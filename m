Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C2832A5F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:26:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQorh-0004vc-DD; Fri, 19 Jan 2024 08:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQorf-0004uz-R1
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:24:55 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQord-0006UF-4h
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:24:55 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a3a2fec1bso812440a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705670691; x=1706275491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+T8RIOEQPRcMJZsgbLWxYT1ca7xyW1DLwtPR8phAymY=;
 b=B6x1XUSf3aUPFjjfEKM3Mv4SWOGltKh8DfxheWdvKObIOpt7xiV4KDAjdfqT7+f94k
 ZMg7pUMilp9/B8ENl1M7Woug5FfBFlWyni+bIePNTF6tDK9NoJw+N2CGTO0HcB9sEdhM
 VydL2+7M3pnts+UDXnAZWXL2YJpfT/n9CIW97w0F8pQJw2e/YTKeje8QkHfzuYLxmSU+
 t1OaKvasK2X5ZGV1xrFrRkdqiyCzsWeiYu7SHCLWwL3+XdhiptTT6uNkydbQacJA74L0
 CXpHLDdtBl62vtqveNP3XKznjzI6LGyaXQXTRkXCclT7+uU1MuPrdp7MQItC/dvyQo5U
 w2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705670691; x=1706275491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+T8RIOEQPRcMJZsgbLWxYT1ca7xyW1DLwtPR8phAymY=;
 b=VJjEE2ar+T+hYJj3RK3Qkph4EipYQS7Qu5QzxOymUWwzgsXDpeEe2M1UNkyzkte483
 udm78PlFh5O7HoSa2VZpQcoA62qA9HYYUjAgyKVvAXAxWVcweyI7SZEiZWWNZPesURrH
 o3n0tGQH+OTESWZo/7QuDJrNSSVTT7rSzleOiMZcSkHN/yHAlYqjM5V77UfjvGMh67wz
 AB+KLj1jB7fP5UF/Z8oGT4nqWweuxmqkVQU4xnOu4Dy/+YOYUvP/a6SdcK3vwNuHyek2
 klpCZHxRzrsWNoDQlEpNSdbd2hxD4cReWTF/9qjo9B37t1oXV/KriLR7gw26gm8DZ0Jo
 yX2Q==
X-Gm-Message-State: AOJu0YyUNtqq2derGI+0XQe+tnzexndP9v9yK2MR25/GRrYg11bFkLVp
 uqN8mfrZIgUL/yhgbz14pzX9EkWsD8WfA2ne3losH/UWJAdIQVYlD/RAM/DTefJEaz89K9jHq+v
 2enU=
X-Google-Smtp-Source: AGHT+IH02j12TkkwJ+aVLwll6KgcW8NdLsxmRj8ev6W7H46ZVDEqtXSkiGJYs48zLMSDy+bkv6JCrw==
X-Received: by 2002:a50:ec99:0:b0:559:4f8:36a9 with SMTP id
 e25-20020a50ec99000000b0055904f836a9mr720444edr.11.1705670690707; 
 Fri, 19 Jan 2024 05:24:50 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 b11-20020aa7dc0b000000b00558fc426affsm8568310edu.88.2024.01.19.05.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 05:24:50 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/5] hw/{arm,xen} convert printfs to trace/reports
Date: Fri, 19 Jan 2024 15:24:42 +0200
Message-Id: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

This series changes some printfs to use the trace event framework. 
Additionally, it converts some error/warning reporting fprintfs to 
error_report/warn_report.

Differences from v1 
<cover.1705662313.git.manos.pitsidianakis@linaro.org>:
    - addressed Alex's review

Manos Pitsidianakis (5):
  hw/arm/z2: convert DPRINTF to trace events and guest errors
  hw/arm/xen_arm.c: convert DPRINTF to trace events and error/warn
    reports
  hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
  hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
  hw/xen: convert stderr prints to error/warn reports

 hw/arm/strongarm.c      | 55 +++++++++++++++++++-------------------
 hw/arm/trace-events     | 15 +++++++++++
 hw/arm/xen_arm.c        | 23 ++++++++--------
 hw/arm/z2.c             | 27 ++++++-------------
 hw/xen/trace-events     | 21 ++++++++++++++-
 hw/xen/xen-hvm-common.c | 47 ++++++++++++++++----------------
 hw/xen/xen-mapcache.c   | 59 ++++++++++++++++++-----------------------
 7 files changed, 131 insertions(+), 116 deletions(-)

Range-diff against v1:
1:  021405f5ef < -:  ---------- hw/arm/z2: convert DPRINTF to tracepoints
2:  3c6fbd73a1 ! 1:  339219e962 hw/arm/strongarm.c: convert DPRINTF to tracepoints
    @@ Metadata
     Author: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## Commit message ##
    -    hw/arm/strongarm.c: convert DPRINTF to tracepoints
    +    hw/arm/z2: convert DPRINTF to trace events and guest errors
     
         Tracing DPRINTFs to stderr might not be desired. A developer that relies
    -    on tracepoints should be able to opt-in to each tracepoint and rely on
    +    on trace events should be able to opt-in to each trace event and rely on
         QEMU's log redirection, instead of stderr by default.
     
         This commit converts DPRINTFs in this file that are used for tracing
    -    into tracepoints.
    +    into trace events. DPRINTFs that report guest errors are logged with
    +    LOG_GUEST_ERROR.
     
         Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
    @@ hw/arm/strongarm.c: static uint64_t strongarm_pic_mem_read(void *opaque, hwaddr
          default:
     -        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
     -                        __func__, offset);
    -+        trace_strongarm_pic_mem_read(offset);
    ++        qemu_log_mask(LOG_GUEST_ERROR,
    ++                      "Bad pic mem register read offset 0x%zu",
    ++                      offset);
              return 0;
          }
      }
    @@ hw/arm/strongarm.c: static void strongarm_pic_mem_write(void *opaque, hwaddr off
          default:
     -        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
     -                        __func__, offset);
    -+        trace_strongarm_pic_mem_write(offset);
    ++        qemu_log_mask(LOG_GUEST_ERROR,
    ++                     "Bad pic mem register write offset 0x%zu",
    ++                      offset);
              break;
          }
          strongarm_pic_update(s);
    @@ hw/arm/strongarm.c: static uint64_t strongarm_rtc_read(void *opaque, hwaddr addr
                      (1000 * ((s->rttr & 0xffff) + 1));
          default:
     -        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
    -+        trace_strongarm_rtc_read(addr);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad rtc register read 0x%zu", addr);
              return 0;
          }
      }
    @@ hw/arm/strongarm.c: static void strongarm_rtc_write(void *opaque, hwaddr addr,
      
          default:
     -        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
    -+        trace_strongarm_rtc_write(addr);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad rtc register write 0x%zu", addr);
          }
      }
      
    @@ hw/arm/strongarm.c: static uint64_t strongarm_gpio_read(void *opaque, hwaddr off
      
          default:
     -        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
    -+        trace_strongarm_gpio_read(offset);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad gpio read offset 0x%zu", offset);
          }
      
          return 0;
    @@ hw/arm/strongarm.c: static void strongarm_gpio_write(void *opaque, hwaddr offset
      
          default:
     -        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
    -+        trace_strongarm_gpio_write(offset);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad gpio write offset 0x%zu", offset);
          }
      }
      
    @@ hw/arm/strongarm.c: static uint64_t strongarm_ppc_read(void *opaque, hwaddr offs
      
          default:
     -        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
    -+        trace_strongarm_ppc_read(offset);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad ppc read offset 0x%zu", offset);
          }
      
          return 0;
    @@ hw/arm/strongarm.c: static void strongarm_ppc_write(void *opaque, hwaddr offset,
      
          default:
     -        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
    -+        trace_strongarm_ppc_write(offset);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad ppc write offset 0x%zu", offset);
          }
      }
      
    @@ hw/arm/strongarm.c: static uint64_t strongarm_uart_read(void *opaque, hwaddr add
      
          default:
     -        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
    -+        trace_strongarm_uart_read_bad_register(addr);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad uart register read 0x%zu", addr);
              return 0;
          }
      }
    @@ hw/arm/strongarm.c: static void strongarm_uart_write(void *opaque, hwaddr addr,
      
          default:
     -        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
    -+        trace_strongarm_uart_write_bad_register(addr);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad uart register write 0x%zu", addr);
          }
      }
      
    @@ hw/arm/strongarm.c: static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr
              return retval;
          default:
     -        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
    -+        trace_strongarm_ssp_read(addr);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad ssp register read 0x%zu", addr);
              break;
          }
          return 0;
    @@ hw/arm/strongarm.c: static void strongarm_ssp_write(void *opaque, hwaddr addr,
              if ((s->sscr[0] & SSCR0_SSE) && SSCR0_DSS(value) < 4) {
     -            printf("%s: Wrong data size: %i bits\n", __func__,
     -                   (int)SSCR0_DSS(value));
    -+            trace_strongarm_ssp_write_wrong_data_size((int)SSCR0_DSS(value));
    ++            qemu_log_mask(LOG_GUEST_ERROR,
    ++                          "Wrong data size: %i bits",
    ++                          (int)SSCR0_DSS(value));
              }
              if (!(value & SSCR0_SSE)) {
                  s->sssr = 0;
    @@ hw/arm/strongarm.c: static void strongarm_ssp_write(void *opaque, hwaddr addr,
              s->sscr[1] = value & 0x2f;
              if (value & SSCR1_LBM) {
     -            printf("%s: Attempt to use SSP LBM mode\n", __func__);
    -+            trace_strongarm_ssp_write_wrong_data_size_invalid();
    ++            qemu_log_mask(LOG_GUEST_ERROR, "Attempt to use SSP LBM mode");
              }
              strongarm_ssp_fifo_update(s);
              break;
    @@ hw/arm/strongarm.c: static void strongarm_ssp_write(void *opaque, hwaddr addr,
      
          default:
     -        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
    -+        trace_strongarm_ssp_write_bad_register(addr);
    ++        qemu_log_mask(LOG_GUEST_ERROR, "Bad ssp register write 0x%zu", addr);
              break;
          }
      }
     
      ## hw/arm/trace-events ##
    -@@ hw/arm/trace-events: z2_lcd_invalid_command(uint8_t value) "0x%x"
    - z2_aer915_send_too_log(int8_t msg) "message too long (%i bytes)"
    - z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
    - z2_aer915_i2c_start_recv(uint16_t len) "I2C_START_RECV: short message with len %d"
    +@@ hw/arm/trace-events: smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
    + smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
    + smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
    + 
    ++# z2.c
    ++z2_lcd_reg_update(uint8_t cur, uint8_t _0, uint8_t _1, uint8_t _2, uint32_t value) "cur_reg = 0x%xd, buf = [0x%xd, 0x%xd, 0x%xd], value = 0x%x"
    ++z2_lcd_enable_disable_result(const char * result) "LCD %s"
    ++z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
    ++z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
    ++z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
     +
     +# strongarm.c
     +strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
    -+strongarm_uart_read_bad_register(uint64_t addr) "Bad uart register 0x%zu"
    -+strongarm_uart_write_bad_register(uint64_t addr) "Bad uart register 0x%zu"
    -+strongarm_pic_mem_read(uint64_t offset) "Bad pic mem register read offset 0x%zu"
    -+strongarm_pic_mem_write(uint64_t offset) "Bad pic mem register write offset 0x%zu"
    -+strongarm_rtc_read(uint64_t addr) "Bad rtc register read 0x%zu"
    -+strongarm_rtc_write(uint64_t addr) "Bad rtc register write 0x%zu"
    -+strongarm_gpio_read(uint64_t offset) "Bad gpio read offset 0x%zu"
    -+strongarm_gpio_write(uint64_t offset) "Bad gpio write offset 0x%zu"
    -+strongarm_ppc_write(uint64_t offset) "Bad ppc write offset 0x%zu"
    -+strongarm_ppc_read(uint64_t offset) "Bad ppc write offset 0x%zu"
    -+strongarm_ssp_read_underrun(void) "SSP Rx Underrun"
    -+strongarm_ssp_read(uint64_t addr) "Bad register 0x%zu"
    -+strongarm_ssp_write_wrong_data_size(int v) "Wrong data size: %i bits"
    -+strongarm_ssp_write_wrong_data_size_invalid(void) "Attempt to use SSP LBM mode"
    -+strongarm_ssp_write_bad_register(uint64_t addr) "Bad register 0x%zu"
    ++strongarm_ssp_read_underrun(void) "SSP rx underrun"
    +
    + ## hw/arm/z2.c ##
    +@@
    + #include "cpu.h"
    + #include "qom/object.h"
    + #include "qapi/error.h"
    +-
    +-#ifdef DEBUG_Z2
    +-#define DPRINTF(fmt, ...) \
    +-        printf(fmt, ## __VA_ARGS__)
    +-#else
    +-#define DPRINTF(fmt, ...)
    +-#endif
    ++#include "trace.h"
    + 
    + static const struct keymap map[0x100] = {
    +     [0 ... 0xff] = { -1, -1 },
    +@@ hw/arm/z2.c: static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
    + {
    +     ZipitLCD *z = ZIPIT_LCD(dev);
    +     uint16_t val;
    ++
    ++    trace_z2_lcd_reg_update(z->cur_reg, z->buf[0], z->buf[1], z->buf[2], value);
    +     if (z->selected) {
    +         z->buf[z->pos] = value & 0xff;
    +         z->pos++;
    +@@ hw/arm/z2.c: static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
    +     if (z->pos == 3) {
    +         switch (z->buf[0]) {
    +         case 0x74:
    +-            DPRINTF("%s: reg: 0x%.2x\n", __func__, z->buf[2]);
    +             z->cur_reg = z->buf[2];
    +             break;
    +         case 0x76:
    +             val = z->buf[1] << 8 | z->buf[2];
    +-            DPRINTF("%s: value: 0x%.4x\n", __func__, val);
    +             if (z->cur_reg == 0x22 && val == 0x0000) {
    +                 z->enabled = 1;
    +-                printf("%s: LCD enabled\n", __func__);
    ++                trace_z2_lcd_enable_disable_result("enabled");
    +             } else if (z->cur_reg == 0x10 && val == 0x0000) {
    +                 z->enabled = 0;
    +-                printf("%s: LCD disabled\n", __func__);
    ++                trace_z2_lcd_enable_disable_result("disabled");
    +             }
    +             break;
    +         default:
    +-            DPRINTF("%s: unknown command!\n", __func__);
    +             break;
    +         }
    +         z->pos = 0;
    +@@ hw/arm/z2.c: static int aer915_send(I2CSlave *i2c, uint8_t data)
    + 
    +     s->buf[s->len] = data;
    +     if (s->len++ > 2) {
    +-        DPRINTF("%s: message too long (%i bytes)\n",
    +-            __func__, s->len);
    ++        trace_z2_aer915_send_too_long(s->len);
    +         return 1;
    +     }
    + 
    +     if (s->len == 2) {
    +-        DPRINTF("%s: reg %d value 0x%02x\n", __func__,
    +-                s->buf[0], s->buf[1]);
    ++        trace_z2_aer915_send(s->buf[0], s->buf[1]);
    +     }
    + 
    +     return 0;
    +@@ hw/arm/z2.c: static int aer915_event(I2CSlave *i2c, enum i2c_event event)
    + {
    +     AER915State *s = AER915(i2c);
    + 
    ++    trace_z2_aer915_event(s->len, event);
    +     switch (event) {
    +     case I2C_START_SEND:
    +         s->len = 0;
    +         break;
    +     case I2C_START_RECV:
    +-        if (s->len != 1) {
    +-            DPRINTF("%s: short message!?\n", __func__);
    +-        }
    +         break;
    +     case I2C_FINISH:
    +         break;
3:  49905a0d22 ! 2:  c7eb8943f0 hw/arm/xen_arm.c: replace DPRINTF with traces
    @@ Metadata
     Author: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## Commit message ##
    -    hw/arm/xen_arm.c: replace DPRINTF with traces
    +    hw/arm/xen_arm.c: convert DPRINTF to trace events and error/warn reports
    +
    +    Tracing DPRINTFs to stderr might not be desired. A developer that relies
    +    on trace events should be able to opt-in to each trace event and rely on
    +    QEMU's log redirection, instead of stderr by default.
    +
    +    This commit converts DPRINTFs in this file that are used for tracing
    +    into trace events. Errors or warnings are converted to error_report and
    +    warn_report calls.
     
         Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/arm/trace-events ##
    -@@ hw/arm/trace-events: strongarm_ssp_read(uint64_t addr) "Bad register 0x%zu"
    - strongarm_ssp_write_wrong_data_size(int v) "Wrong data size: %i bits"
    - strongarm_ssp_write_wrong_data_size_invalid(void) "Attempt to use SSP LBM mode"
    - strongarm_ssp_write_bad_register(uint64_t addr) "Bad register 0x%zu"
    +@@ hw/arm/trace-events: z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
    + # strongarm.c
    + strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
    + strongarm_ssp_read_underrun(void) "SSP rx underrun"
     +
     +# xen_arm.c
     +xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%lx"
    -+xen_init_ram(const char *hi_xor_low, uint64_t base, uint64_t size) "Initialized region xen.ram.%s: base 0x%lx size 0x%lx"
    -+xen_enable_tpm_not_found(void) "Couldn't find tmp0 backend"
    ++xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%lx"
     +xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%lx"
    -+xen_arm_init(const char *msg) "%s"
     
      ## hw/arm/xen_arm.c ##
     @@
    @@ hw/arm/xen_arm.c: static void xen_create_virtio_mmio_devices(XenArmState *xam)
      }
      
     @@ hw/arm/xen_arm.c: static void xen_init_ram(MachineState *machine)
    +     MemoryRegion *sysmem = get_system_memory();
    +     ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
    + 
    ++    trace_xen_init_ram(machine->ram_size);
    +     if (machine->ram_size <= GUEST_RAM0_SIZE) {
    +         ram_size[0] = machine->ram_size;
    +         ram_size[1] = 0;
    +@@ hw/arm/xen_arm.c: static void xen_init_ram(MachineState *machine)
          memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
                                   GUEST_RAM0_BASE, ram_size[0]);
          memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
     -    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
     -            GUEST_RAM0_BASE, ram_size[0]);
    -+    trace_xen_init_ram("lo", GUEST_RAM0_BASE, ram_size[0]);
    - 
    +-
          if (ram_size[1] > 0) {
              memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
                                       GUEST_RAM1_BASE, ram_size[1]);
              memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     -        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
     -                GUEST_RAM1_BASE, ram_size[1]);
    -+        trace_xen_init_ram("hi", GUEST_RAM1_BASE, ram_size[1]);
          }
      }
      
    @@ hw/arm/xen_arm.c: static void xen_enable_tpm(XenArmState *xam)
          TPMBackend *be = qemu_find_tpm_be("tpm0");
          if (be == NULL) {
     -        DPRINTF("Couldn't fine the backend for tpm0\n");
    -+        trace_xen_enable_tpm_not_found();
    ++        error_report("Couldn't find tmp0 backend");
              return;
          }
          dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
    @@ hw/arm/xen_arm.c: static void xen_arm_init(MachineState *machine)
          if (machine->ram_size == 0) {
     -        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
     -                "(no emulated devices including Virtio)\n");
    -+        trace_xen_arm_init("ram_size not specified. "
    -+                           "QEMU machine started "
    -+                           "without IOREQ "
    -+                           "(no emulated devices"
    -+                           "including Virtio)");
    ++        warn_report("%s non-zero ram size not specified. QEMU machine started"
    ++                    " without IOREQ (no emulated devices including virtio)",
    ++                    MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
              return;
          }
      
    @@ hw/arm/xen_arm.c: static void xen_arm_init(MachineState *machine)
              xen_enable_tpm(xam);
          } else {
     -        DPRINTF("tpm-base-addr is not provided. TPM will not be enabled\n");
    -+        trace_xen_arm_init("tpm-base-addr is not provided."
    -+                           "TPM will not be enabled");
    ++        warn_report("tpm-base-addr is not provided. TPM will not be enabled");
          }
      #endif
      }
4:  c5c74aadad = 3:  d5493e864f hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
5:  d1f96a077b = 4:  651ad62da1 hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
6:  a741c52584 = 5:  bf55043690 hw/xen: convert stderr prints to error/warn reports

base-commit: d0f4aa7d50d485b1fb5ec8ab6f934e5df852ab07
-- 
γαῖα πυρί μιχθήτω


