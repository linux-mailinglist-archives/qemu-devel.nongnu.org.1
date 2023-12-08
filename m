Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA0809963
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:41:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQgE-00052h-Cm; Thu, 07 Dec 2023 21:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQg4-0004tP-LB; Thu, 07 Dec 2023 21:33:21 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQg2-0002Zw-N9; Thu, 07 Dec 2023 21:33:20 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ca0c36f5beso20174951fa.1; 
 Thu, 07 Dec 2023 18:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002796; x=1702607596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Rjbw5RYP1TnoKVdXAKQhTrSFNyGeuEqSS68XHm6tGg=;
 b=Qs21APE9GUtpDDVUS9SWs+QPcl2u2xRRy3Xam06NbRtrn140IELMn0D2hqbUojBU2H
 j8gtzoqZ2h8xH067os7S1mfAMjIWkYc761NLOIGnfaF8XNiKS8np6kaXvalTo7X4glnO
 YbtVFUbvilOIyqJ3c92Dsp1628iQLCFfoH9HtRubYzoAvj6Ge+K9wyp8m9UG1cn7SpQl
 647HffW75StlnV6hPsj54G5I3Rv+io+DIsSApzXIbX9yOl9l9YGfm7rTeHqbcyDLTesB
 NEvxuDjJ3x0CnhFo8k4vfG5TbjWcZLgjB7fHUS+9EuLHN1GMe7K85ZZDNjf4GrVkHFG6
 KHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002796; x=1702607596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Rjbw5RYP1TnoKVdXAKQhTrSFNyGeuEqSS68XHm6tGg=;
 b=gVHZKjb3EAmC2EZ2QkSwUTLFJOuvGGuSd7pgexfJYp3Ibe5esS8qFZPujUz2n32FGQ
 lzP9QcUJwJ9xANks+jXoymdH9rA0E51bv4o+RQ9RyxSrc6vkZDi8KhB8l1nIYnspuQEE
 Xzdk7+RQIbXYM5a0l+1SHpG5bLN3echDW5kNo+OSq7uWHhXx5wh9EnviWGU7hyxmlB5n
 vVpDcvo563G4UCCZe4NsEJqB9d3llprsg9t5wj4pFuaCNQCYsi8Mfw07bRrT6K/wDjXM
 Q2y0MqHBUK7QYiEtpeZy/adSVnnM4nGA+a/TkcZutm14Vu7FcXEZRS0P3fmg4PwkzAW8
 C8TA==
X-Gm-Message-State: AOJu0YzxEwuKxKr6IWZRxpgend5MhO4G7tYy3M5nK9YN4KUYIWz6lTde
 twb1iIPCDv71kAhhF7FfBk0aV0XnRnXm+A==
X-Google-Smtp-Source: AGHT+IGqKYgm/CYH0KJuhBD0CCm2kUiWNir5O6Qba/IhThEnooznMq/fKUJwZVjRAs7Wq6PVtWcGpw==
X-Received: by 2002:a2e:3503:0:b0:2ca:ab3:7863 with SMTP id
 z3-20020a2e3503000000b002ca0ab37863mr1818774ljz.66.1702002795715; 
 Thu, 07 Dec 2023 18:33:15 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:33:14 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 24/45] Add GENET register structs. Part 2
Date: Thu,  7 Dec 2023 20:31:24 -0600
Message-Id: <20231208023145.1385775-25-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 89 ++++++++++++++++++++++++++++++++++
 include/hw/net/bcm2838_genet.h | 89 ++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 0d98d1b30e..9a99f34c4a 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -19,6 +19,7 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+/* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
 FIELD(GENET_SYS_REV_CTRL, MINOR_REV,   16, 4)
@@ -55,6 +56,94 @@ REG32(GENET_INTRL_1,              0)
 FIELD(GENET_INTRL_1, TX_INTRS,    0, 16)
 FIELD(GENET_INTRL_1, RX_INTRS,    16, 16)
 
+REG32(GENET_UMAC_CMD,                  0)
+FIELD(GENET_UMAC_CMD, TX_EN,           0, 1)
+FIELD(GENET_UMAC_CMD, RX_EN,           1, 1)
+FIELD(GENET_UMAC_CMD, SPEED,           2, 2)
+FIELD(GENET_UMAC_CMD, PROMISC,         4, 1)
+FIELD(GENET_UMAC_CMD, PAD_EN,          5, 1)
+FIELD(GENET_UMAC_CMD, CRC_FWD,         6, 1)
+FIELD(GENET_UMAC_CMD, PAUSE_FWD,       7, 1)
+FIELD(GENET_UMAC_CMD, RX_PAUSE_IGNORE, 8, 1)
+FIELD(GENET_UMAC_CMD, TX_ADDR_INS,     9, 1)
+FIELD(GENET_UMAC_CMD, HD_EN,           10, 1)
+FIELD(GENET_UMAC_CMD, SW_RESET_OLD,    11, 1)
+FIELD(GENET_UMAC_CMD, RSVD_12,         12, 1)
+FIELD(GENET_UMAC_CMD, SW_RESET,        13, 1)
+FIELD(GENET_UMAC_CMD, RSVD_14,         14, 1)
+FIELD(GENET_UMAC_CMD, LCL_LOOP_EN,     15, 1)
+FIELD(GENET_UMAC_CMD, RSVD_16_21,      16, 6)
+FIELD(GENET_UMAC_CMD, AUTO_CONFIG,     22, 1)
+FIELD(GENET_UMAC_CMD, CNTL_FRM_EN,     23, 1)
+FIELD(GENET_UMAC_CMD, NO_LEN_CHK,      24, 1)
+FIELD(GENET_UMAC_CMD, RMT_LOOP_EN,     25, 1)
+FIELD(GENET_UMAC_CMD, RX_ERR_DISC,     26, 1)
+FIELD(GENET_UMAC_CMD, PRBL_EN,         27, 1)
+FIELD(GENET_UMAC_CMD, TX_PAUSE_IGNORE, 28, 1)
+FIELD(GENET_UMAC_CMD, TX_RX_EN,        29, 1)
+FIELD(GENET_UMAC_CMD, RUNT_FILTER_DIS, 30, 1)
+FIELD(GENET_UMAC_CMD, RSVD_31,         31, 1)
+
+REG32(GENET_UMAC_MAC_0,         0)
+FIELD(GENET_UMAC_MAC_0, ADDR_3, 0,  8)
+FIELD(GENET_UMAC_MAC_0, ADDR_2, 8,  8)
+FIELD(GENET_UMAC_MAC_0, ADDR_1, 16, 8)
+FIELD(GENET_UMAC_MAC_0, ADDR_0, 24, 8)
+
+REG32(GENET_UMAC_MAC_1,             0)
+FIELD(GENET_UMAC_MAC_1, ADDR_5,     0,  8)
+FIELD(GENET_UMAC_MAC_1, ADDR_4,     8,  8)
+FIELD(GENET_UMAC_MAC_1, RSVD_16_31, 16, 8)
+
+REG32(GENET_UMAC_MDIO_CMD,             0)
+FIELD(GENET_UMAC_MDIO_CMD, REG_DATA,   0, 16)
+FIELD(GENET_UMAC_MDIO_CMD, REG_ID,     16, 5)
+FIELD(GENET_UMAC_MDIO_CMD, PHY_ID,     21, 5)
+FIELD(GENET_UMAC_MDIO_CMD, WR,         26, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RD,         27, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RD_FAIL,    28, 1)
+FIELD(GENET_UMAC_MDIO_CMD, START_BUSY, 29, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RSVD_30_31, 30, 2)
+
+REG32(GENET_DMA_RING_CFG,             0)
+FIELD(GENET_DMA_RING_CFG, EN,         0, 17)
+FIELD(GENET_DMA_RING_CFG, RSVD_17_31, 17, 14)
+
+REG32(GENET_DMA_CTRL,              0)
+FIELD(GENET_DMA_CTRL, EN,          0, 1)
+FIELD(GENET_DMA_CTRL, RING_BUF_EN, 1, 17)
+FIELD(GENET_DMA_CTRL, RSVD_18_19,  18, 2)
+FIELD(GENET_DMA_CTRL, TSB_SWAP_EN, 20, 1)
+FIELD(GENET_DMA_CTRL, RSVD_21_31,  21, 11)
+
+REG32(GENET_DMA_PROD_INDEX,              0)
+FIELD(GENET_DMA_PROD_INDEX, INDEX,       0, 16)
+FIELD(GENET_DMA_PROD_INDEX, DISCARD_CNT, 16, 16)
+
+REG32(GENET_DMA_CONS_INDEX,             0)
+FIELD(GENET_DMA_CONS_INDEX, INDEX,      0, 16)
+FIELD(GENET_DMA_CONS_INDEX, RSVD_16_31, 16, 16)
+
+REG32(GENET_DMA_STATUS,                     0)
+FIELD(GENET_DMA_STATUS, DISABLED,           0, 1)
+FIELD(GENET_DMA_STATUS, DESC_RAM_INIT_BUSY, 1, 1)
+FIELD(GENET_DMA_STATUS, RSVD_2_31,          2, 30)
+
+REG32(GENET_RDMA_LENGTH_STATUS,             0)
+FIELD(GENET_RDMA_LENGTH_STATUS, OVERRUN,    0, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, CRC_ERROR,  1, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, RXERR,      2, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, NO,         3, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, LG,         4, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, MULTICAST,  5, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, BROADCAST,  6, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_7_11,  7, 5)
+FIELD(GENET_RDMA_LENGTH_STATUS, WRAP,       12, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, SOP,        13, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, EOP,        14, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, OWN,        15, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
+FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
 
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index f583818399..736b4d1757 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,6 +18,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+#define BCM2838_GENET_DMA_DESC_CNT      256
+#define BCM2838_GENET_DMA_RING_CNT      17
+#define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -83,6 +87,88 @@ typedef struct {
     uint32_t reserved_0x18[58];
 } BCM2838GenetRegsTbuf;
 
+typedef struct {
+    uint32_t reserved_0x0;
+    uint32_t hd_bkp_ctrl;
+    uint32_t cmd;
+    uint32_t mac0;
+    uint32_t mac1;
+    uint32_t max_frame_len;
+    uint32_t pause_quanta;
+    uint32_t reserved_0x1C[10];
+    uint32_t mode;
+    uint32_t frm_tag0;
+    uint32_t frm_tag1;
+    uint32_t reserved_0x50[3];
+    uint32_t tx_ipg_len;
+    uint32_t reserved_0x60;
+    uint32_t eee_ctrl;
+    uint32_t eee_lpi_timer;
+    uint32_t eee_wake_timer;
+    uint32_t eee_ref_count;
+    uint32_t reserved_0x74;
+    uint32_t rx_ipg_inv;
+    uint32_t reserved_0x7C[165];
+    uint32_t macsec_prog_tx_crc;
+    uint32_t macsec_ctrl;
+    uint32_t reserved_0x318[6];
+    uint32_t pause_ctrl;
+    uint32_t tx_flush;
+    uint32_t rx_fifo_status;
+    uint32_t tx_fifo_status;
+    uint32_t reserved_0x340[48];
+    uint32_t mib[96];
+    uint32_t mib_ctrl;
+    uint32_t reserved_0x584[36];
+    uint32_t mdio_cmd;
+    uint32_t reserved_0x618[2];
+    uint32_t mpd_ctrl;
+    uint32_t mpd_pw_ms;
+    uint32_t mpd_pw_ls;
+    uint32_t reserved_0x62C[3];
+    uint32_t mdf_err_cnt;
+    uint32_t reserved_0x63C[5];
+    uint32_t mdf_ctrl;
+    uint32_t mdf_addr;
+    uint32_t reserved_0x658[106];
+} BCM2838GenetRegsUmac;
+
+typedef struct {
+    uint32_t length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} BCM2838GenetRdmaDesc;
+
+typedef struct {
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint32_t prod_index;
+    uint32_t cons_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t xon_xoff_tresh;
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint32_t reserved_0x34[3];
+} BCM2838GenetRdmaRing;
+
+typedef struct {
+    BCM2838GenetRdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetRdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    uint32_t ring_cfg;
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t scb_burst_size;
+    uint32_t reserved_0x1050[7];
+    uint32_t ring_timeout[17];
+    uint32_t index2ring[8];
+    uint32_t reserved_0x10D0[972];
+} BCM2838GenetRegsRdma;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -95,6 +181,9 @@ typedef struct {
     uint32_t reserved_0x400[128];
     BCM2838GenetRegsTbuf tbuf;
     uint32_t reserved_0x700[64];
+    BCM2838GenetRegsUmac umac;
+    uint32_t reserved_0x1000[1024];
+    BCM2838GenetRegsRdma rdma;
 } BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.34.1


