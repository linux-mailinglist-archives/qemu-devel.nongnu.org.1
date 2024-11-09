Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1447F9C2CCC
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:16:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kL1-0002vH-3a; Sat, 09 Nov 2024 07:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKh-00024r-FI; Sat, 09 Nov 2024 07:12:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKf-0004cf-K8; Sat, 09 Nov 2024 07:12:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A20EA1612;
 Sat,  9 Nov 2024 15:07:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 11B26167FA0;
 Sat,  9 Nov 2024 15:08:04 +0300 (MSK)
Received: (nullmailer pid 3295382 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sergey Makarov <s.makarov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 42/57] hw/intc: Don't clear pending bits on IRQ lowering
Date: Sat,  9 Nov 2024 15:07:44 +0300
Message-Id: <20241109120801.3295120-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Sergey Makarov <s.makarov@syntacore.com>

According to PLIC specification (chapter 5), there
is only one case, when interrupt is claimed. Fix
PLIC controller to match this behavior.

Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240918140229.124329-3-s.makarov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit a84be2baa9eca8bc500f866ad943b8f63dc99adf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index e559f11805..ca4c2de494 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -349,8 +349,10 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 {
     SiFivePLICState *s = opaque;
 
-    sifive_plic_set_pending(s, irq, level > 0);
-    sifive_plic_update(s);
+    if (level > 0) {
+        sifive_plic_set_pending(s, irq, true);
+        sifive_plic_update(s);
+    }
 }
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
-- 
2.39.5


