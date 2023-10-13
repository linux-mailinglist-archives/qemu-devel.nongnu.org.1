Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD147C80D2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDql-0001C1-Br; Fri, 13 Oct 2023 04:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqa-0000pX-5N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqX-00017U-2g
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so1770499f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186915; x=1697791715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zggbk3Tv5WW2FuR6IS0/SDL1yyI6gdBYW/mCpV1Dhdc=;
 b=zGJ+tC+79lUT2+PxIGovvqfaSZMxhTYH4obc7C5AjofXgKuiXmMG1G6ujE5rwFg8xF
 5b8UAO1bD/e0kzI6M8uepp0H1bID2pnvb/EFm8A23H1WFh5OQ50tfRk4Ym6IAFTkNAJD
 b4MTsCKK2+j2JgOIpcg+3mSJsjqLOo2jwiby9RIsSWh2FWdiT5o/EjG9X5cEuUvQXHWl
 Mto2ex8Zq3l6oZSZfOBbYqm3aPDg/IRpfdhrgPkF3veXiKuPbIyHt0VjUIR+XRVYRHCu
 /GKPPkWW1OLwIp7NcFy+x6gzbr78rhVrFz1AXWk4fFDQfpd750rkHUxL8L8Q+WxfPUou
 0L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186915; x=1697791715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zggbk3Tv5WW2FuR6IS0/SDL1yyI6gdBYW/mCpV1Dhdc=;
 b=uFygua0TscoGqQYj8t2fDqPqvMK7kondu4ZUjiCzpPN4cMGupFlNitjiAvL2/jYxgZ
 uD7bQzjpFYlk9ebwOVx1gDDlEa0WZj+M03gYVQ+qcpVvRw9SzflfahRdPhV44/yyIOse
 S+MvNl/vYVuin2aTe4AFsOMNpMIb+6AmzBMGPe+ipkylH9lQ10YG7/E+RTSa1z2nSFY7
 c41B/eADydQHIwyi9mhlO3QsyQRaFQtqibzWNHAr2XgSzDa/KtIa4+msvABSslO9SqdG
 EVr3Ug9XMbEie5mU8FqSJjZUZjwzU4pjYBZ4ZfC8Ddx9W3QtyXAtYl3k/BUF8HzBnci3
 mQGw==
X-Gm-Message-State: AOJu0Yx3/jzNUa1yh+ufyVQu5nGvBpJTlait3yo8Q52eL6hdVBwciKhD
 Frjgx+LCYV7ab6AOx+6tdFHCb0lyIEJ7h7hwvL0=
X-Google-Smtp-Source: AGHT+IFiEYEmuX6acV373Dhs8z7eLQV194olC1ziBIQDPidAJT914euYJpxYMBOh7CboemFkTCSbrQ==
X-Received: by 2002:a5d:62c6:0:b0:31f:d52a:82b3 with SMTP id
 o6-20020a5d62c6000000b0031fd52a82b3mr21325818wrv.46.1697186915447; 
 Fri, 13 Oct 2023 01:48:35 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:34 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:OMAP)
Subject: [RFC PATCH v3 49/78] hw/arm: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:17 +0300
Message-Id: <92469f064a501d60fbd39699052067dc25747038.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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
 hw/arm/omap1.c     | 8 ++++----
 hw/arm/pxa2xx.c    | 6 +++---
 hw/arm/stellaris.c | 1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index d5438156ee..c54a4ec553 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -552,7 +552,7 @@ static uint64_t omap_ulpd_pm_read(void *opaque, hwaddr addr,
     case 0x28:	/* Reserved */
     case 0x2c:	/* Reserved */
         OMAP_BAD_REG(addr);
-        /* fall through */
+        fallthrough;
     case 0x00:	/* COUNTER_32_LSB */
     case 0x04:	/* COUNTER_32_MSB */
     case 0x08:	/* COUNTER_HIGH_FREQ_LSB */
@@ -658,7 +658,7 @@ static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
     case 0x28:	/* Reserved */
     case 0x2c:	/* Reserved */
         OMAP_BAD_REG(addr);
-        /* fall through */
+        fallthrough;
     case 0x24:	/* SETUP_ANALOG_CELL3_ULPD1 */
     case 0x38:	/* COUNTER_32_FIQ */
     case 0x48:	/* LOCL_TIME */
@@ -3181,7 +3181,7 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
     case 0x00:	/* DRR2 */
         if (((s->rcr[0] >> 5) & 7) < 3)			/* RWDLEN1 */
             return 0x0000;
-        /* Fall through.  */
+        fallthrough;
     case 0x02:	/* DRR1 */
         if (s->rx_req < 2) {
             printf("%s: Rx FIFO underrun\n", __func__);
@@ -3279,7 +3279,7 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
     case 0x04:	/* DXR2 */
         if (((s->xcr[0] >> 5) & 7) < 3)			/* XWDLEN1 */
             return;
-        /* Fall through.  */
+        fallthrough;
     case 0x06:	/* DXR1 */
         if (s->tx_req > 1) {
             s->tx_req -= 2;
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 07d5dd8691..eaa6684243 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -285,7 +285,7 @@ static void pxa2xx_pwrmode_write(CPUARMState *env, const ARMCPRegInfo *ri,
             cpu_interrupt(CPU(s->cpu), CPU_INTERRUPT_HALT);
             break;
         }
-        /* Fall through.  */
+        fallthrough;
 
     case 2:
         /* Deep-Idle */
@@ -425,7 +425,7 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
     case MDCNFG ... SA1110:
         if ((addr & 3) == 0)
             return s->mm_regs[addr >> 2];
-        /* fall through */
+        fallthrough;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
@@ -446,7 +446,7 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
             s->mm_regs[addr >> 2] = value;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index aa5b0ddfaa..d68602ab71 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -157,6 +157,7 @@ static int ssys_board_class(const ssys_state *s)
             return did0 & DID0_CLASS_MASK;
         }
         /* for unknown classes, fall through */
+        fallthrough;
     default:
         /* This can only happen if the hardwired constant did0 value
          * in this board's stellaris_board_info struct is wrong.
-- 
2.39.2


