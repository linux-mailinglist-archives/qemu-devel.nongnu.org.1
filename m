Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B397E8310
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 20:51:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XWz-0003HX-0K; Fri, 10 Nov 2023 14:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1XWx-000388-5p; Fri, 10 Nov 2023 14:51:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1XWv-0002Uh-DI; Fri, 10 Nov 2023 14:51:02 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAJfFBG001976; Fri, 10 Nov 2023 19:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a0GP25viI1IX7b79DyNGWma37TXbvOA5X/mUzbfWuFk=;
 b=hEgcSJzWNQq54krZL281V0hNiuG8r8yISWu6nkp2JRAJ8ieLJKEHiaqHC7ghOZDVWb8J
 aFJYTjU3nZs+o2OwX/erEYOuWv+7k+u2XFTCg2ORA7e53qYD/M1utsdCMvT3pqMUyOul
 X3H1v21P+G1ZLX9aJCzNqqgSSgCWvUUCMvub8RM/WQs4eX9qBRNs7Gb1zJ/ZhRYXTAxs
 ahVsG8sj1VzOmSKLbGIfifz3k5bJ1QKCJ2XNheEHRIKQ9RJMcb5QBVm6ADtAqtMSyxlT
 mpjsyD1jmEihG8IQdijG84npkY1p7ICiezfA3zyHskZQMHqIveOtpQSZSbOC53RqMcKH kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9tvwg7y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 19:50:51 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAJgeic006315;
 Fri, 10 Nov 2023 19:50:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9tvwg7n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 19:50:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAIxkbV028348; Fri, 10 Nov 2023 19:49:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22w7nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 19:49:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAJnkom17695438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 19:49:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA53058054;
 Fri, 10 Nov 2023 19:49:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 683CE58045;
 Fri, 10 Nov 2023 19:49:46 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 19:49:46 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v2 4/8] ppc/pnv: Fix PNV I2C invalid status after reset
Date: Fri, 10 Nov 2023 13:49:21 -0600
Message-Id: <20231110194925.475909-5-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
References: <20231110194925.475909-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nTD1h1fM8M0R3G4Je8U-ZuGM8QyNUYU9
X-Proofpoint-ORIG-GUID: 4GMNP_MffUaYJsLbBVjXrjtJXvld-ViL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=759 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100166
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

The PNV I2C Controller was clearing the status register
after a reset without repopulating the "upper threshold
for I2C ports", "Command Complete" and the SCL/SDA input
level fields.

Fixed this for resets caused by a system reset as well
as from writing to the "Immediate Reset" register.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 hw/ppc/pnv_i2c.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index b2c738da50..f80589157b 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -462,6 +462,23 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
     return val;
 }
 
+static void pnv_i2c_reset(void *dev)
+{
+    PnvI2C *i2c = PNV_I2C(dev);
+
+    memset(i2c->regs, 0, sizeof(i2c->regs));
+
+    i2c->regs[I2C_STAT_REG] =
+        SETFIELD(I2C_STAT_UPPER_THRS, 0ull, i2c->num_busses - 1) |
+        I2C_STAT_CMD_COMP | I2C_STAT_SCL_INPUT_LEVEL |
+        I2C_STAT_SDA_INPUT_LEVEL;
+    i2c->regs[I2C_EXTD_STAT_REG] =
+        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
+        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
+
+    fifo8_reset(&i2c->fifo);
+}
+
 static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
@@ -499,16 +516,7 @@ static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
         break;
 
     case I2C_RESET_I2C_REG:
-        i2c->regs[I2C_MODE_REG] = 0;
-        i2c->regs[I2C_CMD_REG] = 0;
-        i2c->regs[I2C_WATERMARK_REG] = 0;
-        i2c->regs[I2C_INTR_MASK_REG] = 0;
-        i2c->regs[I2C_INTR_COND_REG] = 0;
-        i2c->regs[I2C_INTR_RAW_COND_REG] = 0;
-        i2c->regs[I2C_STAT_REG] = 0;
-        i2c->regs[I2C_RESIDUAL_LEN_REG] = 0;
-        i2c->regs[I2C_EXTD_STAT_REG] &=
-            (I2C_EXTD_STAT_FIFO_SIZE | I2C_EXTD_STAT_I2C_VERSION);
+        pnv_i2c_reset(i2c);
         break;
 
     case I2C_RESET_ERRORS:
@@ -620,20 +628,6 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
-static void pnv_i2c_reset(void *dev)
-{
-    PnvI2C *i2c = PNV_I2C(dev);
-
-    memset(i2c->regs, 0, sizeof(i2c->regs));
-
-    i2c->regs[I2C_STAT_REG] = I2C_STAT_CMD_COMP;
-    i2c->regs[I2C_EXTD_STAT_REG] =
-        SETFIELD(I2C_EXTD_STAT_FIFO_SIZE, 0ull, PNV_I2C_FIFO_SIZE) |
-        SETFIELD(I2C_EXTD_STAT_I2C_VERSION, 0ull, 23); /* last version */
-
-    fifo8_reset(&i2c->fifo);
-}
-
 static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 {
     PnvI2C *i2c = PNV_I2C(dev);
-- 
2.31.1


