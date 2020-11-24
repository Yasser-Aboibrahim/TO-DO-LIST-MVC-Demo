//
//  TodoListPresenter.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/13/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import UIKit

class TodoListPresenter{
    
    private var userTasksArr = [TaskData]()
    private weak var view: TodoListVC!
    
    init(view: TodoListVC){
        self.view = view
    }
    
     func getUserTasks(){
        view.showLoader()
        
        APIManager.getUserTasksAPIRouter{ (response) in
            switch response{
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                    self.view.showAlert(alertTitle: "Error",message: "Incorrect Email and Password",actionTitle: "Dismiss")
                }else{
                    self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
                    print(error.localizedDescription)
                }
            case .success(let result):
                if let taskArr = result?.data{
                    if taskArr.isEmpty{
                        self.userTasksArr = []
                    }else{
                        self.userTasksArr = taskArr
                    }
                }
                self.view.hideLoader()
                self.view.reloadDataWithoutScroll()
            }
            
        }
    }
    
    func userTasksArrCount() -> Int{
        return userTasksArr.count
    }
    
    func configure(cell: todoCelldelegate, for index: Int){
        let task = userTasksArr[index]
        cell.displayTaskDescription(description: task.description)
    }
    
    func deleteTask(){
        view.showLoader()
            APIManager.deleteTaskAPIRouter{ (response) in
                switch response{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let result):
                    print("The task is deleted ")
                    print(result)
                }
                DispatchQueue.main.async {
                    self.getUserTasks()
                    self.view.reloadDataWithoutScroll()
                }
                self.view.hideLoader()
            }
    }
    
    func getTaskId(index: Int){
        let task = userTasksArr[index]
        UserDefaultsManager.shared().taskId = task.id
    }
    
    func addTask(task: String){
                self.view.showLoader()
                APIManager.addTaskAPIRouter(description: task){ (response) in
                    switch response{
                    case .failure(let error):
                        self.view.showAlert(alertTitle: "Error",message: "\(error.localizedDescription)",actionTitle: "Dismiss")
                    case .success(let result):
                        print(result)
                        self.getUserTasks()
                    }
                    DispatchQueue.main.async {
                        self.view.reloadDataWithoutScroll()
                    }
                    self.view.hideLoader()
                }
    }
    
}
