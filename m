Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E48801D23
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:44:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9QEu-0005BD-45; Sat, 02 Dec 2023 08:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEs-0005Ah-Ed
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:58 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEp-000063-CB
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:40:56 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 979E811F365;
 Sat,  2 Dec 2023 13:40:35 +0000 (UTC)
From: ~lbryndza <lbryndza@git.sr.ht>
Date: Sat, 02 Dec 2023 13:20:29 +0100
Subject: [PATCH qemu v3 13/20] Fixing the basic functionality of STM32 timers
Message-ID: <170152443229.18048.53824064267512246-13@git.sr.ht>
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

Add update egr function

Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
---
 hw/timer/stm32f2xx_timer.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 3997521610..010b5b41bd 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -233,6 +233,21 @@ static void stm32f2xx_update_psc(STM32F2XXTimerState *s,=
 uint64_t value)
     ptimer_transaction_commit(s->timer);
     DB_PRINT("write psc =3D %x\n", s->tim_psc);
 }
+
+static void stm32f2xx_update_egr(STM32F2XXTimerState *s, uint64_t value)
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
 static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
                         uint64_t val64, unsigned size)
 {
--=20
2.38.5


