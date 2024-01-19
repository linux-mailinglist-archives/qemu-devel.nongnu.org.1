Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE3832A56
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQork-0004xf-51; Fri, 19 Jan 2024 08:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQorh-0004w2-7X
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:24:57 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQord-0006WL-R6
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:24:56 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-559de6145c3so844331a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 05:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705670692; x=1706275492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46YiY2CEk5qY+rzHSC7rrIsEJwDXdSPiYCQhhnqgWUg=;
 b=fBFKeyHMxt0LIe455+sEl1zkGklFV9VpfeQuHOLAdwXQQCYUbOAisTYgO4Vce4mE4M
 8HXbXZ8nT/k+mavngdBdVUnuL2nKTIWIzrCYDz90r6X4sq7qs237C8QyDDcTypIey1F+
 BqcnJZ831NTZsUEk5TWGxL+XGXmGXi7LeOfd91vGc2gdJqvhXpkyOjrF2m/mYvthvksb
 CZmP0WTEQ79m/KjWGEP09oxZk7UGyj1t75c/AVc4gefsdcXl4v1rSSiseY7FQGy/qS4g
 ZpyMMu0PQsYEgmWmYbsyU2xHhJnjXGmIJsR4n5Vf0f+A6feWP+srWD8ORL2d/iCNcAAp
 /RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705670692; x=1706275492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46YiY2CEk5qY+rzHSC7rrIsEJwDXdSPiYCQhhnqgWUg=;
 b=D7HJmK9SgCebKyRjfCTfGD0f0qx3MmZbEoIQAqr72I1m7VqXyB2PmzlGtHPghxkIGc
 6SnisrDBWCmwrfCl0T5RdT61t+P/SHMBtdXzDfBMZ5cw6LWYp51ZfZYRHkW6vd9yUYsA
 yjO6M2yZuC/bfSVQiK/uzJ88qlAaeH0P3E9OtZmFoqsvjCOILhDXZF+tfs2h/Xd5JgVm
 xa2Dt7B0R33nmXDw6djmThQTbLQSkzsy4V83nVhyh9Dy3kTUW7ctPWJ6IbIoivxUyHaH
 8XaULKQVIwASpCjgTKyW+3KxJbg++EMWy//DPMqZZq/FTdqQFe8BZ0fVDC+/tDXewmGl
 P/Yg==
X-Gm-Message-State: AOJu0YydEJ6Ex0w58YNFEUe8buQVcqZxsVu8qyL52DQBeq9Gu9Z68TQi
 SOyPKWmrq2Z+FmO98ruCsMmEnjg0zNEVbFVwPIZ+8YDl1ew0aO0vVhBWLdS/YiY1ehYm05Lzhvc
 pxZo=
X-Google-Smtp-Source: AGHT+IENp8muasuKq/i/1a39zy4Wl2/8UDdLhlmNZ42q7lXd1d929WXy1NPkktj6p0M8fw/3xE7SmA==
X-Received: by 2002:aa7:d743:0:b0:558:322f:3bcb with SMTP id
 a3-20020aa7d743000000b00558322f3bcbmr1636635eds.57.1705670692177; 
 Fri, 19 Jan 2024 05:24:52 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 b11-20020aa7dc0b000000b00558fc426affsm8568310edu.88.2024.01.19.05.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 05:24:51 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/5] hw/arm/z2: convert DPRINTF to trace events and guest
 errors
Date: Fri, 19 Jan 2024 15:24:43 +0200
Message-Id: <339219e962d90f47cf125f2be2d64afb0833e905.1705670342.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
References: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. DPRINTFs that report guest errors are logged with
LOG_GUEST_ERROR.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/strongarm.c  | 55 ++++++++++++++++++++++-----------------------
 hw/arm/trace-events | 10 +++++++++
 hw/arm/z2.c         | 27 +++++++---------------
 3 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index fef3638aca..9fca0b302c 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -46,8 +46,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qom/object.h"
-
-//#define DEBUG
+#include "trace.h"
 
 /*
  TODO
@@ -66,12 +65,6 @@
  - Enhance UART with modem signals
  */
 
-#ifdef DEBUG
-# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
-#else
-# define DPRINTF(format, ...) do { } while (0)
-#endif
-
 static struct {
     hwaddr io_base;
     int irq;
@@ -151,8 +144,9 @@ static uint64_t strongarm_pic_mem_read(void *opaque, hwaddr offset,
     case ICPR:
         return s->pending;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Bad pic mem register read offset 0x%zu",
+                      offset);
         return 0;
     }
 }
@@ -173,8 +167,9 @@ static void strongarm_pic_mem_write(void *opaque, hwaddr offset,
         s->int_idle = (value & 1) ? 0 : ~0;
         break;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                     "Bad pic mem register write offset 0x%zu",
+                      offset);
         break;
     }
     strongarm_pic_update(s);
@@ -333,7 +328,7 @@ static uint64_t strongarm_rtc_read(void *opaque, hwaddr addr,
                 ((qemu_clock_get_ms(rtc_clock) - s->last_hz) << 15) /
                 (1000 * ((s->rttr & 0xffff) + 1));
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad rtc register read 0x%zu", addr);
         return 0;
     }
 }
@@ -375,7 +370,7 @@ static void strongarm_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad rtc register write 0x%zu", addr);
     }
 }
 
@@ -581,7 +576,7 @@ static uint64_t strongarm_gpio_read(void *opaque, hwaddr offset,
         return s->status;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad gpio read offset 0x%zu", offset);
     }
 
     return 0;
@@ -626,7 +621,7 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad gpio write offset 0x%zu", offset);
     }
 }
 
@@ -782,7 +777,7 @@ static uint64_t strongarm_ppc_read(void *opaque, hwaddr offset,
         return s->ppfr | ~0x7f001;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad ppc read offset 0x%zu", offset);
     }
 
     return 0;
@@ -817,7 +812,7 @@ static void strongarm_ppc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad ppc write offset 0x%zu", offset);
     }
 }
 
@@ -1029,8 +1024,11 @@ static void strongarm_uart_update_parameters(StrongARMUARTState *s)
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
-    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n", s->chr->label,
-            speed, parity, data_bits, stop_bits);
+    trace_strongarm_uart_update_parameters(s->chr.chr->label?:"NULL",
+                                           speed,
+                                           parity,
+                                           data_bits,
+                                           stop_bits);
 }
 
 static void strongarm_uart_rx_to(void *opaque)
@@ -1164,7 +1162,7 @@ static uint64_t strongarm_uart_read(void *opaque, hwaddr addr,
         return s->utsr1;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad uart register read 0x%zu", addr);
         return 0;
     }
 }
@@ -1221,7 +1219,7 @@ static void strongarm_uart_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad uart register write 0x%zu", addr);
     }
 }
 
@@ -1434,7 +1432,7 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
             return 0xffffffff;
         }
         if (s->rx_level < 1) {
-            printf("%s: SSP Rx Underrun\n", __func__);
+            trace_strongarm_ssp_read_underrun();
             return 0xffffffff;
         }
         s->rx_level--;
@@ -1443,7 +1441,7 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
         strongarm_ssp_fifo_update(s);
         return retval;
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad ssp register read 0x%zu", addr);
         break;
     }
     return 0;
@@ -1458,8 +1456,9 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR0:
         s->sscr[0] = value & 0xffbf;
         if ((s->sscr[0] & SSCR0_SSE) && SSCR0_DSS(value) < 4) {
-            printf("%s: Wrong data size: %i bits\n", __func__,
-                   (int)SSCR0_DSS(value));
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Wrong data size: %i bits",
+                          (int)SSCR0_DSS(value));
         }
         if (!(value & SSCR0_SSE)) {
             s->sssr = 0;
@@ -1471,7 +1470,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR1:
         s->sscr[1] = value & 0x2f;
         if (value & SSCR1_LBM) {
-            printf("%s: Attempt to use SSP LBM mode\n", __func__);
+            qemu_log_mask(LOG_GUEST_ERROR, "Attempt to use SSP LBM mode");
         }
         strongarm_ssp_fifo_update(s);
         break;
@@ -1509,7 +1508,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "Bad ssp register write 0x%zu", addr);
         break;
     }
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cdc1ea06a8..b0a56fcdc6 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,3 +55,13 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# z2.c
+z2_lcd_reg_update(uint8_t cur, uint8_t _0, uint8_t _1, uint8_t _2, uint32_t value) "cur_reg = 0x%xd, buf = [0x%xd, 0x%xd, 0x%xd], value = 0x%x"
+z2_lcd_enable_disable_result(const char * result) "LCD %s"
+z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
+z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
+z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
+
+# strongarm.c
+strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
+strongarm_ssp_read_underrun(void) "SSP rx underrun"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 83741a4909..147a5f9857 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -28,13 +28,7 @@
 #include "cpu.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-
-#ifdef DEBUG_Z2
-#define DPRINTF(fmt, ...) \
-        printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 static const struct keymap map[0x100] = {
     [0 ... 0xff] = { -1, -1 },
@@ -120,6 +114,8 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
 {
     ZipitLCD *z = ZIPIT_LCD(dev);
     uint16_t val;
+
+    trace_z2_lcd_reg_update(z->cur_reg, z->buf[0], z->buf[1], z->buf[2], value);
     if (z->selected) {
         z->buf[z->pos] = value & 0xff;
         z->pos++;
@@ -127,22 +123,19 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
     if (z->pos == 3) {
         switch (z->buf[0]) {
         case 0x74:
-            DPRINTF("%s: reg: 0x%.2x\n", __func__, z->buf[2]);
             z->cur_reg = z->buf[2];
             break;
         case 0x76:
             val = z->buf[1] << 8 | z->buf[2];
-            DPRINTF("%s: value: 0x%.4x\n", __func__, val);
             if (z->cur_reg == 0x22 && val == 0x0000) {
                 z->enabled = 1;
-                printf("%s: LCD enabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("enabled");
             } else if (z->cur_reg == 0x10 && val == 0x0000) {
                 z->enabled = 0;
-                printf("%s: LCD disabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("disabled");
             }
             break;
         default:
-            DPRINTF("%s: unknown command!\n", __func__);
             break;
         }
         z->pos = 0;
@@ -212,14 +205,12 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
 
     s->buf[s->len] = data;
     if (s->len++ > 2) {
-        DPRINTF("%s: message too long (%i bytes)\n",
-            __func__, s->len);
+        trace_z2_aer915_send_too_long(s->len);
         return 1;
     }
 
     if (s->len == 2) {
-        DPRINTF("%s: reg %d value 0x%02x\n", __func__,
-                s->buf[0], s->buf[1]);
+        trace_z2_aer915_send(s->buf[0], s->buf[1]);
     }
 
     return 0;
@@ -229,14 +220,12 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event event)
 {
     AER915State *s = AER915(i2c);
 
+    trace_z2_aer915_event(s->len, event);
     switch (event) {
     case I2C_START_SEND:
         s->len = 0;
         break;
     case I2C_START_RECV:
-        if (s->len != 1) {
-            DPRINTF("%s: short message!?\n", __func__);
-        }
         break;
     case I2C_FINISH:
         break;
-- 
γαῖα πυρί μιχθήτω


