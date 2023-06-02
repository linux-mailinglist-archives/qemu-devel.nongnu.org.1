Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900671F99E
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 07:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4xAU-0006aq-3u; Fri, 02 Jun 2023 01:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1q4vPs-0007nU-1t
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 23:25:28 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1q4vPo-0006Sq-Gn
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 23:25:27 -0400
X-UUID: 85d8ca73307340f58525e757699073ce-20230602
X-CID-CACHE: Type:Local,Time:202306021119+08,HitQuantity:1
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GE969F26
X-CID-O-INFO: VERSION:1.1.22, REQID:d9480df9-8fb8-4e85-bdba-e61d56085852, IP:5,
 U
 RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,A
 CTION:release,TS:-60
X-CID-INFO: VERSION:1.1.22, REQID:d9480df9-8fb8-4e85-bdba-e61d56085852, IP:5,
 URL
 :0,TC:0,Content:-25,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,AC
 TION:release,TS:-60
X-CID-META: VersionHash:120426c, CLOUDID:89e2543d-7aa7-41f3-a6bd-0433bee822f3,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:nil,Content:0,EDM
 :1,IP:-2,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 85d8ca73307340f58525e757699073ce-20230602
X-User: zhanghao1@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <zhanghao1@kylinos.cn>) (Generic MTA)
 with ESMTP id 49649800; Fri, 02 Jun 2023 11:25:17 +0800
From: zhanghao1 <zhanghao1@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhanghao1 <zhanghao1@kylinos.cn>
Subject: [PATCH 1/1] Add a new virtio pci device named
 virtio-vcpu-stall-watchdog-pci
Date: Fri,  2 Jun 2023 11:22:32 +0800
Message-Id: <20230602032231.84610-2-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602032231.84610-1-zhanghao1@kylinos.cn>
References: <20230602032231.84610-1-zhanghao1@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhanghao1@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Jun 2023 01:17:30 -0400
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

Each vcpu creates a corresponding timer task. The watchdog
is driven by a timer according to a certain period. Each time
the timer expires, the counter is decremented. When the counter
is "0", the watchdog considers the vcpu to be stalling and resets
the VM. To avoid watchdog expiration, the guest kernel driver
needs to periodically send a pet event to update the counter.

Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
---
 hw/virtio/Kconfig                             |   5 +
 hw/virtio/meson.build                         |   2 +
 hw/virtio/virtio-vcpu-stall-watchdog-pci.c    |  89 +++++++
 hw/virtio/virtio-vcpu-stall-watchdog.c        | 240 ++++++++++++++++++
 .../hw/virtio/virtio-vcpu-stall-watchdog.h    |  45 ++++
 5 files changed, 381 insertions(+)
 create mode 100644 hw/virtio/virtio-vcpu-stall-watchdog-pci.c
 create mode 100644 hw/virtio/virtio-vcpu-stall-watchdog.c
 create mode 100644 include/hw/virtio/virtio-vcpu-stall-watchdog.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 89e9e426d8..2247e382e4 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -90,3 +90,8 @@ config VHOST_VDPA_DEV
     bool
     default y
     depends on VIRTIO && VHOST_VDPA && LINUX
+
+config VIRTIO_VCPU_STALL_WATCHDOG
+    bool
+    default y
+    depends on VIRTIO
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index bdec78bfc6..b93246e2db 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -33,6 +33,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
+specific_virtio_ss.add(when: 'CONFIG_VIRTIO_VCPU_STALL_WATCHDOG', if_true: files('virtio-vcpu-stall-watchdog.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
@@ -59,6 +60,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_VCPU_STALL_WATCHDOG', if_true: files('virtio-vcpu-stall-watchdog-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
diff --git a/hw/virtio/virtio-vcpu-stall-watchdog-pci.c b/hw/virtio/virtio-vcpu-stall-watchdog-pci.c
new file mode 100644
index 0000000000..7540d488e3
--- /dev/null
+++ b/hw/virtio/virtio-vcpu-stall-watchdog-pci.c
@@ -0,0 +1,89 @@
+/*
+ * Virtio cpu stall watchdog PCI Bindings
+ *
+ * Copyright 2023 Kylin, Inc.
+ * Copyright 2023 Hao Zhang <zhanghao1@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-vcpu-stall-watchdog.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+
+typedef struct VirtIOCpuStallWatchdogPCI VirtIOCpuStallWatchdogPCI;
+
+/*
+ * virtio-cpu-stall-watchdog-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_CPU_STALL_WATCHDOG_PCI "virtio-vcpu-stall-watchdog-pci-base"
+#define VIRTIO_CPU_STALL_WATCHDOG_PCI(obj) \
+        OBJECT_CHECK(VirtIOCpuStallWatchdogPCI, (obj), TYPE_VIRTIO_CPU_STALL_WATCHDOG_PCI)
+
+struct VirtIOCpuStallWatchdogPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOCPUSTALLWATCHDOG vdev;
+};
+
+static Property vcpu_stall_watchdog_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_vcpu_stall_watchdog_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOCpuStallWatchdogPCI *dev = VIRTIO_CPU_STALL_WATCHDOG_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 1;
+    }
+
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
+        return;
+    }
+}
+
+static void virtio_vcpu_stall_watchdog_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_vcpu_stall_watchdog_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, vcpu_stall_watchdog_properties);
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_vcpu_stall_watchdog_init(Object *obj)
+{
+    VirtIOCpuStallWatchdogPCI *dev = VIRTIO_CPU_STALL_WATCHDOG_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_CPU_STALL_WATCHDOG);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_vcpu_stall_watchdog_pci_info = {
+    .base_name             = TYPE_VIRTIO_CPU_STALL_WATCHDOG_PCI,
+    .generic_name          = "virtio-vcpu-stall-watchdog-pci",
+    .transitional_name     = "virtio-vcpu-stall-watchdog-pci-transitional",
+    .non_transitional_name = "virtio-vcpu-stall-watchdog-pci-non-transitional",
+    .instance_size = sizeof(VirtIOCpuStallWatchdogPCI),
+    .instance_init = virtio_vcpu_stall_watchdog_init,
+    .class_init    = virtio_vcpu_stall_watchdog_pci_class_init,
+};
+
+static void virtio_vcpu_stall_watchdog_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_vcpu_stall_watchdog_pci_info);
+}
+
+type_init(virtio_vcpu_stall_watchdog_pci_register)
diff --git a/hw/virtio/virtio-vcpu-stall-watchdog.c b/hw/virtio/virtio-vcpu-stall-watchdog.c
new file mode 100644
index 0000000000..ea7dbd4810
--- /dev/null
+++ b/hw/virtio/virtio-vcpu-stall-watchdog.c
@@ -0,0 +1,240 @@
+/*
+ * A virtio device implementing a vcpu stall watchdog.
+ *
+ * Copyright 2023 Kylin, Inc.
+ * Copyright 2023 zhanghao1 <zhanghao1@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/iov.h"
+#include "qemu/module.h"
+#include "qemu/bswap.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-vcpu-stall-watchdog.h"
+#include "qom/object_interfaces.h"
+#include "trace.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/boards.h"
+#include "sysemu/cpus.h"
+#include "sysemu/runstate.h"
+
+#define MAX_PATH 1024
+
+#define VCPU_STALL_DEFAULT_CLOCK_HZ (5)
+#define VCPU_STALL_DEFAULT_TIMEOUT_SEC (8)
+#define MSEC_PER_SEC 1000
+#define PROCSTAT_UTIME_INDX 13
+#define PROCSTAT_GUEST_TIME_INDX 42
+
+struct vcpu_stall_info {
+    uint32_t cpu_id;
+    bool is_initialized;
+    uint32_t ticks;
+    uint64_t not_running_last_timestamp;
+};
+
+static VirtIOCPUSTALLWATCHDOG *vwdt;
+
+static bool is_guest_ready(VirtIOCPUSTALLWATCHDOG *vwdt)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vwdt);
+    if (virtio_queue_ready(vwdt->vq)
+        && (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+        return true;
+    }
+    return false;
+}
+
+/* receive data from guest */
+static void receive_vcpu_info(void *opaque, void *buf, size_t size)
+{
+    VirtIOCPUSTALLWATCHDOG *vwdt = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vwdt);
+    VirtQueueElement *elem;
+    size_t len;
+
+    if (!is_guest_ready(vwdt)) {
+        return;
+    }
+
+    elem = virtqueue_pop(vwdt->vq, sizeof(VirtQueueElement));
+    if (!elem) {
+        return;
+    }
+
+    len = iov_size(elem->out_sg, elem->out_num);
+
+    len = iov_to_buf(elem->out_sg, elem->out_num,
+                     0, buf, len);
+
+    int cpu = virtio_ldl_p(vdev, &((struct vcpu_stall_info *)buf)->cpu_id);
+    DPRINTF("read to buf:%lu cpu_id:%u is_initialized:%d ticks:%u\n", len, cpu,
+                     ((struct vcpu_stall_info *)buf)->is_initialized,
+                     ((struct vcpu_stall_info *)buf)->ticks);
+
+    virtqueue_push(vwdt->vq, elem, len);
+    g_free(elem);
+    virtio_notify(vdev, vwdt->vq);
+}
+
+static void vcpu_stall_check(void *opaque)
+{
+    int *cpu_id = (int *)opaque;
+
+    struct vcpu_stall_info *priv = vwdt->recv_buf[*cpu_id];
+
+    DPRINTF("start to vcpu stall check, cpu:%d ticks:%u\n",
+                *cpu_id, priv->ticks);
+    priv->ticks -= 1;
+
+    if (priv->ticks <= 0) {
+        /* cpu is stall, reset vm */
+        qemu_log("CPU:%d is stall, need to reset vm\n", *cpu_id);
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+
+    int64_t expire_timer = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    expire_timer += (MSEC_PER_SEC / VCPU_STALL_DEFAULT_CLOCK_HZ);
+    timer_mod(vwdt->timer[*cpu_id], expire_timer);
+}
+
+static void virtio_vcpu_stall_watchdog_process(VirtIOCPUSTALLWATCHDOG *vwdt)
+{
+    int i = 0;
+    struct vcpu_stall_info recv_buf;
+
+    if (!is_guest_ready(vwdt)) {
+        qemu_log("guest is not ready\n");
+        return;
+    }
+
+    receive_vcpu_info(vwdt, &recv_buf, sizeof(recv_buf));
+
+    for (i = 0; i < vwdt->num_timers; i++) {
+        if (vwdt->recv_buf[i]) {
+            if (vwdt->recv_buf[i]->cpu_id == recv_buf.cpu_id) {
+                /* update ticks */
+                vwdt->recv_buf[i]->is_initialized = true;
+                vwdt->recv_buf[i]->ticks = recv_buf.ticks;
+            }
+        } else {
+            break;
+        }
+    }
+
+    if (i != vwdt->num_timers) {
+        struct vcpu_stall_info *priv = malloc(sizeof(struct vcpu_stall_info));
+        if (!priv) {
+            qemu_log("failed to alloc vcpu_stall_info\n");
+            return;
+        }
+        memcpy(priv, &recv_buf, sizeof(struct vcpu_stall_info));
+        vwdt->recv_buf[i] = priv;
+        vwdt->timer[i] = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            vcpu_stall_check, &priv->cpu_id);
+
+        int64_t expire_timer = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+        expire_timer += (MSEC_PER_SEC / VCPU_STALL_DEFAULT_CLOCK_HZ);
+        timer_mod(vwdt->timer[i], expire_timer);
+
+        CPUState *cpu = qemu_get_cpu(recv_buf.cpu_id);
+        if (!cpu) {
+            DPRINTF("failed to get cpu:%d\n", recv_buf.cpu_id);
+        }
+        DPRINTF("vcpu thread id:%d\n", cpu->thread_id);
+    }
+}
+
+static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOCPUSTALLWATCHDOG *vwdt = VIRTIO_VCPU_STALL_WATCHDOG(vdev);
+    virtio_vcpu_stall_watchdog_process(vwdt);
+}
+
+static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
+{
+    return f;
+}
+
+static void virtio_vcpu_stall_watchdog_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    vwdt = VIRTIO_VCPU_STALL_WATCHDOG(dev);
+
+    virtio_init(vdev, VIRTIO_ID_WATCHDOG, 0);
+
+    vwdt->vq = virtio_add_queue(vdev, 1024, handle_input);
+
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
+
+    vwdt->timer = malloc(sizeof(struct QEMUTimer *) * smp_cpus);
+    if (!vwdt->timer) {
+        qemu_log("failed to alloc timer\n");
+        return;
+    }
+
+    vwdt->recv_buf = malloc(sizeof(struct vcpu_stall_info *) * smp_cpus);
+    if (!vwdt->recv_buf) {
+        qemu_log("failed to alloc recv_buf\n");
+        return;
+    }
+
+    vwdt->num_timers = smp_cpus;
+}
+
+static void virtio_vcpu_stall_watchdog_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOCPUSTALLWATCHDOG  *vwdt = VIRTIO_VCPU_STALL_WATCHDOG(dev);
+
+    g_free(vwdt->timer);
+    g_free(vwdt->recv_buf);
+    virtio_cleanup(vdev);
+}
+
+static const VMStateDescription vmstate_virtio_vcpu_stall_watchdog = {
+    .name = "virtio-vcpu-stall-watchdog",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property virtio_vcpu_stall_watchdog_properties[] = {
+};
+
+static void virtio_vcpu_stall_watchdog_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, virtio_vcpu_stall_watchdog_properties);
+    dc->vmsd = &vmstate_virtio_vcpu_stall_watchdog;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_vcpu_stall_watchdog_device_realize;
+    vdc->unrealize = virtio_vcpu_stall_watchdog_device_unrealize;
+    vdc->get_features = get_features;
+}
+
+static const TypeInfo virtio_vcpu_stall_watchdog_info = {
+    .name = TYPE_VIRTIO_CPU_STALL_WATCHDOG,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOCPUSTALLWATCHDOG),
+    .class_init = virtio_vcpu_stall_watchdog_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_vcpu_stall_watchdog_info);
+}
+
+type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-vcpu-stall-watchdog.h b/include/hw/virtio/virtio-vcpu-stall-watchdog.h
new file mode 100644
index 0000000000..7803b12bd6
--- /dev/null
+++ b/include/hw/virtio/virtio-vcpu-stall-watchdog.h
@@ -0,0 +1,45 @@
+/*
+ * Virtio cpu stall watchdog Support
+ *
+ * Copyright Kylin, Inc. 2023
+ * Copyright zhanghao1 <zhanghao1@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_CPU_STALL_WATCHDOG_H
+#define QEMU_VIRTIO_CPU_STALL_WATCHDOG_H
+
+#include "hw/virtio/virtio.h"
+
+#define DEBUG_VIRTIO_CPU_STALL_WATCHDOG 0
+
+#define DPRINTF(fmt, ...) \
+do { \
+    if (DEBUG_VIRTIO_CPU_STALL_WATCHDOG) { \
+        fprintf(stderr, "virtio_cpu_stall_watchdog: " fmt, ##__VA_ARGS__); \
+    } \
+} while (0)
+
+#define TYPE_VIRTIO_CPU_STALL_WATCHDOG "virtio-cpu-stall-watchdog-device"
+#define VIRTIO_VCPU_STALL_WATCHDOG(obj) \
+        OBJECT_CHECK(VirtIOCPUSTALLWATCHDOG, (obj), TYPE_VIRTIO_CPU_STALL_WATCHDOG)
+#define VIRTIO_CPU_STALL_WATCHDOG_GET_PARENT_CLASS(obj) \
+        OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_CPU_STALL_WATCHDOG)
+typedef struct VirtIOCPUSTALLWATCHDOG {
+    VirtIODevice parent_obj;
+
+    /* Only one vq - guest puts message on it when vcpu is stall */
+    VirtQueue *vq;
+
+    QEMUTimer **timer;
+    int num_timers;
+
+    struct vcpu_stall_info **recv_buf;
+
+    uint64_t not_running_last_timestamp;
+} VirtIOCPUSTALLWATCHDOG;
+
+#endif
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

