Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0D79E186
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrb-0000qF-4F; Wed, 13 Sep 2023 04:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrZ-0000pS-8G
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrW-0004hL-Lt
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzgaRSFt8dpfPY2f/oMbZpdHY7BgU9HeHfEHDSJiSEU=;
 b=Gi3Q5v3ZxnIW8EmKpp7+a7B1VDHH1yM26YP+zB2vxB4d5e1Nm0vFsd+BkXP64wjRUiA9sR
 W/kpz87KZ5gD/KnLtr18/++LYGCci/mmAJ6yPKqZ0mFnGudQ+6NuPLaXSCXxhNj5K/mmRa
 KSSW3w+ZiG8KSFbAUc9Z+T0wUJpivdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-UyuzM6vnP0uC25hRYNQSQQ-1; Wed, 13 Sep 2023 04:04:33 -0400
X-MC-Unique: UyuzM6vnP0uC25hRYNQSQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9946581652A;
 Wed, 13 Sep 2023 08:04:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F7FD2026D68;
 Wed, 13 Sep 2023 08:04:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 01/12] memory: Let ReservedRegion use Range
Date: Wed, 13 Sep 2023 10:01:36 +0200
Message-ID: <20230913080423.523953-2-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A reserved region is a range tagged with a type. Let's directly use
the Range type in the prospect to reuse some of the library helpers
shipped with the Range type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---

v1 -> v2:
- Added Philippe and David's R-b
---
 include/exec/memory.h            | 4 ++--
 hw/core/qdev-properties-system.c | 9 ++++++---
 hw/virtio/virtio-iommu.c         | 6 +++---
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f8..184cb3a01b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -24,6 +24,7 @@
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
+#include "qemu/range.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
 #include "qemu/rcu.h"
@@ -79,8 +80,7 @@ extern unsigned int global_dirty_tracking;
 typedef struct MemoryRegionOps MemoryRegionOps;
 
 struct ReservedRegion {
-    hwaddr low;
-    hwaddr high;
+    Range range;
     unsigned type;
 };
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 6d5d43eda2..8d486eeefd 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -699,7 +699,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
     int rc;
 
     rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
-                  rr->low, rr->high, rr->type);
+                  range_lob(&rr->range), range_upb(&rr->range), rr->type);
     assert(rc < sizeof(buffer));
 
     visit_type_str(v, name, &p, errp);
@@ -711,6 +711,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     ReservedRegion *rr = object_field_prop_ptr(obj, prop);
     const char *endptr;
+    uint64_t lob, upb;
     char *str;
     int ret;
 
@@ -718,7 +719,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
+    ret = qemu_strtou64(str, &endptr, 16, &lob);
     if (ret) {
         error_setg(errp, "start address of '%s'"
                    " must be a hexadecimal integer", name);
@@ -728,7 +729,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
         goto separator_error;
     }
 
-    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
+    ret = qemu_strtou64(endptr + 1, &endptr, 16, &upb);
     if (ret) {
         error_setg(errp, "end address of '%s'"
                    " must be a hexadecimal integer", name);
@@ -738,6 +739,8 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
         goto separator_error;
     }
 
+    range_set_bounds(&rr->range, lob, upb);
+
     ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
     if (ret) {
         error_setg(errp, "type of '%s'"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index be51635895..e5e46e1b55 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -645,8 +645,8 @@ static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
         prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
         prop.head.length = cpu_to_le16(length);
         prop.subtype = subtype;
-        prop.start = cpu_to_le64(s->reserved_regions[i].low);
-        prop.end = cpu_to_le64(s->reserved_regions[i].high);
+        prop.start = cpu_to_le64(range_lob(&s->reserved_regions[i].range));
+        prop.end = cpu_to_le64(range_upb(&s->reserved_regions[i].range));
 
         memcpy(buf, &prop, size);
 
@@ -897,7 +897,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     for (i = 0; i < s->nb_reserved_regions; i++) {
         ReservedRegion *reg = &s->reserved_regions[i];
 
-        if (addr >= reg->low && addr <= reg->high) {
+        if (range_contains(&reg->range, addr)) {
             switch (reg->type) {
             case VIRTIO_IOMMU_RESV_MEM_T_MSI:
                 entry.perm = flag;
-- 
2.41.0


