Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0684CEA1
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Feb 2024 17:10:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkTw-0003cL-K8; Wed, 07 Feb 2024 11:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkTu-0003bd-D1; Wed, 07 Feb 2024 11:09:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkTs-0000cR-7J; Wed, 07 Feb 2024 11:09:02 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417FTigl018552; Wed, 7 Feb 2024 16:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m/xAHQgXZcZVVLf1O5AkXO/lmGBklFsg/KbCxQdG/NQ=;
 b=EfQlgJUsOQYJi+nAJ71Ekg5fKr+QaP4R+LuA0yYzgDwEQ7+1p84twkXKtlw3e/f4pkuC
 8ubmziS+rXO3+T1JOWO47DC9yH1PMT3MGZ4VE0H3OgejeMPz291efWNIn4lQYfxMl9Vb
 7S26tg228tUDMKOEU+v4kySTMTuz69GjerRMVkZEkqkeLhKpCbbde/MM/7EH3nBtUOhp
 +i69o5Dd6s6UdllHNRnkRp9zAQZt5LazmCmaGqMaiNHNEOwGhoyPnSztjGno4a2bmpxE
 K59xAzijwViHkkvBGWBFrNFwvHoeA8k3/12RByly3fL4LYGKnSwLKV/V2Ac7ra9n0QSQ Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4cj6h4q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:56 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417G1B6h028418;
 Wed, 7 Feb 2024 16:08:55 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4cj6h4pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 417FVqiK016148; Wed, 7 Feb 2024 16:08:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h2680c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 417G8qtD24969790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Feb 2024 16:08:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 171952004B;
 Wed,  7 Feb 2024 16:08:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60D9A20040;
 Wed,  7 Feb 2024 16:08:50 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Feb 2024 16:08:50 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v1 2/5] hw/ppc: SPI controller model - registers implementation
Date: Wed,  7 Feb 2024 10:08:30 -0600
Message-Id: <20240207160833.3437779-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vvt-ueNvzakqNOuQ95-ckoPwO0crnCpy
X-Proofpoint-ORIG-GUID: DNPh83JZzu2PQ_GsBv9xbpRE9SC92sST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SPI controller device model supports a connection to a single SPI responder.
This provide access to SPI seeproms, TPM, flash device and an ADC controller.

All SPI function control is mapped into the SPI register space to enable full
control by firmware. In this commit SPI configuration component is modelled
which contains all SPI configuration and status registers as well as the hold
registers for data to be sent or having been received.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_spi_controller.h |  43 ++++
 include/hw/ppc/pnv_xscom.h          |   3 +
 hw/ppc/pnv_spi_controller.c         | 337 ++++++++++++++++++++++++++++
 hw/ppc/meson.build                  |   1 +
 4 files changed, 384 insertions(+)
 create mode 100644 include/hw/ppc/pnv_spi_controller.h
 create mode 100644 hw/ppc/pnv_spi_controller.c

diff --git a/include/hw/ppc/pnv_spi_controller.h b/include/hw/ppc/pnv_spi_controller.h
new file mode 100644
index 0000000000..8afaabdd1b
--- /dev/null
+++ b/include/hw/ppc/pnv_spi_controller.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU PowerPC SPI Controller model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This model Supports a connection to a single SPI responder.
+ * Introduced for P10 to provide access to SPI seeproms, TPM, flash device
+ * and an ADC controller.
+ */
+
+#ifndef PPC_PNV_SPI_CONTROLLER_H
+#define PPC_PNV_SPI_CONTROLLER_H
+
+#define TYPE_PNV_SPI_CONTROLLER "pnv-spi-controller"
+#define PNV_SPICONTROLLER(obj) \
+        OBJECT_CHECK(PnvSpiController, (obj), TYPE_PNV_SPI_CONTROLLER)
+
+#define SPI_CONTROLLER_REG_SIZE 8
+
+typedef struct SpiBus SpiBus;
+
+typedef struct PnvSpiController {
+    DeviceState parent;
+
+    SpiBus            *spi_bus;
+    MemoryRegion    xscom_spic_regs;
+    /* SPI controller object number */
+    uint32_t        spic_num;
+
+    /* SPI Controller registers */
+    uint64_t        error_reg;
+    uint64_t        counter_config_reg;
+    uint64_t        config_reg1;
+    uint64_t        clock_config_reset_control;
+    uint64_t        memory_mapping_reg;
+    uint64_t        transmit_data_reg;
+    uint64_t        receive_data_reg;
+    uint8_t         sequencer_operation_reg[SPI_CONTROLLER_REG_SIZE];
+    uint64_t        status_reg;
+} PnvSpiController;
+#endif /* PPC_PNV_SPI_CONTROLLER_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f5becbab41..0575bf0985 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -176,6 +176,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
 
+#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
+#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
+
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
diff --git a/hw/ppc/pnv_spi_controller.c b/hw/ppc/pnv_spi_controller.c
new file mode 100644
index 0000000000..0f2bc25e82
--- /dev/null
+++ b/hw/ppc/pnv_spi_controller.c
@@ -0,0 +1,337 @@
+/*
+ * QEMU PowerPC SPI Controller model
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_spi_controller.h"
+#include "hw/ppc/pnv_spi_responder.h"
+#include "hw/ppc/fdt.h"
+#include <libfdt.h>
+#include <math.h>
+
+#define SPI_DEBUG(x)
+
+/* Error Register */
+#define ERROR_REG                               0x00
+
+/* counter_config_reg */
+#define COUNTER_CONFIG_REG                      0x01
+#define COUNTER_CONFIG_REG_SHIFT_COUNT_N1       PPC_BITMASK(0 , 7)
+#define COUNTER_CONFIG_REG_SHIFT_COUNT_N2       PPC_BITMASK(8 , 15)
+#define COUNTER_CONFIG_REG_COUNT_COMPARE1       PPC_BITMASK(24 , 31)
+#define COUNTER_CONFIG_REG_COUNT_COMPARE2       PPC_BITMASK(32 , 39)
+#define COUNTER_CONFIG_REG_N1_COUNT_CONTROL     PPC_BITMASK(48 , 51)
+#define COUNTER_CONFIG_REG_N2_COUNT_CONTROL     PPC_BITMASK(52 , 55)
+
+/* config_reg */
+#define CONFIG_REG1                             0x02
+
+/* clock_config_reset_control_ecc_enable_reg */
+#define CLOCK_CONFIG_REG                        0x03
+#define CLOCK_CONFIG_RESET_CONTROL_HARD_RESET   0x0084000000000000;
+#define CLOCK_CONFIG_REG_RESET_CONTROL          PPC_BITMASK(24 , 27)
+#define CLOCK_CONFIG_REG_ECC_CONTROL            PPC_BITMASK(28 , 30)
+
+/* memory_mapping_reg */
+#define MEMORY_MAPPING_REG                      0x04
+#define MEMORY_MAPPING_REG_MMSPISM_BASE_ADDR    PPC_BITMASK(0 , 15)
+#define MEMORY_MAPPING_REG_MMSPISM_ADDR_MASK    PPC_BITMASK(16 , 31)
+#define MEMORY_MAPPING_REG_RDR_MATCH_VAL        PPC_BITMASK(32 , 47)
+#define MEMORY_MAPPING_REG_RDR_MATCH_MASK       PPC_BITMASK(48 , 63)
+
+/* transmit_data_reg */
+#define TRANSMIT_DATA_REG                       0x05
+
+/* receive_data_reg */
+#define RECEIVE_DATA_REG                        0x06
+
+/* sequencer_operation_reg */
+#define SEQUENCER_OPERATION_REG                 0x07
+
+/* status_reg */
+#define STATUS_REG                              0x08
+#define STATUS_REG_RDR_FULL                     PPC_BIT(0)
+#define STATUS_REG_RDR_OVERRUN                  PPC_BIT(1)
+#define STATUS_REG_RDR_UNDERRUN                 PPC_BIT(2)
+#define STATUS_REG_TDR_FULL                     PPC_BIT(4)
+#define STATUS_REG_TDR_OVERRUN                  PPC_BIT(5)
+#define STATUS_REG_TDR_UNDERRUN                 PPC_BIT(6)
+#define STATUS_REG_SEQUENCER_FSM                PPC_BITMASK(8 , 15)
+#define STATUS_REG_SHIFTER_FSM                  PPC_BITMASK(16 , 27)
+#define STATUS_REG_SEQUENCER_INDEX              PPC_BITMASK(28 , 31)
+#define STATUS_REG_GENERAL_SPI_STATUS           PPC_BITMASK(32 , 63)
+#define STATUS_REG_RDR                          PPC_BITMASK(1 , 3)
+#define STATUS_REG_TDR                          PPC_BITMASK(5 , 7)
+
+/*
+ * Shifter states
+ *
+ * These are the same values defined for the Shifter FSM field of the
+ * status register.  It's a 12 bit field so we will represent it as three
+ * nibbles in the constants.
+ *
+ * These are shifter_fsm values
+ *
+ * Status reg bits 16-27 -> field bits 0-11
+ * bits 0,1,2,5 unused/reserved
+ * bit 4 crc shift in (unused)
+ * bit 8 crc shift out (unused)
+ */
+
+#define FSM_DONE                        0x100   /* bit 3 */
+#define FSM_SHIFT_N2                    0x020   /* bit 6 */
+#define FSM_WAIT                        0x010   /* bit 7 */
+#define FSM_SHIFT_N1                    0x004   /* bit 9 */
+#define FSM_START                       0x002   /* bit 10 */
+#define FSM_IDLE                        0x001   /* bit 11 */
+
+/*
+ * Sequencer states
+ *
+ * These are sequencer_fsm values
+ *
+ * Status reg bits 8-15 -> field bits 0-7
+ * bits 0-3 unused/reserved
+ *
+ */
+#define SEQ_STATE_INDEX_INCREMENT       0x08    /* bit 4 */
+#define SEQ_STATE_EXECUTE               0x04    /* bit 5 */
+#define SEQ_STATE_DECODE                0x02    /* bit 6 */
+#define SEQ_STATE_IDLE                  0x01    /* bit 7 */
+
+/*
+ * These are the supported sequencer operations.
+ * Only the upper nibble is significant because for many operations
+ * the lower nibble is a variable specific to the operation.
+ */
+#define SEQ_OP_STOP                     0x00
+#define SEQ_OP_SELECT_SLAVE             0x10
+#define SEQ_OP_SHIFT_N1                 0x30
+#define SEQ_OP_SHIFT_N2                 0x40
+#define SEQ_OP_BRANCH_IFNEQ_RDR         0x60
+#define SEQ_OP_TRANSFER_TDR             0xC0
+#define SEQ_OP_BRANCH_IFNEQ_INC_1       0xE0
+#define SEQ_OP_BRANCH_IFNEQ_INC_2       0xF0
+
+
+static uint64_t pnv_spi_controller_read(void *opaque, hwaddr addr,
+                                 unsigned size)
+{
+    PnvSpiController *sc = PNV_SPICONTROLLER(opaque);
+    uint32_t reg = addr >> 3;
+
+    uint64_t val = ~0ull;
+
+    switch (reg) {
+    case ERROR_REG:
+        val = sc->error_reg;
+        break;
+    case COUNTER_CONFIG_REG:
+        val = sc->counter_config_reg;
+        break;
+    case CONFIG_REG1:
+        val = sc->config_reg1;
+        break;
+    case CLOCK_CONFIG_REG:
+        val = sc->clock_config_reset_control;
+        break;
+    case MEMORY_MAPPING_REG:
+        val = sc->memory_mapping_reg;
+        break;
+    case TRANSMIT_DATA_REG:
+        val = sc->transmit_data_reg;
+        break;
+    case RECEIVE_DATA_REG:
+        val = sc->receive_data_reg;
+        SPI_DEBUG(qemu_log("RDR being read, data extracted = 0x%16.16lx\n",
+                           val));
+        sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL, sc->status_reg, 0);
+        SPI_DEBUG(qemu_log("RDR being read, RDR_full set to 0\n"));
+        break;
+    case SEQUENCER_OPERATION_REG:
+        for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
+            val |= ((uint64_t)sc->sequencer_operation_reg[i] <<
+                                                    (64 - ((i + 1) * 8)));
+        }
+        break;
+    case STATUS_REG:
+        val = sc->status_reg;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "spi_controller_regs: Invalid xscom "
+                 "read at 0x%08x\n", reg);
+    }
+    return val;
+}
+
+static void pnv_spi_controller_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvSpiController *sc = PNV_SPICONTROLLER(opaque);
+    uint32_t reg = addr >> 3;
+
+    switch (reg) {
+    case ERROR_REG:
+        sc->error_reg = val;
+        break;
+    case COUNTER_CONFIG_REG:
+        sc->counter_config_reg = val;
+        break;
+    case CONFIG_REG1:
+        sc->config_reg1 = val;
+        break;
+    case CLOCK_CONFIG_REG:
+        /*
+         * To reset the SPI controller write the sequence 0x5 0xA to
+         * reset_control field
+         */
+        if (GETFIELD(CLOCK_CONFIG_REG_RESET_CONTROL,
+                                sc->clock_config_reset_control) == 0x5) {
+            if (GETFIELD(CLOCK_CONFIG_REG_RESET_CONTROL, val) == 0xA) {
+                SPI_DEBUG(qemu_log("SPI controller reset sequence completed, "
+                               "resetting..."));
+                sc->clock_config_reset_control =
+                                 CLOCK_CONFIG_RESET_CONTROL_HARD_RESET;
+            } else {
+                sc->clock_config_reset_control = val;
+            }
+        } else {
+            sc->clock_config_reset_control = val;
+        }
+        break;
+    case MEMORY_MAPPING_REG:
+        sc->memory_mapping_reg = val;
+        break;
+    case TRANSMIT_DATA_REG:
+        /*
+         * Writing to the transmit data register causes the transmit data
+         * register full status bit in the status register to be set.  Writing
+         * when the transmit data register full status bit is already set
+         * causes a "Resource Not Available" condition.  This is not possible
+         * in the model since writes to this register are not asynchronous to
+         * the operation sequence like it would be in hardware.
+         */
+        sc->transmit_data_reg = val;
+        SPI_DEBUG(qemu_log("TDR being written, data written = 0x%16.16lx\n",
+                            val));
+        sc->status_reg = SETFIELD(STATUS_REG_TDR_FULL, sc->status_reg, 1);
+        SPI_DEBUG(qemu_log("TDR being written, TDR_full set to 1\n"));
+        sc->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, sc->status_reg, 0);
+        SPI_DEBUG(qemu_log("TDR being written, TDR_underrun set to 0\n"));
+        SPI_DEBUG(qemu_log("TDR being written, starting sequencer\n"));
+        break;
+    case RECEIVE_DATA_REG:
+        sc->receive_data_reg = val;
+        break;
+    case SEQUENCER_OPERATION_REG:
+        for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
+            sc->sequencer_operation_reg[i] =
+                 (val & PPC_BITMASK(i * 8 , i * 8 + 7)) >> (63 - (i * 8 + 7));
+        }
+        break;
+    case STATUS_REG:
+        ;
+        uint8_t rdr_val = GETFIELD(STATUS_REG_RDR, val);
+        uint8_t tdr_val = GETFIELD(STATUS_REG_TDR, val);
+        /* other fields are ignore_write */
+        sc->status_reg = SETFIELD(STATUS_REG_RDR_OVERRUN,
+                                         sc->status_reg, rdr_val);
+        sc->status_reg = SETFIELD(STATUS_REG_TDR_OVERRUN,
+                                         sc->status_reg, tdr_val);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "spi_controller_regs: Invalid xscom "
+                 "write at 0x%08x\n", reg);
+    }
+    return;
+}
+
+static const MemoryRegionOps pnv_spi_controller_xscom_ops = {
+    .read = pnv_spi_controller_read,
+    .write = pnv_spi_controller_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static Property pnv_spi_controller_properties[] = {
+    DEFINE_PROP_UINT32("spic_num", PnvSpiController, spic_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_spi_controller_realize(DeviceState *dev, Error **errp)
+{
+    PnvSpiController *sc = PNV_SPICONTROLLER(dev);
+    g_autofree char *bus_name;
+    bus_name = g_strdup_printf("spi_bus%x", sc->spic_num);
+    sc->spi_bus = spi_create_bus(dev, bus_name);
+
+    /* spi controller scoms */
+    pnv_xscom_region_init(&sc->xscom_spic_regs, OBJECT(sc),
+                          &pnv_spi_controller_xscom_ops, sc,
+                          "xscom-spi-controller-regs",
+                          PNV10_XSCOM_PIB_SPIC_SIZE);
+}
+
+static int pnv_spi_controller_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int offset)
+{
+    PnvSpiController *sc = PNV_SPICONTROLLER(dev);
+    g_autofree char *name;
+    int sc_offset;
+    const char compat[] = "ibm,power10-spi_controller";
+    uint32_t spic_pcba = PNV10_XSCOM_PIB_SPIC_BASE +
+        sc->spic_num * PNV10_XSCOM_PIB_SPIC_SIZE;
+    uint32_t reg[] = {
+        cpu_to_be32(spic_pcba),
+        cpu_to_be32(PNV10_XSCOM_PIB_SPIC_SIZE)
+    };
+    name = g_strdup_printf("spi_controller@%x", spic_pcba);
+    sc_offset = fdt_add_subnode(fdt, offset, name);
+    _FDT(sc_offset);
+
+    _FDT(fdt_setprop(fdt, sc_offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop(fdt, sc_offset, "compatible", compat, sizeof(compat)));
+    _FDT((fdt_setprop_cell(fdt, sc_offset, "spic_num#", sc->spic_num)));
+    return 0;
+}
+
+static void pnv_spi_controller_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xscomc->dt_xscom = pnv_spi_controller_dt_xscom;
+
+    dc->desc = "PowerNV SPI Controller";
+    dc->realize = pnv_spi_controller_realize;
+    device_class_set_props(dc, pnv_spi_controller_properties);
+}
+
+static const TypeInfo pnv_spi_controller_info = {
+    .name          = TYPE_PNV_SPI_CONTROLLER,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvSpiController),
+    .class_init    = pnv_spi_controller_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_spi_controller_register_types(void)
+{
+    type_register_static(&pnv_spi_controller_info);
+}
+
+type_init(pnv_spi_controller_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 9bfd5a5613..de25cac763 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -54,6 +54,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_homer.c',
   'pnv_pnor.c',
   'pnv_spi_responder.c',
+  'pnv_spi_controller.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.31.1


