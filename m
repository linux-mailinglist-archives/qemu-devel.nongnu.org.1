Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD87D5D1C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 23:23:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvOqz-0006bm-M8; Tue, 24 Oct 2023 17:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvOqw-0006bX-LX; Tue, 24 Oct 2023 17:22:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qvOqp-0006EW-Pp; Tue, 24 Oct 2023 17:22:18 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OLCwNK012740; Tue, 24 Oct 2023 21:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=20OCEaLL45CYoryFN0eFzFnul6Qs4Dg3Je0ad2Lxwsg=;
 b=Ix9s7ncafosw5SNOG+o+5+1EZRuPhfpBALB51yNnjOc1CA8S4tJMd5CF+2jprF3xdxSO
 pyGhHtJoa3sBs3R2Jt6LZxJfhFn2ibd9bOFiHFXPuLgSiXAjMKsojRZhbpjak/SGospK
 v8n6/DfLcHqE5wI4dLR5F8VTN73s8zCqKRJmUzk4AyERh0RqpyVn+Z55nBic/LSbMWV4
 T6crzI2W6yEpNAstDNlblCBplecHNMU9LFbnmryRSC+AqxKSLUEsFmWFNT5u3vunPGr+
 EuPPZtMLHE0cQBqUqVn+UhN3lCb2G4gCH5cOaGlexFb8A50iHNK/2pcEfJBdqDnYNm3K cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txnmw09wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 21:21:59 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OLGoFL027576;
 Tue, 24 Oct 2023 21:21:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txnmw09wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 21:21:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OKe1sv023800; Tue, 24 Oct 2023 21:21:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvryt2jn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 21:21:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OLLvrP30802350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 21:21:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A91558058;
 Tue, 24 Oct 2023 21:21:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F7E158059;
 Tue, 24 Oct 2023 21:21:56 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 21:21:56 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Subject: [PATCH v2] ppc/pnv: Fix number of I2C engines and ports for power9/10
Date: Tue, 24 Oct 2023 16:21:48 -0500
Message-Id: <20231024212148.33387-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mc_RjgCTOLcxPhDLsc32Pt5dXeQMzZrx
X-Proofpoint-ORIG-GUID: v3LkLEQUwnxarA5S6JU4KDlePQmDhqT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_21,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=654
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240184
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

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

Changes from v1:
    - Added i2c_ports_per_engine to PnvChipClass
    - replaced the word "ctlr" with "engine"

 hw/ppc/pnv.c              | 14 ++++++++++----
 include/hw/ppc/pnv_chip.h |  6 ++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2655b6e506..f6dc84b869 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1507,6 +1507,8 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static int pnv_power9_i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -1626,7 +1628,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip9->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1667,7 +1670,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER9";
     k->num_pecs = PNV9_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
+    k->i2c_ports_per_engine = pnv_power9_i2c_ports_per_engine;
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
                                     &k->parent_realize);
@@ -1751,6 +1754,8 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static int pnv_power10_i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
+
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -1877,7 +1882,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip10->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pcc->i2c_ports_per_engine[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1918,7 +1924,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER10";
     k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
+    k->i2c_ports_per_engine = pnv_power10_i2c_ports_per_engine;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 5815d96ecf..3643e0fd86 100644
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
+    int          *i2c_ports_per_engine;
 
     DeviceRealize parent_realize;
 
-- 
2.31.1


