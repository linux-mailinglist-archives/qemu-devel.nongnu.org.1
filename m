Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9687C8101
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqZ-0000iE-Be; Fri, 13 Oct 2023 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqU-0000Fl-9M
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqR-00015x-QH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1689137f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186909; x=1697791709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSPuq3mpKDJwPTlZ47KrmhB2Wgg5QUxBL1oyH2kdMUI=;
 b=cDtrBFbYEJnZTH1HVz2wbZ3Z1jW07JspXTE27VXaiVodsx8PlKxtC1yD5ordGzqpc0
 KVkQAOaF2HzA58bOI/T+SaDfhTNskmOJRiIYXSC5PyfUr5YBz5VBX3ozZr1Ic8tvnaxh
 08rI3X3cDoGsDLS2jxGXU9A2tf8gRp0KbviL3d2egSe3ZYe9y2XxrcotJj7SEIXPwpkn
 WkZbONhaLhqXlbgsKAzpa3NMloUnGrAsPzNaaIu/hsSoGENYyoWAvKUieil1KxCH+dzL
 dOQDWrsGtZVFHBIady95xORmnYuCukqkWL/ij+lnLH4CRIRWfsiXOFztAQrvrQ4kI17j
 6jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186909; x=1697791709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSPuq3mpKDJwPTlZ47KrmhB2Wgg5QUxBL1oyH2kdMUI=;
 b=WcPynI/CMVYYMjZEE7kzvjIRLoU0d2QBi5R5Iz67mYeqSTgTnpUTiqQBJeE0JS1vOK
 pJl8vagT5p+4QbtsA8YawMoliNZCEnDAp82wKsdTZfCaMvvFQZa7m4cXUzSmKJgXFEqV
 E8wwZHOClnyzT/m6pw1oS07OLePLnJiZ49fbuKKbEg8szTnH3r5SmNUtv03Fd3Edfiag
 gkpJWtwv7ipKuqJ3wyahoxc0bP5s0zI9r16sgCC78J0U1v3L436vyEEVPTpNuW2pTDA6
 j6ShgoHY7b59fJIlZpVUVgLfO7WQZGDuYZQFYW12bdyCbqPvC1CevJirWINBXvOIs8TE
 fNVg==
X-Gm-Message-State: AOJu0Yygb88LFehHjLVOgbDM8SrtZya19xk62ZwQ9aDaJX9rr3nW0gPP
 epOq+2M2TD8Cvj9RGnOfSZIaEgUgsL/y6gz+2GI=
X-Google-Smtp-Source: AGHT+IGr0IfuHS02UTAahjTddnW2nSJuP3z3KjhFhjLuLuczH/ebpeq1K/Dw3nvz6vyXJx0YQnNxdQ==
X-Received: by 2002:adf:f407:0:b0:31f:eed7:2fdc with SMTP id
 g7-20020adff407000000b0031feed72fdcmr23644043wro.35.1697186909200; 
 Fri, 13 Oct 2023 01:48:29 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:28 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-arm@nongnu.org (open list:OMAP)
Subject: [RFC PATCH v3 45/78] hw/dma: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:13 +0300
Message-Id: <584198a301a0dbbeea1a127d054a0ebe68f5fe39.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/dma/omap_dma.c    | 32 ++++++++++++++++----------------
 hw/dma/pxa2xx_dma.c  |  4 ++--
 hw/dma/sparc32_dma.c |  2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 77797a67b5..dd43dbf3d2 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1471,7 +1471,7 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
                 break;
             return ret;
         }
-        /* Fall through. */
+        fallthrough;
     case 0x000 ... 0x2fe:
         reg = addr & 0x3f;
         ch = (addr >> 6) & 0x0f;
@@ -1482,7 +1482,7 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
     case 0x404 ... 0x4fe:
         if (s->model <= omap_dma_3_1)
             break;
-        /* Fall through. */
+        fallthrough;
     case 0x400:
         if (omap_dma_sys_read(s, addr, &ret))
             break;
@@ -1519,7 +1519,7 @@ static void omap_dma_write(void *opaque, hwaddr addr,
                 break;
             return;
         }
-        /* Fall through.  */
+        fallthrough;
     case 0x000 ... 0x2fe:
         reg = addr & 0x3f;
         ch = (addr >> 6) & 0x0f;
@@ -1530,7 +1530,7 @@ static void omap_dma_write(void *opaque, hwaddr addr,
     case 0x404 ... 0x4fe:
         if (s->model <= omap_dma_3_1)
             break;
-        /* fall through */
+        fallthrough;
     case 0x400:
         if (omap_dma_sys_write(s, addr, value))
             break;
@@ -1716,25 +1716,25 @@ static uint64_t omap_dma4_read(void *opaque, hwaddr addr,
 
     case 0x14:	/* DMA4_IRQSTATUS_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x10:	/* DMA4_IRQSTATUS_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x0c:	/* DMA4_IRQSTATUS_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x08:	/* DMA4_IRQSTATUS_L0 */
         return s->irqstat[irqn];
 
     case 0x24:	/* DMA4_IRQENABLE_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x20:	/* DMA4_IRQENABLE_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x1c:	/* DMA4_IRQENABLE_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x18:	/* DMA4_IRQENABLE_L0 */
         return s->irqen[irqn];
 
@@ -1870,13 +1870,13 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
     switch (addr) {
     case 0x14:	/* DMA4_IRQSTATUS_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x10:	/* DMA4_IRQSTATUS_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x0c:	/* DMA4_IRQSTATUS_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x08:	/* DMA4_IRQSTATUS_L0 */
         s->irqstat[irqn] &= ~value;
         if (!s->irqstat[irqn])
@@ -1885,13 +1885,13 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
 
     case 0x24:	/* DMA4_IRQENABLE_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x20:	/* DMA4_IRQENABLE_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x1c:	/* DMA4_IRQENABLE_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x18:	/* DMA4_IRQENABLE_L0 */
         s->irqen[irqn] = value;
         return;
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index fa896f7edf..ac47256572 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -278,7 +278,7 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
     switch (offset) {
     case DRCMR64 ... DRCMR74:
         offset -= DRCMR64 - DRCMR0 - (64 << 2);
-        /* Fall through */
+        fallthrough;
     case DRCMR0 ... DRCMR63:
         channel = (offset - DRCMR0) >> 2;
         return s->req[channel];
@@ -338,7 +338,7 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
     switch (offset) {
     case DRCMR64 ... DRCMR74:
         offset -= DRCMR64 - DRCMR0 - (64 << 2);
-        /* Fall through */
+        fallthrough;
     case DRCMR0 ... DRCMR63:
         channel = (offset - DRCMR0) >> 2;
 
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 0ef13c5e9a..c68e068cc9 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -220,7 +220,7 @@ static void dma_mem_write(void *opaque, hwaddr addr,
         break;
     case 1:
         s->dmaregs[0] |= DMA_LOADED;
-        /* fall through */
+        fallthrough;
     default:
         s->dmaregs[saddr] = val;
         break;
-- 
2.39.2


