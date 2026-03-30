package com.grownited.controller;

import com.grownited.entity.TaskEntity;
import com.grownited.repository.TaskRepository;
import com.grownited.repository.ModuleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/projects/{projectId}/modules/{moduleId}/tasks")
public class TaskController {

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private ModuleRepository moduleRepository; // optional, if you need to validate module exists

    // List all tasks for a specific module
    @GetMapping
    public String listTasks(@PathVariable Integer projectId,
                            @PathVariable Integer moduleId,
                            Model model) {
        List<TaskEntity> tasks = taskRepository.findByModuleId(moduleId);
        model.addAttribute("tasks", tasks);
        model.addAttribute("projectId", projectId);
        model.addAttribute("moduleId", moduleId);
        model.addAttribute("pageTitle", "Tasks for Module #" + moduleId);
        return "admin/task-list";
    }

    // Show form to create a new task
    @GetMapping("/new")
    public String showCreateForm(@PathVariable Integer projectId,
                                 @PathVariable Integer moduleId,
                                 Model model) {
        TaskEntity task = new TaskEntity();
        task.setProjectId(projectId);
        task.setModuleId(moduleId);
        model.addAttribute("task", task);
        model.addAttribute("projectId", projectId);
        model.addAttribute("moduleId", moduleId);
        model.addAttribute("statuses", getTaskStatuses()); // dummy status list
        model.addAttribute("pageTitle", "Add Task");
        return "admin/task-form";
    }

    // Save a new task
    @PostMapping("/save")
    public String save(@PathVariable Integer projectId,
                       @PathVariable Integer moduleId,
                       @ModelAttribute("task") TaskEntity task) {
        if (task.getTotalUtilizedHours() == null) {
            task.setTotalUtilizedHours(0.0);
        }
        task.setProjectId(projectId);
        task.setModuleId(moduleId);
        taskRepository.save(task);
        return "redirect:/admin/projects/" + projectId + "/modules/" + moduleId + "/tasks";
    }

    // Show form to edit an existing task
    @GetMapping("/edit/{taskId}")
    public String showEditForm(@PathVariable Integer projectId,
                               @PathVariable Integer moduleId,
                               @PathVariable Integer taskId,
                               Model model) {
        Optional<TaskEntity> taskOpt = taskRepository.findById(taskId);
        if (taskOpt.isPresent()) {
            model.addAttribute("task", taskOpt.get());
            model.addAttribute("projectId", projectId);
            model.addAttribute("moduleId", moduleId);
            model.addAttribute("statuses", getTaskStatuses());
            model.addAttribute("pageTitle", "Edit Task");
            return "admin/task-form";
        }
        return "redirect:/admin/projects/" + projectId + "/modules/" + moduleId + "/tasks";
    }

    // Update an existing task
    @PostMapping("/update/{taskId}")
    public String update(@PathVariable Integer projectId,
                         @PathVariable Integer moduleId,
                         @PathVariable Integer taskId,
                         @ModelAttribute("task") TaskEntity task) {
        task.setTaskId(taskId);
        task.setProjectId(projectId);
        task.setModuleId(moduleId);
        taskRepository.save(task);
        return "redirect:/admin/projects/" + projectId + "/modules/" + moduleId + "/tasks";
    }

    // View a single task
    @GetMapping("/view/{taskId}")
    public String view(@PathVariable Integer projectId,
                       @PathVariable Integer moduleId,
                       @PathVariable Integer taskId,
                       Model model) {
        Optional<TaskEntity> taskOpt = taskRepository.findById(taskId);
        if (taskOpt.isPresent()) {
            model.addAttribute("task", taskOpt.get());
            model.addAttribute("projectId", projectId);
            model.addAttribute("moduleId", moduleId);
            model.addAttribute("pageTitle", "Task Details");
            return "admin/task-view";
        }
        return "redirect:/admin/projects/" + projectId + "/modules/" + moduleId + "/tasks";
    }

    // Delete a task
    @GetMapping("/delete/{taskId}")
    public String delete(@PathVariable Integer projectId,
                         @PathVariable Integer moduleId,
                         @PathVariable Integer taskId) {
        taskRepository.deleteById(taskId);
        return "redirect:/admin/projects/" + projectId + "/modules/" + moduleId + "/tasks";
    }

    // Helper method for task status dropdown (replace with real service later)
    private List<TaskStatus> getTaskStatuses() {
        return List.of(
                new TaskStatus(1, "Not Started"),
                new TaskStatus(2, "In Progress"),
                new TaskStatus(3, "Completed"),
                new TaskStatus(4, "On Hold")
        );
    }

    // Simple inner class for status
    public static class TaskStatus {
        private Integer id; private String name;
        public TaskStatus(Integer id, String name) { this.id = id; this.name = name; }
        public Integer getId() { return id; }
        public String getName() { return name; }
    }
}