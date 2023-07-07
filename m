Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B92174AFED
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:36:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgS-0001n2-3X; Fri, 07 Jul 2023 07:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgP-0001m4-2v; Fri, 07 Jul 2023 07:31:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgM-0006T4-Qz; Fri, 07 Jul 2023 07:31:28 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b7474b0501so1631369a34.1; 
 Fri, 07 Jul 2023 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729485; x=1691321485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUg7Q73kEMeAx0Een00oIb5s2nW2Sa1jBnegcv9S4ZI=;
 b=WZo8cwwLDoGOCBO3slD+2yc2xNmAXt3I88cCDWvnx9C2Zi95HUzGqDzxSjNefTxZjP
 Z58LfTPqHutqF9HABlAzgt/crn7+3l/LcvbmVEOWoTfYHOJNkOnTHFaim3uuVMvBvu9s
 jeTdyPfFCvdkTDb141kgn+CfGnM5M4r+QYEs+ncxKc9TJU5tM0oiPyQm3Zlcv0gWsr3i
 d81JoSxRg8ECmTwkQKFfCMPV0PFjTxXMMRTfTNwu6oX5QF9DW3vU6R64eAwZJ2Gpn/fp
 UeE4ydmuLwhh3XlL+fF6VlfBC43FHgLwcKKT8NyGNB4e/JxJbX2EXA7F6edm/WlU+XFf
 h60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729485; x=1691321485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUg7Q73kEMeAx0Een00oIb5s2nW2Sa1jBnegcv9S4ZI=;
 b=NchwSyxxRxAdbg2PmElUAXt9YnxQ/8tgXSz9sDnjgG71D6H2ELN9iYoN01EZFvTUAy
 RVl3cD+1InqfUlV7tiOm92BpYDQAWSMAFzstTI11coR2zbQTFJIvOkPj8DwKitW4h8f4
 gYnZgm4r6ptfu0QUTRkkEy9X7rAE1OXLwPgehQt+RXd6ELfZL1uYia1P10SPHh75ZFlh
 9sI2uP/2FLK1pOnc9/4yj7CM2IxKgkxcn69548Tqvb3hOYJ9A+ZGWslJ1m4UzyqByf2c
 CEk/jCHn7T3uj4AfINjijUShGYUDy0ANnA+Se+aws5oMZUWPD0IrUx6T3NhxrTWqtrfF
 pVcQ==
X-Gm-Message-State: ABy/qLZjSnQff5OlQmrjWMoDGgyciuEI+3e4e/d9IVwdCXY9bgmcDaOM
 OV9kEjq1sMBN6J+G7z5TrBkMuhKMhD0=
X-Google-Smtp-Source: APBJJlE3fOQFaSLn1NdyjGXR+HfQKOZP2txBzK7M/JLfZtmtPxYw91mVFEzgF3R0ms5qJgMdYPLVZQ==
X-Received: by 2002:a9d:4d0e:0:b0:6b9:1be6:ef56 with SMTP id
 n14-20020a9d4d0e000000b006b91be6ef56mr683710otf.23.1688729485367; 
 Fri, 07 Jul 2023 04:31:25 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:25 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 01/60] pnv/psi: Allow access to PSI registers through xscom
Date: Fri,  7 Jul 2023 08:30:09 -0300
Message-ID: <20230707113108.7145-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

skiboot only uses mmio to access the PSI registers (once the BAR is
set) but we don't have any reason to block the accesses through
xscom. This patch enables xscom access to the PSI registers. It
converts the xscom addresses to mmio addresses, which requires a bit
of care for the PSIHB, then reuse the existing mmio ops.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230630102609.193214-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_psi.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 8aa09ab26b..46da58dff8 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -121,8 +121,12 @@
 #define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
 #define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
 
+/* mmio address to xscom address */
 #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
 
+/* xscom address to mmio address */
+#define PSIHB_MMIO(reg) ((reg - PSIHB_XSCOM_BAR) << 3)
+
 static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
@@ -769,24 +773,31 @@ static const MemoryRegionOps pnv_psi_p9_mmio_ops = {
 
 static uint64_t pnv_psi_p9_xscom_read(void *opaque, hwaddr addr, unsigned size)
 {
-    /* No read are expected */
-    qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom read at 0x%" PRIx64 "\n", addr);
-    return -1;
+    uint32_t reg = addr >> 3;
+    uint64_t val = -1;
+
+    if (reg < PSIHB_XSCOM_BAR) {
+        /* FIR, not modeled */
+        qemu_log_mask(LOG_UNIMP, "PSI: xscom read at 0x%08x\n", reg);
+    } else {
+        val = pnv_psi_p9_mmio_read(opaque, PSIHB_MMIO(reg), size);
+    }
+    return val;
 }
 
 static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
     PnvPsi *psi = PNV_PSI(opaque);
+    uint32_t reg = addr >> 3;
 
-    /* XSCOM is only used to set the PSIHB MMIO region */
-    switch (addr >> 3) {
-    case PSIHB_XSCOM_BAR:
+    if (reg < PSIHB_XSCOM_BAR) {
+        /* FIR, not modeled */
+        qemu_log_mask(LOG_UNIMP, "PSI: xscom write at 0x%08x\n", reg);
+    } else if (reg == PSIHB_XSCOM_BAR) {
         pnv_psi_set_bar(psi, val);
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom write at 0x%" PRIx64 "\n",
-                      addr);
+    } else {
+        pnv_psi_p9_mmio_write(opaque, PSIHB_MMIO(reg), val, size);
     }
 }
 
-- 
2.41.0


