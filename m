Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDAD7F21A5
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 00:53:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5E3x-00072U-M7; Mon, 20 Nov 2023 18:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5E3t-00070F-T6; Mon, 20 Nov 2023 18:52:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5E3s-0001l5-73; Mon, 20 Nov 2023 18:52:17 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKNVvrE020006; Mon, 20 Nov 2023 23:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jLFFXWHjHtxXzp2RA7oPF5xM5gQPNjpU+ta6ndaQyU8=;
 b=Q/I3asgmliXW0E9aQ0xBnEQ/BQlUa5fH+8UJsqxG/kHXG4HbHEie77aP0cY6Sn0rxHNT
 n/zgWnBTIo6oQAz3hVSvv0ep3gyiRbZHcf8SxObD/0BxkpooLDm5+jfUM+KAMjOVGdi4
 WZt8V4zA8k9+WrJHCikRkg6+vsshbeL3HipWGez1TV4gNpATjkoMxg/iLS0wbwWLRJTP
 9w5J6PFXVH9bC4TJA7fsYmthNN8zlus9YmL5qFcAT83Ob1823hJBSe6jUhuJcRCEmucf
 fRP3O0Ib8pRP6rDX4bvdxwftjiowY9wM/5zQGqVxW03wfGEtQeaIaU8GD42vDkKtiILI Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugh7agavw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:52:06 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKNdUcV013689;
 Mon, 20 Nov 2023 23:52:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugh7agavm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:52:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKNmq2X003364; Mon, 20 Nov 2023 23:52:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kmpbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Nov 2023 23:52:04 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AKNq4Tl26149618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 23:52:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 232AF58043;
 Mon, 20 Nov 2023 23:52:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E683958055;
 Mon, 20 Nov 2023 23:52:03 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Nov 2023 23:52:03 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v4 05/11] ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug
 power control
Date: Mon, 20 Nov 2023 17:51:06 -0600
Message-Id: <20231120235112.1951342-6-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O1ySqcyFkj1357BomV9Hz2GcSYbyPB3Y
X-Proofpoint-ORIG-GUID: kLU5tceKL19oVfx-_d8WL6LntVf06eJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311200175
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

For power10-rainier, a pca9552 device is used for PCIe slot hotplug
power control by the Power Hypervisor code.  The code expects that
some time after it enables power to a PCIe slot by asserting one of
the pca9552 GPIO pins 0-4, it should see a "power good" signal asserted
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

Changes from previous version:
  - Code moved from pnv_chip_power10_realize to pnv_rainier_i2c_init

 hw/ppc/pnv.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9cefcd0fd6..80d25fc1bd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1898,8 +1898,24 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9552 I2C device for PCIe hotplug control
          * to engine 2, bus 1, address 0x63
          */
-        i2c_slave_create_simple(chip10->i2c[2].busses[1],
-                                "pca9552", 0x63);
+        I2CSlave *hotplug = i2c_slave_create_simple(chip10->i2c[2].busses[1],
+                                                "pca9552", 0x63);
+
+        /*
+         * Connect PCA9552 GPIO pins 0-4 (SLOTx_EN) outputs to GPIO pins 5-9
+         * (SLOTx_PG) inputs in order to fake the pgood state of PCIe slots
+         * after hypervisor code sets a SLOTx_EN pin high.
+         */
+        qdev_connect_gpio_out(DEVICE(hotplug), 0,
+                              qdev_get_gpio_in(DEVICE(hotplug), 5));
+        qdev_connect_gpio_out(DEVICE(hotplug), 1,
+                              qdev_get_gpio_in(DEVICE(hotplug), 6));
+        qdev_connect_gpio_out(DEVICE(hotplug), 2,
+                              qdev_get_gpio_in(DEVICE(hotplug), 7));
+        qdev_connect_gpio_out(DEVICE(hotplug), 3,
+                              qdev_get_gpio_in(DEVICE(hotplug), 8));
+        qdev_connect_gpio_out(DEVICE(hotplug), 4,
+                              qdev_get_gpio_in(DEVICE(hotplug), 9));
     }
 }
 
-- 
2.31.1


