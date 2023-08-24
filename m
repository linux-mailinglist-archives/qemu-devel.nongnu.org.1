Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68337875F1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDVU-0001k3-Mv; Thu, 24 Aug 2023 12:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDVP-0001js-JG
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:48:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDVN-0001vC-7x
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:48:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c79850df5so666449f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895699; x=1693500499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iy7N/Rnqx9OMidqM6GTDKL4xclWQ6WwSF+w7lEnOsYw=;
 b=zX8nK2sH7KzOa0+ZZEtkw9zxoIeoyDUYfLF3D6Vkm3xld+NrqXd6ezB/1NS6mWuaxN
 8+Kb2hPx1pfcKJ1caW6UlWnU7IY2+aXvKvjByh3xtsR7shFHeIGpguwLu9Xc3opjoK4R
 JhFlsNZTu9IxfH0VC2HvRAsHNemQQrPtDq/UM0E3ewXMy7U8nnUEdyg5SJrqdY+zjJHR
 xtII3JjCNrgBXWD4d1HRRAp262lJHinXYzvaHUFtwkbBHY6Ybz7I5EJa65TnmKsyTXUH
 hMZ7Ocq3JNOIF/5Qe+I+TQggHeAxxi308rUMi7dfGdh18MFJGzFOYL//W7AVEa9vtApr
 ZHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895699; x=1693500499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iy7N/Rnqx9OMidqM6GTDKL4xclWQ6WwSF+w7lEnOsYw=;
 b=MEc2UcUJRsQ4K/40VA6iWdCZwoQxctxuFAVnIw9CQDV0bWjHaGK7fa/fUX5o9ERR88
 2enC+w+iS9naWsTn5pboFXMRl8XQEL+e5YS5mLPNF3vthqFoVNcJI4DCNbxVhrJ+20s/
 kUMcJenHsK/F3a4DIKPqXgIjVnUIaAELrJZ3bMud7+lgq5ZCsJ22ye+lskv5aaXTuX9/
 pg9xFscxS6jHeHtz9xgjikHlAs59QYNfZ6l4o0jq5+nY+lGDfIr6fU0fxaRsEj1s8vDm
 7R/uVZt7Oy8McxjMkV1o20FKEVfRBL7yw2c+9UtfaR7Z38BQxkPTtG4G8uGMTTr3drh2
 I2ZA==
X-Gm-Message-State: AOJu0YwoVkgGRo7Flwxgjy+5VgbmqpGrdKxVKU6jpIwUL0XWE188zAZX
 azDWPMCntfVjpB3nb7p+SdM6JfS+XQux/7ZxGlU=
X-Google-Smtp-Source: AGHT+IELnjOi+bjRUzDaVyri23w/pmZ/1TwwQ92Xy2yoC+/9x13u+4vFSrD2/zwTfuwqzcVltEGKTA==
X-Received: by 2002:adf:fe86:0:b0:31c:6525:770d with SMTP id
 l6-20020adffe86000000b0031c6525770dmr5356870wrr.1.1692895699401; 
 Thu, 24 Aug 2023 09:48:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a5d630e000000b0031980783d78sm22626598wru.54.2023.08.24.09.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/usb/hcd-xhci: Avoid variable-length array in
 xhci_get_port_bandwidth()
Date: Thu, 24 Aug 2023 17:48:18 +0100
Message-Id: <20230824164818.2652452-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In xhci_get_port_bandwidth(), we use a variable-length array to
construct the buffer to send back to the guest. Avoid the VLA
by using dma_memory_set() to directly request the memory system
to fill the guest memory with a string of '80's.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Use of dma_memory_set() is a suggestion from RTH from Philippe's
original attempt.  If we ever do anything about the "use real
values" TODO we'll need to do something else (eg heap-allocated
array), but since we haven't done so since the code was written
in 2012 it doesn't seem very likely we'll ever do so.
---
 hw/usb/hcd-xhci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b89b618ec21..324177ad5df 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2434,7 +2434,6 @@ static void xhci_detach_slot(XHCIState *xhci, USBPort *uport)
 static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
 {
     dma_addr_t ctx;
-    uint8_t bw_ctx[xhci->numports+1];
 
     DPRINTF("xhci_get_port_bandwidth()\n");
 
@@ -2442,11 +2441,10 @@ static TRBCCode xhci_get_port_bandwidth(XHCIState *xhci, uint64_t pctx)
 
     DPRINTF("xhci: bandwidth context at "DMA_ADDR_FMT"\n", ctx);
 
-    /* TODO: actually implement real values here */
-    bw_ctx[0] = 0;
-    memset(&bw_ctx[1], 80, xhci->numports); /* 80% */
-    if (dma_memory_write(xhci->as, ctx, bw_ctx, sizeof(bw_ctx),
-                     MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+    /* TODO: actually implement real values here. This is 80% for all ports. */
+    if (stb_dma(xhci->as, ctx, 0, MEMTXATTRS_UNSPECIFIED) != MEMTX_OK ||
+        dma_memory_set(xhci->as, ctx + 1, 80, xhci->numports,
+                       MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: DMA memory write failed!\n",
                       __func__);
         return CC_TRB_ERROR;
-- 
2.34.1


