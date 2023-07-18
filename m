Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F328C7577CA
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLguy-0006Cw-Ir; Tue, 18 Jul 2023 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguw-0006CH-QQ; Tue, 18 Jul 2023 05:22:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguv-0000x1-67; Tue, 18 Jul 2023 05:22:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9KMaw021326; Tue, 18 Jul 2023 09:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EYQSG0df+biYjvobKKJ19ouEI6ALG1MZFYogM6/kffc=;
 b=kwdfBMNRm4jXZuB3+GzIreE6RNJvxYG7evp7QtYDCog6HJrP/1iQgL8Jf8nUGWaqD77W
 1uJ7oEn2ZtTj5CkrC1+ID539pELXm4jPWSmuoK9iv02iHO6pH7vXUy8N65MB/WwRK08A
 Ju16WX/pByrEtTzYXg3TIjUsDX544wYkRAc8Gq3hhjYxeXEHHwFQbD5Y4dKHqFJwTbXh
 tgnLmwUAHrwq9YzdzVG6baggQ5LHjmx9emtpJUqoXJ/SVQV/nt2KnQjKC3onqRjYx7A1
 QETeFLls3ukCICgkWJQfBNn6c6oJYk+4kXMyBR8h9rxPk+JLnJ8hsT9164Yeq7vE6/gE DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqx206cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:44 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9F0f5031849;
 Tue, 18 Jul 2023 09:22:43 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqx206cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I8F033004149; Tue, 18 Jul 2023 09:22:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv8g0wbr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MdbE59179372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9581720043;
 Tue, 18 Jul 2023 09:22:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D31A20040;
 Tue, 18 Jul 2023 09:22:37 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:37 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 05/15] ppc: spapr: Introduce cap-nested-papr for nested PAPR
 API
Date: Tue, 18 Jul 2023 14:52:11 +0530
Message-Id: <20230718092221.1053686-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CZgRBQe8SdnUyzwTM50lYZDY6vK3-UMN
X-Proofpoint-ORIG-GUID: b8r0bquVG1Y8x0Th3CqyNAQx7afg_bpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=652 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

This patch introduces a new cmd line option cap-nested-papr to enable
support for nested PAPR API by setting the nested.api version accordingly.
It requires the user to launch the L0 Qemu in TCG mode and then L1 Linux
can then launch the nested guest in KVM mode. Unlike cap-nested-hv,
this is meant for nested guest on pseries (PowerVM) where L0 retains
whole state of the nested guest. Both APIs are thus mutually exclusive.
Support for related hcalls is being added in next set of patches.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e25a35f4a5..d357350468 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2092,6 +2092,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_nested_papr,
         NULL
     }
 };
@@ -4685,6 +4686,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index a3a790b026..d3b9f107aa 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -491,6 +491,44 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
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
+        spapr->nested.api = NESTED_API_PAPR;
+    } else if (kvm_enabled()) {
+        /*
+         * this gets executed in L1 qemu when L2 is launched,
+         * needs kvm-hv support in L1 kernel.
+         */
+        if (!kvmppc_has_cap_nested_kvm_hv()) {
+            error_setg(errp,
+                       "KVM implementation does not support Nested-HV");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-hv=off\n");
+        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
+            error_setg(errp, "Error enabling cap-nested-hv with KVM");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-hv=off\n");
+        }
+    }
+}
+
 static void cap_large_decr_apply(SpaprMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
@@ -736,6 +774,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_NESTED_PAPR] = {
+        .name = "nested-papr",
+        .description = "Allow Nested PAPR (Phyp)",
+        .index = SPAPR_CAP_NESTED_PAPR,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_nested_papr_apply,
+    },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
         .description = "Allow Large Decrementer",
@@ -920,6 +967,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c8b42af430..8a6e9ce929 100644
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
@@ -1005,6 +1007,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_nested_papr;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
-- 
2.39.3


