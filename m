Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D17FA8CC
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 19:19:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7gB3-0001W9-5r; Mon, 27 Nov 2023 13:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gB1-0001Uj-9I; Mon, 27 Nov 2023 13:17:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gAz-000185-6w; Mon, 27 Nov 2023 13:17:47 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARHljxA003329; Mon, 27 Nov 2023 18:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Dfqb2qJhtg/GBi590y/b4hRyYlUfuoAoT9C5EJ7PSlU=;
 b=INoWDALevJbGbg1PXvJupdqexDEGSvazv4Ei6DyCxf2yb7up/52Rdf6yqnpWUXrCffx+
 58A0B74lNPPKpTIspt9GXOvqEykhUDKdJ02bhuihUgltSYTZYilLlPA3RNK17y0Y5Oay
 dURC2RPhIVAhAtGIL5dRB6ApZJR4wIuwroAuZVWsi0otcuco+mABENd/ABn6Lxi1Nk26
 gHWIRkS/Iq9ZmrhkO+n2/k9AKxNhUQQxKn6RxYp8d7LWNi606CYyN/MWuhHN6k0patXU
 RhivB7IPFRcpnEA377kVxTuxnJHPcBa6c+MGePNX0KF6PTSbfCLHoaTKEcW9/Y2adhhQ 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umytg0xj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:26 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARHlXLL002456;
 Mon, 27 Nov 2023 18:17:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umytg0xhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARGrZY4025568; Mon, 27 Nov 2023 18:17:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkacen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARIHNZF26149606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 18:17:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77E8E5805D;
 Mon, 27 Nov 2023 18:17:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B10A58059;
 Mon, 27 Nov 2023 18:17:23 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 18:17:23 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Subject: [PATCH v6 3/9] ppc/pnv: New powernv10-rainier machine type
Date: Mon, 27 Nov 2023 12:16:49 -0600
Message-Id: <20231127181655.1997496-4-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
References: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 54zSQaKisbebS0fhAN8oHiCfovi3yCxd
X-Proofpoint-ORIG-GUID: bggRXXhh3kb7NskcKbKEjjCMaNFSoVrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=825 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270126
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No change from previous version

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


