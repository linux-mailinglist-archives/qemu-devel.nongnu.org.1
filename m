Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 101487FA8CA
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 19:19:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7gBC-0001XN-MG; Mon, 27 Nov 2023 13:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gBA-0001Wc-Lk; Mon, 27 Nov 2023 13:17:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r7gB9-00018S-7m; Mon, 27 Nov 2023 13:17:56 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARIE4oI010407; Mon, 27 Nov 2023 18:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=nkgGlxqg8UV1SVlvWw8rs6SNQoIvMdJKthxnyYmZuwU=;
 b=K9B9FGMFCQlJccM3uEAaAyyHw7C19mk/LZJjcbEW8dwwnv/NIwN9ThBajosX4Yu+5FIt
 RVrMzcg2I37J7VNpJz5bWhICYr/AtRMwNXLgHZul/WeMfWhHI1S5vO5d0Ka25iRWgGwp
 klyVOCznm7mmdS46pGBOCmZYRGoDuJldnuLScjCxkB00/0EpAd34DMNaTI0F+L8Y5lCj
 2aQHyQLg3C6ZrilWDj3J282Qsr0tagV3zkwTPSyGwozfCufzCRn8kau9wk3oXjj9WTnA
 Xqy27bplK/2qwNCBtFTophshoWSx9c3MuL1Na2MHVhwkZgDMJRFiD7GpexGxvgIDn2BP Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un077r39r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:51 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARIEpP8012873;
 Mon, 27 Nov 2023 18:17:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un077r32k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARGtR5n009198; Mon, 27 Nov 2023 18:17:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyaph7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 18:17:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARIHSiY24380044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 18:17:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1508958058;
 Mon, 27 Nov 2023 18:17:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBDC658057;
 Mon, 27 Nov 2023 18:17:27 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 18:17:27 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Subject: [PATCH v6 6/9] ppc/pnv: Use resettable interface to reset child I2C
 buses
Date: Mon, 27 Nov 2023 12:16:52 -0600
Message-Id: <20231127181655.1997496-7-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
References: <20231127181655.1997496-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LXhuv4HZNFfEza4UJxqzFcfPjXrra-qB
X-Proofpoint-ORIG-GUID: SBFlI2esIkUzoEIPFpc0lLDVh25pAWRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_16,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=736
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

The QEMU I2C buses and devices use the resettable
interface for resetting while the PNV I2C controller
and parent buses and devices have not yet transitioned
to this new interface and use the old reset strategy.
This was preventing the I2C buses and devices wired
to the PNV I2C controller from being reset.

The short term fix for this is to have the PNV I2C
Controller's reset function explicitly call the resettable
interface function, bus_cold_reset(), on all child
I2C buses.

The long term fix should be to transition all PNV parent
devices and buses to use the resettable interface so that
all child buses and devices are automatically reset.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No change from previous version

 hw/ppc/pnv_i2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 656a48eebe..774946d6b2 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -629,6 +629,19 @@ static int pnv_i2c_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
+static void pnv_i2c_sys_reset(void *dev)
+{
+    int port;
+    PnvI2C *i2c = PNV_I2C(dev);
+
+    pnv_i2c_reset(dev);
+
+    /* reset all buses connected to this i2c controller */
+    for (port = 0; port < i2c->num_busses; port++) {
+        bus_cold_reset(BUS(i2c->busses[port]));
+    }
+}
+
 static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 {
     PnvI2C *i2c = PNV_I2C(dev);
@@ -654,7 +667,7 @@ static void pnv_i2c_realize(DeviceState *dev, Error **errp)
 
     fifo8_create(&i2c->fifo, PNV_I2C_FIFO_SIZE);
 
-    qemu_register_reset(pnv_i2c_reset, dev);
+    qemu_register_reset(pnv_i2c_sys_reset, dev);
 
     qdev_init_gpio_out(DEVICE(dev), &i2c->psi_irq, 1);
 }
-- 
2.31.1


