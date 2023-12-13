Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E8809E87
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:48:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWVO-00060P-0v; Fri, 08 Dec 2023 03:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVD-0005r9-6I
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:31 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWV9-0000kJ-2K
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sml9T21QQz4x7q;
 Fri,  8 Dec 2023 19:46:21 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sml9Q3bBlz4x1v;
 Fri,  8 Dec 2023 19:46:18 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps under
 vfio_init_container()
Date: Fri,  8 Dec 2023 09:45:53 +0100
Message-ID: <20231208084600.858964-4-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208084600.858964-1-clg@redhat.com>
References: <20231208084600.858964-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7WKM=HT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

vfio_init_container() already defines the IOMMU type of the container.
Do the same for the VFIOIOMMUOps struct. This prepares ground for the
following patches that will deduce the associated VFIOIOMMUOps struct
from the IOMMU type.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index afcfe8048805c58291d1104ff0ef20bdc457f99c..f4a0434a5239bfb6a17b91c8879cb98e686afccc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -370,7 +370,7 @@ static int vfio_get_iommu_type(VFIOContainer *container,
 }
 
 static int vfio_init_container(VFIOContainer *container, int group_fd,
-                               Error **errp)
+                               VFIOAddressSpace *space, Error **errp)
 {
     int iommu_type, ret;
 
@@ -401,6 +401,7 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
     }
 
     container->iommu_type = iommu_type;
+    vfio_container_init(&container->bcontainer, space, &vfio_legacy_ops);
     return 0;
 }
 
@@ -583,9 +584,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, space, &vfio_legacy_ops);
 
-    ret = vfio_init_container(container, group->fd, errp);
+    ret = vfio_init_container(container, group->fd, space, errp);
     if (ret) {
         goto free_container_exit;
     }
-- 
2.43.0


