Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893C847BDF
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Feb 2024 22:55:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1U3-0008DJ-Dv; Fri, 02 Feb 2024 16:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1U1-0008Ct-1v
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1Tz-0004sz-9k
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjO81Bw6iEHfFtOoTrtiZ4pC6BhmP65sUHBmbECDG38=;
 b=Adoz6RpliJRzssFDKh/P62V0+5muIekqtG15RN0VhFPwOUCEqHs8eItmTgoE4Fq+h76JDJ
 Oi+N8cD+dCVU7W53T8kmXHqQBxSqHCrTC3zmo3YKR/bZcRlxgLFVNfAXRIuNfk5RNTOtrJ
 56PbdCH3dbjG/irMFuYXtLFWcAEzMsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-fUP7D4M9NUSUuujoq_jgNQ-1; Fri, 02 Feb 2024 16:53:55 -0500
X-MC-Unique: fUP7D4M9NUSUuujoq_jgNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13F59800074;
 Fri,  2 Feb 2024 21:53:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 727D52166B31;
 Fri,  2 Feb 2024 21:53:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 06/15] libvhost-user: Factor out adding a memory region
Date: Fri,  2 Feb 2024 22:53:23 +0100
Message-ID: <20240202215332.118728-7-david@redhat.com>
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's factor it out, reducing quite some code duplication and perparing
for further changes.

If we fail to mmap a region and panic, we now simply don't add that
(broken) region.

Note that we now increment dev->nregions as we are successfully
adding memory regions, and don't increment dev->nregions if anything went
wrong.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 168 ++++++++--------------
 1 file changed, 60 insertions(+), 108 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index d9e2214ad2..a2baefe84b 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -256,6 +256,61 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static void
+_vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
+{
+    int prot = PROT_READ | PROT_WRITE;
+    VuDevRegion *r;
+    void *mmap_addr;
+
+    DPRINT("Adding region %d\n", dev->nregions);
+    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+           msg_region->guest_phys_addr);
+    DPRINT("    memory_size:     0x%016"PRIx64"\n",
+           msg_region->memory_size);
+    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+           msg_region->userspace_addr);
+    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+           msg_region->mmap_offset);
+
+    if (dev->postcopy_listening) {
+        /*
+         * In postcopy we're using PROT_NONE here to catch anyone
+         * accessing it before we userfault
+         */
+        prot = PROT_NONE;
+    }
+
+    /*
+     * We don't use offset argument of mmap() since the mapped address has
+     * to be page aligned, and we use huge pages.
+     */
+    mmap_addr = mmap(0, msg_region->memory_size + msg_region->mmap_offset,
+                     prot, MAP_SHARED | MAP_NORESERVE, fd, 0);
+    if (mmap_addr == MAP_FAILED) {
+        vu_panic(dev, "region mmap error: %s", strerror(errno));
+        return;
+    }
+    DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+           (uint64_t)(uintptr_t)mmap_addr);
+
+    r = &dev->regions[dev->nregions];
+    r->gpa = msg_region->guest_phys_addr;
+    r->size = msg_region->memory_size;
+    r->qva = msg_region->userspace_addr;
+    r->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
+    r->mmap_offset = msg_region->mmap_offset;
+    dev->nregions++;
+
+    if (dev->postcopy_listening) {
+        /*
+         * Return the address to QEMU so that it can translate the ufd
+         * fault addresses back.
+         */
+        msg_region->userspace_addr = r->mmap_addr + r->mmap_offset;
+    }
+}
+
 static void
 vmsg_close_fds(VhostUserMsg *vmsg)
 {
@@ -727,10 +782,7 @@ generate_faults(VuDev *dev) {
 static bool
 vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     int i;
-    bool track_ramblocks = dev->postcopy_listening;
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
-    VuDevRegion *dev_region = &dev->regions[dev->nregions];
-    void *mmap_addr;
 
     if (vmsg->fd_num != 1) {
         vmsg_close_fds(vmsg);
@@ -760,69 +812,20 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
      * we know all the postcopy client bases have been received, and we
      * should start generating faults.
      */
-    if (track_ramblocks &&
+    if (dev->postcopy_listening &&
         vmsg->size == sizeof(vmsg->payload.u64) &&
         vmsg->payload.u64 == 0) {
         (void)generate_faults(dev);
         return false;
     }
 
-    DPRINT("Adding region: %u\n", dev->nregions);
-    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
-           msg_region->guest_phys_addr);
-    DPRINT("    memory_size:     0x%016"PRIx64"\n",
-           msg_region->memory_size);
-    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
-           msg_region->userspace_addr);
-    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
-           msg_region->mmap_offset);
-
-    dev_region->gpa = msg_region->guest_phys_addr;
-    dev_region->size = msg_region->memory_size;
-    dev_region->qva = msg_region->userspace_addr;
-    dev_region->mmap_offset = msg_region->mmap_offset;
-
-    /*
-     * We don't use offset argument of mmap() since the
-     * mapped address has to be page aligned, and we use huge
-     * pages.
-     */
-    if (track_ramblocks) {
-        /*
-         * In postcopy we're using PROT_NONE here to catch anyone
-         * accessing it before we userfault.
-         */
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_NONE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[0], 0);
-    } else {
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[0], 0);
-    }
-
-    if (mmap_addr == MAP_FAILED) {
-        vu_panic(dev, "region mmap error: %s", strerror(errno));
-    } else {
-        dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-        DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
-               dev_region->mmap_addr);
-    }
-
+    _vu_add_mem_reg(dev, msg_region, vmsg->fds[0]);
     close(vmsg->fds[0]);
 
-    if (track_ramblocks) {
-        /*
-         * Return the address to QEMU so that it can translate the ufd
-         * fault addresses back.
-         */
-        msg_region->userspace_addr = dev_region->mmap_addr +
-                                     dev_region->mmap_offset;
-
+    if (dev->postcopy_listening) {
         /* Send the message back to qemu with the addresses filled in. */
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
-        dev->nregions++;
         return true;
     } else {
         for (i = 0; i < dev->max_queues; i++) {
@@ -835,7 +838,6 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         }
 
         DPRINT("Successfully added new region\n");
-        dev->nregions++;
         return false;
     }
 }
@@ -940,63 +942,13 @@ static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     VhostUserMemory m = vmsg->payload.memory, *memory = &m;
-    int prot = PROT_READ | PROT_WRITE;
     unsigned int i;
 
-    if (dev->postcopy_listening) {
-        /*
-         * In postcopy we're using PROT_NONE here to catch anyone
-         * accessing it before we userfault
-         */
-        prot = PROT_NONE;
-    }
-
     vu_remove_all_mem_regs(dev);
-    dev->nregions = memory->nregions;
 
     DPRINT("Nregions: %u\n", memory->nregions);
-    for (i = 0; i < dev->nregions; i++) {
-        void *mmap_addr;
-        VhostUserMemoryRegion *msg_region = &memory->regions[i];
-        VuDevRegion *dev_region = &dev->regions[i];
-
-        DPRINT("Region %d\n", i);
-        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
-               msg_region->guest_phys_addr);
-        DPRINT("    memory_size:     0x%016"PRIx64"\n",
-               msg_region->memory_size);
-        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
-               msg_region->userspace_addr);
-        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
-               msg_region->mmap_offset);
-
-        dev_region->gpa = msg_region->guest_phys_addr;
-        dev_region->size = msg_region->memory_size;
-        dev_region->qva = msg_region->userspace_addr;
-        dev_region->mmap_offset = msg_region->mmap_offset;
-
-        /* We don't use offset argument of mmap() since the
-         * mapped address has to be page aligned, and we use huge
-         * pages.  */
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         prot, MAP_SHARED | MAP_NORESERVE, vmsg->fds[i], 0);
-
-        if (mmap_addr == MAP_FAILED) {
-            vu_panic(dev, "region mmap error: %s", strerror(errno));
-        } else {
-            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
-                   dev_region->mmap_addr);
-        }
-
-        if (dev->postcopy_listening) {
-            /*
-             * Return the address to QEMU so that it can translate the ufd
-             * fault addresses back.
-             */
-            msg_region->userspace_addr = dev_region->mmap_addr +
-                                         dev_region->mmap_offset;
-        }
+    for (i = 0; i < memory->nregions; i++) {
+        _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
         close(vmsg->fds[i]);
     }
 
-- 
2.43.0


