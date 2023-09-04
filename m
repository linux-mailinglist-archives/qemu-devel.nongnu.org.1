Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D07912F0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4bz-00023B-DQ; Mon, 04 Sep 2023 04:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bw-0001zF-4f
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bt-0006Wq-Q5
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693814821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdJyzro/1PW1wpTBijWjAZMD3UPhZ9MGOFDP+xuEvXk=;
 b=Qbe4nkw+lvP6YcAG+qdRdQuC0JK2ietyHiN4sWV8BNjRNeIdlgi63ryFDfEQkk4clftK4b
 OlWpzt1WDKrNx0tVXQmepOaDuZnnuI6DXvzq8uU7jvMTZ4Z9gVvUle6ZW1WPEg8ae/+DRU
 qTyKdkQLAg2ocUpmdlVelgwJcv6OmOw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-fRGHcY_WMvqyLpc1b289WA-1; Mon, 04 Sep 2023 04:05:36 -0400
X-MC-Unique: fRGHcY_WMvqyLpc1b289WA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C953F3804519;
 Mon,  4 Sep 2023 08:05:35 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 271A740C6CCC;
 Mon,  4 Sep 2023 08:05:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH 13/13] vfio: Remove 64-bit IOVA address space assumption
Date: Mon,  4 Sep 2023 10:03:56 +0200
Message-ID: <20230904080451.424731-14-eric.auger@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
References: <20230904080451.424731-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
let's remove the assumption of 64b IOVA space when calling
vfio_host_win_add().

Make sure the vfio_find_hostwin() gets called after we get
a chance to call set_iova_regions and resize the IOMMU MR
according to the actual physical GAW.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
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


