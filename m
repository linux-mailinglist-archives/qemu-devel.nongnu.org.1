Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D15831263
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:27:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKuI-0006Xa-OY; Thu, 18 Jan 2024 00:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKu7-0006Pk-4G; Thu, 18 Jan 2024 00:25:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKu3-0006cG-Hb; Thu, 18 Jan 2024 00:25:25 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I4aknM028017; Thu, 18 Jan 2024 05:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MjN3GQdOtFm7wTjkilDoMdx45A+P6A1H9lSMoqHwTDw=;
 b=FzQZncBAuY1D+b34iotulqFObxf378fbFcEaFu2rnJ2D/CuMLuHeOnGRkkvnxVUQhhJk
 QfcWDOrzja+adIs+1BwWq5mya/seUSkrkRmXMoee5GB9BX3RDgjXeiPa815k09kyIFlu
 Ixr1/M2SvMbZsVQZoyBt9jjHjYxrum4KSCtgxPBR1MxLa380MQ59VVzVG4G7X58T492d
 4vyIZmkIdzUWG0GEpT8GJNgOU2PLAsjRksdDkryUcpLefrgc/73LuYnRv43BpD1q5X76
 kQooicMjWmXHnjI5ed1rmnx6GtwygUDft0Q21L6pwASsYVjYS9dF+Vq8lbx3NTNVnxtQ 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp4se19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:19 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5KUtK028276;
 Thu, 18 Jan 2024 05:25:19 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp4se0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3KAND000381; Thu, 18 Jan 2024 05:25:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4ut1q0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5PFX264422362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:25:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 876B220040;
 Thu, 18 Jan 2024 05:25:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8EC720043;
 Thu, 18 Jan 2024 05:25:13 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:25:13 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 12/15] spapr: nested: Use correct source for parttbl info
 for nested PAPR API.
Date: Thu, 18 Jan 2024 10:54:35 +0530
Message-Id: <20240118052438.1475437-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 40nqwLKqqstwy3yxciiK-J8kf7iSx0X4
X-Proofpoint-ORIG-GUID: gkIPs19sniD9nzoXntV1ZLuYIHAELzcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=699 lowpriorityscore=0 impostorscore=0
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

For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
partition table info, use the same in spapr_get_pate_nested() via helper.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_nested.h |  4 ++++
 hw/ppc/spapr.c                |  2 ++
 hw/ppc/spapr_nested.c         | 20 +++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index c124dd1455..18dd82009d 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -513,4 +513,8 @@ void spapr_nested_init(SpaprMachineState *spapr);
 uint8_t spapr_nested_api(SpaprMachineState *spapr);
 void spapr_register_nested_papr(void);
 void spapr_nested_gsb_init(void);
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry);
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong lpid);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 367beb5255..b87532343c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1379,6 +1379,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         assert(spapr_nested_api(spapr));
         if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
             return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
         }
         return false;
     }
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index dba7161563..81c1e78323 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -52,6 +52,19 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return true;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    SpaprMachineStateNestedGuest *guest;
+    assert(lpid != 0);
+    guest = spapr_get_nested_guest(spapr, lpid);
+    assert(guest != NULL);
+
+    entry->dw0 = guest->parttbl[0];
+    entry->dw1 = guest->parttbl[1];
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -536,7 +549,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
-static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
@@ -1550,6 +1562,12 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return false;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
+
 void spapr_register_nested_papr(void)
 {
     /* DO NOTHING */
-- 
2.39.3


