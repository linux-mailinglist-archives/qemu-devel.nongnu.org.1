Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3945802827
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:54:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLb-0003QX-Lw; Sun, 03 Dec 2023 16:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLX-0003IM-84; Sun, 03 Dec 2023 16:49:52 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLV-0008PX-F6; Sun, 03 Dec 2023 16:49:50 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d3d5b10197so28817077b3.2; 
 Sun, 03 Dec 2023 13:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640188; x=1702244988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0plx2CSfyD/hqodRTCcCQxsf1hkYu3FpLFu5vV8rvY=;
 b=awbbiEFAU+yX6eg1aX54W+0oiVuuOs8y1wZxuSSOZ1+vU6Nk9MVsOlm/NcW4uncoFL
 Uy/cvI+nqVMR5aFtLPmVNgDC6XBsVQlWy6mdHRe2jWB9qcg+ksOQ78fflPuXUhw7NlgR
 Rsw8Gfp5kAZkREb+SHqji6CP249qJv+NvhG5ZsAQWV14HIv3N57gZyRW7As7RKIER8ZA
 5p9eOweco2TWcUtuVPfaHzx2azkAF8iLQaJvKqmKk4Ypil6ZTTs4qoMOSKNrEHp7zPDf
 DjdF0g4ejcHSY566xc25YY3iuJzHIgwZJucQS6aR0iky8tR6/RUHohFu/7F3eX0MHlLz
 +dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640188; x=1702244988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0plx2CSfyD/hqodRTCcCQxsf1hkYu3FpLFu5vV8rvY=;
 b=xRiS1W9w+co3aePw0RwXcR6XdzR8/ZUOL34FO7RCUGe6Zjq9pFBnIPu4ws1qNgWIi3
 fF9/+OYEoEsqA8Cam5uO6J1QWiHC2Jsoo0tgzRvejsHSyTJdabOMphar+856RHAFLIpF
 g+/nspMyozy1sJMzuHTvJlRGk9xneNNRXfqt8q+q/q2AiSTl/KRPIjumnwWJ22uhRao4
 TdqtKDuztH4TNukNJg9KsbGi5/KsFGFu8sCR/AmEyZypjaspOYndb91mzbiJLbSp6OxC
 5ZedajLsNoyCPBL54dInsJX5SXgxtl9wvhwXrgzsr+52wcDxG1QCWomewkttZJJAd4rP
 V5eQ==
X-Gm-Message-State: AOJu0YzWRraCSxdkR7zYqfz2fql+1BPbTD5+Enrcd59DX7RGICG5H91j
 UYpLDrHh4whB00y7D2RMix6rY6DKuF62LA==
X-Google-Smtp-Source: AGHT+IH6chicG0c1YERomY8j02PTJmIZ3jDg9Utx19WS51ZRTYY3ou6RKbH5cvFpbRfdyT6OtzK4hA==
X-Received: by 2002:a81:a10f:0:b0:5d7:1941:ac7 with SMTP id
 y15-20020a81a10f000000b005d719410ac7mr2276638ywg.98.1701640187950; 
 Sun, 03 Dec 2023 13:49:47 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:47 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 29/45] Implement GENET MDIO
Date: Sun,  3 Dec 2023 15:48:54 -0600
Message-Id: <20231203214910.1364468-30-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-29-sergey.kambalin@auriga.com>
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
 <20231203214910.1364468-27-sergey.kambalin@auriga.com>
 <20231203214910.1364468-28-sergey.kambalin@auriga.com>
 <20231203214910.1364468-29-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1134.google.com
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
 hw/net/bcm2838_genet.c         | 126 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   3 +-
 2 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 56ff6a6f39..1fae3ecbc2 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -213,6 +213,7 @@ FIELD(GENET_PHY_STAT_1000, LOCALRXOK, 13, 1)
 FIELD(GENET_PHY_STAT_1000, MSRES,     14, 1)
 FIELD(GENET_PHY_STAT_1000, MSFAIL,    15, 1)
 
+/* There are two data representations for PHY_AUX_CTRL register */
 REG16(GENET_PHY_AUX_CTRL_0,              0)
 FIELD(GENET_PHY_AUX_CTRL_0, REG_ID_MASK, 0, 3)
 FIELD(GENET_PHY_AUX_CTRL_0, RSVD_3,      3, 1)
@@ -269,6 +270,123 @@ static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
     qemu_set_irq(s->irq_prio, level);
 }
 
+static void bcm2838_genet_phy_aux_ctl_write(BCM2838GenetState *s,
+                                            uint16_t value)
+{
+    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID);
+    uint16_t reg_id_mask = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID_MASK);
+    uint16_t misc_wren = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, MISC_WREN);
+    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_DATA);
+    uint16_t reg_data12 = FIELD_EX16(value, GENET_PHY_AUX_CTRL_1, REG_DATA);
+
+    uint16_t *phy_aux_ctl_shd_reg_id = (uint16_t *)&s->phy_aux_ctl_shd_regs + reg_id;
+    uint16_t *phy_aux_ctl_shd_reg_id_mask = (uint16_t *)&s->phy_aux_ctl_shd_regs + reg_id_mask;
+
+    if (reg_id_mask == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+        if (reg_id == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+            if (misc_wren == 0) {
+                /* write for subsequent read (8-bit from AUX_CTL_MISC) */
+                FIELD_DP16(value, GENET_PHY_AUX_CTRL_0, REG_DATA, *phy_aux_ctl_shd_reg_id);
+            } else {
+                /* write 8 bits to AUX_CTL_MISC */
+                *phy_aux_ctl_shd_reg_id_mask = reg_data;
+            }
+        } else {
+            /* write for subsequent read (12-bit) */
+            FIELD_DP16(value, GENET_PHY_AUX_CTRL_1, REG_DATA, *phy_aux_ctl_shd_reg_id);
+        }
+    } else {
+        /* write 12 bits */
+        *phy_aux_ctl_shd_reg_id_mask = reg_data12;
+    }
+
+    s->phy_regs.aux_ctl = value;
+}
+
+static void bcm2838_genet_phy_shadow_write(BCM2838GenetState *s,
+                                           uint16_t value)
+{
+    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_SHADOW, REG_ID);
+    uint16_t wr = FIELD_EX16(value, GENET_PHY_SHADOW, WR);
+    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_SHADOW, REG_DATA);
+
+    uint16_t *phy_shd_reg = (uint16_t *)&s->phy_shd_regs + reg_id;
+
+    if (wr == 0) {
+        FIELD_DP16(value, GENET_PHY_SHADOW, REG_DATA, *phy_shd_reg);
+    } else {
+        *phy_shd_reg = reg_data;
+    }
+
+    s->phy_regs.shd = value;
+}
+
+static void bcm2838_genet_phy_exp_shadow_write(BCM2838GenetState *s,
+                                               uint16_t value)
+{
+    /* TODO Stub implementation without side effect,
+            just storing registers values */
+    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                 GENET_PHY_EXP_SEL, REG_ID);
+    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                   GENET_PHY_EXP_SEL, BLOCK_ID);
+
+    s->phy_exp_shd_regs.regs[block_id][reg_id] = value;
+}
+
+static uint16_t bcm2838_genet_phy_exp_shadow_read(BCM2838GenetState *s)
+{
+    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                 GENET_PHY_EXP_SEL, REG_ID);
+    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                   GENET_PHY_EXP_SEL, BLOCK_ID);
+
+    return s->phy_exp_shd_regs.regs[block_id][reg_id];
+}
+
+static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
+{
+    uint32_t phy_reg_id = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, REG_ID);
+    uint32_t phy_reg_data = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA);
+    uint32_t start_busy = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, START_BUSY);
+    uint32_t rd = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, RD);
+    uint32_t wr = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, WR);
+    uint16_t *phy_reg = (uint16_t *)&s->phy_regs + phy_reg_id;
+
+    uint16_t anrestart = FIELD_EX16(phy_reg_data, GENET_PHY_BMCR, ANRESTART);
+
+    if (start_busy != 0) {
+        cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, START_BUSY, 0);
+
+        if (rd != 0) {
+            if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA,
+                                 bcm2838_genet_phy_exp_shadow_read(s));
+            } else {
+                cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA, *phy_reg);
+            }
+        } else if (wr != 0) {
+            if (phy_reg_id == BCM2838_GENET_PHY_AUX_CTL) {
+                bcm2838_genet_phy_aux_ctl_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_PHY_SHD) {
+                bcm2838_genet_phy_shadow_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                bcm2838_genet_phy_exp_shadow_write(s, phy_reg_data);
+            } else {
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
+                    /* Initiate auto-negotiation once it has been restarted */
+                    if (anrestart == 1) {
+                        FIELD_DP16(phy_reg_data, GENET_PHY_BMCR, ANRESTART, 0);
+                    }
+                }
+                *phy_reg = phy_reg_data;
+            }
+        }
+    }
+
+    return cmd;
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -353,10 +471,13 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             trace_bcm2838_genet_mac_address(ncs->info_str);
             break;
         case BCM2838_GENET_UMAC_MDIO_CMD:
+            value = bcm2838_genet_mdio_cmd(s, value);
+            s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                             GENET_INTRL_0, MDIO_DONE, 1);
+            break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP,
-                "UMAC MDIO and TDMA aren't implemented yet");
+            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
             break;
         default:
             break;
@@ -452,6 +573,7 @@ static void bcm2838_genet_reset(DeviceState *d)
 
     trace_bcm2838_genet_reset("done");
 
+    bcm2838_genet_set_qemu_mac(s);
     bcm2838_genet_phy_reset(s);
 }
 
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index b9d6d35cce..7a483bd265 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -101,7 +101,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_EXP_DATA          BCM2838_GENET_PHY_REG(exp_data)
 #define BCM2838_GENET_EXP_SEL           BCM2838_GENET_PHY_REG(exp_ctrl)
 
-#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_AUXCTL    0x0
+#define BCM2838_GENET_PHY_AUX_CTL_MISC      0x7
 #define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
 
 #define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
-- 
2.34.1


