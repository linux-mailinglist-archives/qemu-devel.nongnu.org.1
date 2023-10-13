Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2DA7C80F5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtN-0000nS-0h; Fri, 13 Oct 2023 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsn-00078o-9N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:59 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsh-0001b0-FD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:57 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c50cd16f3bso84701fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187049; x=1697791849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUIhP++t1/xzGexyy38QEsbzLOw4q8ngroWW7CBww/E=;
 b=IH3UhbBsDQj7NNo4JwrVDaHXOIuXk2P0zsRq6/29c5KiwOVPPAU+nWnbjakjsJHXiS
 xvVcBA8IbBUIVWr6Yiiy/136lI2WDi10K3e6wc4jskbbrVeT6TeaIvOeVNrse+xxAGVZ
 LZ3VKW2wU+KiZMVkSQ5tDHY+i+h5NlRjC707u9zeh06gyOkvRSf0iXhesDFKLfiqPOJe
 FCbufCWPqtdS3CgwEhLy2YIMgsK9fRK6wkDtOQmqjlCRw7NJbPV8V5cCA5pC9ZJtu9N5
 IP992NrKcw5pL4bRSHBo2oEkbr33PXa7xZT8nX7J/1xv/A3y1LW963nf3Q+W50D+3BGg
 EF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187049; x=1697791849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUIhP++t1/xzGexyy38QEsbzLOw4q8ngroWW7CBww/E=;
 b=neGbDXtNfAQlvqEgK7Lsc2PRxYOcSYGVrAj4yWV1pjOv7p0iXnpCE8jKOwYZl4/ohX
 htt4U9tOelQwI6fHcbEIgOEkv7nmpU/VdajlxRfXzCwXQhIwS58R5z8QDGZJ/XjuQ8DJ
 ptpRBBTdVK86nxREDM1L1f0o7HCWQ+ES93uj2187V8wzwyohwQiZDHCdbA6U4P86bI0F
 Z2YnQQGWLA+8TotLUgge0SxprFMPXoe0N3s2UDgUMdy4ibVlP6DtoITB+/SLtp9hLXdh
 62Wgj0Bf5dTkJ6RVEZz661BgP31BvZ8pJ9GbWT1MOKPn5g0G0zYKTUVdydAj3msaTEF8
 LX9Q==
X-Gm-Message-State: AOJu0YyI4i9LK4tTKmlz+u1xHEn+6q/Ky+EknsM8GJrI23h3EDmg5IFA
 GiPCgR78Hh9VCz1csmF21htWjgvYtJhSDS+sBX4=
X-Google-Smtp-Source: AGHT+IHYQWIaAOBBYMLPPy/IOzwecfDdsPDqzqWIvI7zOwBKNjtrgGbQoQI6YuS6jMpwvlxk16Z/kA==
X-Received: by 2002:a2e:a9a2:0:b0:2c5:32b:28fa with SMTP id
 x34-20020a2ea9a2000000b002c5032b28famr1964682ljq.30.1697187048866; 
 Fri, 13 Oct 2023 01:50:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:48 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Nuvoton NPCM7xx)
Subject: [RFC PATCH v3 72/78] hw/ssi: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:40 +0300
Message-Id: <ddd1b9ad088e5020ef9bea8773f09e18dc474fc0.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 hw/ssi/npcm7xx_fiu.c | 14 ++++++-------
 hw/ssi/omap_spi.c    | 48 ++++++++++++++++++++++----------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 4eedb2927e..fadd66a675 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -167,7 +167,7 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
     switch (FIU_DRD_CFG_ADDSIZ(drd_cfg)) {
     case FIU_ADDSIZ_4BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 24, 8));
-        /* fall through */
+        fallthrough;
     case FIU_ADDSIZ_3BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 16, 8));
         ssi_transfer(fiu->spi, extract32(addr, 8, 8));
@@ -226,7 +226,7 @@ static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
     switch (FIU_DWR_CFG_ADDSIZ(dwr_cfg)) {
     case FIU_ADDSIZ_4BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 24, 8));
-        /* fall through */
+        fallthrough;
     case FIU_ADDSIZ_3BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 16, 8));
         ssi_transfer(fiu->spi, extract32(addr, 8, 8));
@@ -285,16 +285,16 @@ static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
     switch (addsiz) {
     case 4:
         ssi_transfer(spi, extract32(addr, 24, 8));
-        /* fall through */
+        fallthrough;
     case 3:
         ssi_transfer(spi, extract32(addr, 16, 8));
-        /* fall through */
+        fallthrough;
     case 2:
         ssi_transfer(spi, extract32(addr, 8, 8));
-        /* fall through */
+        fallthrough;
     case 1:
         ssi_transfer(spi, extract32(addr, 0, 8));
-        /* fall through */
+        fallthrough;
     case 0:
         break;
     }
@@ -391,7 +391,7 @@ static void npcm7xx_fiu_ctrl_write(void *opaque, hwaddr addr, uint64_t v,
             value &= ~FIU_UMA_CFG_CMMLCK_MASK;
             value |= (s->regs[reg] & FIU_UMA_CFG_CMMLCK_MASK);
         }
-        /* fall through */
+        fallthrough;
     case NPCM7XX_FIU_DRD_CFG:
     case NPCM7XX_FIU_DWR_CFG:
         if (s->regs[reg] & NPCM7XX_FIU_CFG_LCK) {
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 8f85c3e391..a0f367bd17 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -170,47 +170,47 @@ static uint64_t omap_mcspi_read(void *opaque, hwaddr addr, unsigned size)
         return s->control;
 
     case 0x68: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x54: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x40: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x2c:	/* MCSPI_CHCONF */
         return s->ch[ch].config;
 
     case 0x6c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x58: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x44: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x30:	/* MCSPI_CHSTAT */
         return s->ch[ch].status;
 
     case 0x70: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x5c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x48: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x34:	/* MCSPI_CHCTRL */
         return s->ch[ch].control;
 
     case 0x74: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x60: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x4c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x38:	/* MCSPI_TX */
         return s->ch[ch].tx;
 
     case 0x78: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x64: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x50: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x3c:	/* MCSPI_RX */
         s->ch[ch].status &= ~(1 << 0);			/* RXS */
         ret = s->ch[ch].rx;
@@ -288,11 +288,11 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
         break;
 
     case 0x68: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x54: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x40: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x2c:	/* MCSPI_CHCONF */
         if ((value ^ s->ch[ch].config) & (3 << 14))	/* DMAR | DMAW */
             omap_mcspi_dmarequest_update(s->ch + ch);
@@ -309,11 +309,11 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
         break;
 
     case 0x70: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x5c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x48: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x34:	/* MCSPI_CHCTRL */
         if (value & ~s->ch[ch].control & 1) {		/* EN */
             s->ch[ch].control |= 1;
@@ -323,11 +323,11 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
         break;
 
     case 0x74: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x60: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x4c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x38:	/* MCSPI_TX */
         s->ch[ch].tx = value;
         s->ch[ch].status &= ~(1 << 1);			/* TXS */
-- 
2.39.2


