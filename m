Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0598CA37
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 03:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svnmA-0006q7-Vc; Tue, 01 Oct 2024 21:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnm8-0006pV-TY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:03:33 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnm6-0002dq-F0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:03:32 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e6afa8baeaso5247318a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727831008; x=1728435808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krGRmW+acDTMjoi2j3LIu82IhlRsbAlbWrm8av/rqpI=;
 b=hPKiTtUqJee7liE2tEvbJhn3RsM2FAgzZfXYH+qoqeceSilsIc8jhx8KU994ba57II
 3Rj8RhRZgIf+tOOBAPtZj9PUiOeq9pMdMqaMCcRKhUJ5eEdwrbqoQao5M+0j1r5CmrOD
 jf267jIuF2FS4OcQqofWtMzzZWaB489OUTxtegT0ysLFBEyWh15YQNY4zu0GCHpDvDMx
 Ajf300PGB13YOa9xvGhopRvMQfomjQ5/S4eiWXNCPjtry++Ah3FIO7qf2rs91iUuIz1f
 VAkr/DFW68NI5YeULMxXNpo28rr7SYdgmuQa1+5XyvRjFQdhlPkEi5xVZaDwQptnSh5z
 dS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727831008; x=1728435808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krGRmW+acDTMjoi2j3LIu82IhlRsbAlbWrm8av/rqpI=;
 b=OgrY7uoe7sWsXZgmP8RJvMFMYi3mb3NvoeTjNst004N+AZ1Qd2t12x+eTiKqLTAzZf
 T3RZpfL5kQWSrEMgxBbLRV3EmpB0dXG/AI+gbhhnCek5MGD2Zq7doHrDwMPUegbKEAXm
 kBNQcoZ6KMJtKauaKu5nBFRLT5qxi1MKKdyqCU28y+WyT+QJM4JP8FPNZiuCay86txn+
 zAy54RWMeWfC4ahb5N4fHzvq4oIZ3pC7jznfIbdcquchTxqgqC3S1lZWg9JQXV7XCTEv
 yV6vJNplzxqC/p2PCze+BEF/gw+ZMV6FoyXj7FQxsaRT2JMytn1AcjNhBm0gHPcUSGBB
 qqdw==
X-Gm-Message-State: AOJu0Yx2IKFenvHpY/G+WFF9uaUBInnPbVxAYVMQSlSQBfRJ9HWjfpSa
 hOGts1Exf6d++L05uE/lm/Trn+CdJVM5szCkNGD3igBoppSNEMybk4ntpP6j/TdA8pVhxvOrSmo
 I
X-Google-Smtp-Source: AGHT+IEdYpt03oeNFSD38Ljw+uzS2iCZK6CNt8t5i+AJ9H/I7N3vB22XW+Cx8paHD+qB4hUrclWFiQ==
X-Received: by 2002:a17:903:22cf:b0:205:4885:235e with SMTP id
 d9443c01a7336-20bc5a6a4cfmr18759925ad.39.1727831008463; 
 Tue, 01 Oct 2024 18:03:28 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d63971sm76061295ad.4.2024.10.01.18.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 18:03:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v8 02/12] hw/riscv: add riscv-iommu-bits.h
Date: Tue,  1 Oct 2024 22:02:57 -0300
Message-ID: <20241002010314.1928515-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

This header will be used by the RISC-V IOMMU emulation to be added
in the next patch. Due to its size it's being sent in separate for
an easier review.

One thing to notice is that this header can be replaced by the future
Linux RISC-V IOMMU driver header, which would become a linux-header we
would import instead of keeping our own. The Linux implementation isn't
upstream yet so for now we'll have to manage riscv-iommu-bits.h.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 345 ++++++++++++++++++++++++++++++++++++
 1 file changed, 345 insertions(+)
 create mode 100644 hw/riscv/riscv-iommu-bits.h

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
new file mode 100644
index 0000000000..c46d7d18ab
--- /dev/null
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -0,0 +1,345 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright © 2022-2023 Rivos Inc.
+ * Copyright © 2023 FORTH-ICS/CARV
+ * Copyright © 2023 RISC-V IOMMU Task Group
+ *
+ * RISC-V IOMMU - Register Layout and Data Structures.
+ *
+ * Based on the IOMMU spec version 1.0, 3/2023
+ * https://github.com/riscv-non-isa/riscv-iommu
+ */
+
+#ifndef HW_RISCV_IOMMU_BITS_H
+#define HW_RISCV_IOMMU_BITS_H
+
+#define RISCV_IOMMU_SPEC_DOT_VER 0x010
+
+#ifndef GENMASK_ULL
+#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
+#endif
+
+/*
+ * struct riscv_iommu_fq_record - Fault/Event Queue Record
+ * See section 3.2 for more info.
+ */
+struct riscv_iommu_fq_record {
+    uint64_t hdr;
+    uint64_t _reserved;
+    uint64_t iotval;
+    uint64_t iotval2;
+};
+/* Header fields */
+#define RISCV_IOMMU_FQ_HDR_CAUSE        GENMASK_ULL(11, 0)
+#define RISCV_IOMMU_FQ_HDR_PID          GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_FQ_HDR_PV           BIT_ULL(32)
+#define RISCV_IOMMU_FQ_HDR_TTYPE        GENMASK_ULL(39, 34)
+#define RISCV_IOMMU_FQ_HDR_DID          GENMASK_ULL(63, 40)
+
+/*
+ * struct riscv_iommu_pq_record - PCIe Page Request record
+ * For more infos on the PCIe Page Request queue see chapter 3.3.
+ */
+struct riscv_iommu_pq_record {
+      uint64_t hdr;
+      uint64_t payload;
+};
+/* Header fields */
+#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
+#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
+#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
+#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
+/* Payload fields */
+#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
+
+/* Common field positions */
+#define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
+#define RISCV_IOMMU_QUEUE_LOGSZ_FIELD   GENMASK_ULL(4, 0)
+#define RISCV_IOMMU_QUEUE_INDEX_FIELD   GENMASK_ULL(31, 0)
+#define RISCV_IOMMU_QUEUE_ENABLE        BIT(0)
+#define RISCV_IOMMU_QUEUE_INTR_ENABLE   BIT(1)
+#define RISCV_IOMMU_QUEUE_MEM_FAULT     BIT(8)
+#define RISCV_IOMMU_QUEUE_OVERFLOW      BIT(9)
+#define RISCV_IOMMU_QUEUE_ACTIVE        BIT(16)
+#define RISCV_IOMMU_QUEUE_BUSY          BIT(17)
+#define RISCV_IOMMU_ATP_PPN_FIELD       GENMASK_ULL(43, 0)
+#define RISCV_IOMMU_ATP_MODE_FIELD      GENMASK_ULL(63, 60)
+
+/* 5.3 IOMMU Capabilities (64bits) */
+#define RISCV_IOMMU_REG_CAP             0x0000
+#define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
+#define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
+#define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
+#define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
+#define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
+#define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
+#define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
+#define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
+#define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
+
+/* 5.4 Features control register (32bits) */
+#define RISCV_IOMMU_REG_FCTL            0x0008
+#define RISCV_IOMMU_FCTL_WSI            BIT(1)
+
+/* 5.5 Device-directory-table pointer (64bits) */
+#define RISCV_IOMMU_REG_DDTP            0x0010
+#define RISCV_IOMMU_DDTP_MODE           GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_DDTP_BUSY           BIT_ULL(4)
+#define RISCV_IOMMU_DDTP_PPN            RISCV_IOMMU_PPN_FIELD
+
+enum riscv_iommu_ddtp_modes {
+    RISCV_IOMMU_DDTP_MODE_OFF = 0,
+    RISCV_IOMMU_DDTP_MODE_BARE = 1,
+    RISCV_IOMMU_DDTP_MODE_1LVL = 2,
+    RISCV_IOMMU_DDTP_MODE_2LVL = 3,
+    RISCV_IOMMU_DDTP_MODE_3LVL = 4,
+    RISCV_IOMMU_DDTP_MODE_MAX = 4
+};
+
+/* 5.6 Command Queue Base (64bits) */
+#define RISCV_IOMMU_REG_CQB             0x0018
+#define RISCV_IOMMU_CQB_LOG2SZ          RISCV_IOMMU_QUEUE_LOGSZ_FIELD
+#define RISCV_IOMMU_CQB_PPN             RISCV_IOMMU_PPN_FIELD
+
+/* 5.7 Command Queue head (32bits) */
+#define RISCV_IOMMU_REG_CQH             0x0020
+
+/* 5.8 Command Queue tail (32bits) */
+#define RISCV_IOMMU_REG_CQT             0x0024
+
+/* 5.9 Fault Queue Base (64bits) */
+#define RISCV_IOMMU_REG_FQB             0x0028
+#define RISCV_IOMMU_FQB_LOG2SZ          RISCV_IOMMU_QUEUE_LOGSZ_FIELD
+#define RISCV_IOMMU_FQB_PPN             RISCV_IOMMU_PPN_FIELD
+
+/* 5.10 Fault Queue Head (32bits) */
+#define RISCV_IOMMU_REG_FQH             0x0030
+
+/* 5.11 Fault Queue tail (32bits) */
+#define RISCV_IOMMU_REG_FQT             0x0034
+
+/* 5.12 Page Request Queue base (64bits) */
+#define RISCV_IOMMU_REG_PQB             0x0038
+#define RISCV_IOMMU_PQB_LOG2SZ          RISCV_IOMMU_QUEUE_LOGSZ_FIELD
+#define RISCV_IOMMU_PQB_PPN             RISCV_IOMMU_PPN_FIELD
+
+/* 5.13 Page Request Queue head (32bits) */
+#define RISCV_IOMMU_REG_PQH             0x0040
+
+/* 5.14 Page Request Queue tail (32bits) */
+#define RISCV_IOMMU_REG_PQT             0x0044
+
+/* 5.15 Command Queue CSR (32bits) */
+#define RISCV_IOMMU_REG_CQCSR           0x0048
+#define RISCV_IOMMU_CQCSR_CQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_CQCSR_CIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_CQCSR_CQMF          RISCV_IOMMU_QUEUE_MEM_FAULT
+#define RISCV_IOMMU_CQCSR_CMD_TO        BIT(9)
+#define RISCV_IOMMU_CQCSR_CMD_ILL       BIT(10)
+#define RISCV_IOMMU_CQCSR_FENCE_W_IP    BIT(11)
+#define RISCV_IOMMU_CQCSR_CQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_CQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+/* 5.16 Fault Queue CSR (32bits) */
+#define RISCV_IOMMU_REG_FQCSR           0x004C
+#define RISCV_IOMMU_FQCSR_FQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_FQCSR_FIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_FQCSR_FQMF          RISCV_IOMMU_QUEUE_MEM_FAULT
+#define RISCV_IOMMU_FQCSR_FQOF          RISCV_IOMMU_QUEUE_OVERFLOW
+#define RISCV_IOMMU_FQCSR_FQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_FQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+/* 5.17 Page Request Queue CSR (32bits) */
+#define RISCV_IOMMU_REG_PQCSR           0x0050
+#define RISCV_IOMMU_PQCSR_PQEN          RISCV_IOMMU_QUEUE_ENABLE
+#define RISCV_IOMMU_PQCSR_PIE           RISCV_IOMMU_QUEUE_INTR_ENABLE
+#define RISCV_IOMMU_PQCSR_PQMF          RISCV_IOMMU_QUEUE_MEM_FAULT
+#define RISCV_IOMMU_PQCSR_PQOF          RISCV_IOMMU_QUEUE_OVERFLOW
+#define RISCV_IOMMU_PQCSR_PQON          RISCV_IOMMU_QUEUE_ACTIVE
+#define RISCV_IOMMU_PQCSR_BUSY          RISCV_IOMMU_QUEUE_BUSY
+
+/* 5.18 Interrupt Pending Status (32bits) */
+#define RISCV_IOMMU_REG_IPSR            0x0054
+#define RISCV_IOMMU_IPSR_CIP            BIT(0)
+#define RISCV_IOMMU_IPSR_FIP            BIT(1)
+#define RISCV_IOMMU_IPSR_PIP            BIT(3)
+
+enum {
+    RISCV_IOMMU_INTR_CQ,
+    RISCV_IOMMU_INTR_FQ,
+    RISCV_IOMMU_INTR_PM,
+    RISCV_IOMMU_INTR_PQ,
+    RISCV_IOMMU_INTR_COUNT
+};
+
+/* 5.27 Interrupt cause to vector (64bits) */
+#define RISCV_IOMMU_REG_ICVEC           0x02F8
+
+/* 5.28 MSI Configuration table (32 * 64bits) */
+#define RISCV_IOMMU_REG_MSI_CONFIG      0x0300
+
+#define RISCV_IOMMU_REG_SIZE            0x1000
+
+#define RISCV_IOMMU_DDTE_VALID          BIT_ULL(0)
+#define RISCV_IOMMU_DDTE_PPN            RISCV_IOMMU_PPN_FIELD
+
+/* Struct riscv_iommu_dc - Device Context - section 2.1 */
+struct riscv_iommu_dc {
+      uint64_t tc;
+      uint64_t iohgatp;
+      uint64_t ta;
+      uint64_t fsc;
+      uint64_t msiptp;
+      uint64_t msi_addr_mask;
+      uint64_t msi_addr_pattern;
+      uint64_t _reserved;
+};
+
+/* Translation control fields */
+#define RISCV_IOMMU_DC_TC_V             BIT_ULL(0)
+#define RISCV_IOMMU_DC_TC_EN_PRI        BIT_ULL(2)
+#define RISCV_IOMMU_DC_TC_T2GPA         BIT_ULL(3)
+#define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
+#define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
+#define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
+#define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
+#define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
+#define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
+
+/* Second-stage (aka G-stage) context fields */
+#define RISCV_IOMMU_DC_IOHGATP_PPN      RISCV_IOMMU_ATP_PPN_FIELD
+#define RISCV_IOMMU_DC_IOHGATP_GSCID    GENMASK_ULL(59, 44)
+#define RISCV_IOMMU_DC_IOHGATP_MODE     RISCV_IOMMU_ATP_MODE_FIELD
+
+enum riscv_iommu_dc_iohgatp_modes {
+    RISCV_IOMMU_DC_IOHGATP_MODE_BARE = 0,
+    RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 = 8,
+    RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4 = 8,
+    RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4 = 9,
+    RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4 = 10
+};
+
+/* Translation attributes fields */
+#define RISCV_IOMMU_DC_TA_PSCID         GENMASK_ULL(31, 12)
+
+/* First-stage context fields */
+#define RISCV_IOMMU_DC_FSC_PPN          RISCV_IOMMU_ATP_PPN_FIELD
+#define RISCV_IOMMU_DC_FSC_MODE         RISCV_IOMMU_ATP_MODE_FIELD
+
+/* Generic I/O MMU command structure - check section 3.1 */
+struct riscv_iommu_command {
+    uint64_t dword0;
+    uint64_t dword1;
+};
+
+#define RISCV_IOMMU_CMD_OPCODE          GENMASK_ULL(6, 0)
+#define RISCV_IOMMU_CMD_FUNC            GENMASK_ULL(9, 7)
+
+#define RISCV_IOMMU_CMD_IOTINVAL_OPCODE         1
+#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA       0
+#define RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA      1
+#define RISCV_IOMMU_CMD_IOTINVAL_AV     BIT_ULL(10)
+#define RISCV_IOMMU_CMD_IOTINVAL_PSCID  GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_CMD_IOTINVAL_PSCV   BIT_ULL(32)
+#define RISCV_IOMMU_CMD_IOTINVAL_GV     BIT_ULL(33)
+#define RISCV_IOMMU_CMD_IOTINVAL_GSCID  GENMASK_ULL(59, 44)
+
+#define RISCV_IOMMU_CMD_IOFENCE_OPCODE          2
+#define RISCV_IOMMU_CMD_IOFENCE_FUNC_C          0
+#define RISCV_IOMMU_CMD_IOFENCE_AV      BIT_ULL(10)
+#define RISCV_IOMMU_CMD_IOFENCE_DATA    GENMASK_ULL(63, 32)
+
+#define RISCV_IOMMU_CMD_IODIR_OPCODE            3
+#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT    0
+#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT    1
+#define RISCV_IOMMU_CMD_IODIR_PID       GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_CMD_IODIR_DV        BIT_ULL(33)
+#define RISCV_IOMMU_CMD_IODIR_DID       GENMASK_ULL(63, 40)
+
+enum riscv_iommu_dc_fsc_atp_modes {
+    RISCV_IOMMU_DC_FSC_MODE_BARE = 0,
+    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 = 8,
+    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 = 8,
+    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48 = 9,
+    RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 = 10,
+    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8 = 1,
+    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17 = 2,
+    RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20 = 3
+};
+
+enum riscv_iommu_fq_causes {
+    RISCV_IOMMU_FQ_CAUSE_INST_FAULT           = 1,
+    RISCV_IOMMU_FQ_CAUSE_RD_ADDR_MISALIGNED   = 4,
+    RISCV_IOMMU_FQ_CAUSE_RD_FAULT             = 5,
+    RISCV_IOMMU_FQ_CAUSE_WR_ADDR_MISALIGNED   = 6,
+    RISCV_IOMMU_FQ_CAUSE_WR_FAULT             = 7,
+    RISCV_IOMMU_FQ_CAUSE_INST_FAULT_S         = 12,
+    RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S           = 13,
+    RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S           = 15,
+    RISCV_IOMMU_FQ_CAUSE_INST_FAULT_VS        = 20,
+    RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS          = 21,
+    RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS          = 23,
+    RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED         = 256,
+    RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT       = 257,
+    RISCV_IOMMU_FQ_CAUSE_DDT_INVALID          = 258,
+    RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED    = 259,
+    RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED        = 260,
+    RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT       = 261,
+    RISCV_IOMMU_FQ_CAUSE_MSI_INVALID          = 262,
+    RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED    = 263,
+    RISCV_IOMMU_FQ_CAUSE_MRIF_FAULT           = 264,
+    RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT       = 265,
+    RISCV_IOMMU_FQ_CAUSE_PDT_INVALID          = 266,
+    RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED    = 267,
+    RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED        = 268,
+    RISCV_IOMMU_FQ_CAUSE_PDT_CORRUPTED        = 269,
+    RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED     = 270,
+    RISCV_IOMMU_FQ_CAUSE_MRIF_CORRUIPTED      = 271,
+    RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR    = 272,
+    RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT         = 273,
+    RISCV_IOMMU_FQ_CAUSE_PT_CORRUPTED         = 274
+};
+
+/* MSI page table pointer */
+#define RISCV_IOMMU_DC_MSIPTP_PPN       RISCV_IOMMU_ATP_PPN_FIELD
+#define RISCV_IOMMU_DC_MSIPTP_MODE      RISCV_IOMMU_ATP_MODE_FIELD
+#define RISCV_IOMMU_DC_MSIPTP_MODE_OFF  0
+#define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1
+
+/* Translation attributes fields */
+#define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
+
+/* First stage context fields */
+#define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
+
+enum riscv_iommu_fq_ttypes {
+    RISCV_IOMMU_FQ_TTYPE_NONE = 0,
+    RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH = 1,
+    RISCV_IOMMU_FQ_TTYPE_UADDR_RD = 2,
+    RISCV_IOMMU_FQ_TTYPE_UADDR_WR = 3,
+    RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
+    RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
+    RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
+    RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 8,
+};
+
+/* Fields on pte */
+#define RISCV_IOMMU_MSI_PTE_V           BIT_ULL(0)
+#define RISCV_IOMMU_MSI_PTE_M           GENMASK_ULL(2, 1)
+
+#define RISCV_IOMMU_MSI_PTE_M_MRIF      1
+#define RISCV_IOMMU_MSI_PTE_M_BASIC     3
+
+/* When M == 1 (MRIF mode) */
+#define RISCV_IOMMU_MSI_PTE_MRIF_ADDR   GENMASK_ULL(53, 7)
+/* When M == 3 (basic mode) */
+#define RISCV_IOMMU_MSI_PTE_PPN         RISCV_IOMMU_PPN_FIELD
+#define RISCV_IOMMU_MSI_PTE_C           BIT_ULL(63)
+
+/* Fields on mrif_info */
+#define RISCV_IOMMU_MSI_MRIF_NID        GENMASK_ULL(9, 0)
+#define RISCV_IOMMU_MSI_MRIF_NPPN       RISCV_IOMMU_PPN_FIELD
+#define RISCV_IOMMU_MSI_MRIF_NID_MSB    BIT_ULL(60)
+
+#endif /* _RISCV_IOMMU_BITS_H_ */
-- 
2.45.2


