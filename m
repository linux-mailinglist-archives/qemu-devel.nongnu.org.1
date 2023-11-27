Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E567FA7A4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6D-0007V2-EI; Mon, 27 Nov 2023 12:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f65-0007TB-Ib
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f62-0004e7-Jl
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:36 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b4a8db314so155825e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104913; x=1701709713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NQoM6ZQcldmAQjeSbb2MeylPpQJEjtu5OCIvJVzBqwo=;
 b=KsaXNjukW+03neiEXU9zpyYG61T1U8dRzkRIZkLYid+fHip8ic+Ve9UiSDwgWwGdyw
 1CfGodGphFeV4XACFNCEIEMC9QNSh14690puYXk9QRKjzopQ8jxTS3Zs1JU9EI84aN1V
 ceCrALQkVpDNuTE6D0kL7LApGO1VpfPgDToACVeRFGBumIHjOSs1SeWTKXBlEF6Vo0XM
 2jNOpRQdfgUP2fFnrh6ukrOCi4HOe2/Z/rGy/GgERQReRTJWr0dS/H2VW7rOSlZuyNwE
 +9NORgDTvci6tehyfAUjFOAIkjFLa8nMqjB5tvA04/lDoaCNHD4w2/ZQSfC/0qdNFQcn
 k/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104913; x=1701709713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQoM6ZQcldmAQjeSbb2MeylPpQJEjtu5OCIvJVzBqwo=;
 b=A5hPJ/hWgGn479XTxFUZHaxgl7X/mjXtskJ6yZMEv+vC8qG1MIq7zeTxpCe2GvDz21
 Bupmn/hQjMEdbq21ZKgCkD+9iZ7LkKKkZp1WGGvHEKjCKmi5Cl+ql4h923Y3tRPtKO2t
 tzxnold7rhScHx9/KWsCRmWwwAMBIQeT1zYwBYrXuk/9bL5HgvfZ8lyePVlNG+DXSFcj
 sZMnet1+QSE2yaZb4UmsVviaVShdUHDSVmhKIEnBVD66/TVSAoVM3Un16GQrTh10F+m2
 R7NGD03CctciPWIAd2pHx2pCnAA6cPeBp4v3F/hyWL16livxDxeOvKU2aHz097EVSwau
 Ny8Q==
X-Gm-Message-State: AOJu0YzM+mmZ5BOMog2Dso4nLpBThBdT/luN/rma211ejw6jF8P0ZvJy
 QUhTrGgW8bMALNRjWR5pS1wy7HqlbA7F0FMxVzI=
X-Google-Smtp-Source: AGHT+IFbpnA7OZxd3VyFXoyMGjtVtB3CMdKIfxk58ysh7Rm3lXTc7rqIfm7+Y0txel3YDGHyWX3HGA==
X-Received: by 2002:a05:600c:198a:b0:40b:448b:f711 with SMTP id
 t10-20020a05600c198a00b0040b448bf711mr3410855wmq.18.1701104912737; 
 Mon, 27 Nov 2023 09:08:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] hw/dma/xlnx_csu_dma: don't throw guest errors when
 stopping the SRC DMA
Date: Mon, 27 Nov 2023 17:08:23 +0000
Message-Id: <20231127170823.589863-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frederic Konrad <fkonrad@amd.com>

UG1087 states for the source channel that: if SIZE is programmed to 0, and the
DMA is started, the interrupts DONE and MEM_DONE will be asserted.

This implies that it is allowed for the guest to stop the source DMA by writing
a size of 0 to the SIZE register, so remove the LOG_GUEST_ERROR in that case.

While at it remove the comment marking the SIZE register as write-only.

See: https://docs.xilinx.com/r/en-US/ug1087-zynq-ultrascale-registers/CSUDMA_SRC_SIZE-CSUDMA-Register

Signed-off-by: Frederic Konrad <fkonrad@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20231124143505.1493184-4-fkonrad@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx_csu_dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 531013f35aa..bc1505aade7 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -39,7 +39,7 @@
 REG32(ADDR, 0x0)
     FIELD(ADDR, ADDR, 2, 30) /* wo */
 REG32(SIZE, 0x4)
-    FIELD(SIZE, SIZE, 2, 27) /* wo */
+    FIELD(SIZE, SIZE, 2, 27)
     FIELD(SIZE, LAST_WORD, 0, 1) /* rw, only exists in SRC */
 REG32(STATUS, 0x8)
     FIELD(STATUS, DONE_CNT, 13, 3) /* wtc */
@@ -335,10 +335,14 @@ static uint64_t addr_pre_write(RegisterInfo *reg, uint64_t val)
 static uint64_t size_pre_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxCSUDMA *s = XLNX_CSU_DMA(reg->opaque);
+    uint64_t size = val & R_SIZE_SIZE_MASK;
 
     if (s->regs[R_SIZE] != 0) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Starting DMA while already running.\n", __func__);
+        if (size || s->is_dst) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Starting DMA while already running.\n",
+                          __func__);
+        }
     }
 
     if (!s->is_dst) {
@@ -346,7 +350,7 @@ static uint64_t size_pre_write(RegisterInfo *reg, uint64_t val)
     }
 
     /* Size is word aligned */
-    return val & R_SIZE_SIZE_MASK;
+    return size;
 }
 
 static uint64_t size_post_read(RegisterInfo *reg, uint64_t val)
-- 
2.34.1


