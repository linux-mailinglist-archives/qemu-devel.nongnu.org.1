Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D0854C7D
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Feb 2024 16:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH17-0007rR-3B; Wed, 14 Feb 2024 10:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH12-0007qz-Kf
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH10-0000PQ-SD
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XvHRrSZGz0C59Zu95hBu5n9kentS+2TwgEY3I45/xk=;
 b=AD5FKGKahUv1pmlXHSf08zkkLhL7DYZvhIIz3mr1QNjOvVNgDFx6cj/XRcpvFZV081z+fK
 ZL+zoWPTSesFuEaM5u5G8ts7U/q/2KemKUYHRlPs48SV6/sSzhuBsv0h3xyPjxJspljQm3
 zXrPIrV3O8N2A1rf+gCthD/cXsnGe4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-_3p6Hmf6OI-LMlamvCbY4g-1; Wed, 14 Feb 2024 10:17:34 -0500
X-MC-Unique: _3p6Hmf6OI-LMlamvCbY4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20724185A783;
 Wed, 14 Feb 2024 15:17:34 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55A7E1C066AA;
 Wed, 14 Feb 2024 15:17:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PATCH v2 09/14] libvhost-user: Factor out search for memory region
 by GPA and simplify
Date: Wed, 14 Feb 2024 16:16:56 +0100
Message-ID: <20240214151701.29906-10-david@redhat.com>
In-Reply-To: <20240214151701.29906-1-david@redhat.com>
References: <20240214151701.29906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Memory regions cannot overlap, and if we ever hit that case something
would be really flawed.

For example, when vhost code in QEMU decides to increase the size of memory
regions to cover full huge pages, it makes sure to never create overlaps,
and if there would be overlaps, it would bail out.

QEMU commits 48d7c9757749 ("vhost: Merge sections added to temporary
list"), c1ece84e7c93 ("vhost: Huge page align and merge") and
e7b94a84b6cb ("vhost: Allow adjoining regions") added and clarified that
handling and how overlaps are impossible.

Consequently, each GPA can belong to at most one memory region, and
everything else doesn't make sense. Let's factor out our search to prepare
for further changes.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 79 +++++++++++++----------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 7f29e01c30..d72f25396d 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -195,30 +195,47 @@ vu_panic(VuDev *dev, const char *msg, ...)
      */
 }
 
+/* Search for a memory region that covers this guest physical address. */
+static VuDevRegion *
+vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
+{
+    unsigned int i;
+
+    /*
+     * Memory regions cannot overlap in guest physical address space. Each
+     * GPA belongs to exactly one memory region, so there can only be one
+     * match.
+     */
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *cur = &dev->regions[i];
+
+        if (guest_addr >= cur->gpa && guest_addr < cur->gpa + cur->size) {
+            return cur;
+        }
+    }
+    return NULL;
+}
+
 /* Translate guest physical address to our virtual address.  */
 void *
 vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr)
 {
-    unsigned int i;
+    VuDevRegion *r;
 
     if (*plen == 0) {
         return NULL;
     }
 
-    /* Find matching memory region.  */
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *r = &dev->regions[i];
-
-        if ((guest_addr >= r->gpa) && (guest_addr < (r->gpa + r->size))) {
-            if ((guest_addr + *plen) > (r->gpa + r->size)) {
-                *plen = r->gpa + r->size - guest_addr;
-            }
-            return (void *)(uintptr_t)
-                guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
-        }
+    r = vu_gpa_to_mem_region(dev, guest_addr);
+    if (!r) {
+        return NULL;
     }
 
-    return NULL;
+    if ((guest_addr + *plen) > (r->gpa + r->size)) {
+        *plen = r->gpa + r->size - guest_addr;
+    }
+    return (void *)(uintptr_t)guest_addr - r->gpa + r->mmap_addr +
+           r->mmap_offset;
 }
 
 /* Translate qemu virtual address to our virtual address.  */
@@ -854,8 +871,8 @@ static inline bool reg_equal(VuDevRegion *vudev_reg,
 static bool
 vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
-    unsigned int i;
-    bool found = false;
+    unsigned int idx;
+    VuDevRegion *r;
 
     if (vmsg->fd_num > 1) {
         vmsg_close_fds(vmsg);
@@ -882,28 +899,22 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     DPRINT("    mmap_offset      0x%016"PRIx64"\n",
            msg_region->mmap_offset);
 
-    for (i = 0; i < dev->nregions; i++) {
-        if (reg_equal(&dev->regions[i], msg_region)) {
-            VuDevRegion *r = &dev->regions[i];
-
-            munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
-
-            /* Shift all affected entries by 1 to close the hole at index. */
-            memmove(dev->regions + i, dev->regions + i + 1,
-                    sizeof(VuDevRegion) * (dev->nregions - i - 1));
-            DPRINT("Successfully removed a region\n");
-            dev->nregions--;
-            i--;
-
-            found = true;
-            break;
-        }
-    }
-
-    if (!found) {
+    r = vu_gpa_to_mem_region(dev, msg_region->guest_phys_addr);
+    if (!r || !reg_equal(r, msg_region)) {
+        vmsg_close_fds(vmsg);
         vu_panic(dev, "Specified region not found\n");
+        return false;
     }
 
+    munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
+
+    idx = r - dev->regions;
+    assert(idx < dev->nregions);
+    /* Shift all affected entries by 1 to close the hole. */
+    memmove(r, r + 1, sizeof(VuDevRegion) * (dev->nregions - idx - 1));
+    DPRINT("Successfully removed a region\n");
+    dev->nregions--;
+
     vmsg_close_fds(vmsg);
 
     return false;
-- 
2.43.0


