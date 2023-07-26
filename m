Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D40763923
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:30:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWt-00036c-Dg; Wed, 26 Jul 2023 09:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWa-0002pD-On; Wed, 26 Jul 2023 09:25:56 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWW-0003M3-UH; Wed, 26 Jul 2023 09:25:56 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe11652b64so978121e87.0; 
 Wed, 26 Jul 2023 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377950; x=1690982750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbfsBj/+K4fj7D8dqGOr1JbmZZeN9V37pJVq9TrwgUQ=;
 b=VXQptpi6UUNjS7OhaBnD6VmS8UbaD1QsTbhx6E+aSk3o8JtpN5wP60l0VhLDwziEqT
 CapsUv5c/6THl0oqHP5IRWQC79VvvX7QWd0r1gfHuCBZAk65eFtvf4XX/O754NnUrzTu
 0CoMdR6YFOW6OTpk+IVgwXaNkHf5PUlZSdcLZ28Mkgq3d5IAQcsibPKP5PlqQhtw97xW
 fl5gfyvj71mOVL/Q2ObFqhKXWPxrMMHDSxo+0+QX3RUNa7CCOaskgZTSPgilUkweYKQb
 CuSJJlvA0k3nA9IAq1Kwk46+RRoZAdSZG3IlwEHtM+HIBatY7hUpmJz5OdlhdWJ4UbXB
 fF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377950; x=1690982750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QbfsBj/+K4fj7D8dqGOr1JbmZZeN9V37pJVq9TrwgUQ=;
 b=hTMmuthzaZJHbjyst6QHLHx/9w0FQ2qP+F3NNBarm2lXLsqgsqYgkUwqnwY3AaEC+B
 Cyg7n+oMX77dhby8RyJeyDGVZYwZQbTfG/gQt7VFb5n/xyjNEpaGergdQNr2eV8kXKK9
 LRo7Hkfvk6/KLfiiG6ttaX47fZnIntlKLfKJmvYx84kJMrBqdzIU38ZgA9Yb6X88E5BE
 jh0ytkDqXQ2O6il0011N5HHlPKwWWlVbNzZqewAHC4wzcTkk9i4k8lfzzTYouZx4sgTx
 8jCdiNJx8CVzGPmDHXE2d6ms8KxDWwcgvJVTkF5YwioYQT78unz/Hxitn16LBgtcqK58
 Pqww==
X-Gm-Message-State: ABy/qLa+K374dIAiaVCpGbNuqslu8Xul/wrjbWzcBeKhIP/e3UpFs/BX
 TmMpUWMTUGexvDRQ43xsLRScyNPm0uk=
X-Google-Smtp-Source: APBJJlFMVZ7FAifU0TtPpycOF77V3e91tK9d2PFUmA0k3YWCN6Ha2D8HJ0Gr6Qb8JNDHZIVntCg+3g==
X-Received: by 2002:a19:ca0e:0:b0:4f8:6dfd:faa0 with SMTP id
 a14-20020a19ca0e000000b004f86dfdfaa0mr1457298lfg.2.1690377949945; 
 Wed, 26 Jul 2023 06:25:49 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:49 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 25/44] Add GENET register structs. Part 3
Date: Wed, 26 Jul 2023 16:24:53 +0300
Message-Id: <20230726132512.149618-26-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x131.google.com
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
 include/hw/net/bcm2838_genet.h | 206 +++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 4542f27eba..4cf70a17d3 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -22,6 +22,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_DMA_RING_CNT      17
 #define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
 
+#define BCM2838_GENET_HFB_FILTER_CNT      48
+#define BCM2838_GENET_HFB_FILTER_SIZE     128
+
 typedef union {
     uint32_t value;
     struct {
@@ -179,6 +182,25 @@ typedef union {
     } fields;
 } BCM2838GenetDmaStatus;
 
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t reserved_0_3:4;
+        uint32_t do_csum:1;
+        uint32_t ow_crc:1;
+        uint32_t append_crc:1;
+        uint32_t reserved_7_8:2;
+        uint32_t underrun:1;
+        uint32_t reserved_10_11:2;
+        uint32_t wrap:1;
+        uint32_t sop:1;
+        uint32_t eop:1;
+        uint32_t own:1;
+        uint32_t buflength:12;
+        uint32_t reserved_28_31:4;
+    } fields;
+} BCM2838GenetTdmaLengthStatus;
+
 typedef union {
     uint32_t value;
     struct {
@@ -346,6 +368,53 @@ typedef struct {
     uint8_t reserved_0x10D0[0xF30];
 } __attribute__((__packed__)) BCM2838GenetRegsRdma;
 
+typedef struct {
+    BCM2838GenetTdmaLengthStatus length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} __attribute__((__packed__)) BCM2838GenetTdmaDesc;
+
+typedef struct {
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    BCM2838GenetDmaConsIndex cons_index;
+    BCM2838GenetDmaProdIndex prod_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t flow_period;
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint8_t reserved_0x34[0xC];
+} __attribute__((__packed__)) BCM2838GenetTdmaRing;
+
+typedef struct {
+    BCM2838GenetTdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetTdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    BCM2838GenetDmaRingCfg ring_cfg;
+    BCM2838GenetDmaCtrl ctrl;
+    BCM2838GenetDmaStatus status;
+    uint32_t scb_burst_size;
+    uint8_t reserved_0x1050[0x1C];
+    uint32_t arb_ctrl;
+    uint32_t priority[3];
+    uint8_t reserved_0x10D0[0xF84];
+} __attribute__((__packed__)) BCM2838GenetRegsTdma;
+
+typedef struct {
+    uint8_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE
+                * sizeof(uint32_t)];
+    uint8_t reserved_0x6000[0x1C00];
+    uint32_t ctrl;
+    uint32_t flt_enable[2];
+    uint8_t reserved_0x7C0C[0x10];
+    uint32_t flt_len[BCM2838_GENET_HFB_FILTER_CNT / sizeof(uint32_t)];
+    uint8_t reserved_0x7C4C[0x3B4];
+} __attribute__((__packed__)) BCM2838GenetRegsHfb;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -361,8 +430,144 @@ typedef struct {
     BCM2838GenetRegsUmac umac;
     uint8_t reserved_0x1000[0x1000];
     BCM2838GenetRegsRdma rdma;
+    BCM2838GenetRegsTdma tdma;
+    uint8_t reserved_0x6000[0x2000];
+    BCM2838GenetRegsHfb hfb;
 } __attribute__((__packed__)) BCM2838GenetRegs;
 
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reserved_0_5:6;
+        uint16_t speed1000:1;
+        uint16_t ctst:1;
+        uint16_t fulldplx:1;
+        uint16_t anrestart:1;
+        uint16_t isolate:1;
+        uint16_t pdown:1;
+        uint16_t aenable:1;
+        uint16_t speed100:1;
+        uint16_t loopback:1;
+        uint16_t reset:1;
+    } fields;
+} BCM2838GenetPhyBmcr;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t ercap:1;
+        uint16_t jcd:1;
+        uint16_t lstatus:1;
+        uint16_t anegcapable:1;
+        uint16_t rfault:1;
+        uint16_t anegcomplete:1;
+        uint16_t reserved_6_7:2;
+        uint16_t estaten:1;
+        uint16_t _100half2:1;
+        uint16_t _100full2:1;
+        uint16_t _10half:1;
+        uint16_t _10full:1;
+        uint16_t _100half:1;
+        uint16_t _100full:1;
+        uint16_t _100base4:1;
+    } fields;
+} BCM2838GenetPhyBmsr;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t slct:5;
+        uint16_t _10half_1000xfull:1;
+        uint16_t _10full_1000xhalf:1;
+        uint16_t _100half_1000xpause:1;
+        uint16_t _100full_1000xpause_asym:1;
+        uint16_t _100base4:1;
+        uint16_t pause_cap:1;
+        uint16_t pause_asym:1;
+        uint16_t reserved_12:1;
+        uint16_t rfault:1;
+        uint16_t lpack:1;
+        uint16_t npage:1;
+    } fields;
+} BCM2838GenetPhyLpa;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reserved_0_9:10;
+        uint16_t _1000half:1;
+        uint16_t _1000full:1;
+        uint16_t _1000remrxok:1;
+        uint16_t _1000localrxok:1;
+        uint16_t _1000msres:1;
+        uint16_t _1000msfail:1;
+    } fields;
+} BCM2838GenetPhyStat1000;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reg_id_mask:3;
+        uint16_t reserved_3:1;
+        uint16_t reg_data:8;
+        uint16_t reg_id:3;
+        uint16_t misc_wren:1;
+    } fields_1;
+    struct {
+        uint16_t reserved_0_3:4;
+        uint16_t reg_data:12;
+    } fields_2;
+} BCM2838GenetPhyAuxCtl;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reg_data:10;
+        uint16_t reg_id:5;
+        uint16_t wr:1;
+    } fields;
+} BCM2838GenetPhyShadow;
+
+
+typedef struct {
+    uint8_t reg_id;
+    uint8_t block_id;
+}  __attribute__((__packed__)) BCM2838GenetPhyExpSel;
+
+typedef struct {
+    BCM2838GenetPhyBmcr bmcr;
+    BCM2838GenetPhyBmsr bmsr;
+    uint16_t sid1;
+    uint16_t sid2;
+    uint16_t advertise;
+    BCM2838GenetPhyLpa lpa;
+    uint16_t expansion;
+    uint16_t next_page;
+    uint16_t lpa_next_page;
+    uint16_t ctrl1000;
+    BCM2838GenetPhyStat1000 stat1000;
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
+    BCM2838GenetPhyExpSel exp_ctrl;
+    BCM2838GenetPhyAuxCtl aux_ctl;
+    uint16_t phyaddr;
+    uint16_t isr;
+    uint16_t imr;
+    BCM2838GenetPhyShadow shd;
+    uint16_t reserved_29;
+    uint16_t rdb_addr;
+    uint16_t rdb_data;
+} __attribute__((__packed__)) BCM2838GenetPhyRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -373,6 +578,7 @@ struct BCM2838GenetState {
     AddressSpace dma_as;
 
     BCM2838GenetRegs regs;
+    BCM2838GenetPhyRegs phy_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


