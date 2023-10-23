Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ADB7D4373
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4dU-0002nC-3I; Mon, 23 Oct 2023 19:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38QU3ZQYKCgo3s3421qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--titusr.bounces.google.com>)
 id 1qv4dR-0002mK-5l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:01 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38QU3ZQYKCgo3s3421qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--titusr.bounces.google.com>)
 id 1qv4dO-0002lM-Ti
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:00 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-da033914f7cso405911276.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698104818; x=1698709618; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hBi9ecZu+jknETLfEjF91XegZl5B2r+QYOyPgwOcjHE=;
 b=xoQrMLa9vGOddbcKH0N7gPKv2Ql1h/9i2Gvz6GxuuTxSlugC4WveA1iHquvDZuSYtS
 Wk+wyydtEsYAOScKzr8jiDgwX57fgCoLj/O9ExSCYbHZj/4l1r+dEsh1tKeIwWmyleCm
 yT0SPPWEb/8YsdkflUfUCjxvvJSTzd+W6/BuiNH/Ll0fpZdp1mAHIqUFgIQhRmyB8vWG
 PN0YnCHBood/PUmHl5rexXWxMxNIOptLESiHrjo2aOKxTw1URzdN0Df7oZdyw9q1gk90
 +xRw9t9cMjl3ApqheSvmXnVKhPwkzVzBg3V5s9GTbkU26Htk/vxN5TuJrX3UZ6XW1v1h
 +jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104818; x=1698709618;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hBi9ecZu+jknETLfEjF91XegZl5B2r+QYOyPgwOcjHE=;
 b=snpeJMJYU6ZydfM6AzHfhXkgcOPDFKrTSfKDCSbUMcTAw9Xv237+Y+OSaJsn4R+TP4
 yYeUBquQpCldKJqKwlv1aO1MvJLW1sLbiIcnTxHdsj8GfvXt8F7ZLFPVkDNH7ves6D+Q
 F59PdOLA2qOF2t8ZI4/w4oGb3k9uPFaDxzxzhzQSCXWz1kyjPfpUs06Zldkw2SKqDLbN
 TlZuH8vQ7A7/dh+6hu9BpSmC3Og/ostV5t8VA3KAHoZwTTJ2m3eP6ZXZLCOR5c/hlp0D
 QVl6iLaLreXlVmsIDMbnrPo2TO2ulg9mqDDd1qPNt7T57DjjDQ5jlOir4B9go38ybbut
 RGxg==
X-Gm-Message-State: AOJu0YzTJ+QLDGugRFw9rXAf5aNNbH47T1wEX8GuqV2J2XTgHudX8qiv
 7aGIbUvxi3OtrpmyeeCea3AkTmkbxKY=
X-Google-Smtp-Source: AGHT+IE4Qc/4NeP7RNmT6lTSnsSiLzx4hAD0jarRLDQtPo/dU8uGovlL1PBBR/G4sSv6GQ/583Lc0SgeLW8=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a25:c5cf:0:b0:d9c:a498:c1ef with SMTP id
 v198-20020a25c5cf000000b00d9ca498c1efmr200160ybe.9.1698104817995; Mon, 23 Oct
 2023 16:46:57 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:46:40 +0000
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Mime-Version: 1.0
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
X-Developer-Key: i=titusr@google.com; a=openpgp;
 fpr=228BD42BAD6A2BCD3865AEA6C41200175CD21E30
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793; i=titusr@google.com;
 h=from:subject:message-id; bh=DFzZTJTLw0CTmSTx82hBdiA+2byo4JM+5crzjaQBGUE=;
 b=owEB7QES/pANAwAKAcQSABdc0h4wAcsmYgBlNwXtyT65ehjpk1G3HI0rYb89KGrgO+LHkhvlr
 pyAHqH7GPmJAbMEAAEKAB0WIQQii9QrrWorzThlrqbEEgAXXNIeMAUCZTcF7QAKCRDEEgAXXNIe
 MKjlDACPXKl0VvqiIL+xetkQoN/Pr+swT5ig8aeZCkAefyjEa6kKr5g1t7GK5mkIQDmleoL7M5C
 UmpNxdxBeaczz5K5MydblhmHrAozTo6rkE92sWA15SCu4t2dkCc1Q4NXk4qdPOWxg9L/x356DMS
 PKhJB85bGNDYPSHTlCPpqOUxHbJCa/vt9aJsQ49iLJgINrXJ0sl9YvZO9Y0mzNjdV85Txc2quD1
 Q8YhiYI0NZr5qH6C0tBMK5mUKVrooWwXERJzcciD/8mtHZQLFaYXxR2U+9eXWJzxm8T+pfiWyW6
 dPWBA1S1rmIg8H61vVZSKNCJrPvcPXZ7NnzK+Zn58kLaWqBuUFwveZcTwjNHfIo3gbCSAdGigXK
 rBx/qvZj+cW+imGfMR3SEHxpHytEiTXkIKS7UuwUxmve66zkAk25KA9Uwfc+ZmBn0kk8HRDuJN3
 Gnh/nUMiVJDvpmCJMZHb4shXB1Yb7JP2v06P6iXxwKFtuIcdEIqa6txYJYEuHA7JLFni0=
X-Mailer: b4 0.12.2
Message-ID: <20231023-staging-pmbus-v3-v4-1-07a8cb7cd20a@google.com>
Subject: [PATCH v4 1/8] hw/i2c: pmbus add support for block receive
From: titusr@google.com
To: philmd@linaro.org, minyard@acm.org
Cc: Titus Rwantare <titusr@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=38QU3ZQYKCgo3s3421qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--titusr.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

PMBus devices can send and receive variable length data using the
block read and write format, with the first byte in the payload
denoting the length.

This is mostly used for strings and on-device logs. Devices can
respond to a block read with an empty string.

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/i2c/pmbus_device.h |  7 +++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index cef51663d0..ea15490720 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -102,7 +102,6 @@ void pmbus_send_string(PMBusDevice *pmdev, const char *data)
     }
 
     size_t len = strlen(data);
-    g_assert(len > 0);
     g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
     pmdev->out_buf[len + pmdev->out_buf_len] = len;
 
@@ -112,6 +111,35 @@ void pmbus_send_string(PMBusDevice *pmdev, const char *data)
     pmdev->out_buf_len += len + 1;
 }
 
+uint8_t pmbus_receive_block(PMBusDevice *pmdev, uint8_t *dest, size_t len)
+{
+    /* dest may contain data from previous writes */
+    memset(dest, 0, len);
+
+    /* Exclude command code from return value */
+    pmdev->in_buf++;
+    pmdev->in_buf_len--;
+
+    /* The byte after the command code denotes the length */
+    uint8_t sent_len = pmdev->in_buf[0];
+
+    if (sent_len != pmdev->in_buf_len - 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: length mismatch. Expected %d bytes, got %d bytes\n",
+                      __func__, sent_len, pmdev->in_buf_len - 1);
+    }
+
+    /* exclude length byte */
+    pmdev->in_buf++;
+    pmdev->in_buf_len--;
+
+    if (pmdev->in_buf_len < len) {
+        len = pmdev->in_buf_len;
+    }
+    memcpy(dest, pmdev->in_buf, len);
+    return len;
+}
+
 
 static uint64_t pmbus_receive_uint(PMBusDevice *pmdev)
 {
diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index 93f5d57c9d..7dc00cc4d9 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -501,6 +501,13 @@ void pmbus_send64(PMBusDevice *state, uint64_t data);
  */
 void pmbus_send_string(PMBusDevice *state, const char *data);
 
+/**
+ * @brief Receive data sent with Block Write.
+ * @param dest - memory with enough capacity to receive the write
+ * @param len - the capacity of dest
+ */
+uint8_t pmbus_receive_block(PMBusDevice *pmdev, uint8_t *dest, size_t len);
+
 /**
  * @brief Receive data over PMBus
  * These methods help track how much data is being received over PMBus

-- 
2.42.0.758.gaed0368e0e-goog


