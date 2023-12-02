Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71915801D14
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9QF0-0005Ej-Nt; Sat, 02 Dec 2023 08:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEw-0005Cg-BV
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:41:02 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEr-00006f-Cb
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:41:00 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 1FC8611F368;
 Sat,  2 Dec 2023 13:40:36 +0000 (UTC)
From: ~lbryndza <lbryndza@git.sr.ht>
Date: Sat, 02 Dec 2023 13:22:28 +0100
Subject: [PATCH qemu v3 16/20] Fixing the basic functionality of STM32 timers
Message-ID: <170152443229.18048.53824064267512246-16@git.sr.ht>
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

Update timer write function

Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
---
 hw/timer/stm32f2xx_timer.c | 67 +++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 800172a3ff..bb10a276da 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -265,92 +265,79 @@ static void stm32f2xx_update_arr(STM32F2XXTimerState *s=
, uint64_t value)
     ptimer_transaction_commit(s->timer);
     DB_PRINT("write arr =3D %x\n", s->tim_arr);
 }
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
+        stm32f2xx_update_cr1(s, value);
         return;
     case TIM_CR2:
-        s->tim_cr2 =3D value;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not supported");
         return;
     case TIM_SMCR:
-        s->tim_smcr =3D value;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SCMR not supported");
         return;
     case TIM_DIER:
-        s->tim_dier =3D value;
+        s->tim_dier =3D value & 0x5F5F;
+        DB_PRINT("write dier =3D %x\n", s->tim_dier);
         return;
     case TIM_SR:
-        /* This is set by hardware and cleared by software */
-        s->tim_sr &=3D value;
+        stm32f2xx_update_sr(s, value);
         return;
     case TIM_EGR:
-        s->tim_egr =3D value;
-        if (s->tim_egr & TIM_EGR_UG) {
-            timer_val =3D 0;
-            break;
-        }
+        stm32f2xx_update_egr(s, value);
         return;
     case TIM_CCMR1:
-        s->tim_ccmr1 =3D value;
+        s->tim_ccmr1 =3D value & 0xffff;
+        DB_PRINT("write ccmr1 =3D %x\n", s->tim_ccmr1);
         return;
     case TIM_CCMR2:
-        s->tim_ccmr2 =3D value;
+        s->tim_ccmr2 =3D value & 0xffff;
+        DB_PRINT("write ccmr2 =3D %x\n", s->tim_ccmr2);
         return;
     case TIM_CCER:
-        s->tim_ccer =3D value;
+        s->tim_ccer =3D value & 0x3333;
+        DB_PRINT("write ccer =3D %x\n", s->tim_ccer);
         return;
     case TIM_PSC:
-        timer_val =3D stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
-        s->tim_psc =3D value & 0xFFFF;
-        break;
+        stm32f2xx_update_psc(s, value);
+        return;
     case TIM_CNT:
-        timer_val =3D value;
-        break;
+        stm32f2xx_update_cnt(s, value);
+        return;
     case TIM_ARR:
-        s->tim_arr =3D value;
-        stm32f2xx_timer_set_alarm(s, now);
+        stm32f2xx_update_arr(s, value);
         return;
     case TIM_CCR1:
-        s->tim_ccr1 =3D value;
+        s->tim_ccr1 =3D value & 0xffff;
         return;
     case TIM_CCR2:
-        s->tim_ccr2 =3D value;
+        s->tim_ccr2 =3D value & 0xffff;
         return;
     case TIM_CCR3:
-        s->tim_ccr3 =3D value;
+        s->tim_ccr3 =3D value & 0xffff;
         return;
     case TIM_CCR4:
-        s->tim_ccr4 =3D value;
+        s->tim_ccr4 =3D value & 0xffff;
         return;
     case TIM_DCR:
-        s->tim_dcr =3D value;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not supported");
         return;
     case TIM_DMAR:
-        s->tim_dmar =3D value;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DMAR not supported");
         return;
     case TIM_OR:
-        s->tim_or =3D value;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: OR not supported");
         return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, offset);
         return;
     }
-
-    /* This means that a register write has affected the timer in a way that
-     * requires a refresh of both tick_offset and the alarm.
-     */
-    s->tick_offset =3D stm32f2xx_ns_to_ticks(s, now) - timer_val;
-    stm32f2xx_timer_set_alarm(s, now);
 }
=20
 static const MemoryRegionOps stm32f2xx_timer_ops =3D {
--=20
2.38.5


