Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED9A592DF
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 12:39:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trbTK-0001Fx-NG; Mon, 10 Mar 2025 07:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.chichkov@yadro.com>)
 id 1trbT6-0001Ex-4S
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:38:52 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.chichkov@yadro.com>)
 id 1trbSz-0004xu-Dl
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:38:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 5FC62E000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1741606716; bh=zygtVR89aj1WvkgCgaFfSujeOcDwG+D/ur8mD5S0nU8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=kyw8prmPe641nkGzz7+dRf13QBN9Ya6kyxLiiGRZaT/bmIfGCP775+2TgQy9yZlIi
 UogTnw1KGv3nqPwIB+OSNmX+xYVncgdpF9YtLq5choNp3GCve4OdmYJDPkMe7UFJYO
 +547HSyBXWnMRgqiEf8ClqjdsxFh9RTGZoMsqt5QW/zc9wqLFKyblfRRshJAdF5wWr
 s1Lfynm7bykQo+tZQwpqNJymoCz33lzmFwWmbiKjuauwt5TWaHAjHLEwXoDBJjm+Re
 Ea+hfG4eov7/3Y0d0qBHzSd5+ACSe9nYLwn47eGd371DtMTujU1tVYS4vioGZ6Xgm8
 7ydMRrdv2BSBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1741606716; bh=zygtVR89aj1WvkgCgaFfSujeOcDwG+D/ur8mD5S0nU8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=JWPK3k3AwoU1uHuVqIug2AkAuLLGe3Rz6LkRFcChM+gWNmxbIlxZ8C1DyOyf3aPSF
 OTN5ZhVzASOTUdOJyzFfKp3v2bm7vzOYs4CTY1fVRAumrjD2Lr/PycTF2822xGcsLS
 j2E1SI1W142BFNZ9SCmT0/AEi4I42jwZEHYVfsuk9fSVxe4lAlX6ZMi9Nv+rOhPb1x
 cvPK7qPH1z55ZjgmlfYW3TDN7ZmghDtvr+9iJLLFXPDRZKNZoc43ZFV0BIWA2Gw9sa
 QkLhtKVVOjUxnfpYmKGWTa9GF8yTyOBNBer+zkeUXVzHAnm7mf17gK9dX++Y5G2Eu8
 Tp2SnbBHA/ivQ==
From: Ilya Chichkov <i.chichkov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <nikita.shubin@maquefel.me>, Ilya Chichkov
 <i.chichkov@yadro.com>
Subject: [PATCH v2] hw/rtc: Add RTC PCF8563 module
Date: Mon, 10 Mar 2025 14:36:34 +0300
Message-ID: <20250310113635.349822-1-i.chichkov@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: pass client-ip=89.207.88.253; envelope-from=i.chichkov@yadro.com;
 helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add PCF8563 a real-time clock with calendar and I2C interface.
This commit adds support for interfacing with it and implements
functionality of setting timer, alarm, reading and writing time.

Signed-off-by: Ilya Chichkov <i.chichkov@yadro.com>
---
v1->v2
Phil:
- Add hot reset
- Fix trace message
- Add testing coverage with qtest

Bernhard:
- Move datasheet link to source code top comment section
- Fix typos
- Update licence identifier to SPDX
- Remove unused import libraries
- Change OBJECT_CHECK to OBJECT_DECLARE_SIMPLE_TYPE
- Remove outdated comment
- Rename i2c to parent_obj
- Moved get_time inside capture_time function that is
  called only when I2C request starts
- Add fields inside VMStateDescription
- Removed pcf8563_realize
- Change type_init to DEFINE_TYPES
---
 hw/rtc/Kconfig       |   5 +
 hw/rtc/meson.build   |   1 +
 hw/rtc/pcf8563_rtc.c | 740 +++++++++++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events  |  12 +
 4 files changed, 758 insertions(+)
 create mode 100644 hw/rtc/pcf8563_rtc.c

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index b90c2e510a..4e7a1f75ef 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -27,5 +27,10 @@ config GOLDFISH_RTC
 config LS7A_RTC
     bool
 
+config PCF8563_RTC
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
+
 config STM32_RTC
     bool
\ No newline at end of file
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index b6bb7436c7..6180ffc6d9 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -13,4 +13,5 @@ system_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_true: files('goldfish_rtc.c'))
 system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
+system_ss.add(when: 'CONFIG_PCF8563_RTC', if_true: files('pcf8563_rtc.c'))
 system_ss.add(when: 'CONFIG_STM32_RTC', if_true: files('stm32-rtc.c'))
diff --git a/hw/rtc/pcf8563_rtc.c b/hw/rtc/pcf8563_rtc.c
new file mode 100644
index 0000000000..195b697598
--- /dev/null
+++ b/hw/rtc/pcf8563_rtc.c
@@ -0,0 +1,740 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Real-time clock/calendar PCF8563 with I2C interface.
+ *
+ * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCF8563.pdf
+ *
+ * Author (c) 2024 Ilya Chichkov <i.chichkov@yadro.com>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/registerfields.h"
+#include "hw/irq.h"
+#include "qemu/bitops.h"
+#include "hw/qdev-properties.h"
+#include "qemu/timer.h"
+#include "hw/i2c/i2c.h"
+#include "qemu/bcd.h"
+#include "qom/object.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/rtc.h"
+#include "migration/vmstate.h"
+#include "qapi/visitor.h"
+
+#include "trace.h"
+
+#define TYPE_PCF8563 "pcf8563"
+OBJECT_DECLARE_SIMPLE_TYPE(Pcf8563State, PCF8563)
+
+#define  PCF8563_CS1            0x00
+#define  PCF8563_CS2            0x01
+#define  PCF8563_VLS            0x02
+#define  PCF8563_MINUTES        0x03
+#define  PCF8563_HOURS          0x04
+#define  PCF8563_DAYS           0x05
+#define  PCF8563_WEEKDAYS       0x06
+#define  PCF8563_CENTURY_MONTHS 0x07
+#define  PCF8563_YEARS          0x08
+#define  PCF8563_MINUTE_A       0x09
+#define  PCF8563_HOUR_A         0x0A
+#define  PCF8563_DAY_A          0x0B
+#define  PCF8563_WEEKDAY_A      0x0C
+#define  PCF8563_CLKOUT_CTL     0x0D
+#define  PCF8563_TIMER_CTL      0x0E
+#define  PCF8563_TIMER          0x0F
+
+#define MINUTES_IN_HOUR 60
+#define HOURS_IN_DAY 24
+#define DAYS_IN_MONTH 31
+#define DAYS_IN_WEEK 7
+
+REG8(PCF8563_CS1, 0x00)
+    FIELD(PCF8563_CS1, RSVD0,  0,  3)
+    FIELD(PCF8563_CS1, TESTC,  3,  1)
+    FIELD(PCF8563_CS1, RSVD1,  4,  1)
+    FIELD(PCF8563_CS1, STOP,   5,  1)
+    FIELD(PCF8563_CS1, RSVD2,  6,  1)
+    FIELD(PCF8563_CS1, TEST1,  7,  1)
+
+REG8(PCF8563_CS2, 0x01)
+    FIELD(PCF8563_CS2, TIE,   0,  1)
+    FIELD(PCF8563_CS2, AIE,   1,  1)
+    FIELD(PCF8563_CS2, TF,    2,  1)
+    FIELD(PCF8563_CS2, AF,    3,  1)
+    FIELD(PCF8563_CS2, TI_TP, 4,  1)
+    FIELD(PCF8563_CS2, RSVD,  5,  3)
+
+REG8(PCF8563_VLS, 0x02)
+    FIELD(PCF8563_VLS, SECONDS,  0,  7)
+    FIELD(PCF8563_VLS, VL,       7,  1)
+
+REG8(PCF8563_MINUTES, 0x03)
+    FIELD(PCF8563_MINUTES, MINUTES, 0,  7)
+    FIELD(PCF8563_MINUTES, RSVD,    7,  1)
+
+REG8(PCF8563_HOURS, 0x04)
+    FIELD(PCF8563_HOURS, HOURS, 0,  6)
+    FIELD(PCF8563_HOURS, RSVD,  6,  2)
+
+REG8(PCF8563_DAYS, 0x05)
+    FIELD(PCF8563_DAYS, DAYS, 0,  6)
+    FIELD(PCF8563_DAYS, RSVD, 6,  2)
+
+REG8(PCF8563_WEEKDAYS, 0x06)
+    FIELD(PCF8563_WEEKDAYS, WEEKDAYS, 0,  3)
+    FIELD(PCF8563_WEEKDAYS, RSVD,     3,  5)
+
+REG8(PCF8563_CENTURY_MONTHS, 0x07)
+    FIELD(PCF8563_CENTURY_MONTHS, MONTHS,  0,  5)
+    FIELD(PCF8563_CENTURY_MONTHS, RSVD,    5,  2)
+    FIELD(PCF8563_CENTURY_MONTHS, CENTURY, 7,  1)
+
+REG8(PCF8563_YEARS, 0x08)
+    FIELD(PCF8563_YEARS, YEARS, 0,  8)
+
+REG8(PCF8563_MINUTE_A, 0x09)
+    FIELD(PCF8563_MINUTE_A, MINUTE_A, 0,  7)
+    FIELD(PCF8563_MINUTE_A, AE_M,     7,  1)
+
+REG8(PCF8563_HOUR_A, 0x0A)
+    FIELD(PCF8563_HOUR_A, HOUR_A, 0,  7)
+    FIELD(PCF8563_HOUR_A, AE_H,   7,  1)
+
+REG8(PCF8563_DAY_A, 0x0B)
+    FIELD(PCF8563_DAY_A, DAY_A,  0,  7)
+    FIELD(PCF8563_DAY_A, AE_D,   7,  1)
+
+REG8(PCF8563_WEEKDAY_A, 0x0C)
+    FIELD(PCF8563_WEEKDAY_A, WEEKDAY_A, 0,  3)
+    FIELD(PCF8563_WEEKDAY_A, RSVD,      3,  4)
+    FIELD(PCF8563_WEEKDAY_A, AE_W,      7,  1)
+
+REG8(PCF8563_CLKOUT_CTL, 0x0D)
+    FIELD(PCF8563_CLKOUT_CTL, FD,   0,  2)
+    FIELD(PCF8563_CLKOUT_CTL, RSVD, 2,  5)
+    FIELD(PCF8563_CLKOUT_CTL, FE,   7,  1)
+
+REG8(PCF8563_TIMER_CTL, 0x0E)
+    FIELD(PCF8563_TIMER_CTL, TD,   0,  2)
+    FIELD(PCF8563_TIMER_CTL, RSVD, 2,  5)
+    FIELD(PCF8563_TIMER_CTL, TE,   7,  1)
+
+REG8(PCF8563_TIMER, 0x0F)
+    FIELD(PCF8563_TIMER, TIMER, 0,  8)
+
+typedef struct Pcf8563State {
+    I2CSlave parent_obj;
+
+    struct tm current_time;
+    qemu_irq irq;
+
+    uint8_t read_index;
+    uint8_t write_index;
+    uint8_t reg_addr;
+
+    /* Control and status */
+    uint8_t cs1;
+    uint8_t cs2;
+    /* Counters */
+    uint8_t vls;
+    uint8_t minutes;
+    uint8_t hours;
+    uint8_t days;
+    uint8_t weekdays;
+    uint8_t centure_months;
+    uint8_t years;
+    /* Alarm registers */
+    uint8_t minute_a;
+    uint8_t hour_a;
+    uint8_t day_a;
+    uint8_t weekday_a;
+    /* Timer control */
+    uint8_t clkout_ctl;
+    uint8_t timer_ctl;
+    uint8_t timer_cnt;
+
+    QEMUTimer *alarm_timer;
+    struct tm tm_alarm;
+    bool alarm_irq;
+    QEMUTimer *timer;
+    time_t time_offset;
+    time_t stop_time;
+    QEMUTimer *irq_gen_timer;
+} Pcf8563State;
+
+static uint16_t get_src_freq(Pcf8563State *s, bool *multiply)
+{
+    *multiply = false;
+    /* Select source clock frequency (Hz) */
+    switch (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD)) {
+    case 0:
+        return 4096;
+    case 1:
+        return 64;
+    case 2:
+        return 1;
+    case 3:
+        *multiply = true;
+        return 60;
+    default:
+        return 0;
+    }
+}
+
+static uint16_t get_irq_pulse_freq(Pcf8563State *s)
+{
+    if (s->timer_cnt > 1) {
+        switch (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD)) {
+        case 0:
+            return 8192;
+        case 1:
+            return 128;
+        case 2:
+        case 3:
+            return 64;
+        default:
+            return 0;
+        }
+    } else {
+        if (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD) == 0) {
+            return 4096;
+        }
+        return 64;
+    }
+
+}
+
+static void timer_irq(Pcf8563State *s)
+{
+    if (!FIELD_EX8(s->cs2, PCF8563_CS2, TIE)) {
+        return;
+    }
+
+    if (FIELD_EX8(s->cs2, PCF8563_CS2, TI_TP)) {
+        qemu_irq_pulse(s->irq);
+
+        /* Start IRQ pulse generator */
+        uint64_t delay = s->timer_cnt *
+                        NANOSECONDS_PER_SECOND *
+                        get_irq_pulse_freq(s);
+        timer_mod(s->irq_gen_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay);
+    } else {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void alarm_irq(Pcf8563State *s)
+{
+    if (FIELD_EX8(s->cs2, PCF8563_CS2, AIE)) {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void set_alarm(Pcf8563State *s)
+{
+    uint64_t diff_sec = 0;
+    uint64_t diff_min = 0;
+    uint64_t diff_hour = 0;
+    uint64_t diff_day = 0;
+    uint64_t diff_wday = 0;
+    uint64_t delay = 0;
+    uint64_t now_cl = 0;
+    struct tm now;
+
+    bool is_min_en = !FIELD_EX8(s->minute_a, PCF8563_MINUTE_A, AE_M);
+    bool is_hour_en = !FIELD_EX8(s->hour_a, PCF8563_HOUR_A, AE_H);
+    bool is_day_en = !FIELD_EX8(s->day_a, PCF8563_DAY_A, AE_D);
+    bool is_wday_en = !FIELD_EX8(s->weekday_a, PCF8563_WEEKDAY_A, AE_W);
+    if (!is_day_en && !is_wday_en && !is_hour_en && !is_min_en) {
+        if (s->alarm_timer) {
+            timer_del(s->alarm_timer);
+        }
+        return;
+    }
+
+    qemu_get_timedate(&now, s->time_offset);
+
+    if (is_min_en) {
+        if (s->tm_alarm.tm_min > s->current_time.tm_min) {
+            diff_min = s->tm_alarm.tm_min - s->current_time.tm_min;
+        } else {
+            diff_min = (MINUTES_IN_HOUR -
+                        s->current_time.tm_min + s->tm_alarm.tm_min);
+        }
+    }
+
+    if (is_hour_en) {
+        if (s->tm_alarm.tm_hour > s->current_time.tm_hour) {
+            diff_hour = s->tm_alarm.tm_hour - s->current_time.tm_hour;
+        } else {
+            diff_hour = (HOURS_IN_DAY -
+                         s->current_time.tm_hour + s->tm_alarm.tm_hour);
+        }
+    }
+
+    if (is_day_en) {
+        if (s->tm_alarm.tm_mday > s->current_time.tm_mday) {
+            diff_day = s->tm_alarm.tm_mday - s->current_time.tm_mday;
+        } else {
+            diff_day = (DAYS_IN_MONTH -
+                        s->current_time.tm_mday + s->tm_alarm.tm_mday);
+        }
+    }
+
+    if (is_wday_en) {
+        if (s->tm_alarm.tm_wday > s->current_time.tm_wday) {
+            diff_wday = s->tm_alarm.tm_wday - s->current_time.tm_wday;
+        } else {
+            diff_wday = (DAYS_IN_WEEK -
+                         s->current_time.tm_wday + s->tm_alarm.tm_wday);
+        }
+    }
+
+    diff_sec = (diff_min * 60) +
+               (diff_hour * 60 * 60) +
+               (diff_day * 24 * 60 * 60) +
+               (diff_wday * 24 * 60 * 60);
+    now_cl = muldiv64(qemu_clock_get_ns(rtc_clock), 1, NANOSECONDS_PER_SECOND);
+    delay = muldiv64((now_cl + diff_sec), NANOSECONDS_PER_SECOND, 1);
+
+    if (s->alarm_timer) {
+        timer_del(s->alarm_timer);
+    }
+    timer_mod(s->alarm_timer, delay);
+}
+
+static void pcf8563_update_irq(Pcf8563State *s)
+{
+    if (FIELD_EX8(s->cs2, PCF8563_CS2, TF)) {
+        timer_irq(s);
+    }
+
+    if (FIELD_EX8(s->cs2, PCF8563_CS2, AF)) {
+        alarm_irq(s);
+    }
+}
+
+static void alarm_timer_cb(void *opaque)
+{
+    Pcf8563State *s = PCF8563(opaque);
+
+    set_alarm(s);
+    s->cs2 = FIELD_DP8(s->cs2, PCF8563_CS2, AF, 1);
+    pcf8563_update_irq(s);
+}
+
+static void timer_cb(void *opaque)
+{
+    Pcf8563State *s = PCF8563(opaque);
+
+    s->timer_cnt = 0;
+    s->cs2 = FIELD_DP8(s->cs2, PCF8563_CS2, TF, 1);
+    pcf8563_update_irq(s);
+}
+
+static void irq_gen_timer_cb(void *opaque)
+{
+    Pcf8563State *s = PCF8563(opaque);
+
+    pcf8563_update_irq(s);
+}
+
+static inline void capture_time(Pcf8563State *s)
+{
+    qemu_get_timedate(&s->current_time, s->time_offset);
+    trace_pcf8563_rtc_capture_time();
+}
+
+static void set_time(Pcf8563State *s, struct tm *tm)
+{
+    s->time_offset = qemu_timedate_diff(tm);
+    set_alarm(s);
+    trace_pcf8563_rtc_set_time();
+}
+
+static void pcf8563_reset(I2CSlave *i2c)
+{
+    Pcf8563State *s = PCF8563(i2c);
+
+    s->read_index = 0;
+    s->write_index = 0;
+    s->reg_addr = 0;
+
+    s->cs1 = 0x8;
+    s->cs2 = 0x0;
+    s->vls = 0x80;
+    s->minutes = 0x0;
+    s->hours = 0x0;
+    s->days = 0x0;
+    s->weekdays = 0x0;
+    s->centure_months = 0x0;
+    s->years = 0x0;
+    s->minute_a = 0x80;
+    s->hour_a = 0x80;
+    s->day_a = 0x80;
+    s->weekday_a = 0x80;
+    s->clkout_ctl = 0x80;
+    s->timer_ctl = 0x3;
+    s->timer_cnt = 0x0;
+
+    s->stop_time = 0;
+    s->reg_addr = 0;
+
+    s->alarm_irq = false;
+    s->time_offset = 0;
+
+    qemu_irq_lower(s->irq);
+    qemu_get_timedate(&s->tm_alarm, 0);
+
+    timer_del(s->alarm_timer);
+    timer_del(s->timer);
+}
+
+static void pcf8563_read(Pcf8563State *s, uint8_t *result)
+{
+    struct tm *tm = &s->current_time;
+
+    bool multiply = false;
+    uint16_t src_freq = get_src_freq(s, &multiply);
+
+    switch (s->reg_addr) {
+    case PCF8563_CS1:
+        *result = s->cs1;
+        break;
+    case PCF8563_CS2:
+        *result = s->cs2;
+        break;
+    case PCF8563_VLS:
+        *result = (s->vls & 0x80) | to_bcd(tm->tm_sec);
+        break;
+    case PCF8563_MINUTES:
+        *result = to_bcd(tm->tm_min);
+        break;
+    case PCF8563_HOURS:
+        *result = to_bcd(tm->tm_hour);
+        break;
+    case PCF8563_DAYS:
+        *result = to_bcd(tm->tm_mday);
+        break;
+    case PCF8563_WEEKDAYS:
+        *result = to_bcd(tm->tm_wday);
+        break;
+    case PCF8563_CENTURY_MONTHS:
+        *result = to_bcd(tm->tm_mon + 1);
+        break;
+    case PCF8563_YEARS:
+        *result = to_bcd((tm->tm_year + 1900) % 100);
+        break;
+    case PCF8563_MINUTE_A:
+        *result = s->minute_a;
+        break;
+    case PCF8563_HOUR_A:
+        *result = s->hour_a;
+        break;
+    case PCF8563_DAY_A:
+        *result = s->day_a;
+        break;
+    case PCF8563_WEEKDAY_A:
+        *result = s->weekday_a;
+        break;
+    case PCF8563_CLKOUT_CTL:
+        *result = s->clkout_ctl;
+        break;
+    case PCF8563_TIMER_CTL:
+        *result = s->timer_ctl;
+        break;
+    case PCF8563_TIMER:
+        if (timer_pending(s->timer)) {
+            uint64_t expire_time_s = muldiv64(timer_expire_time_ns(s->timer),
+                                              1,
+                                              NANOSECONDS_PER_SECOND);
+            if (multiply) {
+                s->timer_cnt = muldiv64(expire_time_s, 1, src_freq);
+            } else {
+                s->timer_cnt = muldiv64(expire_time_s, src_freq, 1);
+            }
+        }
+        *result = s->timer_cnt;
+        break;
+    }
+}
+
+static void pcf8563_write(Pcf8563State *s, uint8_t val)
+{
+    struct tm *tm = &s->current_time;
+    int tmp;
+
+    switch (s->reg_addr) {
+    case PCF8563_CS1:
+        s->cs1 = val & 0xa8;
+        break;
+    case PCF8563_CS2:
+        s->cs2 = val & 0x1f;
+        break;
+    case PCF8563_VLS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_VLS, SECONDS));
+        if (tmp >= 0 && tmp <= 59) {
+            tm->tm_sec = tmp;
+            set_time(s, tm);
+        }
+
+        bool vl = FIELD_EX8(val, PCF8563_VLS, VL);
+
+        if (vl ^ (s->vls & 0x80)) {
+            if (vl) {
+                /* Clock integrity is not guaranteed */
+                s->stop_time = time(NULL);
+            } else if (s->stop_time != 0) {
+                s->time_offset += s->stop_time - time(NULL);
+                s->stop_time = 0;
+            }
+        }
+
+        s->vls = vl << 8;
+        break;
+    case PCF8563_MINUTES:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_MINUTES, MINUTES));
+        if (tmp >= 0 && tmp <= 59) {
+            s->minutes = val;
+            tm->tm_min = tmp;
+            set_time(s, tm);
+        }
+        break;
+    case PCF8563_HOURS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_HOURS, HOURS));
+        if (tmp >= 0 && tmp <= 23) {
+            s->hours = val;
+            tm->tm_hour = tmp;
+            set_time(s, tm);
+        }
+        break;
+    case PCF8563_DAYS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_DAYS, DAYS));
+        if (tmp >= 1 && tmp <= 31) {
+            s->days = val;
+            tm->tm_mday = tmp;
+            set_time(s, tm);
+        }
+        break;
+    case PCF8563_WEEKDAYS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_WEEKDAYS, WEEKDAYS));
+        if (tmp >= 0 && tmp <= 6) {
+            s->weekdays = val;
+            tm->tm_wday = tmp;
+            set_time(s, tm);
+        }
+        break;
+    case PCF8563_CENTURY_MONTHS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_CENTURY_MONTHS, MONTHS));
+        if (tmp >= 0 && tmp <= 12) {
+            s->centure_months = val;
+            tm->tm_mon = tmp;
+            set_time(s, tm);
+        }
+        break;
+    case PCF8563_YEARS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_YEARS, YEARS));
+        if (tmp >= 0 && tmp <= 99) {
+            s->years = val;
+            tm->tm_year = tmp + 100;
+            set_time(s, tm);
+        }
+        break;
+    case PCF8563_MINUTE_A:
+        s->minute_a = val;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_MINUTE_A, MINUTE_A));
+        if (tmp >= 0 && tmp <= 59) {
+            s->tm_alarm.tm_min = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_HOUR_A:
+        s->hour_a = val & 0xbf;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_HOUR_A, HOUR_A));
+        if (tmp >= 0 && tmp <= 23) {
+            s->tm_alarm.tm_hour = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_DAY_A:
+        s->day_a = val & 0xbf;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_DAY_A, DAY_A));
+        if (tmp >= 1 && tmp <= 31) {
+            s->tm_alarm.tm_mday = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_WEEKDAY_A:
+        s->weekday_a = val & 0x87;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_WEEKDAY_A, WEEKDAY_A));
+        if (tmp >= 0 && tmp <= 6) {
+            s->tm_alarm.tm_wday = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_CLKOUT_CTL:
+        s->clkout_ctl = val & 0x83;
+        break;
+    case PCF8563_TIMER_CTL:
+        s->timer_ctl = val & 0x83;
+
+        if (!FIELD_EX32(s->timer_ctl, PCF8563_TIMER_CTL, TE)) {
+            if (timer_pending(s->timer)) {
+                timer_del(s->timer);
+            }
+        }
+        break;
+    case PCF8563_TIMER:
+        s->timer_cnt = val;
+        if (FIELD_EX32(s->timer_ctl, PCF8563_TIMER_CTL, TE)) {
+            bool multiply = false;
+            uint16_t src_freq = get_src_freq(s, &multiply);
+            uint64_t delay = 0;
+
+            /* Calculate timer's delay in ns based on value and set it up */
+            if (multiply) {
+                delay = val * NANOSECONDS_PER_SECOND * src_freq;
+            } else {
+                delay = val * NANOSECONDS_PER_SECOND / src_freq;
+            }
+            timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay);
+        }
+        break;
+    }
+}
+
+static uint8_t pcf8563_rx(I2CSlave *i2c)
+{
+    Pcf8563State *s = PCF8563(i2c);
+    uint8_t result = 0xff;
+
+    pcf8563_read(s, &result);
+    /* Auto-increment register address */
+    s->reg_addr++;
+
+    trace_pcf8563_rtc_read(s->read_index, result);
+    return result;
+}
+
+static int pcf8563_tx(I2CSlave *i2c, uint8_t data)
+{
+    Pcf8563State *s = PCF8563(i2c);
+
+    if (s->write_index == 0) {
+        /* Receive register address */
+        s->reg_addr = data;
+        s->write_index++;
+        trace_pcf8563_rtc_write_addr(data);
+    } else {
+        /* Receive data to write */
+        pcf8563_write(s, data);
+        s->write_index++;
+        s->reg_addr++;
+        trace_pcf8563_rtc_write_data(data);
+    }
+    return 0;
+}
+
+static int pcf8563_event(I2CSlave *i2c, enum i2c_event event)
+{
+    trace_pcf8563_rtc_event(event);
+    Pcf8563State *s = PCF8563(i2c);
+
+    switch (event) {
+    case I2C_START_RECV:
+        capture_time(s);
+        break;
+    case I2C_FINISH:
+        s->read_index = 0;
+        s->write_index = 0;
+    default:
+        break;
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_pcf8563 = {
+    .name = "PCF8563",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(parent_obj, Pcf8563State),
+        VMSTATE_UINT8(read_index, Pcf8563State),
+        VMSTATE_UINT8(write_index, Pcf8563State),
+        VMSTATE_UINT8(reg_addr, Pcf8563State),
+        VMSTATE_UINT8(cs1, Pcf8563State),
+        VMSTATE_UINT8(cs2, Pcf8563State),
+        VMSTATE_UINT8(vls, Pcf8563State),
+        VMSTATE_UINT8(minutes, Pcf8563State),
+        VMSTATE_UINT8(hours, Pcf8563State),
+        VMSTATE_UINT8(days, Pcf8563State),
+        VMSTATE_UINT8(weekdays, Pcf8563State),
+        VMSTATE_UINT8(centure_months, Pcf8563State),
+        VMSTATE_UINT8(years, Pcf8563State),
+        VMSTATE_UINT8(minute_a, Pcf8563State),
+        VMSTATE_UINT8(hour_a, Pcf8563State),
+        VMSTATE_UINT8(day_a, Pcf8563State),
+        VMSTATE_UINT8(weekday_a, Pcf8563State),
+        VMSTATE_UINT8(clkout_ctl, Pcf8563State),
+        VMSTATE_UINT8(timer_ctl, Pcf8563State),
+        VMSTATE_UINT8(timer_cnt, Pcf8563State),
+        VMSTATE_TIMER_PTR(timer, Pcf8563State),
+        VMSTATE_TIMER_PTR(irq_gen_timer, Pcf8563State),
+        VMSTATE_TIMER_PTR(alarm_timer, Pcf8563State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pcf8563_init(Object *obj)
+{
+    I2CSlave *i2c = I2C_SLAVE(obj);
+    Pcf8563State *s = PCF8563(obj);
+
+    s->alarm_timer = timer_new_ns(rtc_clock, &alarm_timer_cb, s);
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &timer_cb, s);
+    s->irq_gen_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &irq_gen_timer_cb, s);
+
+    qdev_init_gpio_out(DEVICE(s), &s->irq, 1);
+
+    pcf8563_reset(i2c);
+
+    trace_pcf8563_rtc_init();
+
+    s->reg_addr = 0x09;
+    pcf8563_write(s, 0x81);
+    set_alarm(s);
+}
+
+static void pcf8563_reset_hold(Object *obj, ResetType type)
+{
+    I2CSlave *i2c = I2C_SLAVE(obj);
+    pcf8563_reset(i2c);
+}
+
+static void pcf8563_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    k->event = pcf8563_event;
+    k->recv = pcf8563_rx;
+    k->send = pcf8563_tx;
+    dc->vmsd = &vmstate_pcf8563;
+    rc->phases.hold = pcf8563_reset_hold;
+}
+
+static const TypeInfo pcf8563_register_types[] = {
+    {
+        .name          = TYPE_PCF8563,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(Pcf8563State),
+        .instance_init = pcf8563_init,
+        .class_init    = pcf8563_class_init,
+    },
+};
+
+DEFINE_TYPES(pcf8563_register_types)
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 743ff775d4..17c524d61d 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -43,3 +43,15 @@ stm32_rtc_arm_ointr(uint64_t tocks, uint64_t nsecs) "overflow interrupt in %" PR
 stm32_rtc_arm_aintr(uint64_t tocks, uint64_t nsecs) "alarm interrupt in %" PRIu64 " ticks, %" PRIu64" nsecs"
 stm32_rtc_read(uint64_t addr, uint64_t value, uint32_t size) "addr 0x%02" PRIx64 " value 0x%08" PRIx64" size %u"
 stm32_rtc_write(uint64_t addr, uint64_t value, uint32_t size) "addr 0x%02" PRIx64 " value 0x%08" PRIx64" size %u"
+
+# pcf8563_rtc.c
+pcf8563_rtc_write_data(uint8_t data) "data: 0x%x"
+pcf8563_rtc_write_addr(uint8_t addr) "register address: 0x%x"
+pcf8563_rtc_read(uint8_t addr, uint8_t data) "addr: 0x%x, data: 0x%x"
+pcf8563_rtc_event(uint8_t event) "Event: 0x%x"
+pcf8563_rtc_init(void)
+pcf8563_rtc_reset(void)
+pcf8563_rtc_set_time(void)
+pcf8563_rtc_get_time(void)
+pcf8563_rtc_set_alarm(void)
+pcf8563_rtc_capture_time(void)
-- 
2.34.1


