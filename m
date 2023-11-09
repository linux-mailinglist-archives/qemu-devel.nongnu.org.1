Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8FB7E6BA0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:52:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Nq-0000mj-2v; Thu, 09 Nov 2023 08:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NE-0007jj-CN; Thu, 09 Nov 2023 08:47:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15N0-00020O-FS; Thu, 09 Nov 2023 08:46:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C36431B1C;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5C5BB344C2;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461870 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 36/55] hw/xen: use correct default protocol for
 xen-block on x86
Date: Thu,  9 Nov 2023 16:42:40 +0300
Message-Id: <20231109134300.1461632-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: David Woodhouse <dwmw@amazon.co.uk>

Even on x86_64 the default protocol is the x86-32 one if the guest doesn't
specifically ask for x86-64.

Cc: qemu-stable@nongnu.org
Fixes: b6af8926fb85 ("xen: add implementations of xen-block connect and disconnect functions...")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
(cherry picked from commit a1c1082908dde4867b1ac55f546bea0c17d52318)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 3906b9058b..c754126711 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -115,9 +115,13 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
         return;
     }
 
-    if (xen_device_frontend_scanf(xendev, "protocol", "%ms",
-                                  &str) != 1) {
-        protocol = BLKIF_PROTOCOL_NATIVE;
+    if (xen_device_frontend_scanf(xendev, "protocol", "%ms", &str) != 1) {
+        /* x86 defaults to the 32-bit protocol even for 64-bit guests. */
+        if (object_dynamic_cast(OBJECT(qdev_get_machine()), "x86-machine")) {
+            protocol = BLKIF_PROTOCOL_X86_32;
+        } else {
+            protocol = BLKIF_PROTOCOL_NATIVE;
+        }
     } else {
         if (strcmp(str, XEN_IO_PROTO_ABI_X86_32) == 0) {
             protocol = BLKIF_PROTOCOL_X86_32;
-- 
2.39.2


