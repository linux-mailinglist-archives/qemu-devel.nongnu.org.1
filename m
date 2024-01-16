Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA682FCEB
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:33:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPryf-0005R0-Ut; Tue, 16 Jan 2024 17:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPryd-0005Q6-Em; Tue, 16 Jan 2024 17:32:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPryb-0007RQ-NU; Tue, 16 Jan 2024 17:32:11 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GMS9I4005000; Tue, 16 Jan 2024 22:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=nutOIXfJwy5KxSjxfsPcLQog2vNcfbvHCIpPeuYzWlU=;
 b=cvxo7KIp+ontxuRoks4XsBPz3Une8gxhj+pyuUtvlWiAwGRiNio00xf50zqu1fmoBiv8
 wO4Z+ieXu0HCkFkGTZr7QbsyrCE3y06y/xiTNRKs+LWn2VxgGC5cc/j6/62Rx9r+76oH
 qLa9jNk+m1Wb+tYpAOFoSQxZUK157ZqZq4FEiYANChtuNr0NP00MHFzzzseklU1293Xt
 2i6s1nWZ913YwmhRXb3sQXqCb/kxDjhWMdQjF8tBMUo75e9gpY1eik0jM7Sar3cWxGKz
 oPO0trJUNTVfl42f3a0KqNAzDOUXbjEKBJ1Qxs4/C8GRU9TV4IEp3djWGK6eFZWoLkAR SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp2mag3n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:07 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GMUNZs010867;
 Tue, 16 Jan 2024 22:32:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp2mag3m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GM5Tn7005408; Tue, 16 Jan 2024 22:32:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j1s0g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40GMW4au20382254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 22:32:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C7D358079;
 Tue, 16 Jan 2024 22:32:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E426B58068;
 Tue, 16 Jan 2024 22:32:02 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 22:32:02 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
Date: Tue, 16 Jan 2024 17:31:57 -0500
Message-ID: <20240116223157.73752-4-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116223157.73752-1-mjrosato@linux.ibm.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FVoGwnGrFuv035QXw1N0vqngGQql9YMW
X-Proofpoint-ORIG-GUID: Hv5ycFb8o6vOu-zrLcyaHoYHEURBzoQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160178
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

ISM devices are sensitive to manipulation of the IOMMU, so the ISM device
needs to be reset before the vfio-pci device is reset (triggering a full
UNMAP).  In order to ensure this occurs, trigger ISM device resets from
subsystem_reset before triggering the PCI bus reset (which will also
trigger vfio-pci reset).  This only needs to be done for ISM devices
which were enabled for use by the guest.
Further, ensure that AIF is disabled as part of the reset event.

Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect on reboot")
Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
Reported-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 26 +++++++++++++++++---------
 hw/s390x/s390-virtio-ccw.c      |  2 ++
 include/hw/s390x/s390-pci-bus.h |  1 +
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 347580ebac..3e57d5faca 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
     pci_device_reset(pbdev->pdev);
 }
 
-static void s390_pci_reset_cb(void *opaque)
-{
-    S390PCIBusDevice *pbdev = opaque;
-
-    pci_device_reset(pbdev->pdev);
-}
-
 static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
 {
     HotplugHandler *hotplug_ctrl;
 
     if (pbdev->pft == ZPCI_PFT_ISM) {
         notifier_remove(&pbdev->shutdown_notifier);
-        qemu_unregister_reset(s390_pci_reset_cb, pbdev);
     }
 
     /* Unplug the PCI device */
@@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             if (pbdev->pft == ZPCI_PFT_ISM) {
                 pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
                 qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
-                qemu_register_reset(s390_pci_reset_cb, pbdev);
             }
         } else {
             pbdev->fh |= FH_SHM_EMUL;
@@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
 }
 
+void s390_pci_ism_reset(void)
+{
+    S390pciState *s = s390_get_phb();
+
+    S390PCIBusDevice *pbdev, *next;
+
+    /* Trigger reset event for each passthrough ISM device currently in-use */
+    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
+        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
+            pbdev->fh & FH_MASK_ENABLE) {
+            s390_pci_kvm_aif_disable(pbdev);
+
+            pci_device_reset(pbdev->pdev);
+        }
+    }
+}
+
 static void s390_pcihost_reset(DeviceState *dev)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1169e20b94..4de04f7e9f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -118,6 +118,8 @@ static void subsystem_reset(void)
     DeviceState *dev;
     int i;
 
+    s390_pci_ism_reset();
+
     for (i = 0; i < ARRAY_SIZE(reset_dev_types); i++) {
         dev = DEVICE(object_resolve_path_type("", reset_dev_types[i], NULL));
         if (dev) {
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 435e788867..2c43ea123f 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -401,5 +401,6 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
                                               const char *target);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
+void s390_pci_ism_reset(void);
 
 #endif
-- 
2.43.0


