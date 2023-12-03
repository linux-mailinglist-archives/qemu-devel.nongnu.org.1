Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6A802924
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:47:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w80-0000A8-FS; Sun, 03 Dec 2023 18:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w75-0007Rc-I0; Sun, 03 Dec 2023 18:43:03 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w73-0002r0-Od; Sun, 03 Dec 2023 18:43:03 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d3c7ef7b31so29457057b3.3; 
 Sun, 03 Dec 2023 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646980; x=1702251780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY8sUeibQtSIKqZZj4hPgQKFQsYZHNo91+gsd8Kiers=;
 b=Cv4g6u8Vi1pcBU4IrDGeWxE0NfeMgNM132l7di+4j4myA4etURbSYVzBTTN516ikQT
 zDYJBgg4Pk+IVChwrDXE9pUYsEf71EwyJFiO7kKiIQUADxLkcPVzjhcA8q8+DNYkeKVc
 MqtzqvXdmFiGOZvSQdyH655iRwhUjldV5u0WeNKqRwllHnQtIzCCHRMcaixCjtLTfbiH
 INuADS4f5gBRkBwPYdC1D7QseXnvXzVab/X7cp8dOOfip8J5QRt5hkuC/NBJ08a/V6wM
 8cSHIdFeCtPHu0Tz1hr77cxsr9hVpNY1K+ttTO8XOIGU7kCbspxw6Ov/WMkzM9733bLz
 1yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646980; x=1702251780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY8sUeibQtSIKqZZj4hPgQKFQsYZHNo91+gsd8Kiers=;
 b=l/SS+5OjW5B1TXqg0lmm7KHUx5c+PyJCENFFlHdlmNIXwYvevZ/9AvX4yJ7dfApqdw
 4kNECnBEd5AiyxyXS1cNWWA08hEz2c0eawZT4eYYr483aW1C2OfXDuhu6yh8akwJFgiQ
 mUUsnrtCR20wF7FpbV1GqAhCCdaOco+6JZl6fidCdbd3QGpYPA4v3EnsLdD6yMG9sdav
 c2lOcf1QcNTahoF3uzVKNDh3HTs33xdNfQTmQOeeLbCo06BnHxH6Ms41u6Xhs1oQdqQV
 RHCScZlE98OfyTyFLKjL2k1cJ6gasMN2VfMXYhYk3xlgWJvwFD3bSOEBlakaNBc7uVeH
 O26g==
X-Gm-Message-State: AOJu0YxDWWZTaambxIwEvKObdPTKdWtEQHvXTRYZDusD026Eo5a4lOQW
 ERuFNm9LWIEBR/iXSGE9lzyvo0g0774Mvg==
X-Google-Smtp-Source: AGHT+IHMAGo6tVUrnhACgdVc8+Fet1kAyf6XIKAl6Z9+aXURrX40+XTm8b/SMvySBCK5VPULwmnHqg==
X-Received: by 2002:a81:ae4b:0:b0:5d7:1941:3555 with SMTP id
 g11-20020a81ae4b000000b005d719413555mr1635343ywk.60.1701646980325; 
 Sun, 03 Dec 2023 15:43:00 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:43:00 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 39/45] Add mailbox tests tags. Part 3
Date: Sun,  3 Dec 2023 17:42:07 -0600
Message-Id: <20231203234213.1366214-40-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.h | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 49668668da..2b140a5d32 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -514,6 +514,84 @@ DECLARE_TAG_TYPE(TAG_GET_DMA_CHANNELS_t,
         uint32_t mask;
     });
 
+DECLARE_TAG_TYPE(TAG_GET_THROTTLED_t,
+    struct {},
+    struct {
+        uint32_t throttled;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_NUM_DISPLAYS_t,
+    struct {},
+    struct {
+        uint32_t num_displays;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_DISPLAY_SETTINGS_t,
+    struct {},
+    struct {
+        uint32_t display_num;
+        uint32_t phys_width;
+        uint32_t phys_height;
+        uint32_t bpp;
+        uint16_t pitch;
+        uint32_t virt_width;
+        uint32_t virt_height;
+        uint16_t virt_width_offset;
+        uint32_t virt_height_offset;
+        uint32_t fb_bus_address_lo;
+        uint32_t fb_bus_address_hi;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_GPIO_CONFIG_t,
+    struct {
+        uint32_t gpio_num;
+    },
+    struct {
+        uint32_t zero;
+        uint32_t direction;
+        uint32_t polarity;
+        uint32_t term_en;
+        uint32_t term_pull_up;
+    });
+
+
+DECLARE_TAG_TYPE(TAG_SET_GPIO_CONFIG_t,
+    struct {
+        uint32_t gpio_num;
+        uint32_t direction;
+        uint32_t polarity;
+        uint32_t term_en;
+        uint32_t term_pull_up;
+        uint32_t state;
+    },
+    struct {
+        uint32_t zero;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_GPIO_STATE_t,
+    struct {
+        uint32_t gpio_num;
+    },
+    struct {
+        uint32_t zero;
+        uint32_t state;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_GPIO_STATE_t,
+    struct {
+        uint32_t gpio_num;
+        uint32_t state;
+    },
+    struct {
+        uint32_t zero;
+    });
+
+DECLARE_TAG_TYPE(TAG_INITIALIZE_VCHIQ_t,
+    struct {},
+    struct {
+        uint32_t zero;
+    });
+
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
 void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
-- 
2.34.1


