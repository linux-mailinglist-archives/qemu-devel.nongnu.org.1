Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A22998C3E6
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Oct 2024 18:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfut-0005tM-N5; Tue, 01 Oct 2024 12:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfud-0005ap-2h
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuW-00066l-C6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37cd831ab06so2261732f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800778; x=1728405578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JG57QVpHrLALzZR+9s2olzjjtYqV+9hQmExoUYKYmvA=;
 b=yARlAyQ+G9mNb5RL01SF04FVyGXsic/g+5x4OgJ0ZfOpk8XU5B+SVBUeoDfPO5bbuz
 fjLupfmx5lSEapxWelZ+gZUGUjWhZzTG/fZvnMxbEGLTQJOF1qPJTlxC0a13cXPCwOMG
 9h4NX+zpCpVbELwDFark4ljkhhOOlYdtI3YHTjNl0rMX+MgTqhWOgWWM5rWrAk34r7Yd
 13PSQvMMxp5JQCOlSrKu4fdjC2G7KAYJBLAM950ZubU40JlWyt5+MHPasP7FvlQIXFbN
 ke8hG08MrfXsC5m+s1lFfHWmQt39NhD/z/Ozxqwnn/IP/Dm/KWJzkZcDuDSVO4naiTHB
 zQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800778; x=1728405578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JG57QVpHrLALzZR+9s2olzjjtYqV+9hQmExoUYKYmvA=;
 b=umXcT/IoMXoxe3EITcmEpj/O/xatPN+EcwtUrFNBcUf8jg6a48Os+oXIANGmLOZmXT
 h+hooVDGJwRQtPo5fM7ZoLaEsoJ3U3A8xCk7tHas7sUqtpQyn2ob9dMH4l1/ivclJIyy
 DGAYQpjCKzFmvdM8qbFga6BgqO9466hTHjIDof8bdLFDhdnTkYSFcBfofO3iBpYsAfVk
 b0CmkcW3XjgyqOpZUHIuLbR1ohrh/iBgdybJnuNCR5hbhKYyefoy3dPCp9B+dogKN6OR
 1ovNOIfWXfx9s9q8mV1GLu597wcu2cc5iFNz2eZa3F1AMOeEsPc6XxI1vVQIRLl6j80k
 sJYA==
X-Gm-Message-State: AOJu0YxPH0vnBo0dO9fZIf+BE5Znr4yWnsQOGcyJqC3if/xG0m04pC0y
 KJgSRr1Hb5eevkT9zONJ/35K3IZDlLy3rEKpNz29AwRnApAgFDW+QEYtu14MIu8RypwZjb2J23T
 F
X-Google-Smtp-Source: AGHT+IFaMqaqXTiPq1GLRA6gutjgS3+O0burdaaXLEQf7uzcQIL/stMJLkN3Ua0kIrySMkbnwnjUPQ==
X-Received: by 2002:a5d:584c:0:b0:374:ae04:c7c5 with SMTP id
 ffacd0b85a97d-37cfb9fc32bmr174137f8f.36.1727800778382; 
 Tue, 01 Oct 2024 09:39:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/54] hw/input: Remove lm832x device
Date: Tue,  1 Oct 2024 17:38:58 +0100
Message-Id: <20241001163918.1275441-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Remove the lm832x keyboard-and-pwm i2c device model. This
was only used by the n800 and n810 machines.

(Although this is an i2c device and so in theory available to create
on the command line, in practice it has an outbound IRQ line that the
machine model needs to wire up, and the only way to inject keys events
into it is to call the lm832x_key_event() function, so it isn't
in practice possible to use it separately from the n800/n810.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240903160751.4100218-32-peter.maydell@linaro.org
---
 MAINTAINERS               |   7 -
 include/hw/input/lm832x.h |  28 --
 hw/input/lm832x.c         | 528 --------------------------------------
 hw/input/Kconfig          |   4 -
 hw/input/meson.build      |   1 -
 5 files changed, 568 deletions(-)
 delete mode 100644 include/hw/input/lm832x.h
 delete mode 100644 hw/input/lm832x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 98314d157c2..4ee26995436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -870,13 +870,6 @@ F: pc-bios/npcm7xx_bootrom.bin
 F: roms/vbootrom
 F: docs/system/arm/nuvoton.rst
 
-nSeries
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/input/lm832x.c
-F: include/hw/input/lm832x.h
-
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
diff --git a/include/hw/input/lm832x.h b/include/hw/input/lm832x.h
deleted file mode 100644
index e0e5d5ef20e..00000000000
--- a/include/hw/input/lm832x.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * National Semiconductor LM8322/8323 GPIO keyboard & PWM chips.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef HW_INPUT_LM832X_H
-#define HW_INPUT_LM832X_H
-
-#define TYPE_LM8323 "lm8323"
-
-void lm832x_key_event(DeviceState *dev, int key, int state);
-
-#endif
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
deleted file mode 100644
index ef65ad18b89..00000000000
--- a/hw/input/lm832x.c
+++ /dev/null
@@ -1,528 +0,0 @@
-/*
- * National Semiconductor LM8322/8323 GPIO keyboard & PWM chips.
- *
- * Copyright (C) 2008 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "hw/input/lm832x.h"
-#include "hw/i2c/i2c.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "qemu/timer.h"
-#include "ui/console.h"
-#include "qom/object.h"
-
-OBJECT_DECLARE_SIMPLE_TYPE(LM823KbdState, LM8323)
-
-struct LM823KbdState {
-    I2CSlave parent_obj;
-
-    uint8_t i2c_dir;
-    uint8_t i2c_cycle;
-    uint8_t reg;
-
-    qemu_irq nirq;
-    uint16_t model;
-
-    struct {
-        qemu_irq out[2];
-        int in[2][2];
-    } mux;
-
-    uint8_t config;
-    uint8_t status;
-    uint8_t acttime;
-    uint8_t error;
-    uint8_t clock;
-
-    struct {
-        uint16_t pull;
-        uint16_t mask;
-        uint16_t dir;
-        uint16_t level;
-        qemu_irq out[16];
-    } gpio;
-
-    struct {
-        uint8_t dbnctime;
-        uint8_t size;
-        uint8_t start;
-        uint8_t len;
-        uint8_t fifo[16];
-    } kbd;
-
-    struct {
-        uint16_t file[256];
-        uint8_t faddr;
-        uint8_t addr[3];
-        QEMUTimer *tm[3];
-    } pwm;
-};
-
-#define INT_KEYPAD		(1 << 0)
-#define INT_ERROR		(1 << 3)
-#define INT_NOINIT		(1 << 4)
-#define INT_PWMEND(n)		(1 << (5 + n))
-
-#define ERR_BADPAR		(1 << 0)
-#define ERR_CMDUNK		(1 << 1)
-#define ERR_KEYOVR		(1 << 2)
-#define ERR_FIFOOVR		(1 << 6)
-
-static void lm_kbd_irq_update(LM823KbdState *s)
-{
-    qemu_set_irq(s->nirq, !s->status);
-}
-
-static void lm_kbd_gpio_update(LM823KbdState *s)
-{
-}
-
-static void lm_kbd_reset(DeviceState *dev)
-{
-    LM823KbdState *s = LM8323(dev);
-
-    s->config = 0x80;
-    s->status = INT_NOINIT;
-    s->acttime = 125;
-    s->kbd.dbnctime = 3;
-    s->kbd.size = 0x33;
-    s->clock = 0x08;
-
-    lm_kbd_irq_update(s);
-    lm_kbd_gpio_update(s);
-}
-
-static void lm_kbd_error(LM823KbdState *s, int err)
-{
-    s->error |= err;
-    s->status |= INT_ERROR;
-    lm_kbd_irq_update(s);
-}
-
-static void lm_kbd_pwm_tick(LM823KbdState *s, int line)
-{
-}
-
-static void lm_kbd_pwm_start(LM823KbdState *s, int line)
-{
-    lm_kbd_pwm_tick(s, line);
-}
-
-static void lm_kbd_pwm0_tick(void *opaque)
-{
-    lm_kbd_pwm_tick(opaque, 0);
-}
-static void lm_kbd_pwm1_tick(void *opaque)
-{
-    lm_kbd_pwm_tick(opaque, 1);
-}
-static void lm_kbd_pwm2_tick(void *opaque)
-{
-    lm_kbd_pwm_tick(opaque, 2);
-}
-
-enum {
-    LM832x_CMD_READ_ID		= 0x80, /* Read chip ID. */
-    LM832x_CMD_WRITE_CFG	= 0x81, /* Set configuration item. */
-    LM832x_CMD_READ_INT		= 0x82, /* Get interrupt status. */
-    LM832x_CMD_RESET		= 0x83, /* Reset, same as external one */
-    LM823x_CMD_WRITE_PULL_DOWN	= 0x84, /* Select GPIO pull-up/down. */
-    LM832x_CMD_WRITE_PORT_SEL	= 0x85, /* Select GPIO in/out. */
-    LM832x_CMD_WRITE_PORT_STATE	= 0x86, /* Set GPIO pull-up/down. */
-    LM832x_CMD_READ_PORT_SEL	= 0x87, /* Get GPIO in/out. */
-    LM832x_CMD_READ_PORT_STATE	= 0x88, /* Get GPIO pull-up/down. */
-    LM832x_CMD_READ_FIFO	= 0x89, /* Read byte from FIFO. */
-    LM832x_CMD_RPT_READ_FIFO	= 0x8a, /* Read FIFO (no increment). */
-    LM832x_CMD_SET_ACTIVE	= 0x8b, /* Set active time. */
-    LM832x_CMD_READ_ERROR	= 0x8c, /* Get error status. */
-    LM832x_CMD_READ_ROTATOR	= 0x8e, /* Read rotator status. */
-    LM832x_CMD_SET_DEBOUNCE	= 0x8f, /* Set debouncing time. */
-    LM832x_CMD_SET_KEY_SIZE	= 0x90, /* Set keypad size. */
-    LM832x_CMD_READ_KEY_SIZE	= 0x91, /* Get keypad size. */
-    LM832x_CMD_READ_CFG		= 0x92, /* Get configuration item. */
-    LM832x_CMD_WRITE_CLOCK	= 0x93, /* Set clock config. */
-    LM832x_CMD_READ_CLOCK	= 0x94, /* Get clock config. */
-    LM832x_CMD_PWM_WRITE	= 0x95, /* Write PWM script. */
-    LM832x_CMD_PWM_START	= 0x96, /* Start PWM engine. */
-    LM832x_CMD_PWM_STOP		= 0x97, /* Stop PWM engine. */
-    LM832x_GENERAL_ERROR	= 0xff, /* There was one error.
-                                           Previously was represented by -1
-                                           This is not a command */
-};
-
-#define LM832x_MAX_KPX		8
-#define LM832x_MAX_KPY		12
-
-static uint8_t lm_kbd_read(LM823KbdState *s, int reg, int byte)
-{
-    int ret;
-
-    switch (reg) {
-    case LM832x_CMD_READ_ID:
-        ret = 0x0400;
-        break;
-
-    case LM832x_CMD_READ_INT:
-        ret = s->status;
-        if (!(s->status & INT_NOINIT)) {
-            s->status = 0;
-            lm_kbd_irq_update(s);
-        }
-        break;
-
-    case LM832x_CMD_READ_PORT_SEL:
-        ret = s->gpio.dir;
-        break;
-    case LM832x_CMD_READ_PORT_STATE:
-        ret = s->gpio.mask;
-        break;
-
-    case LM832x_CMD_READ_FIFO:
-        if (s->kbd.len <= 1)
-            return 0x00;
-
-        /* Example response from the two commands after a INT_KEYPAD
-         * interrupt caused by the key 0x3c being pressed:
-         * RPT_READ_FIFO: 55 bc 00 4e ff 0a 50 08 00 29 d9 08 01 c9 01
-         *     READ_FIFO: bc 00 00 4e ff 0a 50 08 00 29 d9 08 01 c9 01
-         * RPT_READ_FIFO: bc 00 00 4e ff 0a 50 08 00 29 d9 08 01 c9 01
-         *
-         * 55 is the code of the key release event serviced in the previous
-         * interrupt handling.
-         *
-         * TODO: find out whether the FIFO is advanced a single character
-         * before reading every byte or the whole size of the FIFO at the
-         * last LM832x_CMD_READ_FIFO.  This affects LM832x_CMD_RPT_READ_FIFO
-         * output in cases where there are more than one event in the FIFO.
-         * Assume 0xbc and 0x3c events are in the FIFO:
-         * RPT_READ_FIFO: 55 bc 3c 00 4e ff 0a 50 08 00 29 d9 08 01 c9
-         *     READ_FIFO: bc 3c 00 00 4e ff 0a 50 08 00 29 d9 08 01 c9
-         * Does RPT_READ_FIFO now return 0xbc and 0x3c or only 0x3c?
-         */
-        s->kbd.start ++;
-        s->kbd.start &= sizeof(s->kbd.fifo) - 1;
-        s->kbd.len --;
-
-        return s->kbd.fifo[s->kbd.start];
-    case LM832x_CMD_RPT_READ_FIFO:
-        if (byte >= s->kbd.len)
-            return 0x00;
-
-        return s->kbd.fifo[(s->kbd.start + byte) & (sizeof(s->kbd.fifo) - 1)];
-
-    case LM832x_CMD_READ_ERROR:
-        return s->error;
-
-    case LM832x_CMD_READ_ROTATOR:
-        return 0;
-
-    case LM832x_CMD_READ_KEY_SIZE:
-        return s->kbd.size;
-
-    case LM832x_CMD_READ_CFG:
-        return s->config & 0xf;
-
-    case LM832x_CMD_READ_CLOCK:
-        return (s->clock & 0xfc) | 2;
-
-    default:
-        lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
-        return 0x00;
-    }
-
-    return ret >> (byte << 3);
-}
-
-static void lm_kbd_write(LM823KbdState *s, int reg, int byte, uint8_t value)
-{
-    switch (reg) {
-    case LM832x_CMD_WRITE_CFG:
-        s->config = value;
-        /* This must be done whenever s->mux.in is updated (never).  */
-        if ((s->config >> 1) & 1)			/* MUX1EN */
-            qemu_set_irq(s->mux.out[0], s->mux.in[0][(s->config >> 0) & 1]);
-        if ((s->config >> 3) & 1)			/* MUX2EN */
-            qemu_set_irq(s->mux.out[0], s->mux.in[0][(s->config >> 2) & 1]);
-        /* TODO: check that this is issued only following the chip reset
-         * and not in the middle of operation and that it is followed by
-         * the GPIO ports re-resablishing through WRITE_PORT_SEL and
-         * WRITE_PORT_STATE (using a timer perhaps) and otherwise output
-         * warnings.  */
-        s->status = 0;
-        lm_kbd_irq_update(s);
-        s->kbd.len = 0;
-        s->kbd.start = 0;
-        s->reg = LM832x_GENERAL_ERROR;
-        break;
-
-    case LM832x_CMD_RESET:
-        if (value == 0xaa)
-            lm_kbd_reset(DEVICE(s));
-        else
-            lm_kbd_error(s, ERR_BADPAR);
-        s->reg = LM832x_GENERAL_ERROR;
-        break;
-
-    case LM823x_CMD_WRITE_PULL_DOWN:
-        if (!byte)
-            s->gpio.pull = value;
-        else {
-            s->gpio.pull |= value << 8;
-            lm_kbd_gpio_update(s);
-            s->reg = LM832x_GENERAL_ERROR;
-        }
-        break;
-    case LM832x_CMD_WRITE_PORT_SEL:
-        if (!byte)
-            s->gpio.dir = value;
-        else {
-            s->gpio.dir |= value << 8;
-            lm_kbd_gpio_update(s);
-            s->reg = LM832x_GENERAL_ERROR;
-        }
-        break;
-    case LM832x_CMD_WRITE_PORT_STATE:
-        if (!byte)
-            s->gpio.mask = value;
-        else {
-            s->gpio.mask |= value << 8;
-            lm_kbd_gpio_update(s);
-            s->reg = LM832x_GENERAL_ERROR;
-        }
-        break;
-
-    case LM832x_CMD_SET_ACTIVE:
-        s->acttime = value;
-        s->reg = LM832x_GENERAL_ERROR;
-        break;
-
-    case LM832x_CMD_SET_DEBOUNCE:
-        s->kbd.dbnctime = value;
-        s->reg = LM832x_GENERAL_ERROR;
-        if (!value)
-            lm_kbd_error(s, ERR_BADPAR);
-        break;
-
-    case LM832x_CMD_SET_KEY_SIZE:
-        s->kbd.size = value;
-        s->reg = LM832x_GENERAL_ERROR;
-        if (
-                        (value & 0xf) < 3 || (value & 0xf) > LM832x_MAX_KPY ||
-                        (value >> 4) < 3 || (value >> 4) > LM832x_MAX_KPX)
-            lm_kbd_error(s, ERR_BADPAR);
-        break;
-
-    case LM832x_CMD_WRITE_CLOCK:
-        s->clock = value;
-        s->reg = LM832x_GENERAL_ERROR;
-        if ((value & 3) && (value & 3) != 3) {
-            lm_kbd_error(s, ERR_BADPAR);
-            fprintf(stderr, "%s: invalid clock setting in RCPWM\n",
-                            __func__);
-        }
-        /* TODO: Validate that the command is only issued once */
-        break;
-
-    case LM832x_CMD_PWM_WRITE:
-        if (byte == 0) {
-            if (!(value & 3) || (value >> 2) > 59) {
-                lm_kbd_error(s, ERR_BADPAR);
-                s->reg = LM832x_GENERAL_ERROR;
-                break;
-            }
-
-            s->pwm.faddr = value;
-            s->pwm.file[s->pwm.faddr] = 0;
-        } else if (byte == 1) {
-            s->pwm.file[s->pwm.faddr] |= value << 8;
-        } else if (byte == 2) {
-            s->pwm.file[s->pwm.faddr] |= value << 0;
-            s->reg = LM832x_GENERAL_ERROR;
-        }
-        break;
-    case LM832x_CMD_PWM_START:
-        s->reg = LM832x_GENERAL_ERROR;
-        if (!(value & 3) || (value >> 2) > 59) {
-            lm_kbd_error(s, ERR_BADPAR);
-            break;
-        }
-
-        s->pwm.addr[(value & 3) - 1] = value >> 2;
-        lm_kbd_pwm_start(s, (value & 3) - 1);
-        break;
-    case LM832x_CMD_PWM_STOP:
-        s->reg = LM832x_GENERAL_ERROR;
-        if (!(value & 3)) {
-            lm_kbd_error(s, ERR_BADPAR);
-            break;
-        }
-
-        timer_del(s->pwm.tm[(value & 3) - 1]);
-        break;
-
-    case LM832x_GENERAL_ERROR:
-        lm_kbd_error(s, ERR_BADPAR);
-        break;
-    default:
-        lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
-        break;
-    }
-}
-
-static int lm_i2c_event(I2CSlave *i2c, enum i2c_event event)
-{
-    LM823KbdState *s = LM8323(i2c);
-
-    switch (event) {
-    case I2C_START_RECV:
-    case I2C_START_SEND:
-        s->i2c_cycle = 0;
-        s->i2c_dir = (event == I2C_START_SEND);
-        break;
-
-    default:
-        break;
-    }
-
-    return 0;
-}
-
-static uint8_t lm_i2c_rx(I2CSlave *i2c)
-{
-    LM823KbdState *s = LM8323(i2c);
-
-    return lm_kbd_read(s, s->reg, s->i2c_cycle ++);
-}
-
-static int lm_i2c_tx(I2CSlave *i2c, uint8_t data)
-{
-    LM823KbdState *s = LM8323(i2c);
-
-    if (!s->i2c_cycle)
-        s->reg = data;
-    else
-        lm_kbd_write(s, s->reg, s->i2c_cycle - 1, data);
-    s->i2c_cycle ++;
-
-    return 0;
-}
-
-static int lm_kbd_post_load(void *opaque, int version_id)
-{
-    LM823KbdState *s = opaque;
-
-    lm_kbd_irq_update(s);
-    lm_kbd_gpio_update(s);
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_lm_kbd = {
-    .name = "LM8323",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .post_load = lm_kbd_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_I2C_SLAVE(parent_obj, LM823KbdState),
-        VMSTATE_UINT8(i2c_dir, LM823KbdState),
-        VMSTATE_UINT8(i2c_cycle, LM823KbdState),
-        VMSTATE_UINT8(reg, LM823KbdState),
-        VMSTATE_UINT8(config, LM823KbdState),
-        VMSTATE_UINT8(status, LM823KbdState),
-        VMSTATE_UINT8(acttime, LM823KbdState),
-        VMSTATE_UINT8(error, LM823KbdState),
-        VMSTATE_UINT8(clock, LM823KbdState),
-        VMSTATE_UINT16(gpio.pull, LM823KbdState),
-        VMSTATE_UINT16(gpio.mask, LM823KbdState),
-        VMSTATE_UINT16(gpio.dir, LM823KbdState),
-        VMSTATE_UINT16(gpio.level, LM823KbdState),
-        VMSTATE_UINT8(kbd.dbnctime, LM823KbdState),
-        VMSTATE_UINT8(kbd.size, LM823KbdState),
-        VMSTATE_UINT8(kbd.start, LM823KbdState),
-        VMSTATE_UINT8(kbd.len, LM823KbdState),
-        VMSTATE_BUFFER(kbd.fifo, LM823KbdState),
-        VMSTATE_UINT16_ARRAY(pwm.file, LM823KbdState, 256),
-        VMSTATE_UINT8(pwm.faddr, LM823KbdState),
-        VMSTATE_BUFFER(pwm.addr, LM823KbdState),
-        VMSTATE_TIMER_PTR_ARRAY(pwm.tm, LM823KbdState, 3),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-
-static void lm8323_realize(DeviceState *dev, Error **errp)
-{
-    LM823KbdState *s = LM8323(dev);
-
-    s->model = 0x8323;
-    s->pwm.tm[0] = timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm0_tick, s);
-    s->pwm.tm[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm1_tick, s);
-    s->pwm.tm[2] = timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm2_tick, s);
-    qdev_init_gpio_out(dev, &s->nirq, 1);
-}
-
-void lm832x_key_event(DeviceState *dev, int key, int state)
-{
-    LM823KbdState *s = LM8323(dev);
-
-    if ((s->status & INT_ERROR) && (s->error & ERR_FIFOOVR))
-        return;
-
-    if (s->kbd.len >= sizeof(s->kbd.fifo)) {
-        lm_kbd_error(s, ERR_FIFOOVR);
-        return;
-    }
-
-    s->kbd.fifo[(s->kbd.start + s->kbd.len ++) & (sizeof(s->kbd.fifo) - 1)] =
-            key | (state << 7);
-
-    /* We never set ERR_KEYOVR because we support multiple keys fine.  */
-    s->status |= INT_KEYPAD;
-    lm_kbd_irq_update(s);
-}
-
-static void lm8323_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
-
-    device_class_set_legacy_reset(dc, lm_kbd_reset);
-    dc->realize = lm8323_realize;
-    k->event = lm_i2c_event;
-    k->recv = lm_i2c_rx;
-    k->send = lm_i2c_tx;
-    dc->vmsd = &vmstate_lm_kbd;
-}
-
-static const TypeInfo lm8323_info = {
-    .name          = TYPE_LM8323,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(LM823KbdState),
-    .class_init    = lm8323_class_init,
-};
-
-static void lm832x_register_types(void)
-{
-    type_register_static(&lm8323_info);
-}
-
-type_init(lm832x_register_types)
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 6f3ffbc5aa1..a116cb82dff 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -1,10 +1,6 @@
 config ADB
     bool
 
-config LM832X
-    bool
-    depends on I2C
-
 config PCKBD
     bool
     select PS2
diff --git a/hw/input/meson.build b/hw/input/meson.build
index f12796fb695..90a214962c7 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(files('hid.c'))
 system_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c'))
-system_ss.add(when: 'CONFIG_LM832X', if_true: files('lm832x.c'))
 system_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
 system_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
 system_ss.add(when: 'CONFIG_PS2', if_true: files('ps2.c'))
-- 
2.34.1


