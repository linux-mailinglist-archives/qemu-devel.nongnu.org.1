Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 260FC802820
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:52:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLV-0003Ga-Ne; Sun, 03 Dec 2023 16:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLT-0003E8-Bv; Sun, 03 Dec 2023 16:49:47 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLR-0008OZ-F0; Sun, 03 Dec 2023 16:49:47 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5c08c47c055so41671237b3.1; 
 Sun, 03 Dec 2023 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640184; x=1702244984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GUF+BYnLIFgUYZSAH+PcH4wY20N6XyOgpSpQ20MSSg=;
 b=UmE7b8yoeFng5LM37oyVe2q26onJgHnIN244CnYuRHInN3QKpwHYDrUAchIdg+PxTk
 o3CnitCnd6vI1XAkD60irM/6vFKwN/b334QI4FfDIGGdUKOtns4dOENleA1Sy9W3yCXP
 BFSI+2KCVOTWIJ5og8xKgzMTS18nwCj3lU0EpBJLmF8FgKHk9285z7kH/rzY32LVh9yC
 KofnjxBCcFE/AITEiZMqPeZX/VL+nSgWrWb1qvC4gPUfpEj3uhKD+AwsR+L0DImeBFnx
 rtAVrT6Vhjf3JU0q85v5jDTiV2vmizGE7Jw5KxTmfpzO24PYQpJfo7V5Zdi581lBoWcx
 fazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640184; x=1702244984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GUF+BYnLIFgUYZSAH+PcH4wY20N6XyOgpSpQ20MSSg=;
 b=Urxqx4zNEZzPNpsZcSbTAt9xD0maKCgDWdhu/AEgMWjqPTDUnEOyJMHuDflqiGbvYE
 pAUkTrUcUHmYbgBpItlFXNgnu4vJVb7fDW1IPEdOJ/c+iypDBbXxhwHpLsXQXjtxRp8A
 HQdtCSVDBcsNhFOnU81d57Znj+mR00SXB6CbnAZY+yM0AWtKB1vt7fYM9BRc5o74iNd+
 ARztQos7t2uItqBy4KXIu9T3HXRa7f/cZFY+L1iyy0bTli2uj0LN1aICPIdx0hNnYJS5
 z9Q/lSxQLNVUxzG2xCZ/xxUt/s3PTYqpIdyHamrPsVXNN/B8nU8IA+wRGTkhNXGneFHl
 OWIQ==
X-Gm-Message-State: AOJu0YzedvhzxkFSMuB7Ef58hpe3OM1xWXtw07Vg8NEeO1+CthGxGPyo
 Euwe49rlN+tWkiwMkeo5IHSilpghrbF4IQ==
X-Google-Smtp-Source: AGHT+IGt1kwbUetgmwb3mHh3lnKiSUHkSBHCbqwon+7QUlsBE9Y2807bhm985vhyRE6VTCgUuDkolA==
X-Received: by 2002:a81:ac62:0:b0:5d7:1940:53d5 with SMTP id
 z34-20020a81ac62000000b005d7194053d5mr1705332ywj.77.1701640183995; 
 Sun, 03 Dec 2023 13:49:43 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:43 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 25/45] Add GENET register structs. Part 3
Date: Sun,  3 Dec 2023 15:48:50 -0600
Message-Id: <20231203214910.1364468-26-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-25-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-2-sergey.kambalin@auriga.com>
 <20231203214910.1364468-3-sergey.kambalin@auriga.com>
 <20231203214910.1364468-4-sergey.kambalin@auriga.com>
 <20231203214910.1364468-5-sergey.kambalin@auriga.com>
 <20231203214910.1364468-6-sergey.kambalin@auriga.com>
 <20231203214910.1364468-7-sergey.kambalin@auriga.com>
 <20231203214910.1364468-8-sergey.kambalin@auriga.com>
 <20231203214910.1364468-9-sergey.kambalin@auriga.com>
 <20231203214910.1364468-10-sergey.kambalin@auriga.com>
 <20231203214910.1364468-11-sergey.kambalin@auriga.com>
 <20231203214910.1364468-12-sergey.kambalin@auriga.com>
 <20231203214910.1364468-13-sergey.kambalin@auriga.com>
 <20231203214910.1364468-14-sergey.kambalin@auriga.com>
 <20231203214910.1364468-15-sergey.kambalin@auriga.com>
 <20231203214910.1364468-16-sergey.kambalin@auriga.com>
 <20231203214910.1364468-17-sergey.kambalin@auriga.com>
 <20231203214910.1364468-18-sergey.kambalin@auriga.com>
 <20231203214910.1364468-19-sergey.kambalin@auriga.com>
 <20231203214910.1364468-20-sergey.kambalin@auriga.com>
 <20231203214910.1364468-21-sergey.kambalin@auriga.com>
 <20231203214910.1364468-22-sergey.kambalin@auriga.com>
 <20231203214910.1364468-23-sergey.kambalin@auriga.com>
 <20231203214910.1364468-24-sergey.kambalin@auriga.com>
 <20231203214910.1364468-25-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1136.google.com
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
 hw/net/bcm2838_genet.c         | 88 ++++++++++++++++++++++++++++++++++
 include/hw/net/bcm2838_genet.h | 88 ++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 9a99f34c4a..be899b68f8 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -145,6 +145,94 @@ FIELD(GENET_RDMA_LENGTH_STATUS, OWN,        15, 1)
 FIELD(GENET_RDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
 FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
 
+REG32(GENET_TDMA_LENGTH_STATUS,             0)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_0_3,   0, 4)
+FIELD(GENET_TDMA_LENGTH_STATUS, DO_CSUM,    4, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, OW_CRC,     5, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, APPEND_CRC, 6, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_7_8,   7, 2)
+FIELD(GENET_TDMA_LENGTH_STATUS, UNDERRUN,   9, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_10_11, 10, 2)
+FIELD(GENET_TDMA_LENGTH_STATUS, WRAP,       12, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, SOP,        13, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, EOP,        14, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, OWN,        15, 1)
+FIELD(GENET_TDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
+FIELD(GENET_TDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
+
+REG16(GENET_PHY_BMCR,            0)
+FIELD(GENET_PHY_BMCR, RSVD_0_5,  0, 6)
+FIELD(GENET_PHY_BMCR, SPEED1000, 6, 1)
+FIELD(GENET_PHY_BMCR, CTST,      7, 1)
+FIELD(GENET_PHY_BMCR, FULLDPLX,  8, 1)
+FIELD(GENET_PHY_BMCR, ANRESTART, 9, 1)
+FIELD(GENET_PHY_BMCR, ISOLATE,   10, 1)
+FIELD(GENET_PHY_BMCR, PDOWN,     11, 1)
+FIELD(GENET_PHY_BMCR, AENABLE,   12, 1)
+FIELD(GENET_PHY_BMCR, SPEED100,  13, 1)
+FIELD(GENET_PHY_BMCR, LOOPBACK,  14, 1)
+FIELD(GENET_PHY_BMCR, RESET,     15, 1)
+
+REG16(GENET_PHY_BMSR,               0)
+FIELD(GENET_PHY_BMSR, ERCAP,        0, 1)
+FIELD(GENET_PHY_BMSR, JCD,          1, 1)
+FIELD(GENET_PHY_BMSR, LSTATUS,      2, 1)
+FIELD(GENET_PHY_BMSR, ANEGCAPABLE,  3, 1)
+FIELD(GENET_PHY_BMSR, RFAULT,       4, 1)
+FIELD(GENET_PHY_BMSR, ANEGCOMPLETE, 5, 1)
+FIELD(GENET_PHY_BMSR, RSVD_6_7,     6, 2)
+FIELD(GENET_PHY_BMSR, ESTATEN,      8, 1)
+FIELD(GENET_PHY_BMSR, _100HALF2,    9, 1)
+FIELD(GENET_PHY_BMSR, _100FULL2,    10, 1)
+FIELD(GENET_PHY_BMSR, _10HALF,      11, 1)
+FIELD(GENET_PHY_BMSR, _10FULL,      12, 1)
+FIELD(GENET_PHY_BMSR, _100HALF,     13, 1)
+FIELD(GENET_PHY_BMSR, _100FULL,     14, 1)
+FIELD(GENET_PHY_BMSR, _10BASE4,     15, 1)
+
+REG16(GENET_PHY_LPA,                           0)
+FIELD(GENET_PHY_LPA, SLCT,                     0, 5)
+FIELD(GENET_PHY_LPA, _10HALF_1000XFULL,        5, 1)
+FIELD(GENET_PHY_LPA, _10FULL_1000XHALF,        6, 1)
+FIELD(GENET_PHY_LPA, _100HALF_1000XPAUSE,      7, 1)
+FIELD(GENET_PHY_LPA, _100FULL_1000XPAUSE_ASYM, 8, 1)
+FIELD(GENET_PHY_LPA, _100BASE4,                9, 1)
+FIELD(GENET_PHY_LPA, PAUSE_CAP,                10, 1)
+FIELD(GENET_PHY_LPA, PAUSE_ASYM,               11, 1)
+FIELD(GENET_PHY_LPA, RSVD_12,                  12, 1)
+FIELD(GENET_PHY_LPA, RFAULT,                   13, 1)
+FIELD(GENET_PHY_LPA, LPACK,                    14, 1)
+FIELD(GENET_PHY_LPA, NPAGE,                    15, 1)
+
+REG16(GENET_PHY_STAT_1000,            0)
+FIELD(GENET_PHY_STAT_1000, RSVD_0_9,  0, 10)
+FIELD(GENET_PHY_STAT_1000, HALF,      10, 1)
+FIELD(GENET_PHY_STAT_1000, FULL,      11, 1)
+FIELD(GENET_PHY_STAT_1000, REMRXOK,   12, 1)
+FIELD(GENET_PHY_STAT_1000, LOCALRXOK, 13, 1)
+FIELD(GENET_PHY_STAT_1000, MSRES,     14, 1)
+FIELD(GENET_PHY_STAT_1000, MSFAIL,    15, 1)
+
+REG16(GENET_PHY_AUX_CTRL_0,              0)
+FIELD(GENET_PHY_AUX_CTRL_0, REG_ID_MASK, 0, 3)
+FIELD(GENET_PHY_AUX_CTRL_0, RSVD_3,      3, 1)
+FIELD(GENET_PHY_AUX_CTRL_0, REG_DATA,    4, 8)
+FIELD(GENET_PHY_AUX_CTRL_0, REG_ID,      12, 3)
+FIELD(GENET_PHY_AUX_CTRL_0, MISC_WREN,   15, 1)
+
+REG16(GENET_PHY_AUX_CTRL_1,           0)
+FIELD(GENET_PHY_AUX_CTRL_1, RSVD_0_3, 0, 4)
+FIELD(GENET_PHY_AUX_CTRL_1, REG_DATA, 4, 12)
+
+REG16(GENET_PHY_SHADOW,           0)
+FIELD(GENET_PHY_SHADOW, REG_DATA, 0, 10)
+FIELD(GENET_PHY_SHADOW, REG_ID,   10, 5)
+FIELD(GENET_PHY_SHADOW, WR,       15, 1)
+
+REG16(GENET_PHY_EXP_SEL,           0)
+FIELD(GENET_PHY_EXP_SEL, REG_ID,   0, 8)
+FIELD(GENET_PHY_EXP_SEL, BLOCK_ID, 8, 8)
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 736b4d1757..1bd004785a 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -22,6 +22,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_DMA_RING_CNT      17
 #define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
 
+#define BCM2838_GENET_HFB_FILTER_CNT      48
+#define BCM2838_GENET_HFB_FILTER_SIZE     128
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -169,6 +172,53 @@ typedef struct {
     uint32_t reserved_0x10D0[972];
 } BCM2838GenetRegsRdma;
 
+typedef struct {
+    uint32_t length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} BCM2838GenetTdmaDesc;
+
+typedef struct {
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint32_t cons_index;
+    uint32_t prod_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t flow_period;
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint32_t reserved_0x34[3];
+} BCM2838GenetTdmaRing;
+
+typedef struct {
+    BCM2838GenetTdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetTdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    uint32_t ring_cfg;
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t scb_burst_size;
+    uint32_t reserved_0x1050[7];
+    uint32_t arb_ctrl;
+    uint32_t priority[3];
+    uint32_t reserved_0x10D0[993];
+} BCM2838GenetRegsTdma;
+
+typedef struct {
+    uint8_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE
+        * sizeof(uint32_t)];
+    uint32_t reserved_0x6000[1792];
+    uint32_t ctrl;
+    uint32_t flt_enable[2];
+    uint32_t reserved_0x7C0C[4];
+    uint32_t flt_len[BCM2838_GENET_HFB_FILTER_CNT / sizeof(uint32_t)];
+    uint32_t reserved_0x7C4C[237];
+} BCM2838GenetRegsHfb;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -184,8 +234,45 @@ typedef struct {
     BCM2838GenetRegsUmac umac;
     uint32_t reserved_0x1000[1024];
     BCM2838GenetRegsRdma rdma;
+    BCM2838GenetRegsTdma tdma;
+    uint32_t reserved_0x6000[2048];
+    BCM2838GenetRegsHfb hfb;
 } BCM2838GenetRegs;
 
+typedef struct {
+    uint16_t bmcr;
+    uint16_t bmsr;
+    uint16_t sid1;
+    uint16_t sid2;
+    uint16_t advertise;
+    uint16_t lpa;
+    uint16_t expansion;
+    uint16_t next_page;
+    uint16_t lpa_next_page;
+    uint16_t ctrl1000;
+    uint16_t stat1000;
+    uint16_t reserved_11_12[2];
+    uint16_t mmd_ctrl;
+    uint16_t mmd_data;
+    uint16_t estatus;
+    uint16_t ecr;
+    uint16_t esr;
+    uint16_t dcounter;
+    uint16_t fcscounter;
+    uint16_t nwaytest;
+    uint16_t exp_data;
+    uint16_t srevision;
+    uint16_t exp_ctrl;
+    uint16_t aux_ctl;
+    uint16_t phyaddr;
+    uint16_t isr;
+    uint16_t imr;
+    uint16_t shd;
+    uint16_t reserved_29;
+    uint16_t rdb_addr;
+    uint16_t rdb_data;
+} BCM2838GenetPhyRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -196,6 +283,7 @@ struct BCM2838GenetState {
     AddressSpace dma_as;
 
     BCM2838GenetRegs regs;
+    BCM2838GenetPhyRegs phy_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


