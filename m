Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D779E173
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKs4-0001Aa-0Q; Wed, 13 Sep 2023 04:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrz-00018R-8q
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrw-00050w-SN
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTDGgmVQIETGydo7EfxtZXhZg5y0CSCWuHRrtPE8L58=;
 b=SbJigfh04eGibSU28NYKal9TnCFY9I7hkkOq+4s9z9zv8+EQO5t5Tc1l4XCmiznUHSRZrh
 q1GhkL2ePJWggcwY0VKGMYbdCCPM831BDyGzWbHuZeoshLkXlcoNU5S/CdMpNHy+xiJmCU
 vCgIU0UAVe+bq6kC57SBV+3GKNCuCJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-E-ynGMhTOm67fU89LjBXRg-1; Wed, 13 Sep 2023 04:05:02 -0400
X-MC-Unique: E-ynGMhTOm67fU89LjBXRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD7F98A12AF;
 Wed, 13 Sep 2023 08:05:01 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2A12026D68;
 Wed, 13 Sep 2023 08:04:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 12/12] vfio: Remove 64-bit IOVA address space assumption
Date: Wed, 13 Sep 2023 10:01:47 +0200
Message-ID: <20230913080423.523953-13-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now we retrieve the usable IOVA ranges from the host,
we now the physical IOMMU aperture and we can remove
the assumption of 64b IOVA space when calling
vfio_host_win_add().

This works fine in general but in case of an IOMMU memory
region this becomes more tricky. For instance the virtio-iommu
MR has a 64b aperture by default. If the physical IOMMU has a
smaller aperture (typically the case for VTD), this means we
would need to resize the IOMMU MR when this latter is linked
to a container. However this happens on vfio_listener_region_add()
when calling the IOMMU MR set_iova_ranges() callback and this
would mean we would have a recursive call the
vfio_listener_region_add(). This looks like a wrong usage of
the memory API causing duplicate IOMMU MR notifier registration
for instance.

Until we find a better solution, make sure the vfio_find_hostwin()
is not called anymore for IOMMU region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

I have not found any working solution to the IOMMU MR resizing.
So I can remove this patch or remove the check for IOMMU MR. Maybe
this is an issue which can be handled separately?
---
 hw/vfio/common.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 26da38de05..40cac1ca91 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1112,13 +1112,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
 #endif
     }
 
-    hostwin = vfio_find_hostwin(container, iova, end);
-    if (!hostwin) {
-        error_setg(&err, "Container %p can't map guest IOVA region"
-                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
-        goto fail;
-    }
-
     memory_region_ref(section->mr);
 
     if (memory_region_is_iommu(section->mr)) {
@@ -1177,6 +1170,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
+    hostwin = vfio_find_hostwin(container, iova, end);
+    if (!hostwin) {
+        error_setg(&err, "Container %p can't map guest IOVA region"
+                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
+        goto fail;
+    }
+
+
     /* Here we assume that memory_region_is_ram(section->mr)==true */
 
     /*
@@ -2594,12 +2595,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
 
-        /*
-         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
-         * information to get the actual window extent rather than assume
-         * a 64-bit IOVA address space.
-         */
-        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
+        g_assert(container->nr_iovas);
+        vfio_host_win_add(container, 0,
+                          container->iova_ranges[container->nr_iovas - 1].end,
+                          container->pgsizes);
 
         break;
     }
-- 
2.41.0


