Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D887CB1C1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:01:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsRsv-0000RT-16; Mon, 16 Oct 2023 14:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1qsRsr-0000N9-O8; Mon, 16 Oct 2023 14:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1qsRsp-0003OE-9q; Mon, 16 Oct 2023 14:00:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GHdWqE008758; Mon, 16 Oct 2023 17:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=CXJzVchG2VE0mUcfy81HpUAL3SZdR6UHiG60LEm64Vg=;
 b=XwVA4n+R/fAuncuX3G05YGyLhP1usxz+PIrBpRoHyrgcO67084ytNfL/G9Wu5LcFkwLQ
 EwiQzDXUzr1BX6ZmEOzvojugA3aZPxddgLW8rfxrT+EASPpTjd++kv04EDkwRSxnO57z
 7q6HEA5k2Ex81XuUgKd1onsSpV1OqZl2zx6RNmVFzmQFaBBA/7O2/AqB4/Dk4154Khem
 6iC8C1zK+yuiWBYqY6O1sdfcIqChw+kWj6v7uB4CZFqDbNaKlm2N1MN686haKBVGQahY
 wzeRni91TDFSNPjCJQexdHm9x1xyYz09PEgPiFXA4+VO4W1llttn6LlN5iOrHV6lrRMy kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts9s08keh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 17:59:58 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GHeCFW011772;
 Mon, 16 Oct 2023 17:59:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts9s08ke9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 17:59:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GHrjGe020486; Mon, 16 Oct 2023 17:59:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6amthx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 17:59:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GHxux619792618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 17:59:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C371C58053;
 Mon, 16 Oct 2023 17:59:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11DA858043;
 Mon, 16 Oct 2023 17:59:56 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 17:59:55 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [PATCH v2] hw/pci-host: Update PHB5 XSCOM registers
Date: Mon, 16 Oct 2023 12:59:48 -0500
Message-Id: <20231016175948.10869-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kEYmq8YXHfL1FwgJtrh67sl5o2IAqy6f
X-Proofpoint-GUID: pPrj4CCnOT9_Of3wc9Z-zN1wnu8TMMmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160156
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add new XSCOM registers introduced in PHB5.
Apply bit-masks within xscom-write methods.
Bit-masks specified using PPC_BITMASK macro.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
v2: Bit-masks specified using PPC_BITMASK macro.

 hw/pci-host/pnv_phb4.c              | 46 ++++++++++++++++++-----------
 hw/pci-host/pnv_phb4_pec.c          | 33 +++++++++++++++++----
 include/hw/pci-host/pnv_phb4.h      |  2 +-
 include/hw/pci-host/pnv_phb4_regs.h |  4 ++-
 4 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 29cb11a5d9..2f935aabd4 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -855,7 +855,7 @@ static uint64_t pnv_pec_stk_nest_xscom_read(void *opaque, hwaddr addr,
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are read-able */
     return phb->nest_regs[reg];
 }
 
@@ -1000,7 +1000,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
 
     switch (reg) {
     case PEC_NEST_STK_PCI_NEST_FIR:
-        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] = val;
+        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] = val & PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_CLR:
         phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] &= val;
@@ -1009,7 +1009,8 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] |= val;
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_MSK:
-        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] = val;
+        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] = val &
+                                                        PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_MSKC:
         phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] &= val;
@@ -1019,7 +1020,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_ACT0:
     case PEC_NEST_STK_PCI_NEST_FIR_ACT1:
-        phb->nest_regs[reg] = val;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_PCI_NEST_FIR_WOF:
         phb->nest_regs[reg] = 0;
@@ -1030,7 +1031,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         /* Flag error ? */
         break;
     case PEC_NEST_STK_PBCQ_MODE:
-        phb->nest_regs[reg] = val & 0xff00000000000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 7);
         break;
     case PEC_NEST_STK_MMIO_BAR0:
     case PEC_NEST_STK_MMIO_BAR0_MASK:
@@ -1041,28 +1042,33 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
              PEC_NEST_STK_BAR_EN_MMIO1)) {
             phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
-        phb->nest_regs[reg] = val & 0xffffffffff000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 39);
         break;
     case PEC_NEST_STK_PHB_REGS_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_PHB) {
             phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
-        phb->nest_regs[reg] = val & 0xffffffffffc00000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 41);
         break;
     case PEC_NEST_STK_INT_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_INT) {
             phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
-        phb->nest_regs[reg] = val & 0xfffffff000000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 27);
         break;
     case PEC_NEST_STK_BAR_EN:
-        phb->nest_regs[reg] = val & 0xf000000000000000ull;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 3);
         pnv_pec_phb_update_map(phb);
         break;
     case PEC_NEST_STK_DATA_FRZ_TYPE:
-    case PEC_NEST_STK_PBCQ_TUN_BAR:
         /* Not used for now */
-        phb->nest_regs[reg] = val;
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 27);
+        break;
+    case PEC_NEST_STK_PBCQ_SPARSE_PAGE:
+        phb->nest_regs[reg] = val & PPC_BITMASK(3, 5);
+        break;
+    case PEC_NEST_STK_PBCQ_CACHE_INJ:
+        phb->nest_regs[reg] = val & PPC_BITMASK(0, 7);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "phb4_pec: nest_xscom_write 0x%"HWADDR_PRIx
@@ -1086,7 +1092,7 @@ static uint64_t pnv_pec_stk_pci_xscom_read(void *opaque, hwaddr addr,
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are read-able */
     return phb->pci_regs[reg];
 }
 
@@ -1095,10 +1101,9 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint32_t reg = addr >> 3;
-
     switch (reg) {
     case PEC_PCI_STK_PCI_FIR:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & PPC_BITMASK(0, 5);
         break;
     case PEC_PCI_STK_PCI_FIR_CLR:
         phb->pci_regs[PEC_PCI_STK_PCI_FIR] &= val;
@@ -1107,7 +1112,7 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
         phb->pci_regs[PEC_PCI_STK_PCI_FIR] |= val;
         break;
     case PEC_PCI_STK_PCI_FIR_MSK:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & PPC_BITMASK(0, 5);
         break;
     case PEC_PCI_STK_PCI_FIR_MSKC:
         phb->pci_regs[PEC_PCI_STK_PCI_FIR_MSK] &= val;
@@ -1117,20 +1122,25 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
         break;
     case PEC_PCI_STK_PCI_FIR_ACT0:
     case PEC_PCI_STK_PCI_FIR_ACT1:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & PPC_BITMASK(0, 5);
         break;
     case PEC_PCI_STK_PCI_FIR_WOF:
         phb->pci_regs[reg] = 0;
         break;
     case PEC_PCI_STK_ETU_RESET:
-        phb->pci_regs[reg] = val & 0x8000000000000000ull;
+        phb->pci_regs[reg] = val & PPC_BIT(0);
         /* TODO: Implement reset */
         break;
     case PEC_PCI_STK_PBAIB_ERR_REPORT:
         break;
     case PEC_PCI_STK_PBAIB_TX_CMD_CRED:
+        phb->pci_regs[reg] = val &
+                                 ((PPC_BITMASK(0, 2) | PPC_BITMASK(10, 18)
+                                   | PPC_BITMASK(26, 34) | PPC_BITMASK(41, 50)
+                                   | PPC_BITMASK(58, 63)));
+        break;
     case PEC_PCI_STK_PBAIB_TX_DAT_CRED:
-        phb->pci_regs[reg] = val;
+        phb->pci_regs[reg] = val & (PPC_BITMASK(33, 34) | PPC_BITMASK(44, 47));
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "phb4_pec_stk: pci_xscom_write 0x%"HWADDR_PRIx
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 3b2850f7a3..ce8e228f98 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -34,7 +34,7 @@ static uint64_t pnv_pec_nest_xscom_read(void *opaque, hwaddr addr,
     PnvPhb4PecState *pec = PNV_PHB4_PEC(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are readable */
     return pec->nest_regs[reg];
 }
 
@@ -45,18 +45,36 @@ static void pnv_pec_nest_xscom_write(void *opaque, hwaddr addr,
     uint32_t reg = addr >> 3;
 
     switch (reg) {
-    case PEC_NEST_PBCQ_HW_CONFIG:
     case PEC_NEST_DROP_PRIO_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 25);
+        break;
     case PEC_NEST_PBCQ_ERR_INJECT:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 11);
+        break;
     case PEC_NEST_PCI_NEST_CLK_TRACE_CTL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 16);
+        break;
     case PEC_NEST_PBCQ_PMON_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 37);
+        break;
     case PEC_NEST_PBCQ_PBUS_ADDR_EXT:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 6);
+        break;
     case PEC_NEST_PBCQ_PRED_VEC_TIMEOUT:
-    case PEC_NEST_CAPP_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 15);
+        break;
     case PEC_NEST_PBCQ_READ_STK_OVR:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 48);
+        break;
     case PEC_NEST_PBCQ_WRITE_STK_OVR:
     case PEC_NEST_PBCQ_STORE_STK_OVR:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 24);
+        break;
     case PEC_NEST_PBCQ_RETRY_BKOFF_CTRL:
+        pec->nest_regs[reg] = val & PPC_BITMASK(0, 41);
+        break;
+    case PEC_NEST_PBCQ_HW_CONFIG:
+    case PEC_NEST_CAPP_CTRL:
         pec->nest_regs[reg] = val;
         break;
     default:
@@ -81,7 +99,7 @@ static uint64_t pnv_pec_pci_xscom_read(void *opaque, hwaddr addr,
     PnvPhb4PecState *pec = PNV_PHB4_PEC(opaque);
     uint32_t reg = addr >> 3;
 
-    /* TODO: add list of allowed registers and error out if not */
+    /* All registers are readable */
     return pec->pci_regs[reg];
 }
 
@@ -93,8 +111,13 @@ static void pnv_pec_pci_xscom_write(void *opaque, hwaddr addr,
 
     switch (reg) {
     case PEC_PCI_PBAIB_HW_CONFIG:
+        pec->pci_regs[reg] = val & PPC_BITMASK(0, 42);
+        break;
+    case PEC_PCI_PBAIB_HW_OVR:
+        pec->pci_regs[reg] = val & PPC_BITMASK(0, 15);
+        break;
     case PEC_PCI_PBAIB_READ_STK_OVR:
-        pec->pci_regs[reg] = val;
+        pec->pci_regs[reg] = val & PPC_BITMASK(0, 48);
         break;
     default:
         phb_pec_error(pec, "%s @0x%"HWADDR_PRIx"=%"PRIx64"\n", __func__,
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 2d026db9a3..3212e68160 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -117,7 +117,7 @@ struct PnvPHB4 {
     MemoryRegion pci_regs_mr;
 
     /* Nest registers */
-#define PHB4_PEC_NEST_STK_REGS_COUNT  0x17
+#define PHB4_PEC_NEST_STK_REGS_COUNT  0x18
     uint64_t nest_regs[PHB4_PEC_NEST_STK_REGS_COUNT];
     MemoryRegion nest_regs_mr;
 
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index 4a0d3b28ef..bea96f4d91 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -77,10 +77,12 @@
 #define   PEC_NEST_STK_BAR_EN_PHB               PPC_BIT(2)
 #define   PEC_NEST_STK_BAR_EN_INT               PPC_BIT(3)
 #define PEC_NEST_STK_DATA_FRZ_TYPE      0x15
-#define PEC_NEST_STK_PBCQ_TUN_BAR       0x16
+#define PEC_NEST_STK_PBCQ_SPARSE_PAGE   0x16 /* P10 */
+#define PEC_NEST_STK_PBCQ_CACHE_INJ     0x17 /* P10 */
 
 /* XSCOM PCI global registers */
 #define PEC_PCI_PBAIB_HW_CONFIG         0x00
+#define PEC_PCI_PBAIB_HW_OVR            0x01
 #define PEC_PCI_PBAIB_READ_STK_OVR      0x02
 
 /* XSCOM PCI per-stack registers */
-- 
2.31.1


