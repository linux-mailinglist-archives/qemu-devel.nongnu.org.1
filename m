Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95057F98A3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 06:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7U4I-0004S7-JH; Mon, 27 Nov 2023 00:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U4G-0004Rj-ND
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:22:00 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U4D-0008Au-At
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:22:00 -0500
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-6ce322b62aeso2215950a34.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 21:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701062516; x=1701667316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrIvw/c7ANbXl/qBEcZRfQxui2zzTTLXuYa9rLTlQvE=;
 b=N/zxCT0P7gHHdafFKJ9mZgFKUqHtsw9fkL6Ig4h6p4RVvGtiHGz0kpLJgJ2ijVKylN
 5qvg8FZUIhp52tabSUF85uoizxkN5F0+4QiWbMfgwSZ68EdwXnw2E13ItaGhOLHAn/dG
 pLxOOOpmsOAIKIJWOsUly5s1K0fzeYXi4aXvthE+xoj4+vqriNoP1b30sf9ZVmIbfmBA
 MWzvYOg3y6cB5p44nQ3S+fe3/Vp0P4CsHk5aJDxiW/yg2clD7iVQfyUi+VcU+6OfFpY5
 dduMgJncZzG3APN22qGCLXAv75UiKIGEzmpWyH/d2ITffHd7se4RDk68tbQEMYg8/G7w
 ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701062516; x=1701667316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrIvw/c7ANbXl/qBEcZRfQxui2zzTTLXuYa9rLTlQvE=;
 b=KB1KzHkwvJeAApnTdglEUPQbcDNXEnWXbohkpHrxGdo7n121YjZsnGNoeiY/bTpfto
 /N8TGxq2t4RoqCh1KmG69reFyY0jTtzZesBKT8s8eT6lAZOz8EJDcURy8N7HqLro5xSs
 sayrLJGt0tDllje/cjPsifAcBmSnhM+rBLJKXi2RwIi+hCKCkgGPyMBlnI8WRup3Hji9
 VCZ5FkdzreCN5xpH0saUVVW+SeLjvTsmVj1C8NqTAQQzd71QiCEWMADEJpfxlmhxtOUP
 AWsc9ic5JfbAxardyeTH3/M2QogeEGxW38dijZuSXJBX+51LO3Gh/4pNNKbMvoSY275o
 7UnQ==
X-Gm-Message-State: AOJu0Yz1jOaw/HDsbohMGzmxQuxwKw+b40l/L5N1HmYyPJD/ADKKs000
 YakqpfoKW2LiZ2hsQYsK98zaMpjtl6haQVymFdrqRnxGaNI=
X-Google-Smtp-Source: AGHT+IGwkpaOBVpHGxRq5MC2tUlm5T2F1gq5/+BHzLkwsyr2stcZ+43YxOuHRNADwemLoSJzuIafRg==
X-Received: by 2002:a05:6870:88d:b0:1fa:5873:d0fa with SMTP id
 fx13-20020a056870088d00b001fa5873d0famr1756547oab.50.1701062515423; 
 Sun, 26 Nov 2023 21:21:55 -0800 (PST)
Received: from amd.. ([2804:7f0:b402:7782:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 v13-20020aa7808d000000b006cb9f436232sm6392316pff.114.2023.11.26.21.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 21:21:54 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 1/4] Add ivshmem-flat device
Date: Mon, 27 Nov 2023 05:20:21 +0000
Message-Id: <20231127052024.435743-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127052024.435743-1-gustavo.romero@linaro.org>
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
does not require a PCI bus. It's meant to be used on machines like those
with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
and mps2-an385.

The device currently only supports the sysbus bus.

The following is an example on how to create the ivshmem-flat device on
a Stellaris machine:

$ qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic
                  -net none -chardev stdio,id=con,mux=on
                  -serial chardev:con -mon chardev=con,mode=readline
                  -chardev socket,path=/tmp/ivshmem_socket,id=ivf
                  -device ivshmem-flat,x-irq-qompath=/machine/unattached/device[1]/nvic/unnamed-gpio-in[0],x-bus-qompath="/sysbus",chardev=ivf
                  -kernel zephyr_qemu.elf

The new device, just like the ivshmem PCI device, supports both peer
notification via hardware interrupts and shared memory.

The IRQ QOM path for the target machine can be determined by creating
the VM without the ivshmem-flat device, going to the QEMU console and
listing the QOM nodes with 'info qom-tree'. In the Stellaris example
above the input IRQ is in the NVIC IC.

The MMRs for status and control (notification) are mapped to the MMIO
region at 0x400FF000 (default), whilst the shared memory region start
is mapped at addr. 0x40100000 (default), but both addresses can be set
when creating the device by using 'x-bus-address-{mmr,shmem}' options,
respectively.

The device shared memory size can be set using the 'shmem-size' option
and it defaults to 4 MiB, which is the default size of shmem allocated
by the ivshmem server.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/devices/ivshmem-flat.rst |  89 +++++
 hw/arm/mps2.c                        |   2 +
 hw/arm/stellaris.c                   |   5 +-
 hw/arm/virt.c                        |   2 +
 hw/core/sysbus-fdt.c                 |   1 +
 hw/misc/Kconfig                      |   5 +
 hw/misc/ivshmem-flat.c               | 477 +++++++++++++++++++++++++++
 hw/misc/meson.build                  |   2 +
 hw/misc/trace-events                 |  18 +
 include/hw/misc/ivshmem-flat.h       |  72 ++++
 10 files changed, 672 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 hw/misc/ivshmem-flat.c
 create mode 100644 include/hw/misc/ivshmem-flat.h

diff --git a/docs/system/devices/ivshmem-flat.rst b/docs/system/devices/ivshmem-flat.rst
new file mode 100644
index 0000000000..a10446a18f
--- /dev/null
+++ b/docs/system/devices/ivshmem-flat.rst
@@ -0,0 +1,89 @@
+Inter-VM Shared Memory Flat Device
+----------------------------------
+
+The ivshmem-flat device is meant to be used on machines that lack a PCI bus,
+making them unsuitable for the use of the traditional ivshmem device modeled as
+a PCI device. Machines like those with a Cortex-M MCU are good candidates to use
+the ivshmem-flat device. Also, since the flat version maps the control and
+status registers directly to the memory, it requires a quite tiny "device
+driver" to interact with other VMs, which is useful in some RTOSes, like
+Zephyr, which usually run on constrained resource targets.
+
+Similar to the ivshmem device, the ivshmem-flat device supports both peer
+notification via HW interrupts and Inter-VM shared memory. This allows the
+device to be used together with the traditional ivshmem, enabling communication
+between, for instance, an aarch64 VM  (using the traditional ivshmem device and
+running Linux), and an arm VM (using the ivshmem-flat device and running Zephyr
+instead).
+
+The ivshmem-flat device does not support the use of a ``memdev`` option (see
+ivshmem.rst for more details). It relies on the ivshmem server to create and
+distribute the proper shared memory file descriptor and the eventfd(s) to notify
+(interrupt) the peers. Therefore, to use this device, it is always necessary to
+have an ivshmem server up and running for proper device creation.
+
+Although the ivshmem-flat supports both peer notification (interrupts) and
+shared memory, the interrupt mechanism is optional. If no input IRQ is
+specified for the device it is disabled, preventing the VM from notifying or
+being notified by other VMs (a warning will be displayed to the user to inform
+the IRQ mechanism is disabled). The shared memory region is always present.
+
+The MMRs (INTRMASK, INTRSTATUS, IVPOSITION, and DOORBELL registers) offsets at
+the MMR region, and their functions, follow the ivshmem spec, so they work
+exactly as in the ivshmem PCI device (see ./specs/ivshmem-spec.txt).
+
+
+Device Options
+--------------
+
+The only required options to create an ivshmem-flat device are: (a) the UNIX
+socket where the ivshmem server is listening, usually ``/tmp/ivshmem_socket``;
+and (b) the bus type to be used by the device, which currently only supports
+"/sysbus" bus type.
+
+Example:
+
+.. parsed-literal::
+
+    |qemu-system-arm| -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat -device ivshmem-flat,x-bus-qompath="/sysbus",chardev=ivshmem_flat
+
+The other options are for fine tuning the device.
+
+``x-irq-qompath``. Used to inform the device which IRQ input line it can attach
+to enable the notification mechanism (IRQ). The ivshmem-flat device currently
+only supports notification via vector 0, ignoring other vectors.
+
+Two examples for different machines follow.
+
+Stellaris machine (``- machine lm3s6965evb``):
+
+::
+
+    x-irq-qompath=/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]
+
+Arm mps2-an385 machine (``-machine mps2-an385``):
+
+::
+
+    x-irq-qompath=/machine/armv7m/nvic/unnamed-gpio-in[0]
+
+The available IRQ input lines on a given VM that the ivshmem-flat device can be
+attached to can be inspected from the QEMU monitor (Ctrl-a + c) with:
+
+(qemu) info qom-tree
+
+``x-bus-address-mmr``. Allows changing the address where the MMRs are mapped
+into the VM memory layout. Default is 0x400FF000, but this address might be
+already taken on some VMs, hence it's  necessary to adjust the MMR location on
+some VMs.
+
+ ``x-bus-address-shmem``. Allows changing the address where the shared memory
+region is mapped into the VM memory layout. Default is 0x40100000, but this
+address might be already taken on some VMs, hence it's necessary to adjust the
+shared memory location.
+
+``shmem-size``. Allows changing the size (in bytes) of shared memroy region.
+Default is 4 MiB, which is the same default value used by the ivshmem server, so
+usually it's not necessary to change it. The  size must match the size of the
+shared memory reserverd and informed by the ivshmem server, otherwise device
+creation fails.
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d92fd60684..2bd0e6ba6e 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -474,6 +474,8 @@ static void mps2_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "mps.ram";
+
+    machine_class_allow_dynamic_sysbus_dev(mc, "ivshmem-flat");
 }
 
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f7e99baf62..792b7b57c1 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -28,6 +28,7 @@
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/ivshmem-flat.h"
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
@@ -720,7 +721,7 @@ static void stellaris_adc_fifo_write(StellarisADCState *s, int n,
 {
     int head;
 
-    /* TODO: Real hardware has limited size FIFOs.  We have a full 16 entry 
+    /* TODO: Real hardware has limited size FIFOs.  We have a full 16 entry
        FIFO fir each sequencer.  */
     head = (s->fifo[n].state >> 4) & 0xf;
     if (s->fifo[n].state & STELLARIS_ADC_FIFO_FULL) {
@@ -1344,6 +1345,8 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a13c658bbf..e26f9b54f8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -80,6 +80,7 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "hw/misc/ivshmem-flat.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -2938,6 +2939,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a..af43b67577 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -495,6 +495,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
+    TYPE_BINDING("ivshmem-flat", no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 6996d265e4..701df866ba 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -63,6 +63,11 @@ config IVSHMEM_DEVICE
     default y if PCI_DEVICES
     depends on PCI && LINUX && IVSHMEM && MSI_NONBROKEN
 
+config IVSHMEM_FLAT_DEVICE
+    bool
+    default y
+    depends on LINUX && IVSHMEM
+
 config ECCMEMCTL
     bool
     select ECC
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
new file mode 100644
index 0000000000..31731a38cf
--- /dev/null
+++ b/hw/misc/ivshmem-flat.c
@@ -0,0 +1,477 @@
+/*
+ * Inter-VM Shared Memory Flat Device
+ *
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "exec/address-spaces.h"
+#include "trace.h"
+
+#include "hw/misc/ivshmem-flat.h"
+
+static int64_t ivshmem_flat_recv_msg(IvshmemFTState *s, int *pfd)
+{
+    int64_t msg;
+    int n, ret;
+
+    n = 0;
+    do {
+        ret = qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n,
+                                   sizeof(msg) - n);
+        if (ret < 0) {
+            if (ret == -EINTR) {
+                continue;
+            }
+            exit(1);
+        }
+        n += ret;
+    } while (n < sizeof(msg));
+
+    *pfd = qemu_chr_fe_get_msgfd(&s->server_chr);
+    return le64_to_cpu(msg);
+}
+
+static void ivshmem_flat_irq_handler(void *opaque)
+{
+    VectorInfo *vi = opaque;
+    EventNotifier *e = &vi->event_notifier;
+    uint16_t vector_id;
+    const VectorInfo (*v)[64];
+
+    assert(e->initialized);
+
+    vector_id = vi->id;
+
+    /*
+     * The vector info struct is passed to the handler via the 'opaque' pointer.
+     * This struct pointer allows the retrieval of the vector ID and its
+     * associated event notifier. However, for triggering an interrupt using
+     * qemu_set_irq, it's necessary to also have a pointer to the device state,
+     * i.e., a pointer to the IvshmemFTState struct. Since the vector info
+     * struct is contained within the IvshmemFTState struct, its pointer can be
+     * used to obtain the pointer to IvshmemFTState through simple pointer math.
+     */
+    v = (void *)(vi - vector_id); /* v =  &IvshmemPeer->vector[0] */
+    IvshmemPeer *own_peer = container_of(v, IvshmemPeer, vector);
+    IvshmemFTState *s = container_of(own_peer, IvshmemFTState, own);
+
+    /* Clear event  */
+    if (!event_notifier_test_and_clear(e)) {
+        return;
+    }
+
+    trace_ivshmem_flat_irq_handler(vector_id);
+
+    /*
+     * Toggle device's output line, which is connected to interrupt controller,
+     * generating an interrupt request to the CPU.
+     */
+    qemu_set_irq(s->irq, true);
+    qemu_set_irq(s->irq, false);
+}
+
+static IvshmemPeer *ivshmem_flat_find_peer(IvshmemFTState *s, uint16_t peer_id)
+{
+    IvshmemPeer *peer;
+
+    /* Own ID */
+    if (s->own.id == peer_id) {
+        return &s->own;
+    }
+
+    /* Peer ID */
+    QTAILQ_FOREACH(peer, &s->peer, next) {
+        if (peer->id == peer_id) {
+            return peer;
+        }
+    }
+
+    return NULL;
+}
+
+static IvshmemPeer *ivshmem_flat_add_peer(IvshmemFTState *s, uint16_t peer_id)
+{
+    IvshmemPeer *new_peer;
+
+    new_peer = g_malloc0(sizeof(*new_peer));
+    new_peer->id = peer_id;
+    new_peer->vector_counter = 0;
+
+    QTAILQ_INSERT_TAIL(&s->peer, new_peer, next);
+
+    trace_ivshmem_flat_new_peer(peer_id);
+
+    return new_peer;
+}
+
+static void ivshmem_flat_remove_peer(IvshmemFTState *s, uint16_t peer_id)
+{
+   IvshmemPeer *peer;
+
+   peer = ivshmem_flat_find_peer(s, peer_id);
+   assert(peer);
+
+   QTAILQ_REMOVE(&s->peer, peer, next);
+   for (int n = 0; n < peer->vector_counter; n++) {
+       int efd;
+       efd = event_notifier_get_fd(&(peer->vector[n].event_notifier));
+       close(efd);
+   }
+
+   g_free(peer);
+}
+
+static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer, int vector_fd)
+{
+    if (peer->vector_counter >= IVSHMEM_MAX_VECTOR_NUM) {
+        trace_ivshmem_flat_add_vector_failure(peer->vector_counter, vector_fd, peer->id);
+        close(vector_fd);
+
+        return;
+    }
+
+    trace_ivshmem_flat_add_vector_success(peer->vector_counter, vector_fd, peer->id);
+
+    /*
+     * Set vector ID and its associated eventfd notifier and add them to the
+     * peer.
+     */
+    peer->vector[peer->vector_counter].id = peer->vector_counter;
+    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
+    event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier, vector_fd);
+
+    /*
+     * If it's the device's own ID, register also the handler for the eventfd so
+     * the device can be notified by the other peers.
+     */
+    if (peer == &s->own) {
+        qemu_set_fd_handler(vector_fd, ivshmem_flat_irq_handler, NULL, &peer->vector);
+    }
+
+    peer->vector_counter++;
+}
+
+static void ivshmem_flat_process_msg(IvshmemFTState *s, uint64_t msg, int fd) {
+    uint16_t peer_id;
+    IvshmemPeer *peer;
+
+    peer_id = msg & 0xFFFF;
+    peer = ivshmem_flat_find_peer(s, peer_id);
+
+    if (!peer) {
+        peer = ivshmem_flat_add_peer(s, peer_id);
+    }
+
+    if (fd >= 0) {
+        ivshmem_flat_add_vector(s, peer, fd);
+    } else { /* fd == -1, which is received when peers disconnect. */
+        ivshmem_flat_remove_peer(s, peer_id);
+    }
+}
+
+static int ivshmem_flat_can_receive_data(void *opaque)
+{
+    IvshmemFTState *s = opaque;
+
+    assert(s->msg_buffered_bytes < sizeof(s->msg_buf));
+    return sizeof(s->msg_buf) - s->msg_buffered_bytes;
+}
+
+static void ivshmem_flat_read_msg(void *opaque, const uint8_t *buf, int size)
+{
+    IvshmemFTState *s = opaque;
+    int fd;
+    int64_t msg;
+
+    assert(size >= 0 && s->msg_buffered_bytes + size <= sizeof(s->msg_buf));
+    memcpy((unsigned char *)&s->msg_buf + s->msg_buffered_bytes, buf, size);
+    s->msg_buffered_bytes += size;
+    if (s->msg_buffered_bytes < sizeof(s->msg_buf)) {
+        return;
+    }
+    msg = le64_to_cpu(s->msg_buf);
+    s->msg_buffered_bytes = 0;
+
+    fd = qemu_chr_fe_get_msgfd(&s->server_chr);
+
+    ivshmem_flat_process_msg(s, msg, fd);
+}
+
+/*
+ * Message sequence from server on new connection:
+ *  _____________________________________
+ * |STEP| uint64_t msg  | int fd         |
+ *  -------------------------------------
+ *
+ *  0    PROTOCOL        -1              \
+ *  1    OWN PEER ID     -1               |-- Header/Greeting
+ *  2    -1              shmem fd        /
+ *
+ *  3    PEER IDx        Other peer's Vector 0 eventfd
+ *  4    PEER IDx        Other peer's Vector 1 eventfd
+ *  .                    .
+ *  .                    .
+ *  .                    .
+ *  N    PEER IDy        Other peer's Vector 0 eventfd
+ *  N+1  PEER IDy        Other peer's Vector 1 eventfd
+ *  .                    .
+ *  .                    .
+ *  .                    .
+ *
+ *  ivshmem_flat_recv_msg() calls return 'msg' and 'fd'.
+ *
+ *  See ./docs/specs/ivshmem-spec.txt for details on the protocol.
+ */
+static void ivshmem_flat_realize(DeviceState *dev, Error **errp) {
+    IvshmemFTState *s = IVSHMEM_FLAT(dev);
+
+    int64_t protocol_version, msg;
+    int fd, shmem_fd, vector_fd;
+    uint16_t peer_id;
+
+    /* Input IRQ line, in the IRQ controller or CPU. */
+    Object *oirq;
+    bool ambiguous = false;
+
+    /* Device requires sysbus. */
+    if (s->bus_qompath) {
+        if (strcmp(s->bus_qompath, "/sysbus")) {
+            error_setg(errp, "ivshmem-flat requires '/sysbus' bus.");
+            return;
+        }
+    } else {
+        error_setg(errp, "Bus not specified. Use 'x-bus-qompath' to specify the bus type.");
+        return;
+    }
+
+    /* Check for input IRQ line, if it's provided, connect it. */
+    if (s->irq_qompath) {
+        oirq = object_resolve_path_type(s->irq_qompath, TYPE_IRQ, &ambiguous);
+        if (ambiguous) {
+            error_setg(errp, "Specified IRQ is ambiguous. Can't create ivshmem-flat device.");
+            return;
+        }
+
+        if (!oirq) {
+            error_setg(errp, "Can't resolve IRQ QOM path.");
+            return;
+        } else {
+            trace_ivshmem_flat_irq_resolved(s->irq_qompath);
+        }
+
+        /* Connect device out irq line to interrupt controller input irq line. */
+        qdev_connect_gpio_out_named(dev, "irq-output", 0, (qemu_irq)(oirq));
+
+        if (qemu_irq_is_connected((qemu_irq)(oirq))) {
+            trace_ivshmem_flat_irq_connected();
+        }
+    } else {
+       /*
+        * If input IRQ is not provided, warn user the device won't be able to trigger any
+        * interrupts.
+        */
+        warn_report("Input IRQ not specified, device won't be able to handle IRQs!");
+    }
+
+    /* Check ivshmem server connection. */
+    if (!qemu_chr_fe_backend_connected(&s->server_chr)) {
+        error_setg(errp, "ivshmem server socket not specified or incorret. Can't create device.\n");
+        return;
+    }
+
+    /* Step 0 */
+    protocol_version = ivshmem_flat_recv_msg(s, &fd);
+
+    /* Step 1 */
+    msg = ivshmem_flat_recv_msg(s, &vector_fd);
+    peer_id = 0xFFFF & msg;
+    s->own.id = peer_id;
+    s->own.vector_counter = 0;
+
+    trace_ivshmem_flat_proto_ver_own_id(protocol_version, s->own.id);
+
+    /* Step 2 */
+    msg = ivshmem_flat_recv_msg(s, &shmem_fd);
+    /* Map shmem fd and MMRs into memory regions. */
+    if (msg == -1 && shmem_fd >= 0) {
+        struct stat fdstat;
+
+        if (fstat(shmem_fd, &fdstat) != 0) {
+            error_setg(errp, "Could not determine shmem fd size. Can't create device!");
+
+            return;
+        }
+        trace_ivshmem_flat_shmem_size(fdstat.st_size);
+
+        /* Shmem size provided by the ivshmem server must be equal to device's shmem size. */
+        if (fdstat.st_size != s->shmem_size) {
+            error_setg(errp, "Can't map shmem fd: shmem size different from device size!");
+            return;
+        } else {
+            trace_ivshmem_flat_shmem_addr(shmem_fd, s->bus_address_shmem);
+            memory_region_init_ram_from_fd(&s->shmem, OBJECT(s), "ivshmem-shmem", fdstat.st_size,
+                                           RAM_SHARED, shmem_fd, 0, NULL);
+            memory_region_add_subregion(get_system_memory(), s->bus_address_shmem, &s->shmem);
+
+            trace_ivshmem_flat_mmr_addr(s->bus_address_mmr);
+            sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, s->bus_address_mmr);
+        }
+    }
+
+    /*
+     * Beyond step 2 ivshmem_process_msg, called by ivshmem_flat_read_msg handler -- when data is
+     * available on the server socket -- will handle the additional messages that will be generated
+     * by the server as peers connect or disconnect.
+     */
+    qemu_chr_fe_set_handlers(&s->server_chr, ivshmem_flat_can_receive_data, ivshmem_flat_read_msg,
+                             NULL, NULL, s, NULL, true);
+}
+
+static uint64_t ivshmem_flat_iomem_read(void *opaque, hwaddr offset, unsigned size)
+{
+    IvshmemFTState *s = opaque;
+    uint32_t ret;
+
+    trace_ivshmem_flat_read_mmr(offset);
+
+    switch (offset)
+    {
+        case INTMASK:
+            ret = 0; /* Ignore read since all bits are reserved in rev 1. */
+            break;
+        case INTSTATUS:
+            ret = 0; /* Ignore read since all bits are reserved in rev 1. */
+            break;
+        case IVPOSITION:
+            ret = s->own.id;
+            break;
+        case DOORBELL:
+            trace_ivshmem_flat_read_mmr_doorbell(); /* DOORBELL is write-only */
+            ret = 0;
+            break;
+        default:
+            /* Should never reach out here due to iomem map range being exact. */
+            trace_ivshmem_flat_read_write_mmr_invalid(offset);
+            ret = 0;
+    }
+
+    return ret;
+}
+
+static int ivshmem_flat_interrupt_peer(IvshmemFTState *s, uint16_t peer_id, uint16_t vector_id)
+{
+    IvshmemPeer *peer;
+
+    peer = ivshmem_flat_find_peer(s, peer_id);
+    if (!peer) {
+        trace_ivshmem_flat_interrupt_invalid_peer(peer_id);
+        return 1;
+    }
+
+    event_notifier_set(&(peer->vector[vector_id].event_notifier));
+
+    return 0;
+}
+
+static void ivshmem_flat_iomem_write(void *opaque, hwaddr offset, uint64_t value, unsigned size)
+{
+    IvshmemFTState *s = opaque;
+    uint16_t peer_id = (value >> 16) & 0xFFFF;
+    uint16_t vector_id = value & 0xFFFF;
+
+    trace_ivshmem_flat_write_mmr(offset);
+
+    switch (offset) {
+    case INTMASK:
+        break;
+    case INTSTATUS:
+        break;
+    case IVPOSITION:
+        break;
+    case DOORBELL:
+        trace_ivshmem_flat_interrupt_peer(peer_id, vector_id);
+        ivshmem_flat_interrupt_peer(s, peer_id, vector_id);
+        break;
+    default:
+        /* Should never reach out here due to iomem map range being exact. */
+        trace_ivshmem_flat_read_write_mmr_invalid(offset);
+        break;
+    }
+
+    return;
+}
+
+static const MemoryRegionOps ivshmem_flat_ops = {
+    .read = ivshmem_flat_iomem_read,
+    .write = ivshmem_flat_iomem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = { /* Read/write aligned at 32 bits. */
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void ivshmem_flat_instance_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IvshmemFTState *s = IVSHMEM_FLAT(obj);
+
+    /* Init mem region for 4 MMRs (ivshmem_registers), 32 bits each => 16 bytes (0x10) */
+    memory_region_init_io(&s->iomem, obj, &ivshmem_flat_ops, s, "ivshmem-mmr", 0x10);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    /* Create one output IRQ that will be connect to the machine's interrupt controller. */
+    qdev_init_gpio_out_named(dev, &s->irq, "irq-output", 1);
+
+    QTAILQ_INIT(&s->peer);
+}
+
+static Property ivshmem_flat_props[] = {
+    DEFINE_PROP_CHR("chardev", IvshmemFTState, server_chr),
+    DEFINE_PROP_UINT32("shmem-size", IvshmemFTState, shmem_size, 4194304), /* 4 MiB */
+    DEFINE_PROP_STRING("x-irq-qompath", IvshmemFTState, irq_qompath),
+    DEFINE_PROP_STRING("x-bus-qompath", IvshmemFTState, bus_qompath),
+    DEFINE_PROP_UINT64("x-bus-address-mmr", IvshmemFTState, bus_address_mmr, 0x400FF000),
+    DEFINE_PROP_UINT64("x-bus-address-shmem", IvshmemFTState, bus_address_shmem, 0x40100000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ivshmem_flat_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->hotpluggable = true;
+    dc->user_creatable = true;
+    dc->realize = ivshmem_flat_realize;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, ivshmem_flat_props);
+}
+
+static const TypeInfo ivshmem_flat_info = {
+    .name = TYPE_IVSHMEM_FLAT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IvshmemFTState),
+    .instance_init = ivshmem_flat_instance_init,
+    .class_init = ivshmem_flat_class_init,
+};
+
+static void ivshmem_flat_register_types(void)
+{
+    type_register_static(&ivshmem_flat_info);
+}
+
+type_init(ivshmem_flat_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d9a370c1de..7b03fc1345 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -36,7 +36,9 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 
 subdir('macio')
 
+# ivshmem devices
 system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e8b2be14c0..19a75c4d45 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -301,3 +301,21 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
 lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# ivshmem-flat.c
+ivshmem_flat_irq_handler(uint16_t vector_id) "Caught interrupt request: vector %d"
+ivshmem_flat_new_peer(uint16_t peer_id) "New peer ID: %d"
+ivshmem_flat_add_vector_failure(uint16_t vector_id, uint32_t vector_fd, uint16_t peer_id) "Failed to add vector %d (fd = %d) to peer ID %d, maximum number of vectors reached"
+ivshmem_flat_add_vector_success(uint16_t vector_id, uint32_t vector_fd, uint16_t peer_id) "Successful addition of vector %d (fd = %d) to peer ID %d"
+ivshmem_flat_irq_resolved(const char *irq_qompath) "IRQ QOM path '%s' correctly resolved"
+ivshmem_flat_irq_connected(void) "Device IRQ output line connected to Interrupt Controller IRQ input line"
+ivshmem_flat_proto_ver_own_id(uint64_t proto_ver, uint16_t peer_id) "Protocol Version = %lx, Own Peer ID = %d"
+ivshmem_flat_shmem_size(uint64_t size) "Shmem fd total size is %ld byte(s)"
+ivshmem_flat_shmem_addr(uint32_t fd, uint64_t addr) "Mapping shmem fd (%d) @ %#lx"
+ivshmem_flat_mmr_addr(uint64_t addr) "Mapping MMRs @ %#lx"
+ivshmem_flat_read_mmr(uint64_t addr_offset) "Read access at offset %ld"
+ivshmem_flat_read_mmr_doorbell(void) "DOORBELL register is write-only!"
+ivshmem_flat_read_write_mmr_invalid(uint64_t addr_offset) "No ivshmem register mapped at offset %ld"
+ivshmem_flat_interrupt_invalid_peer(uint16_t peer_id) "Can't interrupt non-existing peer %d"
+ivshmem_flat_write_mmr(uint64_t addr_offset) "Write access at offset %ld"
+ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Interrupting peer ID %d, vector %d..."
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
new file mode 100644
index 0000000000..2f6f7462f6
--- /dev/null
+++ b/include/hw/misc/ivshmem-flat.h
@@ -0,0 +1,72 @@
+/*
+ * Inter-VM Shared Memory Flat Device
+ *
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef IVSHMEM_FLAT_H
+#define IVSHMEM_FLAT_H
+
+#define IVSHMEM_MAX_VECTOR_NUM 64
+
+#define TYPE_IVSHMEM_FLAT "ivshmem-flat"
+typedef struct IvshmemFTState IvshmemFTState;
+
+DECLARE_INSTANCE_CHECKER(IvshmemFTState, IVSHMEM_FLAT, TYPE_IVSHMEM_FLAT)
+
+/* Ivshmem registers. See ./docs/specs/ivshmem-spec.txt for details. */
+enum ivshmem_registers {
+    INTMASK = 0,
+    INTSTATUS = 4,
+    IVPOSITION = 8,
+    DOORBELL = 12,
+};
+
+typedef struct VectorInfo {
+    EventNotifier event_notifier;
+    uint16_t id;
+} VectorInfo;
+
+typedef struct IvshmemPeer {
+    QTAILQ_ENTRY(IvshmemPeer) next;
+    VectorInfo vector[IVSHMEM_MAX_VECTOR_NUM];
+    int vector_counter;
+    uint16_t id;
+} IvshmemPeer;
+
+struct IvshmemFTState {
+    SysBusDevice parent_obj;
+
+    uint64_t msg_buf;
+    int msg_buffered_bytes;
+
+    QTAILQ_HEAD(, IvshmemPeer) peer;
+    IvshmemPeer own;
+
+    CharBackend server_chr;
+
+    char *bus_qompath;
+
+    /* IRQ */
+    qemu_irq irq;
+    char *irq_qompath;
+
+    /* MMRs */
+    MemoryRegion iomem;
+    uint64_t bus_address_mmr;
+    uint32_t intmask;
+    uint32_t intstatus;
+    uint32_t ivposition;
+    uint32_t doorbell;
+
+    /* Shared memory */
+    MemoryRegion shmem;
+    int shmem_fd;
+    uint32_t shmem_size;
+    uint64_t bus_address_shmem;
+};
+
+#endif /* IVSHMEM_FLAT_H */
-- 
2.34.1


