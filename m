Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEB761A82
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINT-0006e6-Sq; Tue, 25 Jul 2023 09:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMF-0005Gs-9z; Tue, 25 Jul 2023 09:45:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMD-0001HS-Os; Tue, 25 Jul 2023 09:45:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 630BC160ED;
 Tue, 25 Jul 2023 16:45:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 81D95194B0;
 Tue, 25 Jul 2023 16:45:30 +0300 (MSK)
Received: (nullmailer pid 3370798 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 05/31] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Date: Tue, 25 Jul 2023 16:44:50 +0300
Message-Id: <20230725134517.3370706-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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
(cherry picked from commit 8af87a3ec7e42ff1b9cf75ceee0451c31e34d153)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4773cc1f2b..53dcb3efaa 100644
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
2.39.2


