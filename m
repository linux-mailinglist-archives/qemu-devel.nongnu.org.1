Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE1573EAFE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrN7-0003Tf-7N; Mon, 26 Jun 2023 14:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrMF-0001vs-Jp; Mon, 26 Jun 2023 14:54:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrLn-0005Uz-T8; Mon, 26 Jun 2023 14:54:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C0B0EF40;
 Mon, 26 Jun 2023 21:50:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6BE54F7CF;
 Mon, 26 Jun 2023 21:50:27 +0300 (MSK)
Received: (nullmailer pid 1574082 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 41/54] hw/intc/allwinner-a10-pic: Handle IRQ levels
 other than 0 or 1
Date: Mon, 26 Jun 2023 21:49:48 +0300
Message-Id: <20230626185002.1573836-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 2c5fa0778c3b430 we fixed an endianness bug in the Allwinner
A10 PIC model; however in the process we introduced a regression.
This is because the old code was robust against the incoming 'level'
argument being something other than 0 or 1, whereas the new code was
not.

In particular, the allwinner-sdhost code treats its IRQ line
as 0-vs-non-0 rather than 0-vs-1, so when the SD controller
set its IRQ line for any reason other than transmit the
interrupt controller would ignore it. The observed effect
was a guest timeout when rebooting the guest kernel.

Handle level values other than 0 or 1, to restore the old
behaviour.

Fixes: 2c5fa0778c3b430 ("hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()")
(Mjt:  af08c70ef5204fe in stable-8.0)
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20230606104609.3692557-2-peter.maydell@linaro.org
(cherry picked from commit f837b468cdaa7e736b5385c7dc4f8c5adcad3bf1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 4875e68ba6..d0bf8d545b 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -51,7 +51,7 @@ static void aw_a10_pic_set_irq(void *opaque, int irq, int level)
     AwA10PICState *s = opaque;
     uint32_t *pending_reg = &s->irq_pending[irq / 32];
 
-    *pending_reg = deposit32(*pending_reg, irq % 32, 1, level);
+    *pending_reg = deposit32(*pending_reg, irq % 32, 1, !!level);
     aw_a10_pic_update(s);
 }
 
-- 
2.39.2


