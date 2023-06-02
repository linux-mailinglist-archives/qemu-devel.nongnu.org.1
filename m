Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A272040F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55VN-0003yH-PL; Fri, 02 Jun 2023 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q55VH-0003xS-8A; Fri, 02 Jun 2023 10:11:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q55VC-0006VC-Rx; Fri, 02 Jun 2023 10:11:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 352E8iU7019588; Fri, 2 Jun 2023 14:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ImoiGITD2h3EV4MYH61k2bquP7lqRj7IDs6dvH5FAQ0=;
 b=rECMsnq69cBTXxdzOSbKCnniDd5qCtOuijSNhhlCMNzEPR7VH3++skMTdDrhfbGwdtT8
 u1bGYDDnNUMOH9Qb6PC8A8T0P0boBNy/cRO7Q3UxPm+g4PC+V7yzo6EpV8bS9aXYt8OV
 ew4SRXjywgESA6jmGq6dGlpxjj1nrjqdVqvQRQQDmo39ZKwjz72Yheka0ayDw2W0UYu9
 moqqTuAnNmPNE7hLqO2/yoTvA9Cv/nAsj0jEQd1OSDtjZKggOqUclxK14CINOrv3ASNE
 tt7Ych78wQYPJPSBCOHfZwTfFASvSNb1aojW3SKjI44v6GrWBGV91gbbAme1yeAfVuGE vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyha3s0e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 14:11:36 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352E9vNo025392;
 Fri, 2 Jun 2023 14:11:36 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyha3s0df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 14:11:36 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 352As3sJ009526;
 Fri, 2 Jun 2023 14:11:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
 by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g67gtn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 14:11:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 352EBXWh20316912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Jun 2023 14:11:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E87258075;
 Fri,  2 Jun 2023 14:11:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 773F158063;
 Fri,  2 Jun 2023 14:11:32 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown
 [9.61.88.233]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Jun 2023 14:11:32 +0000 (GMT)
From: Tony Krowiak <akrowiak@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
 cohuck@redhat.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 2/2] s390x/ap: Wire up the device request notifier interface
Date: Fri,  2 Jun 2023 10:11:25 -0400
Message-Id: <20230602141125.448833-3-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602141125.448833-1-akrowiak@linux.ibm.com>
References: <20230602141125.448833-1-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nYKocictdda8Ip_RVrNh-waHE2htgbBG
X-Proofpoint-ORIG-GUID: CRB2nt3p5qxPvFwet6124lgbOPB03w_N
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020106
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Let's wire up the device request notifier interface to handle device unplug
requests for AP.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20230530225544.280031-1-akrowiak@linux.ibm.com/
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
2.31.1


