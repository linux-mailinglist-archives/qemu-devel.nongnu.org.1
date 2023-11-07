Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B27E45B9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:17:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0OkY-0007za-4C; Tue, 07 Nov 2023 11:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gin-0006A1-So; Tue, 07 Nov 2023 02:42:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gil-0006aC-GU; Tue, 07 Nov 2023 02:42:01 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A77dZ2d018164; Tue, 7 Nov 2023 07:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Jw2xSs+BxAc8oeAD791uufh2poFYCMzdEe6QqC8uh7Y=;
 b=SkJYclP38rVlLgSe+r5JjPaLfM5bSPv2iTY4b/qDcaq1dtcmlg95DN6EVBLhazw0Z37t
 Wyo2ycG/U60UPXVELWsG1p7umDeG2LENYvqS0l+d9HilRHMMdIWk0ynaVLTFLros8Mlr
 hyCtW/lHC31JZSo+/3+vB/oLvnaCpPJjTug+a09ZY0c9O2oWESO+WmJUPWrLZvScDDz+
 5cpikFM/EQm0htQnbLJTVNQNzsWiGVLlDYKUDfRrXs9qEhCKU4yQcqESu47TmRzl4d/F
 62lEW9R0768RRMxqGlrMwVMaQHvs/QpoYZFqrVBGJFugIqEvsHxofT/haDQN0/VJE76k Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1sg2wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:37 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77diSo018894;
 Tue, 7 Nov 2023 07:41:36 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1sg2we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A76B9CL012797; Tue, 7 Nov 2023 07:41:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u609sqc45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A77fXSQ63832410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 07:41:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 252A55805C;
 Tue,  7 Nov 2023 07:41:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09EE65805B;
 Tue,  7 Nov 2023 07:41:33 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: by gfwr516.rchland.ibm.com (Postfix, from userid 607334)
 id 47B62220041; Tue,  7 Nov 2023 01:41:32 -0600 (CST)
From: Chalapathi V <chalap1@gfwr516.rchland.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com, Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PATCH v4 3/3] hw/ppc: Nest1 chiplet wiring
Date: Tue,  7 Nov 2023 01:41:27 -0600
Message-Id: <20231107074127.31821-4-chalap1@gfwr516.rchland.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
References: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B1JaVuTRIogQJ2klZ4OZSShgf-lFzlCg
X-Proofpoint-ORIG-GUID: TnCjVkpcXZAK6akRaViQNELVdZtI44xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1034 mlxlogscore=843 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311070062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=chalap1@us.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Nov 2023 11:16:20 -0500
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

This part of the patchset connects the nest1 chiplet model to p10 chip.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/pnv.c              | 14 ++++++++++++++
 include/hw/ppc/pnv_chip.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0e34ff..2b93cdd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -351,6 +351,8 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
     static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
     int i;
 
+    Pnv10Chip *chip10 = PNV10_CHIP(chip);
+
     pnv_dt_xscom(chip, fdt, 0,
                  cpu_to_be64(PNV10_XSCOM_BASE(chip)),
                  cpu_to_be64(PNV10_XSCOM_SIZE),
@@ -366,6 +368,9 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
         pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_size);
     }
 
+    /* Populate nest1_chiplet device tree */
+    PNV_NEST1CHIPLET_GET_CLASS(&chip10->nest1_chiplet)->nest1_dt_populate(fdt);
+
     pnv_dt_lpc(chip, fdt, 0, PNV10_LPCM_BASE(chip), PNV10_LPCM_SIZE);
 }
 
@@ -1649,6 +1654,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
+    object_initialize_child(obj, "nest1_chiplet", &chip10->nest1_chiplet,
+                            TYPE_PNV_NEST1_CHIPLET);
 
     chip->num_pecs = pcc->num_pecs;
 
@@ -1813,6 +1820,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
                                 &chip10->homer.regs);
 
+    /* nest1 chiplet control regs */
+    if (!qdev_realize(DEVICE(&chip10->nest1_chiplet), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
+                   &chip10->nest1_chiplet.perv_chiplet.xscom_perv_ctrl_regs);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 53e1d92..4bcb925 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -4,6 +4,7 @@
 #include "hw/pci-host/pnv_phb4.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
+#include "hw/ppc/pnv_nest_chiplet.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -109,6 +110,7 @@ struct Pnv10Chip {
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
+    PnvNest1Chiplet nest1_chiplet;
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
-- 
1.8.3.1


