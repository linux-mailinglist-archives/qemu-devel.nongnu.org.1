Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B666809E84
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:48:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWVa-00064a-LE; Fri, 08 Dec 2023 03:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVL-0005zT-AD
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:39 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVH-0000le-BH
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sml9g3GD7z4xCp;
 Fri,  8 Dec 2023 19:46:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sml9c4rLqz4x1v;
 Fri,  8 Dec 2023 19:46:28 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 06/10] vfio/container: Intoduce a new
 VFIOIOMMUClass::setup handler
Date: Fri,  8 Dec 2023 09:45:56 +0100
Message-ID: <20231208084600.858964-7-clg@redhat.com>
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

This will help in converting the sPAPR IOMMU backend to a QOM interface.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 1 +
 hw/vfio/container.c                   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index a31fd9c2e3b9a571083ea8987ac27e91b332c170..870e7dc48e542ddbfc52e12b0ab5fab4771a1ebd 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -104,6 +104,7 @@ struct VFIOIOMMUClass {
     InterfaceClass parent_class;
 
     /* basic feature */
+    int (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index fdf4e116570013732d48071a5122d25b02da715c..5f5ad8479f083db0be5207f179f3056ae67c49c3 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1129,6 +1129,7 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->setup = vfio_legacy_setup;
     vioc->dma_map = vfio_legacy_dma_map;
     vioc->dma_unmap = vfio_legacy_dma_unmap;
     vioc->attach_device = vfio_legacy_attach_device;
-- 
2.43.0


