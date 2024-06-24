Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A223E9158F3
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 23:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCs-0005Nz-8X; Mon, 24 Jun 2024 17:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCl-0004kB-2V
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCh-0006nv-Jc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9Xxpw6hFNbZAaPpfxh018kdn7i18l2cZpestljZF00=;
 b=EYSmmjBy39+F76CMDjr2y2dMF/x+5H/XMQsDTIqBCBIZVNeRXtqs0+NcT4y3rvqD2cS6Bi
 zlCg6RhQ3+ZrJJ5QkPOj/ZShhxTHDKoOXUSlC/ELddvKH6A35Aip4Dtk7xk3FFXOSWMazS
 EHG5a87l6NaGUXlI1jMflf0iV1A2Hng=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-3s2r6EVMPamHmxQgonLj5Q-1; Mon,
 24 Jun 2024 17:26:20 -0400
X-MC-Unique: 3s2r6EVMPamHmxQgonLj5Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81A2119560BC; Mon, 24 Jun 2024 21:26:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1FD51956053; Mon, 24 Jun 2024 21:26:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 31/42] vfio/container: Simplify vfio_container_init()
Date: Mon, 24 Jun 2024 23:24:45 +0200
Message-ID: <20240624212456.350919-32-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Assign the base container VFIOAddressSpace 'space' pointer in
vfio_address_space_insert(). The ultimate goal is to remove
vfio_container_init() and instead rely on an .instance_init() handler
to perfom the initialization of VFIOContainerBase.

To be noted that vfio_connect_container() will assign the 'space'
pointer later in the execution flow. This should not have any
consequence.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 1 -
 hw/vfio/common.c                      | 1 +
 hw/vfio/container-base.c              | 3 +--
 hw/vfio/container.c                   | 6 +++---
 hw/vfio/iommufd.c                     | 2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 442c0dfc4c1774753c239c2c8360dcd1540d44fa..d505f63607ec40e6aa44aeb3e20848ac780562a1 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -87,7 +87,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
-                         VFIOAddressSpace *space,
                          const VFIOIOMMUClass *ops);
 void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8cdf26c6f5a490cfa02bdf1087a91948709aaa33..1686a0bed23bd95467bfb00a0c39a4d966e49cae 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1512,6 +1512,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
                                VFIOContainerBase *bcontainer)
 {
     QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+    bcontainer->space = space;
 }
 
 struct vfio_device_info *vfio_get_device_info(int fd)
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 760d9d0622b2e847ecb3368c88df772efb06043f..280f0dd2db1fc3939fe9925ce00a2c50d0e14196 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -71,11 +71,10 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                                errp);
 }
 
-void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
+void vfio_container_init(VFIOContainerBase *bcontainer,
                          const VFIOIOMMUClass *ops)
 {
     bcontainer->ops = ops;
-    bcontainer->space = space;
     bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0237c216987ff64a6d11bef8688bb000d93a7f09..dc85a79cb9e62b72312f79da994c53608b6cef48 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -394,7 +394,7 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
 }
 
 static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
-                           VFIOAddressSpace *space, Error **errp)
+                           Error **errp)
 {
     int iommu_type;
     const VFIOIOMMUClass *vioc;
@@ -432,7 +432,7 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
         return false;
     }
 
-    vfio_container_init(&container->bcontainer, space, vioc);
+    vfio_container_init(&container->bcontainer, vioc);
     return true;
 }
 
@@ -614,7 +614,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     bcontainer = &container->bcontainer;
 
-    if (!vfio_set_iommu(container, group->fd, space, errp)) {
+    if (!vfio_set_iommu(container, group->fd, errp)) {
         goto free_container_exit;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9f8f33e383a38827ceca0f73cb77f5ca6b123198..e5d9334142418514215528b9523f12c031792c7f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -357,7 +357,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     container->ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, space, iommufd_vioc);
+    vfio_container_init(bcontainer, iommufd_vioc);
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
-- 
2.45.2


