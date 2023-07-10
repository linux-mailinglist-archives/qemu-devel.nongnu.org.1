Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0A74CF13
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:51:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleK-0006li-Qs; Mon, 10 Jul 2023 03:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldz-0006NW-Ov
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldy-0006us-5p
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx3F3ql4z4wxx;
 Mon, 10 Jul 2023 17:49:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx3C2cd2z4wy9;
 Mon, 10 Jul 2023 17:49:11 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/11] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Date: Mon, 10 Jul 2023 09:48:44 +0200
Message-ID: <20230710074848.456453-8-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Avihai Horon <avihaih@nvidia.com>

vfio_realize() has the following flow:
1. vfio_bars_prepare() -- sets VFIOBAR->size.
2. msix_early_setup().
3. vfio_bars_register() -- allocates VFIOBAR->mr.

After vfio_bars_prepare() is called msix_early_setup() can fail. If it
does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
allocated.

In this case, vfio_bars_finalize() is called as part of the error flow
to free the bars' resources. However, vfio_bars_finalize() calls
object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
thus we get a null pointer dereference.

Fix it by checking VFIOBAR->mr in vfio_bars_finalize().

Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 68dd99283620..c89fdf7ae6c2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1752,9 +1752,11 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
 
         vfio_bar_quirk_finalize(vdev, i);
         vfio_region_finalize(&bar->region);
-        if (bar->size) {
+        if (bar->mr) {
+            assert(bar->size);
             object_unparent(OBJECT(bar->mr));
             g_free(bar->mr);
+            bar->mr = NULL;
         }
     }
 
-- 
2.41.0


