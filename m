Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0380A71C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 16:15:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBcYB-0007kW-Jf; Fri, 08 Dec 2023 10:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBcXn-0007fH-Og; Fri, 08 Dec 2023 10:13:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBcXm-0005ka-13; Fri, 08 Dec 2023 10:13:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8ExUPq026739; Fri, 8 Dec 2023 15:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TvNCP88Wih3iCPLGr0imWZLWfqNMOFk0A6mAUZSumPc=;
 b=Sma5v2kq4Kqy11W8OPrtLi88MoNolYJzYazVEFxl9XX+pGeU0MMc9CwUz+jVIgQyOIGo
 EBngQmsx4+kNAkkB/dV/QZkacTa+uVnvsRisBKNLy/jSGm+wLc3sphCeN41bMFGsYN/Y
 6kCygbUPqwcIdp3JCP+ryhzUopBLcHUfUs/9NFSXoYh44L2AfhI3TPS+X+bjzWMeCmjW
 96avPjS0I47SwBkNYZpXawbX+T2hBAGmNCICTlbPXi1MaEh9t+4IYTGSapb2SVaXaFSv
 rxF5FnO8q2MBn636pTOyRhRKCBX9dqNsVq3XfaoPvH34wPWd4i6RBNiJt7Z9wGmcnM5v 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv46etgn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:13:28 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B8ExUEp026733;
 Fri, 8 Dec 2023 15:13:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv46etgmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:13:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8DYr3d013747; Fri, 8 Dec 2023 15:13:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utau4j7q3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:13:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B8FDNKS45417098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 15:13:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A70B2004B;
 Fri,  8 Dec 2023 15:13:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C364820043;
 Fri,  8 Dec 2023 15:13:21 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 15:13:21 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v8 3/3] hw/ppc: N1 chiplet wiring
Date: Fri,  8 Dec 2023 09:13:12 -0600
Message-Id: <20231208151312.24811-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231208151312.24811-1-chalapathi.v@linux.ibm.com>
References: <20231208151312.24811-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a8PP7g4bm6Mb3BuORQgeQomOTmAbqbOE
X-Proofpoint-ORIG-GUID: w38AF95aPlthzzNX991osPonBlAtAYSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=787 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

This part of the patchset connects the nest1 chiplet model to p10 chip.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_chip.h |  2 ++
 hw/ppc/pnv.c              | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c42308..9b06c8d87c 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -4,6 +4,7 @@
 #include "hw/pci-host/pnv_phb4.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
+#include "hw/ppc/pnv_n1_chiplet.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -113,6 +114,7 @@ struct Pnv10Chip {
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
+    PnvN1Chiplet     n1_chiplet;
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..be3e922644 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1680,6 +1680,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
+    object_initialize_child(obj, "n1-chiplet", &chip10->n1_chiplet,
+                            TYPE_PNV_N1_CHIPLET);
 
     chip->num_pecs = pcc->num_pecs;
 
@@ -1849,6 +1851,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
                                 &chip10->homer.regs);
 
+    /* N1 chiplet */
+    if (!qdev_realize(DEVICE(&chip10->n1_chiplet), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_CHIPLET_CTRL_REGS_BASE,
+             &chip10->n1_chiplet.nest_pervasive.xscom_ctrl_regs_mr);
+
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_EQ_BASE,
+                           &chip10->n1_chiplet.xscom_pb_eq_mr);
+
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_N1_PB_SCOM_ES_BASE,
+                           &chip10->n1_chiplet.xscom_pb_es_mr);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
-- 
2.31.1


