Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFE7C7FEA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD62-0001uI-GA; Fri, 13 Oct 2023 04:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5d-0008EQ-1O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5Z-0007VZ-4N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso21740235e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184003; x=1697788803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KB0gvugYc9C6TU4Cb/iuN+aDu5QpjXM6/bIk/+OkcXM=;
 b=fqvjLbZhNGXRCCNSs3vrFzUApQDf3DmRzB/zxfpiveZp6U8q9s1NPUpL8ap9YaH/3M
 RLD2hNb+p1mVQWK2mz6jRABTdxDvzQgCCkKsHaMn5nNyyn2iLC5eAs1vv4MGfui9CbcH
 nzaTf8c4kzgbaH4BLegreurw6e6ODseyE9c1h2ruY1lQVi9ZiwLQuummE8RDmhIWjK3S
 6o8PgOpuTzbwYSAvFHRougDezuaE4jvNPgNzqhEAtFVC4vClCM4zYByWOt6ZGN8BVKhs
 nQe0MgpdHa+GwbRShzSZfTIoE0tA/IBliGhDkrevwCzvOnFG8rivQC8Z7jYScBtpFQvp
 3Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184003; x=1697788803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KB0gvugYc9C6TU4Cb/iuN+aDu5QpjXM6/bIk/+OkcXM=;
 b=jxvZP3YnTaZaZxwBArsZtOqaZq/H0K770HTIcZ6CVXTJl4gUQtaRlEeKAksBExDqhq
 nra2A6cjuRYkgj4f4UXIHcsq5X3LGi+p/odeY7Ti7cOxopgKB/EGK7C74UJSh/8T85JR
 /+2b+1b/cgDq09fXxsicw0HEQXPyBqwpOt414txNyIZOfS8glllZgVhh2dooh71JkhTo
 mnDdfYoID1TG9JLUUInjmhZT7DKVm5hL+3EtjDMZ/jBS4Iw2LcaZqsPzzJmk/E61TY+9
 947DkBKGUg86ZaM5Cvl8ihvjx5AS4JoEbZWvlIXxSXkCvTduyLMinTQHL9TaGuPB9Kkf
 fOkg==
X-Gm-Message-State: AOJu0Yyw56O4QwJBpnWiCRGSluGw0Ye3cNUJYdTCRxLjduTLccjyWdQS
 /oCdvo0GJYjZwMe1A4Lxa90f22sPOQdDsOihdm0=
X-Google-Smtp-Source: AGHT+IHpdmQduaz9oTXIexvry4ciDDONgjZWs3D9NR2xIgLdVJBy4WWW6dCQpmp68UikEmT7QuipRg==
X-Received: by 2002:a05:600c:2107:b0:405:48ba:9c with SMTP id
 u7-20020a05600c210700b0040548ba009cmr24266073wml.16.1697184003223; 
 Fri, 13 Oct 2023 01:00:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:02 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [RFC PATCH v2 70/78] hw/rtc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:37 +0300
Message-Id: <aba72599f8eb496fe5c4f1683b1e9d96d5e1a843.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/rtc/aspeed_rtc.c  | 4 ++--
 hw/rtc/mc146818rtc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index fa861e2d49..59c64b01b9 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -68,28 +68,28 @@ static uint32_t aspeed_rtc_get_counter(AspeedRtcState *rtc, int r)
 static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
     AspeedRtcState *rtc = opaque;
     uint64_t val;
     uint32_t r = addr >> 2;
 
     switch (r) {
     case COUNTER1:
     case COUNTER2:
         if (rtc->reg[CONTROL] & RTC_ENABLED) {
             rtc->reg[r] = aspeed_rtc_get_counter(rtc, r);
         }
-        /* fall through */
+        fallthrough;
     case CONTROL:
         val = rtc->reg[r];
         break;
     case ALARM:
     case ALARM_STATUS:
     default:
         qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, addr);
         return 0;
     }
 
     trace_aspeed_rtc_read(addr, val);
 
     return val;
 }
@@ -97,25 +97,25 @@ static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
 static void aspeed_rtc_write(void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
     AspeedRtcState *rtc = opaque;
     uint32_t r = addr >> 2;
 
     switch (r) {
     case COUNTER1:
     case COUNTER2:
         if (!(rtc->reg[CONTROL] & RTC_UNLOCKED)) {
             break;
         }
-        /* fall through */
+        fallthrough;
     case CONTROL:
         rtc->reg[r] = val;
         aspeed_rtc_calc_offset(rtc);
         break;
     case ALARM:
     case ALARM_STATUS:
     default:
         qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__, addr);
         break;
     }
     trace_aspeed_rtc_write(addr, val);
 }
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index c27c362db9..6b6eef94fd 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -439,120 +439,120 @@ static void rtc_update_timer(void *opaque)
 static void cmos_ioport_write(void *opaque, hwaddr addr,
                               uint64_t data, unsigned size)
 {
     MC146818RtcState *s = opaque;
     uint32_t old_period;
     bool update_periodic_timer;
 
     if ((addr & 1) == 0) {
         s->cmos_index = data & 0x7f;
     } else {
         CMOS_DPRINTF("cmos: write index=0x%02x val=0x%02" PRIx64 "\n",
                      s->cmos_index, data);
         switch(s->cmos_index) {
         case RTC_SECONDS_ALARM:
         case RTC_MINUTES_ALARM:
         case RTC_HOURS_ALARM:
             s->cmos_data[s->cmos_index] = data;
             check_update_timer(s);
             break;
         case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
-            /* fall through */
+            fallthrough;
         case RTC_CENTURY:
         case RTC_SECONDS:
         case RTC_MINUTES:
         case RTC_HOURS:
         case RTC_DAY_OF_WEEK:
         case RTC_DAY_OF_MONTH:
         case RTC_MONTH:
         case RTC_YEAR:
             s->cmos_data[s->cmos_index] = data;
             /* if in set mode, do not update the time */
             if (rtc_running(s)) {
                 rtc_set_time(s);
                 check_update_timer(s);
             }
             break;
         case RTC_REG_A:
             update_periodic_timer = (s->cmos_data[RTC_REG_A] ^ data) & 0x0f;
             old_period = rtc_periodic_clock_ticks(s);
 
             if ((data & 0x60) == 0x60) {
                 if (rtc_running(s)) {
                     rtc_update_time(s);
                 }
                 /* What happens to UIP when divider reset is enabled is
                  * unclear from the datasheet.  Shouldn't matter much
                  * though.
                  */
                 s->cmos_data[RTC_REG_A] &= ~REG_A_UIP;
             } else if (((s->cmos_data[RTC_REG_A] & 0x60) == 0x60) &&
                     (data & 0x70)  <= 0x20) {
                 /* when the divider reset is removed, the first update cycle
                  * begins one-half second later*/
                 if (!(s->cmos_data[RTC_REG_B] & REG_B_SET)) {
                     s->offset = 500000000;
                     rtc_set_time(s);
                 }
                 s->cmos_data[RTC_REG_A] &= ~REG_A_UIP;
             }
             /* UIP bit is read only */
             s->cmos_data[RTC_REG_A] = (data & ~REG_A_UIP) |
                 (s->cmos_data[RTC_REG_A] & REG_A_UIP);
 
             if (update_periodic_timer) {
                 periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
                                       old_period, true);
             }
 
             check_update_timer(s);
             break;
         case RTC_REG_B:
             update_periodic_timer = (s->cmos_data[RTC_REG_B] ^ data)
                                        & REG_B_PIE;
             old_period = rtc_periodic_clock_ticks(s);
 
             if (data & REG_B_SET) {
                 /* update cmos to when the rtc was stopping */
                 if (rtc_running(s)) {
                     rtc_update_time(s);
                 }
                 /* set mode: reset UIP mode */
                 s->cmos_data[RTC_REG_A] &= ~REG_A_UIP;
                 data &= ~REG_B_UIE;
             } else {
                 /* if disabling set mode, update the time */
                 if ((s->cmos_data[RTC_REG_B] & REG_B_SET) &&
                     (s->cmos_data[RTC_REG_A] & 0x70) <= 0x20) {
                     s->offset = get_guest_rtc_ns(s) % NANOSECONDS_PER_SECOND;
                     rtc_set_time(s);
                 }
             }
             /* if an interrupt flag is already set when the interrupt
              * becomes enabled, raise an interrupt immediately.  */
             if (data & s->cmos_data[RTC_REG_C] & REG_C_MASK) {
                 s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
                 qemu_irq_raise(s->irq);
             } else {
                 s->cmos_data[RTC_REG_C] &= ~REG_C_IRQF;
                 qemu_irq_lower(s->irq);
             }
             s->cmos_data[RTC_REG_B] = data;
 
             if (update_periodic_timer) {
                 periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
                                       old_period, true);
             }
 
             check_update_timer(s);
             break;
         case RTC_REG_C:
         case RTC_REG_D:
             /* cannot write to them */
             break;
         default:
             s->cmos_data[s->cmos_index] = data;
             break;
         }
     }
 }
@@ -678,63 +678,63 @@ static int update_in_progress(MC146818RtcState *s)
 static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
     MC146818RtcState *s = opaque;
     int ret;
     if ((addr & 1) == 0) {
         return 0xff;
     } else {
         switch(s->cmos_index) {
         case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
-            /* fall through */
+            fallthrough;
         case RTC_CENTURY:
         case RTC_SECONDS:
         case RTC_MINUTES:
         case RTC_HOURS:
         case RTC_DAY_OF_WEEK:
         case RTC_DAY_OF_MONTH:
         case RTC_MONTH:
         case RTC_YEAR:
             /* if not in set mode, calibrate cmos before
              * reading*/
             if (rtc_running(s)) {
                 rtc_update_time(s);
             }
             ret = s->cmos_data[s->cmos_index];
             break;
         case RTC_REG_A:
             ret = s->cmos_data[s->cmos_index];
             if (update_in_progress(s)) {
                 ret |= REG_A_UIP;
             }
             break;
         case RTC_REG_C:
             ret = s->cmos_data[s->cmos_index];
             qemu_irq_lower(s->irq);
             s->cmos_data[RTC_REG_C] = 0x00;
             if (ret & (REG_C_UF | REG_C_AF)) {
                 check_update_timer(s);
             }
 
             if(s->irq_coalesced &&
                     (s->cmos_data[RTC_REG_B] & REG_B_PIE) &&
                     s->irq_reinject_on_ack_count < RTC_REINJECT_ON_ACK_COUNT) {
                 s->irq_reinject_on_ack_count++;
                 s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_PF;
                 DPRINTF_C("cmos: injecting on ack\n");
                 if (rtc_policy_slew_deliver_irq(s)) {
                     s->irq_coalesced--;
                     DPRINTF_C("cmos: coalesced irqs decreased to %d\n",
                               s->irq_coalesced);
                 }
             }
             break;
         default:
             ret = s->cmos_data[s->cmos_index];
             break;
         }
         CMOS_DPRINTF("cmos: read index=0x%02x val=0x%02x\n",
                      s->cmos_index, ret);
         return ret;
     }
 }
-- 
2.39.2


