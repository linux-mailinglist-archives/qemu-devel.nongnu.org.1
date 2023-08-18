Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283A780DB5
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05n-0004xc-9u; Fri, 18 Aug 2023 10:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qWxS1-0001Us-3L; Fri, 18 Aug 2023 07:15:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qWxRx-0000M8-Jy; Fri, 18 Aug 2023 07:15:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IB0eDv015101; Fri, 18 Aug 2023 11:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kSb6FgA0aws4uXGJec17OoNZU6uoD99yHXOkhBOgUiE=;
 b=gdNLorHw+cw+8QMp5PRIqlnzxJfKE9ALvp+fWkZRs61BRmMByvX1l1fAvsyJM7C2vmA7
 ScfuZtatwEeCdp2BLQUrcAuRxWtSVry5bLv4s5eRJIqtgdgs/OI0IXbxoaDTs3X7xj9Q
 Q/ZYKgzLRejWQM52GVwTNqPaV2eB+kpZWWs9FIszdMyM9tGTvqCghj2AUa9QJBvFo/G/
 yV9ho4ZTROUdnvAGf8WVZ6lMnm7JwtIZRY2DNCxVfM4KsrBvd97bbnKXN0JX3cm/qFe2
 Gsx0mUdGlGMpu4LtbZpmr8piHq/B2A8qzbGkoo7cuz9JIcaXursAEKc4UjVZaShBZ+Ra Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj79d0eu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:26 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IArP1A021608;
 Fri, 18 Aug 2023 11:15:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj79d0eu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IA1DMG001078; Fri, 18 Aug 2023 11:15:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsyxtx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37IBFLSj45482390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 11:15:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC5EA20071;
 Fri, 18 Aug 2023 11:15:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADCD820076;
 Fri, 18 Aug 2023 11:15:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Aug 2023 11:15:21 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 4/5] target/s390x/kvm: Refactor AP functionalities
Date: Fri, 18 Aug 2023 13:15:19 +0200
Message-ID: <20230818111520.698615-5-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818111520.698615-1-seiden@linux.ibm.com>
References: <20230818111520.698615-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2l4Fq7EncoB2h-SEI6SmYJxu9gZTVF2-
X-Proofpoint-ORIG-GUID: UFBySvq_7lUpc57rB64sgQB_7jF002vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_13,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


