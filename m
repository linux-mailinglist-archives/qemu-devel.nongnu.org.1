Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A52801D1B
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:42:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9QEv-0005Bl-IX; Sat, 02 Dec 2023 08:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEs-0005Ar-Kv
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:58 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEp-000055-Cj
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:57 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 776BD11F361;
 Sat,  2 Dec 2023 13:40:34 +0000 (UTC)
From: ~lbryndza <lbryndza@git.sr.ht>
Date: Sat, 02 Dec 2023 13:18:17 +0100
Subject: [PATCH qemu v3 09/20] Fixing the basic functionality of STM32 timers
Message-ID: <170152443229.18048.53824064267512246-9@git.sr.ht>
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

Timer read function modified

Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
---
 hw/timer/stm32f2xx_timer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 20ca762601..07d82b841a 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -159,15 +159,18 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwad=
dr offset,
     case TIM_CR1:
         return s->tim_cr1;
     case TIM_CR2:
-        return s->tim_cr2;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not supported");
+        return 0;
     case TIM_SMCR:
-        return s->tim_smcr;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: SMCR not supported");
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
@@ -175,8 +178,7 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr=
 offset,
     case TIM_CCER:
         return s->tim_ccer;
     case TIM_CNT:
-        return stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
)) -
-               s->tick_offset;
+        return stm32f2xx_timer_get_count(s);
     case TIM_PSC:
         return s->tim_psc;
     case TIM_ARR:
@@ -190,16 +192,17 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwad=
dr offset,
     case TIM_CCR4:
         return s->tim_ccr4;
     case TIM_DCR:
-        return s->tim_dcr;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: DCR not supported");
+        return 0;
     case TIM_DMAR:
-        return s->tim_dmar;
+        qemu_log_mask(LOG_GUEST_ERROR, "stm32_timer: CR2 not supported");
+        return 0;
     case TIM_OR:
         return s->tim_or;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, offset);
     }
-
     return 0;
 }
=20
--=20
2.38.5


