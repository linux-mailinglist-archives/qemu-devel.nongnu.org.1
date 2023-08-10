Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3477778CB
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU54g-0006GY-7z; Thu, 10 Aug 2023 08:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qU54c-0006E0-Qp; Thu, 10 Aug 2023 08:47:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qU54Z-0005uj-QT; Thu, 10 Aug 2023 08:47:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AClKVV009133; Thu, 10 Aug 2023 12:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g06oV7B9yyB59BYQ33KFJlu2dJh6t51Y+NZt33IGor4=;
 b=TJQjT+YlOq8qxOseaarLLMD7D1fymSTZeg5t+LWPh0x2jyu8RmpPM0APsMY6HdwdgmC2
 sKkr3nU1+KXiXKADNlmvrhOLckLazv60iw7cbpl6uANYEDuoNcnxsuuDXf4HThPDH0RU
 aonzJOaeXp+20G4arqGgcr+9ZJ70I7X/SMaz2QGcg4koBJgEUNhtrqistTl3D4wnpLQ5
 l4HjN3Bic+lmRXRa9TPHaw5GMUColba0XejQI18UMUf0X12ZwmlU5huW6mvB6Dgapuys
 4/okwZU7FZqFxeINQqHNtS+pVP03RWlmI6nFT1Hv3J8AZOch5xGvBx9VneBS9sHkNPTR uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scyupgnb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:25 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ACOGVl023278;
 Thu, 10 Aug 2023 12:47:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scyupgna3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ACRDsN000376; Thu, 10 Aug 2023 12:47:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28m1d2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37AClK2445810274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 12:47:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C7312004F;
 Thu, 10 Aug 2023 12:47:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D09120043;
 Thu, 10 Aug 2023 12:47:20 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 3/3] target/s390x: AP-passthrough for PV guests
Date: Thu, 10 Aug 2023 14:47:19 +0200
Message-Id: <20230810124719.2167260-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810124719.2167260-1-seiden@linux.ibm.com>
References: <20230810124719.2167260-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: npIcFQjRq8KS9EulL5pp2sPCiJF2nqJ5
X-Proofpoint-ORIG-GUID: h5QzXXOYHoQVxF93x4MlcdAYZg9UxDpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100106
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

Enabling AP-passthrough(AP-pt) for PV-guest by using the new CPU
features for PV-AP-pt of KVM.

As usual QEMU first checks which CPU features are available and then
sets them if available and selected by user. An additional check is done
to verify that PV-AP can only be enabled if "regular" AP-pt is enabled
as well. Note that KVM itself does not enforce this restriction.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  4 ++
 target/s390x/cpu_models.c           |  2 +
 target/s390x/gen-features.c         |  2 +
 target/s390x/kvm/kvm.c              | 73 +++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+)

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
index e3cfe63735..9a2c5a9dfc 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -379,3 +379,7 @@ DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
 DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
 DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
 DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block")
+
+/* Features exposed via the UV-CALL instruction */
+DEF_FEAT(UV_CALL_AP, "appv", UV_CALL, 4, "AP instructions installed for secure guests")
+DEF_FEAT(UV_CALL_AP_INTR, "appvi", UV_CALL, 5, "AP instructions interpretation for secure guests")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 42b52afdb4..a7900a8a5c 100644
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
index 1e3b7c0dc9..6ae10a2cd8 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -576,6 +576,8 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_RDP,
     S390_FEAT_PAI,
     S390_FEAT_PAIE,
+    S390_FEAT_UV_CALL_AP,
+    S390_FEAT_UV_CALL_AP_INTR,
 };
 
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a7e2cdf668..500b9d894d 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2307,6 +2307,42 @@ static bool ap_enabled(const S390FeatBitmap features)
     return test_bit(S390_FEAT_AP, features);
 }
 
+static bool uv_feat_supported(void)
+{
+    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_MODEL,
+                             KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST);
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
+    if (!uv_feat_supported()) {
+        return 0;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    if (rc) {
+        return  rc;
+    }
+
+    if (ap_available()) {
+        if (prop.ap) {
+            set_bit(S390_FEAT_UV_CALL_AP, features);
+        }
+        if (prop.ap_intr) {
+            set_bit(S390_FEAT_UV_CALL_AP_INTR, features);
+        }
+    }
+    return 0;
+}
+
 static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
     { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
@@ -2501,11 +2537,41 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
+    /* Test for Ultravisor features that influence secure guest behavior */
+    query_uv_feat_guest(model->features);
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
 }
 
+static int configure_uv_feat_guest(const S390FeatBitmap features,
+                                   bool interpret)
+{
+
+    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
+    struct kvm_device_attr attribute = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
+        .addr = (__u64) &uv_feat,
+    };
+
+    if (!uv_feat_supported()) {
+        return 0;
+    }
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
@@ -2569,6 +2635,13 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     if (ap_enabled(model->features)) {
         kvm_s390_configure_apie(true);
     }
+
+    /* configure UV-features for the guest indicated via query / test_bit */
+    rc = configure_uv_feat_guest(model->features, true);
+    if (rc) {
+        error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
+        return;
+    }
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
-- 
2.40.1


