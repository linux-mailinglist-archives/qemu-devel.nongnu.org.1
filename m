Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3BD827BD3
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:04:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMza5-0002Q9-Fj; Mon, 08 Jan 2024 19:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3KI2cZQwKCucWJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com>)
 id 1rMza1-0002P3-Se
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:54 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3KI2cZQwKCucWJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com>)
 id 1rMzZz-0002tD-Ex
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:53 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-db410931c23so2783858276.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704758569; x=1705363369; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tej3cWvS+UWc/eQTZOfAEg9WDZ/VnqiSSVvVLWXewJo=;
 b=bCZudT+scdaE/w5Oq7x8ZS97yWd4pi78gbYQDK5SigHR11URw0NqnWbx9QRzZFpBIs
 IP2bU0PC9Pd3sKCqUmSiOO1bMzb4irxyy2LPTrMwP4Gu+eVcDl7iv+Mvfy7ukb7t1THa
 o8QLet9zvZDbHJMk5g+GGH7tEqjBYdkBtG2wcrvDDEj/DLCdAWOn2OKMt4HjzexQY9jt
 AQU8gmOADT/u/SctH+ICBC8sG8fyeM54bknU/WuGYD1k40A6J6q5hy6NI6m6qR+7aevQ
 pSfsi21vJUD10TMmbWxdOMQBnXcTd1NK+wjAmMrFMNozumUiwGBDhciaIsaovP9c0qos
 Ef0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704758569; x=1705363369;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tej3cWvS+UWc/eQTZOfAEg9WDZ/VnqiSSVvVLWXewJo=;
 b=c2pusjKGmsdSSBp6xXreSyZf2w3CrBlUm3vugbsNMspaIqo6xPm1DqAHO3UAEYzT79
 E/qEm6JOcMM8NXcuElsBt+7pLU6u692dwMI8Gm92zYhZLRVJtrfb/4rw7WjH0nlTxtkp
 CvQuKPBoIuGooOLJD4E+Z36XUZyqlb7aUzebAXwUf1DXvcEoGLGwReqsV5i6W8O3fIFh
 J0dHszc0j8EkSJ7WMAblP9DcNzWv5Hl5ebV1XQo4rURtW/lNWu9sVTIY08HFVbxVrerV
 g+sMnnrfyHkka2rumFPIBiN3987qa8/w/HMmK/INmURNnM0glxyxEK52pP2SPi95yNCD
 sXIw==
X-Gm-Message-State: AOJu0YzVL/Zp90qd1DI+Z5geHOqCfRo0fmivuCe8rJaID3Y2YZKkM2fY
 NT2pOkq/iWQVzuB2PsMlHUIC0QMaaSBVnixelBrTfJCHpw==
X-Google-Smtp-Source: AGHT+IFD8bpxBCk0dIhV2p6rIisZtt+IJ1RA+9h0kssShdK0QhBgemtpQqhuHPRHZFgDJVXH7nTrRVgA8IxVqJs1PW0=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:b911:0:b0:dbe:4fc2:d6ef with SMTP
 id x17-20020a25b911000000b00dbe4fc2d6efmr1815242ybj.12.1704758568997; Mon, 08
 Jan 2024 16:02:48 -0800 (PST)
Date: Tue,  9 Jan 2024 00:02:31 +0000
In-Reply-To: <20240109000234.2799153-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240109000234.2799153-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109000234.2799153-8-nabihestefan@google.com>
Subject: [PATCH v11 07/10] include/hw/net: GMAC IRQ Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3KI2cZQwKCucWJKRQNbcNOJWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Implement Update IRQ Method for GMAC functionality.

Added relevant trace-events

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
2.43.0.472.g3155946c3a-goog


