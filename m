Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13D490533F
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 15:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNcO-0003SG-Vs; Wed, 12 Jun 2024 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNcK-0003KT-TN
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNcC-00081Q-Oj
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4pjGaGoyjtNHc+eRM2tVmkqWWianbUh/EWWOB064lE=;
 b=W1YFj6Yr+WbuC/C/HX0ILkxMMvqT/xBSKQQ/tFTkyeLM4Z5OmR1phExu5HrZ017/NMNxB9
 /WkWRYIyceNy9nayE+hgtYOBQd8vdxm8+1vifYpqaYVudVGP3e17UESE3YJlnotCoVKlF6
 5GH7e+vnRWRHJiJqRlFOG/PxRQyjorA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-jqQTprIaPOudRrniSpSlbw-1; Wed,
 12 Jun 2024 09:02:02 -0400
X-MC-Unique: jqQTprIaPOudRrniSpSlbw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B32E1954214; Wed, 12 Jun 2024 13:02:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B2B31956053; Wed, 12 Jun 2024 13:01:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 15/16] vfio/container: Remove vfio_container_init()
Date: Wed, 12 Jun 2024 15:01:21 +0200
Message-ID: <20240612130122.813935-16-clg@redhat.com>
In-Reply-To: <20240612130122.813935-1-clg@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It's now empty.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 2 --
 hw/vfio/container-base.c              | 5 -----
 hw/vfio/container.c                   | 3 ---
 hw/vfio/iommufd.c                     | 1 -
 4 files changed, 11 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 6b57cd8e7f5d7d2817f6e3b96ce4566d2630bb12..6242a62771caa8cf19440a53ad6f4db862ca12d7 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -86,8 +86,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 
-void vfio_container_init(VFIOContainerBase *bcontainer,
-                         const VFIOIOMMUClass *ops);
 void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 24669d4d7472f49ac3adf2618a32bf7d82c5c344..970ae2356a92f87df44e1dd58ff8c67045a24ef1 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -83,11 +83,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                                errp);
 }
 
-void vfio_container_init(VFIOContainerBase *bcontainer,
-                         const VFIOIOMMUClass *ops)
-{
-}
-
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
 {
     VFIOGuestIOMMU *giommu, *tmp;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9e9e1ab229c0804f073cd65d92735d4bbf63d1d7..60a0838a9ca83a010d73396dbcd2d24fcdc802ae 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -419,7 +419,6 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
                                             Error **errp)
 {
     int iommu_type;
-    const VFIOIOMMUClass *vioc;
     const char *vioc_name;
     VFIOContainer *container;
 
@@ -433,12 +432,10 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
     }
 
     vioc_name = vfio_get_iommu_class_name(iommu_type);
-    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
 
     container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
     container->fd = fd;
     container->iommu_type = iommu_type;
-    vfio_container_init(&container->bcontainer, vioc);
     return container;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e1932135df410c53d4062616ee2664b27d30b92c..811e12b7da91357fa5b85ebb9dcc3adeabfa41fd 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -357,7 +357,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     container->ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, iommufd_vioc);
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
-- 
2.45.2


