Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CEE7CCFF8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssPI-00072y-Ts; Tue, 17 Oct 2023 18:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qssPG-00071y-5N; Tue, 17 Oct 2023 18:19:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qssPD-0003QG-WC; Tue, 17 Oct 2023 18:19:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HMIvWi001565; Tue, 17 Oct 2023 22:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zqmu1bTo+8wQ8MZuSaYqVCcmAe0/CMYSlmcGLQ+19zU=;
 b=YK0ryXquxwanKdT7a33LSl3+LCzLb17VHxkSKsD/wgXbIGFpPxy0WhPsmwZj8ni66Wt4
 p3B5gRgbkkW1pc58hTlrdUBh5XlNxil8Ffq2Zrnai39zj6KI6AUWOWX3epQTYKjA8VHe
 YWFfjV5m1pcev6MYIS9jXE2W2uAta7E6aEscjbzn8toLvG848VVam60bsT08AsVL5c7U
 n4kVtPJjWxTU6Gxjfy0A7hFzKMx9+0Ci2jnRixPBqOTLmjQMgWPCTn1MXQnTIW9c3LGg
 06zHzQJh9EWG3GVre0B+S06j+VhEV03bZuhGgC1GbPiTBISUzIEinFCsNqFQsuJb84V9 WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt23b1hqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 22:19:06 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HMJ52Q001687;
 Tue, 17 Oct 2023 22:19:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt23b1g2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 22:19:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HJdYE4027177; Tue, 17 Oct 2023 22:14:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tkbysx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Oct 2023 22:14:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39HMEhUj31195650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Oct 2023 22:14:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C67DF58055;
 Tue, 17 Oct 2023 22:14:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EA625804B;
 Tue, 17 Oct 2023 22:14:43 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Oct 2023 22:14:43 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Subject: [PATCH] ppc/pnv: Connect PNV I2C controller to powernv10
Date: Tue, 17 Oct 2023 17:14:34 -0500
Message-Id: <20231017221434.810363-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DbFl7kS1qVYuy-GVQ0WCktXPRB_UbfCU
X-Proofpoint-GUID: XsXQ2YeO84wtWyDm1zs6x3q19WpkEmU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=616 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170188
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Wires up four I2C controller instances to the powernv10 chip
XSCOM address space.

Each controller instance is wired up to two I2C buses of
its own.  No other I2C devices are connected to the buses
at this time.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
Based-on: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
([PATCH v3 0/2] Add PowerNV I2C Controller Model)

 hw/ppc/pnv.c               | 29 +++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |  4 ++++
 include/hw/ppc/pnv_xscom.h |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e0b3478325..2655b6e506 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1695,6 +1695,10 @@ static void pnv_chip_power10_instance_init(Object *obj)
         object_initialize_child(obj, "pec[*]", &chip10->pecs[i],
                                 TYPE_PNV_PHB5_PEC);
     }
+
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
+    }
 }
 
 static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
@@ -1753,6 +1757,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     PnvChip *chip = PNV_CHIP(dev);
     Pnv10Chip *chip10 = PNV10_CHIP(dev);
     Error *local_err = NULL;
+    int i;
 
     /* XSCOM bridge is first */
     pnv_xscom_realize(chip, PNV10_XSCOM_SIZE, &local_err);
@@ -1863,6 +1868,28 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+
+
+    /*
+     * I2C
+     */
+    for (i = 0; i < pcc->i2c_num_engines; i++) {
+        Object *obj =  OBJECT(&chip10->i2c[i]);
+
+        object_property_set_int(obj, "engine", i + 1, &error_fatal);
+        object_property_set_int(obj, "num-busses", pcc->i2c_num_ports,
+                                &error_fatal);
+        object_property_set_link(obj, "chip", OBJECT(chip), &error_abort);
+        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
+                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
+                                &chip10->i2c[i].xscom_regs);
+        qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                               PSIHB9_IRQ_SBE_I2C));
+    }
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -1890,6 +1917,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     k->xscom_pcba = pnv_chip_power10_xscom_pcba;
     dc->desc = "PowerNV Chip POWER10";
     k->num_pecs = PNV10_CHIP_MAX_PEC;
+    k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
+    k->i2c_num_ports = PNV10_CHIP_MAX_I2C_PORTS;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 90cfbad1a5..5815d96ecf 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -120,6 +120,10 @@ struct Pnv10Chip {
 
 #define PNV10_CHIP_MAX_PEC 2
     PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
+
+#define PNV10_CHIP_MAX_I2C 4
+#define PNV10_CHIP_MAX_I2C_PORTS 2
+    PnvI2C       i2c[PNV10_CHIP_MAX_I2C];
 };
 
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 0c8b873c4c..2b607b22c9 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -152,6 +152,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
 
+#define PNV10_XSCOM_I2CM_BASE      PNV9_XSCOM_I2CM_BASE
+#define PNV10_XSCOM_I2CM_SIZE      PNV9_XSCOM_I2CM_SIZE
+
 #define PNV10_XSCOM_OCC_BASE       PNV9_XSCOM_OCC_BASE
 #define PNV10_XSCOM_OCC_SIZE       PNV9_XSCOM_OCC_SIZE
 
-- 
2.31.1


