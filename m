Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7C801D1D
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:43:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9QEe-00055u-QI; Sat, 02 Dec 2023 08:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEa-00055K-PE
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:40 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QET-0008V6-Ie
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:36 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id D004911F014;
 Sat,  2 Dec 2023 13:40:32 +0000 (UTC)
From: ~lbryndza <lbryndza@git.sr.ht>
Date: Sat, 02 Dec 2023 13:05:19 +0100
Subject: [PATCH qemu v3 02/20] Fixing the basic functionality of STM32 timers
Message-ID: <170152443229.18048.53824064267512246-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170152443229.18048.53824064267512246-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_REPLYTO=2.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~lbryndza <lbryndza.oss@icloud.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Lucjan Bryndza <lbryndza.oss@icloud.com>

The current implementation of timers does not work properly
even in basic functionality. A counter configured to report
an interrupt every 10ms reports the first interrupts after a
few seconds.  There are also no properly implemented count up an
count down modes. This commit fixes bugs with interrupt
reporting and implements the basic modes of the counter's
time-base block.

Remove wrong qemu timer implementation

Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
---
 hw/timer/stm32f2xx_timer.c | 55 ++++----------------------------------
 1 file changed, 5 insertions(+), 50 deletions(-)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index ba8694dcd3..f03f594a17 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -23,12 +23,17 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/stm32f2xx_timer.h"
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
@@ -42,57 +47,7 @@
=20
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
=20
-static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t now);
=20
-static void stm32f2xx_timer_interrupt(void *opaque)
-{
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
-    }
-}
-
-static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, int64_t =
t)
-{
-    return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + 1);
-}
-
-static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t now)
-{
-    uint64_t ticks;
-    int64_t now_ticks;
-
-    if (s->tim_arr =3D=3D 0) {
-        return;
-    }
-
-    DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
-
-    now_ticks =3D stm32f2xx_ns_to_ticks(s, now);
-    ticks =3D s->tim_arr - (now_ticks - s->tick_offset);
-
-    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
-
-    s->hit_time =3D muldiv64((ticks + (uint64_t) now_ticks) * (s->tim_psc + =
1),
-                               1000000000ULL, s->freq_hz);
-
-    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->hit_time);
-    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
-}
=20
 static void stm32f2xx_timer_reset(DeviceState *dev)
 {
--=20
2.38.5


