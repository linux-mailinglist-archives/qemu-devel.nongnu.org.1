Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 755917FA8CB
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 19:19:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7gBD-0001Y3-Jj; Mon, 27 Nov 2023 13:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gBB-0001Wo-DL; Mon, 27 Nov 2023 13:17:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gB9-00018Z-Sb; Mon, 27 Nov 2023 13:17:57 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARIE5pH010487; Mon, 27 Nov 2023 18:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZgC1I8nOP1IWtgez8DvBdSGGXz8ZpWJd0sotXK22zuo=;
 b=ePSgdERckQmkBmiOmvqULe0ZUCqq6IMNbEnsrO94tqjzjjHJjEYFsca7SHyaAo05mFst
 kzfyKrmsN6iFPElY0b0ceZ2ySoxkPscyECbf7fgWFLvIfxVb6P+0f6ljvD4jPUVGZkwc
 uGeq42sRZIjED0n/9xRs4EJZPsX9N0SCwtgdiE2JTCx3eSnRwoFsj490WiMGYKEVY93f
 VYi6rrQ32VOXqjM7XHQ8VYfFBoippaTjeNIilUNivV6YUkZ6ysIXDl5O1OtzbGTUY/3G
 1ddxsNu6j8xvmbjIaCv520KD4p+6wJ6qte8eECh6NqE1N1YNBz3d+xvVjYqd8Nrg5cXe yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un077r39y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:52 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARIF2d1013125;
 Mon, 27 Nov 2023 18:17:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un077r31t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARGoPwC016887; Mon, 27 Nov 2023 18:17:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8stsb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARIHQkc14287574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 18:17:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E39258058;
 Mon, 27 Nov 2023 18:17:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50F0858057;
 Mon, 27 Nov 2023 18:17:26 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 18:17:26 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Subject: [PATCH v6 5/9] ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug
 power control
Date: Mon, 27 Nov 2023 12:16:51 -0600
Message-Id: <20231127181655.1997496-6-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
References: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C1kEyScSQYiC4ZUuG5O2JoTX94k_MZ45
X-Proofpoint-ORIG-GUID: a5CzExKJTVxzr-RS-P1FkqF1RFy7y0Hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270126
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

Changes from previous version:
  - Changed 'hotplug' variable name to 'dev'

 hw/ppc/pnv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d8d19fb065..42105211f5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1900,7 +1900,19 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
          * Add a PCA9552 I2C device for PCIe hotplug control
          * to engine 2, bus 1, address 0x63
          */
-        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
+        I2CSlave *dev = i2c_slave_create_simple(chip10->i2c[2].busses[1],
+                                                "pca9552", 0x63);
+
+        /*
+         * Connect PCA9552 GPIO pins 0-4 (SLOTx_EN) outputs to GPIO pins 5-9
+         * (SLOTx_PG) inputs in order to fake the pgood state of PCIe slots
+         * after hypervisor code sets a SLOTx_EN pin high.
+         */
+        qdev_connect_gpio_out(DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(dev), 5));
+        qdev_connect_gpio_out(DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(dev), 6));
+        qdev_connect_gpio_out(DEVICE(dev), 2, qdev_get_gpio_in(DEVICE(dev), 7));
+        qdev_connect_gpio_out(DEVICE(dev), 3, qdev_get_gpio_in(DEVICE(dev), 8));
+        qdev_connect_gpio_out(DEVICE(dev), 4, qdev_get_gpio_in(DEVICE(dev), 9));
     }
 }
 
-- 
2.31.1


