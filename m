Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392977D4378
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4dX-0002sS-H6; Mon, 23 Oct 2023 19:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39AU3ZQYKCg06v6754t11tyr.p1z3rz7-qr8ry010t07.14t@flex--titusr.bounces.google.com>)
 id 1qv4dT-0002pk-SQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:04 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39AU3ZQYKCg06v6754t11tyr.p1z3rz7-qr8ry010t07.14t@flex--titusr.bounces.google.com>)
 id 1qv4dR-0002lp-SY
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:03 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-da03c5ae220so153534276.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698104820; x=1698709620; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ltiPFA7AykEhStcVaCE5/VxTxx+tCgIE8K92hBhsFWc=;
 b=e2TdaWrdmJ7utjfSWSu6Cn5ra+1J3A0lVpAxh6bXIYjULJGkjwA8hmPogPayeoG5hO
 iiCsaJ7QU0cfsyHjjxEbM6adZqzV+E9JZNSccFn3FnMnjJb57zzHpvfFZ/fG81FeMeHa
 qCUsW/Yeaw+p4y0kva2ZMMArgsDo6yZTNSffOFTrffAEIRZitL+BwdocZ2CHPZfExfl2
 iDSLPa+3GlRn0UJmpMI8PwO2JL2+v5O38it6WHE6LI/Kxf67UJgTL3Wv9wpNs7VpO5Ap
 pCuMzBl8OQnZUQ+NVPiN+2pInPV8WOQfQo7/DgS3iMBUk9Htx00LNeUDl0RM3u7l0piE
 w12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104820; x=1698709620;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ltiPFA7AykEhStcVaCE5/VxTxx+tCgIE8K92hBhsFWc=;
 b=KWYEcTc8ZMcDRCoqbG4r5LBobtUBEyUWfkAzqjrIbY5UG74fiXWwYecj2CQZpn8LV4
 jdNabsgl8oGwjpdWvpgRGKDux8TLAJE+RSpMYGbSJAj4ROYgoIf2z7XBnKYkxwvUtrLO
 TA941qqCMU3+VaQOAcP2vqOZ/u5UDuiB4mNVbEOe9THuWKHlmtU7G5gnJup6UX0gUtPv
 1dOdDSTAn1HopFX4sUbCJI9Sb9p03mrpKmv2pn7Ca5yFAQhJ//FeMFRVUqpcLYjxKWQs
 vloBP1lYtySZwM2iEPbrWOtwMKnAXAMedUOgs9XHKbMYZ0ZVDP6fUeqqHv7wxr3KrxNQ
 Bm6A==
X-Gm-Message-State: AOJu0Yxk9XqFyRHdWs+DlQMK76JcKHpOeEagUEr7ZhEsWjmoAWNhO5Ia
 1Ovq1xD/dy36/bKNsMbYVUg8nJ4FRc8=
X-Google-Smtp-Source: AGHT+IGrMKLWf2N7R5uLAY/umOT+vzsKodOfaCPnqeLitnOQFDKj8dnlza7vjBO+Z9J+bIWy2d1ABsDObwM=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a25:6902:0:b0:da0:36a5:97bb with SMTP id
 e2-20020a256902000000b00da036a597bbmr20949ybc.5.1698104820171; Mon, 23 Oct
 2023 16:47:00 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:46:42 +0000
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Mime-Version: 1.0
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
X-Developer-Key: i=titusr@google.com; a=openpgp;
 fpr=228BD42BAD6A2BCD3865AEA6C41200175CD21E30
X-Developer-Signature: v=1; a=openpgp-sha256; l=9030; i=titusr@google.com;
 h=from:subject:message-id; bh=xtvVQXZg79IMOuVxQNJZwOLLMDrZH/r2Ohc1ZeKx5G8=;
 b=owEB7QES/pANAwAKAcQSABdc0h4wAcsmYgBlNwXt5On5JCDZ6UzKYsRmqn5as7lOzXBgdGvmC
 vhmk0fNOCWJAbMEAAEKAB0WIQQii9QrrWorzThlrqbEEgAXXNIeMAUCZTcF7QAKCRDEEgAXXNIe
 MOmnDACumsNAH1W9m4ssqP62+NGCszpmHNu/61jTI9KWsCHEDF6P6NG/zD+PoQSP0mhTQ1rhNtU
 UyXyppK+ESrJGOaisGQLVT8AoE44lvVIAnG35Dw/htr2wCmWbHENfi2ghjbrGmR6IepeZPluO1o
 6TSrz7MNMy5qa1zinD0eNBnYEiH+SYIXg7n2MOIZlSqM0ZC1Fh9afGhsodEjhv7ujA/WVynBTdH
 IDdRGBf1A2TwjKlEYA072RS4XF6DAVVcp3/Rme93Nd2lf+G58Zg82m+Amg+aJhghppgl/deIprW
 8YiyGkuMksWcxMggdpcV6TDqez3Qj3ERYVSyVh7mhVvf9gVU9kBS4hzNpBSN4MqMyFhhfhA11kt
 Y1lTE3Fg3hvvf9Gt3rl/QLt1osLAitHelWRNzvrnq3xi/9Uaake8+2tFZVek0J0OE/vahKsAY2m
 dzJW4bfIZ654c7FtEgLConusyou9ZX73E+t9HztNV1sGIePJnsPWKSeCq8TO0USNc/7l8=
X-Mailer: b4 0.12.2
Message-ID: <20231023-staging-pmbus-v3-v4-3-07a8cb7cd20a@google.com>
Subject: [PATCH v4 3/8] hw/i2c: pmbus: add fan support
From: titusr@google.com
To: philmd@linaro.org, minyard@acm.org
Cc: Titus Rwantare <titusr@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Stephen Longfield <slongfield@google.com>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=39AU3ZQYKCg06v6754t11tyr.p1z3rz7-qr8ry010t07.14t@flex--titusr.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c         | 176 ++++++++++++++++++++++++++++++++++++++++++
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


