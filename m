Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B17D7885
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnI3-0001gn-Pl; Wed, 25 Oct 2023 19:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI1-0001gA-LN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHz-0005Fz-H9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvamEoqM8Sl3gxDErfw6G2IaFKsYbroO1o7QRH3OnqE=;
 b=iaZfR0T+RluxRzSL5Qom9fZd5aq5U5JjC8lTbiyYcWsIoBSpTJFgbqyFAW5G11dZgwXz12
 ZNf7xDRrdH/oXprY6yIw+NcAU7NGHkD3K9MoDLVRmOzpYh0Hbmm4LeZjam6tq2vxmJqGwt
 TeqrkJwfXOakrPzomI8xLDVGGwjAZUU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-tjMMic8VPl2NhzgE1PZQ6g-1; Wed, 25 Oct 2023 19:27:49 -0400
X-MC-Unique: tjMMic8VPl2NhzgE1PZQ6g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7789f06778aso206682685a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276469; x=1698881269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mvamEoqM8Sl3gxDErfw6G2IaFKsYbroO1o7QRH3OnqE=;
 b=hOKaf0WGLR0hSg0GMeftg6EBK2Da9Uql/++rK+T6dCMhpZdWWD+qIF09WZqMY7sUC8
 yehy1B3nvoaI24kSOh25ye4sDudiWbgxqBfTUUZeYgz8tnGHsyIBob2/lGRzxC05RpCO
 taZ6VSrBaAVf8MQMaGy3tLWO8NOtex2rpQqF2KC8b6tTmFJTZ1hkagq+TYS5qEVVqZs9
 YFEmUBXZTXe71GFnvy1R56G89XGaQrarev4WYXMulYUxUR+jx/b4IQtNYtcbrBJP7OBT
 5UjOpjMc9Y3jZIiILgypWiiw0K3E7vChBUIYyNj6LH59lUZP/2d0CYMsBe7b6K9dH1li
 vWBQ==
X-Gm-Message-State: AOJu0YxNrb2cukHePoH50O9dwbhlpmI5dMKmzRDC1cGTK698vEHA8vgZ
 3JQ7jmnBqiLzlH4XYX3CubQh6E48R4w4aj3nuT2d8cJovcY8mgeueWp88cMtK3985ZbEwgQpbqi
 We53bvGlzn8rclawe/a9XG9+eh/+FXSD/V5j++0kciCzAeYDy7B/BKnwJ6od+pz9HGX04gbO8wo
 o=
X-Received: by 2002:a05:620a:450a:b0:76e:f90d:85d1 with SMTP id
 t10-20020a05620a450a00b0076ef90d85d1mr1571124qkp.26.1698276468680; 
 Wed, 25 Oct 2023 16:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu3HZFNREWMTlX1dHn4JJ91M3vPXO+EhZDQ6YO6cX3o8Uz6UaPiOpv6QPFihxfe2e598dZWQ==
X-Received: by 2002:a05:620a:450a:b0:76e:f90d:85d1 with SMTP id
 t10-20020a05620a450a00b0076ef90d85d1mr1571100qkp.26.1698276468083; 
 Wed, 25 Oct 2023 16:27:48 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 cx21-20020a05620a51d500b00773fe8971bbsm4598009qkb.90.2023.10.25.16.27.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] kvm: require KVM_CAP_IOEVENTFD and
 KVM_CAP_IOEVENTFD_ANY_LENGTH
Date: Thu, 26 Oct 2023 01:27:08 +0200
Message-ID: <20231025232718.89428-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

KVM_CAP_IOEVENTFD_ANY_LENGTH was added in Linux 4.4, released in 2016.
Assume that it is present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c     | 22 ++++++----------------
 accel/stubs/kvm-stub.c  |  2 --
 hw/misc/pci-testdev.c   |  3 +--
 hw/s390x/virtio-ccw.c   |  4 ----
 hw/virtio/vhost-user.c  |  7 +------
 hw/virtio/virtio-mmio.c |  4 ----
 hw/virtio/virtio-pci.c  | 19 ++++---------------
 include/sysemu/kvm.h    | 19 -------------------
 system/memory.c         | 16 ++++++----------
 9 files changed, 18 insertions(+), 78 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 05be687be1b..120051da649 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -90,7 +90,6 @@ bool kvm_kernel_irqchip;
 bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
 bool kvm_halt_in_kernel_allowed;
-bool kvm_eventfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
@@ -98,7 +97,6 @@ bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
-bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
@@ -110,6 +108,8 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
     KVM_CAP_INFO(INTERNAL_ERROR_DATA),
+    KVM_CAP_INFO(IOEVENTFD),
+    KVM_CAP_INFO(IOEVENTFD_ANY_LENGTH),
     KVM_CAP_LAST_INFO
 };
 
@@ -2547,18 +2547,12 @@ static int kvm_init(MachineState *ms)
     kvm_readonly_mem_allowed =
         (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
 
-    kvm_eventfds_allowed =
-        (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
-
     kvm_resamplefds_allowed =
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
 
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-    kvm_ioeventfd_any_length_allowed =
-        (kvm_check_extension(s, KVM_CAP_IOEVENTFD_ANY_LENGTH) > 0);
-
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
@@ -2595,19 +2589,15 @@ static int kvm_init(MachineState *ms)
         kvm_irqchip_create(s);
     }
 
-    if (kvm_eventfds_allowed) {
-        s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
-        s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
-    }
+    s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
+    s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
     s->memory_listener.listener.coalesced_io_add = kvm_coalesce_mmio_region;
     s->memory_listener.listener.coalesced_io_del = kvm_uncoalesce_mmio_region;
 
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0, "kvm-memory");
-    if (kvm_eventfds_allowed) {
-        memory_listener_register(&kvm_io_listener,
-                                 &address_space_io);
-    }
+    memory_listener_register(&kvm_io_listener,
+                             &address_space_io);
     memory_listener_register(&kvm_coalesced_pio_listener,
                              &address_space_io);
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b2d8885853f..1b37d9a302c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -17,14 +17,12 @@
 KVMState *kvm_state;
 bool kvm_kernel_irqchip;
 bool kvm_async_interrupts_allowed;
-bool kvm_eventfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
 bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
-bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 
 void kvm_flush_coalesced_mmio_buffer(void)
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 49303134e4c..acedd0f82bc 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -245,7 +245,6 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
     uint8_t *pci_conf;
     char *name;
     int r, i;
-    bool fastmmio = kvm_ioeventfd_any_length_enabled();
 
     pci_conf = pci_dev->config;
 
@@ -279,7 +278,7 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
         g_free(name);
         test->hdr->offset = cpu_to_le32(IOTEST_SIZE(i) + i * IOTEST_ACCESS_WIDTH);
         test->match_data = strcmp(IOTEST_TEST(i), "wildcard-eventfd");
-        if (fastmmio && IOTEST_IS_MEM(i) && !test->match_data) {
+        if (IOTEST_IS_MEM(i) && !test->match_data) {
             test->size = 0;
         } else {
             test->size = IOTEST_ACCESS_WIDTH;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 17c548b84ff..80453718a33 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -768,10 +768,6 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
         sch->cssid, sch->ssid, sch->schid, sch->devno,
         ccw_dev->devno.valid ? "user-configured" : "auto-configured");
 
-    if (kvm_enabled() && !kvm_eventfds_enabled()) {
-        dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
-    }
-
     /* fd-based ioevents can't be synchronized in record/replay */
     if (replay_mode != REPLAY_MODE_NONE) {
         dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b8a7b5542d9..7b42ae8aae8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -264,11 +264,6 @@ struct scrub_regions {
     int fd_idx;
 };
 
-static bool ioeventfd_enabled(void)
-{
-    return !kvm_enabled() || kvm_eventfds_enabled();
-}
-
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -1318,7 +1313,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.u64),
     };
 
-    if (ioeventfd_enabled() && file->fd > 0) {
+    if (file->fd > 0) {
         fds[fd_num++] = file->fd;
     } else {
         msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index c2c6d854750..22f15e1e02f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -761,10 +761,6 @@ static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
     qbus_init(&proxy->bus, sizeof(proxy->bus), TYPE_VIRTIO_MMIO_BUS, d, NULL);
     sysbus_init_irq(sbd, &proxy->irq);
 
-    if (!kvm_eventfds_enabled()) {
-        proxy->flags &= ~VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD;
-    }
-
     /* fd-based ioevents can't be synchronized in record/replay */
     if (replay_mode != REPLAY_MODE_NONE) {
         proxy->flags &= ~VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5f614334ec4..205dbf24fb1 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -332,7 +332,6 @@ static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
     VirtQueue *vq = virtio_get_queue(vdev, n);
     bool legacy = virtio_pci_legacy(proxy);
     bool modern = virtio_pci_modern(proxy);
-    bool fast_mmio = kvm_ioeventfd_any_length_enabled();
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
     MemoryRegion *modern_mr = &proxy->notify.mr;
     MemoryRegion *modern_notify_mr = &proxy->notify_pio.mr;
@@ -343,13 +342,8 @@ static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
 
     if (assign) {
         if (modern) {
-            if (fast_mmio) {
-                memory_region_add_eventfd(modern_mr, modern_addr, 0,
-                                          false, n, notifier);
-            } else {
-                memory_region_add_eventfd(modern_mr, modern_addr, 2,
-                                          false, n, notifier);
-            }
+            memory_region_add_eventfd(modern_mr, modern_addr, 0,
+                                      false, n, notifier);
             if (modern_pio) {
                 memory_region_add_eventfd(modern_notify_mr, 0, 2,
                                               true, n, notifier);
@@ -361,13 +355,8 @@ static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
         }
     } else {
         if (modern) {
-            if (fast_mmio) {
-                memory_region_del_eventfd(modern_mr, modern_addr, 0,
-                                          false, n, notifier);
-            } else {
-                memory_region_del_eventfd(modern_mr, modern_addr, 2,
-                                          false, n, notifier);
-            }
+            memory_region_del_eventfd(modern_mr, modern_addr, 0,
+                                      false, n, notifier);
             if (modern_pio) {
                 memory_region_del_eventfd(modern_notify_mr, 0, 2,
                                           true, n, notifier);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 8c5867ba8a4..31c03cc1932 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -36,13 +36,11 @@ extern bool kvm_kernel_irqchip;
 extern bool kvm_split_irqchip;
 extern bool kvm_async_interrupts_allowed;
 extern bool kvm_halt_in_kernel_allowed;
-extern bool kvm_eventfds_allowed;
 extern bool kvm_resamplefds_allowed;
 extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
-extern bool kvm_ioeventfd_any_length_allowed;
 extern bool kvm_msi_use_devid;
 
 #define kvm_enabled()           (kvm_allowed)
@@ -86,15 +84,6 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_halt_in_kernel() (kvm_halt_in_kernel_allowed)
 
-/**
- * kvm_eventfds_enabled:
- *
- * Returns: true if we can use eventfds to receive notifications
- * from a KVM CPU (ie the kernel supports eventds and we are running
- * with a configuration where it is meaningful to use them).
- */
-#define kvm_eventfds_enabled() (kvm_eventfds_allowed)
-
 /**
  * kvm_irqfds_enabled:
  *
@@ -147,12 +136,6 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_readonly_mem_enabled() (kvm_readonly_mem_allowed)
 
-/**
- * kvm_ioeventfd_any_length_enabled:
- * Returns: true if KVM allows any length io eventfd.
- */
-#define kvm_ioeventfd_any_length_enabled() (kvm_ioeventfd_any_length_allowed)
-
 /**
  * kvm_msi_devid_required:
  * Returns: true if KVM requires a device id to be provided while
@@ -168,13 +151,11 @@ extern bool kvm_msi_use_devid;
 #define kvm_async_interrupts_enabled() (false)
 #define kvm_halt_in_kernel() (false)
 #define kvm_irqfds_enabled() (false)
-#define kvm_eventfds_enabled() (false)
 #define kvm_resamplefds_enabled() (false)
 #define kvm_msi_via_irqfd_enabled() (false)
 #define kvm_gsi_routing_allowed() (false)
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
-#define kvm_ioeventfd_any_length_enabled() (false)
 #define kvm_msi_devid_required() (false)
 
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
diff --git a/system/memory.c b/system/memory.c
index a800fbc9e59..4928f2525de 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1535,7 +1535,12 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
-    if ((!kvm_eventfds_enabled()) &&
+    /*
+     * FIXME: it's not clear why under KVM the write would be processed
+     * directly, instead of going through eventfd.  This probably should
+     * test "tcg_enabled() || qtest_enabled()", or should just go away.
+     */
+    if (!kvm_enabled() &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
         return MEMTX_OK;
     }
@@ -2550,8 +2555,6 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
-static bool userspace_eventfd_warning;
-
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
@@ -2568,13 +2571,6 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     };
     unsigned i;
 
-    if (kvm_enabled() && (!(kvm_eventfds_enabled() ||
-                            userspace_eventfd_warning))) {
-        userspace_eventfd_warning = true;
-        error_report("Using eventfd without MMIO binding in KVM. "
-                     "Suboptimal performance expected");
-    }
-
     if (size) {
         adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
     }
-- 
2.41.0


