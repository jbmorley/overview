// Copyright (c) 2021-2023 InSeven Limited
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import EventKit

struct Summary<Context, Item>: Identifiable {
    var id = UUID()
    var dateInterval: DateInterval
    var context: Context
    var items: [Item]
}

extension Summary where Item: EKEvent {

    var uniqueItems: [Item] { Array(Set(items)) }

    func duration(calendar: Calendar) -> DateComponents {
        calendar.date(byAdding: uniqueItems.map { $0.duration(calendar: calendar, bounds: dateInterval) },
                      to: dateInterval.start)
    }

}

extension Summary where Context == Array<EKCalendar>, Item == Summary<CalendarItem, EKEvent> {

    func duration(calendar: Calendar) -> DateComponents {
        calendar.date(byAdding: items.map { $0.duration(calendar: calendar) }, to: dateInterval.start)
    }

}