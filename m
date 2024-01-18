Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00EB831267
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:28:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKuA-0006OM-H1; Thu, 18 Jan 2024 00:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtq-0006IO-2n; Thu, 18 Jan 2024 00:25:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKto-0006YT-2Z; Thu, 18 Jan 2024 00:25:09 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I5KV5Z022605; Thu, 18 Jan 2024 05:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hvo0bkNXkHR5Bbho5x8PJ6EqZsFuex4PXnydnPR1ycU=;
 b=brRaVIyayC7eF7NIH8LnccvGwNsmPQ5GPKRXsaWZD+WH1fY8BPI7YHLwXdy5Pkw60V/t
 Fy/X0CFaXlG/RKytzh2daDCGLHOGxKXzkS5t+HY4g17jkHdSr80J7h2OTmHxVGd/9hHw
 CvohHqllaBPXEBq/HEJQTWN8kobbGZpXKxIGZRYTqQWnfeMdWRdmkBQH5RBeu22QPe0x
 QgIQGTn/7tV/GLBvwWHVlZgP9ftFJwZjBmNAjUbix3TkEGaxY1VHyXUJpunfH9Uw5PqF
 UVNZC9AiLbFpH/ItiU0svztkJQMe90B4NGg6FTKbkp7vPlAtBbyePjXPYAXFipo4l/2x Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp5sacq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:03 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5KWes022855;
 Thu, 18 Jan 2024 05:25:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp5sabp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3NNDX005785; Thu, 18 Jan 2024 05:25:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkscyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5OwN027722172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:24:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52A9920043;
 Thu, 18 Jan 2024 05:24:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3F3620040;
 Thu, 18 Jan 2024 05:24:56 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:24:56 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 03/15] spapr: nested: Introduce SpaprMachineStateNested to
 store related info.
Date: Thu, 18 Jan 2024 10:54:26 +0530
Message-Id: <20240118052438.1475437-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HuHkeCYd60n5rzs4QHeg4vTQ42jLfW7m
X-Proofpoint-ORIG-GUID: k6as73qOSFLFWznEyihMff41GfojBcpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=944
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Currently, nested_ptcr is being used by existing nested-hv API to store
nested guest related info. This need to be organised to extend support
for the nested PAPR API which would need to store additional info
related to nested guests in next series of patches.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h        | 3 ++-
 include/hw/ppc/spapr_nested.h | 5 +++++
 hw/ppc/spapr_nested.c         | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d98fbf1def..5521cbe5fb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -12,6 +12,7 @@
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/ppc/spapr_nested.h" /* For SpaprMachineStateNested */
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -213,7 +214,7 @@ struct SpaprMachineState {
     uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
 
     /* Nested HV support (TCG only) */
-    uint64_t nested_ptcr;
+    SpaprMachineStateNested nested;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index cc199a05a7..e9c11111dd 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -4,6 +4,10 @@
 #include "qemu/osdep.h"
 #include "target/ppc/cpu.h"
 
+typedef struct SpaprMachineStateNested {
+    uint64_t ptcr;
+} SpaprMachineStateNested;
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
@@ -97,6 +101,7 @@ struct nested_ppc_state {
 };
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
+typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 401b52833f..a41f1af839 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -17,8 +17,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
     assert(lpid != 0);
 
-    patb = spapr->nested_ptcr & PTCR_PATB;
-    pats = spapr->nested_ptcr & PTCR_PATS;
+    patb = spapr->nested.ptcr & PTCR_PATB;
+    pats = spapr->nested.ptcr & PTCR_PATS;
 
     /* Check if partition table is properly aligned */
     if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
@@ -55,7 +55,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    spapr->nested_ptcr = ptcr; /* Save new partition table */
+    spapr->nested.ptcr = ptcr; /* Save new partition table */
 
     return H_SUCCESS;
 }
@@ -187,7 +187,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    if (spapr->nested_ptcr == 0) {
+    if (spapr->nested.ptcr == 0) {
         return H_NOT_AVAILABLE;
     }
 
-- 
2.39.3


