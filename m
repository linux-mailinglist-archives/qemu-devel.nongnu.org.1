Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD77E200E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:32:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxU8-0001Ph-QD; Mon, 06 Nov 2023 06:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxU5-0001H3-AH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:09:33 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxU0-0005TA-8Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:09:33 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso33493715e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268966; x=1699873766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjHtz+lPcIw6M6S7bcDq7sYVmI6jCo0hvfjVBU4M5Y0=;
 b=dxRKLRxS7P6J8gLspT56u4bESTfjapZzmI2cg9bzOES6xxXA+pEfLm9qztx8astJ6/
 WTSShcv1g6Jr3JqVOvMeNuO61D6B3tc1QXwRviKDpaymlaGlHtPsKrFQ5/uMv4Hpj+px
 75JHL6zjulfDUVziZcJSXU5R0ejX6infaXSYPnmPNhwyhUWgbgdeeoRK39TI3mbzciGl
 vlmBN1zbCIxAanBwB4VBfEth6Q/pB8Yz/IEd5eLTTRRt2Cu4bd3ooq+L+9rAKC9Yo8LZ
 XqDtNZMxiBUHretIxwWain1Gam73ixGrMw3Od6uVmMug+NGU6VNzl1ykKB8AQL+ckudi
 3MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268966; x=1699873766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjHtz+lPcIw6M6S7bcDq7sYVmI6jCo0hvfjVBU4M5Y0=;
 b=OxE9XwRqv6NTRkWATjQaLWMbZ1GFHN4aJU5wgbkx5OMcSzx11L4SW4SAalRXg6/R7O
 +8e12Uvdt53raRjlTiInOA8BlxDqR+mjj+MjSaIfaQ+ubvFHyTjOA7/iqkpIFnQq3g/m
 YWJhs37nXt0M66Gl44ZDW9ZybkdgUB/AjQMXxDRTFA4/LTzWLnxZ8wu6YysEKz+ojIB3
 rzaoh27aWnEKAUys7sJqdHec2Dn7MCAWBa6z0AQ9YuXkfWbM6WxGOQtiGrjekFH0He3y
 kz+zBT7sgls+wV1OKnyFOk9+r+TMWQvcWSYusdunGkzipd1ATEoKXxxKemaBT//vApSk
 laDQ==
X-Gm-Message-State: AOJu0YwLKm1dCDRov0pguYP2ooazqCKt27cgvyyerIkHRlYewHquw7OA
 7h1JUtSMBe7UEd8NVrKo6wse4LdwODVhxeCOUIU=
X-Google-Smtp-Source: AGHT+IG8Q4coZ+Ea54w4wY9DsUFuNEg759Mh+b6Z9wAr9dd+6s8Zg0s9ng5tqvrG8ylEYsTfJNq9ow==
X-Received: by 2002:a05:600c:4693:b0:409:5a92:472f with SMTP id
 p19-20020a05600c469300b004095a92472fmr11071290wmo.6.1699268966532; 
 Mon, 06 Nov 2023 03:09:26 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adfea46000000b0032fc609c118sm6076145wrn.66.2023.11.06.03.09.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:09:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Titus Rwantare <titusr@google.com>,
 Stephen Longfield <slongfield@google.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 51/60] hw/i2c: pmbus: add fan support
Date: Mon,  6 Nov 2023 12:03:23 +0100
Message-ID: <20231106110336.358-52-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Titus Rwantare <titusr@google.com>

PMBus devices may integrate fans whose operation is configurable
over PMBus. This commit allows the driver to read and write the
fan control registers but does not model the operation of fans.

Reviewed-by: Stephen Longfield <slongfield@google.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
Message-ID: <20231023-staging-pmbus-v3-v4-3-07a8cb7cd20a@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/pmbus_device.h |   1 +
 hw/i2c/pmbus_device.c         | 176 ++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index 2e95164aa1..ad431bdc7c 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -258,6 +258,7 @@ OBJECT_DECLARE_TYPE(PMBusDevice, PMBusDeviceClass,
 #define PB_HAS_TEMP2               BIT_ULL(41)
 #define PB_HAS_TEMP3               BIT_ULL(42)
 #define PB_HAS_TEMP_RATING         BIT_ULL(43)
+#define PB_HAS_FAN                 BIT_ULL(44)
 #define PB_HAS_MFR_INFO            BIT_ULL(50)
 #define PB_HAS_STATUS_MFR_SPECIFIC BIT_ULL(51)
 
diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index ea15490720..c1d8c93056 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -500,6 +500,54 @@ static uint8_t pmbus_receive_byte(SMBusDevice *smd)
         }
         break;
 
+    case PMBUS_FAN_CONFIG_1_2:            /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send8(pmdev, pmdev->pages[index].fan_config_1_2);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_1:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].fan_command_1);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_2:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].fan_command_2);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_FAN_CONFIG_3_4:            /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send8(pmdev, pmdev->pages[index].fan_config_3_4);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_3:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].fan_command_3);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_4:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].fan_command_4);
+        } else {
+            goto passthough;
+        }
+        break;
+
     case PMBUS_VOUT_OV_FAULT_LIMIT:       /* R/W word */
         if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
             pmbus_send16(pmdev, pmdev->pages[index].vout_ov_fault_limit);
@@ -810,6 +858,22 @@ static uint8_t pmbus_receive_byte(SMBusDevice *smd)
         pmbus_send8(pmdev, pmdev->pages[index].status_mfr_specific);
         break;
 
+    case PMBUS_STATUS_FANS_1_2:           /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send8(pmdev, pmdev->pages[index].status_fans_1_2);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_STATUS_FANS_3_4:           /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send8(pmdev, pmdev->pages[index].status_fans_3_4);
+        } else {
+            goto passthough;
+        }
+        break;
+
     case PMBUS_READ_EIN:                  /* Read-Only block 5 bytes */
         if (pmdev->pages[index].page_flags & PB_HAS_EIN) {
             pmbus_send(pmdev, pmdev->pages[index].read_ein, 5);
@@ -882,6 +946,54 @@ static uint8_t pmbus_receive_byte(SMBusDevice *smd)
         }
         break;
 
+    case PMBUS_READ_FAN_SPEED_1:          /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_fan_speed_1);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_READ_FAN_SPEED_2:          /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_fan_speed_2);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_READ_FAN_SPEED_3:          /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_fan_speed_3);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_READ_FAN_SPEED_4:          /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_fan_speed_4);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_READ_DUTY_CYCLE:           /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_duty_cycle);
+        } else {
+            goto passthough;
+        }
+        break;
+
+    case PMBUS_READ_FREQUENCY:            /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_frequency);
+        } else {
+            goto passthough;
+        }
+        break;
+
     case PMBUS_READ_POUT:                 /* Read-Only word */
         if (pmdev->pages[index].page_flags & PB_HAS_POUT) {
             pmbus_send16(pmdev, pmdev->pages[index].read_pout);
@@ -1305,6 +1417,54 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
         }
         break;
 
+    case PMBUS_FAN_CONFIG_1_2:            /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmdev->pages[index].fan_config_1_2 = pmbus_receive8(pmdev);
+        } else {
+            goto passthrough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_1:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmdev->pages[index].fan_command_1 = pmbus_receive16(pmdev);
+        } else {
+            goto passthrough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_2:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmdev->pages[index].fan_command_2 = pmbus_receive16(pmdev);
+        } else {
+            goto passthrough;
+        }
+        break;
+
+    case PMBUS_FAN_CONFIG_3_4:            /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmdev->pages[index].fan_config_3_4 = pmbus_receive8(pmdev);
+        } else {
+            goto passthrough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_3:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmdev->pages[index].fan_command_3 = pmbus_receive16(pmdev);
+        } else {
+            goto passthrough;
+        }
+        break;
+
+    case PMBUS_FAN_COMMAND_4:             /* R/W word */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmdev->pages[index].fan_command_4 = pmbus_receive16(pmdev);
+        } else {
+            goto passthrough;
+        }
+        break;
+
     case PMBUS_VOUT_OV_FAULT_LIMIT:       /* R/W word */
         if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
             pmdev->pages[index].vout_ov_fault_limit = pmbus_receive16(pmdev);
@@ -1610,6 +1770,22 @@ static int pmbus_write_data(SMBusDevice *smd, uint8_t *buf, uint8_t len)
         pmdev->pages[index].status_mfr_specific = pmbus_receive8(pmdev);
         break;
 
+    case PMBUS_STATUS_FANS_1_2:           /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send8(pmdev, pmdev->pages[index].status_fans_1_2);
+        } else {
+            goto passthrough;
+        }
+        break;
+
+    case PMBUS_STATUS_FANS_3_4:           /* R/W byte */
+        if (pmdev->pages[index].page_flags & PB_HAS_FAN) {
+            pmbus_send8(pmdev, pmdev->pages[index].status_fans_3_4);
+        } else {
+            goto passthrough;
+        }
+        break;
+
     case PMBUS_PAGE_PLUS_READ:            /* Block Read-only */
     case PMBUS_CAPABILITY:                /* Read-Only byte */
     case PMBUS_COEFFICIENTS:              /* Read-only block 5 bytes */
-- 
2.41.0


