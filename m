Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 388867F36AC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 20:13:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5W8n-0008Fp-06; Tue, 21 Nov 2023 14:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8k-0008E7-34; Tue, 21 Nov 2023 14:10:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8f-00046J-9c; Tue, 21 Nov 2023 14:10:28 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALI3P0k005373; Tue, 21 Nov 2023 19:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yupSSpeeu7hHz+osl3dS2pRyOkjUKjoYW2y/pfGJmOo=;
 b=kn2BbHUQnJ2STkiFGeb5aJBx0BRdGhKd6bSmNHoyuYqqjm+heSKfmY5WUZBlmvh6eOaz
 6C4Fkdczmiaxjed74myHHkmyVT3xmidVYGBMwV9jYgThbMktKDh1RSCtukxaMy2tmZuQ
 4Gjlf3MYCohRPSSt/e2n0SCD973vh1iAECFdHmf3GfSHXj9VKDj96NQre0W+1aQXBRQT
 Vx1u+UEgrCG7e6MOF13AWE79NzXTQBs0a10Ixqw9pUngqVD3ePDRtDmWusJ93cAyHTEl
 QakQyf8nsqdIku0zt+LLHkYdlpTY9TCz1yyOYswvOPpy3MfLJ6VIc/lZ3zXgEt4BopG/ 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh1g61pwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:15 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALILT8i022008;
 Tue, 21 Nov 2023 19:10:15 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh1g61pwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIVbuG010183; Tue, 21 Nov 2023 19:10:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkagkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALJADQv22151780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 19:10:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 818745805A;
 Tue, 21 Nov 2023 19:10:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FD9858051;
 Tue, 21 Nov 2023 19:10:13 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 19:10:13 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v5 8/9] ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
Date: Tue, 21 Nov 2023 13:09:44 -0600
Message-Id: <20231121190945.3140221-9-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GNX05j-76t9E94ZxpcJFKldpvGPMGAsI
X-Proofpoint-ORIG-GUID: kcyIqm4NzxhMUYLZqeojNKl4heUnM6KV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210150
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

For powernv10-rainier, the Power Hypervisor code expects to see a
pca9554 device connected to the 3rd PNV I2C engine on port 1 at I2C
address 0x25 (or left-justified address of 0x4A).  This is used by
the hypervisor code to detect if a "Cable Card" is present.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

No change from previous version

 hw/misc/Kconfig     | 4 ++++
 hw/misc/meson.build | 1 +
 hw/ppc/Kconfig      | 1 +
 hw/ppc/pnv.c        | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cc8a8c1418..c347a132c2 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -34,6 +34,10 @@ config PCA9552
     bool
     depends on I2C
 
+config PCA9554
+    bool
+    depends on I2C
+
 config I2C_ECHO
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 36c20d5637..c39410e4a7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
+system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index f77ca773cf..2302778265 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -33,6 +33,7 @@ config POWERNV
     select FDT_PPC
     select PCI_POWERNV
     select PCA9552
+    select PCA9554
 
 config PPC405
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 088824fd9f..1dab7c57e8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1918,6 +1918,12 @@ static void pnv_rainier_i2c_init(PnvMachineState *pnv)
                               qdev_get_gpio_in(DEVICE(hotplug), 8));
         qdev_connect_gpio_out(DEVICE(hotplug), 4,
                               qdev_get_gpio_in(DEVICE(hotplug), 9));
+
+        /*
+         * Add a PCA9554 I2C device for cable card presence detection
+         * to engine 2, bus 1, address 0x25
+         */
+        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9554", 0x25);
     }
 }
 
-- 
2.31.1


