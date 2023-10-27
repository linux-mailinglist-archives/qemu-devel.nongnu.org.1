Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C97DA17E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 21:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwSuk-00073r-N4; Fri, 27 Oct 2023 15:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbryndza.oss@icloud.com>)
 id 1qwSe8-00040X-02
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 15:37:28 -0400
Received: from mr85p00im-zteg06022001.me.com ([17.58.23.193])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbryndza.oss@icloud.com>)
 id 1qwSe4-0005zh-6P
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 15:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1698435440;
 bh=ifqO7vO/ZlsuowPu+tyD9J5BwoJh50TCAeQWb+9gblg=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
 b=C6SfMcQ4bEMo0dRs0wVjJY9b4VPH1o1JbHMTiJDpqwwQ+I9sNvsabrQbYAFuxAmzX
 Gmoi2B/d1VaxsUhRtACYBLhr3rCYdM3TUd4kKK+7VZdFY+0cHDVtEdMY3RpLzcQwKd
 IoQK31i2GH4nfalN49t1VhonFoVQ2ihmlVnUkUSXEk3Rci4waa2FEVLy/2Jh/JXJVU
 bkuOryuvHLhdqbd1pW0lHznW6Fk2DRBceR2OzYRwnWahJQBSCXW1xEy2wfJvAxlIul
 QCXCUrD5BubblalfsWn1qZB0/f8PWREgK1psLleFE+dXtukNyT5QzS5pd3IOzAb+tn
 PTdavbh/1OPrQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id E5254800304;
 Fri, 27 Oct 2023 19:37:18 +0000 (UTC)
From: Lucjan Bryndza <lbryndza.oss@icloud.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_ACB8861C-70D3-4830-AE21-06E164E36073"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Patch to fix malfunctioning of T2-T5 timers on the STM32 platform
Message-Id: <04E66FC8-A5DC-469B-B23E-8FF9E4757915@icloud.com>
Date: Fri, 27 Oct 2023 21:37:05 +0200
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Proofpoint-ORIG-GUID: 3KaCVgihfZtqbIGWu0BzSejxVrmgDe5s
X-Proofpoint-GUID: 3KaCVgihfZtqbIGWu0BzSejxVrmgDe5s
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2310270170
Received-SPF: pass client-ip=17.58.23.193;
 envelope-from=lbryndza.oss@icloud.com; helo=mr85p00im-zteg06022001.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Oct 2023 15:54:37 -0400
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


--Apple-Mail=_ACB8861C-70D3-4830-AE21-06E164E36073
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Current implementation of T2 - T5 times on the STM32 platform does not =
work properly.=20
After configuring the timer-counter circuit to report interrupts every =
10ms, in reality the first interrupt is reported=20
only once after a few seconds, while subsequent interrupts do not come.=20=

The current code also does not properly emulate the operation of even =
the basic functions of the TIME-BASE unit. =20
This patch contains fixes that reimplements the basic functionality
of the time base unit such as up-counting down-counting , and =
alternate-mode up-down counting.=20
The ptimer() API is used to emulate timers.=20
After applying the patch, STM32 timer works correctly in its basic =
functionality.
The ISIX-RTOS test unit was used to test the patch.
Links and instructions can be found below:

=
https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_basic_prim=
itives.cpp
=
https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_test_qemu.m=
d


qemu-system-arm -M olimex-stm32-h405  -kernel =
build/tests/libisix/isixunittests.binary -nographic
unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty
unittests_entry.cpp:83|Exceptions pretest. OK
51 selected tests
[   RUN    ] 01_base_00 TimeBase timer vs systick
[  1001ms  ] ...
[   RUN    ] 01_base_01 Basic heap allocator
[   1ms    ] ...


Best Regards
Lucjan Bryndza


=46rom 3ccfe70979d1b263d4fa22104ecf42ac5a628554 Mon Sep 17 00:00:00 2001
From: Lucjan Bryndza <lbryndza.oss@icloud.com>
Date: Thu, 26 Oct 2023 22:45:26 +0200
Subject: [PATCH] Fixing the basic functionality of STM32 timers

The current implementation of timers does not work properly
even in the basic functionality. A counter configured to report
an interrupt 10ms every reports the first interrupts after a
few seconds.   Count up and
count down modes are also not properly implemented. This commit fixes =
bugs with interrupt
reporting and implements the basic modes of the counter's
time-base block.

Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
---
 hw/arm/stm32f405_soc.c             |   2 +-
 hw/timer/stm32f2xx_timer.c         | 291 ++++++++++++++++++-----------
 include/hw/timer/stm32f2xx_timer.h |  23 ++-
 3 files changed, 202 insertions(+), 114 deletions(-)

diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index cef23d7ee4..69316181b3 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -183,7 +183,7 @@ static void stm32f405_soc_realize(DeviceState =
*dev_soc, Error **errp)
     /* Timer 2 to 5 */
     for (i =3D 0; i < STM_NUM_TIMERS; i++) {
         dev =3D DEVICE(&(s->timer[i]));
-        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
+       qdev_prop_set_uint64(dev, "clock-frequency", 48000000);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index ba8694dcd3..65f3287125 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -29,11 +29,18 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/typedefs.h"
+#include "qemu/timer.h"
+#include "qemu/main-loop.h"
+#include "sysemu/dma.h"
=20
 #ifndef STM_TIMER_ERR_DEBUG
 #define STM_TIMER_ERR_DEBUG 0
 #endif
=20
+/* PCLK /4 */
+#define CLOCK_FREQUENCY 48000000ULL
+
 #define DB_PRINT_L(lvl, fmt, args...) do { \
     if (STM_TIMER_ERR_DEBUG >=3D lvl) { \
         qemu_log("%s: " fmt, __func__, ## args); \
@@ -42,63 +49,87 @@
=20
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
=20
-static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t =
now);
=20
-static void stm32f2xx_timer_interrupt(void *opaque)
+static uint32_t stm32f2xx_timer_get_count(STM32F2XXTimerState *s)
 {
-    STM32F2XXTimerState *s =3D opaque;
-
-    DB_PRINT("Interrupt\n");
-
-    if (s->tim_dier & TIM_DIER_UIE && s->tim_cr1 & TIM_CR1_CEN) {
-        s->tim_sr |=3D 1;
-        qemu_irq_pulse(s->irq);
-        stm32f2xx_timer_set_alarm(s, s->hit_time);
-    }
-
-    if (s->tim_ccmr1 & (TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &&
-        !(s->tim_ccmr1 & TIM_CCMR1_OC2M0) &&
-        s->tim_ccmr1 & TIM_CCMR1_OC2PE &&
-        s->tim_ccer & TIM_CCER_CC2E) {
-        /* PWM 2 - Mode 1 */
-        DB_PRINT("PWM2 Duty Cycle: %d%%\n",
-                s->tim_ccr2 / (100 * (s->tim_psc + 1)));
+    uint64_t cnt =3D ptimer_get_count(s->timer);
+    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
+        return s->tim_arr - (cnt & 0xffff);
+    } else {
+        return cnt & 0xffff;
     }
 }
=20
-static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, =
int64_t t)
+
+static void stm32f2xx_timer_set_count(STM32F2XXTimerState *s, uint32_t =
cnt)
 {
-    return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + 1);
+    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
+        ptimer_set_count(s->timer, s->tim_arr - (cnt & 0xffff));
+    } else {
+        ptimer_set_count(s->timer, cnt & 0xffff);
+    }
 }
=20
-static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t =
now)
+static void stm32f2xx_timer_update(STM32F2XXTimerState *s)
 {
-    uint64_t ticks;
-    int64_t now_ticks;
+    if (s->tim_cr1 & TIM_CR1_DIR) {
+        s->count_mode =3D TIMER_DOWN_COUNT;
+    } else {
+        s->count_mode =3D TIMER_UP_COUNT;
+    }
=20
-    if (s->tim_arr =3D=3D 0) {
-        return;
+    if (s->tim_cr1 & TIM_CR1_CMS) {
+        s->count_mode =3D TIMER_UP_COUNT;
     }
=20
-    DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
+    if (s->tim_cr1 & TIM_CR1_CEN) {
+        DB_PRINT("Enabling timer\n");
+        ptimer_set_freq(s->timer, s->freq_hz);
+        ptimer_run(s->timer, !(s->tim_cr1 & 0x04));
+    } else {
+        DB_PRINT("Disabling timer\n");
+        ptimer_stop(s->timer);
+    }
+}
=20
-    now_ticks =3D stm32f2xx_ns_to_ticks(s, now);
-    ticks =3D s->tim_arr - (now_ticks - s->tick_offset);
+static void stm32f2xx_timer_update_uif(STM32F2XXTimerState *s, uint8_t =
value)
+{
+    s->tim_sr &=3D ~TIM_SR1_UIF;
+    s->tim_sr |=3D (value & TIM_SR1_UIF);
+    qemu_set_irq(s->irq, value);
+}
=20
-    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
+static void stm32f2xx_timer_tick(void *opaque)
+{
+    STM32F2XXTimerState *s =3D (STM32F2XXTimerState *)opaque;
+    DB_PRINT("Alarm raised\n");
+    stm32f2xx_timer_update_uif(s, 1);
+
+    if (s->count_mode =3D=3D TIMER_UP_COUNT) {
+        stm32f2xx_timer_set_count(s, 0);
+    } else {
+        stm32f2xx_timer_set_count(s, s->tim_arr);
+    }
=20
-    s->hit_time =3D muldiv64((ticks + (uint64_t) now_ticks) * =
(s->tim_psc + 1),
-                               1000000000ULL, s->freq_hz);
+    if (s->tim_cr1 & TIM_CR1_CMS) {
+        if (s->count_mode =3D=3D TIMER_UP_COUNT) {
+            s->count_mode =3D TIMER_DOWN_COUNT;
+        } else {
+            s->count_mode =3D TIMER_UP_COUNT;
+        }
+    }
=20
-    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + =
s->hit_time);
-    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
+    if (s->tim_cr1 & TIM_CR1_OPM) {
+        s->tim_cr1 &=3D ~TIM_CR1_CEN;
+    } else {
+        stm32f2xx_timer_update(s);
+    }
 }
=20
+
 static void stm32f2xx_timer_reset(DeviceState *dev)
 {
     STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
-    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
     s->tim_cr1 =3D 0;
     s->tim_cr2 =3D 0;
     s->tim_smcr =3D 0;
@@ -117,8 +148,6 @@ static void stm32f2xx_timer_reset(DeviceState *dev)
     s->tim_dcr =3D 0;
     s->tim_dmar =3D 0;
     s->tim_or =3D 0;
-
-    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now);
 }
=20
 static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
@@ -132,15 +161,18 @@ static uint64_t stm32f2xx_timer_read(void *opaque, =
hwaddr offset,
     case TIM_CR1:
         return s->tim_cr1;
     case TIM_CR2:
-        return s->tim_cr2;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");
+        return 0;
     case TIM_SMCR:
-        return s->tim_smcr;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SMCR not =
supported");
+        return 0;
     case TIM_DIER:
         return s->tim_dier;
     case TIM_SR:
         return s->tim_sr;
     case TIM_EGR:
-        return s->tim_egr;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: EGR write only");
+        return 0;
     case TIM_CCMR1:
         return s->tim_ccmr1;
     case TIM_CCMR2:
@@ -148,8 +180,7 @@ static uint64_t stm32f2xx_timer_read(void *opaque, =
hwaddr offset,
     case TIM_CCER:
         return s->tim_ccer;
     case TIM_CNT:
-        return stm32f2xx_ns_to_ticks(s, =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) -
-               s->tick_offset;
+        return stm32f2xx_timer_get_count(s);
     case TIM_PSC:
         return s->tim_psc;
     case TIM_ARR:
@@ -163,105 +194,152 @@ static uint64_t stm32f2xx_timer_read(void =
*opaque, hwaddr offset,
     case TIM_CCR4:
         return s->tim_ccr4;
     case TIM_DCR:
-        return s->tim_dcr;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not =
supported");
+        return 0;
     case TIM_DMAR:
-        return s->tim_dmar;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");
+        return 0;
     case TIM_OR:
         return s->tim_or;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, =
offset);
     }
-
     return 0;
 }
=20
+static void stm32f2xx_update_cr1(STM32F2XXTimerState *s, uint64_t =
value)
+{
+    s->tim_cr1 =3D value & 0x3FF;
+    ptimer_transaction_begin(s->timer);
+    stm32f2xx_timer_update(s);
+    ptimer_transaction_commit(s->timer);
+    DB_PRINT("write cr1 =3D %x\n", s->tim_cr1);
+}
+
+static void stm32f2xx_update_sr(STM32F2XXTimerState *s, uint64_t value)
+{
+    s->tim_sr ^=3D (value ^ 0xFFFF);
+    s->tim_sr &=3D 0x1eFF;
+    ptimer_transaction_begin(s->timer);
+    stm32f2xx_timer_update_uif(s, s->tim_sr & 0x1);
+    ptimer_transaction_commit(s->timer);
+    DB_PRINT("write sr =3D %x\n", s->tim_sr);
+}
+
+static void stm32f2xx_update_psc(STM32F2XXTimerState *s, uint64_t =
value)
+{
+    s->tim_psc =3D value & 0xffff;
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, s->freq_hz);
+    ptimer_transaction_commit(s->timer);
+    DB_PRINT("write psc =3D %x\n", s->tim_psc);
+}
+
+static void stm32f2xx_update_egr(STM32F2XXTimerState *s, uint64_t =
value)
+{
+    s->tim_egr =3D value & 0x1E;
+    if (value & TIM_EGR_TG) {
+        s->tim_sr |=3D TIM_EGR_TG;
+    }
+    if (value & TIM_EGR_UG) {
+        /* UG bit - reload */
+        ptimer_transaction_begin(s->timer);
+        ptimer_set_limit(s->timer, s->tim_arr, 1);
+        ptimer_transaction_commit(s->timer);
+    }
+    DB_PRINT("write EGR =3D %x\n", s->tim_egr);
+}
+
+static void stm32f2xx_update_cnt(STM32F2XXTimerState *s, uint64_t =
value)
+{
+    ptimer_transaction_begin(s->timer);
+    stm32f2xx_timer_set_count(s, value & 0xffff);
+    ptimer_transaction_commit(s->timer);
+    DB_PRINT("write cnt =3D %x\n", stm32f2xx_timer_get_count(s));
+}
+
+static void stm32f2xx_update_arr(STM32F2XXTimerState *s, uint64_t =
value)
+{
+    s->tim_arr =3D value & 0xffff;
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_limit(s->timer, s->tim_arr, 1);
+    ptimer_transaction_commit(s->timer);
+    DB_PRINT("write arr =3D %x\n", s->tim_arr);
+}
+
 static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
-                        uint64_t val64, unsigned size)
+                        uint64_t value, unsigned size)
 {
     STM32F2XXTimerState *s =3D opaque;
-    uint32_t value =3D val64;
-    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    uint32_t timer_val =3D 0;
-
-    DB_PRINT("Write 0x%x, 0x%"HWADDR_PRIx"\n", value, offset);
=20
     switch (offset) {
     case TIM_CR1:
-        s->tim_cr1 =3D value;
-        return;
+       stm32f2xx_update_cr1(s, value);
+       break;
     case TIM_CR2:
-        s->tim_cr2 =3D value;
-        return;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");
+        break;
     case TIM_SMCR:
-        s->tim_smcr =3D value;
-        return;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SCMR not =
supported");
+        break;
     case TIM_DIER:
-        s->tim_dier =3D value;
-        return;
+        s->tim_dier =3D value & 0x5F5F;
+        DB_PRINT("write dier =3D %x\n", s->tim_dier);
+        break;
     case TIM_SR:
-        /* This is set by hardware and cleared by software */
-        s->tim_sr &=3D value;
-        return;
+        stm32f2xx_update_sr(s, value);
+        break;
     case TIM_EGR:
-        s->tim_egr =3D value;
-        if (s->tim_egr & TIM_EGR_UG) {
-            timer_val =3D 0;
-            break;
-        }
-        return;
+        stm32f2xx_update_egr(s, value);
+        break;
     case TIM_CCMR1:
-        s->tim_ccmr1 =3D value;
-        return;
+        s->tim_ccmr1 =3D value & 0xffff;
+        DB_PRINT("write ccmr1 =3D %x\n", s->tim_ccmr1);
+        break;
     case TIM_CCMR2:
-        s->tim_ccmr2 =3D value;
-        return;
+        s->tim_ccmr2 =3D value & 0xffff;
+        DB_PRINT("write ccmr2 =3D %x\n", s->tim_ccmr2);
+        break;
     case TIM_CCER:
-        s->tim_ccer =3D value;
-        return;
+        s->tim_ccer =3D value & 0x3333;
+        DB_PRINT("write ccer =3D %x\n", s->tim_ccer);
+        break;
     case TIM_PSC:
-        timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
-        s->tim_psc =3D value & 0xFFFF;
+        stm32f2xx_update_psc(s, value);
         break;
     case TIM_CNT:
-        timer_val =3D value;
+        stm32f2xx_update_cnt(s, value);
         break;
     case TIM_ARR:
-        s->tim_arr =3D value;
-        stm32f2xx_timer_set_alarm(s, now);
-        return;
+        stm32f2xx_update_arr(s, value);
+        break;
     case TIM_CCR1:
-        s->tim_ccr1 =3D value;
-        return;
+        s->tim_ccr1 =3D value & 0xffff;
+        break;
     case TIM_CCR2:
-        s->tim_ccr2 =3D value;
-        return;
+        s->tim_ccr2 =3D value & 0xffff;
+        break;
     case TIM_CCR3:
-        s->tim_ccr3 =3D value;
-        return;
+        s->tim_ccr3 =3D value & 0xffff;
+        break;
     case TIM_CCR4:
-        s->tim_ccr4 =3D value;
-        return;
+        s->tim_ccr4 =3D value & 0xffff;
+        break;
     case TIM_DCR:
-        s->tim_dcr =3D value;
-        return;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not =
supported");
+        break;
     case TIM_DMAR:
-        s->tim_dmar =3D value;
-        return;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DMAR not =
supported");
+        break;
     case TIM_OR:
-        s->tim_or =3D value;
-        return;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: OR not =
supported");
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, =
offset);
-        return;
+        break;
     }
-
-    /* This means that a register write has affected the timer in a way =
that
-     * requires a refresh of both tick_offset and the alarm.
-     */
-    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - timer_val;
-    stm32f2xx_timer_set_alarm(s, now);
 }
=20
 static const MemoryRegionOps stm32f2xx_timer_ops =3D {
@@ -275,7 +353,7 @@ static const VMStateDescription =
vmstate_stm32f2xx_timer =3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
+        VMSTATE_INT32(count_mode, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_cr2, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_smcr, STM32F2XXTimerState),
@@ -300,25 +378,24 @@ static const VMStateDescription =
vmstate_stm32f2xx_timer =3D {
=20
 static Property stm32f2xx_timer_properties[] =3D {
     DEFINE_PROP_UINT64("clock-frequency", struct STM32F2XXTimerState,
-                       freq_hz, 1000000000),
+                       freq_hz, CLOCK_FREQUENCY),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
 static void stm32f2xx_timer_init(Object *obj)
 {
     STM32F2XXTimerState *s =3D STM32F2XXTIMER(obj);
-
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
     memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
                           "stm32f2xx_timer", 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+
 }
=20
 static void stm32f2xx_timer_realize(DeviceState *dev, Error **errp)
 {
     STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);
-    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, =
stm32f2xx_timer_interrupt, s);
+    s->timer =3D ptimer_init(stm32f2xx_timer_tick, s, =
PTIMER_POLICY_LEGACY);
 }
=20
 static void stm32f2xx_timer_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/timer/stm32f2xx_timer.h =
b/include/hw/timer/stm32f2xx_timer.h
index 90f40f1746..c83f7b0d6f 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
+#include "hw/ptimer.h"
=20
 #define TIM_CR1      0x00
 #define TIM_CR2      0x04
@@ -49,9 +50,15 @@
 #define TIM_DMAR     0x4C
 #define TIM_OR       0x50
=20
-#define TIM_CR1_CEN   1
+#define TIM_CR1_CEN 0x0001
+#define TIM_CR1_DIR 0x0010
+#define TIM_CR1_CMS 0x0060
+#define TIM_CR1_OPM 0x0008
=20
-#define TIM_EGR_UG 1
+#define TIM_SR1_UIF 0x0001
+
+#define TIM_EGR_UG 0x0001
+#define TIM_EGR_TG 0x0040
=20
 #define TIM_CCER_CC2E   (1 << 4)
 #define TIM_CCMR1_OC2M2 (1 << 14)
@@ -61,6 +68,7 @@
=20
 #define TIM_DIER_UIE  1
=20
+
 #define TYPE_STM32F2XX_TIMER "stm32f2xx-timer"
 typedef struct STM32F2XXTimerState STM32F2XXTimerState;
 DECLARE_INSTANCE_CHECKER(STM32F2XXTimerState, STM32F2XXTIMER,
@@ -72,12 +80,10 @@ struct STM32F2XXTimerState {
=20
     /* <public> */
     MemoryRegion iomem;
-    QEMUTimer *timer;
+    ptimer_state *timer;
     qemu_irq irq;
-
-    int64_t tick_offset;
-    uint64_t hit_time;
     uint64_t freq_hz;
+    int count_mode;
=20
     uint32_t tim_cr1;
     uint32_t tim_cr2;
@@ -99,4 +105,9 @@ struct STM32F2XXTimerState {
     uint32_t tim_or;
 };
=20
+enum {
+    TIMER_UP_COUNT     =3D 0,
+    TIMER_DOWN_COUNT   =3D 1
+};
+
 #endif /* HW_STM32F2XX_TIMER_H */
--=20
2.39.3 (Apple Git-145)



--Apple-Mail=_ACB8861C-70D3-4830-AE21-06E164E36073
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><meta =
http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><div =
dir=3D"auto"><div dir=3D"ltr"><br><div dir=3D"ltr"><div>Current =
implementation of T2 - T5 times on the STM32 platform does not work =
properly.&nbsp;</div><div>After configuring the timer-counter circuit to =
report interrupts every 10ms, in reality the first interrupt is =
reported&nbsp;</div><div>only once after a few seconds, while subsequent =
interrupts do not come.&nbsp;</div><div>The current code also does not =
properly emulate the operation of even the basic functions of the =
TIME-BASE unit. &nbsp;</div><div>This patch contains fixes that =
reimplements the basic functionality</div><div>of the time base unit =
such as up-counting down-counting , and alternate-mode up-down =
counting.&nbsp;</div><div>The ptimer() API is used to emulate =
timers.&nbsp;</div><div>After applying the patch, STM32 timer works =
correctly in its basic functionality.</div><div>The ISIX-RTOS test unit =
was used to test the patch.</div><div>Links and instructions can be =
found below:</div><div><br></div><div><a =
href=3D"https://github.com/lucckb/isixrtos/blob/master/tests/libisix/01_ba=
sic_primitives.cpp">https://github.com/lucckb/isixrtos/blob/master/tests/l=
ibisix/01_basic_primitives.cpp</a></div><div><a =
href=3D"https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_tes=
t_qemu.md">https://github.com/lucckb/isixrtos/blob/master/extras/doc/unit_=
test_qemu.md</a></div><div><br></div><div><br></div><div>qemu-system-arm =
-M olimex-stm32-h405&nbsp; -kernel =
build/tests/libisix/isixunittests.binary -nographic<br>
unittests_entry.cpp:146|ISIX VERSION pub/ep0319-157-gb239b35f-dirty<br>
unittests_entry.cpp:83|Exceptions pretest. OK<br>
51 selected tests<br>
[ &nbsp; RUN&nbsp; &nbsp; ]	01_base_00 TimeBase timer vs systick<br>
[&nbsp; 1001ms&nbsp; ]	...<br>
[ &nbsp; RUN&nbsp; &nbsp; ]	01_base_01 Basic heap allocator<br>
[ &nbsp; 1ms&nbsp; &nbsp; ]	=
...<br><br></div><div><br></div><div>Best Regards</div><div>Lucjan =
Bryndza</div><div><br></div><div><br></div><div><div>=46rom =
3ccfe70979d1b263d4fa22104ecf42ac5a628554 Mon Sep 17 00:00:00 =
2001</div><div>From: Lucjan Bryndza =
&lt;lbryndza.oss@icloud.com&gt;</div><div>Date: Thu, 26 Oct 2023 =
22:45:26 +0200</div><div>Subject: [PATCH] Fixing the basic functionality =
of STM32 timers</div><div><br></div><div>The current implementation of =
timers does not work properly</div><div>even in the basic functionality. =
A counter configured to report</div><div>an interrupt 10ms every reports =
the first interrupts after a</div><div>few seconds. &nbsp; Count<span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">&nbsp;up =
and</span></div><div><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);">count down modes are also&nbsp;</span>not properly =
implemented. This commit fixes bugs with interrupt</div><div>reporting =
and implements the basic modes of the counter's</div><div>time-base =
block.</div><div><br></div><div>Signed-off-by: Lucjan Bryndza =
&lt;lbryndza.oss@icloud.com&gt;</div><div>---</div><div>&nbsp;hw/arm/stm32=
f405_soc.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; 2 =
+-</div><div>&nbsp;hw/timer/stm32f2xx_timer.c &nbsp; &nbsp; &nbsp; =
&nbsp; | 291 =
++++++++++++++++++-----------</div><div>&nbsp;include/hw/timer/stm32f2xx_t=
imer.h | &nbsp;23 ++-</div><div>&nbsp;3 files changed, 202 =
insertions(+), 114 deletions(-)</div><div><br></div><div>diff --git =
a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c</div><div>index =
cef23d7ee4..69316181b3 100644</div><div>--- =
a/hw/arm/stm32f405_soc.c</div><div>+++ =
b/hw/arm/stm32f405_soc.c</div><div>@@ -183,7 +183,7 @@ static void =
stm32f405_soc_realize(DeviceState *dev_soc, Error =
**errp)</div><div>&nbsp; &nbsp; &nbsp;/* Timer 2 to 5 =
*/</div><div>&nbsp; &nbsp; &nbsp;for (i =3D 0; i &lt; STM_NUM_TIMERS; =
i++) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dev =3D =
DEVICE(&amp;(s-&gt;timer[i]));</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;qdev_prop_set_uint64(dev, "clock-frequency", =
1000000000);</div><div>+ &nbsp; &nbsp; &nbsp; qdev_prop_set_uint64(dev, =
"clock-frequency", 48000000);</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;timer[i]), errp)) =
{</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;return;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;}</div><div>diff --git a/hw/timer/stm32f2xx_timer.c =
b/hw/timer/stm32f2xx_timer.c</div><div>index ba8694dcd3..65f3287125 =
100644</div><div>--- a/hw/timer/stm32f2xx_timer.c</div><div>+++ =
b/hw/timer/stm32f2xx_timer.c</div><div>@@ -29,11 +29,18 =
@@</div><div>&nbsp;#include =
"migration/vmstate.h"</div><div>&nbsp;#include =
"qemu/log.h"</div><div>&nbsp;#include =
"qemu/module.h"</div><div>+#include =
"qemu/typedefs.h"</div><div>+#include "qemu/timer.h"</div><div>+#include =
"qemu/main-loop.h"</div><div>+#include =
"sysemu/dma.h"</div><div>&nbsp;</div><div>&nbsp;#ifndef =
STM_TIMER_ERR_DEBUG</div><div>&nbsp;#define STM_TIMER_ERR_DEBUG =
0</div><div>&nbsp;#endif</div><div>&nbsp;</div><div>+/* PCLK /4 =
*/</div><div>+#define CLOCK_FREQUENCY =
48000000ULL</div><div>+</div><div>&nbsp;#define DB_PRINT_L(lvl, fmt, =
args...) do { \</div><div>&nbsp; &nbsp; &nbsp;if (STM_TIMER_ERR_DEBUG =
&gt;=3D lvl) { \</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log("%s: " fmt, __func__, ## args); \</div><div>@@ -42,63 =
+49,87 @@</div><div>&nbsp;</div><div>&nbsp;#define DB_PRINT(fmt, =
args...) DB_PRINT_L(1, fmt, ## args)</div><div>&nbsp;</div><div>-static =
void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t =
now);</div><div>&nbsp;</div><div>-static void =
stm32f2xx_timer_interrupt(void *opaque)</div><div>+static uint32_t =
stm32f2xx_timer_get_count(STM32F2XXTimerState =
*s)</div><div>&nbsp;{</div><div>- &nbsp; &nbsp;STM32F2XXTimerState *s =3D =
opaque;</div><div>-</div><div>- &nbsp; =
&nbsp;DB_PRINT("Interrupt\n");</div><div>-</div><div>- &nbsp; &nbsp;if =
(s-&gt;tim_dier &amp; TIM_DIER_UIE &amp;&amp; s-&gt;tim_cr1 &amp; =
TIM_CR1_CEN) {</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_sr |=3D =
1;</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_irq_pulse(s-&gt;irq);</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;stm32f2xx_timer_set_alarm(s, s-&gt;hit_time);</div><div>- &nbsp; =
&nbsp;}</div><div>-</div><div>- &nbsp; &nbsp;if (s-&gt;tim_ccmr1 &amp; =
(TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &amp;&amp;</div><div>- &nbsp; &nbsp; =
&nbsp; &nbsp;!(s-&gt;tim_ccmr1 &amp; TIM_CCMR1_OC2M0) =
&amp;&amp;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccmr1 &amp; =
TIM_CCMR1_OC2PE &amp;&amp;</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_ccer &amp; TIM_CCER_CC2E) {</div><div>- &nbsp; &nbsp; =
&nbsp; &nbsp;/* PWM 2 - Mode 1 */</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;DB_PRINT("PWM2 Duty Cycle: %d%%\n",</div><div>- &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccr2 / (100 * =
(s-&gt;tim_psc + 1)));</div><div>+ &nbsp; &nbsp;uint64_t cnt =3D =
ptimer_get_count(s-&gt;timer);</div><div>+ &nbsp; &nbsp;if =
(s-&gt;count_mode =3D=3D TIMER_UP_COUNT) {</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;return s-&gt;tim_arr - (cnt &amp; 0xffff);</div><div>+ =
&nbsp; &nbsp;} else {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return cnt =
&amp; 0xffff;</div><div>&nbsp; &nbsp; =
&nbsp;}</div><div>&nbsp;}</div><div>&nbsp;</div><div>-static inline =
int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, int64_t =
t)</div><div>+</div><div>+static void =
stm32f2xx_timer_set_count(STM32F2XXTimerState *s, uint32_t =
cnt)</div><div>&nbsp;{</div><div>- &nbsp; &nbsp;return muldiv64(t, =
s-&gt;freq_hz, 1000000000ULL) / (s-&gt;tim_psc + 1);</div><div>+ &nbsp; =
&nbsp;if (s-&gt;count_mode =3D=3D TIMER_UP_COUNT) {</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;ptimer_set_count(s-&gt;timer, s-&gt;tim_arr - (cnt =
&amp; 0xffff));</div><div>+ &nbsp; &nbsp;} else {</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;ptimer_set_count(s-&gt;timer, cnt &amp; =
0xffff);</div><div>+ &nbsp; =
&nbsp;}</div><div>&nbsp;}</div><div>&nbsp;</div><div>-static void =
stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t =
now)</div><div>+static void stm32f2xx_timer_update(STM32F2XXTimerState =
*s)</div><div>&nbsp;{</div><div>- &nbsp; &nbsp;uint64_t =
ticks;</div><div>- &nbsp; &nbsp;int64_t now_ticks;</div><div>+ &nbsp; =
&nbsp;if (s-&gt;tim_cr1 &amp; TIM_CR1_DIR) {</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;s-&gt;count_mode =3D TIMER_DOWN_COUNT;</div><div>+ &nbsp; =
&nbsp;} else {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;count_mode =3D=
 TIMER_UP_COUNT;</div><div>+ &nbsp; &nbsp;}</div><div>&nbsp;</div><div>- =
&nbsp; &nbsp;if (s-&gt;tim_arr =3D=3D 0) {</div><div>- &nbsp; &nbsp; =
&nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp;if (s-&gt;tim_cr1 &amp; =
TIM_CR1_CMS) {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;count_mode =3D=
 TIMER_UP_COUNT;</div><div>&nbsp; &nbsp; =
&nbsp;}</div><div>&nbsp;</div><div>- &nbsp; &nbsp;DB_PRINT("Alarm set =
at: 0x%x\n", s-&gt;tim_cr1);</div><div>+ &nbsp; &nbsp;if (s-&gt;tim_cr1 =
&amp; TIM_CR1_CEN) {</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;DB_PRINT("Enabling timer\n");</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;ptimer_set_freq(s-&gt;timer, s-&gt;freq_hz);</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;ptimer_run(s-&gt;timer, !(s-&gt;tim_cr1 &amp; =
0x04));</div><div>+ &nbsp; &nbsp;} else {</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;DB_PRINT("Disabling timer\n");</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;ptimer_stop(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;}</div><div>+}</div><div>&nbsp;</div><div>- &nbsp; &nbsp;now_ticks =
=3D stm32f2xx_ns_to_ticks(s, now);</div><div>- &nbsp; &nbsp;ticks =3D =
s-&gt;tim_arr - (now_ticks - s-&gt;tick_offset);</div><div>+static void =
stm32f2xx_timer_update_uif(STM32F2XXTimerState *s, uint8_t =
value)</div><div>+{</div><div>+ &nbsp; &nbsp;s-&gt;tim_sr &amp;=3D =
~TIM_SR1_UIF;</div><div>+ &nbsp; &nbsp;s-&gt;tim_sr |=3D (value &amp; =
TIM_SR1_UIF);</div><div>+ &nbsp; &nbsp;qemu_set_irq(s-&gt;irq, =
value);</div><div>+}</div><div>&nbsp;</div><div>- &nbsp; =
&nbsp;DB_PRINT("Alarm set in %d ticks\n", (int) =
ticks);</div><div>+static void stm32f2xx_timer_tick(void =
*opaque)</div><div>+{</div><div>+ &nbsp; &nbsp;STM32F2XXTimerState *s =3D =
(STM32F2XXTimerState *)opaque;</div><div>+ &nbsp; &nbsp;DB_PRINT("Alarm =
raised\n");</div><div>+ &nbsp; &nbsp;stm32f2xx_timer_update_uif(s, =
1);</div><div>+</div><div>+ &nbsp; &nbsp;if (s-&gt;count_mode =3D=3D =
TIMER_UP_COUNT) {</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;stm32f2xx_timer_set_count(s, 0);</div><div>+ &nbsp; &nbsp;} else =
{</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;stm32f2xx_timer_set_count(s, =
s-&gt;tim_arr);</div><div>+ &nbsp; &nbsp;}</div><div>&nbsp;</div><div>- =
&nbsp; &nbsp;s-&gt;hit_time =3D muldiv64((ticks + (uint64_t) now_ticks) =
* (s-&gt;tim_psc + 1),</div><div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
1000000000ULL, s-&gt;freq_hz);</div><div>+ &nbsp; &nbsp;if =
(s-&gt;tim_cr1 &amp; TIM_CR1_CMS) {</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;if (s-&gt;count_mode =3D=3D TIMER_UP_COUNT) {</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;count_mode =3D =
TIMER_DOWN_COUNT;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;} else =
{</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;count_mode =
=3D TIMER_UP_COUNT;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;}</div><div>+ =
&nbsp; &nbsp;}</div><div>&nbsp;</div><div>- &nbsp; =
&nbsp;timer_mod(s-&gt;timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + =
s-&gt;hit_time);</div><div>- &nbsp; &nbsp;DB_PRINT("Wait Time: %" PRId64 =
" ticks\n", s-&gt;hit_time);</div><div>+ &nbsp; &nbsp;if (s-&gt;tim_cr1 =
&amp; TIM_CR1_OPM) {</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_cr1 &amp;=3D ~TIM_CR1_CEN;</div><div>+ &nbsp; &nbsp;} =
else {</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;stm32f2xx_timer_update(s);</div><div>+ &nbsp; =
&nbsp;}</div><div>&nbsp;}</div><div>&nbsp;</div><div>+</div><div>&nbsp;sta=
tic void stm32f2xx_timer_reset(DeviceState =
*dev)</div><div>&nbsp;{</div><div>&nbsp; &nbsp; =
&nbsp;STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);</div><div>- &nbsp; =
&nbsp;int64_t now =3D =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);</div><div>-</div><div>&nbsp; =
&nbsp; &nbsp;s-&gt;tim_cr1 =3D 0;</div><div>&nbsp; &nbsp; =
&nbsp;s-&gt;tim_cr2 =3D 0;</div><div>&nbsp; &nbsp; &nbsp;s-&gt;tim_smcr =
=3D 0;</div><div>@@ -117,8 +148,6 @@ static void =
stm32f2xx_timer_reset(DeviceState *dev)</div><div>&nbsp; &nbsp; =
&nbsp;s-&gt;tim_dcr =3D 0;</div><div>&nbsp; &nbsp; &nbsp;s-&gt;tim_dmar =
=3D 0;</div><div>&nbsp; &nbsp; &nbsp;s-&gt;tim_or =3D =
0;</div><div>-</div><div>- &nbsp; &nbsp;s-&gt;tick_offset =3D =
stm32f2xx_ns_to_ticks(s, =
now);</div><div>&nbsp;}</div><div>&nbsp;</div><div>&nbsp;static uint64_t =
stm32f2xx_timer_read(void *opaque, hwaddr offset,</div><div>@@ -132,15 =
+161,18 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr =
offset,</div><div>&nbsp; &nbsp; &nbsp;case TIM_CR1:</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;return s-&gt;tim_cr1;</div><div>&nbsp; &nbsp; =
&nbsp;case TIM_CR2:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return =
s-&gt;tim_cr2;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return =
0;</div><div>&nbsp; &nbsp; &nbsp;case TIM_SMCR:</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return s-&gt;tim_smcr;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SMCR not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return =
0;</div><div>&nbsp; &nbsp; &nbsp;case TIM_DIER:</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;return s-&gt;tim_dier;</div><div>&nbsp; &nbsp; =
&nbsp;case TIM_SR:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return =
s-&gt;tim_sr;</div><div>&nbsp; &nbsp; &nbsp;case TIM_EGR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;return s-&gt;tim_egr;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: EGR =
write only");</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return =
0;</div><div>&nbsp; &nbsp; &nbsp;case TIM_CCMR1:</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;return s-&gt;tim_ccmr1;</div><div>&nbsp; &nbsp; =
&nbsp;case TIM_CCMR2:</div><div>@@ -148,8 +180,7 @@ static uint64_t =
stm32f2xx_timer_read(void *opaque, hwaddr offset,</div><div>&nbsp; =
&nbsp; &nbsp;case TIM_CCER:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;return s-&gt;tim_ccer;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_CNT:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return =
stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) =
-</div><div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
s-&gt;tick_offset;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return =
stm32f2xx_timer_get_count(s);</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_PSC:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return =
s-&gt;tim_psc;</div><div>&nbsp; &nbsp; &nbsp;case TIM_ARR:</div><div>@@ =
-163,105 +194,152 @@ static uint64_t stm32f2xx_timer_read(void *opaque, =
hwaddr offset,</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_CCR4:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return =
s-&gt;tim_ccr4;</div><div>&nbsp; &nbsp; &nbsp;case TIM_DCR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;return s-&gt;tim_dcr;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return =
0;</div><div>&nbsp; &nbsp; &nbsp;case TIM_DMAR:</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return s-&gt;tim_dmar;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;return =
0;</div><div>&nbsp; &nbsp; &nbsp;case TIM_OR:</div><div>&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;return s-&gt;tim_or;</div><div>&nbsp; &nbsp; =
&nbsp;default:</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log_mask(LOG_GUEST_ERROR,</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"%s: Bad =
offset 0x%"HWADDR_PRIx"\n", __func__, offset);</div><div>&nbsp; &nbsp; =
&nbsp;}</div><div>-</div><div>&nbsp; &nbsp; &nbsp;return =
0;</div><div>&nbsp;}</div><div>&nbsp;</div><div>+static void =
stm32f2xx_update_cr1(STM32F2XXTimerState *s, uint64_t =
value)</div><div>+{</div><div>+ &nbsp; &nbsp;s-&gt;tim_cr1 =3D value =
&amp; 0x3FF;</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_begin(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;stm32f2xx_timer_update(s);</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_commit(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;DB_PRINT("write cr1 =3D %x\n", =
s-&gt;tim_cr1);</div><div>+}</div><div>+</div><div>+static void =
stm32f2xx_update_sr(STM32F2XXTimerState *s, uint64_t =
value)</div><div>+{</div><div>+ &nbsp; &nbsp;s-&gt;tim_sr ^=3D (value ^ =
0xFFFF);</div><div>+ &nbsp; &nbsp;s-&gt;tim_sr &amp;=3D =
0x1eFF;</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_begin(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;stm32f2xx_timer_update_uif(s, s-&gt;tim_sr &amp; 0x1);</div><div>+ =
&nbsp; &nbsp;ptimer_transaction_commit(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;DB_PRINT("write sr =3D %x\n", =
s-&gt;tim_sr);</div><div>+}</div><div>+</div><div>+static void =
stm32f2xx_update_psc(STM32F2XXTimerState *s, uint64_t =
value)</div><div>+{</div><div>+ &nbsp; &nbsp;s-&gt;tim_psc =3D value =
&amp; 0xffff;</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_begin(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;ptimer_set_freq(s-&gt;timer, s-&gt;freq_hz);</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_commit(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;DB_PRINT("write psc =3D %x\n", =
s-&gt;tim_psc);</div><div>+}</div><div>+</div><div>+static void =
stm32f2xx_update_egr(STM32F2XXTimerState *s, uint64_t =
value)</div><div>+{</div><div>+ &nbsp; &nbsp;s-&gt;tim_egr =3D value =
&amp; 0x1E;</div><div>+ &nbsp; &nbsp;if (value &amp; TIM_EGR_TG) =
{</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_sr |=3D =
TIM_EGR_TG;</div><div>+ &nbsp; &nbsp;}</div><div>+ &nbsp; &nbsp;if =
(value &amp; TIM_EGR_UG) {</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;/* UG =
bit - reload */</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;ptimer_transaction_begin(s-&gt;timer);</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;ptimer_set_limit(s-&gt;timer, s-&gt;tim_arr, =
1);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;ptimer_transaction_commit(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;}</div><div>+ &nbsp; &nbsp;DB_PRINT("write EGR =3D %x\n", =
s-&gt;tim_egr);</div><div>+}</div><div>+</div><div>+static void =
stm32f2xx_update_cnt(STM32F2XXTimerState *s, uint64_t =
value)</div><div>+{</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_begin(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;stm32f2xx_timer_set_count(s, value &amp; 0xffff);</div><div>+ =
&nbsp; &nbsp;ptimer_transaction_commit(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;DB_PRINT("write cnt =3D %x\n", =
stm32f2xx_timer_get_count(s));</div><div>+}</div><div>+</div><div>+static =
void stm32f2xx_update_arr(STM32F2XXTimerState *s, uint64_t =
value)</div><div>+{</div><div>+ &nbsp; &nbsp;s-&gt;tim_arr =3D value =
&amp; 0xffff;</div><div>+ &nbsp; =
&nbsp;ptimer_transaction_begin(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;ptimer_set_limit(s-&gt;timer, s-&gt;tim_arr, 1);</div><div>+ =
&nbsp; &nbsp;ptimer_transaction_commit(s-&gt;timer);</div><div>+ &nbsp; =
&nbsp;DB_PRINT("write arr =3D %x\n", =
s-&gt;tim_arr);</div><div>+}</div><div>+</div><div>&nbsp;static void =
stm32f2xx_timer_write(void *opaque, hwaddr offset,</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;uint64_t val64, unsigned size)</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint64_t =
value, unsigned size)</div><div>&nbsp;{</div><div>&nbsp; &nbsp; =
&nbsp;STM32F2XXTimerState *s =3D opaque;</div><div>- &nbsp; =
&nbsp;uint32_t value =3D val64;</div><div>- &nbsp; &nbsp;int64_t now =3D =
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);</div><div>- &nbsp; &nbsp;uint32_t =
timer_val =3D 0;</div><div>-</div><div>- &nbsp; &nbsp;DB_PRINT("Write =
0x%x, 0x%"HWADDR_PRIx"\n", value, =
offset);</div><div>&nbsp;</div><div>&nbsp; &nbsp; &nbsp;switch (offset) =
{</div><div>&nbsp; &nbsp; &nbsp;case TIM_CR1:</div><div>- &nbsp; &nbsp; =
&nbsp; &nbsp;s-&gt;tim_cr1 =3D value;</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; stm32f2xx_update_cr1(s, =
value);</div><div>+ &nbsp; &nbsp; &nbsp; break;</div><div>&nbsp; &nbsp; =
&nbsp;case TIM_CR2:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_cr2 =
=3D value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ =
&nbsp; &nbsp; &nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: =
CR2 not supported");</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_SMCR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_smcr =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SCMR not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_DIER:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_dier =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_dier =3D value &amp; 0x5F5F;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;DB_PRINT("write dier =3D %x\n", =
s-&gt;tim_dier);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_SR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;/* This is set by hardware and cleared by =
software */</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_sr &amp;=3D =
value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;stm32f2xx_update_sr(s, value);</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_EGR:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_egr =3D =
value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;if (s-&gt;tim_egr &amp; =
TIM_EGR_UG) {</div><div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;timer_val =3D 0;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;}</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;stm32f2xx_update_egr(s, value);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_CCMR1:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccmr1 =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_ccmr1 =3D value &amp; 0xffff;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;DB_PRINT("write ccmr1 =3D %x\n", =
s-&gt;tim_ccmr1);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_CCMR2:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccmr2 =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_ccmr2 =3D value &amp; 0xffff;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;DB_PRINT("write ccmr2 =3D %x\n", =
s-&gt;tim_ccmr2);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_CCER:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccer =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_ccer =3D value &amp; 0x3333;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;DB_PRINT("write ccer =3D %x\n", =
s-&gt;tim_ccer);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_PSC:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;timer_val =3D stm32f2xx_ns_to_ticks(s, now) - =
s-&gt;tick_offset;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_psc =
=3D value &amp; 0xFFFF;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;stm32f2xx_update_psc(s, value);</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_CNT:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;timer_val =3D =
value;</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp;stm32f2xx_update_cnt(s, =
value);</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_ARR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_arr =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;stm32f2xx_timer_set_alarm(s, now);</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;stm32f2xx_update_arr(s, value);</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_CCR1:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccr1 =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;s-&gt;tim_ccr1 =3D value &amp; 0xffff;</div><div>+ &nbsp; &nbsp; =
&nbsp; &nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_CCR2:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccr2 =3D =
value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;s-&gt;tim_ccr2 =3D value &amp; 0xffff;</div><div>+ =
&nbsp; &nbsp; &nbsp; &nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_CCR3:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccr3 =3D =
value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;s-&gt;tim_ccr3 =3D value &amp; 0xffff;</div><div>+ =
&nbsp; &nbsp; &nbsp; &nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_CCR4:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_ccr4 =3D =
value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;s-&gt;tim_ccr4 =3D value &amp; 0xffff;</div><div>+ =
&nbsp; &nbsp; &nbsp; &nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case =
TIM_DCR:</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_dcr =3D =
value;</div><div>- &nbsp; &nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; =
&nbsp; &nbsp; &nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_DMAR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_dmar =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DMAR not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;case TIM_OR:</div><div>- =
&nbsp; &nbsp; &nbsp; &nbsp;s-&gt;tim_or =3D value;</div><div>- &nbsp; =
&nbsp; &nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: OR not =
supported");</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;default:</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; =
&nbsp;qemu_log_mask(LOG_GUEST_ERROR,</div><div>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"%s: Bad =
offset 0x%"HWADDR_PRIx"\n", __func__, offset);</div><div>- &nbsp; &nbsp; =
&nbsp; &nbsp;return;</div><div>+ &nbsp; &nbsp; &nbsp; =
&nbsp;break;</div><div>&nbsp; &nbsp; &nbsp;}</div><div>-</div><div>- =
&nbsp; &nbsp;/* This means that a register write has affected the timer =
in a way that</div><div>- &nbsp; &nbsp; * requires a refresh of both =
tick_offset and the alarm.</div><div>- &nbsp; &nbsp; */</div><div>- =
&nbsp; &nbsp;s-&gt;tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - =
timer_val;</div><div>- &nbsp; &nbsp;stm32f2xx_timer_set_alarm(s, =
now);</div><div>&nbsp;}</div><div>&nbsp;</div><div>&nbsp;static const =
MemoryRegionOps stm32f2xx_timer_ops =3D {</div><div>@@ -275,7 +353,7 @@ =
static const VMStateDescription vmstate_stm32f2xx_timer =3D =
{</div><div>&nbsp; &nbsp; &nbsp;.version_id =3D 1,</div><div>&nbsp; =
&nbsp; &nbsp;.minimum_version_id =3D 1,</div><div>&nbsp; &nbsp; =
&nbsp;.fields =3D (VMStateField[]) {</div><div>- &nbsp; &nbsp; &nbsp; =
&nbsp;VMSTATE_INT64(tick_offset, STM32F2XXTimerState),</div><div>+ =
&nbsp; &nbsp; &nbsp; &nbsp;VMSTATE_INT32(count_mode, =
STM32F2XXTimerState),</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),</div><div>&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;VMSTATE_UINT32(tim_cr2, =
STM32F2XXTimerState),</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;VMSTATE_UINT32(tim_smcr, STM32F2XXTimerState),</div><div>@@ =
-300,25 +378,24 @@ static const VMStateDescription =
vmstate_stm32f2xx_timer =3D {</div><div>&nbsp;</div><div>&nbsp;static =
Property stm32f2xx_timer_properties[] =3D {</div><div>&nbsp; &nbsp; =
&nbsp;DEFINE_PROP_UINT64("clock-frequency", struct =
STM32F2XXTimerState,</div><div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; freq_hz, =
1000000000),</div><div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; freq_hz, =
CLOCK_FREQUENCY),</div><div>&nbsp; &nbsp; =
&nbsp;DEFINE_PROP_END_OF_LIST(),</div><div>&nbsp;};</div><div>&nbsp;</div>=
<div>&nbsp;static void stm32f2xx_timer_init(Object =
*obj)</div><div>&nbsp;{</div><div>&nbsp; &nbsp; =
&nbsp;STM32F2XXTimerState *s =3D =
STM32F2XXTIMER(obj);</div><div>-</div><div>&nbsp; &nbsp; =
&nbsp;sysbus_init_irq(SYS_BUS_DEVICE(obj), =
&amp;s-&gt;irq);</div><div>-</div><div>&nbsp; &nbsp; =
&nbsp;memory_region_init_io(&amp;s-&gt;iomem, obj, =
&amp;stm32f2xx_timer_ops, s,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;"stm32f2xx_timer", 0x400);</div><div>&nbsp; &nbsp; =
&nbsp;sysbus_init_mmio(SYS_BUS_DEVICE(obj), =
&amp;s-&gt;iomem);</div><div>+</div><div>&nbsp;}</div><div>&nbsp;</div><di=
v>&nbsp;static void stm32f2xx_timer_realize(DeviceState *dev, Error =
**errp)</div><div>&nbsp;{</div><div>&nbsp; &nbsp; =
&nbsp;STM32F2XXTimerState *s =3D STM32F2XXTIMER(dev);</div><div>- &nbsp; =
&nbsp;s-&gt;timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, =
stm32f2xx_timer_interrupt, s);</div><div>+ &nbsp; &nbsp;s-&gt;timer =3D =
ptimer_init(stm32f2xx_timer_tick, s, =
PTIMER_POLICY_LEGACY);</div><div>&nbsp;}</div><div>&nbsp;</div><div>&nbsp;=
static void stm32f2xx_timer_class_init(ObjectClass *klass, void =
*data)</div><div>diff --git a/include/hw/timer/stm32f2xx_timer.h =
b/include/hw/timer/stm32f2xx_timer.h</div><div>index =
90f40f1746..c83f7b0d6f 100644</div><div>--- =
a/include/hw/timer/stm32f2xx_timer.h</div><div>+++ =
b/include/hw/timer/stm32f2xx_timer.h</div><div>@@ -28,6 +28,7 =
@@</div><div>&nbsp;#include "hw/sysbus.h"</div><div>&nbsp;#include =
"qemu/timer.h"</div><div>&nbsp;#include =
"qom/object.h"</div><div>+#include =
"hw/ptimer.h"</div><div>&nbsp;</div><div>&nbsp;#define TIM_CR1 &nbsp; =
&nbsp; &nbsp;0x00</div><div>&nbsp;#define TIM_CR2 &nbsp; &nbsp; =
&nbsp;0x04</div><div>@@ -49,9 +50,15 @@</div><div>&nbsp;#define TIM_DMAR =
&nbsp; &nbsp; 0x4C</div><div>&nbsp;#define TIM_OR &nbsp; &nbsp; &nbsp; =
0x50</div><div>&nbsp;</div><div>-#define TIM_CR1_CEN &nbsp; =
1</div><div>+#define TIM_CR1_CEN 0x0001</div><div>+#define TIM_CR1_DIR =
0x0010</div><div>+#define TIM_CR1_CMS 0x0060</div><div>+#define =
TIM_CR1_OPM 0x0008</div><div>&nbsp;</div><div>-#define TIM_EGR_UG =
1</div><div>+#define TIM_SR1_UIF 0x0001</div><div>+</div><div>+#define =
TIM_EGR_UG 0x0001</div><div>+#define TIM_EGR_TG =
0x0040</div><div>&nbsp;</div><div>&nbsp;#define TIM_CCER_CC2E &nbsp; (1 =
&lt;&lt; 4)</div><div>&nbsp;#define TIM_CCMR1_OC2M2 (1 &lt;&lt; =
14)</div><div>@@ -61,6 +68,7 @@</div><div>&nbsp;</div><div>&nbsp;#define =
TIM_DIER_UIE =
&nbsp;1</div><div>&nbsp;</div><div>+</div><div>&nbsp;#define =
TYPE_STM32F2XX_TIMER "stm32f2xx-timer"</div><div>&nbsp;typedef struct =
STM32F2XXTimerState =
STM32F2XXTimerState;</div><div>&nbsp;DECLARE_INSTANCE_CHECKER(STM32F2XXTim=
erState, STM32F2XXTIMER,</div><div>@@ -72,12 +80,10 @@ struct =
STM32F2XXTimerState {</div><div>&nbsp;</div><div>&nbsp; &nbsp; &nbsp;/* =
&lt;public&gt; */</div><div>&nbsp; &nbsp; &nbsp;MemoryRegion =
iomem;</div><div>- &nbsp; &nbsp;QEMUTimer *timer;</div><div>+ &nbsp; =
&nbsp;ptimer_state *timer;</div><div>&nbsp; &nbsp; &nbsp;qemu_irq =
irq;</div><div>-</div><div>- &nbsp; &nbsp;int64_t =
tick_offset;</div><div>- &nbsp; &nbsp;uint64_t =
hit_time;</div><div>&nbsp; &nbsp; &nbsp;uint64_t freq_hz;</div><div>+ =
&nbsp; &nbsp;int count_mode;</div><div>&nbsp;</div><div>&nbsp; &nbsp; =
&nbsp;uint32_t tim_cr1;</div><div>&nbsp; &nbsp; &nbsp;uint32_t =
tim_cr2;</div><div>@@ -99,4 +105,9 @@ struct STM32F2XXTimerState =
{</div><div>&nbsp; &nbsp; &nbsp;uint32_t =
tim_or;</div><div>&nbsp;};</div><div>&nbsp;</div><div>+enum =
{</div><div>+ &nbsp; &nbsp;TIMER_UP_COUNT &nbsp; &nbsp; =3D =
0,</div><div>+ &nbsp; &nbsp;TIMER_DOWN_COUNT &nbsp; =3D =
1</div><div>+};</div><div>+</div><div>&nbsp;#endif /* =
HW_STM32F2XX_TIMER_H */</div><div>--&nbsp;</div><div>2.39.3 (Apple =
Git-145)</div><div><br></div></div><div><br></div></div></div>
</div></body></html>=

--Apple-Mail=_ACB8861C-70D3-4830-AE21-06E164E36073--

