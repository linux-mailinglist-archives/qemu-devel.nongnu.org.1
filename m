Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB27F36AB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 20:12:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5W8j-0008Dr-Hr; Tue, 21 Nov 2023 14:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8Z-0008Bp-Dv; Tue, 21 Nov 2023 14:10:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r5W8V-00041n-VS; Tue, 21 Nov 2023 14:10:18 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIqDVp013282; Tue, 21 Nov 2023 19:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=sAwhAMFQpZp3YOsI9pADZWwUDNTxsNy251Ri46zwtfY=;
 b=n4AySao2RgwTeGyCmlDMnVidARMUsM+72JN700o0GIWexHuVLLviYKcXGQQAdMAl8VwP
 5idGMnjKSLu+6Rpnry4RnUWFQtVYs6zvqy1B788ZFgpciLTVKkClv8je7yzYjoVj9sPv
 vl9GK+vtf3OcoOTY4Zo21FU1ODRxP/F3JiDnh2rsJjKiGMkRVEpkqRQRa/1Lj1EWwJOI
 5rkbGnFCZn8LGZHqi+k33SJ9RnW+gOZtAJLBwOlNRPrKPHQp/qy8d7MgNhrzJROZS9k7
 2xQDQi6BdBXCLv43CzcEt7LLAv0g2JpDklgmhlb30orZ/vP9c+pVvtfxDWUkB9EnyIWR pA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh273reuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALJ6UiY019290;
 Tue, 21 Nov 2023 19:10:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh273retu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALIYWUQ007845; Tue, 21 Nov 2023 19:10:06 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa22bq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 19:10:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ALJA5J741026008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Nov 2023 19:10:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDAF258051;
 Tue, 21 Nov 2023 19:10:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 752355805E;
 Tue, 21 Nov 2023 19:10:05 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Nov 2023 19:10:05 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v5 4/9] ppc/pnv: Add pca9552 to powernv10-rainier for PCIe
 hotplug power control
Date: Tue, 21 Nov 2023 13:09:40 -0600
Message-Id: <20231121190945.3140221-5-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fyptizj9JbDkTwk2MYiy8dniEOrySCUq
X-Proofpoint-ORIG-GUID: 3-XXysbb8IGzLbTF_k9gBj96LYoLm7ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210150
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

The Power Hypervisor code expects to see a pca9552 device connected
to the 3rd PNV I2C engine on port 1 at I2C address 0x63 (or left-
justified address of 0xC6).  This is used by hypervisor code to
control PCIe slot power during hotplug events.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---

Changes from previous version:
  - Formatting change

 hw/ppc/Kconfig       |  1 +
 hw/ppc/pnv.c         | 25 +++++++++++++++++++++++++
 include/hw/ppc/pnv.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 56f0475a8e..f77ca773cf 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -32,6 +32,7 @@ config POWERNV
     select XIVE
     select FDT_PPC
     select PCI_POWERNV
+    select PCA9552
 
 config PPC405
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 08704ce695..d8d19fb065 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -790,6 +790,7 @@ static void pnv_init(MachineState *machine)
     const char *bios_name = machine->firmware ?: FW_FILE_NAME;
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
     char *fw_filename;
     long fw_size;
     uint64_t chip_ram_start = 0;
@@ -979,6 +980,13 @@ static void pnv_init(MachineState *machine)
      */
     pnv->powerdown_notifier.notify = pnv_powerdown_notify;
     qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
+
+    /*
+     * Create/Connect any machine-specific I2C devices
+     */
+    if (pmc->i2c_init) {
+        pmc->i2c_init(pnv);
+    }
 }
 
 /*
@@ -1879,6 +1887,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
+
+}
+
+static void pnv_rainier_i2c_init(PnvMachineState *pnv)
+{
+    int i;
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+
+        /*
+         * Add a PCA9552 I2C device for PCIe hotplug control
+         * to engine 2, bus 1, address 0x63
+         */
+        i2c_slave_create_simple(chip10->i2c[2].busses[1], "pca9552", 0x63);
+    }
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -2286,9 +2309,11 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
 
     pnv_machine_p10_common_class_init(oc, data);
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 Rainier";
+    pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 7e5fef7c43..110ac9aace 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ struct PnvMachineClass {
     int compat_size;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
+    void (*i2c_init)(PnvMachineState *pnv);
 };
 
 struct PnvMachineState {
-- 
2.31.1


