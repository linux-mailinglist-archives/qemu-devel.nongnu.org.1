Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D4746D4E
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcJQ-0007vk-Fn; Tue, 04 Jul 2023 05:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1qGcJN-0007vX-4U
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:27:05 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1qGcJI-0005jH-22
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:27:04 -0400
X-UUID: cd291dc1a95947918be55306e00485d6-20230704
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27, REQID:b8fdc848-f158-4bdd-9f0e-216b2eb41782, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-10
X-CID-INFO: VERSION:1.1.27, REQID:b8fdc848-f158-4bdd-9f0e-216b2eb41782, IP:5,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-10
X-CID-META: VersionHash:01c9525, CLOUDID:3283ae82-5a99-42ae-a2dd-e4afb731b474,
 B
 ulkID:230704171854KGK1FHF8,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0|-5,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS, TF_CID_SPAM_SNR, TF_CID_SPAM_FAS,
 TF_CID_SPAM_FSD, TF_CID_SPAM_FSI
X-UUID: cd291dc1a95947918be55306e00485d6-20230704
X-User: zhanghao1@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
 (envelope-from <zhanghao1@kylinos.cn>) (Generic MTA)
 with ESMTP id 1490558801; Tue, 04 Jul 2023 17:26:34 +0800
From: zhanghao1 <zhanghao1@kylinos.cn>
To: berrange@redhat.com
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org,
	zhanghao1@kylinos.cn
Subject: Re: [PATCH 1/1] A new virtio pci device named
 virtio-vcpu-stall-watchdog-pci
Date: Tue,  4 Jul 2023 17:26:22 +0800
Message-Id: <20230704092622.221103-1-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZJKyanLHZ07v6Cpm@redhat.com>
References: <ZJKyanLHZ07v6Cpm@redhat.com>
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

> On Thu, Jun 15, 2023 at 02:13:02PM +0800, zhanghao1 wrote:
> > Each vcpu creates a corresponding timer task. The watchdog
> > is driven by a timer according to a certain period. Each time
> > the timer expires, the counter is decremented. When the counter
> > is "0", the watchdog considers the vcpu to be stalling and resets
> > the VM. To avoid watchdog expiration, the guest kernel driver
> > needs to periodically send a pet event to update the counter.
> 
> I'm wondering how this is different/better from the existing
> watchdogs we have in QEMU.
> 
> IIUC, the interesting bit is that this watchdog is monitoring
> liveliness of every individual guest VCPU, whereas the existing
> watchdogs are all just a single timer for the whole VM.
> 
> IOW, with this watchdog we're proving that *every* vCPU is
> alive, while with other watchdogs we're merely providing that
> at least 1 vCPU is still alive.
> 
> Have you got a Linux guest impl for this watchdog that you're
> submitting too ?

Upstream there is a DTB-based driver with the following address:
https://lore.kernel.org/lkml/20220707154226.1478674-1-sebastianene@google.com/T/#m6ffdbdd43e19f608eaa1580d829a2dad8a6cf2f7
Considering that this driver is not compatible with qemu's virtio device,
I re-implemented a virtio driver. I will submit to the upstream
communitiy as soon as possible.
 
> > Signed-off-by: zhanghao1 <zhanghao1@kylinos.cn>
> > ---
> >  hw/virtio/Kconfig                             |   5 +
> >  hw/virtio/meson.build                         |   2 +
> >  hw/virtio/virtio-vcpu-stall-watchdog-pci.c    |  89 +++++++
> >  hw/virtio/virtio-vcpu-stall-watchdog.c        | 240 ++++++++++++++++++
> >  .../hw/virtio/virtio-vcpu-stall-watchdog.h    |  45 ++++
> >  5 files changed, 381 insertions(+)
> >  create mode 100644 hw/virtio/virtio-vcpu-stall-watchdog-pci.c
> >  create mode 100644 hw/virtio/virtio-vcpu-stall-watchdog.c
> >  create mode 100644 include/hw/virtio/virtio-vcpu-stall-watchdog.h
> 
> > diff --git a/hw/virtio/virtio-vcpu-stall-watchdog-pci.c b/hw/virtio/virtio-vcpu-stall-watchdog-pci.c
> > new file mode 100644
> > index 0000000000..fce735abc7
> > --- /dev/null
> > +++ b/hw/virtio/virtio-vcpu-stall-watchdog-pci.c
> > @@ -0,0 +1,89 @@
> > +/*
> > + * Virtio cpu stall watchdog PCI Bindings
> > + *
> > + * Copyright 2023 Kylin, Inc.
> > + * Copyright 2023 Hao Zhang <zhanghao1@kylinos.cn>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "hw/virtio/virtio-pci.h"
> > +#include "hw/virtio/virtio-vcpu-stall-watchdog.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +
> > +typedef struct VirtIOCpuStallWatchdogPCI VirtIOCpuStallWatchdogPCI;
> > +
> > +/*
> > + * virtio-cpu-stall-watchdog-pci: This extends VirtioPCIProxy.
> > + */
> > +#define TYPE_VIRTIO_CPU_STALL_WATCHDOG_PCI "virtio-vcpu-stall-watchdog-pci-base"
> > +#define VIRTIO_CPU_STALL_WATCHDOG_PCI(obj) \
> > +        OBJECT_CHECK(VirtIOCpuStallWatchdogPCI, (obj), TYPE_VIRTIO_CPU_STALL_WATCHDOG_PCI)
> > +
> > +struct VirtIOCpuStallWatchdogPCI {
> > +    VirtIOPCIProxy parent_obj;
> > +    VirtIOCPUSTALLWATCHDOG vdev;
> > +};
> > +
> > +static Property vcpu_stall_watchdog_properties[] = {
> > +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> > +                       DEV_NVECTORS_UNSPECIFIED),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_vcpu_stall_watchdog_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > +{
> > +    VirtIOCpuStallWatchdogPCI *dev = VIRTIO_CPU_STALL_WATCHDOG_PCI(vpci_dev);
> > +    DeviceState *vdev = DEVICE(&dev->vdev);
> > +
> > +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> > +        vpci_dev->nvectors = 1;
> > +    }
> > +
> > +    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
> > +        return;
> > +    }
> > +}
> > +
> > +static void virtio_vcpu_stall_watchdog_pci_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> > +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> > +
> > +    k->realize = virtio_vcpu_stall_watchdog_pci_realize;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    device_class_set_props(dc, vcpu_stall_watchdog_properties);
> > +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> > +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> > +}
> > +
> > +static void virtio_vcpu_stall_watchdog_init(Object *obj)
> > +{
> > +    VirtIOCpuStallWatchdogPCI *dev = VIRTIO_CPU_STALL_WATCHDOG_PCI(obj);
> > +
> > +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> > +                                TYPE_VIRTIO_CPU_STALL_WATCHDOG);
> > +}
> > +
> > +static const VirtioPCIDeviceTypeInfo virtio_vcpu_stall_watchdog_pci_info = {
> > +    .base_name             = TYPE_VIRTIO_CPU_STALL_WATCHDOG_PCI,
> > +    .generic_name          = "virtio-vcpu-stall-watchdog-pci",
> > +    .transitional_name     = "virtio-vcpu-stall-watchdog-pci-transitional",
> > +    .non_transitional_name = "virtio-vcpu-stall-watchdog-pci-non-transitional",
> 
> New virtio devices should be exclusively operating in modern mode, so
> IIUC, you should not need either of these two compatibility properties,
> only the '.generic_name'
> 
> As a general question, I wonder if 'virtio vcpu stall watchdog' is a
> bit too verbose. A watchdog is inherantly about detecting stalls, so
> perhaps just call it the 'virtio vcpu watchdog' and thus remove the
> word 'stall' everywhere in this patch ?

OK, this one is a little redundant.
 
> > +    .instance_size = sizeof(VirtIOCpuStallWatchdogPCI),
> > +    .instance_init = virtio_vcpu_stall_watchdog_init,
> > +    .class_init    = virtio_vcpu_stall_watchdog_pci_class_init,
> > +};
> > +
> > +static void virtio_vcpu_stall_watchdog_pci_register(void)
> > +{
> > +    virtio_pci_types_register(&virtio_vcpu_stall_watchdog_pci_info);
> > +}
> > +
> > +type_init(virtio_vcpu_stall_watchdog_pci_register)
> 
> > diff --git a/hw/virtio/virtio-vcpu-stall-watchdog.c b/hw/virtio/virtio-vcpu-stall-watchdog.c
> > new file mode 100644
> > index 0000000000..ea7dbd4810
> > --- /dev/null
> > +++ b/hw/virtio/virtio-vcpu-stall-watchdog.c
> > @@ -0,0 +1,240 @@
> > +/*
> > + * A virtio device implementing a vcpu stall watchdog.
> > + *
> > + * Copyright 2023 Kylin, Inc.
> > + * Copyright 2023 zhanghao1 <zhanghao1@kylinos.cn>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/iov.h"
> > +#include "qemu/module.h"
> > +#include "qemu/bswap.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-vcpu-stall-watchdog.h"
> > +#include "qom/object_interfaces.h"
> > +#include "trace.h"
> > +#include "standard-headers/linux/virtio_ids.h"
> > +#include "hw/virtio/virtio-access.h"
> > +#include "hw/boards.h"
> > +#include "sysemu/cpus.h"
> > +#include "sysemu/runstate.h"
> > +
> > +#define MAX_PATH 1024
> 
> This constant does not appear to be used

Yes, I will delete it.
 
> > +
> > +#define VCPU_STALL_DEFAULT_CLOCK_HZ (5)
> > +#define VCPU_STALL_DEFAULT_TIMEOUT_SEC (8)
> > +#define MSEC_PER_SEC 1000
> > +#define PROCSTAT_UTIME_INDX 13
> > +#define PROCSTAT_GUEST_TIME_INDX 42
> > +
> > +struct vcpu_stall_info {
> > +    uint32_t cpu_id;
> > +    bool is_initialized;
> 
> A question for C experts/virtio maintainers - is is appropriate to
> use 'bool' in a host/guest struct ABI - ie is its size well defined,
> or should a sized integer type be used instead ?
> 
> > +    uint32_t ticks;
> > +    uint64_t not_running_last_timestamp;
> > +};
> > +
> > +static VirtIOCPUSTALLWATCHDOG *vwdt;
> > +
> > +static bool is_guest_ready(VirtIOCPUSTALLWATCHDOG *vwdt)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(vwdt);
> > +    if (virtio_queue_ready(vwdt->vq)
> > +        && (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> 
> Qemu conventions more commonly put the '&&' at the end of lines
> rather than start.
> 
> > +        return true;
> > +    }
> > +    return false;
> > +}
> > +
> > +/* receive data from guest */
> > +static void receive_vcpu_info(void *opaque, void *buf, size_t size)
> > +{
> > +    VirtIOCPUSTALLWATCHDOG *vwdt = opaque;
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(vwdt);
> > +    VirtQueueElement *elem;
> 
> Use
> 
>   g_autofree VirtQueueElement *elem = NULL;
> 
> > +    size_t len;
> > +
> > +    if (!is_guest_ready(vwdt)) {
> > +        return;
> > +    }
> > +
> > +    elem = virtqueue_pop(vwdt->vq, sizeof(VirtQueueElement));
> > +    if (!elem) {
> > +        return;
> > +    }
> > +
> > +    len = iov_size(elem->out_sg, elem->out_num);
> > +
> > +    len = iov_to_buf(elem->out_sg, elem->out_num,
> > +                     0, buf, len);
> > +
> > +    int cpu = virtio_ldl_p(vdev, &((struct vcpu_stall_info *)buf)->cpu_id);
> > +    DPRINTF("read to buf:%lu cpu_id:%u is_initialized:%d ticks:%u\n", len, cpu,
> > +                     ((struct vcpu_stall_info *)buf)->is_initialized,
> > +                     ((struct vcpu_stall_info *)buf)->ticks);
> 
> Please use the 'trace-events' file to define trace points, and use trace
> events everywhere in this patch instead of DPRINTF and/or qemu_log.
> 
> > +
> > +    virtqueue_push(vwdt->vq, elem, len);
> > +    g_free(elem);
> 
> This can be removed when using 'g_autofree'
> 
> > +    virtio_notify(vdev, vwdt->vq);
> > +}
> > +
> > +static void vcpu_stall_check(void *opaque)
> > +{
> > +    int *cpu_id = (int *)opaque;
> > +
> > +    struct vcpu_stall_info *priv = vwdt->recv_buf[*cpu_id];
> > +
> > +    DPRINTF("start to vcpu stall check, cpu:%d ticks:%u\n",
> > +                *cpu_id, priv->ticks);
> > +    priv->ticks -= 1;
> > +
> > +    if (priv->ticks <= 0) {
> > +        /* cpu is stall, reset vm */
> > +        qemu_log("CPU:%d is stall, need to reset vm\n", *cpu_id);
> > +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> 
> QEMU has a framework for watchdogs - you should call:
> 
>     watchdog_perform_action();
> 
> which allows the mgmt app to control whether the action is a guest
> reset, or poweroff, or something else.
> 
> 
> > +    }
> > +
> > +    int64_t expire_timer = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> > +    expire_timer += (MSEC_PER_SEC / VCPU_STALL_DEFAULT_CLOCK_HZ);
> > +    timer_mod(vwdt->timer[*cpu_id], expire_timer);
> > +}
> > +
> > +static void virtio_vcpu_stall_watchdog_process(VirtIOCPUSTALLWATCHDOG *vwdt)
> > +{
> > +    int i = 0;
> > +    struct vcpu_stall_info recv_buf;
> > +
> > +    if (!is_guest_ready(vwdt)) {
> > +        qemu_log("guest is not ready\n");
> > +        return;
> > +    }
> > +
> > +    receive_vcpu_info(vwdt, &recv_buf, sizeof(recv_buf));
> > +
> > +    for (i = 0; i < vwdt->num_timers; i++) {
> > +        if (vwdt->recv_buf[i]) {
> > +            if (vwdt->recv_buf[i]->cpu_id == recv_buf.cpu_id) {
> > +                /* update ticks */
> > +                vwdt->recv_buf[i]->is_initialized = true;
> > +                vwdt->recv_buf[i]->ticks = recv_buf.ticks;
> > +            }
> > +        } else {
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (i != vwdt->num_timers) {
> > +        struct vcpu_stall_info *priv = malloc(sizeof(struct vcpu_stall_info));
> > +        if (!priv) {
> > +            qemu_log("failed to alloc vcpu_stall_info\n");
> > +            return;
> > +        }
> 
> Use 'g_new0' instead of malloc, which aborts-on-OOM. Same a few times
> later in this patch.

I will refactor this patch according to your suggestion.

Thanks!
 
> > +        memcpy(priv, &recv_buf, sizeof(struct vcpu_stall_info));
> > +        vwdt->recv_buf[i] = priv;
> > +        vwdt->timer[i] = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> > +                                            vcpu_stall_check, &priv->cpu_id);
> > +
> > +        int64_t expire_timer = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> > +        expire_timer += (MSEC_PER_SEC / VCPU_STALL_DEFAULT_CLOCK_HZ);
> > +        timer_mod(vwdt->timer[i], expire_timer);
> > +
> > +        CPUState *cpu = qemu_get_cpu(recv_buf.cpu_id);
> > +        if (!cpu) {
> > +            DPRINTF("failed to get cpu:%d\n", recv_buf.cpu_id);
> > +        }
> > +        DPRINTF("vcpu thread id:%d\n", cpu->thread_id);
> > +    }
> > +}
> > +
> > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VirtIOCPUSTALLWATCHDOG *vwdt = VIRTIO_VCPU_STALL_WATCHDOG(vdev);
> > +    virtio_vcpu_stall_watchdog_process(vwdt);
> > +}
> > +
> > +static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
> > +{
> > +    return f;
> > +}
> > +
> > +static void virtio_vcpu_stall_watchdog_device_realize(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    vwdt = VIRTIO_VCPU_STALL_WATCHDOG(dev);
> > +
> > +    virtio_init(vdev, VIRTIO_ID_WATCHDOG, 0);
> > +
> > +    vwdt->vq = virtio_add_queue(vdev, 1024, handle_input);
> > +
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    unsigned int smp_cpus = ms->smp.cpus;
> > +
> > +    vwdt->timer = malloc(sizeof(struct QEMUTimer *) * smp_cpus);
> > +    if (!vwdt->timer) {
> > +        qemu_log("failed to alloc timer\n");
> > +        return;
> > +    }
> > +
> > +    vwdt->recv_buf = malloc(sizeof(struct vcpu_stall_info *) * smp_cpus);
> > +    if (!vwdt->recv_buf) {
> > +        qemu_log("failed to alloc recv_buf\n");
> > +        return;
> > +    }
> > +
> > +    vwdt->num_timers = smp_cpus;
> > +}
> > +
> > +static void virtio_vcpu_stall_watchdog_device_unrealize(DeviceState *dev)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    VirtIOCPUSTALLWATCHDOG  *vwdt = VIRTIO_VCPU_STALL_WATCHDOG(dev);
> > +
> > +    g_free(vwdt->timer);
> > +    g_free(vwdt->recv_buf);
> > +    virtio_cleanup(vdev);
> > +}
> > +
> > +static const VMStateDescription vmstate_virtio_vcpu_stall_watchdog = {
> > +    .name = "virtio-vcpu-stall-watchdog",
> > +    .minimum_version_id = 1,
> > +    .version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_VIRTIO_DEVICE,
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static Property virtio_vcpu_stall_watchdog_properties[] = {
> > +};
> > +
> > +static void virtio_vcpu_stall_watchdog_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> > +
> > +    device_class_set_props(dc, virtio_vcpu_stall_watchdog_properties);
> > +    dc->vmsd = &vmstate_virtio_vcpu_stall_watchdog;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    vdc->realize = virtio_vcpu_stall_watchdog_device_realize;
> > +    vdc->unrealize = virtio_vcpu_stall_watchdog_device_unrealize;
> > +    vdc->get_features = get_features;
> > +}
> > +
> > +static const TypeInfo virtio_vcpu_stall_watchdog_info = {
> > +    .name = TYPE_VIRTIO_CPU_STALL_WATCHDOG,
> > +    .parent = TYPE_VIRTIO_DEVICE,
> > +    .instance_size = sizeof(VirtIOCPUSTALLWATCHDOG),
> > +    .class_init = virtio_vcpu_stall_watchdog_class_init,
> > +};
> > +
> > +static void virtio_register_types(void)
> > +{
> > +    type_register_static(&virtio_vcpu_stall_watchdog_info);
> > +}
> > +
> > +type_init(virtio_register_types)
> > diff --git a/include/hw/virtio/virtio-vcpu-stall-watchdog.h b/include/hw/virtio/virtio-vcpu-stall-watchdog.h
> > new file mode 100644
> > index 0000000000..15714ddec5
> > --- /dev/null
> > +++ b/include/hw/virtio/virtio-vcpu-stall-watchdog.h
> > @@ -0,0 +1,45 @@
> > +/*
> > + * Virtio cpu stall watchdog Support
> > + *
> > + * Copyright Kylin, Inc. 2023
> > + * Copyright zhanghao1 <zhanghao1@kylinos.cn>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#ifndef QEMU_VIRTIO_CPU_STALL_WATCHDOG_H
> > +#define QEMU_VIRTIO_CPU_STALL_WATCHDOG_H
> > +
> > +#include "hw/virtio/virtio.h"
> > +
> > +#define DEBUG_VIRTIO_CPU_STALL_WATCHDOG 0
> > +
> > +#define DPRINTF(fmt, ...) \
> > +do { \
> > +    if (DEBUG_VIRTIO_CPU_STALL_WATCHDOG) { \
> > +        fprintf(stderr, "virtio_cpu_stall_watchdog: " fmt, ##__VA_ARGS__); \
> > +    } \
> > +} while (0)
> > +
> > +#define TYPE_VIRTIO_CPU_STALL_WATCHDOG "virtio-cpu-stall-watchdog-device"
> > +#define VIRTIO_VCPU_STALL_WATCHDOG(obj) \
> > +        OBJECT_CHECK(VirtIOCPUSTALLWATCHDOG, (obj), TYPE_VIRTIO_CPU_STALL_WATCHDOG)
> > +#define VIRTIO_CPU_STALL_WATCHDOG_GET_PARENT_CLASS(obj) \
> > +        OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_CPU_STALL_WATCHDOG)
> > +typedef struct VirtIOCPUSTALLWATCHDOG {
> > +    VirtIODevice parent_obj;
> > +
> > +    /* Only one vq - guest puts message on it when vcpu is stall */
> > +    VirtQueue *vq;
> > +
> > +    QEMUTimer **timer;
> > +    int num_timers;
> > +
> > +    struct vcpu_stall_info **recv_buf;
> > +
> > +    uint64_t not_running_last_timestamp;
> > +} VirtIOCPUSTALLWATCHDOG;
> > +
> > +#endif
> > -- 
> > 2.25.1
> > 
> > 
> > No virus found
> > 		Checked by Hillstone Network AntiVirus
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> 
> 

No virus found
		Checked by Hillstone Network AntiVirus

