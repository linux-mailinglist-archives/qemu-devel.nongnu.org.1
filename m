Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE255B49672
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 19:04:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8p-0006xd-I3; Mon, 08 Sep 2025 12:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8a-0006ez-QL
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8N-0001aS-OT
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQx/oECd+eMogBWUPUCkeZ9e+yCISQHntFXEeKE/cs4=;
 b=FoCnFt04LZaVp6fcGRFZQ2LHxLK9OWRWzELd+6QVpkgrdTPjf8Jle22fS3Y2Dh+lfZr2Ez
 wJ9AFPjqZaKelpXWIKmjKNZBvzM95Vz3vbirz9pvkhNyKkeZKzi0o0MbcbGWJzqond84xe
 vXSgUMW/+1cnp42ar5Pb+BNHNk/3fJs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-QqoIIouXOVm1kbYaND0duw-1; Mon,
 08 Sep 2025 12:54:19 -0400
X-MC-Unique: QqoIIouXOVm1kbYaND0duw-1
X-Mimecast-MFC-AGG-ID: QqoIIouXOVm1kbYaND0duw_1757350458
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C7201800624
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 16:54:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4A0C3002D30; Mon,  8 Sep 2025 16:54:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 05/31] vfio: Remove 'vfio-platform'
Date: Mon,  8 Sep 2025 18:53:28 +0200
Message-ID: <20250908165354.1731444-6-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VFIO_PLATFORM device type has been deprecated in the QEMU 10.0
timeframe. All dependent devices have been removed. Now remove the
core vfio platform framework.

Rename VFIO_DEVICE_TYPE_PLATFORM enum to VFIO_DEVICE_TYPE_UNUSED to
maintain the same index for the CCW and AP VFIO device types.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250901064631.530723-8-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst       |  12 -
 docs/about/removed-features.rst |   9 +
 include/hw/vfio/vfio-device.h   |   2 +-
 include/hw/vfio/vfio-platform.h |  78 ----
 hw/arm/virt.c                   |   2 -
 hw/vfio/platform.c              | 716 --------------------------------
 hw/arm/Kconfig                  |   1 -
 hw/vfio/Kconfig                 |   6 -
 hw/vfio/meson.build             |   1 -
 hw/vfio/trace-events            |  11 -
 10 files changed, 10 insertions(+), 828 deletions(-)
 delete mode 100644 include/hw/vfio/vfio-platform.h
 delete mode 100644 hw/vfio/platform.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d0fa8e5536b583f1ec32a8aad4ec2649d1ee8097..2fa2c47b6807c02d9acd5fe6f6ba452de201a354 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -488,18 +488,6 @@ Stream ``reconnect`` (since 9.2)
 The ``reconnect`` option only allows specifying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
-VFIO device options
-'''''''''''''''''''
-
-``-device vfio-platform`` (since 10.0)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-The vfio-platform device allows to assign a host platform device
-to a guest in a generic manner. Integrating a new device into
-the vfio-platform infrastructure requires some adaptation at
-both kernel and qemu level. No such attempt has been done for years
-and the conclusion is that vfio-platform has not got any traction.
-PCIe passthrough shall be the mainline solution.
-
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index db3f22941c25e19ea9ce8fbba584819fc961c7e2..2d3a684e53a4e3c607e1feb539155e8ccb82b72f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1296,6 +1296,15 @@ The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
 to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
 is not supported anymore and there is no point keeping that device.
 
+``-device vfio-platform`` (since 10.2)
+''''''''''''''''''''''''''''''''''''''
+The vfio-platform device allows to assign a host platform device
+to a guest in a generic manner. Integrating a new device into
+the vfio-platform infrastructure requires some adaptation at
+both kernel and qemu level. No such attempt has been done for years
+and the conclusion is that vfio-platform has not got any traction.
+PCIe passthrough shall be the mainline solution.
+
 Tools
 -----
 
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6e4d5ccdac6eaae32fb2d3a59b9c7c85e13e156a..e7e6243e2dd7cf1be37d95414d6a511666f5cb39 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -36,7 +36,7 @@
 
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
-    VFIO_DEVICE_TYPE_PLATFORM = 1,
+    VFIO_DEVICE_TYPE_UNUSED = 1,
     VFIO_DEVICE_TYPE_CCW = 2,
     VFIO_DEVICE_TYPE_AP = 3,
 };
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
deleted file mode 100644
index 256d8500b70a2e985e975b0895e3cfca435ed8ed..0000000000000000000000000000000000000000
--- a/include/hw/vfio/vfio-platform.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * vfio based device assignment support - platform devices
- *
- * Copyright Linaro Limited, 2014
- *
- * Authors:
- *  Kim Phillips <kim.phillips@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Based on vfio based PCI device assignment support:
- *  Copyright Red Hat, Inc. 2012
- */
-
-#ifndef HW_VFIO_VFIO_PLATFORM_H
-#define HW_VFIO_VFIO_PLATFORM_H
-
-#include "hw/sysbus.h"
-#include "hw/vfio/vfio-device.h"
-#include "qemu/event_notifier.h"
-#include "qemu/queue.h"
-#include "qom/object.h"
-
-#define TYPE_VFIO_PLATFORM "vfio-platform"
-
-enum {
-    VFIO_IRQ_INACTIVE = 0,
-    VFIO_IRQ_PENDING = 1,
-    VFIO_IRQ_ACTIVE = 2,
-    /* VFIO_IRQ_ACTIVE_AND_PENDING cannot happen with VFIO */
-};
-
-typedef struct VFIOINTp {
-    QLIST_ENTRY(VFIOINTp) next; /* entry for IRQ list */
-    QSIMPLEQ_ENTRY(VFIOINTp) pqnext; /* entry for pending IRQ queue */
-    EventNotifier *interrupt; /* eventfd triggered on interrupt */
-    EventNotifier *unmask; /* eventfd for unmask on QEMU bypass */
-    qemu_irq qemuirq;
-    struct VFIOPlatformDevice *vdev; /* back pointer to device */
-    int state; /* inactive, pending, active */
-    uint8_t pin; /* index */
-    uint32_t flags; /* IRQ info flags */
-    bool kvm_accel; /* set when QEMU bypass through KVM enabled */
-} VFIOINTp;
-
-/* function type for user side eventfd handler */
-typedef void (*eventfd_user_side_handler_t)(VFIOINTp *intp);
-
-typedef struct VFIORegion VFIORegion;
-
-struct VFIOPlatformDevice {
-    SysBusDevice sbdev;
-    VFIODevice vbasedev; /* not a QOM object */
-    VFIORegion **regions;
-    QLIST_HEAD(, VFIOINTp) intp_list; /* list of IRQs */
-    /* queue of pending IRQs */
-    QSIMPLEQ_HEAD(, VFIOINTp) pending_intp_queue;
-    char *compat; /* DT compatible values, separated by NUL */
-    unsigned int num_compat; /* number of compatible values */
-    uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
-    QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
-    QemuMutex intp_mutex; /* protect the intp_list IRQ state */
-    bool irqfd_allowed; /* debug option to force irqfd on/off */
-};
-typedef struct VFIOPlatformDevice VFIOPlatformDevice;
-
-struct VFIOPlatformDeviceClass {
-    /*< private >*/
-    SysBusDeviceClass parent_class;
-    /*< public >*/
-};
-typedef struct VFIOPlatformDeviceClass VFIOPlatformDeviceClass;
-
-DECLARE_OBJ_CHECKERS(VFIOPlatformDevice, VFIOPlatformDeviceClass,
-                     VFIO_PLATFORM_DEVICE, TYPE_VFIO_PLATFORM)
-
-#endif /* HW_VFIO_VFIO_PLATFORM_H */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6a887228bbb8b65cf8e38f14d839fe1e80b8abce..6f01746e746066b6b9dd70d7899a97e3af876b85 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -38,7 +38,6 @@
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
-#include "hw/vfio/vfio-platform.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
 #include "system/device_tree.h"
@@ -3218,7 +3217,6 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
      */
     mc->max_cpus = 512;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
deleted file mode 100644
index 5c1795a26fe79b98a9886e15f365fa7a921409a4..0000000000000000000000000000000000000000
--- a/hw/vfio/platform.c
+++ /dev/null
@@ -1,716 +0,0 @@
-/*
- * vfio based device assignment support - platform devices
- *
- * Copyright Linaro Limited, 2014
- *
- * Authors:
- *  Kim Phillips <kim.phillips@linaro.org>
- *  Eric Auger <eric.auger@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Based on vfio based PCI device assignment support:
- *  Copyright Red Hat, Inc. 2012
- */
-
-#include "qemu/osdep.h"
-#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
-#include "qapi/error.h"
-#include <sys/ioctl.h>
-#include <linux/vfio.h>
-
-#include "hw/vfio/vfio-platform.h"
-#include "system/iommufd.h"
-#include "migration/vmstate.h"
-#include "qemu/error-report.h"
-#include "qemu/lockable.h"
-#include "qemu/main-loop.h"
-#include "qemu/module.h"
-#include "qemu/range.h"
-#include "system/memory.h"
-#include "system/address-spaces.h"
-#include "qemu/queue.h"
-#include "hw/sysbus.h"
-#include "trace.h"
-#include "hw/irq.h"
-#include "hw/platform-bus.h"
-#include "hw/qdev-properties.h"
-#include "system/kvm.h"
-#include "hw/vfio/vfio-region.h"
-
-/*
- * Functions used whatever the injection method
- */
-
-static inline bool vfio_irq_is_automasked(VFIOINTp *intp)
-{
-    return intp->flags & VFIO_IRQ_INFO_AUTOMASKED;
-}
-
-/**
- * vfio_init_intp - allocate, initialize the IRQ struct pointer
- * and add it into the list of IRQs
- * @vbasedev: the VFIO device handle
- * @info: irq info struct retrieved from VFIO driver
- * @errp: error object
- */
-static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
-                                struct vfio_irq_info info, Error **errp)
-{
-    int ret;
-    VFIOPlatformDevice *vdev =
-        container_of(vbasedev, VFIOPlatformDevice, vbasedev);
-    SysBusDevice *sbdev = SYS_BUS_DEVICE(vdev);
-    VFIOINTp *intp;
-
-    intp = g_malloc0(sizeof(*intp));
-    intp->vdev = vdev;
-    intp->pin = info.index;
-    intp->flags = info.flags;
-    intp->state = VFIO_IRQ_INACTIVE;
-    intp->kvm_accel = false;
-
-    sysbus_init_irq(sbdev, &intp->qemuirq);
-
-    /* Get an eventfd for trigger */
-    intp->interrupt = g_new0(EventNotifier, 1);
-    ret = event_notifier_init(intp->interrupt, 0);
-    if (ret) {
-        g_free(intp->interrupt);
-        g_free(intp);
-        error_setg_errno(errp, -ret,
-                         "failed to initialize trigger eventfd notifier");
-        return NULL;
-    }
-    if (vfio_irq_is_automasked(intp)) {
-        /* Get an eventfd for resample/unmask */
-        intp->unmask = g_new0(EventNotifier, 1);
-        ret = event_notifier_init(intp->unmask, 0);
-        if (ret) {
-            g_free(intp->interrupt);
-            g_free(intp->unmask);
-            g_free(intp);
-            error_setg_errno(errp, -ret,
-                             "failed to initialize resample eventfd notifier");
-            return NULL;
-        }
-    }
-
-    QLIST_INSERT_HEAD(&vdev->intp_list, intp, next);
-    return intp;
-}
-
-/**
- * vfio_set_trigger_eventfd - set VFIO eventfd handling
- *
- * @intp: IRQ struct handle
- * @handler: handler to be called on eventfd signaling
- *
- * Setup VFIO signaling and attach an optional user-side handler
- * to the eventfd
- */
-static int vfio_set_trigger_eventfd(VFIOINTp *intp,
-                                    eventfd_user_side_handler_t handler)
-{
-    VFIODevice *vbasedev = &intp->vdev->vbasedev;
-    int32_t fd = event_notifier_get_fd(intp->interrupt);
-    Error *err = NULL;
-
-    qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
-
-    if (!vfio_device_irq_set_signaling(vbasedev, intp->pin, 0,
-                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
-        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
-        qemu_set_fd_handler(fd, NULL, NULL, NULL);
-        return -EINVAL;
-    }
-
-    return 0;
-}
-
-/*
- * Functions only used when eventfds are handled on user-side
- * ie. without irqfd
- */
-
-/**
- * vfio_mmap_set_enabled - enable/disable the fast path mode
- * @vdev: the VFIO platform device
- * @enabled: the target mmap state
- *
- * enabled = true ~ fast path = MMIO region is mmaped (no KVM TRAP);
- * enabled = false ~ slow path = MMIO region is trapped and region callbacks
- * are called; slow path enables to trap the device IRQ status register reset
-*/
-
-static void vfio_mmap_set_enabled(VFIOPlatformDevice *vdev, bool enabled)
-{
-    int i;
-
-    for (i = 0; i < vdev->vbasedev.num_regions; i++) {
-        vfio_region_mmaps_set_enabled(vdev->regions[i], enabled);
-    }
-}
-
-/**
- * vfio_intp_mmap_enable - timer function, restores the fast path
- * if there is no more active IRQ
- * @opaque: actually points to the VFIO platform device
- *
- * Called on mmap timer timeout, this function checks whether the
- * IRQ is still active and if not, restores the fast path.
- * by construction a single eventfd is handled at a time.
- * if the IRQ is still active, the timer is re-programmed.
- */
-static void vfio_intp_mmap_enable(void *opaque)
-{
-    VFIOINTp *tmp;
-    VFIOPlatformDevice *vdev = (VFIOPlatformDevice *)opaque;
-
-    QEMU_LOCK_GUARD(&vdev->intp_mutex);
-    QLIST_FOREACH(tmp, &vdev->intp_list, next) {
-        if (tmp->state == VFIO_IRQ_ACTIVE) {
-            trace_vfio_platform_intp_mmap_enable(tmp->pin);
-            /* re-program the timer to check active status later */
-            timer_mod(vdev->mmap_timer,
-                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                          vdev->mmap_timeout);
-            return;
-        }
-    }
-    vfio_mmap_set_enabled(vdev, true);
-}
-
-/**
- * vfio_intp_inject_pending_lockheld - Injects a pending IRQ
- * @opaque: opaque pointer, in practice the VFIOINTp handle
- *
- * The function is called on a previous IRQ completion, from
- * vfio_platform_eoi, while the intp_mutex is locked.
- * Also in such situation, the slow path already is set and
- * the mmap timer was already programmed.
- */
-static void vfio_intp_inject_pending_lockheld(VFIOINTp *intp)
-{
-    trace_vfio_platform_intp_inject_pending_lockheld(intp->pin,
-                              event_notifier_get_fd(intp->interrupt));
-
-    intp->state = VFIO_IRQ_ACTIVE;
-
-    /* trigger the virtual IRQ */
-    qemu_set_irq(intp->qemuirq, 1);
-}
-
-/**
- * vfio_intp_interrupt - The user-side eventfd handler
- * @opaque: opaque pointer which in practice is the VFIOINTp handle
- *
- * the function is entered in event handler context:
- * the vIRQ is injected into the guest if there is no other active
- * or pending IRQ.
- */
-static void vfio_intp_interrupt(VFIOINTp *intp)
-{
-    int ret;
-    VFIOINTp *tmp;
-    VFIOPlatformDevice *vdev = intp->vdev;
-    bool delay_handling = false;
-
-    QEMU_LOCK_GUARD(&vdev->intp_mutex);
-    if (intp->state == VFIO_IRQ_INACTIVE) {
-        QLIST_FOREACH(tmp, &vdev->intp_list, next) {
-            if (tmp->state == VFIO_IRQ_ACTIVE ||
-                tmp->state == VFIO_IRQ_PENDING) {
-                delay_handling = true;
-                break;
-            }
-        }
-    }
-    if (delay_handling) {
-        /*
-         * the new IRQ gets a pending status and is pushed in
-         * the pending queue
-         */
-        intp->state = VFIO_IRQ_PENDING;
-        trace_vfio_intp_interrupt_set_pending(intp->pin);
-        QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
-                             intp, pqnext);
-        event_notifier_test_and_clear(intp->interrupt);
-        return;
-    }
-
-    trace_vfio_platform_intp_interrupt(intp->pin,
-                              event_notifier_get_fd(intp->interrupt));
-
-    ret = event_notifier_test_and_clear(intp->interrupt);
-    if (!ret) {
-        error_report("Error when clearing fd=%d (ret = %d)",
-                     event_notifier_get_fd(intp->interrupt), ret);
-    }
-
-    intp->state = VFIO_IRQ_ACTIVE;
-
-    /* sets slow path */
-    vfio_mmap_set_enabled(vdev, false);
-
-    /* trigger the virtual IRQ */
-    qemu_set_irq(intp->qemuirq, 1);
-
-    /*
-     * Schedule the mmap timer which will restore fastpath when no IRQ
-     * is active anymore
-     */
-    if (vdev->mmap_timeout) {
-        timer_mod(vdev->mmap_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                      vdev->mmap_timeout);
-    }
-}
-
-/**
- * vfio_platform_eoi - IRQ completion routine
- * @vbasedev: the VFIO device handle
- *
- * De-asserts the active virtual IRQ and unmasks the physical IRQ
- * (effective for level sensitive IRQ auto-masked by the  VFIO driver).
- * Then it handles next pending IRQ if any.
- * eoi function is called on the first access to any MMIO region
- * after an IRQ was triggered, trapped since slow path was set.
- * It is assumed this access corresponds to the IRQ status
- * register reset. With such a mechanism, a single IRQ can be
- * handled at a time since there is no way to know which IRQ
- * was completed by the guest (we would need additional details
- * about the IRQ status register mask).
- */
-static void vfio_platform_eoi(VFIODevice *vbasedev)
-{
-    VFIOINTp *intp;
-    VFIOPlatformDevice *vdev =
-        container_of(vbasedev, VFIOPlatformDevice, vbasedev);
-
-    QEMU_LOCK_GUARD(&vdev->intp_mutex);
-    QLIST_FOREACH(intp, &vdev->intp_list, next) {
-        if (intp->state == VFIO_IRQ_ACTIVE) {
-            trace_vfio_platform_eoi(intp->pin,
-                                event_notifier_get_fd(intp->interrupt));
-            intp->state = VFIO_IRQ_INACTIVE;
-
-            /* deassert the virtual IRQ */
-            qemu_set_irq(intp->qemuirq, 0);
-
-            if (vfio_irq_is_automasked(intp)) {
-                /* unmasks the physical level-sensitive IRQ */
-                vfio_device_irq_unmask(vbasedev, intp->pin);
-            }
-
-            /* a single IRQ can be active at a time */
-            break;
-        }
-    }
-    /* in case there are pending IRQs, handle the first one */
-    if (!QSIMPLEQ_EMPTY(&vdev->pending_intp_queue)) {
-        intp = QSIMPLEQ_FIRST(&vdev->pending_intp_queue);
-        vfio_intp_inject_pending_lockheld(intp);
-        QSIMPLEQ_REMOVE_HEAD(&vdev->pending_intp_queue, pqnext);
-    }
-}
-
-/**
- * vfio_start_eventfd_injection - starts the virtual IRQ injection using
- * user-side handled eventfds
- * @sbdev: the sysbus device handle
- * @irq: the qemu irq handle
- */
-
-static void vfio_start_eventfd_injection(SysBusDevice *sbdev, qemu_irq irq)
-{
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
-    VFIOINTp *intp;
-
-    QLIST_FOREACH(intp, &vdev->intp_list, next) {
-        if (intp->qemuirq == irq) {
-            break;
-        }
-    }
-    assert(intp);
-
-    if (vfio_set_trigger_eventfd(intp, vfio_intp_interrupt)) {
-        abort();
-    }
-}
-
-/*
- * Functions used for irqfd
- */
-
-/**
- * vfio_set_resample_eventfd - sets the resamplefd for an IRQ
- * @intp: the IRQ struct handle
- * programs the VFIO driver to unmask this IRQ when the
- * intp->unmask eventfd is triggered
- */
-static int vfio_set_resample_eventfd(VFIOINTp *intp)
-{
-    int32_t fd = event_notifier_get_fd(intp->unmask);
-    VFIODevice *vbasedev = &intp->vdev->vbasedev;
-    Error *err = NULL;
-
-    qemu_set_fd_handler(fd, NULL, NULL, NULL);
-    if (!vfio_device_irq_set_signaling(vbasedev, intp->pin, 0,
-                                       VFIO_IRQ_SET_ACTION_UNMASK, fd, &err)) {
-        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
-        return -EINVAL;
-    }
-    return 0;
-}
-
-/**
- * vfio_start_irqfd_injection - starts the virtual IRQ injection using
- * irqfd
- *
- * @sbdev: the sysbus device handle
- * @irq: the qemu irq handle
- *
- * In case the irqfd setup fails, we fallback to userspace handled eventfd
- */
-static void vfio_start_irqfd_injection(SysBusDevice *sbdev, qemu_irq irq)
-{
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
-    VFIOINTp *intp;
-
-    if (!kvm_irqfds_enabled() || !kvm_resamplefds_enabled() ||
-        !vdev->irqfd_allowed) {
-        goto fail_irqfd;
-    }
-
-    QLIST_FOREACH(intp, &vdev->intp_list, next) {
-        if (intp->qemuirq == irq) {
-            break;
-        }
-    }
-    assert(intp);
-
-    if (kvm_irqchip_add_irqfd_notifier(kvm_state, intp->interrupt,
-                                   intp->unmask, irq) < 0) {
-        goto fail_irqfd;
-    }
-
-    if (vfio_set_trigger_eventfd(intp, NULL) < 0) {
-        goto fail_vfio;
-    }
-    if (vfio_irq_is_automasked(intp)) {
-        if (vfio_set_resample_eventfd(intp) < 0) {
-            goto fail_vfio;
-        }
-        trace_vfio_platform_start_level_irqfd_injection(intp->pin,
-                                    event_notifier_get_fd(intp->interrupt),
-                                    event_notifier_get_fd(intp->unmask));
-    } else {
-        trace_vfio_platform_start_edge_irqfd_injection(intp->pin,
-                                    event_notifier_get_fd(intp->interrupt));
-    }
-
-    intp->kvm_accel = true;
-
-    return;
-fail_vfio:
-    kvm_irqchip_remove_irqfd_notifier(kvm_state, intp->interrupt, irq);
-    abort();
-fail_irqfd:
-    vfio_start_eventfd_injection(sbdev, irq);
-}
-
-/* VFIO skeleton */
-
-static void vfio_platform_compute_needs_reset(VFIODevice *vbasedev)
-{
-    vbasedev->needs_reset = true;
-}
-
-/* not implemented yet */
-static int vfio_platform_hot_reset_multi(VFIODevice *vbasedev)
-{
-    return -1;
-}
-
-/**
- * vfio_populate_device - Allocate and populate MMIO region
- * and IRQ structs according to driver returned information
- * @vbasedev: the VFIO device handle
- * @errp: error object
- *
- */
-static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
-{
-    VFIOINTp *intp, *tmp;
-    int i, ret = -1;
-    VFIOPlatformDevice *vdev =
-        container_of(vbasedev, VFIOPlatformDevice, vbasedev);
-
-    if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PLATFORM)) {
-        error_setg(errp, "this isn't a platform device");
-        return false;
-    }
-
-    vdev->regions = g_new0(VFIORegion *, vbasedev->num_regions);
-
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        char *name = g_strdup_printf("VFIO %s region %d\n", vbasedev->name, i);
-
-        vdev->regions[i] = g_new0(VFIORegion, 1);
-        ret = vfio_region_setup(OBJECT(vdev), vbasedev,
-                                vdev->regions[i], i, name);
-        g_free(name);
-        if (ret) {
-            error_setg_errno(errp, -ret, "failed to get region %d info", i);
-            goto reg_error;
-        }
-    }
-
-    vdev->mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                    vfio_intp_mmap_enable, vdev);
-
-    QSIMPLEQ_INIT(&vdev->pending_intp_queue);
-
-    for (i = 0; i < vbasedev->num_irqs; i++) {
-        struct vfio_irq_info irq;
-
-        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
-
-        if (ret) {
-            error_setg_errno(errp, -ret, "failed to get device irq info");
-            goto irq_err;
-        } else {
-            trace_vfio_platform_populate_interrupts(irq.index,
-                                                    irq.count,
-                                                    irq.flags);
-            intp = vfio_init_intp(vbasedev, irq, errp);
-            if (!intp) {
-                goto irq_err;
-            }
-        }
-    }
-    return true;
-irq_err:
-    timer_del(vdev->mmap_timer);
-    QLIST_FOREACH_SAFE(intp, &vdev->intp_list, next, tmp) {
-        QLIST_REMOVE(intp, next);
-        g_free(intp);
-    }
-reg_error:
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        if (vdev->regions[i]) {
-            vfio_region_finalize(vdev->regions[i]);
-        }
-        g_free(vdev->regions[i]);
-    }
-    g_free(vdev->regions);
-    return false;
-}
-
-/* specialized functions for VFIO Platform devices */
-static VFIODeviceOps vfio_platform_ops = {
-    .vfio_compute_needs_reset = vfio_platform_compute_needs_reset,
-    .vfio_hot_reset_multi = vfio_platform_hot_reset_multi,
-    .vfio_eoi = vfio_platform_eoi,
-};
-
-/**
- * vfio_base_device_init - perform preliminary VFIO setup
- * @vbasedev: the VFIO device handle
- * @errp: error object
- *
- * Implement the VFIO command sequence that allows to discover
- * assigned device resources: group extraction, device
- * fd retrieval, resource query.
- * Precondition: the device name must be initialized
- */
-static bool vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
-{
-    /* @fd takes precedence over @sysfsdev which takes precedence over @host */
-    if (vbasedev->fd < 0 && vbasedev->sysfsdev) {
-        vfio_device_free_name(vbasedev);
-        vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
-    } else if (vbasedev->fd < 0) {
-        if (!vbasedev->name || strchr(vbasedev->name, '/')) {
-            error_setg(errp, "wrong host device name");
-            return false;
-        }
-
-        vbasedev->sysfsdev = g_strdup_printf("/sys/bus/platform/devices/%s",
-                                             vbasedev->name);
-    }
-
-    if (!vfio_device_get_name(vbasedev, errp)) {
-        return false;
-    }
-
-    if (!vfio_device_attach(vbasedev->name, vbasedev,
-                            &address_space_memory, errp)) {
-        return false;
-    }
-
-    if (vfio_populate_device(vbasedev, errp)) {
-        return true;
-    }
-
-    vfio_device_detach(vbasedev);
-    return false;
-}
-
-/**
- * vfio_platform_realize  - the device realize function
- * @dev: device state pointer
- * @errp: error
- *
- * initialize the device, its memory regions and IRQ structures
- * IRQ are started separately
- */
-static void vfio_platform_realize(DeviceState *dev, Error **errp)
-{
-    ERRP_GUARD();
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
-    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
-    VFIODevice *vbasedev = &vdev->vbasedev;
-    int i;
-
-    warn_report("-device vfio-platform is deprecated");
-    qemu_mutex_init(&vdev->intp_mutex);
-
-    trace_vfio_platform_realize(vbasedev->sysfsdev ?
-                                vbasedev->sysfsdev : vbasedev->name,
-                                vdev->compat);
-
-    if (!vfio_base_device_init(vbasedev, errp)) {
-        goto init_err;
-    }
-
-    if (!vdev->compat) {
-        GError *gerr = NULL;
-        gchar *contents;
-        gsize length;
-        char *path;
-
-        path = g_strdup_printf("%s/of_node/compatible", vbasedev->sysfsdev);
-        if (!g_file_get_contents(path, &contents, &length, &gerr)) {
-            error_setg(errp, "%s", gerr->message);
-            g_error_free(gerr);
-            g_free(path);
-            return;
-        }
-        g_free(path);
-        vdev->compat = contents;
-        for (vdev->num_compat = 0; length; vdev->num_compat++) {
-            size_t skip = strlen(contents) + 1;
-            contents += skip;
-            length -= skip;
-        }
-    }
-
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        if (vfio_region_mmap(vdev->regions[i])) {
-            warn_report("%s mmap unsupported, performance may be slow",
-                        memory_region_name(vdev->regions[i]->mem));
-        }
-        sysbus_init_mmio(sbdev, vdev->regions[i]->mem);
-    }
-    return;
-
-init_err:
-    if (vdev->vbasedev.name) {
-        error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-    } else {
-        error_prepend(errp, "vfio error: ");
-    }
-}
-
-static const VMStateDescription vfio_platform_vmstate = {
-    .name = "vfio-platform",
-    .unmigratable = 1,
-};
-
-static const Property vfio_platform_dev_properties[] = {
-    DEFINE_PROP_STRING("host", VFIOPlatformDevice, vbasedev.name),
-    DEFINE_PROP_STRING("sysfsdev", VFIOPlatformDevice, vbasedev.sysfsdev),
-    DEFINE_PROP_BOOL("x-no-mmap", VFIOPlatformDevice, vbasedev.no_mmap, false),
-    DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
-                       mmap_timeout, 1100),
-    DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
-#ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
-                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-#endif
-};
-
-static void vfio_platform_instance_init(Object *obj)
-{
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
-    VFIODevice *vbasedev = &vdev->vbasedev;
-
-    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
-                     DEVICE(vdev), false);
-}
-
-#ifdef CONFIG_IOMMUFD
-static void vfio_platform_set_fd(Object *obj, const char *str, Error **errp)
-{
-    vfio_device_set_fd(&VFIO_PLATFORM_DEVICE(obj)->vbasedev, str, errp);
-}
-#endif
-
-static void vfio_platform_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
-
-    dc->realize = vfio_platform_realize;
-    device_class_set_props(dc, vfio_platform_dev_properties);
-#ifdef CONFIG_IOMMUFD
-    object_class_property_add_str(klass, "fd", NULL, vfio_platform_set_fd);
-#endif
-    dc->vmsd = &vfio_platform_vmstate;
-    dc->desc = "VFIO-based platform device assignment";
-    sbc->connect_irq_notifier = vfio_start_irqfd_injection;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-
-    object_class_property_set_description(klass, /* 2.4 */
-                                          "host",
-                                          "Host device name of assigned device");
-    object_class_property_set_description(klass, /* 2.4 and 2.5 */
-                                          "x-no-mmap",
-                                          "Disable MMAP for device. Allows to trace MMIO "
-                                          "accesses (DEBUG)");
-    object_class_property_set_description(klass, /* 2.4 */
-                                          "mmap-timeout-ms",
-                                          "When EOI is not provided by KVM/QEMU, wait time "
-                                          "(milliseconds) to re-enable device direct access "
-                                          "after level interrupt (DEBUG)");
-    object_class_property_set_description(klass, /* 2.4 */
-                                          "x-irqfd",
-                                          "Allow disabling irqfd support (DEBUG)");
-    object_class_property_set_description(klass, /* 2.6 */
-                                          "sysfsdev",
-                                          "Host sysfs path of assigned device");
-#ifdef CONFIG_IOMMUFD
-    object_class_property_set_description(klass, /* 9.0 */
-                                          "iommufd",
-                                          "Set host IOMMUFD backend device");
-#endif
-}
-
-static const TypeInfo vfio_platform_dev_info = {
-    .name = TYPE_VFIO_PLATFORM,
-    .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
-    .instance_size = sizeof(VFIOPlatformDevice),
-    .instance_init = vfio_platform_instance_init,
-    .class_init = vfio_platform_class_init,
-    .class_size = sizeof(VFIOPlatformDeviceClass),
-};
-
-static void register_vfio_platform_dev_type(void)
-{
-    type_register_static(&vfio_platform_dev_info);
-}
-
-type_init(register_vfio_platform_dev_type)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3fca48349ade97002597c866fa6457a784c3219d..3baa6c6c74778683de25ea1349eccace1275cedd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -5,7 +5,6 @@ config ARM_VIRT
     depends on TCG || KVM || HVF
     imply PCI_DEVICES
     imply TEST_DEVICES
-    imply VFIO_PLATFORM
     imply TPM_TIS_SYSBUS
     imply TPM_TIS_I2C
     imply NVDIMM
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 9a1dbe29267ea61709c3e28e4f8c25be01c3aa33..27de24e4db1f080d94be8d666e56812e1e904f1a 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -17,12 +17,6 @@ config VFIO_CCW
     select VFIO
     depends on LINUX && S390_CCW_VIRTIO
 
-config VFIO_PLATFORM
-    bool
-    default y
-    select VFIO
-    depends on LINUX && PLATFORM_BUS
-
 config VFIO_AP
     bool
     default y
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 06473a078990eab9ec5ce76a6d9897326280dc03..d3ed3cb7ac19931f95f60057c3d9d290bc48c07c 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -13,7 +13,6 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index fc6ed230d0c89d4b94e5878043bc23d94dcfe737..e3d571f8c845dad85de5738f8ca768bdfc336252 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -127,17 +127,6 @@ vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Re
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 
-# platform.c
-vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
-vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
-vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"
-vfio_platform_intp_interrupt(int pin, int fd) "Inject IRQ #%d (fd = %d)"
-vfio_platform_intp_inject_pending_lockheld(int pin, int fd) "Inject pending IRQ #%d (fd = %d)"
-vfio_platform_populate_interrupts(int pin, int count, int flags) "- IRQ index %d: count %d, flags=0x%x"
-vfio_intp_interrupt_set_pending(int index) "irq %d is set PENDING"
-vfio_platform_start_level_irqfd_injection(int index, int fd, int resamplefd) "IRQ index=%d, fd = %d, resamplefd = %d"
-vfio_platform_start_edge_irqfd_injection(int index, int fd) "IRQ index=%d, fd = %d"
-
 # spapr.c
 vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
 vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
-- 
2.51.0


