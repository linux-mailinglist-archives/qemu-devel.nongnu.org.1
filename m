Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 792437E7E21
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:25:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VEq-0005GO-8q; Fri, 10 Nov 2023 12:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VES-0004d8-UU; Fri, 10 Nov 2023 12:23:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r1VER-0001Li-35; Fri, 10 Nov 2023 12:23:48 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAHMnjs010444; Fri, 10 Nov 2023 17:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xUr+2y2qt8jU7iels+dJPVMGmTqA8rb9xfHFMnKN58A=;
 b=oOIM8GsnqgCvvwyHvLWEyMb97IadEwpngD3/qiCMhvjcrA0Nucae04xEfANqUvUA51B5
 mU3s9INtM45PmciYFU4Gbf44Eab9oCi8mwOQOgbyL9+ZFUpm0+1TbjvGcwJw+mAT0JTl
 lIAyvzLXTS9HPLx1Dba1hDe2QLteuas/ekam8objwpDO5bV6FJ7YSz7/0KJjqfWpUoeD
 x6Enx/Rc+jfQ16OVpNWGZcveg+ULuHQMVNrv6HA4HNBSlRihHaOG7YMZ3FOLyGATPbkP
 KNv/mgObvo+BJAl21GFxRqKcUZwyac4ft67RRCnWBtxFfIG7F/2epjZ5Hd0vZY2lvruQ ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9rv000gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:28 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHNSEA012795;
 Fri, 10 Nov 2023 17:23:28 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9rv000g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:27 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAH8jrK003443; Fri, 10 Nov 2023 17:23:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w22caew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:23:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHNQeQ20841184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:23:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55A9458045;
 Fri, 10 Nov 2023 17:23:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F099658050;
 Fri, 10 Nov 2023 17:23:25 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:23:25 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 2/8] ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power
 control
Date: Fri, 10 Nov 2023 11:22:42 -0600
Message-Id: <20231110172248.3885194-3-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
References: <20231110172248.3885194-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hflE7fHd5jYCprqmcElSvi9Yk_LVWgbh
X-Proofpoint-ORIG-GUID: YxZny9Dyys6ZuX2LHa8h-MeZG10O3vV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100144
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

For power10, a pca9552 device is used for PCIe slot hotplug power
control by the Power Hypervisor code.  The code expects that some
time after it enables power to a PCIe slot by asserting one of the
pca9552 GPIO pins 0-4, it should see a "power good" signal asserted
on one of pca9552 GPIO pins 5-9.

To simulate this behavior, we simply connect the GPIO outputs for
pins 0-4 to the GPIO inputs for pins 5-9.

Each PCIe slot is assigned 3 GPIO pins on the pca9552 device, for
control of up to 5 PCIe slots.  The per-slot signal names are:

   SLOTx_EN.......PHYP uses this as an output to enable
                  slot power.  We connect this to the
                  SLOTx_PG pin to simulate a PGOOD signal.
   SLOTx_PG.......PHYP uses this as in input to detect
                  PGOOD for the slot.  For our purposes
                  we just connect this to the SLOTx_EN
                  output.
   SLOTx_Control..PHYP uses this as an output to prevent
                  a race condition in the real hotplug
                  circuitry, but we can ignore this output
                  for simulation.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 hw/ppc/pnv.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7afaf1008f..0b24d7d8ed 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1882,7 +1882,24 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
      * Add a PCA9552 I2C device for PCIe hotplug control
      * to engine 2, bus 1, address 0x63
      */
-    i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
+    I2CSlave* hotplug = i2c_slave_create_simple(chip10->i2c[2].busses[1],
+                                                "pca9552", 0x63);
+
+    /*
+     * Connect PCA9552 GPIO pins 0-4 (SLOTx_EN) outputs to GPIO pins 5-9
+     * (SLOTx_PG) inputs in order to fake the pgood state of PCIe slots after
+     * hypervisor code sets a SLOTx_EN pin high.
+     */
+    qdev_connect_gpio_out(DEVICE(hotplug), 0,
+                          qdev_get_gpio_in(DEVICE(hotplug), 5));
+    qdev_connect_gpio_out(DEVICE(hotplug), 1,
+                          qdev_get_gpio_in(DEVICE(hotplug), 6));
+    qdev_connect_gpio_out(DEVICE(hotplug), 2,
+                          qdev_get_gpio_in(DEVICE(hotplug), 7));
+    qdev_connect_gpio_out(DEVICE(hotplug), 3,
+                          qdev_get_gpio_in(DEVICE(hotplug), 8));
+    qdev_connect_gpio_out(DEVICE(hotplug), 4,
+                          qdev_get_gpio_in(DEVICE(hotplug), 9));
 
 }
 
-- 
2.31.1


