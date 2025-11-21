Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 593FBC7C421
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Nov 2025 04:17:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd2W-0001SH-1n; Fri, 21 Nov 2025 21:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcf4-0005wT-5c; Fri, 21 Nov 2025 20:43:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcd1-0003Zn-Ka; Fri, 21 Nov 2025 20:43:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BCCE616CA74;
 Fri, 21 Nov 2025 21:44:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 09EB3321CB0;
 Fri, 21 Nov 2025 21:44:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 57/81] hw/misc/npcm_clk: Don't divide by zero when
 calculating frequency
Date: Fri, 21 Nov 2025 21:43:56 +0300
Message-ID: <20251121184424.1137669-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Peter Maydell <peter.maydell@linaro.org>

If the guest misprograms the PLL registers to request a zero
divisor, we currently fall over with a division by zero:

../../hw/misc/npcm_clk.c:221:14: runtime error: division by zero
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/misc/npcm_clk.c:221:14

Thread 1 "qemu-system-aar" received signal SIGFPE, Arithmetic exception.
0x00005555584d8f6d in npcm7xx_clk_update_pll (opaque=0x7fffed159a20) at ../../hw/misc/npcm_clk.c:221
221             freq /= PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);

Avoid this by treating this invalid setting like a stopped clock
(setting freq to 0).

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/549
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251107150137.1353532-1-peter.maydell@linaro.org
(cherry picked from commit 5fc50b4ec841c8a01e7346c2c804088fc3accb6b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index b6a893ffb2..e6b28c7a57 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -212,13 +212,14 @@ static void npcm7xx_clk_update_pll(void *opaque)
 {
     NPCM7xxClockPLLState *s = opaque;
     uint32_t con = s->clk->regs[s->reg];
-    uint64_t freq;
+    uint64_t freq, freq_div;
 
     /* The PLL is grounded if it is not locked yet. */
     if (con & PLLCON_LOKI) {
         freq = clock_get_hz(s->clock_in);
         freq *= PLLCON_FBDV(con);
-        freq /= PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);
+        freq_div = PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);
+        freq = freq_div ? freq / freq_div : 0;
     } else {
         freq = 0;
     }
-- 
2.47.3


