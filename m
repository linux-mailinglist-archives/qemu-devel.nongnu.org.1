Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A2274BBF0
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0GB-0006Hs-K1; Sat, 08 Jul 2023 01:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fv-0006FT-Dt; Sat, 08 Jul 2023 01:13:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Ft-0001k3-Iq; Sat, 08 Jul 2023 01:13:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4112512681;
 Sat,  8 Jul 2023 08:13:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7AA7A139CF;
 Sat,  8 Jul 2023 08:13:04 +0300 (MSK)
Received: (nullmailer pid 3229981 invoked by uid 1000);
 Sat, 08 Jul 2023 05:13:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Lucas Dietrich <ld.adecy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/10] target/avr: Fix handling of interrupts above 33.
Date: Sat,  8 Jul 2023 08:12:42 +0300
Message-Id: <fc97167f1fc716b2f4d57adcd34f9bb4544976c9.1688793073.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1688793073.git.mjt@tls.msk.ru>
References: <cover.1688793073.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Lucas Dietrich <ld.adecy@gmail.com>

This commit addresses a bug in the AVR interrupt handling code.
The modification involves replacing the usage of the ctz32 function
with ctz64 to ensure proper handling of interrupts above 33 in the AVR
target.

Previously, timers 3, 4, and 5 interrupts were not functioning correctly
because most of their interrupt vectors are numbered above 33.

Signed-off-by: Lucas Dietrich <ld.adecy@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: updated subject line to have subsytem prefix)
---
 target/avr/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 2bad242a66..e6e7d51487 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -52,7 +52,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         if (cpu_interrupts_enabled(env) && env->intsrc != 0) {
-            int index = ctz32(env->intsrc);
+            int index = ctz64(env->intsrc);
             cs->exception_index = EXCP_INT(index);
             avr_cpu_do_interrupt(cs);
 
@@ -79,7 +79,7 @@ void avr_cpu_do_interrupt(CPUState *cs)
     if (cs->exception_index == EXCP_RESET) {
         vector = 0;
     } else if (env->intsrc != 0) {
-        vector = ctz32(env->intsrc) + 1;
+        vector = ctz64(env->intsrc) + 1;
     }
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
-- 
2.39.2


