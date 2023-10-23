Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0437D3EAA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMY-0005SM-HA; Mon, 23 Oct 2023 14:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wbY2ZQYKCjopepqonckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--titusr.bounces.google.com>)
 id 1quzMS-0005NP-IF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:08 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wbY2ZQYKCjopepqonckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--titusr.bounces.google.com>)
 id 1quzMQ-0006xN-EX
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:08 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a7af53bde4so50094757b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084545; x=1698689345; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IVqYj4it6Gbk8q7NLywy+QqsqPeqJ6ajVaN0kVt6mXo=;
 b=t4HIHBOgxVukwK2htMr7/vZrKbqTKGDUmF3dSKGV7V9Px8xBjvSzW7XF8d3kzIbagu
 ph5ifXVNlZPH3jz0qGtDx2tGn0KJXh7i1jJDBPOzQXTiI7+0rN2Da5LSx9r2Ze4CzJZO
 T2t0YGLOuvhoSN0aCX42hK+IgoGdBITv/Opr4q/X5VUmSmHGfU1q3lYmgKFvXDvVVDun
 ohA5zYeKE0D6MQcRYcsqqz0Xz/Hz7iA+Z7lUqYFkQ0DvZkfk9S7oC3NXHBSZr/tHlHmX
 mTRbe2n2i++M6/RPBd+uiEYKGGC4c6JwTVvbTnF7xTymGfRq3/idT/nZRfClp74qLRaV
 1ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084545; x=1698689345;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVqYj4it6Gbk8q7NLywy+QqsqPeqJ6ajVaN0kVt6mXo=;
 b=oKWFMKfhLIYnGMD4/sSt4PDWFQi9Nnz6QUAIwqcvdj+eY8Mo2PNV+8WeNH13dehjNF
 FotXKOnneS4fLF9/hJHmQdcSyCRCZ3ZgrfbTdz/D2RiUd3k78JfIq2Ay+cxMoTBrtQK4
 aIBbYXhLt7Kr1PJeX5SKGeau6OTIA/a3pGUBRyaZebdvq0Hhbh9JL2HMxShA5B8hA1L9
 jEin3IpiKTw7IdTI7HiVKjOLfzrS+W3e4YE3DzvdtfDGjKmBs9YlwMhdaYDELgydiU4k
 VvhHfJ10KnVJb2L7mKW62IpaKC8Y6iW+nEGfK5PUhRRcvCcqqDRKEguwqcwOUYOTlG04
 QLuA==
X-Gm-Message-State: AOJu0YxjlpBp/6Xeq3KF/EFSmbnOq6Z/2D34Ylh80YHkB0xqfTZnxevd
 NXJHuF4SNZADJvzS9HMTdLykipKMiqw=
X-Google-Smtp-Source: AGHT+IGH0IufvyX2Tsf2wMYxZhJs7YspGF2ilDPwyrVwmmXgeXHRn3ktflsA6V8Wesq+ek10RBE6s28ANho=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a25:d601:0:b0:d9b:e3f6:c8c6 with SMTP id
 n1-20020a25d601000000b00d9be3f6c8c6mr205230ybg.4.1698084545044; Mon, 23 Oct
 2023 11:09:05 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:32 +0000
In-Reply-To: <20231023180837.91785-1-titusr@google.com>
Mime-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-4-titusr@google.com>
Subject: [PATCH v3 3/8] hw/i2c: pmbus: add fan support
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>,
 Stephen Longfield <slongfield@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3wbY2ZQYKCjopepqonckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--titusr.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

PMBus devices may integrate fans whose operation is configurable
over PMBus. This commit allows the driver to read and write the
fan control registers but does not model the operation of fans.

Reviewed-by: Stephen Longfield <slongfield@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c         | 176 ++++++++++++++++++++++++++++++++++
 include/hw/i2c/pmbus_device.h |   1 +
 2 files changed, 177 insertions(+)

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
 
-- 
2.42.0.758.gaed0368e0e-goog


