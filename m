Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795C82FCE7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:33:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPryf-0005QE-Dr; Tue, 16 Jan 2024 17:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPryc-0005PN-HQ; Tue, 16 Jan 2024 17:32:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPrya-0007RG-37; Tue, 16 Jan 2024 17:32:10 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GMVPOs028834; Tue, 16 Jan 2024 22:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=IGbIvrVrDCM1/5QMnUc6IVW/4lU22RznChNAwdmgJTE=;
 b=gbX9Qcyv71tBRfihlTV9utyshqSLEvZqoHVmkoXnuSNh6FqInrp87yN28ayrFNiARrxB
 PKm2JSGO/q6fY0dZS/roNTqNvuZhE4Qdm4R8GYLDNvRVrZaqLLwN5EZETwyr1l/jzZPT
 yUYEiqoYbwmSzRQT3x+8fLtbP8f+iNNzv+Is9HnuuzcpyPbbwEOgvcerTwJtF9DB/82N
 hyY9y1PCqMyl89IDzLryKsvQxNdGLoMHZnfcKsSVsXLm5peG2DjPBwKhinPl1zPi14iP
 pN1g3mqj/9bqquvDlv571TaBO7Y4fq51PKtGyocB3odSTvTelin9fhTm2JlXuS4KKLuS BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp2hhr46a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:04 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GMW3OW031032;
 Tue, 16 Jan 2024 22:32:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp2hhr45c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GM4cin023373; Tue, 16 Jan 2024 22:32:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkhcgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:02 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40GMW1cb30081428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 22:32:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ADF758076;
 Tue, 16 Jan 2024 22:32:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B13BD58068;
 Tue, 16 Jan 2024 22:31:59 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 22:31:59 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/3] s390x/pci: avoid double enable/disable of aif
Date: Tue, 16 Jan 2024 17:31:55 -0500
Message-ID: <20240116223157.73752-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116223157.73752-1-mjrosato@linux.ibm.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8-8RKcYJ8sKNe8keY-ALbSLQD3b8UzKv
X-Proofpoint-GUID: 65YFjJrhkg187MG-qrb5NFRRzkv0V3ka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=822 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160178
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
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-kvm.c         | 25 +++++++++++++++++++++++--
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index ff41e4106d..f7e10cfa72 100644
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
+        pbev->aif = false;
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


