Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 427509158FD
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 23:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrD0-0006Me-VR; Mon, 24 Jun 2024 17:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCx-0006Cf-FC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCr-0006rS-LB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMY1D9Xu1DAUFPrRQ1v/hwsSwzaPB+Uo9Uhc1JQMpYs=;
 b=cxbBs3hf//ReZB3WNgvbYTcl/4T4WX6P5jXkQbLYKNA9Hc8e1ktEro8nrIQ1ZUDGs9Lxfy
 /mW79r/7FpmOFKo7WhYAqQ66LztyEWydN2pmrCGpdj5kJSuUwIhCsWRmitOYZAWP8ciBOk
 +Uy1PElskQbOWV6o1Wvbkolrnx4Yt38=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-8LHKYWN8M1WOEOiwH-1mTw-1; Mon,
 24 Jun 2024 17:26:31 -0400
X-MC-Unique: 8LHKYWN8M1WOEOiwH-1mTw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73BFC195608C; Mon, 24 Jun 2024 21:26:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7D931956054; Mon, 24 Jun 2024 21:26:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 36/42] vfio/container: Change VFIOContainerBase to use QOM
Date: Mon, 24 Jun 2024 23:24:50 +0200
Message-ID: <20240624212456.350919-37-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

VFIOContainerBase was made a QOM interface because we believed that a
QOM object would expose all the IOMMU backends to the QEMU machine and
human interface. This only applies to user creatable devices or objects.

Change the VFIOContainerBase nature from interface to object and make
the necessary adjustments in the VFIO_IOMMU hierarchy.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  4 ++++
 include/hw/vfio/vfio-container-base.h | 12 +++---------
 hw/vfio/container-base.c              |  4 +++-
 hw/vfio/container.c                   |  1 +
 hw/vfio/iommufd.c                     |  1 +
 hw/vfio/spapr.c                       |  3 +++
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 825d80130bd435fe50830c8ae5b7905d18104dd6..e8ddf92bb18547f0d3b811b3d757cbae7fec8b8d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -84,6 +84,8 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
@@ -99,6 +101,8 @@ typedef struct VFIOIOMMUFDContainer {
     uint32_t ioas_id;
 } VFIOIOMMUFDContainer;
 
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index d505f63607ec40e6aa44aeb3e20848ac780562a1..b079b76f68975c5701a289ce9012e912a8e44fc6 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -34,6 +34,7 @@ typedef struct VFIOAddressSpace {
  * This is the base object for vfio container backends
  */
 typedef struct VFIOContainerBase {
+    Object parent;
     const VFIOIOMMUClass *ops;
     VFIOAddressSpace *space;
     MemoryListener listener;
@@ -96,17 +97,10 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
 
-/*
- * VFIOContainerBase is not an abstract QOM object because it felt
- * unnecessary to expose all the IOMMU backends to the QEMU machine
- * and human interface. However, we can still abstract the IOMMU
- * backend handlers using a QOM interface class. This provides more
- * flexibility when referencing the various implementations.
- */
-DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
+OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
 struct VFIOIOMMUClass {
-    InterfaceClass parent_class;
+    ObjectClass parent_class;
 
     /* Properties */
     const char *hiod_typename;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 280f0dd2db1fc3939fe9925ce00a2c50d0e14196..98c15e174dd78df5146ee83c05c98f3ea9c1e52c 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -102,8 +102,10 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU,
-        .parent = TYPE_INTERFACE,
+        .parent = TYPE_OBJECT,
+        .instance_size = sizeof(VFIOContainerBase),
         .class_size = sizeof(VFIOIOMMUClass),
+        .abstract = true,
     },
 };
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 31bdc46a96d1626b237227a25007957e1d472757..3ae52530a9b500bd53ec9f9e66c73253d97c9aba 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1196,6 +1196,7 @@ static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOContainer),
         .class_init = vfio_iommu_legacy_class_init,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e5d9334142418514215528b9523f12c031792c7f..3e9d642034c2d2234ea701952c94a78ab32e9147 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -672,6 +672,7 @@ static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
         .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOIOMMUFDContainer),
         .class_init = vfio_iommu_iommufd_class_init,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 47b040f1bcca7dd0b5cf052d941b43541e98a3c5..018bd2048194a6a2db83ed740025a7060181698f 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -30,6 +30,8 @@ typedef struct VFIOSpaprContainer {
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
 } VFIOSpaprContainer;
 
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
+
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
     if (memory_region_is_iommu(section->mr)) {
@@ -548,6 +550,7 @@ static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_SPAPR,
         .parent = TYPE_VFIO_IOMMU_LEGACY,
+        .instance_size = sizeof(VFIOSpaprContainer),
         .class_init = vfio_iommu_spapr_class_init,
     },
 };
-- 
2.45.2


