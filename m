Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8191B5D7
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 06:55:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3cy-0008Hu-Vl; Fri, 28 Jun 2024 00:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cV-0008Gt-52
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cL-0000yR-Jp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:53:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-424ad289949so1693045e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550427; x=1720155227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYEYJ2Wwx71dNKsAcy31SFsnrP/uSxrEAbuXlnudJVY=;
 b=NvKkGR4dZX69TRUprAurmT7zjgRF6itDIG4N8cZ6Fdb7fj/nmB7WmjWK5Qcf3GueMr
 TPKisfaQDmPcTI9IncGWzZhsDDpjhisWfhdFWGTjYPVcjZPe5tIO1OfPSFPB8bQGPH8h
 4KmF8SvYAdrvCjtUhfbYCJ+2MQPVKjoNBvcm1sEnzBAVLAbFRN+SpAvDoFqY3sVQkRBM
 N9dT5NvzThcD4Ssleif91C3O9/hGM6DbxWVcqDicaiUS5rw2edgvAUtTj1F3ybeEwCuE
 wLVHJJOoEUG/yry7oudRVg+EI54AQYyt0G+qIj07lpIcaqsEm2xBi/8+7Iiz6J9muwIA
 AGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550427; x=1720155227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYEYJ2Wwx71dNKsAcy31SFsnrP/uSxrEAbuXlnudJVY=;
 b=vOOQvWFvDQyA75KxdiMQTy69OAzVnyijTvqAzvguzTy9rjDlhNzx+/Dm2TVyC75X/B
 qFwNBtVmKxDrg0GMjZnMHrzzs9a3sixrsUJ7oCvivk2w2N6u4qur272EnNKU/UfYp3U+
 TVk43w++9CdmEh5Se6U79yqGeZ6gRjFhu9/x3H6ezXrV5tQvS3zFTPHCVo6B082uQAzp
 Ci0iQMgbjUb8xBgPk3lz1Ypl0m8FoaSVMH0bneSqNlRp2jV3ZrNgFFvpdDmzmbBpYfj+
 Ockr/G/4meCVG4CCYfYsNpVVGuUa0IIeCwsnChQzSYKvAySYyiRotd+jyXbG9GNo8Woc
 u/kQ==
X-Gm-Message-State: AOJu0YzuFilUbyx/SSE59d2G4rSNOBLcVzXVYvSylii2TR0RuaVF3yaO
 exadjFANEMB0NkBLykcpUiHK6SNXdlfY/dvGfb/SnJQYPwyeWRgOLxzw+79RbUKkrYQGlrxC0SM
 90xZAEA==
X-Google-Smtp-Source: AGHT+IF2wuR/EsTUKhqwrXuCXID6JTSa05iGcVduS3p6PIItAp+gB+5A9DPsB9AKT/9iM3ekks4VEQ==
X-Received: by 2002:a05:600c:1c90:b0:424:eeca:6bd0 with SMTP id
 5b1f17b1804b1-424eeca6c69mr42766655e9.13.1719550427208; 
 Thu, 27 Jun 2024 21:53:47 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0676a3sm17725975e9.28.2024.06.27.21.53.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:53:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/12] hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND handler
 (ACMD41)
Date: Fri, 28 Jun 2024 06:53:16 +0200
Message-ID: <20240628045323.86308-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 82 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cd207a3090..167e1c517a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1704,6 +1704,50 @@ static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* ACMD41 */
+static sd_rsp_type_t sd_acmd_SD_APP_OP_COND(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_idle_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    /*
+     * If it's the first ACMD41 since reset, we need to decide
+     * whether to power up. If this is not an enquiry ACMD41,
+     * we immediately report power on and proceed below to the
+     * ready state, but if it is, we set a timer to model a
+     * delay for power up. This works around a bug in EDK2
+     * UEFI, which sends an initial enquiry ACMD41, but
+     * assumes that the card is in ready state as soon as it
+     * sees the power up bit set.
+     */
+    if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
+        if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
+            timer_del(sd->ocr_power_timer);
+            sd_ocr_powerup(sd);
+        } else {
+            trace_sdcard_inquiry_cmd41();
+            if (!timer_pending(sd->ocr_power_timer)) {
+                timer_mod_ns(sd->ocr_power_timer,
+                             (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                              + OCR_POWER_DELAY_NS));
+            }
+        }
+    }
+
+    if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
+        /*
+         * We accept any voltage.  10000 V is nothing.
+         *
+         * Once we're powered up, we advance straight to ready state
+         * unless it's an enquiry ACMD41 (bits 23:0 == 0).
+         */
+        sd->state = sd_ready_state;
+    }
+
+    return sd_r3;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1812,43 +1856,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     }
 
     switch (req.cmd) {
-    case 41:  /* ACMD41: SD_APP_OP_COND */
-        if (sd->state != sd_idle_state) {
-            break;
-        }
-        /* If it's the first ACMD41 since reset, we need to decide
-         * whether to power up. If this is not an enquiry ACMD41,
-         * we immediately report power on and proceed below to the
-         * ready state, but if it is, we set a timer to model a
-         * delay for power up. This works around a bug in EDK2
-         * UEFI, which sends an initial enquiry ACMD41, but
-         * assumes that the card is in ready state as soon as it
-         * sees the power up bit set. */
-        if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
-            if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
-                timer_del(sd->ocr_power_timer);
-                sd_ocr_powerup(sd);
-            } else {
-                trace_sdcard_inquiry_cmd41();
-                if (!timer_pending(sd->ocr_power_timer)) {
-                    timer_mod_ns(sd->ocr_power_timer,
-                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
-                                  + OCR_POWER_DELAY_NS));
-                }
-            }
-        }
-
-        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
-            /* We accept any voltage.  10000 V is nothing.
-             *
-             * Once we're powered up, we advance straight to ready state
-             * unless it's an enquiry ACMD41 (bits 23:0 == 0).
-             */
-            sd->state = sd_ready_state;
-        }
-
-        return sd_r3;
-
     case 42:  /* ACMD42: SET_CLR_CARD_DETECT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2379,6 +2386,7 @@ static const SDProto sd_proto_sd = {
         [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
         [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
         [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
+        [41] = {8,  sd_bcr,  "SD_APP_OP_COND", sd_acmd_SD_APP_OP_COND},
     },
 };
 
-- 
2.41.0


