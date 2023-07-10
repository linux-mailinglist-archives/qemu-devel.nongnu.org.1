Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2CC74CF0E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:50:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleH-0006V6-2q; Mon, 10 Jul 2023 03:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIle6-0006Pl-Lo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:23 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIle4-0006wr-Hu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx3L456jz4wyG;
 Mon, 10 Jul 2023 17:49:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx3J5ljBz4wy9;
 Mon, 10 Jul 2023 17:49:16 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/11] s390x/ap: Wire up the device request notifier interface
Date: Mon, 10 Jul 2023 09:48:46 +0200
Message-ID: <20230710074848.456453-10-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Tony Krowiak <akrowiak@linux.ibm.com>

Let's wire up the device request notifier interface to handle device unplug
requests for AP.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20230530225544.280031-1-akrowiak@linux.ibm.com/
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index e0dd561e85a3..6e21d1da5a70 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -18,6 +18,8 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
+#include "qemu/event_notifier.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -33,6 +35,7 @@
 struct VFIOAPDevice {
     APDevice apdev;
     VFIODevice vdev;
+    EventNotifier req_notifier;
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
@@ -84,10 +87,110 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
     return vfio_get_group(groupid, &address_space_memory, errp);
 }
 
+static void vfio_ap_req_notifier_handler(void *opaque)
+{
+    VFIOAPDevice *vapdev = opaque;
+    Error *err = NULL;
+
+    if (!event_notifier_test_and_clear(&vapdev->req_notifier)) {
+        return;
+    }
+
+    qdev_unplug(DEVICE(vapdev), &err);
+
+    if (err) {
+        warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
+    }
+}
+
+static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
+                                          unsigned int irq, Error **errp)
+{
+    int fd;
+    size_t argsz;
+    IOHandler *fd_read;
+    EventNotifier *notifier;
+    struct vfio_irq_info *irq_info;
+    VFIODevice *vdev = &vapdev->vdev;
+
+    switch (irq) {
+    case VFIO_AP_REQ_IRQ_INDEX:
+        notifier = &vapdev->req_notifier;
+        fd_read = vfio_ap_req_notifier_handler;
+        break;
+    default:
+        error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
+        return;
+    }
+
+    if (vdev->num_irqs < irq + 1) {
+        error_setg(errp, "vfio: IRQ %u not available (number of irqs %u)",
+                   irq, vdev->num_irqs);
+        return;
+    }
+
+    argsz = sizeof(*irq_info);
+    irq_info = g_malloc0(argsz);
+    irq_info->index = irq;
+    irq_info->argsz = argsz;
+
+    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
+              irq_info) < 0 || irq_info->count < 1) {
+        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+        goto out_free_info;
+    }
+
+    if (event_notifier_init(notifier, 0)) {
+        error_setg_errno(errp, errno,
+                         "vfio: Unable to init event notifier for irq (%d)",
+                         irq);
+        goto out_free_info;
+    }
+
+    fd = event_notifier_get_fd(notifier);
+    qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
+
+    if (vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
+                               errp)) {
+        qemu_set_fd_handler(fd, NULL, NULL, vapdev);
+        event_notifier_cleanup(notifier);
+    }
+
+out_free_info:
+    g_free(irq_info);
+
+}
+
+static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
+                                            unsigned int irq)
+{
+    Error *err = NULL;
+    EventNotifier *notifier;
+
+    switch (irq) {
+    case VFIO_AP_REQ_IRQ_INDEX:
+        notifier = &vapdev->req_notifier;
+        break;
+    default:
+        error_report("vfio: Unsupported device irq(%d)", irq);
+        return;
+    }
+
+    if (vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+        warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
+    }
+
+    qemu_set_fd_handler(event_notifier_get_fd(notifier),
+                        NULL, NULL, vapdev);
+    event_notifier_cleanup(notifier);
+}
+
 static void vfio_ap_realize(DeviceState *dev, Error **errp)
 {
     int ret;
     char *mdevid;
+    Error *err = NULL;
     VFIOGroup *vfio_group;
     APDevice *apdev = AP_DEVICE(dev);
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
@@ -116,6 +219,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         goto out_get_dev_err;
     }
 
+    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
+    if (err) {
+        /*
+         * Report this error, but do not make it a failing condition.
+         * Lack of this IRQ in the host does not prevent normal operation.
+         */
+        error_report_err(err);
+    }
+
     return;
 
 out_get_dev_err:
@@ -129,6 +241,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
     VFIOGroup *group = vapdev->vdev.group;
 
+    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
     vfio_ap_put_device(vapdev);
     vfio_put_group(group);
 }
-- 
2.41.0


