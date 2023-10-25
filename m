Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64E7D70BC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:28:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfnM-0003vJ-ST; Wed, 25 Oct 2023 11:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvfnJ-0003th-Bo; Wed, 25 Oct 2023 11:27:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvfnG-00063t-GA; Wed, 25 Oct 2023 11:27:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PFGD8h025738; Wed, 25 Oct 2023 15:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=n+Xj4YjRO7+N6vsBCFGPOZ6lhLKrX6v+8qTaOMOZKZs=;
 b=fDerW6KtO0jAoCZGNaLoYreBN85gOagHtVJIgLuM9xQU9baNw2hmC5jJD1eVtqWHdlHh
 7bGHPU8IH2Yo9i2XhfLQHUzU9oitgkW5IQu12mm3dES5mDwmyaY+ToAbP0oSYQbWGh9v
 i2rqyghXoryHKPoaeAdjjtV+BgoTnkLOIlAt+So20xiKMCqxmbHXGPbfCuD6eNuhUMIf
 xK1UIzpCVS5vWzHLYKDIlYWDcrnypVOJqb6gX3uAtXxlKkT4hSzTl4Jv83OSvzFnQpTA
 nCM61NxdSGNLPFhj0apEXVQjMFumv5hZgVVhMkNUHoUl6XLQ29dkMn0Czq/eT1Wm34Qm KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty5cm8myp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 15:27:26 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PFRPue030723;
 Wed, 25 Oct 2023 15:27:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty5cm8mxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 15:27:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PDo4SE005105; Wed, 25 Oct 2023 15:27:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvtfkq9sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 15:27:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39PFROrf31588942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 15:27:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D24558059;
 Wed, 25 Oct 2023 15:27:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5313558057;
 Wed, 25 Oct 2023 15:27:24 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Oct 2023 15:27:24 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Subject: [PATCH v3] ppc/pnv: Fix number of I2C engines and ports for power9/10
Date: Wed, 25 Oct 2023 10:27:14 -0500
Message-Id: <20231025152714.956664-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x8CrfEw2MhBxDCs8NKDkELD93Awlawx-
X-Proofpoint-ORIG-GUID: VHLEVKQbpHnJRbmGfVTEaOxFVHyWbd5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=710 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250134
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Power9 is supposed to have 4 PIB-connected I2C engines with the
following number of ports on each engine:

    0: 2
    1: 13
    2: 2
    3: 2

Power10 also has 4 engines but has the following number of ports
on each engine:

    0: 14
    1: 14
    2: 2
    3: 16

Current code assumes that they all have the same (maximum) number.
This can be a problem if software expects to see a certain number
of ports present (Power Hypervisor seems to care).

Fixed this by adding separate tables for power9 and power10 that
map the I2C controller number to the number of I2C buses that should
be attached for that engine.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)

Changes from v2:
    - Moved I2C port definitions close to the class definitions
    - Changed I2C port array type to const

 hw/ppc/pnv.c              | 12 ++++++++----
 include/hw/ppc/pnv_chip.h |  6 ++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2655b6e506..1a728b92a0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1626,7 +1626,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip9->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1651,6 +1652,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
+    static const int i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
@@ -1667,7 +1669,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER9";
     k->num_pecs = PNV9_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
                                     &k->parent_realize);
@@ -1877,7 +1879,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip10->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1902,6 +1905,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
+    static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
@@ -1918,7 +1922,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER10";
     k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
+    k->i2c_ports_per_engine = i2c_ports_per_engine;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 5815d96ecf..0ab5c42308 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -88,8 +88,7 @@ struct Pnv9Chip {
 #define PNV9_CHIP_MAX_PEC 3
     PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
 
-#define PNV9_CHIP_MAX_I2C 3
-#define PNV9_CHIP_MAX_I2C_PORTS 1
+#define PNV9_CHIP_MAX_I2C 4
     PnvI2C      i2c[PNV9_CHIP_MAX_I2C];
 };
 
@@ -122,7 +121,6 @@ struct Pnv10Chip {
     PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
 
 #define PNV10_CHIP_MAX_I2C 4
-#define PNV10_CHIP_MAX_I2C_PORTS 2
     PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
 };
 
@@ -140,7 +138,7 @@ struct PnvChipClass {
     uint32_t     num_phbs;
 
     uint32_t     i2c_num_engines;
-    uint32_t     i2c_num_ports;
+    const int    *i2c_ports_per_engine;
 
     DeviceRealize parent_realize;
 
-- 
2.31.1


