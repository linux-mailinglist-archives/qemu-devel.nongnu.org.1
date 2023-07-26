Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C37787639C1
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWu-00037Z-Q2; Wed, 26 Jul 2023 09:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWc-0002qh-Ku; Wed, 26 Jul 2023 09:25:59 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWY-0003MQ-Sm; Wed, 26 Jul 2023 09:25:57 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so10542485e87.2; 
 Wed, 26 Jul 2023 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377951; x=1690982751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPdZTmCIrme/QnBBrjhsf79S6kax7iTDj/A1vih6UL4=;
 b=fEA2UYx3WYfc9uiFlYtPoirlX4vSiNQ6QT7WdVAl883FuzrAYouLFSr8Tq/tpKVzkb
 zdZPYNNDdMV/5HK1PKTVO+KDbM1rdA4Vbh3i7XC7q6NXW8NpDjN/YHP2HQPtQcyptvkT
 +LHCnJPz/G1nMzFMqaTT2yKdxkc/WmUbth1p6bmIhuMCG8sNwFDkt8qthDiCxlfjcCBV
 B67iFdARn8tBcPYF78LiyoKfLAKSTFLPofA9jW4BwzCQpUgC80wXy4xrhKMQ4EzC5o33
 shzo73mCOok6k5DOE5blk+EWlm/buIH6v4KzY+T7pvRTm8jOElZExMsIZtDXILgbrYkf
 QoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377951; x=1690982751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPdZTmCIrme/QnBBrjhsf79S6kax7iTDj/A1vih6UL4=;
 b=dibgVlvSEJJVRFZcMN0eeLJsScnxxsBSXEmImOOeuFRhnPQ9Qk81HZafpEZ0lsDX8d
 g2FMlRb8MDgvuEnP7F2yly5tQBu/O+DoFYdGVm3JYRI1zlVgzowYOkrtSWlJ+3P7te4y
 fevPw0dOtjD+oWoGLZIemcky7XmnzmHFPgcVBl9NkS2tuH/xx69Ff+6gWTSeuVO0LvqU
 i7y4xYr6UrSKaapc1qknsGLngALTATDLHhttl/4TFdlaoFREcSq05DlyCGP2hkSTY0Lc
 tXinGnQ4b3yVqueqmGb7I8lVxOc/bI6Tedg69I+W1+bwd89Qp4a9F9x6kRrbP6gILV5l
 pvtA==
X-Gm-Message-State: ABy/qLabLz6Rl1hAg3e1G6eOoquIXqoU1EadDX89loXXi0hdqsShJWpm
 OGmyoflwcUyxmx+6gqAwVnJBGspo+fA=
X-Google-Smtp-Source: APBJJlH8XbMfkOJjSZiHfSZm9RDq3x2m583JKHJ8PAKxgEKqYrktmIaLkqafQr6hnOoRT+96TMYeNA==
X-Received: by 2002:a05:6512:6c4:b0:4fd:faa2:884c with SMTP id
 u4-20020a05651206c400b004fdfaa2884cmr1457804lff.29.1690377951103; 
 Wed, 26 Jul 2023 06:25:51 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:50 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 26/44] Add GENET register structs. Part 4
Date: Wed, 26 Jul 2023 16:24:54 +0300
Message-Id: <20230726132512.149618-27-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12c.google.com
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
 include/hw/net/bcm2838_genet.h | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 4cf70a17d3..4b549ed431 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define SIZEOF_FIELD(type, field)      sizeof(((type*) 0)->field)
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT \
+    (1u << (8 * SIZEOF_FIELD(BCM2838GenetPhyExpSel, block_id)))
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT \
+    (1u << (8 * SIZEOF_FIELD(BCM2838GenetPhyExpSel, reg_id)))
+
 typedef union {
     uint32_t value;
     struct {
@@ -568,6 +577,34 @@ typedef struct {
     uint16_t rdb_data;
 } __attribute__((__packed__)) BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} __attribute__((__packed__)) BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} __attribute__((__packed__)) BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} __attribute__((__packed__)) BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -579,6 +616,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


