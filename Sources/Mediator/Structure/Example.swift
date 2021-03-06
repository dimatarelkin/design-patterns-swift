//
//  MediatorStructure.swift
//  MediatorStructure
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

/// EN: Mediator Design Pattern
///
/// Intent: Define an object that encapsulates how a set of objects interact.
/// Mediator promotes loose coupling by keeping objects from referring to each
/// other explicitly, and it lets you vary their interaction independently.
///
/// RU: Паттерн Посредник
///
/// Назначение: Определяет объект, который инкапсулирует взаимодействие набора
/// объектов. Посредник способствует слабой связанности, удерживая объекты от
/// обращения друг к другу напрямую, и это позволяет вам менять их взаимодействие
/// независимо.

import XCTest

class MediatorStructure: XCTestCase {

    func test() {

        let component1 = Component1()
        let component2 = Component2()

        let mediator = ConcreteMediator(component1, component2)
        print("Client triggers operation A.")
        component1.doA()

        print("\nClient triggers operation D.")
        component2.doD()

        print(mediator)
    }
}

protocol Mediator: AnyObject {

    func notify(sender: BaseComponent, event: String)
}

class ConcreteMediator: Mediator {

    /// EN: Concrete Mediators implement cooperative behavior by coordinating several
    /// components.
    ///
    /// RU: Конкретные Посредники реализуют совместное поведение, координируя
    /// отдельные компоненты.

    private var component1: Component1
    private var component2: Component2

    init(_ component1: Component1, _ component2: Component2) {
        self.component1 = component1
        self.component2 = component2

        component1.update(mediator: self)
        component2.update(mediator: self)
    }

    func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            print("Mediator reacts on A and triggers following operations:")
            self.component2.doC()
        }
        else if (event == "D") {
            print("Mediator reacts on D and triggers following operations:")
            self.component1.doB()
            self.component2.doC()
        }
    }
}

/// EN: The Base Component provides the basic functionality of storing a
/// mediator's instance inside component objects.
///
/// RU: Базовый Компонент обеспечивает базовую функциональность хранения
/// экземпляра посредника внутри объектов компонентов.

class BaseComponent {

    fileprivate weak var mediator: Mediator?

    init(mediator: Mediator? = nil) {
        self.mediator = mediator
    }

    func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

/// EN: Concrete Components implement various functionality. They don't depend on
/// other components. They also don't depend on any concrete mediator classes.
///
/// RU: Конкретные Компоненты реализуют различную функциональность. Они не
/// зависят от других компонентов. Они также не зависят от каких-либо конкретных
/// классов посредников.

class Component1: BaseComponent {

    func doA() {
        print("Component 1 does A.")
        mediator?.notify(sender: self, event: "A")
    }

    func doB() {
        print("Component 1 does B.\n")
        mediator?.notify(sender: self, event: "B")
    }
}

class Component2: BaseComponent {

    func doC() {
        print("Component 2 does C.")
        mediator?.notify(sender: self, event: "C")
    }

    func doD() {
        print("Component 2 does D.")
        mediator?.notify(sender: self, event: "D")
    }
}
