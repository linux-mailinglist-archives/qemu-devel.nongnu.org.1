Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E67763823
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeXR-0003JJ-Vl; Wed, 26 Jul 2023 09:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWk-0002vL-AE; Wed, 26 Jul 2023 09:26:07 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWc-0003OM-Qt; Wed, 26 Jul 2023 09:26:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb960b7c9dso10818797e87.0; 
 Wed, 26 Jul 2023 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377954; x=1690982754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lc2M6SSGOLe8/z1uJflfjXaw5jgSfBX004uJV6n1TgA=;
 b=UsmQ4NwQ8ZI0XqKd96WTUFStddto/juiOwDY5m8U7Alz6/ZO6HQnnjHVgTiOMW9ICI
 qVjmz5Jh+c9HbdNHMtPXmkP0t9eGhQddbXNtaco1ovrRQ1D500HoxcGi6qk5SUncW7hD
 ozzIFqfy5eUC3a30LvJNaFfWGR5dEZF5OId8OIZ5Te5C/Rla9uc+m1am+7OWwNrplAOt
 6PMmhyYrF0ZofApAQYhRgbfgYOy3ZXHoQx5lX2RwA7i513UhR9Y5N0v9nZMILQxc2k0Y
 oIDrhpUdr+8mmEkmDl+FBTHkWqsuCKc+yTEft5vZDdaM9N2cCAl1rha0ygtzd6hYWTs0
 dj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377954; x=1690982754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lc2M6SSGOLe8/z1uJflfjXaw5jgSfBX004uJV6n1TgA=;
 b=VmcICrVBvFbYGABP3xQbPC91w8aw0N69OiB9/WqhpSnkjSA454wdXSgZnTymE0GCaY
 N+CmplDzCGdIO+4qKNqoM9KJ3hz6ULvSPflE+JvOtUclDGuKjAk71bTZQr1ANjTtMkyn
 ioWqHnPa/2TxYZSwwtDcASdbttUt7SephPPlQqjFx964T0Aj/SGHb7uu1XZqaxWqM+m5
 R0Ho7iOmWhxy7uksNBjexpjX2mZKFKtEC3aMn9N0uXZxTCE6MycXQwhi1C7IJUcLnLV+
 SqbD/kPRgVmPSNuRPCHjYZjER2oVjWGM1CjVhYLFuo4LMojSmVuuXNoPlXNE0WK16u11
 g0Qw==
X-Gm-Message-State: ABy/qLZnWFnxfMvyal5nXcqUCvlc/SrNylf8cZqEzlr/g5w9Usq7Temf
 7GuGtzpj7C9fAMDMxZWAk+mo3IElKrU=
X-Google-Smtp-Source: APBJJlH0UUunGqKIKZlSRuet/8w6D4QawKTNU1S7Nn+KOxC16F4AMcb0lMlb3qRZp5yFG2epXhOvjQ==
X-Received: by 2002:ac2:5e99:0:b0:4f9:5519:78b8 with SMTP id
 b25-20020ac25e99000000b004f9551978b8mr1336712lfq.63.1690377954498; 
 Wed, 26 Jul 2023 06:25:54 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:54 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 29/44] Impl GENET MDIO
Date: Wed, 26 Jul 2023 16:24:57 +0300
Message-Id: <20230726132512.149618-30-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x135.google.com
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
 hw/net/bcm2838_genet.c | 109 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 01e6819df4..e633323d17 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -47,6 +47,108 @@ static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
     qemu_set_irq(s->irq_prio, level);
 }
 
+static void bcm2838_genet_phy_aux_ctl_write(BCM2838GenetState *s,
+                                            uint16_t value)
+{
+    BCM2838GenetPhyAuxCtl phy_aux_ctl = {.value = value};
+    uint16_t *phy_aux_ctl_shd_reg_id
+        = (uint16_t *)&s->phy_aux_ctl_shd_regs + phy_aux_ctl.fields_1.reg_id;
+    uint16_t *phy_aux_ctl_shd_reg_id_mask
+        = (uint16_t *)&s->phy_aux_ctl_shd_regs + phy_aux_ctl.fields_1.reg_id_mask;
+
+    if (phy_aux_ctl.fields_1.reg_id_mask == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+        if (phy_aux_ctl.fields_1.reg_id == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+            if (phy_aux_ctl.fields_1.misc_wren == 0) {
+                /* write for subsequent read (8-bit from AUX_CTL_MISC) */
+                phy_aux_ctl.fields_1.reg_data = *phy_aux_ctl_shd_reg_id;
+            } else {
+                /* write 8 bits to AUX_CTL_MISC */
+                *phy_aux_ctl_shd_reg_id_mask = phy_aux_ctl.fields_1.reg_data;
+            }
+        } else {
+            /* write for subsequent read (12-bit) */
+            phy_aux_ctl.fields_2.reg_data = *phy_aux_ctl_shd_reg_id;
+        }
+    } else {
+        /* write 12 bits */
+        *phy_aux_ctl_shd_reg_id_mask = phy_aux_ctl.fields_2.reg_data;
+    }
+
+    s->phy_regs.aux_ctl.value = phy_aux_ctl.value;
+}
+
+static void bcm2838_genet_phy_shadow_write(BCM2838GenetState *s,
+                                           uint16_t value)
+{
+    BCM2838GenetPhyShadow phy_shadow = {.value = value};
+    uint16_t *phy_shd_reg
+        = (uint16_t *)&s->phy_shd_regs + phy_shadow.fields.reg_id;
+
+    if (phy_shadow.fields.wr == 0) {
+        phy_shadow.fields.reg_data = *phy_shd_reg;
+    } else {
+        *phy_shd_reg = phy_shadow.fields.reg_data;
+    }
+
+    s->phy_regs.shd.value = phy_shadow.value;
+}
+
+static void bcm2838_genet_phy_exp_shadow_write(BCM2838GenetState *s,
+                                               uint16_t value)
+{
+    /* TODO Stub implementation without side effect,
+            just storing registers values */
+    BCM2838GenetPhyExpSel* exp_ctrl = &s->phy_regs.exp_ctrl;
+    s->phy_exp_shd_regs.regs[exp_ctrl->block_id][exp_ctrl->reg_id] = value;
+}
+
+static uint16_t bcm2838_genet_phy_exp_shadow_read(BCM2838GenetState *s)
+{
+    BCM2838GenetPhyExpSel* exp_ctrl = &s->phy_regs.exp_ctrl;
+    return s->phy_exp_shd_regs.regs[exp_ctrl->block_id][exp_ctrl->reg_id];
+}
+
+static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
+{
+    BCM2838GenetUmacMdioCmd umac_mdio_cmd = {.value = cmd};
+    uint8_t phy_reg_id = umac_mdio_cmd.fields.reg_id;
+    uint16_t phy_reg_data = umac_mdio_cmd.fields.reg_data;
+    uint16_t *phy_reg = (uint16_t *)&s->phy_regs + phy_reg_id;
+    BCM2838GenetPhyBmcr phy_bmcr = {.value = phy_reg_data};
+
+    if (umac_mdio_cmd.fields.start_busy != 0) {
+        umac_mdio_cmd.fields.start_busy = 0;
+
+        if (umac_mdio_cmd.fields.rd != 0) {
+            if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                umac_mdio_cmd.fields.reg_data
+                    = bcm2838_genet_phy_exp_shadow_read(s);
+            } else {
+                umac_mdio_cmd.fields.reg_data = *phy_reg;
+            }
+        } else if (umac_mdio_cmd.fields.wr != 0) {
+            if (phy_reg_id == BCM2838_GENET_PHY_AUX_CTL) {
+                bcm2838_genet_phy_aux_ctl_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_PHY_SHD) {
+                bcm2838_genet_phy_shadow_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                bcm2838_genet_phy_exp_shadow_write(s, phy_reg_data);
+            } else {
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
+                    /* Initiate auto-negotiation once it has been restarted */
+                    if (phy_bmcr.fields.anrestart == 1) {
+                        phy_bmcr.fields.anrestart = 0;
+                        phy_reg_data = phy_bmcr.value;
+                    }
+                }
+                *phy_reg = phy_reg_data;
+            }
+        }
+    }
+
+    return umac_mdio_cmd.value;
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -134,10 +236,12 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             trace_bcm2838_genet_mac_address(ncs->info_str);
             break;
         case BCM2838_GENET_UMAC_MDIO_CMD:
+            value = bcm2838_genet_mdio_cmd(s, value);
+            s->regs.intrl0.stat.fields.mdio_done = 1;
+            break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP,
-                "UMAC MDIO and TDMA aren't implemented yet");
+            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
             break;
         default:
             break;
@@ -231,6 +335,7 @@ static void bcm2838_genet_reset(DeviceState *d)
 
     trace_bcm2838_genet_reset("done");
 
+    bcm2838_genet_set_qemu_mac(s);
     bcm2838_genet_phy_reset(s);
 }
 
-- 
2.34.1


