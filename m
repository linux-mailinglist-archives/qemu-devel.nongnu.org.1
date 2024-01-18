Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D73831266
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:28:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKuK-0006Zv-NH; Thu, 18 Jan 2024 00:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKuA-0006Qp-PU; Thu, 18 Jan 2024 00:25:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKu8-0006ed-PH; Thu, 18 Jan 2024 00:25:30 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I4srIk015151; Thu, 18 Jan 2024 05:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Fq04TSGVKhmDhp7Ea6o9blYNGK04oNML3gU/WjdIpjI=;
 b=cmEFoboVC6ap7HubhhjDXPYITiuRMS5SwOYBmpilANA61ImA1THICh4VNvl5Vk+WhOcQ
 J3iE133xkwYYLvM0TlW9qhlGFETAYNKAWwd+I/WVR5yM3zpj31/uZ1eokOgSXQtEX6R2
 ClUL3gm/5CGIN6m15/3tJyDUT6amRg+QpYXThSEv3ik6Naz8mqHXzt58ityMzybCARw+
 DFrrxK/j3lgaeVwlv9HIw3acRFvTuKliozc+/IGNzrQ8++/bn/m5Nd33ZFxoQhJ4rLSs
 Bvdi5Xcr9w2za+OTrya74BJtjAtzdoNNCuWGZtLFN4BP6fYGUbb+V3h93bh3lFgaopXp sA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp4se5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5KUjY028339;
 Thu, 18 Jan 2024 05:25:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp4se4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3IRQb009733; Thu, 18 Jan 2024 05:25:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5unsh51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5PJ7843123282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:25:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51F6C20043;
 Thu, 18 Jan 2024 05:25:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2B0020040;
 Thu, 18 Jan 2024 05:25:17 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:25:17 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 14/15] spapr: nested: Introduce cap-nested-papr for Nested
 PAPR API
Date: Thu, 18 Jan 2024 10:54:37 +0530
Message-Id: <20240118052438.1475437-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 61fNDEUnPSnkDzqTHcXPBTsD0ZjEFB9Y
X-Proofpoint-ORIG-GUID: N3p_7hH5CBqf4VdVM-Dm1PnBqIUp2uNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=743 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Introduce a SPAPR capability cap-nested-papr which enables nested PAPR
API for nested guests. This new API is to enable support for KVM on PowerVM
and the support in Linux kernel has already merged upstream.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  5 +++-
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 55 ++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nested.c  |  2 --
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4d3dbd4e7a..379b64b0d7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -81,8 +81,10 @@ typedef enum {
 #define SPAPR_CAP_RPT_INVALIDATE        0x0B
 /* Support for AIL modes */
 #define SPAPR_CAP_AIL_MODE_3            0x0C
+/* Nested PAPR */
+#define SPAPR_CAP_NESTED_PAPR           0x0D
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
 
 /*
  * Capability Values
@@ -993,6 +995,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_nested_papr;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b87532343c..b34a1b61a6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2120,6 +2120,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_nested_papr,
         NULL
     }
 };
@@ -4696,6 +4697,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index c3c83f6e68..4c0080120e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -487,11 +487,56 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
             error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
                                     "or use threads=1 with -smp\n");
         }
+    if (spapr->nested.api) {
+        warn_report("nested.api already set as %d, re-init to kvm-hv",
+                    spapr->nested.api);
+    }
     spapr->nested.api = NESTED_API_KVM_HV;
     spapr_register_nested_hv();
     }
 }
 
+static void cap_nested_papr_apply(SpaprMachineState *spapr,
+                                    uint8_t val, Error **errp)
+{
+    ERRP_GUARD();
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (!val) {
+        /* capability disabled by default */
+        return;
+    }
+
+    if (tcg_enabled()) {
+        if (!(env->insns_flags2 & PPC2_ISA300)) {
+            error_setg(errp, "Nested-PAPR only supported on POWER9 and later");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-papr=off\n");
+            return;
+        }
+    } else if (kvm_enabled()) {
+        /*
+         * this gets executed in L1 qemu when L2 is launched,
+         * needs kvm-hv support in L1 kernel.
+         */
+        if (!kvmppc_has_cap_nested_kvm_hv()) {
+            error_setg(errp,
+                       "KVM implementation does not support Nested-HV");
+        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
+            error_setg(errp, "Error enabling Nested-HV with KVM");
+        }
+    }
+    if (spapr->nested.api) {
+        warn_report("nested.api already set as %d, re-init to nested-papr",
+                    spapr->nested.api);
+    }
+    spapr->nested.api = NESTED_API_PAPR;
+    spapr->nested.capabilities_set = false;
+    spapr_register_nested_papr();
+    spapr_nested_gsb_init();
+}
+
 static void cap_large_decr_apply(SpaprMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
@@ -737,6 +782,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_NESTED_PAPR] = {
+        .name = "nested-papr",
+        .description = "Allow Nested HV (PAPR API)",
+        .index = SPAPR_CAP_NESTED_PAPR,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_nested_papr_apply,
+    },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
         .description = "Allow Large Decrementer",
@@ -921,6 +975,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index e7e5e72006..b91413e09a 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -13,8 +13,6 @@
 void spapr_nested_init(SpaprMachineState *spapr)
 {
     spapr->nested.api = 0;
-    spapr->nested.capabilities_set = false;
-    spapr_nested_gsb_init();
 }
 
 uint8_t spapr_nested_api(SpaprMachineState *spapr)
-- 
2.39.3


