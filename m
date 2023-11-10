Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D527E7E20
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:25:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VEn-0004vD-GZ; Fri, 10 Nov 2023 12:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VEV-0004gS-Bg; Fri, 10 Nov 2023 12:23:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VER-0001Lz-3b; Fri, 10 Nov 2023 12:23:49 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAGGINe028699; Fri, 10 Nov 2023 17:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/JwNLu7mrM86wGF1XfEj/6HO1y9iBQtDCwI33+5WE5M=;
 b=QEQsZGkEME2v1dHGFqh8MeXKDZphrmycBqgMsSAi/To9MeTY6cOOrsNlXGhonjhIlgdc
 52+ZSvgbLM/QJNfIHMK2/LqzOoHX5zORn4u0cYTnBACny4F00ymHgglRaUAjLE6P1TaY
 Pj9jKUNHmjNdQhs0GC/UYJ56wlIJTi8jj1FoCdY+lAvV31+NtiFQtR+pJR0qbg1afPzg
 XX66ygrYHrF7mcVShMlHtFM++Lfn6fYaa3zAky2yJMjIqwvQMsEhpn9P2Vppusg6aezB
 AFYWFFO7PUBiwHpXXAW+oT9gyQ+3IazpoQpLNpMiMHjCsSua3VpcxsfeIACWvyFoPRE/ Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9qfgajey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:33 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHLcHA020943;
 Fri, 10 Nov 2023 17:23:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9qfgajdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAGTBVw014309; Fri, 10 Nov 2023 17:23:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22cbym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHNVbu18088578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:23:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2A458045;
 Fri, 10 Nov 2023 17:23:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E20DA58050;
 Fri, 10 Nov 2023 17:23:30 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:23:30 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 3/8] ppc/pnv: PNV I2C engines assigned incorrect XSCOM
 addresses
Date: Fri, 10 Nov 2023 11:22:43 -0600
Message-Id: <20231110172248.3885194-4-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
References: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RCpk0I82fDaHmTV703B0WajATWBdsiqr
X-Proofpoint-ORIG-GUID: 88iar2Hdz1TYNp387V9dgiY_wg13prAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=734 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100144
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

The PNV I2C engines for power9 and power10 were being assigned a base
XSCOM address that was off by one I2C engine's address range such
that engine 0 had engine 1's address and so on.  The xscom address
assignment was being based on the device tree engine numbering, which
starts at 1.  Rather than changing the device tree numbering to start
with 0, the addressing was changed to be based on the existing device
tree numbers minus one.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 hw/ppc/pnv.c     | 6 ++++--
 hw/ppc/pnv_i2c.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0b24d7d8ed..516434bc9c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1623,7 +1623,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
             return;
         }
         pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
-                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
+                                (chip9->i2c[i].engine - 1) *
+                                        PNV9_XSCOM_I2CM_SIZE,
                                 &chip9->i2c[i].xscom_regs);
         qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
                               qdev_get_gpio_in(DEVICE(&chip9->psi),
@@ -1871,7 +1872,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
             return;
         }
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_I2CM_BASE +
-                                chip10->i2c[i].engine * PNV10_XSCOM_I2CM_SIZE,
+                                (chip10->i2c[i].engine - 1) *
+                                        PNV10_XSCOM_I2CM_SIZE,
                                 &chip10->i2c[i].xscom_regs);
         qdev_connect_gpio_out(DEVICE(&chip10->i2c[i]), 0,
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index f75e59e709..b2c738da50 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -593,7 +593,7 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
     int i2c_offset;
     const char i2c_compat[] = "ibm,power8-i2cm\0ibm,power9-i2cm";
     uint32_t i2c_pcba = PNV9_XSCOM_I2CM_BASE +
-        i2c->engine * PNV9_XSCOM_I2CM_SIZE;
+        (i2c->engine - 1) * PNV9_XSCOM_I2CM_SIZE;
     uint32_t reg[2] = {
         cpu_to_be32(i2c_pcba),
         cpu_to_be32(PNV9_XSCOM_I2CM_SIZE)
-- 
2.31.1


