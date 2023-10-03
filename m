Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CBB7B6639
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncSL-0007ba-8b; Tue, 03 Oct 2023 06:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qncSG-0007aq-Aj
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qncS3-0004Vf-Nv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696328187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcBmqIuyPnHgedmKy2ossbRkzFHL6LIyAEHIzIUz0Ak=;
 b=BTW/ck8MWexBZGMjjJFxv85YCzT9WpJzpiVNHohtWJM4gnEn8TEdHMkhNbhKOEVxYbGwGH
 R9fWB1spEbMvCfaNUUZrhEZYfudHzCKbUYfd8uHUmJqkiDcGuuVOqJrU1BLFaBowa72Y6O
 JsOy7oIDwzw+g8bSgqvvWGjzVYax4i4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-kVWM-PYGO8WA_2_Kg6D07g-1; Tue, 03 Oct 2023 06:16:25 -0400
X-MC-Unique: kVWM-PYGO8WA_2_Kg6D07g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA2C985A5BE;
 Tue,  3 Oct 2023 10:16:24 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCC4492B16;
 Tue,  3 Oct 2023 10:16:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
Subject: [PATCH v3 13/15] vfio/common: Store the parent container in VFIODevice
Date: Tue,  3 Oct 2023 12:14:10 +0200
Message-ID: <20231003101530.288864-14-eric.auger@redhat.com>
In-Reply-To: <20231003101530.288864-1-eric.auger@redhat.com>
References: <20231003101530.288864-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

let's store the parent contaienr within the VFIODevice.
This simplifies the logic in vfio_viommu_preset() and
brings the benefice to hide the group specificity which
is useful for IOMMUFD migration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/common.c              | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8ca70dd821..bf12e40667 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -132,6 +132,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     QLIST_ENTRY(VFIODevice) container_next;
     struct VFIOGroup *group;
+    VFIOContainer *container;
     char *sysfsdev;
     char *name;
     DeviceState *dev;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ef9dc7c747..55f8a113ea 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -184,7 +184,7 @@ void vfio_unblock_multiple_devices_migration(void)
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    return vbasedev->group->container->space->as != &address_space_memory;
+    return vbasedev->container->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
@@ -2655,6 +2655,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     }
 
     container = group->container;
+    vbasedev->container = container;
     QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
 
     return ret;
@@ -2664,7 +2665,12 @@ void vfio_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
+    if (!vbasedev->container) {
+        return;
+    }
+
     QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->container = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
-- 
2.41.0


