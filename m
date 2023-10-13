Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 557037C8105
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqn-0001VP-CB; Fri, 13 Oct 2023 04:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqV-0000PR-Rv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:35 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqR-00015Z-QV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:35 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-505748580ceso2350759e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186906; x=1697791706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgK1ep3PqFzkyT15HRsoi+76YmTmRxdKAsgvMnq7kvw=;
 b=Ctys++7cgAxNZsR8ba/RQWCkbVVFzwVJocVjBPRMj9ToesFgBVk1HUIGfVEkb35aDe
 3zNxLTifsgkb+atBI8b8gi2a7eRGhdOJwnMWsYuln9CmvATPHfAXuiPqlWY4CYCwRs+q
 jJas9ZQt6iYjOxNgYkfY/z4Vhd8kcqspKMDk+oD2iSMP7d2EtEJvJrjnzAgBD+NAx5z4
 LcS3DKqiiYdoWNRCLZQcTZX2h9TH6JWBSK3vQHN4Zdft4xc6RZ/FYTOcsAInJruTbt22
 CoRcvPcMe9EcWznY4RfOHYHxiviwvouwvSrGr97fYdqqsvJrDacGoSlAS2xCgpkUJ2Gv
 TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186906; x=1697791706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgK1ep3PqFzkyT15HRsoi+76YmTmRxdKAsgvMnq7kvw=;
 b=PPPtoLOsJW39WQtQdB65YG1InrFNUQ69QiYpZP6mqvSHWJ3Ly29w7n4XM/QgJlW7IJ
 GZtBdEw6cTQsKI+bdCYW2jWv/qrbQ1Cmq1YXisc5F5QtbtFjYMedYr+/ktkRpbYgHSV4
 oIQwJNUjfx+2fdCRf6BdjTjro6gDpqQU0X8+J2e22OE04dgayQZf650CDR6DbQEzVJPH
 qxb63PqMjrLy3BdiPwiTclHo1WFix5ntGhQHNK3WNRR1DP4fl2C1edUoZLd7myqHGL59
 ZCLaoHf9+ZOzVe/D+4qrm0BPVT+Y6dxA1t0X0n9YTz1bpMfvmzvQRE7txNRklYz74fRk
 Pn+g==
X-Gm-Message-State: AOJu0YxfCB1VWz2HTR7u5UdFjiPtQWxuJvgGW0VDr3Vts395+iRqNkNi
 1pBDwUwxAELgRjMad/CVtO0HaCX2mVa3OypcAFo=
X-Google-Smtp-Source: AGHT+IGFLrp1Y9mjbykTCwf3FUrNWvJk/odYnvIfHP7p20hPbMZLCnZGh89w0cNE1ynyM1zw/p8Ygg==
X-Received: by 2002:a05:6512:48d6:b0:500:9734:545a with SMTP id
 er22-20020a05651248d600b005009734545amr19929543lfb.5.1697186906001; 
 Fri, 13 Oct 2023 01:48:26 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:25 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-arm@nongnu.org (open list:ARM cores),
 qemu-ppc@nongnu.org (open list:New World (mac99))
Subject: [RFC PATCH v3 43/78] hw/misc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:11 +0300
Message-Id: <14428b4bb4467c649e4e4a0f7f2ea20f1e9be46b.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
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

(Cédric Le Goater review for aspeed_scu.c)

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/misc/a9scu.c            |  2 ++
 hw/misc/aspeed_scu.c       |  2 +-
 hw/misc/bcm2835_property.c | 12 ++++++------
 hw/misc/mos6522.c          |  4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index a375ebc987..b422bec3c4 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -38,6 +38,7 @@ static uint64_t a9_scu_read(void *opaque, hwaddr offset,
     case 0x50: /* SCU Access Control Register */
     case 0x54: /* SCU Non-secure Access Control Register */
         /* unimplemented, fall through */
+        fallthrough;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
@@ -69,6 +70,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
     case 0x50: /* SCU Access Control Register */
     case 0x54: /* SCU Non-secure Access Control Register */
         /* unimplemented, fall through */
+        fallthrough;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
                                  " value 0x%"PRIx64"\n",
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 8335364906..4a1ea2fa21 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -672,7 +672,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         if (s->regs[reg + 2]) {
             return;
         }
-        /* fall through */
+        fallthrough;
     case AST2600_SYS_RST_CTRL:
     case AST2600_SYS_RST_CTRL2:
     case AST2600_CLK_STOP_CTRL:
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 4ed9faa54a..98170f34a6 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -182,7 +182,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
@@ -193,7 +193,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             fbconfig.yres_virtual = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
@@ -206,7 +206,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             fbconfig.bpp = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_DEPTH:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
@@ -218,7 +218,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             fbconfig.pixo = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_PIXEL_ORDER:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
             resplen = 4;
@@ -230,7 +230,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             fbconfig.alpha = ldl_le_phys(&s->dma_as, value + 12);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_ALPHA_MODE:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
             resplen = 4;
@@ -248,7 +248,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             fbconfig.yoffset = ldl_le_phys(&s->dma_as, value + 16);
             bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            /* fall through */
+            fallthrough;
         case RPI_FWREQ_FRAMEBUFFER_GET_VIRTUAL_OFFSET:
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index d6ba47bde9..a62349e6a0 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -320,7 +320,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
         break;
     case VIA_REG_A:
        qemu_log_mask(LOG_UNIMP, "Read access to register A with handshake");
-       /* fall through */
+       fallthrough;
     case VIA_REG_ANH:
         val = s->a;
         ctrl = (s->pcr & CA2_CTRL_MASK) >> CA2_CTRL_SHIFT;
@@ -412,7 +412,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
     case VIA_REG_A:
        qemu_log_mask(LOG_UNIMP, "Write access to register A with handshake");
-       /* fall through */
+       fallthrough;
     case VIA_REG_ANH:
         s->a = (s->a & ~s->dira) | (val & s->dira);
         mdc->portA_write(s);
-- 
2.39.2


