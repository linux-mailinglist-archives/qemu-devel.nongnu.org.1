Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB897EB71D
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2zXm-0004sv-EP; Tue, 14 Nov 2023 14:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2zXd-0004rh-UN; Tue, 14 Nov 2023 14:57:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r2zXa-0003Wo-H0; Tue, 14 Nov 2023 14:57:45 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEJkPEr026447; Tue, 14 Nov 2023 19:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QgprFp7kxoN61vp0Crwg1xaxjS78Z1YhLvZ2Ip8qqf8=;
 b=saXbensSUW61GjjH2DIcRYTdSklGo9NXEX6lTXBc2c7eSEBsVZpoS1RJEY6iyYzU5lQx
 TLU3SPLPeriW8Gnz5yZHpELki7gNvZz6T4QunkKuuo8/xWSiH8l1y4qc1pIVJgure2Ij
 w6aVCnhYzAnOnkDh6uYBs0G1EQCVNwC8fBOGTWWTSLMNgTkYvbCtuVXBpc96Yp9Yg9ML
 vC0oGFySmkBZJtgvZjTghPZdYydRM5vJqCcHm2umw8/WR6AJc3yHuqOBdb2ii3d49uUF
 WMVp8qPPbqIVLImVGfceQp98h+qQQxpbvpf1cgK5EPI+pverr1X8RYFvab9O2JB4+ove Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uceww16bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 19:57:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEJkrvR027575;
 Tue, 14 Nov 2023 19:57:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uceww16ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 19:57:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEJnH6t029435; Tue, 14 Nov 2023 19:57:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn1hrhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 19:57:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEJvaKA22938264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 19:57:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EABC5805A;
 Tue, 14 Nov 2023 19:57:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AC5858051;
 Tue, 14 Nov 2023 19:57:36 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 19:57:36 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v3 4/8] ppc/pnv: Fix PNV I2C invalid status after reset
Date: Tue, 14 Nov 2023 13:56:55 -0600
Message-Id: <20231114195659.1219821-5-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zF7mJHMb9suVxGW5hEyDYXKlGIxJwH7H
X-Proofpoint-ORIG-GUID: 1Q7a8KEFoN0tyEXyoxi-X4wPeSYyiYx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_20,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=843
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140150
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

The PNV I2C Controller was clearing the status register
after a reset without repopulating the "upper threshold
for I2C ports", "Command Complete" and the SCL/SDA input
level fields.

Fixed this for resets caused by a system reset as well
as from writing to the "Immediate Reset" register.

Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

Changes from v2:
    -Added Fixes: tag

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


