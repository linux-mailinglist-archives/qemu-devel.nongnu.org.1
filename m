Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE67D3CEE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quyE5-0006QJ-1l; Mon, 23 Oct 2023 12:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1quyE2-0006Oo-9L; Mon, 23 Oct 2023 12:56:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1quyDx-0001f4-3u; Mon, 23 Oct 2023 12:56:22 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NGjWug023589; Mon, 23 Oct 2023 16:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TqMUpZZdS9MEyjmNgOWW5RkYuCjbkL9nCmHB3UG0bQU=;
 b=ByOL0tReR8+mWWD+kG6OdEjN6Xsc5FY/S/dX3LJ0ZeXcUzwp6TnvdJGukTt7S8p4cr8+
 UeyTAPBWcQYUdCwV++4gz+a0LblsFQbw9EL6JtlQcAh8j+1zvjmTvazTUswEzIlj2Uv9
 i0UzuC9LrtZGjTwb77g01jMBGnNOy1APf9lvjUbajjba1pIQpnixhItlfSanpU4Klj/a
 te20Yt8lvVoQKQ0TZr0q6cF1KuAZfcuOLdDhHbepdd6ogroAFA3tU1EZOPLDU7u5MmWG
 4Yf90aUAcvfx5LVUOIQd7FUp48FqCGRJGcjFF65VxXzZ8q87yhucTpRsxChmd22IvyDk mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twvmq8cx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 16:56:04 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39NGjv49025930;
 Mon, 23 Oct 2023 16:56:03 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twvmq8cqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 16:56:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NEMLU5024381; Mon, 23 Oct 2023 16:52:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvu6jsgbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 16:52:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39NGqJAL8323672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 16:52:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 974E258060;
 Mon, 23 Oct 2023 16:52:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6074C58056;
 Mon, 23 Oct 2023 16:52:19 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Oct 2023 16:52:19 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Subject: [PATCH] ppc/pnv: Fix number of I2C engines and ports for power9/10
Date: Mon, 23 Oct 2023 11:52:00 -0500
Message-Id: <20231023165200.3846121-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9WXQ9ja5nNn-0QOwpxE9S_LBjRalNCzZ
X-Proofpoint-GUID: 3LnrD8fEG2oIp5LtNXyUblRecQNKqOo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=577 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230147
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Based-on: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
([PATCH] ppc/pnv: Connect PNV I2C controller to powernv10)

 hw/ppc/pnv.c              | 12 ++++++++----
 include/hw/ppc/pnv_chip.h |  5 +----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2655b6e506..6ad4a1a7b1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1507,6 +1507,8 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static int pnv_power9_i2c_ports_per_ctlr[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -1626,7 +1628,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip9->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pnv_power9_i2c_ports_per_ctlr[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1667,7 +1670,6 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER9";
     k->num_pecs = PNV9_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV9_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV9_CHIP_MAX_I2C_PORTS;
 
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
                                     &k->parent_realize);
@@ -1751,6 +1753,8 @@ static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static int pnv_power10_i2c_ports_per_ctlr[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
+
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -1877,7 +1881,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         Object *obj =  OBJECT(&chip10->i2c[i]);
 
         object_property_set_int(obj, "engine", i + 1, &error_fatal);
-        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+        object_property_set_int(obj, "num-busses",
+                                pnv_power10_i2c_ports_per_ctlr[i],
                                 &error_fatal);
         object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
@@ -1918,7 +1923,6 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER10";
     k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
-    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 5815d96ecf..be1fec5698 100644
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
 
@@ -140,7 +138,6 @@ struct PnvChipClass {
     uint32_t     num_phbs;
 
     uint32_t     i2c_num_engines;
-    uint32_t     i2c_num_ports;
 
     DeviceRealize parent_realize;
 
-- 
2.31.1


