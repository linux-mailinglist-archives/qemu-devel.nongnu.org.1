Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F67F21AA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 00:53:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5E3w-00072B-Uq; Mon, 20 Nov 2023 18:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5E3v-00071e-Gj; Mon, 20 Nov 2023 18:52:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5E3t-0001ld-Sg; Mon, 20 Nov 2023 18:52:19 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKNgD06022675; Mon, 20 Nov 2023 23:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GR4rc0XWsgPxrFgsj8a0uT3ebqKUakUMXGYxfutz9lM=;
 b=m8qJvSaqIS+SyaEvbJI0nozYA9aB7LgbYtBZMaHdNmTgUjYeKNPVjIqkEbGnQhIMse89
 gc3Se+FK2WI6MIoyO4MVk1Q4c23x41W//rC4nVkOR5TjB0f804q2hsRf61A1ikpl/J0n
 BJnPr2VOqrb/CElrQz1UCYwwN5QZ2eGMrIkfbtdtzGtugRHBmmBe9sFQUG5e5+jWZsls
 VFaDYdgGkK22tvloF1DXw4lhukrEVXEqf30jggXC8iDrMGV1hoDdhaSskrgcf5ym1TxK
 4QTEdy6hNdlKqFmfY14DXYjfzBsdR//yQQFqXb+Ya2MQSLxEbh8G+uQjqKUfav0c0fsw 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ughc0059r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:52:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKNi6oV027737;
 Mon, 20 Nov 2023 23:52:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ughc0059j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:52:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKNmmbZ008217; Mon, 20 Nov 2023 23:52:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tk4f32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:52:06 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AKNq5qu44237432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 23:52:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D081F58059;
 Mon, 20 Nov 2023 23:52:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A02BB58043;
 Mon, 20 Nov 2023 23:52:05 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Nov 2023 23:52:05 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v4 06/11] ppc/pnv: PNV I2C engines assigned incorrect XSCOM
 addresses
Date: Mon, 20 Nov 2023 17:51:07 -0600
Message-Id: <20231120235112.1951342-7-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ji3TKStalJI0KWfM3iSAy5nWAoXN2kac
X-Proofpoint-GUID: MpNo-JnF1MqugL4a6ZFYstlLvrSrZozA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=752 spamscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200175
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Fixes: 1ceda19c28a1 ("ppc/pnv: Connect PNV I2C controller to powernv10)
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No changes from previous version

 hw/ppc/pnv.c     | 6 ++++--
 hw/ppc/pnv_i2c.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 80d25fc1bd..c29a136465 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1631,7 +1631,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
             return;
         }
         pnv_xscom_add_subregion(chip, PNV9_XSCOM_I2CM_BASE +
-                               chip9->i2c[i].engine * PNV9_XSCOM_I2CM_SIZE,
+                                (chip9->i2c[i].engine - 1) *
+                                        PNV9_XSCOM_I2CM_SIZE,
                                 &chip9->i2c[i].xscom_regs);
         qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
                               qdev_get_gpio_in(DEVICE(&chip9->psi),
@@ -1879,7 +1880,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
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


