Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B577638EF
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWw-00038P-2x; Wed, 26 Jul 2023 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWa-0002pG-PN; Wed, 26 Jul 2023 09:25:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWW-0003LB-Sz; Wed, 26 Jul 2023 09:25:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fde022de07so9479284e87.1; 
 Wed, 26 Jul 2023 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377949; x=1690982749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YD7YWh1gD1ryuvX4jYCwJqGNdPGhCLfiSZBq/8ofA4M=;
 b=dR/wU8d85rnBxT26E6CUOtQmYe6kndO3WUOmj3wOKRHyp97Ca/0CYGjmiIh6VPZ0L6
 0aa70R0MK7Yp5f99+f9KG9Hh8Zsi/4MC+AeHdfgPsbq0E4P5pYQCQCjouk5tcLPVxYou
 C/IN4odkE0HnAQjs7Xo77L0ZsqYJzh3YZRlk5FjHTBIdzwFEqDRza/GJHrCQy6nT796A
 Bv29Zv/eNTZuoFt8Uw3o7f8Ep9Z9/BlfxEtD4yFArnT6iYkf2s26Mxd5VekxyfWpBKCF
 L+j5xU9RjFQic9KHv1i14hB9RBSIExouLjPCj3EGGiiqVIa00Hq/rsV5v/DrKGx/vbLh
 vfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377949; x=1690982749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YD7YWh1gD1ryuvX4jYCwJqGNdPGhCLfiSZBq/8ofA4M=;
 b=Ce9bQmaGRWXUHM6G1hSXj3kSrgHGD0seWYGPogLOZX6dFCSQJoVJlZJVoWKoCKLkOP
 T3ZeiMPHiEFlcsmhR8ihj1Ak9nNwjXoFNdaxl47WkWuiyfQKwjLaZEQsOh1vrbehSjHa
 NPEtTxtZwmsZt9pv2zflxkmOGIoBYMb8btljdIe1LqnZST7u1LyCgS3g+ukSIMffUOBd
 IY+cJ7QfqctqlS7BxrQgbdh5YtE+mNqWscX9bc2Nzp4HbyPllwBNX5ml+NusVXjk6/lM
 kBZR3NK3HcmSdk9ELySzo+LKJYWCfxqoc/fP92O6Rak56eTaXowiDiXgJIJ+Dr4wx8Vo
 EZng==
X-Gm-Message-State: ABy/qLaywXqTRqYceThbub65Rn3x6qw9jAx07dklMlstV5U+FpJNUHPP
 t4pqUlG/KXq5rEjSuREksb8nMkfaKbo=
X-Google-Smtp-Source: APBJJlECyJy6GEO+HYsooUHBJDSLeID1m/kkwnsbguObBV0NHrwfP/XijJjwPJZk6AzAhGhxbf7IFg==
X-Received: by 2002:a19:7705:0:b0:4fd:c923:db62 with SMTP id
 s5-20020a197705000000b004fdc923db62mr1352788lfc.23.1690377947933; 
 Wed, 26 Jul 2023 06:25:47 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:47 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 24/44] Add GENET register structs. Part 2
Date: Wed, 26 Jul 2023 16:24:52 +0300
Message-Id: <20230726132512.149618-25-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x130.google.com
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
 include/hw/net/bcm2838_genet.h | 218 +++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 89b45eb39f..4542f27eba 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,6 +18,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+#define BCM2838_GENET_DMA_DESC_CNT      256
+#define BCM2838_GENET_DMA_RING_CNT      17
+#define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
+
 typedef union {
     uint32_t value;
     struct {
@@ -66,6 +70,135 @@ typedef union {
     } fields;
 } BCM2838GenetIntrl1;
 
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t tx_en:1;
+        uint32_t rx_en:1;
+        uint32_t speed:2;
+        uint32_t promisc:1;
+        uint32_t pad_en:1;
+        uint32_t crc_fwd:1;
+        uint32_t pause_fwd:1;
+        uint32_t rx_pause_ignore:1;
+        uint32_t tx_addr_ins:1;
+        uint32_t hd_en:1;
+        uint32_t sw_reset_old:1;
+        uint32_t reserved_12:1;
+        uint32_t sw_reset:1;
+        uint32_t reserved_14:1;
+        uint32_t lcl_loop_en:1;
+        uint32_t reserved_16_21:6;
+        uint32_t auto_config:1;
+        uint32_t cntl_frm_en:1;
+        uint32_t no_len_chk:1;
+        uint32_t rmt_loop_en:1;
+        uint32_t rx_err_disc:1;
+        uint32_t prbl_en:1;
+        uint32_t tx_pause_ignore:1;
+        uint32_t tx_rx_en:1;
+        uint32_t runt_filter_dis:1;
+        uint32_t reserved_31:1;
+    } fields;
+} BCM2838GenetUmacCmd;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t addr_3:8;
+        uint32_t addr_2:8;
+        uint32_t addr_1:8;
+        uint32_t addr_0:8;
+    } fields;
+} BCM2838GenetUmacMac0;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t addr_5:8;
+        uint32_t addr_4:8;
+        uint32_t reserved_16_31:16;
+    } fields;
+} BCM2838GenetUmacMac1;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t reg_data:16;
+        uint32_t reg_id:5;
+        uint32_t phy_id:5;
+        uint32_t wr:1;
+        uint32_t rd:1;
+        uint32_t rd_fail:1;
+        uint32_t start_busy:1;
+        uint32_t reserved_30_31:2;
+    } fields;
+} BCM2838GenetUmacMdioCmd;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t en:17;
+        uint32_t reserved_17_31:15;
+    } fields;
+} BCM2838GenetDmaRingCfg;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t en:1;
+        uint32_t ring_buf_en:17;
+        uint32_t reserved_18_19:2;
+        uint32_t tsb_swap_en:1;
+        uint32_t reserved_21_31:11;
+    } fields;
+} BCM2838GenetDmaCtrl;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t index:16;
+        uint32_t discard_cnt:16;
+    } fields;
+} BCM2838GenetDmaProdIndex;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t index:16;
+        uint32_t reserved_16_31:16;
+    } fields;
+} BCM2838GenetDmaConsIndex;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t disabled:1;
+        uint32_t desc_ram_init_busy:1;
+        uint32_t reserved_2_31:30;
+    } fields;
+} BCM2838GenetDmaStatus;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t overrun:1;
+        uint32_t crc_error:1;
+        uint32_t rxerr:1;
+        uint32_t no:1;
+        uint32_t lg:1;
+        uint32_t multicast:1;
+        uint32_t broadcast:1;
+        uint32_t reserved_7_11:5;
+        uint32_t wrap:1;
+        uint32_t sop:1;
+        uint32_t eop:1;
+        uint32_t own:1;
+        uint32_t buflength:12;
+        uint32_t reserved_28_31:4;
+    } fields;
+} BCM2838GenetRdmaLengthStatus;
+
 typedef struct {
     BCM2838GenetSysRevCtrl rev_ctrl;
     uint32_t port_ctrl;
@@ -131,6 +264,88 @@ typedef struct {
     uint8_t reserved_0x18[0xE8];
 } __attribute__((__packed__)) BCM2838GenetRegsTbuf;
 
+typedef struct {
+    uint8_t reserved_0x0[0x4];
+    uint32_t hd_bkp_ctrl;
+    BCM2838GenetUmacCmd cmd;
+    BCM2838GenetUmacMac0 mac0;
+    BCM2838GenetUmacMac1 mac1;
+    uint32_t max_frame_len;
+    uint32_t pause_quanta;
+    uint8_t reserved_0x1C[0x28];
+    uint32_t mode;
+    uint32_t frm_tag0;
+    uint32_t frm_tag1;
+    uint8_t reserved_0x50[0xC];
+    uint32_t tx_ipg_len;
+    uint8_t reserved_0x60[0x4];
+    uint32_t eee_ctrl;
+    uint32_t eee_lpi_timer;
+    uint32_t eee_wake_timer;
+    uint32_t eee_ref_count;
+    uint8_t reserved_0x74[0x4];
+    uint32_t rx_ipg_inv;
+    uint8_t reserved_0x7C[0x294];
+    uint32_t macsec_prog_tx_crc;
+    uint32_t macsec_ctrl;
+    uint8_t reserved_0x318[0x18];
+    uint32_t pause_ctrl;
+    uint32_t tx_flush;
+    uint32_t rx_fifo_status;
+    uint32_t tx_fifo_status;
+    uint8_t reserved_0x340[0xC0];
+    uint8_t mib[0x180];
+    uint32_t mib_ctrl;
+    uint8_t reserved_0x584[0x90];
+    BCM2838GenetUmacMdioCmd mdio_cmd;
+    uint8_t reserved_0x618[0x8];
+    uint32_t mpd_ctrl;
+    uint32_t mpd_pw_ms;
+    uint32_t mpd_pw_ls;
+    uint8_t reserved_0x62C[0xC];
+    uint32_t mdf_err_cnt;
+    uint8_t reserved_0x63C[0x14];
+    uint32_t mdf_ctrl;
+    uint32_t mdf_addr;
+    uint8_t reserved_0x658[0x1A8];
+} __attribute__((__packed__)) BCM2838GenetRegsUmac;
+
+typedef struct {
+    BCM2838GenetRdmaLengthStatus length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} __attribute__((__packed__)) BCM2838GenetRdmaDesc;
+
+typedef struct {
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    BCM2838GenetDmaProdIndex prod_index;
+    BCM2838GenetDmaConsIndex cons_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t xon_xoff_tresh;
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint8_t reserved_0x34[0xC];
+} __attribute__((__packed__)) BCM2838GenetRdmaRing;
+
+typedef struct {
+    BCM2838GenetRdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetRdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    BCM2838GenetDmaRingCfg ring_cfg;
+    BCM2838GenetDmaCtrl ctrl;
+    BCM2838GenetDmaStatus status;
+    uint32_t scb_burst_size;
+    uint8_t reserved_0x1050[0x1C];
+    uint32_t ring_timeout[17];
+    uint32_t index2ring[8];
+    uint8_t reserved_0x10D0[0xF30];
+} __attribute__((__packed__)) BCM2838GenetRegsRdma;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -143,6 +358,9 @@ typedef struct {
     uint8_t reserved_0x400[0x200];
     BCM2838GenetRegsTbuf tbuf;
     uint8_t reserved_0x700[0x100];
+    BCM2838GenetRegsUmac umac;
+    uint8_t reserved_0x1000[0x1000];
+    BCM2838GenetRegsRdma rdma;
 } __attribute__((__packed__)) BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.34.1


