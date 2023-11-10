Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE617E8527
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 22:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Z97-0002ax-SC; Fri, 10 Nov 2023 16:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1r1VVt-0006QU-BA
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:41:49 -0500
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1r1VVr-0005H5-2Z
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:41:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 8FB101869017;
 Fri, 10 Nov 2023 20:41:34 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id wvWJpubvldbO; Fri, 10 Nov 2023 20:41:34 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 486291868F89;
 Fri, 10 Nov 2023 20:41:34 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 9jJTylLtCj7W; Fri, 10 Nov 2023 20:41:34 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.237.150])
 by mail.astralinux.ru (Postfix) with ESMTPSA id 5644B1863F5A;
 Fri, 10 Nov 2023 20:41:33 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: [PATCH] hw/display/vmware_vga: fix probably typo
Date: Fri, 10 Nov 2023 20:41:04 +0300
Message-Id: <20231110174104.13280-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119;
 envelope-from=adiupina@astralinux.ru; helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Nov 2023 16:34:26 -0500
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

When calling trace_vmware_verify_rect_greater_than_bound() replace
"y" with "h" and y with h

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 02218aedb1 ("hw/display/vmware_vga: replace fprintf calls with tra=
ce events")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 hw/display/vmware_vga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 7490d43881..3f26bea190 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -336,8 +336,8 @@ static inline bool vmsvga_verify_rect(DisplaySurface =
*surface,
         return false;
     }
     if (h > SVGA_MAX_HEIGHT) {
-        trace_vmware_verify_rect_greater_than_bound(name, "y", SVGA_MAX_=
HEIGHT,
-                                                    y);
+        trace_vmware_verify_rect_greater_than_bound(name, "h", SVGA_MAX_=
HEIGHT,
+                                                    h);
         return false;
     }
     if (y + h > surface_height(surface)) {
--=20
2.30.2


