Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 704BB7654CE
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP03k-0000yf-3J; Thu, 27 Jul 2023 08:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03N-0000y5-Tb; Thu, 27 Jul 2023 08:25:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03M-0001A4-1g; Thu, 27 Jul 2023 08:25:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RCJ7F5003901; Thu, 27 Jul 2023 12:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=n84K8P23Sh5AYEVWROIIfO9iw8kEaaTuXMtdgS7QSPo=;
 b=S68FSarHvxfpbjrU42qvwsWCIH7glmvvEN/JlmYBgH6kkcyrqaoM1nqrBE5+xMRPPxzw
 HG2c5pZL/Nn1+OM111jBYlpA47x53313ZM0EvStm8eBaM+wkftpD3XignnSMcF4UsJyn
 5arTjEZ7gs+7AYhOkeMMEFdVLfcdRErIDmeCf+tj0F9o7VwoBBYwVUbl0gtZR4UEHXZI
 wPGljqfu+8tptQ798SJCz+sdmPrVXpxjODs3eR5/6ILfglwJRGLjjMWX406xo5DOGSZH
 E8XOde7BGl7Unwa9oTShzyfo5IxLW+jVoY5dOTuc70QgVHG5vdozCCZY5JFCw8hICn2H wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3qyfs3yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:08 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RCAZrN000377;
 Thu, 27 Jul 2023 12:25:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3qyfs3yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RBSUQd002412; Thu, 27 Jul 2023 12:25:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txkd9dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36RCP4as60686752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 12:25:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90BD72004B;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5991120043;
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
Subject: [PATCH 2/3] target/s390x: refractor AP functionalities
Date: Thu, 27 Jul 2023 14:25:02 +0200
Message-Id: <20230727122503.775084-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727122503.775084-1-seiden@linux.ibm.com>
References: <20230727122503.775084-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cFCrH0TuZh3DxL2j4X9ll5jiPm1mfqHI
X-Proofpoint-GUID: mrlTkt3PyPQ0YrlApmlwaSSwAv_Tt_xE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 target/s390x/kvm/kvm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 3ac7ec9acf..bd62a7f606 100644
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
 
@@ -2296,6 +2296,11 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+static bool ap_available(void)
+{
+    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, KVM_S390_VM_CRYPTO_ENABLE_APIE);
+}
+
 static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
     { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
@@ -2475,8 +2480,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         return;
     }
     /* for now, we can only provide the AP feature with HW support */
-    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
-        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
+    if (ap_available()) {
         set_bit(S390_FEAT_AP, model->features);
     }
 
@@ -2502,7 +2506,7 @@ static void kvm_s390_configure_apie(bool interpret)
                                 KVM_S390_VM_CRYPTO_DISABLE_APIE;
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-        kvm_s390_set_attr(attr);
+        kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -2556,7 +2560,7 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         kvm_s390_enable_cmma();
     }
 
-    if (test_bit(S390_FEAT_AP, model->features)) {
+    if (ap_enabled(model->features)) {
         kvm_s390_configure_apie(true);
     }
 }
-- 
2.40.1


