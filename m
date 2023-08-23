Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F88785A58
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYokn-00079C-Lr; Wed, 23 Aug 2023 10:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qYokg-00077Y-R3; Wed, 23 Aug 2023 10:22:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qYokf-0001VY-8k; Wed, 23 Aug 2023 10:22:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37NELAFm021854; Wed, 23 Aug 2023 14:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rZwX6/RiuQfLIVkgVAB3/92+Xrnh+UNsR+t4WrWVxos=;
 b=pJwgWyga54iMDfzBRX7Oe79AVVEwHd8gbBRtIj5/gW782X5F9aPyhFD1vJEjEoM2o4Zj
 BWOdaOkm3AX0XNTMyTskPliAHFTq+1lAwLyvciBHEwFwcxos6ORxGv/a9SgFxJtSf3lA
 AFFWu7MgOihQNcDomYL9OxtV4y+pUf9+/LzDHYJpM7U15qjVs4CqD+wR7ksR4AItYLko
 P0gnTKXL/GmLf8LMFXA99KiBIBZbO0hUqSGx55IKmp7TxGrj57eVJtFtk8WgzLC25qNJ
 mu7VxuQxNgbGm/kKj/EaCnjkBt14tqs9UVYz/piE7Sg5Dq5pUbZeqqDxiopJZQ7od3bZ Og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snkh5gs8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 14:22:26 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NE2UHS009163;
 Wed, 23 Aug 2023 14:22:26 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snkh5gs6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 14:22:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37NCB5SL020096; Wed, 23 Aug 2023 14:22:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn22aex5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 14:22:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37NEMLj113894302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Aug 2023 14:22:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7E7E20049;
 Wed, 23 Aug 2023 14:22:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EE3C2004F;
 Wed, 23 Aug 2023 14:22:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Aug 2023 14:22:21 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v4 4/5] target/s390x/kvm: Refactor AP functionalities
Date: Wed, 23 Aug 2023 16:22:18 +0200
Message-ID: <20230823142219.1046522-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823142219.1046522-1-seiden@linux.ibm.com>
References: <20230823142219.1046522-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hb0OxnBwYDnn-zQDV5i4irIdJojuyJIe
X-Proofpoint-GUID: 3MOgpeHj3wVIXIaVVB7BPf6gAgfIBf0L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308230128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=seiden@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

kvm_s390_set_attr() is a misleading name as it only sets attributes for
the KVM_S390_VM_CRYPTO group. Therefore, rename it to
kvm_s390_set_crypto_attr().

Add new functions ap_available() and ap_enabled() to avoid code
duplication later.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Mueller <mimu@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 target/s390x/kvm/kvm.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..a7e2cdf668 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -250,7 +250,7 @@ static void kvm_s390_enable_cmma(void)
     trace_kvm_enable_cmma(rc);
 }
 
-static void kvm_s390_set_attr(uint64_t attr)
+static void kvm_s390_set_crypto_attr(uint64_t attr)
 {
     struct kvm_device_attr attribute = {
         .group = KVM_S390_VM_CRYPTO,
@@ -275,7 +275,7 @@ static void kvm_s390_init_aes_kw(void)
     }
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-            kvm_s390_set_attr(attr);
+            kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -289,7 +289,7 @@ static void kvm_s390_init_dea_kw(void)
     }
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-            kvm_s390_set_attr(attr);
+            kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -2296,6 +2296,17 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+static bool ap_available(void)
+{
+    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
+                             KVM_S390_VM_CRYPTO_ENABLE_APIE);
+}
+
+static bool ap_enabled(const S390FeatBitmap features)
+{
+    return test_bit(S390_FEAT_AP, features);
+}
+
 static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
     { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
@@ -2475,8 +2486,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         return;
     }
     /* for now, we can only provide the AP feature with HW support */
-    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
-        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
+    if (ap_available()) {
         set_bit(S390_FEAT_AP, model->features);
     }
 
@@ -2502,7 +2512,7 @@ static void kvm_s390_configure_apie(bool interpret)
                                 KVM_S390_VM_CRYPTO_DISABLE_APIE;
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-        kvm_s390_set_attr(attr);
+        kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -2556,7 +2566,7 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         kvm_s390_enable_cmma();
     }
 
-    if (test_bit(S390_FEAT_AP, model->features)) {
+    if (ap_enabled(model->features)) {
         kvm_s390_configure_apie(true);
     }
 }
-- 
2.41.0


