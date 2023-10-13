Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDA67C7F34
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCzJ-00055c-8K; Fri, 13 Oct 2023 03:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCyB-0002Cn-Tw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxs-0005Mg-5j
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so19254185e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183526; x=1697788326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgVJaEUfo38wurBGn+D3UK3JXthAmJ84+zCqcU6HvLo=;
 b=QXXJ28VI4GxcOAqDcNdbzAVI5q0WuVldZSSJVRn3+rPK981k5cn6Y07XxED4HEsp1g
 O25DPRjL46m/ZhHEeolNdgrZV7/Joatn/PTxtRqDVm8QWb6+DY/QGQYzxupgFyvkUz38
 rELP7KbiNAVWsrWpzNhewdjDvnnQXYRXwbv6qTv3hkSbh75ytKsJhtMU0QuiyY+/K+Io
 u89ksfOD6vKCvfTEnlExsrhenUi73Y+UDomAzeezQERcitogfPvkgUQNoJDONlIUsXIY
 +jCMCOgzx+/FblyyNm1w8nrlc3C3Dqp0vrASjbUfCcJpf43sOd1It6ME5SLcC4fBx2z/
 TNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183526; x=1697788326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgVJaEUfo38wurBGn+D3UK3JXthAmJ84+zCqcU6HvLo=;
 b=PfOwncNm3Zz8HJRNjiB3kOG4kVOYcwFxcgUSEpTQpAvZ4hGuHhw+WuJcVWlHj291vZ
 X/S2RuKkXFXyrX+Gj2Eh5GEMWVTod7monO+qLBoiWwh7JXgP1R+gOdLz6BA9wNCohkle
 2UTvZTLWTDBLzPQuifxVaP3dlhTKZ2qoQo/I4tEl0aZliKBBs6Oksrhx+7JuoU2wdg/S
 bVubBytSLCO+37zvC7oiPNd+1yjXV9/yMXLKbQuwY5HMCXrN+2ifLSmVixjmNb1b/eTm
 2oKTsyy0pSRj3hm/OfmY8g9xCOFD+NX/N/Znu94iqppqAEppwSd9RQrefZt4qZ63jAV6
 v5fw==
X-Gm-Message-State: AOJu0YyykDel2UzVrUvJGyCcPL5AhTgYyLugbtjfyPqM1zX2xPWYooSq
 azvospoFPoBzBSWWyFT294snGi+nhK/bthnCp9c=
X-Google-Smtp-Source: AGHT+IEN+1PGLebGHG6LzB4Jve857eLBKb2V4txZtHsiU8Ve4TjS2fUcZG8o6jlHj5kQoDmKtsiI4A==
X-Received: by 2002:a5d:4c8a:0:b0:32d:8f5d:c6db with SMTP id
 z10-20020a5d4c8a000000b0032d8f5dc6dbmr3286780wrs.16.1697183526541; 
 Fri, 13 Oct 2023 00:52:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:52:06 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 56/78] hw/input: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:19 +0300
Message-Id: <7f9ab65c5376669408c00fa27d187aef66f2d26e.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/input/hid.c     | 3 ++-
 hw/input/tsc2005.c | 4 ++--
 hw/input/tsc210x.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index a9c7dd1ce1..15fffc5dfb 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -250,88 +250,89 @@ static void hid_keyboard_event(DeviceState *dev, QemuConsole *src,
 static void hid_keyboard_process_keycode(HIDState *hs)
 {
     uint8_t hid_code, index, key;
     int i, keycode, slot;
 
     if (hs->n == 0) {
         return;
     }
     slot = hs->head & QUEUE_MASK; QUEUE_INCR(hs->head); hs->n--;
     keycode = hs->kbd.keycodes[slot];
 
     if (!hs->n) {
         trace_hid_kbd_queue_empty();
     }
 
     key = keycode & 0x7f;
     index = key | ((hs->kbd.modifiers & (1 << 8)) >> 1);
     hid_code = hid_usage_keys[index];
     hs->kbd.modifiers &= ~(1 << 8);
 
     switch (hid_code) {
     case 0x00:
         return;
 
     case 0xe0:
         assert(key == 0x1d);
         if (hs->kbd.modifiers & (1 << 9)) {
             /* The hid_codes for the 0xe1/0x1d scancode sequence are 0xe9/0xe0.
              * Here we're processing the second hid_code.  By dropping bit 9
              * and setting bit 8, the scancode after 0x1d will access the
              * second half of the table.
              */
             hs->kbd.modifiers ^= (1 << 8) | (1 << 9);
             return;
         }
         /* fall through to process Ctrl_L */
+        fallthrough;
     case 0xe1 ... 0xe7:
         /* Ctrl_L/Ctrl_R, Shift_L/Shift_R, Alt_L/Alt_R, Win_L/Win_R.
          * Handle releases here, or fall through to process presses.
          */
         if (keycode & (1 << 7)) {
             hs->kbd.modifiers &= ~(1 << (hid_code & 0x0f));
             return;
         }
-        /* fall through */
+        fallthrough;
     case 0xe8 ... 0xe9:
         /* USB modifiers are just 1 byte long.  Bits 8 and 9 of
          * hs->kbd.modifiers implement a state machine that detects the
          * 0xe0 and 0xe1/0x1d sequences.  These bits do not follow the
          * usual rules where bit 7 marks released keys; they are cleared
          * elsewhere in the function as the state machine dictates.
          */
         hs->kbd.modifiers |= 1 << (hid_code & 0x0f);
         return;
 
     case 0xea ... 0xef:
         abort();
 
     default:
         break;
     }
 
     if (keycode & (1 << 7)) {
         for (i = hs->kbd.keys - 1; i >= 0; i--) {
             if (hs->kbd.key[i] == hid_code) {
                 hs->kbd.key[i] = hs->kbd.key[-- hs->kbd.keys];
                 hs->kbd.key[hs->kbd.keys] = 0x00;
                 break;
             }
         }
         if (i < 0) {
             return;
         }
     } else {
         for (i = hs->kbd.keys - 1; i >= 0; i--) {
             if (hs->kbd.key[i] == hid_code) {
                 break;
             }
         }
         if (i < 0) {
             if (hs->kbd.keys < sizeof(hs->kbd.key)) {
                 hs->kbd.key[hs->kbd.keys++] = hid_code;
             }
         } else {
             return;
         }
     }
 }
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index db2b80e35f..4f3f1d9d12 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -234,70 +234,70 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
 /* This handles most of the chip's logic.  */
 static void tsc2005_pin_update(TSC2005State *s)
 {
     int64_t expires;
     bool pin_state;
 
     switch (s->pin_func) {
     case 0:
         pin_state = !s->pressure && !!s->dav;
         break;
     case 1:
     case 3:
     default:
         pin_state = !s->dav;
         break;
     case 2:
         pin_state = !s->pressure;
     }
 
     if (pin_state != s->irq) {
         s->irq = pin_state;
         qemu_set_irq(s->pint, s->irq);
     }
 
     switch (s->nextfunction) {
     case TSC_MODE_XYZ_SCAN:
     case TSC_MODE_XY_SCAN:
         if (!s->host_mode && s->dav)
             s->enabled = false;
         if (!s->pressure)
             return;
-        /* Fall through */
+        fallthrough;
     case TSC_MODE_AUX_SCAN:
         break;
 
     case TSC_MODE_X:
     case TSC_MODE_Y:
     case TSC_MODE_Z:
         if (!s->pressure)
             return;
-        /* Fall through */
+        fallthrough;
     case TSC_MODE_AUX:
     case TSC_MODE_TEMP1:
     case TSC_MODE_TEMP2:
     case TSC_MODE_X_TEST:
     case TSC_MODE_Y_TEST:
     case TSC_MODE_TS_TEST:
         if (s->dav)
             s->enabled = false;
         break;
 
     case TSC_MODE_RESERVED:
     case TSC_MODE_XX_DRV:
     case TSC_MODE_YY_DRV:
     case TSC_MODE_YX_DRV:
     default:
         return;
     }
 
     if (!s->enabled || s->busy)
         return;
 
     s->busy = true;
     s->precision = s->nextprecision;
     s->function = s->nextfunction;
     s->pdst = !s->pnd0;	/* Synchronised on internal clock */
     expires = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
         (NANOSECONDS_PER_SECOND >> 7);
     timer_mod(s->timer, expires);
 }
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 950506fb38..9ae426e1a6 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -774,70 +774,70 @@ static void tsc2102_audio_register_write(
 /* This handles most of the chip logic.  */
 static void tsc210x_pin_update(TSC210xState *s)
 {
     int64_t expires;
     bool pin_state;
 
     switch (s->pin_func) {
     case 0:
         pin_state = s->pressure;
         break;
     case 1:
         pin_state = !!s->dav;
         break;
     case 2:
     default:
         pin_state = s->pressure && !s->dav;
     }
 
     if (!s->enabled)
         pin_state = false;
 
     if (pin_state != s->irq) {
         s->irq = pin_state;
         qemu_set_irq(s->pint, !s->irq);
     }
 
     switch (s->nextfunction) {
     case TSC_MODE_XY_SCAN:
     case TSC_MODE_XYZ_SCAN:
         if (!s->pressure)
             return;
         break;
 
     case TSC_MODE_X:
     case TSC_MODE_Y:
     case TSC_MODE_Z:
         if (!s->pressure)
             return;
-        /* Fall through */
+        fallthrough;
     case TSC_MODE_BAT1:
     case TSC_MODE_BAT2:
     case TSC_MODE_AUX:
     case TSC_MODE_TEMP1:
     case TSC_MODE_TEMP2:
         if (s->dav)
             s->enabled = false;
         break;
 
     case TSC_MODE_AUX_SCAN:
     case TSC_MODE_PORT_SCAN:
         break;
 
     case TSC_MODE_NO_SCAN:
     case TSC_MODE_XX_DRV:
     case TSC_MODE_YY_DRV:
     case TSC_MODE_YX_DRV:
     default:
         return;
     }
 
     if (!s->enabled || s->busy || s->dav)
         return;
 
     s->busy = true;
     s->precision = s->nextprecision;
     s->function = s->nextfunction;
     expires = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
         (NANOSECONDS_PER_SECOND >> 10);
     timer_mod(s->timer, expires);
 }
-- 
2.39.2


