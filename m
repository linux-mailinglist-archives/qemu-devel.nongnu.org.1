Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E38801D1E
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 14:43:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9QF0-0005DR-4x; Sat, 02 Dec 2023 08:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEw-0005Ca-3S
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:41:02 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1r9QEr-00006k-Ca
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 08:41:00 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 8FCD711F36B;
 Sat,  2 Dec 2023 13:40:36 +0000 (UTC)
From: ~lbryndza <lbryndza@git.sr.ht>
Date: Sat, 02 Dec 2023 13:26:25 +0100
Subject: [PATCH qemu v3 19/20] Fixing the basic functionality of STM32 timers
Message-ID: <170152443229.18048.53824064267512246-19@git.sr.ht>
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

Update timer structures

Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
---
 include/hw/timer/stm32f2xx_timer.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f2xx_=
timer.h
index 8112878aa7..c83f7b0d6f 100644
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
@@ -79,12 +80,10 @@ struct STM32F2XXTimerState {
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
--=20
2.38.5


