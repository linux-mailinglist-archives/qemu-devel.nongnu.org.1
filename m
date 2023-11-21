Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B297F36A8
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 20:12:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5W8o-0008GQ-Od; Tue, 21 Nov 2023 14:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8k-0008E4-2d; Tue, 21 Nov 2023 14:10:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8P-000412-MH; Tue, 21 Nov 2023 14:10:28 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALJ8eHV012488; Tue, 21 Nov 2023 19:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=W7YjKCew7catGboidcAvcCAZdu4VcjJp7fKtu5FsoFk=;
 b=fK+Q/Dyk4xHiE2JPe27SNsnOhd8ilOCH92mDOdpkgdP6EAUGRN8xOLilHDladQzTAZ4c
 yp5tK8Y+nfQQ8VWwzrv20Zm1TgmS/MrcdJjp/KygWRkRht/ojA4aQVfjiaGHEyhTax3d
 ng3xXqKx+cOKs+wSP19cOpTE5zlC0GfpMIu5pXGuuDpGG5/+IB5pzwbnRKn2gpcLclZP
 2yVnptM0vg+jkYBXEVzYDfXXZBw3Dhc6/d92RKRidCIkTsJc2Fel1zIESsdrx2HanZhs
 R7u7eH0EL+uSOIb/Yp1I3MI/IfwxbfcrxpLT7r9//SaJpNYdZHP3uMbzGjtKHaN5ECnw nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2en020p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:06 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALJ9Cq0014694;
 Tue, 21 Nov 2023 19:10:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2en0207-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIZ3Xf007404; Tue, 21 Nov 2023 19:10:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kntuwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALJA4x918809546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 19:10:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 204B65805C;
 Tue, 21 Nov 2023 19:10:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F240758062;
 Tue, 21 Nov 2023 19:10:03 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 19:10:03 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v5 3/9] ppc/pnv: New powernv10-rainier machine type
Date: Tue, 21 Nov 2023 13:09:39 -0600
Message-Id: <20231121190945.3140221-4-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uOxuznojLhFUBFU9ephgUuQW60jjKnGj
X-Proofpoint-GUID: Ih0obQPc-cXWSm-9V-qn7v1gl--_YrD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=973 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210150
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Create a new powernv machine type, powernv10-rainier, that
will contain rainier-specific devices.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

Changes from previous version:
  - Formatting changes
  - Capitalized "Rainier" in machine description string
  - Changed powernv10-rainier parent to MACHINE_TYPE_NAME("powernv10")

 hw/ppc/pnv.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..08704ce695 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2251,7 +2251,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
-static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
@@ -2263,7 +2263,6 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
         { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
     };
 
-    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
@@ -2276,6 +2275,22 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
 
+static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pnv_machine_p10_common_class_init(oc, data);
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
+}
+
+static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    pnv_machine_p10_common_class_init(oc, data);
+    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2381,6 +2396,11 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     }
 
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
+        .parent        = MACHINE_TYPE_NAME("powernv10"),
+        .class_init    = pnv_machine_p10_rainier_class_init,
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10"),
         .parent        = TYPE_PNV_MACHINE,
-- 
2.31.1


