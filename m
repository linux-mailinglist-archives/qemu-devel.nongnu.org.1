Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C27DA6BC
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 13:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwhWs-0000dU-EX; Sat, 28 Oct 2023 07:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWn-0000cC-9N; Sat, 28 Oct 2023 07:30:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWl-0005VD-Pt; Sat, 28 Oct 2023 07:30:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SBFE8L031636; Sat, 28 Oct 2023 11:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q7P7aRnlpESXy63pGHtOprsVL0ZIV7bRi0QoawX605E=;
 b=bswoRnHCnKJbbMKdCT/iobyEEe+SyocP5t5D6lUPEqTvjns4l9XnqV3R+vATLAbOWXsB
 00JKXHeT66cKIayj7Et7ldEiyUeC1N8LIlaTLI0kGnpkvfvvTPzv+0ZUaSyofw/YUnac
 Weo8fVtAnZk2PerbEClkYKXuIG/DP1qMdL9XTaCjkblgALAa2f+EX2hyQIA9Sqjc6tZ4
 ccmx6OfflPCsXWdLbIvuvsZBStncIKEap8ielt8Wted/efFJNbHHTsp9l7wNk54rOagc
 HavY+mHlXC8eYYw4YufbHfF3Op9z3+7Yj8xYm+98tNi79lGMMUHhHV7paujnI/jaybra dA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u118pg7q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:49 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39SBOnn9021285;
 Sat, 28 Oct 2023 11:30:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u118pg7pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SAhWRU021478; Sat, 28 Oct 2023 11:30:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqrkj7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39SBUjSa41943784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Oct 2023 11:30:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF6D72004E;
 Sat, 28 Oct 2023 11:30:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43ACA20063;
 Sat, 28 Oct 2023 11:30:44 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Oct 2023 11:30:43 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 3/3] hw/ppc: Nest1 chiplet wiring
Date: Sat, 28 Oct 2023 06:30:26 -0500
Message-Id: <20231028113026.23510-4-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
References: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7F9BbMozeu36XklKNu-IsA25EpIBTzMz
X-Proofpoint-ORIG-GUID: yvspbwiIcXiWFdl9iQDZOCVtiSm2qNW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_09,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=631
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310280088
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

This part of the patchset connects the nest1 chiplet model to p10 chip.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ppc/pnv.c              | 11 +++++++++++
 include/hw/ppc/pnv_chip.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index eb54f93986..a5abaf5608 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1660,6 +1660,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
     object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
     object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
     object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
+    object_initialize_child(obj, "nest1_chiplet", &chip10->nest1_chiplet,
+                            TYPE_PNV_NEST1_CHIPLET);
 
     chip->num_pecs = pcc->num_pecs;
 
@@ -1829,6 +1831,15 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
                                 &chip10->homer.regs);
 
+    /* nest1 chiplet control regs */
+    object_property_set_link(OBJECT(&chip10->nest1_chiplet), "chip",
+                             OBJECT(chip), &error_abort);
+    if (!qdev_realize(DEVICE(&chip10->nest1_chiplet), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
+                           &chip10->nest1_chiplet.perv_chiplet.xscom_perv_ctrl_regs);
+
     /* PHBs */
     pnv_chip_power10_phb_realize(chip, &local_err);
     if (local_err) {
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 53e1d921d7..4bcb92595a 100644
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
2.31.1


