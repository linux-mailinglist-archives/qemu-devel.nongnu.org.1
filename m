Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E810763814
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:52:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWs-00035a-HH; Wed, 26 Jul 2023 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWY-0002op-PI; Wed, 26 Jul 2023 09:25:56 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWU-0003KJ-Lk; Wed, 26 Jul 2023 09:25:53 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fba86f069bso10515923e87.3; 
 Wed, 26 Jul 2023 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377947; x=1690982747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nT/007Z4llBVr8xI5WSffpu4fUVxqfV0qsrvXIlQXA=;
 b=kgkZEo5KJmJoGir+RHUgnF1BPyY9LkNutu1S/l3Iw2zn2tcaVzfofJEvQ8QUw6VIWX
 qmFiCAEUapqjMRUW3j+hptPUtzEyyeG1j6UZ/E9jZ5tq0rySmOQlfOvH4Ev2uNnoK4FP
 HJFWLNUH5+ykh0BDnFnu3BeHkX4BH9Ow+lflEE6MBcMB65nqBdw8aNWPvvp4cXvjmYH4
 dWZl+4XcwCBr+kNaS74XgknDpm4Gn0lCvIDZvYbXokmQ+wKi0mlEZNVvPZjznCtpUhYk
 K0deeDW388ijnyD6EdQw/bM2OwbOyw1KXNfiyx4ttQ0tsb7tNCW6iT8lmCF46hZ07nHo
 UI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377947; x=1690982747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nT/007Z4llBVr8xI5WSffpu4fUVxqfV0qsrvXIlQXA=;
 b=FIOkJUVMoe66OACBtUy4eYmcusiu1jIBLx9wjU8ChogVwrup2pxL7NLuyvkld/uvWR
 gFWSxkEAj7/GUqHQDD4k01QtXr9nlGFd7hW0nK1QLktku22hlcuTHe7KmEEBN4Ufa33Q
 Ee4bwqDR+0wd4sb2QEHqtpFCjfWvCBkST+AYR6i/s8l7xHfl95IMaG/k+JAIzK047cQt
 g5eqIXVRviDH+IdqqDRRst6X3KXGAY2v39QqBygLughb3X3TjUfLW1sv9ekpr/lYf1Vo
 EjeSMp0Lav4jI/Mhn6hcr7zOfTB+oc2AUfrlz5sRY5bqxgQv9xqsqo0o9GU5sTXspQTI
 Zi8A==
X-Gm-Message-State: ABy/qLYK6lg+t3YMgX6Fj68jDw84fqyxqndwEzfHpOQoaKSQYxrmHXWl
 mI2jZUKWGTPtckaurXEeJR78OjwDGO8=
X-Google-Smtp-Source: APBJJlFYZgime/SsPolBP3XJyOp9JZ9LkqB6gYtMAN2dLFQQ+/enZUUjFOafK4iEqhwsrrFv07+8kg==
X-Received: by 2002:ac2:58ca:0:b0:4fb:8bcd:acd4 with SMTP id
 u10-20020ac258ca000000b004fb8bcdacd4mr1106649lfo.37.1690377946880; 
 Wed, 26 Jul 2023 06:25:46 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:46 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 23/44] Add GENET register structs. Part 1
Date: Wed, 26 Jul 2023 16:24:51 +0300
Message-Id: <20230726132512.149618-24-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12a.google.com
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
 include/hw/net/bcm2838_genet.h | 125 ++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index f62b24fa2f..89b45eb39f 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,8 +18,131 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t gphy_rev:16;
+        uint32_t minor_rev:4;
+        uint32_t reserved_20_23:4;
+        uint32_t major_rev:4;
+        uint32_t reserved_28_31:4;
+    } fields;
+} BCM2838GenetSysRevCtrl;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t scb:1;
+        uint32_t ephy:1;
+        uint32_t phy_det_r:1;
+        uint32_t phy_det_f:1;
+        uint32_t link_up:1;
+        uint32_t link_down:1;
+        uint32_t umac:1;
+        uint32_t umac_tsv:1;
+        uint32_t tbuf_underrun:1;
+        uint32_t rbuf_overflow:1;
+        uint32_t hfb_sm:1;
+        uint32_t hfb_mm:1;
+        uint32_t mpd_r:1;
+        uint32_t rxdma_mbdone:1;
+        uint32_t rxdma_pdone:1;
+        uint32_t rxdma_bdone:1;
+        uint32_t txdma_mbdone:1;
+        uint32_t txdma_pdone:1;
+        uint32_t txdma_bdone:1;
+        uint32_t reserved_19_22:4;
+        uint32_t mdio_done:1;
+        uint32_t mdio_error:1;
+        uint32_t reserved_25_31:7;
+    } fields;
+} BCM2838GenetIntrl0;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t tx_intrs:16;
+        uint32_t rx_intrs:16;
+    } fields;
+} BCM2838GenetIntrl1;
+
+typedef struct {
+    BCM2838GenetSysRevCtrl rev_ctrl;
+    uint32_t port_ctrl;
+    uint32_t rbuf_flush_ctrl;
+    uint32_t tbuf_flush_ctrl;
+    uint8_t reserved_0x10[0x30];
+} __attribute__((__packed__)) BCM2838GenetRegsSys;
+
+typedef struct {
+    uint8_t reserved_0x0[0x40];
+} __attribute__((__packed__)) BCM2838GenetRegsGrBridge;
+
+typedef struct {
+    uint32_t pwr_mgmt;
+    uint8_t reserved_0x4[0x8];
+    uint32_t rgmii_oob_ctrl;
+    uint8_t reserved_0x10[0xC];
+    uint32_t gphy_ctrl;
+    uint8_t reserved_0x20[0x60];
+} __attribute__((__packed__)) BCM2838GenetRegsExt;
+
+typedef struct {
+    BCM2838GenetIntrl0 stat;
+    BCM2838GenetIntrl0 set;
+    BCM2838GenetIntrl0 clear;
+    BCM2838GenetIntrl0 mask_status;
+    BCM2838GenetIntrl0 mask_set;
+    BCM2838GenetIntrl0 mask_clear;
+    uint8_t reserved_0x18[0x28];
+} __attribute__((__packed__)) BCM2838GenetRegsIntrl0;
+
+typedef struct {
+    BCM2838GenetIntrl1 stat;
+    BCM2838GenetIntrl1 set;
+    BCM2838GenetIntrl1 clear;
+    BCM2838GenetIntrl1 mask_status;
+    BCM2838GenetIntrl1 mask_set;
+    BCM2838GenetIntrl1 mask_clear;
+    uint8_t reserved_0x18[0x28];
+} __attribute__((__packed__)) BCM2838GenetRegsIntrl1;
+
+typedef struct {
+    uint32_t ctrl;
+    uint8_t reserved_0x4[0x8];
+    uint32_t status;
+    uint8_t reserved_0x10[0x4];
+    uint32_t chk_ctrl;
+    uint8_t reserved_0x18[0x7C];
+    uint32_t ovfl_cnt;
+    uint32_t err_cnt;
+    uint32_t energy_ctrl;
+    uint8_t reserved_0xA0[0x14];
+    uint32_t size_ctrl;
+    uint8_t reserved_0xB8[0x48];
+} __attribute__((__packed__)) BCM2838GenetRegsRbuf;
+
+typedef struct {
+    uint32_t ctrl;
+    uint8_t reserved_0x4[0x8];
+    uint32_t bp_mc;
+    uint8_t reserved_0x10[0x4];
+    uint32_t energy_ctrl;
+    uint8_t reserved_0x18[0xE8];
+} __attribute__((__packed__)) BCM2838GenetRegsTbuf;
+
 typedef struct {
-    uint8_t stub_area[0x10000]; /* temporary stub */
+    BCM2838GenetRegsSys sys;
+    BCM2838GenetRegsGrBridge gr_bridge;
+    BCM2838GenetRegsExt ext;
+    uint8_t reserved_0x100[0x100];
+    BCM2838GenetRegsIntrl0 intrl0;
+    BCM2838GenetRegsIntrl1 intrl1;
+    uint8_t reserved_0x280[0x80];
+    BCM2838GenetRegsRbuf rbuf;
+    uint8_t reserved_0x400[0x200];
+    BCM2838GenetRegsTbuf tbuf;
+    uint8_t reserved_0x700[0x100];
 } __attribute__((__packed__)) BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.34.1


