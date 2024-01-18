Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0A831F57
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQXUl-0005K4-8J; Thu, 18 Jan 2024 13:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQXUi-0005IO-Te; Thu, 18 Jan 2024 13:52:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQXUg-0004wl-2W; Thu, 18 Jan 2024 13:52:04 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40IIMd8w021586; Thu, 18 Jan 2024 18:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=aTK80eHhkCk85Ajd7xVIK47RMBIeltdH7k58nnyiFC4=;
 b=EN+qvinu5ssELOkwnoCEW9f5x4c0mEaLLuF1Iv1Gu8shwNc4aVBCJpzGli4wBZbUFP4K
 ghsHknrHWdWEhVru38cgppCkscGspix3+nT5GF9x52YAWp86Ky7wWEqkH7nbOF3CPvCH
 BPjfYLc61rJB/+fRdf0zECdeq0/lNBYGKq+OeDm17KCKMJarJAaTvIzYJ3eydm35ZWCc
 pIcbht4vF1tjwXnrZiWZJ4Basmh7xL7TJsjsmmeTekfC7lmMSoZ5KtADur5HSpDRX+CH
 Yj8KK6tWMful8R299jLEB1cQmRCf0CL29Vr0DJgnlmrbe9+KWKOwykQyc0vr1LuvNnTe +g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq9708stc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:57 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40IINIHN024762;
 Thu, 18 Jan 2024 18:51:56 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq9708ssv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40IHCwCZ006737; Thu, 18 Jan 2024 18:51:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j24kxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40IIptv124314410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 18:51:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E45A458050;
 Thu, 18 Jan 2024 18:51:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6013358056;
 Thu, 18 Jan 2024 18:51:53 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 18:51:53 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 1/3] s390x/pci: avoid double enable/disable of aif
Date: Thu, 18 Jan 2024 13:51:49 -0500
Message-ID: <20240118185151.265329-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118185151.265329-1-mjrosato@linux.ibm.com>
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x2p20XQ5vwF8ctYReHLaGklnQks517pz
X-Proofpoint-GUID: gCWlg352OAtGnDv7wMVAFtgGoT1HeZfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 mlxlogscore=835 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180137
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Use a flag to keep track of whether AIF is currently enabled.  This can be
used to avoid enabling/disabling AIF multiple times as well as to determine
whether or not it should be disabled during reset processing.

Fixes: d0bc7091c2 ("s390x/pci: enable adapter event notification for interpreted devices")
Reported-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-kvm.c         | 25 +++++++++++++++++++++++--
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index ff41e4106d..1ee510436c 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -27,6 +27,7 @@ bool s390_pci_kvm_interp_allowed(void)
 
 int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist)
 {
+    int rc;
     struct kvm_s390_zpci_op args = {
         .fh = pbdev->fh,
         .op = KVM_S390_ZPCIOP_REG_AEN,
@@ -38,15 +39,35 @@ int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist)
         .u.reg_aen.flags = (assist) ? 0 : KVM_S390_ZPCIOP_REGAEN_HOST
     };
 
-    return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (pbdev->aif) {
+        return -EINVAL;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (rc == 0) {
+        pbdev->aif = true;
+    }
+
+    return rc;
 }
 
 int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
 {
+    int rc;
+
     struct kvm_s390_zpci_op args = {
         .fh = pbdev->fh,
         .op = KVM_S390_ZPCIOP_DEREG_AEN
     };
 
-    return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (!pbdev->aif) {
+        return -EINVAL;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (rc == 0) {
+        pbdev->aif = false;
+    }
+
+    return rc;
 }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index b1bdbeaeb5..435e788867 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -361,6 +361,7 @@ struct S390PCIBusDevice {
     bool unplug_requested;
     bool interp;
     bool forwarding_assist;
+    bool aif;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
-- 
2.43.0


