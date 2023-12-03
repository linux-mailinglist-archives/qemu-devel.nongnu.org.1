Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5448F802835
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:55:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLY-0003IC-Ad; Sun, 03 Dec 2023 16:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLU-0003Ey-6q; Sun, 03 Dec 2023 16:49:48 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLS-0008Oo-No; Sun, 03 Dec 2023 16:49:47 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso1310107276.2; 
 Sun, 03 Dec 2023 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640185; x=1702244985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m35zG+ajLJL60pM6bIM9adMNO13lGgmKjK7XnKNpmk8=;
 b=HIkhdJ1zLqvjPPW+3hYfDArLY5byquUfpfxgFeNWjroc5N/VbySEXk3s65qCjX87mM
 nN6s7q4lCLcotgzene654MErf9BzRB4E5xtHD7cFL8ZJ6QvTd4DVO4v/3CFBVXEuEzR4
 gfkS8fNwfbgvRU/TRKyPSz7tlKfiDxFaslHkfEuR7sbjD82hgB11B3BiVbRaZ/vbX7yq
 zlzfXiSEHw35teLCi8VZ0S+4uOI79QmaS3P2OpHhmcaB3/fIQsvf1uXg/COICngnFX7L
 lUwNfpGC50T15eEGlzaLimMHWt0A/hIa+lXb1ZvXGITVBS+Q45iWfOG8wLgNeYKusoy4
 5a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640185; x=1702244985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m35zG+ajLJL60pM6bIM9adMNO13lGgmKjK7XnKNpmk8=;
 b=ZQYTpEDp7XTdvIGN3Bm/nBXk2zjykMK67Yf0mq72hMz6zp1tLBoHiAFZtT9h0RrnwS
 69dcMB2vj4xvFOSVZ3fNHfZnf+lMFAlK/8CcVuLfMiVuMHF0wtmuYQXkOneTV7BddI2C
 AEQi/JI9tylMeLIroxkLCRgNA7vPpkJqUsKouU37oyUJts5vNojc5/Nb67jK9pCMR4L+
 9HGK7BxesAWLvkMh0fyZhVeCEStOgWgbLgQaHhzJVyVCiImGBd1xLELov0qAasqGR6/1
 ab2Ktqwp6JHW00EbHk3TAV8ax8StJ+97TYqgqyCzK9tzDdc8tgB2dsSMLOeWuT7I5VjM
 DpxQ==
X-Gm-Message-State: AOJu0Yxd7DS39Wn7zYMKQa+Ehtoj6DqJdbSHKGnvi/YCkJCYubUVVUth
 ypMlKXmBsT/cKUxZV+vzPnoBI5QCtAwbhg==
X-Google-Smtp-Source: AGHT+IG3jhbNyyx2/TB/PpOopoHVtkx6ze3hvFgtFsmdpR55+fEh0FnM18zhEn6bUU3I3tmrEg7r7g==
X-Received: by 2002:a81:4c4a:0:b0:5c5:d898:e476 with SMTP id
 z71-20020a814c4a000000b005c5d898e476mr691982ywa.33.1701640184999; 
 Sun, 03 Dec 2023 13:49:44 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:44 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 26/45] Add GENET register structs. Part 4
Date: Sun,  3 Dec 2023 15:48:51 -0600
Message-Id: <20231203214910.1364468-27-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-26-sergey.kambalin@auriga.com>
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
 <20231203214910.1364468-26-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb2d.google.com
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
 include/hw/net/bcm2838_genet.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 1bd004785a..94c2f3ebca 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -273,6 +279,34 @@ typedef struct {
     uint16_t rdb_data;
 } BCM2838GenetPhyRegs;
 
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
+} BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -284,6 +318,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


