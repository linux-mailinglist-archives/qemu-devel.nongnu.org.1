Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766BA2B4DE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 23:13:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6v-0005q1-U8; Thu, 06 Feb 2025 17:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xDOlZwgKCgU1zmftyxmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6k-0005eH-Lx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:28 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xDOlZwgKCgU1zmftyxmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6h-0001Ro-G1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:26 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f9fbe0215bso3130880a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879940; x=1739484740; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ODQOf6P0G6BAbndAM0dAbeD41I+TYA8HzSXWvwyTAB8=;
 b=Zq6SHBbtC4GT+Q+d2yWcBKrOeD52jQftF6kN4XOkSCJ88Hl3hGWG6jILFVNs2a3PRh
 gIF3IW5JU99SkHGSFb5l+5S/92GjU5f3ZTyMgHoYfhC0iKZDDYmsq2Gj7ZjoZw3ueGAW
 ZhijxcPGaupQ2Eqty05ELXxz4/WyEAITBDec+CYA3dzgI1A406JLg0EkfYhqFm5dEIzo
 I6SDANOa71k/d/dAQ7Q8R0+Xm8LL9OPKpOfUG5Vfvc5h4czKNLg2vDmJbQNwCKHF1+DL
 Zw6N9vY1OjzLSE+CjrNYwFUx+IdoWP6Yt4YCZgF5iGhANVPTmchunuXR7EMmWy1bfPEe
 LNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879940; x=1739484740;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODQOf6P0G6BAbndAM0dAbeD41I+TYA8HzSXWvwyTAB8=;
 b=MQtEB/zKSJQebBa/DHkY3cn7KCsWueBrgEsSTAYyUBDAABnMzeHw0TuLD+nbqobFVv
 UgjoJSYBFzjYsIEAY4pB6WHIEsu5Sy5jbZSsf+quQJGytYSg2s6R4fHISZNNa5lVdXzn
 FIkietm6TOPE7dGXvvPoJNYWebH4V/k9rtuzgTGXhT85YGfOS3T4aGlXjasoCb7eEtYe
 6pwsWQi0t1urYqxtet/cTxtGeAC+zLJXZs3Lvv7HO/xZg9kpzsXR7TZLhLVBYWga5e48
 AGtw3pfMIJISG8TGUPiOrySYJsbJJ3YBqjUBRocEQJGJou0J3Z9KuxNpKApr42/ji578
 +crQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaC67A3+wRLnW2wuapKwcJc2FIDtfeQbY3KpvU8mmIE3F9/vcGJMv3g4xF3mIqwjtZm9JFl+p0iL+J@nongnu.org
X-Gm-Message-State: AOJu0YzA23IU6voNYcnvrCg9v9mFKii/OPlnErJA3dMFCf4BGdfeKgsB
 Z3qLOgtbU/Oc4Go/NCB2PGcUonVQWOW3/Rw3V/SrrMICen366BpveeJMArY+4JsIZqjZuuNkeIG
 VR8lnT4DOYA==
X-Google-Smtp-Source: AGHT+IGEMd6DIbXkzuWZCQkZ55LahPMAvVvlAxjeGnH9fEyzRSZvVREswP0Wy/xCmqQnVMgta0t9E8UBn82JZQ==
X-Received: from pji14.prod.google.com ([2002:a17:90b:3fce:b0:2f4:47fc:7f17])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2303:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2fa2417c0f9mr1163870a91.20.1738879940302; 
 Thu, 06 Feb 2025 14:12:20 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:54 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-9-wuhaotsh@google.com>
Subject: [PATCH v4 08/17] hw/misc: Store DRAM size in NPCM8XX GCR Module
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3xDOlZwgKCgU1zmftyxmlttlqj.htrvjrz-ij0jqstslsz.twl@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NPCM8XX boot block stores the DRAM size in SCRPAD_B register in GCR
module. Since we don't simulate a detailed memory controller, we
need to store this information directly similar to the NPCM7XX's
INCTR3 register.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c         | 24 ++++++++++++++++++++++++
 include/hw/misc/npcm_gcr.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index fe6e332de7..7cdea2e392 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -280,6 +280,19 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
+static void npcm8xx_gcr_enter_reset(Object *obj, ResetType type)
+{
+    NPCMGCRState *s = NPCM_GCR(obj);
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
+
+    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
+    /* These 3 registers are at the same location in both 7xx and 8xx. */
+    s->regs[NPCM8XX_GCR_PWRON] = s->reset_pwron;
+    s->regs[NPCM8XX_GCR_MDLR] = s->reset_mdlr;
+    s->regs[NPCM8XX_GCR_INTCR3] = s->reset_intcr3;
+    s->regs[NPCM8XX_GCR_SCRPAD_B] = s->reset_scrpad_b;
+}
+
 static void npcm_gcr_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
@@ -323,6 +336,14 @@ static void npcm_gcr_realize(DeviceState *dev, Error **errp)
      * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
      */
     s->reset_intcr3 |= ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;
+
+    /*
+     * The boot block starting from 0.0.6 for NPCM8xx SoCs stores the DRAM size
+     * in the SCRPAD2 registers. We need to set this field correctly since
+     * the initialization is skipped as we mentioned above.
+     * https://github.com/Nuvoton-Israel/u-boot/blob/npcm8mnx-v2019.01_tmp/board/nuvoton/arbel/arbel.c#L737
+     */
+    s->reset_scrpad_b = dram_size;
 }
 
 static void npcm_gcr_init(Object *obj)
@@ -370,16 +391,19 @@ static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
 
     c->nr_regs = NPCM7XX_GCR_NR_REGS;
     c->cold_reset_values = npcm7xx_cold_reset_values;
+    rc->phases.enter = npcm7xx_gcr_enter_reset;
 }
 
 static void npcm8xx_gcr_class_init(ObjectClass *klass, void *data)
 {
     NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NPCM8xx System Global Control Registers";
     c->nr_regs = NPCM8XX_GCR_NR_REGS;
     c->cold_reset_values = npcm8xx_cold_reset_values;
+    rc->phases.enter = npcm8xx_gcr_enter_reset;
 }
 
 static const TypeInfo npcm_gcr_info[] = {
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 9ac76ca9ab..d81bb9afb2 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -68,6 +68,7 @@ typedef struct NPCMGCRState {
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
+    uint32_t reset_scrpad_b;
 } NPCMGCRState;
 
 typedef struct NPCMGCRClass {
-- 
2.48.1.502.g6dc24dfdaf-goog


