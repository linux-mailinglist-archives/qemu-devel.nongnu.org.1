Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A5F7C80A0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpd-0007Sv-Qd; Fri, 13 Oct 2023 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpa-0007Q2-5X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:38 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpY-0000nn-1T
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:37 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-503f39d3236so2381806e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186853; x=1697791653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TilCLybsKQVSIwhb19nthh+M1jJV+7LFdQfVqtwfBA=;
 b=CkkzPqd3fMKOBmvkAEsNVv9eV4qkzJL7BYWycUavBrGDRqD+twKP99wfrb4Ijdbil9
 aULdcoYgc0xBEfQ8bhQuiXiaz2DDh0cvv2O9dCr63+wN1q3NmOyCDIcma4cKLO5g2+AP
 ZIssRB9kcQmAuJ8PV+LXSFBfAKl9Yr03IiKwoRdg39YgKPDnkGBa3Z+oRv58g+heXDt+
 vmHNyakJNJlNMlmsYpCc6Zmpvr1kg/tNXkx80e+XaQ6wg1YLH++xPnAVPmpsCIuRs5N1
 DjKPt/kergzq16ennb2Kr5ES4MFlWIqJw1Rl7YRICyBSAkHK04UtJN3nDQM4Z0aY8G4l
 qSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186853; x=1697791653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TilCLybsKQVSIwhb19nthh+M1jJV+7LFdQfVqtwfBA=;
 b=Stm/6+Q+VboG/Vcm4ftphefJ+O+iGgIX46IrHe95gAubJpiDBuCm0IpXIxVm//X6PF
 rLmwljeIouML1H+g4LtgcLH0/CWh2hjG9FljaOy5IkqjSE7cCxtyJVJDwXeCO9y5t4Ja
 P1qpXoofdQOaKZluyONefphd3Opa4nUZbCcR3cPIzVhsizxegzPByqLcJnZ4I+OH056j
 xy1TUroamxGDL20Zbol0VvWo2fBpInXZT1fJ1kujDDp+MvnUFx8OQn4qnlRaAOzF/vXQ
 tsuiE6E82wLexKKU6c2bwEYo0ZGb/8GahXYIrxxQoOZMuvNU1j8ni9EP8jMHjc+fzFDZ
 az3w==
X-Gm-Message-State: AOJu0YwpoJ+P6wDkUI9Dywf7cWiulDWLocdZyuUImUyvV3t6NBvtRd6q
 gjQwLeWUFK0APl94FojXFgWY6hsbLQmL6UOD1f8=
X-Google-Smtp-Source: AGHT+IFVlnd6s45/C4fj/u7Sfy6G7IjYLdJW6OHuKXHEvTR+b3UmeS+qEVWygOdEP4xenBbYqkPhyg==
X-Received: by 2002:a05:6512:130b:b0:502:ffdf:b098 with SMTP id
 x11-20020a056512130b00b00502ffdfb098mr27985287lfu.6.1697186853671; 
 Fri, 13 Oct 2023 01:47:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:33 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [RFC PATCH v3 11/78] hw/timer: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:39 +0300
Message-Id: <089c04aaa8a001c7af0e44c309122c738ff2bf50.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12e.google.com
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
 hw/timer/a9gtimer.c     |  8 ++--
 hw/timer/aspeed_timer.c |  1 +
 hw/timer/pxa2xx_timer.c | 94 ++++++++++++++++++++---------------------
 hw/timer/renesas_tmr.c  |  2 +-
 hw/timer/sh_timer.c     |  8 ++--
 5 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 5e959b6d09..b83d51da96 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -143,7 +143,7 @@ static uint64_t a9_gtimer_read(void *opaque, hwaddr addr, unsigned size)
     switch (addr) {
     case R_COUNTER_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COUNTER_LO:
         update = a9_gtimer_get_update(s);
         ret = extract64(update.new, shift, 32);
@@ -156,7 +156,7 @@ static uint64_t a9_gtimer_read(void *opaque, hwaddr addr, unsigned size)
         break;
     case R_COMPARATOR_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COMPARATOR_LO:
         ret = extract64(gtb->compare, shift, 32);
         break;
@@ -185,7 +185,7 @@ static void a9_gtimer_write(void *opaque, hwaddr addr, uint64_t value,
     switch (addr) {
     case R_COUNTER_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COUNTER_LO:
         /*
          * Keep it simple - ARM docco explicitly says to disable timer before
@@ -209,7 +209,7 @@ static void a9_gtimer_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case R_COMPARATOR_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COMPARATOR_LO:
         a9_gtimer_update(s, false);
         gtb->compare = deposit64(gtb->compare, shift, 32, value);
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 72161f07bb..b343b7ab2c 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -284,6 +284,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
             break;
         }
         /* fall through to re-enable */
+        fallthrough;
     case TIMER_REG_STATUS:
         if (timer_enabled(t)) {
             uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 2ae5ae3212..11863e1a42 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -167,27 +167,27 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
 
     switch (offset) {
     case OSMR3:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR2:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR1:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR0:
         return s->timer[tm].value;
     case OSMR11: tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR10: tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR9:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR8:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR7:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR6:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR5:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR4:
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
@@ -196,19 +196,19 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
         return s->clock + muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                         s->lastload, s->freq, NANOSECONDS_PER_SECOND);
     case OSCR11: tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR10: tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR9:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR8:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR7:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR6:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR5:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR4:
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
@@ -236,19 +236,19 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
     case OWER:
         return s->reset3;
     case OMCR11: tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR10: tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR9:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR8:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR7:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR6:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR5:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR4:
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
@@ -277,29 +277,29 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
 
     switch (offset) {
     case OSMR3:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR2:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR1:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR0:
         s->timer[tm].value = value;
         pxa2xx_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case OSMR11: tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR10: tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR9:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR8:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR7:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR6:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR5:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSMR4:
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
@@ -313,19 +313,19 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
         pxa2xx_timer_update(s, s->lastload);
         break;
     case OSCR11: tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR10: tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR9:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR8:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR7:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR6:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR5:  tm ++;
-        /* fall through */
+        fallthrough;
     case OSCR4:
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
@@ -350,11 +350,11 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
         s->reset3 = value;
         break;
     case OMCR7:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR6:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR5:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR4:
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
@@ -368,11 +368,11 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,
         }
         break;
     case OMCR11: tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR10: tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR9:  tm ++;
-        /* fall through */
+        fallthrough;
     case OMCR8:  tm += 4;
         if (!pxa2xx_timer_has_tm4(s))
             goto badreg;
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 43b31213bc..a32521e3c3 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -236,7 +236,7 @@ static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
         } else if (ch == 0) {
             return concat_reg(tmr->tcora);
         }
-        /* fall through */
+        fallthrough;
     case A_TCORB:
         if (size == 1) {
             return tmr->tcorb[ch];
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 7788939766..6dbfc2595b 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -131,7 +131,7 @@ static void sh_timer_write(void *opaque, hwaddr offset, uint32_t value)
             if (s->feat & TIMER_FEAT_EXTCLK) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved TPSC value\n", __func__);
@@ -145,7 +145,7 @@ static void sh_timer_write(void *opaque, hwaddr offset, uint32_t value)
             if (s->feat & TIMER_FEAT_EXTCLK) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved CKEG value\n", __func__);
@@ -158,7 +158,7 @@ static void sh_timer_write(void *opaque, hwaddr offset, uint32_t value)
             if (s->feat & TIMER_FEAT_CAPT) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved ICPE value\n", __func__);
@@ -194,7 +194,7 @@ static void sh_timer_write(void *opaque, hwaddr offset, uint32_t value)
             s->tcpr = value;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
-- 
2.39.2


