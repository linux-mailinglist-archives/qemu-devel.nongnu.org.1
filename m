Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCEE82A507
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:44:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNiE0-0007XE-Ls; Wed, 10 Jan 2024 18:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fSufZQwKCoQvijqpm01mnivowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--nabihestefan.bounces.google.com>)
 id 1rNiDo-0007VQ-3G
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:56 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fSufZQwKCoQvijqpm01mnivowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--nabihestefan.bounces.google.com>)
 id 1rNiDm-0006fe-9a
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 18:42:55 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5e73bd9079eso88430297b3.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704930173; x=1705534973; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oAHRpxv+fB7+yiYSPtPuRU5upd4MhVK+1G8Q0VdrAns=;
 b=DNi8HYoZL2Mms/tYGm/C8Rv6zXFpZ6etb/KOskGwzV9617ODuBs9WVyewY3PXi3ubS
 iioPJEYGB9Ciu6ba8sG1qp6iYxsU0PY14fDwCxIbAlhptnufJgtBnC9WEd9Ma5pyttb2
 tHl48juhW+gbgncHYO2qKARuyvBC4NfjMIc004Xhr91JRQF+bhGqgzSN2fIINvbnBnLA
 9ZvkeF/Kdj7j7/sJ7n37Tku/EoLse86HGq71ke+eT4agBa1zUt/irLMb35mz3fhLbWzK
 1du//P6nhQaUDaTt5G5gG6wKb+MFoHwvi+Arx+a1FR9YQEBjHNV5PMZp7zu8IRV7mFCG
 7ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704930173; x=1705534973;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAHRpxv+fB7+yiYSPtPuRU5upd4MhVK+1G8Q0VdrAns=;
 b=Q8wMOmvSGTkPB4RDWriyHGHLYpinjmcQmOa7y82iDJ5r7BuYnrNPXXqhXlOnSv3SV/
 E660GB0xDJju6CCayXXHvUt1dxZRmHThco8bIMN4Kp5MlEJb/Wqnhhl+1lK8Eh/pNTVK
 CQuu9ex7w/ovfy7RW32wA4zJjNBITxuZpTyVB5/WX8gXV1gelHyIHyikgiSWL2gUdZCu
 f9BcIICbDQx0y8VlFzn9apFM3EmboFGPKhQq3YuyZBPsFq+wj0z1m4yByEjx1jOYdizX
 bPfBxQFcLq6fYxBdZFyPRVtZeOa3/8PNCllM4ug9YvbLCHhFeGyqZDGfaDtPr/yTj4e4
 Hwzg==
X-Gm-Message-State: AOJu0YzZ33PlMNXxJoDnZUB/dJQy3e6ASvEW7UNbvx9J3ht7m2s0riJg
 zMb8y7jeiz9JGV/WLl15Xt9xOM+Am5deJg7MNRZeMVZ7xg==
X-Google-Smtp-Source: AGHT+IFM8LM5RJszTW3OkrO4h1De5W9pe0tJPJMi/BivPcRvt6rjura+9pOg8iX0tlD8pj1FkY5ZvmMT8cROTfV2NWE=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:a02:b0:dbd:b6cd:92cf with
 SMTP id cb2-20020a0569020a0200b00dbdb6cd92cfmr161272ybb.11.1704930173233;
 Wed, 10 Jan 2024 15:42:53 -0800 (PST)
Date: Wed, 10 Jan 2024 23:42:29 +0000
In-Reply-To: <20240110234232.4116804-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110234232.4116804-8-nabihestefan@google.com>
Subject: [PATCH v12 07/10] include/hw/net: General GMAC Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3fSufZQwKCoQvijqpm01mnivowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

Implemented GMAC IRQ Handling and added relevant trace-events

Change-Id: I7a2d3cd3f493278bcd0cf483233c1e05c37488b7
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 hw/net/npcm_gmac.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/net/trace-events |  1 +
 2 files changed, 41 insertions(+)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 98b3c33c94..44c4ffaff4 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -149,6 +149,46 @@ static bool gmac_can_receive(NetClientState *nc)
     return true;
 }
 
+/*
+ * Function that updates the GMAC IRQ
+ * It find the logical OR of the enabled bits for NIS (if enabled)
+ * It find the logical OR of the enabled bits for AIS (if enabled)
+ */
+static void gmac_update_irq(NPCMGMACState *gmac)
+{
+    /*
+     * Check if the normal interrupts summary is enabled
+     * if so, add the bits for the summary that are enabled
+     */
+    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
+        (NPCM_DMA_INTR_ENAB_NIE_BITS)) {
+        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_NIS;
+    }
+    /*
+     * Check if the abnormal interrupts summary is enabled
+     * if so, add the bits for the summary that are enabled
+     */
+    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
+        (NPCM_DMA_INTR_ENAB_AIE_BITS)) {
+        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_AIS;
+    }
+
+    /* Get the logical OR of both normal and abnormal interrupts */
+    int level = !!((gmac->regs[R_NPCM_DMA_STATUS] &
+                    gmac->regs[R_NPCM_DMA_INTR_ENA] &
+                    NPCM_DMA_STATUS_NIS) |
+                   (gmac->regs[R_NPCM_DMA_STATUS] &
+                   gmac->regs[R_NPCM_DMA_INTR_ENA] &
+                   NPCM_DMA_STATUS_AIS));
+
+    /* Set the IRQ */
+    trace_npcm_gmac_update_irq(DEVICE(gmac)->canonical_path,
+                               gmac->regs[R_NPCM_DMA_STATUS],
+                               gmac->regs[R_NPCM_DMA_INTR_ENA],
+                               level);
+    qemu_set_irq(gmac->irq, level);
+}
+
 static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
 {
     /* Placeholder. Function will be filled in following patches */
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 33514548b8..56057de47f 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -473,6 +473,7 @@ npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offs
 npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %" PRIu8 " val: 0x%04" PRIx16
 npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
 npcm_gmac_set_link(bool active) "Set link: active=%u"
+npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en, int level) "%s: Status Reg: 0x%04" PRIX32 " Interrupt Enable Reg: 0x%04" PRIX32 " IRQ Set: %d"
 
 # npcm_pcs.c
 npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.43.0.275.g3460e3d667-goog


