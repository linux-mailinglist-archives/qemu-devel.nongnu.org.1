Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FECA8268A5
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:34:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk8T-0003Rk-2t; Mon, 08 Jan 2024 02:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8O-0003Iu-2l
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=P3fH=IS=redhat.com=clg@ozlabs.org>)
 id 1rMk8L-0004hv-7H
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:33:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7m4q1YqMz4x23;
 Mon,  8 Jan 2024 18:33:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7m4n38rFz4wyS;
 Mon,  8 Jan 2024 18:33:13 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/17] vfio/container: Rename vfio_init_container to
 vfio_set_iommu
Date: Mon,  8 Jan 2024 08:32:29 +0100
Message-ID: <20240108073232.118228-15-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108073232.118228-1-clg@redhat.com>
References: <20240108073232.118228-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=P3fH=IS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

vfio_container_init() and vfio_init_container() names are confusing
especially when we see vfio_init_container() calls vfio_container_init().

vfio_container_init() operates on base container which is consistent
with all routines handling 'VFIOContainerBase *' ops.

vfio_init_container() operates on legacy container and setup IOMMU
context with ioctl(VFIO_SET_IOMMU).

So choose to rename vfio_init_container to vfio_set_iommu to avoid
the confusion.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 8d334f52f2438d05f632502e07ffd4dc2ec76cb5..bd25b9fbad2e717e63c2ab0e331186e5f63cef49 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -392,8 +392,8 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
     return VFIO_IOMMU_CLASS(klass);
 }
 
-static int vfio_init_container(VFIOContainer *container, int group_fd,
-                               VFIOAddressSpace *space, Error **errp)
+static int vfio_set_iommu(VFIOContainer *container, int group_fd,
+                          VFIOAddressSpace *space, Error **errp)
 {
     int iommu_type, ret;
     const VFIOIOMMUClass *vioc;
@@ -616,7 +616,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     bcontainer = &container->bcontainer;
 
-    ret = vfio_init_container(container, group->fd, space, errp);
+    ret = vfio_set_iommu(container, group->fd, space, errp);
     if (ret) {
         goto free_container_exit;
     }
-- 
2.43.0


