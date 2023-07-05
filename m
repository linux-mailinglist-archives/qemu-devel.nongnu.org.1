Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E985747F62
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxjf-0006XI-24; Wed, 05 Jul 2023 04:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1qGxjY-0006Wm-AS
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:19:32 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1qGxjQ-0007zU-LY
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:19:32 -0400
X-UUID: ff2df42a177b42938f41d3ee2a90a997-20230705
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27, REQID:1c244c42-6298-4007-af1a-195b4deb4fca, IP:5,
 U
 RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
 TION:release,TS:-10
X-CID-INFO: VERSION:1.1.27, REQID:1c244c42-6298-4007-af1a-195b4deb4fca, IP:5,
 URL
 :0,TC:0,Content:-25,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-10
X-CID-META: VersionHash:01c9525, CLOUDID:64aab882-5a99-42ae-a2dd-e4afb731b474,
 B
 ulkID:230705100759I2IPX061,BulkQuantity:2,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR, TF_CID_SPAM_FAS, TF_CID_SPAM_FSD,
 TF_CID_SPAM_FSI, TF_CID_SPAM_ULN
X-UUID: ff2df42a177b42938f41d3ee2a90a997-20230705
X-User: zhanghao1@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
 (envelope-from <zhanghao1@kylinos.cn>) (Generic MTA)
 with ESMTP id 1295193389; Wed, 05 Jul 2023 16:19:12 +0800
From: zhanghao1 <zhanghao1@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, zhanghao1 <zhanghao1@kylinos.cn>
Subject: [PATCH v2] virtio: add a new vcpu watchdog
Date: Wed,  5 Jul 2023 16:18:13 +0800
Message-Id: <20230705081813.411526-1-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
v2:
 - change the function name and remove the redundant word 'stall'
 - add trace-events to replace DPRINTF and qemu_log
 - call 'watchdog_perform_action()' to reset vm
 - update g_new0 to replace malloc
 - update only use '.generic_name'
 - update the bool variable 'is_initialized' to uint32_t

v1: https://lore.kernel.org/qemu-devel/20230615061302.301754-1-zhanghao1@kylinos.cn/

 hw/virtio/Kconfig                        |   5 +
 hw/virtio/meson.build                    |   2 +
 hw/virtio/trace-events                   |   6 +
 hw/virtio/virtio-vcpu-watchdog-pci.c     |  86 +++++++++
 hw/virtio/virtio-vcpu-watchdog.c         | 226 +++++++++++++++++++++++
 include/hw/virtio/virtio-vcpu-watchdog.h |  37 ++++
 6 files changed, 362 insertions(+)
 create mode 100644 hw/virtio/virtio-vcpu-watchdog-pci.c
 create mode 100644 hw/virtio/virtio-vcpu-watchdog.c
 create mode 100644 include/hw/virtio/virtio-vcpu-watchdog.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 89e9e426d8..85bb7ce46d 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -90,3 +90,8 @@ config VHOST_VDPA_DEV
     bool
     default y
     depends on VIRTIO && VHOST_VDPA && LINUX
+
+config VIRTIO_VCPU_WATCHDOG
+    bool
+    default y
+    depends on VIRTIO
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index bdec78bfc6..fe2084ec07 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -33,6 +33,7 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
 specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'], if_true: files('vhost-user-gpio-pci.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
+specific_virtio_ss.add(when: 'CONFIG_VIRTIO_VCPU_WATCHDOG', if_true: files('virtio-vcpu-watchdog.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
@@ -59,6 +60,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_VCPU_WATCHDOG', if_true: files('virtio-vcpu-watchdog-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f8d05cf9b..dc0d5174e6 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -151,3 +151,9 @@ virtio_pmem_flush_done(int type) "fsync return=%d"
 virtio_gpio_start(void) "start"
 virtio_gpio_stop(void) "stop"
 virtio_gpio_set_status(uint8_t status) "0x%x"
+
+# virtio-vcpu-watchdog.c
+virtio_receive_vcpu_info(size_t len, int cpu, uint32_t is_initialized, uint32_t ticks) "len=%zd cpu=%d is_initialized=%d ticks=%d"
+virtio_vcpu_check_ticks(int cpu_id, uint32_t ticks) "cpu_id=%d ticks=%d"
+virtio_vcpu_check_reset(int cpu_id) "CPU:%d is stall need to reset vm"
+virtio_vcpu_watchdog_process(int thread_id) "vcpu thread id:%d"
diff --git a/hw/virtio/virtio-vcpu-watchdog-pci.c b/hw/virtio/virtio-vcpu-watchdog-pci.c
new file mode 100644
index 0000000000..f264c82d6f
--- /dev/null
+++ b/hw/virtio/virtio-vcpu-watchdog-pci.c
@@ -0,0 +1,86 @@
+/*
+ * Virtio cpu watchdog PCI Bindings
+ *
+ * Copyright 2023 Kylin, Inc.
+ * Copyright 2023 Hao Zhang <zhanghao1@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-vcpu-watchdog.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+
+typedef struct VirtIOCpuWatchdogPCI VirtIOCpuWatchdogPCI;
+
+/*
+ * virtio-cpu-watchdog-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_CPU_WATCHDOG_PCI "virtio-vcpu-watchdog-pci"
+DECLARE_INSTANCE_CHECKER(VirtIOCpuWatchdogPCI, VIRTIO_CPU_WATCHDOG_PCI,
+                         TYPE_VIRTIO_CPU_WATCHDOG_PCI)
+
+struct VirtIOCpuWatchdogPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOCPUWATCHDOG vdev;
+};
+
+static Property vcpu_watchdog_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_vcpu_watchdog_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOCpuWatchdogPCI *dev = VIRTIO_CPU_WATCHDOG_PCI(vpci_dev);
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
+static void virtio_vcpu_watchdog_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_vcpu_watchdog_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, vcpu_watchdog_properties);
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_vcpu_watchdog_init(Object *obj)
+{
+    VirtIOCpuWatchdogPCI *dev = VIRTIO_CPU_WATCHDOG_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_VCPU_WATCHDOG);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_vcpu_watchdog_pci_info = {
+    .generic_name  = TYPE_VIRTIO_CPU_WATCHDOG_PCI,
+    .instance_size = sizeof(VirtIOCpuWatchdogPCI),
+    .instance_init = virtio_vcpu_watchdog_init,
+    .class_init    = virtio_vcpu_watchdog_pci_class_init,
+};
+
+static void virtio_vcpu_watchdog_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_vcpu_watchdog_pci_info);
+}
+
+type_init(virtio_vcpu_watchdog_pci_register)
diff --git a/hw/virtio/virtio-vcpu-watchdog.c b/hw/virtio/virtio-vcpu-watchdog.c
new file mode 100644
index 0000000000..f9cf658711
--- /dev/null
+++ b/hw/virtio/virtio-vcpu-watchdog.c
@@ -0,0 +1,226 @@
+/*
+ * A virtio device implementing a vcpu watchdog.
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
+#include "hw/virtio/virtio-vcpu-watchdog.h"
+#include "qom/object_interfaces.h"
+#include "trace.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/boards.h"
+#include "sysemu/cpus.h"
+#include "sysemu/runstate.h"
+#include "sysemu/watchdog.h"
+
+#define VCPU_DEFAULT_CLOCK_HZ (5)
+#define VCPU_DEFAULT_TIMEOUT_SEC (8)
+#define MSEC_PER_SEC 1000
+#define PROCSTAT_UTIME_INDX 13
+#define PROCSTAT_GUEST_TIME_INDX 42
+
+struct vcpu_info {
+    uint32_t cpu_id;
+    uint32_t is_initialized;
+    uint32_t ticks;
+    uint64_t not_running_last_timestamp;
+};
+
+static VirtIOCPUWATCHDOG *vwdt;
+
+static bool is_guest_ready(VirtIOCPUWATCHDOG *vwdt)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(vwdt);
+    if (virtio_queue_ready(vwdt->vq) &&
+        (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+        return true;
+    }
+    return false;
+}
+
+/* receive data from guest */
+static void receive_vcpu_info(void *opaque, void *buf, size_t size)
+{
+    VirtIOCPUWATCHDOG *vwdt = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vwdt);
+    g_autofree VirtQueueElement *elem;
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
+    int cpu = virtio_ldl_p(vdev, &((struct vcpu_info *)buf)->cpu_id);
+    trace_virtio_receive_vcpu_info(len, cpu,
+                                   ((struct vcpu_info *)buf)->is_initialized,
+                                   ((struct vcpu_info *)buf)->ticks);
+
+    virtqueue_push(vwdt->vq, elem, len);
+    virtio_notify(vdev, vwdt->vq);
+}
+
+static void vcpu_check(void *opaque)
+{
+    int *cpu_id = (int *)opaque;
+
+    struct vcpu_info *priv = vwdt->recv_buf[*cpu_id];
+
+    trace_virtio_vcpu_check_ticks(*cpu_id, priv->ticks);
+    
+    priv->ticks -= 1;
+
+    if (priv->ticks <= 0) {
+        /* cpu is stall, reset vm */
+        trace_virtio_vcpu_check_reset(*cpu_id);
+        watchdog_perform_action();
+    }
+
+    int64_t expire_timer = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    expire_timer += (MSEC_PER_SEC / VCPU_DEFAULT_CLOCK_HZ);
+    timer_mod(vwdt->timer[*cpu_id], expire_timer);
+}
+
+static void virtio_vcpu_watchdog_process(VirtIOCPUWATCHDOG *vwdt)
+{
+    int i = 0;
+    struct vcpu_info recv_buf;
+
+    if (!is_guest_ready(vwdt)) {
+        return;
+    }
+
+    receive_vcpu_info(vwdt, &recv_buf, sizeof(recv_buf));
+
+    for (i = 0; i < vwdt->num_timers; i++) {
+        if (vwdt->recv_buf[i]) {
+            if (vwdt->recv_buf[i]->cpu_id == recv_buf.cpu_id) {
+                /* update ticks */
+                vwdt->recv_buf[i]->is_initialized = 1;
+                vwdt->recv_buf[i]->ticks = recv_buf.ticks;
+            }
+        } else {
+            break;
+        }
+    }
+
+    if (i != vwdt->num_timers) {
+        struct vcpu_info *priv = g_new0(struct vcpu_info, 1);
+
+        memcpy(priv, &recv_buf, sizeof(struct vcpu_info));
+        vwdt->recv_buf[i] = priv;
+        vwdt->timer[i] = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            vcpu_check, &priv->cpu_id);
+
+        int64_t expire_timer = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+        expire_timer += (MSEC_PER_SEC / VCPU_DEFAULT_CLOCK_HZ);
+        timer_mod(vwdt->timer[i], expire_timer);
+
+        CPUState *cpu = qemu_get_cpu(recv_buf.cpu_id);
+        if (!cpu) {
+            return;
+        }
+        trace_virtio_vcpu_watchdog_process(cpu->thread_id);
+    }
+}
+
+static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOCPUWATCHDOG *vwdt = VIRTIO_VCPU_WATCHDOG(vdev);
+    virtio_vcpu_watchdog_process(vwdt);
+}
+
+static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
+{
+    return f;
+}
+
+static void virtio_vcpu_watchdog_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    vwdt = VIRTIO_VCPU_WATCHDOG(dev);
+
+    virtio_init(vdev, VIRTIO_ID_WATCHDOG, 0);
+
+    vwdt->vq = virtio_add_queue(vdev, 1024, handle_input);
+
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
+
+    vwdt->timer = g_new0(struct QEMUTimer *, smp_cpus);
+
+    vwdt->recv_buf = g_new0(struct vcpu_info *, smp_cpus);
+
+    vwdt->num_timers = smp_cpus;
+}
+
+static void virtio_vcpu_watchdog_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOCPUWATCHDOG  *vwdt = VIRTIO_VCPU_WATCHDOG(dev);
+
+    g_free(vwdt->timer);
+    g_free(vwdt->recv_buf);
+    virtio_cleanup(vdev);
+}
+
+static const VMStateDescription vmstate_virtio_vcpu_watchdog = {
+    .name = "virtio-vcpu-watchdog",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property virtio_vcpu_watchdog_properties[] = {
+};
+
+static void virtio_vcpu_watchdog_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, virtio_vcpu_watchdog_properties);
+    dc->vmsd = &vmstate_virtio_vcpu_watchdog;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_vcpu_watchdog_device_realize;
+    vdc->unrealize = virtio_vcpu_watchdog_device_unrealize;
+    vdc->get_features = get_features;
+}
+
+static const TypeInfo virtio_vcpu_watchdog_info = {
+    .name = TYPE_VIRTIO_VCPU_WATCHDOG,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOCPUWATCHDOG),
+    .class_init = virtio_vcpu_watchdog_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_vcpu_watchdog_info);
+}
+
+type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-vcpu-watchdog.h b/include/hw/virtio/virtio-vcpu-watchdog.h
new file mode 100644
index 0000000000..6cce4e9bab
--- /dev/null
+++ b/include/hw/virtio/virtio-vcpu-watchdog.h
@@ -0,0 +1,37 @@
+/*
+ * Virtio cpu watchdog Support
+ *
+ * Copyright Kylin, Inc. 2023
+ * Copyright zhanghao1 <zhanghao1@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef QEMU_VIRTIO_CPU_WATCHDOG_H
+#define QEMU_VIRTIO_CPU_WATCHDOG_H
+
+#include "hw/virtio/virtio.h"
+
+#define TYPE_VIRTIO_VCPU_WATCHDOG "virtio-vcpu-watchdog-device"
+
+#define VIRTIO_VCPU_WATCHDOG(obj) \
+        OBJECT_CHECK(VirtIOCPUWATCHDOG, (obj), TYPE_VIRTIO_VCPU_WATCHDOG)
+#define VIRTIO_CPU_WATCHDOG_GET_PARENT_CLASS(obj) \
+        OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_VCPU_WATCHDOG)
+typedef struct VirtIOCPUWATCHDOG {
+    VirtIODevice parent_obj;
+
+    /* Only one vq - guest puts message on it when vcpu is stall */
+    VirtQueue *vq;
+
+    QEMUTimer **timer;
+    int num_timers;
+
+    struct vcpu_info **recv_buf;
+
+    uint64_t not_running_last_timestamp;
+} VirtIOCPUWATCHDOG;
+
+#endif
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

