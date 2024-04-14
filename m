Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA978A26A1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Apr 2024 08:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvAOP-0002UA-G7; Fri, 12 Apr 2024 02:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rvAON-0002Ty-A1
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rvAOK-000519-TN
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712903284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2d7ReGeZaAGrK6QeKjsa3T/domBjtFnuH/9lxJAcAhg=;
 b=g9ptJ3JujQA5IeaFh00e+4qQkCMaUNNr1zyzjQTpOya54bmANXHrG9iSY9G51O2ybo5yUm
 61zXKBXQTzKflfiE7kjRtYjhgxgXCJI9djWCNm2UpZ/f68toYH9ZxLnWwO2k78QGbYBj7v
 G4MbGfvjEjyURI+AtP0ygKoiSrztPgE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-fxVH2dcePFewjgAlI9QsRQ-1; Fri,
 12 Apr 2024 02:28:00 -0400
X-MC-Unique: fxVH2dcePFewjgAlI9QsRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E806D28EC115;
 Fri, 12 Apr 2024 06:27:59 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 910332026D06;
 Fri, 12 Apr 2024 06:27:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v6] virtio-pci: Fix the crash that the vector was used after
 released.
Date: Fri, 12 Apr 2024 14:26:55 +0800
Message-ID: <20240412062750.475180-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During the booting process of the non-standard image, the behavior of the
called function in qemu is as follows:

1. vhost_net_stop() was triggered by guest image. This will call the function
virtio_pci_set_guest_notifiers() with assgin= false,
virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0

2. virtio_reset() was triggered, this will set configure vector to VIRTIO_NO_VECTOR

3.vhost_net_start() was called (at this time, the configure vector is
still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() with
assgin=true, so the irqfd for vector 0 is still not "init" during this process

4. The system continues to boot and sets the vector back to 0. After that
msix_fire_vector_notifier() was triggered to unmask the vector 0 and  meet the crash

To fix the issue, we need to support changing the vector after VIRTIO_CONFIG_S_DRIVER_OK is set.

(gdb) bt
0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
    at pthread_kill.c:44
1  0x00007fc87148ec53 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at pthread_kill.c:78
2  0x00007fc87143e956 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
4  0x00007fc87142871b in __assert_fail_base
    (fmt=0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x5606413efd53 "ret == 0", file=0x5606413ef87d "../accel/kvm/kvm-all.c", line=1837, function=<optimized out>) at assert.c:92
5  0x00007fc871437536 in __GI___assert_fail
    (assertion=0x5606413efd53 "ret == 0", file=0x5606413ef87d "../accel/kvm/kvm-all.c", line=1837, function=0x5606413f06f0 <__PRETTY_FUNCTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=0x560642cae1f0) at ../accel/kvm/kvm-all.c:1837
7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
    (proxy=0x560643c65f00, queue_no=4294967295, vector=0, msg=..., n=0x560643c6e4c8)
    at ../hw/virtio/virtio-pci.c:1005
8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=0x560643c65f00, vector=0, msg=...)
    at ../hw/virtio/virtio-pci.c:1070
9  0x0000560640bc402e in msix_fire_vector_notifier (dev=0x560643c65f00, vector=0, is_masked=false)
    at ../hw/pci/msix.c:120
10 0x0000560640bc40f1 in msix_handle_mask_update (dev=0x560643c65f00, vector=0, was_masked=true)
    at ../hw/pci/msix.c:140
11 0x0000560640bc4503 in msix_table_mmio_write (opaque=0x560643c65f00, addr=12, val=0, size=4)
    at ../hw/pci/msix.c:231
12 0x0000560640f26d83 in memory_region_write_accessor
    (mr=0x560643c66540, addr=12, value=0x7fc86b7bc628, size=4, shift=0, mask=4294967295, attrs=...)
    at ../system/memory.c:497
13 0x0000560640f270a6 in access_with_adjusted_size

     (addr=12, value=0x7fc86b7bc628, size=4, access_size_min=1, access_size_max=4, access_fn=0x560640f26c8d <memory_region_write_accessor>, mr=0x560643c66540, attrs=...) at ../system/memory.c:573
14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=0x560643c66540, addr=12, data=0, op=MO_32, attrs=...)
    at ../system/memory.c:1521
15 0x0000560640f37bac in flatview_write_continue
    (fv=0x7fc65805e0b0, addr=4273803276, attrs=..., ptr=0x7fc871e9c028, len=4, addr1=12, l=4, mr=0x560643c66540)
    at ../system/physmem.c:2714
16 0x0000560640f37d0f in flatview_write
    (fv=0x7fc65805e0b0, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4) at ../system/physmem.c:2756
17 0x0000560640f380bf in address_space_write
    (as=0x560642161ae0 <address_space_memory>, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4)
    at ../system/physmem.c:2863
18 0x0000560640f3812c in address_space_rw
    (as=0x560642161ae0 <address_space_memory>, addr=4273803276, attrs=..., buf=0x7fc871e9c028, len=4, is_write=true) at ../system/physmem.c:2873
--Type <RET> for more, q to quit, c to continue without paging--
19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=0x560642f205e0) at ../accel/kvm/kvm-all.c:2915
20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=0x560642f205e0) at ../accel/kvm/kvm-accel-ops.c:51
21 0x00005606411949f4 in qemu_thread_start (args=0x560642f292b0) at ../util/qemu-thread-posix.c:541
22 0x00007fc87148cdcd in start_thread (arg=<optimized out>) at pthread_create.c:442
23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
(gdb)

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Cc: qemu-stable@nongnu.org

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 43 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..f83ec92990 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1423,6 +1423,36 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
 
     return offset;
 }
+static void virtio_pci_set_and_change_vector(VirtIODevice *vdev,
+                                             VirtIOPCIProxy *proxy,
+                                             int queue_no, uint16_t old_vector,
+                                             uint16_t new_vector)
+{
+    /*
+     * If the device uses irqfd and the vector changes after DRIVER_OK is
+     * set, we need to release the old vector and set up the new one.
+     * others just need to set the new vector to device
+     */
+    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled())) {
+        if (old_vector != VIRTIO_NO_VECTOR) {
+            kvm_virtio_pci_vector_release_one(proxy, queue_no);
+        }
+    }
+    /*set the new vector to device*/
+    if (queue_no == VIRTIO_CONFIG_IRQ_IDX) {
+        vdev->config_vector = new_vector;
+    } else {
+        virtio_queue_set_vector(vdev, queue_no, new_vector);
+    }
+    /* if the new vector chanegd need to set it up */
+    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled())) {
+        if (new_vector != VIRTIO_NO_VECTOR) {
+            kvm_virtio_pci_vector_use_one(proxy, queue_no);
+        }
+    }
+}
 
 int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
                            uint8_t bar, uint64_t offset, uint64_t length,
@@ -1570,7 +1600,12 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         } else {
             val = VIRTIO_NO_VECTOR;
         }
-        vdev->config_vector = val;
+        vector = vdev->config_vector;
+        /*check if need to change the vector*/
+        if (val != vector) {
+            virtio_pci_set_and_change_vector(vdev, proxy, VIRTIO_CONFIG_IRQ_IDX,
+                                             vector, val);
+        }
         break;
     case VIRTIO_PCI_COMMON_STATUS:
         if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
@@ -1610,7 +1645,11 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         } else {
             val = VIRTIO_NO_VECTOR;
         }
-        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
+        /*check if need to change the vector*/
+        if (val != vector) {
+            virtio_pci_set_and_change_vector(vdev, proxy, vdev->queue_sel,
+                                             vector, val);
+        }
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
         if (val == 1) {
-- 
2.43.0


