Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B9C7C801A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD40-0008WK-Ry; Fri, 13 Oct 2023 03:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3x-0008Jk-Ip
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3s-0006mT-2f
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-406618d080eso19281695e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183898; x=1697788698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSixY69xmL0JnyirRdBeKYpA0hdWse2178EiFFrGZG8=;
 b=nkpafIUp8JzyDHzZkpXGSouRwx6aWKTJrI7pnvyKq9IKTIpwfRD/cdjlZDZDiyvO5C
 tRSssuIgquFvVQBYHecdYTjUWxGl1KxLFMdTEo9t7ojgcWb0RDMuTCCiuG6i0Htj/rUr
 NuWDYMt//MyzGqKzA3Q+MpnKHvwRmeplI73l5ZWaNo47KQp0WSRDaiZeWdz9PJWkA+j0
 OnNwy/iofsCzp7cAAdwupGCgKbQyO0N64GxOPp/vaAIDq2vf1XzMjL5lI8imYhBxTmP/
 qSR28cxjipN6Pzs7vYyTCoGAMgtQZsApNmJABC+JQ1QniPppwlZeXvt5S216tZC9/2bw
 FZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183898; x=1697788698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSixY69xmL0JnyirRdBeKYpA0hdWse2178EiFFrGZG8=;
 b=oJ5wp/C5nyYpHKM6bPhNy+2rhylC/PhEmUmIt+zap9sj2/hGsiqBovFozvIzzQ/ckG
 2zdzKbrjQuATuz6uPe9k7HA6iSM2qKlRIEWhagbAvxlcSNdoMpAG0tY8VEHZHT7ZsNy9
 azmbTaDwbCxfvw1nK9QpLIh9jP1CheYcSfjXEu2l6qQb9iTMcPdqpnnwFXReXrgcj8N6
 Hi7z2lJZ1aHSfBOx0SZpxqNqHYYbiSbZ11Nt99l4r3rqOe539qC8Yi7Lbd+xR6Lg/I/4
 K4mBCN+imFX5swoBwsanqQuThGP5iq7pB6OwZFh+zZMbKkXIoRA3EiNPnkdh2VoMeywj
 iaeg==
X-Gm-Message-State: AOJu0Yyx4cQF71JKH727gmjH2NfNx/vhpaTcpq8Gc4mBRaSi+0Xxa8E5
 mkOTNrHfXIxsuCMsAbH/gJXw6LG2XMtuXAX8068=
X-Google-Smtp-Source: AGHT+IGR/Fvudc4l61bKAa6gGyb/yQpiDm0HE9NcjezrdSZONBuk2v0BBZ5K/cwcSalx2MbxCp4jsA==
X-Received: by 2002:a05:600c:252:b0:402:f536:2d3e with SMTP id
 18-20020a05600c025200b00402f5362d3emr22454352wmj.14.1697183898335; 
 Fri, 13 Oct 2023 00:58:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:17 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [RFC PATCH v2 11/78] hw/timer: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:38 +0300
Message-Id: <0aa9568d743e6e1cf5763fe5557171fff773d50d.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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
@@ -135,40 +135,40 @@ static void a9_gtimer_update_no_sync(void *opaque)
 static uint64_t a9_gtimer_read(void *opaque, hwaddr addr, unsigned size)
 {
     A9GTimerPerCPU *gtb = (A9GTimerPerCPU *)opaque;
     A9GTimerState *s = gtb->parent;
     A9GTimerUpdate update;
     uint64_t ret = 0;
     int shift = 0;
 
     switch (addr) {
     case R_COUNTER_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COUNTER_LO:
         update = a9_gtimer_get_update(s);
         ret = extract64(update.new, shift, 32);
         break;
     case R_CONTROL:
         ret = s->control | gtb->control;
         break;
     case R_INTERRUPT_STATUS:
         ret = gtb->status;
         break;
     case R_COMPARATOR_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COMPARATOR_LO:
         ret = extract64(gtb->compare, shift, 32);
         break;
     case R_AUTO_INCREMENT:
         ret =  gtb->inc;
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "bad a9gtimer register: %x\n",
                       (unsigned)addr);
         return 0;
     }
 
     DB_PRINT("addr:%#x data:%#08" PRIx64 "\n", (unsigned)addr, ret);
     return ret;
 }
@@ -176,54 +176,54 @@ static uint64_t a9_gtimer_read(void *opaque, hwaddr addr, unsigned size)
 static void a9_gtimer_write(void *opaque, hwaddr addr, uint64_t value,
                             unsigned size)
 {
     A9GTimerPerCPU *gtb = (A9GTimerPerCPU *)opaque;
     A9GTimerState *s = gtb->parent;
     int shift = 0;
 
     DB_PRINT("addr:%#x data:%#08" PRIx64 "\n", (unsigned)addr, value);
 
     switch (addr) {
     case R_COUNTER_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COUNTER_LO:
         /*
          * Keep it simple - ARM docco explicitly says to disable timer before
          * modding it, so don't bother trying to do all the difficult on the fly
          * timer modifications - (if they even work in real hardware??).
          */
         if (s->control & R_CONTROL_TIMER_ENABLE) {
             qemu_log_mask(LOG_GUEST_ERROR, "Cannot mod running ARM gtimer\n");
             return;
         }
         s->counter = deposit64(s->counter, shift, 32, value);
         return;
     case R_CONTROL:
         a9_gtimer_update(s, (value ^ s->control) & R_CONTROL_NEEDS_SYNC);
         gtb->control = value & R_CONTROL_BANKED;
         s->control = value & ~R_CONTROL_BANKED;
         break;
     case R_INTERRUPT_STATUS:
         a9_gtimer_update(s, false);
         gtb->status &= ~value;
         break;
     case R_COMPARATOR_HI:
         shift = 32;
-        /* fallthrough */
+        fallthrough;
     case R_COMPARATOR_LO:
         a9_gtimer_update(s, false);
         gtb->compare = deposit64(gtb->compare, shift, 32, value);
         break;
     case R_AUTO_INCREMENT:
         gtb->inc = value;
         return;
     default:
         return;
     }
 
     a9_gtimer_update(s, false);
 }
 
 /* Wrapper functions to implement the "read global timer for
  * the current CPU" memory regions.
  */
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 72161f07bb..b343b7ab2c 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -266,53 +266,54 @@ static uint64_t aspeed_timer_read(void *opaque, hwaddr offset, unsigned size)
 static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
                                    uint32_t value)
 {
     AspeedTimer *t;
     uint32_t old_reload;
 
     trace_aspeed_timer_set_value(timer, reg, value);
     t = &s->timers[timer];
     switch (reg) {
     case TIMER_REG_RELOAD:
         old_reload = t->reload;
         t->reload = calculate_min_ticks(t, value);
 
         /* If the reload value was not previously set, or zero, and
          * the current value is valid, try to start the timer if it is
          * enabled.
          */
         if (old_reload || !t->reload) {
             break;
         }
         /* fall through to re-enable */
+        fallthrough;
     case TIMER_REG_STATUS:
         if (timer_enabled(t)) {
             uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
             int64_t delta = (int64_t) value - (int64_t) calculate_ticks(t, now);
             uint32_t rate = calculate_rate(t);
 
             if (delta >= 0) {
                 t->start += muldiv64(delta, NANOSECONDS_PER_SECOND, rate);
             } else {
                 t->start -= muldiv64(-delta, NANOSECONDS_PER_SECOND, rate);
             }
             aspeed_timer_mod(t);
         }
         break;
     case TIMER_REG_MATCH_FIRST:
     case TIMER_REG_MATCH_SECOND:
         t->match[reg - 2] = value;
         if (timer_enabled(t)) {
             aspeed_timer_mod(t);
         }
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: Programming error: unexpected reg: %d\n",
                       __func__, reg);
         break;
     }
 }
 
 /* Control register operations are broken out into helpers that can be
  * explicitly called on aspeed_timer_reset(), but also from
  * aspeed_timer_ctrl_op().
  */
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 2ae5ae3212..11863e1a42 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -162,109 +162,109 @@ static void pxa2xx_timer_update4(void *opaque, uint64_t now_qemu, int n)
 static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
                                   unsigned size)
 {
     PXA2xxTimerInfo *s = (PXA2xxTimerInfo *) opaque;
     int tm = 0;
 
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
         return s->tm4[tm].tm.value;
     case OSCR:
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
 
         if ((tm == 9 - 4 || tm == 11 - 4) && (s->tm4[tm].control & (1 << 9))) {
             if (s->tm4[tm - 1].freq)
                 s->snapshot = s->tm4[tm - 1].clock + muldiv64(
                                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                                 s->tm4[tm - 1].lastload,
                                 s->tm4[tm - 1].freq, NANOSECONDS_PER_SECOND);
             else
                 s->snapshot = s->tm4[tm - 1].clock;
         }
 
         if (!s->tm4[tm].freq)
             return s->tm4[tm].clock;
         return s->tm4[tm].clock +
             muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                      s->tm4[tm].lastload, s->tm4[tm].freq,
                      NANOSECONDS_PER_SECOND);
     case OIER:
         return s->irq_enabled;
     case OSSR:	/* Status register */
         return s->events;
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
         return s->tm4[tm].control;
     case OSNR:
         return s->snapshot;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: unknown register 0x%02" HWADDR_PRIx "\n",
                       __func__, offset);
         break;
     badreg:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: incorrect register 0x%02" HWADDR_PRIx "\n",
                       __func__, offset);
     }
 
     return 0;
 }
@@ -272,128 +272,128 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,
 static void pxa2xx_timer_write(void *opaque, hwaddr offset,
                                uint64_t value, unsigned size)
 {
     int i, tm = 0;
     PXA2xxTimerInfo *s = (PXA2xxTimerInfo *) opaque;
 
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
         s->tm4[tm].tm.value = value;
         pxa2xx_timer_update4(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tm);
         break;
     case OSCR:
         s->oldclock = s->clock;
         s->lastload = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         s->clock = value;
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
         s->tm4[tm].oldclock = s->tm4[tm].clock;
         s->tm4[tm].lastload = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         s->tm4[tm].clock = value;
         pxa2xx_timer_update4(s, s->tm4[tm].lastload, tm);
         break;
     case OIER:
         s->irq_enabled = value & 0xfff;
         break;
     case OSSR:	/* Status register */
         value &= s->events;
         s->events &= ~value;
         for (i = 0; i < 4; i ++, value >>= 1)
             if (value & 1)
                 qemu_irq_lower(s->timer[i].irq);
         if (pxa2xx_timer_has_tm4(s) && !(s->events & 0xff0) && value)
             qemu_irq_lower(s->irq4);
         break;
     case OWER:	/* XXX: Reset on OSMR3 match? */
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
         s->tm4[tm].control = value & 0x0ff;
         /* XXX Stop if running (shouldn't happen) */
         if ((value & (1 << 7)) || tm == 0)
             s->tm4[tm].freq = pxa2xx_timer4_freq[value & 7];
         else {
             s->tm4[tm].freq = 0;
             pxa2xx_timer_update4(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tm);
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
         s->tm4[tm].control = value & 0x3ff;
         /* XXX Stop if running (shouldn't happen) */
         if ((value & (1 << 7)) || !(tm & 1))
             s->tm4[tm].freq =
                     pxa2xx_timer4_freq[(value & (1 << 8)) ?  0 : (value & 7)];
         else {
             s->tm4[tm].freq = 0;
             pxa2xx_timer_update4(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tm);
         }
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s: unknown register 0x%02" HWADDR_PRIx " "
                       "(value 0x%08" PRIx64 ")\n",  __func__, offset, value);
         break;
     badreg:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: incorrect register 0x%02" HWADDR_PRIx " "
                       "(value 0x%08" PRIx64 ")\n", __func__, offset, value);
     }
 }
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
index 43b31213bc..a32521e3c3 100644
--- a/hw/timer/renesas_tmr.c
+++ b/hw/timer/renesas_tmr.c
@@ -193,69 +193,69 @@ static uint8_t read_tccr(uint8_t r)
 static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
 {
     RTMRState *tmr = opaque;
     int ch = addr & 1;
     uint64_t ret;
 
     if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
         qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr: Invalid read size 0x%"
                                        HWADDR_PRIX "\n",
                       addr);
         return UINT64_MAX;
     }
     switch (addr & 0x0e) {
     case A_TCR:
         ret = 0;
         ret = FIELD_DP8(ret, TCR, CCLR,
                         FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
         ret = FIELD_DP8(ret, TCR, OVIE,
                         FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
         ret = FIELD_DP8(ret, TCR, CMIEA,
                         FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
         ret = FIELD_DP8(ret, TCR, CMIEB,
                         FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
         return ret;
     case A_TCSR:
         ret = 0;
         ret = FIELD_DP8(ret, TCSR, OSA,
                         FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
         ret = FIELD_DP8(ret, TCSR, OSB,
                         FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
         switch (ch) {
         case 0:
             ret = FIELD_DP8(ret, TCSR, ADTE,
                             FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
             break;
         case 1: /* CH1 ADTE unimplement always 1 */
             ret = FIELD_DP8(ret, TCSR, ADTE, 1);
             break;
         }
         return ret;
     case A_TCORA:
         if (size == 1) {
             return tmr->tcora[ch];
         } else if (ch == 0) {
             return concat_reg(tmr->tcora);
         }
-        /* fall through */
+        fallthrough;
     case A_TCORB:
         if (size == 1) {
             return tmr->tcorb[ch];
         } else {
             return concat_reg(tmr->tcorb);
         }
     case A_TCNT:
         return read_tcnt(tmr, size, ch);
     case A_TCCR:
         if (size == 1) {
             return read_tccr(tmr->tccr[ch]);
         } else {
             return read_tccr(tmr->tccr[0]) << 8 | read_tccr(tmr->tccr[1]);
         }
     default:
         qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
                                  " not implemented\n",
                       addr);
         break;
     }
     return UINT64_MAX;
 }
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 7788939766..6dbfc2595b 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -84,120 +84,120 @@ static uint32_t sh_timer_read(void *opaque, hwaddr offset)
 static void sh_timer_write(void *opaque, hwaddr offset, uint32_t value)
 {
     SHTimerState *s = opaque;
     int freq;
 
     switch (offset >> 2) {
     case OFFSET_TCOR:
         s->tcor = value;
         ptimer_transaction_begin(s->timer);
         ptimer_set_limit(s->timer, s->tcor, 0);
         ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCNT:
         s->tcnt = value;
         ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, s->tcnt);
         ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCR:
         ptimer_transaction_begin(s->timer);
         if (s->enabled) {
             /*
              * Pause the timer if it is running. This may cause some inaccuracy
              * due to rounding, but avoids a whole lot of other messiness
              */
             ptimer_stop(s->timer);
         }
         freq = s->freq;
         /* ??? Need to recalculate expiry time after changing divisor.  */
         switch (value & TIMER_TCR_TPSC) {
         case 0:
             freq >>= 2;
             break;
         case 1:
             freq >>= 4;
             break;
         case 2:
             freq >>= 6;
             break;
         case 3:
             freq >>= 8;
             break;
         case 4:
             freq >>= 10;
             break;
         case 6:
         case 7:
             if (s->feat & TIMER_FEAT_EXTCLK) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved TPSC value\n", __func__);
         }
         switch ((value & TIMER_TCR_CKEG) >> 3) {
         case 0:
             break;
         case 1:
         case 2:
         case 3:
             if (s->feat & TIMER_FEAT_EXTCLK) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved CKEG value\n", __func__);
         }
         switch ((value & TIMER_TCR_ICPE) >> 6) {
         case 0:
             break;
         case 2:
         case 3:
             if (s->feat & TIMER_FEAT_CAPT) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved ICPE value\n", __func__);
         }
         if ((value & TIMER_TCR_UNF) == 0) {
             s->int_level = 0;
         }
 
         value &= ~TIMER_TCR_UNF;
 
         if ((value & TIMER_TCR_ICPF) && (!(s->feat & TIMER_FEAT_CAPT))) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved ICPF value\n", __func__);
         }
 
         value &= ~TIMER_TCR_ICPF; /* capture not supported */
 
         if (value & TIMER_TCR_RESERVED) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Reserved TCR bits set\n", __func__);
         }
         s->tcr = value;
         ptimer_set_limit(s->timer, s->tcor, 0);
         ptimer_set_freq(s->timer, freq);
         if (s->enabled) {
             /* Restart the timer if still enabled.  */
             ptimer_run(s->timer, 0);
         }
         ptimer_transaction_commit(s->timer);
         break;
     case OFFSET_TCPR:
         if (s->feat & TIMER_FEAT_CAPT) {
             s->tcpr = value;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
     }
     sh_timer_update(s);
 }
-- 
2.39.2


