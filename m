Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BC7653E7
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP03s-00011o-Ky; Thu, 27 Jul 2023 08:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03P-0000yH-Cb; Thu, 27 Jul 2023 08:25:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03L-0001A7-TQ; Thu, 27 Jul 2023 08:25:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RCEKEf008939; Thu, 27 Jul 2023 12:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=X9WB5JQ2lHFulrq0bpP4+zs9ypnpfxdUIKkyr++DW9U=;
 b=eD2ZOkn5zHONiACJiSE/cn0fN6t1s3UlRwppnNunY4/OtJdS9EHWC36B+NXAJ2+NWAfz
 GeJmp8OiZcwIeT10c4o6zh+M45IFJ0w2EYXlfKJ3JnTch45ytZBmTYV2GkbN6/W+dR23
 p1Z9cm9EJ2fMkXHNrTGpA2b3djr3r+ekOwRuotxcC7A9vcMd2uzdeCNPaHWYldhchqLT
 8z9NEtK3r7sEDiTPlGwOhs6HLEz1ZYdeOSSk9eulMyOG5BQizE4sV0ZI2mOa3CQtLHpN
 hr2VlieNQvipd+8W84Bya5wlmpMIMpFM3Wzz8JDH1JE+X1DiMeC5WVfnyFIxtnYfhcSp fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3rdk0apq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:08 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RCG0xt013841;
 Thu, 27 Jul 2023 12:25:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3rdk0ap8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RBvVGC026200; Thu, 27 Jul 2023 12:25:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0sesdw13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36RCP4v260686754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 12:25:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0F7B20043;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 996192004E;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 3/3] target/s390x: AP-passthrough for PV guests
Date: Thu, 27 Jul 2023 14:25:03 +0200
Message-Id: <20230727122503.775084-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727122503.775084-1-seiden@linux.ibm.com>
References: <20230727122503.775084-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N3-EBQvrrf8yD6g1PJ9D00XjZ1_5MzPU
X-Proofpoint-GUID: 8M_Za6K8eZnP7kOipdkEs8p1tDQ6z-vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Enabling AP-passthrough(AP-pt) for PV-guest via using the new CPU
features for PV-AP-pt of kvm.

As usual QEMU first checks which CPU features are available and then
sets them if available and selected by user. An additional check is done
to verify that PV-AP can only be enabled if "regular" AP-pt is enabled
as well. Note that KVM itself does not enforce this restriction.

If regular AP-pt is enabled and kvm/firmware supports PV-AP-pt it is
also turned on by default.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  4 ++
 target/s390x/cpu_models.c           |  2 +
 target/s390x/gen-features.c         |  4 ++
 target/s390x/kvm/kvm.c              | 73 +++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+)

diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 87463f064d..40928c60e9 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -43,6 +43,7 @@ typedef enum {
     S390_FEAT_TYPE_KDSA,
     S390_FEAT_TYPE_SORTL,
     S390_FEAT_TYPE_DFLTCC,
+    S390_FEAT_TYPE_UV_CALL,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index e3cfe63735..4b659d4064 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -379,3 +379,7 @@ DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
 DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
 DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
 DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block")
+
+/* Features exposed via the UV-CALL instruction */
+DEF_FEAT(UV_CALL_AP, "appv", UV_CALL, 4, "AP instructions installed for secure guests")
+DEF_FEAT(UV_CALL_AP_INTR, "appvi", UV_CALL, 5, "AP instructions interpretion for secure guests")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ae8880e81d..6d703b3c55 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -483,6 +483,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
+        { S390_FEAT_UV_CALL_AP, S390_FEAT_AP },
+        { S390_FEAT_UV_CALL_AP_INTR, S390_FEAT_UV_CALL_AP },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 1e3b7c0dc9..0220864d89 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -576,6 +576,8 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_RDP,
     S390_FEAT_PAI,
     S390_FEAT_PAIE,
+    S390_FEAT_UV_CALL_AP,
+    S390_FEAT_UV_CALL_AP_INTR,
 };
 
 
@@ -671,6 +673,8 @@ static uint16_t default_GEN16_GA1[] = {
     S390_FEAT_RDP,
     S390_FEAT_PAI,
     S390_FEAT_PAIE,
+    S390_FEAT_UV_CALL_AP,
+    S390_FEAT_UV_CALL_AP_INTR,
 };
 
 /* QEMU (CPU model) features */
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bd62a7f606..cf11bfb0fa 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2301,6 +2301,39 @@ static bool ap_available(void)
     return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, KVM_S390_VM_CRYPTO_ENABLE_APIE);
 }
 
+static bool uv_feat_supported(void)
+{
+    return kvm_vm_check_attr(
+            kvm_state, KVM_S390_VM_CPU_MODEL, KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST);
+}
+
+static int query_uv_feat_guest(S390FeatBitmap features)
+{
+    struct kvm_s390_vm_cpu_uv_feat prop = {};
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST,
+        .addr = (uint64_t) &prop,
+    };
+    int rc;
+
+    if (!uv_feat_supported())
+        return 0;
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    if (rc) {
+        return  rc;
+    }
+
+    if (ap_available()) {
+        if (prop.ap)
+            set_bit(S390_FEAT_UV_CALL_AP, features);
+        if (prop.ap_intr)
+            set_bit(S390_FEAT_UV_CALL_AP_INTR, features);
+    }
+    return 0;
+}
+
 static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
     { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
@@ -2495,11 +2528,44 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
+    /* Test for Ultravisor features that influence secure guest behavior */
+    query_uv_feat_guest(model->features);
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
 }
 
+static bool ap_enabled(const S390FeatBitmap features)
+{
+    return test_bit(S390_FEAT_AP, features);
+}
+
+static int configure_uv_feat_guest(const S390FeatBitmap features, bool interpret)
+{
+
+    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
+    struct kvm_device_attr attribute = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
+        .addr = (__u64)&uv_feat,
+    };
+
+    if (!uv_feat_supported())
+        return 0;
+
+    if (ap_enabled(features)) {
+        if (test_bit(S390_FEAT_UV_CALL_AP, features)) {
+            uv_feat.ap = 1;
+        }
+        if (test_bit(S390_FEAT_UV_CALL_AP_INTR, features) && interpret) {
+            uv_feat.ap_intr = 1;
+        }
+    }
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
+}
+
 static void kvm_s390_configure_apie(bool interpret)
 {
     uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
@@ -2563,6 +2629,13 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     if (ap_enabled(model->features)) {
         kvm_s390_configure_apie(true);
     }
+
+    /* configure uv features for the guest indicated via query / test_bit*/
+    rc = configure_uv_feat_guest(model->features, true);
+    if (rc) {
+        error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
+        return;
+    }
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
-- 
2.40.1


