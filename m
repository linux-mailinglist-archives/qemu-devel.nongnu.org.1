Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347B8328A1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:15:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmpj-0007aI-Bo; Fri, 19 Jan 2024 06:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpa-0007Wq-Rq
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:40 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpU-0007Ju-Ko
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:37 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2c375d2430so71724466b.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705662870; x=1706267670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axwu9OirAAbfzNHj3iKrYWOaH6e1S20UxGk7oz9UvVY=;
 b=w2mbi0dv13ztU+bxrBMwatv5EXYcDuW4HQILSS/RCKWZqfqa0Icu6gkIrZC8FUTdY8
 +nlo9Kw1GrZXYd9ujl/5XCwAPV3HQqN6+p1R8UsoiXZgbRyKzcYHq88pxhD4GCWXuID/
 h8doPxrnXKUG1t+wnE1N419e2+CD/WTCw7l2pKG2FvWDJ0Fum8pxYH1tNxsLRqztBlyR
 GDBwgP4hP5r1Q8SwOJ3grDxJsPo/G7NOVohI8hkIf4bxyvTwNBnxN8w6Fphaq8MCIZaj
 s2iRUdj2J5zqO0qL/nMimF7jjy/OVDU4CHveAMb6YJrA8fA70oECdY87Dtk3rl8Ez4JH
 aNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662870; x=1706267670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axwu9OirAAbfzNHj3iKrYWOaH6e1S20UxGk7oz9UvVY=;
 b=QwVNj9saBKMyvY5QfeG5k3Ee+mBidL6USlQu4VeC9GGJMpGAUDOuWrg302rHMFHRgY
 mSytz/kHdIv1SiLZSqCWzhDAxJ2ksgtCa0PdrP30bdZqcpwzhXTW+e1JD4Um9vJG5JIb
 vbK5/bjVPCh1O2L8jVs8txV0hs5m5S2/CGWZ3OQurW95Peeooo6lnoFTP+E4aWT6LtqE
 j4pHDk7L8pQBboRkWbxTZuLKoP8+bgNHSy38a1HqPy7YKGlt1RdzAGvSWyMKUPPUdly7
 aRNbUm4Rk0R/hv0UeelupoH9sY0WXaL3NW/KbZ/KzvDJisjC4j9+0uOqPZ/HvxDanF+b
 TnlA==
X-Gm-Message-State: AOJu0YyDkuF3smg+BYul1Ash5V+YmA2VGKZHpaTflB8bhkKCaAQOM0bC
 eFqM9ftsDvIDg+YFy4RuuHxAdmfYz+/TH2IldsX3WN1PArzi4HVT+SxKERKm6Ksg4vI4QRnDHEe
 RWbc=
X-Google-Smtp-Source: AGHT+IHARoneApKjgPLy58+Put03cP3Oze0dmwhxjxb5Lpeq9M94R8OhG7zIpSvJ9lel5kPZR1bh1g==
X-Received: by 2002:a17:907:d510:b0:a2f:3f0f:964c with SMTP id
 wb16-20020a170907d51000b00a2f3f0f964cmr950846ejc.98.1705662870043; 
 Fri, 19 Jan 2024 03:14:30 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.227.tellas.gr.
 [109.242.227.114]) by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm9283321ejc.120.2024.01.19.03.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:14:29 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/6] hw/arm/strongarm.c: convert DPRINTF to tracepoints
Date: Fri, 19 Jan 2024 13:14:20 +0200
Message-Id: <3c6fbd73a14fdf120a6b0c1e168e5469acd00306.1705662313.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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
on tracepoints should be able to opt-in to each tracepoint and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into tracepoints.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/strongarm.c  | 49 +++++++++++++++++++--------------------------
 hw/arm/trace-events | 18 +++++++++++++++++
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index fef3638aca..3ff748e826 100644
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
@@ -151,8 +144,7 @@ static uint64_t strongarm_pic_mem_read(void *opaque, hwaddr offset,
     case ICPR:
         return s->pending;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        trace_strongarm_pic_mem_read(offset);
         return 0;
     }
 }
@@ -173,8 +165,7 @@ static void strongarm_pic_mem_write(void *opaque, hwaddr offset,
         s->int_idle = (value & 1) ? 0 : ~0;
         break;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        trace_strongarm_pic_mem_write(offset);
         break;
     }
     strongarm_pic_update(s);
@@ -333,7 +324,7 @@ static uint64_t strongarm_rtc_read(void *opaque, hwaddr addr,
                 ((qemu_clock_get_ms(rtc_clock) - s->last_hz) << 15) /
                 (1000 * ((s->rttr & 0xffff) + 1));
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        trace_strongarm_rtc_read(addr);
         return 0;
     }
 }
@@ -375,7 +366,7 @@ static void strongarm_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        trace_strongarm_rtc_write(addr);
     }
 }
 
@@ -581,7 +572,7 @@ static uint64_t strongarm_gpio_read(void *opaque, hwaddr offset,
         return s->status;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        trace_strongarm_gpio_read(offset);
     }
 
     return 0;
@@ -626,7 +617,7 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        trace_strongarm_gpio_write(offset);
     }
 }
 
@@ -782,7 +773,7 @@ static uint64_t strongarm_ppc_read(void *opaque, hwaddr offset,
         return s->ppfr | ~0x7f001;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        trace_strongarm_ppc_read(offset);
     }
 
     return 0;
@@ -817,7 +808,7 @@ static void strongarm_ppc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        trace_strongarm_ppc_write(offset);
     }
 }
 
@@ -1029,8 +1020,11 @@ static void strongarm_uart_update_parameters(StrongARMUARTState *s)
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
@@ -1164,7 +1158,7 @@ static uint64_t strongarm_uart_read(void *opaque, hwaddr addr,
         return s->utsr1;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        trace_strongarm_uart_read_bad_register(addr);
         return 0;
     }
 }
@@ -1221,7 +1215,7 @@ static void strongarm_uart_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        trace_strongarm_uart_write_bad_register(addr);
     }
 }
 
@@ -1434,7 +1428,7 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
             return 0xffffffff;
         }
         if (s->rx_level < 1) {
-            printf("%s: SSP Rx Underrun\n", __func__);
+            trace_strongarm_ssp_read_underrun();
             return 0xffffffff;
         }
         s->rx_level--;
@@ -1443,7 +1437,7 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
         strongarm_ssp_fifo_update(s);
         return retval;
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        trace_strongarm_ssp_read(addr);
         break;
     }
     return 0;
@@ -1458,8 +1452,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR0:
         s->sscr[0] = value & 0xffbf;
         if ((s->sscr[0] & SSCR0_SSE) && SSCR0_DSS(value) < 4) {
-            printf("%s: Wrong data size: %i bits\n", __func__,
-                   (int)SSCR0_DSS(value));
+            trace_strongarm_ssp_write_wrong_data_size((int)SSCR0_DSS(value));
         }
         if (!(value & SSCR0_SSE)) {
             s->sssr = 0;
@@ -1471,7 +1464,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR1:
         s->sscr[1] = value & 0x2f;
         if (value & SSCR1_LBM) {
-            printf("%s: Attempt to use SSP LBM mode\n", __func__);
+            trace_strongarm_ssp_write_wrong_data_size_invalid();
         }
         strongarm_ssp_fifo_update(s);
         break;
@@ -1509,7 +1502,7 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        trace_strongarm_ssp_write_bad_register(addr);
         break;
     }
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index a262ad2e6a..a6a67d5f16 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -63,3 +63,21 @@ z2_lcd_invalid_command(uint8_t value) "0x%x"
 z2_aer915_send_too_log(int8_t msg) "message too long (%i bytes)"
 z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
 z2_aer915_i2c_start_recv(uint16_t len) "I2C_START_RECV: short message with len %d"
+
+# strongarm.c
+strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
+strongarm_uart_read_bad_register(uint64_t addr) "Bad uart register 0x%zu"
+strongarm_uart_write_bad_register(uint64_t addr) "Bad uart register 0x%zu"
+strongarm_pic_mem_read(uint64_t offset) "Bad pic mem register read offset 0x%zu"
+strongarm_pic_mem_write(uint64_t offset) "Bad pic mem register write offset 0x%zu"
+strongarm_rtc_read(uint64_t addr) "Bad rtc register read 0x%zu"
+strongarm_rtc_write(uint64_t addr) "Bad rtc register write 0x%zu"
+strongarm_gpio_read(uint64_t offset) "Bad gpio read offset 0x%zu"
+strongarm_gpio_write(uint64_t offset) "Bad gpio write offset 0x%zu"
+strongarm_ppc_write(uint64_t offset) "Bad ppc write offset 0x%zu"
+strongarm_ppc_read(uint64_t offset) "Bad ppc write offset 0x%zu"
+strongarm_ssp_read_underrun(void) "SSP Rx Underrun"
+strongarm_ssp_read(uint64_t addr) "Bad register 0x%zu"
+strongarm_ssp_write_wrong_data_size(int v) "Wrong data size: %i bits"
+strongarm_ssp_write_wrong_data_size_invalid(void) "Attempt to use SSP LBM mode"
+strongarm_ssp_write_bad_register(uint64_t addr) "Bad register 0x%zu"
-- 
γαῖα πυρί μιχθήτω


