Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A178EE5E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLM-000895-57; Thu, 31 Aug 2023 09:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHP-0005an-RZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHL-0006Gz-Ew
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c6cd238e0so1311057f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486801; x=1694091601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8EundCVxScMr4tt/7YFkt/7+4fhMJQyHAWZWT88veQ=;
 b=egQjO4qICOsafCqxEjgccVxk7EjRDY8muzWAaojzCgMDoJ4l0+gyYcxQIVffhJM1G+
 TxEwGJ4AHMmLSqZf86FCglZO/IbL5vypGVaWM3iSAkpyYcTpn7j9qOEiZJelY74dN+Nr
 ehaBWXOHgHohegynh3rhOvrB5fh62grEzBGhFsSuATbpKJCcoQS/iTINU8kQb/uyc4fp
 eMCKbSKmojcq7XKkZR7VBtwPgwq7GpXCzdZRjT2oxnwmF85ZYSCam2zWrw9qguJlG0YU
 upeks5kYZawH7xdnm5RKEMgFVZ8nKkhqwUN7whvRwGzFr4IMpf2NV2mJXuBxCAJ3GcfP
 F7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486801; x=1694091601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8EundCVxScMr4tt/7YFkt/7+4fhMJQyHAWZWT88veQ=;
 b=W/8PTWM/tZTtfULKivEjUEIGcHz4vw4p9lkJi0dF+YMHtL/10MB63s+vCn0/x7xQho
 xTXRO4IPYwEaYuwlix8dfrTSu7yff2+fegnQYQCNZCwOJtMhWNgytRnEgBijpTwMDjac
 x9oMUzG+dQyCqtpAnuJBf6KRkKbEy4wnkMc21iy0afACm01J0IxQXNxLV4DgyaHf3zx8
 l/z94vAuHn9l62jT3LDfik/yNFsjivo5Ial9wgdBmI6zbC58Rjk3+RKKdJfqHqvaYoHb
 396eMPR/hPJbmKMbdtwpZkJZ56ECae+O4RfIJFeh0FGP15gZvoEajDd7/nsS49tVW1nT
 zesQ==
X-Gm-Message-State: AOJu0YycCUlFuwGPmyVGH6WLGYXKZ/kZpCbsDHaGNkKxin6c9JmkPr7A
 jMbNm98oyD3Q710wDq5yL53usomO2OKxlmIYslU=
X-Google-Smtp-Source: AGHT+IFgSAu7Yr1XlZV8tyfY4LMZJaXQxlIrz2p714/LOnR17cYws3TVIMXVnJ20fntcAAVtdIkUkg==
X-Received: by 2002:a5d:44d2:0:b0:317:f3fd:21b0 with SMTP id
 z18-20020a5d44d2000000b00317f3fd21b0mr1976615wrr.7.1693486801382; 
 Thu, 31 Aug 2023 06:00:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 b11-20020adfee8b000000b0031aeca90e1fsm2162331wro.70.2023.08.31.06.00.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:00:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 32/41] hw/usb/hcd-xhci: Avoid variable-length array in
 xhci_get_port_bandwidth()
Date: Thu, 31 Aug 2023 14:56:34 +0200
Message-ID: <20230831125646.67855-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In xhci_get_port_bandwidth(), we use a variable-length array to
construct the buffer to send back to the guest. Avoid the VLA
by using dma_memory_set() to directly request the memory system
to fill the guest memory with a string of '80's.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230824164818.2652452-1-peter.maydell@linaro.org>
---
 hw/usb/hcd-xhci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b89b618ec2..324177ad5d 100644
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
2.41.0


