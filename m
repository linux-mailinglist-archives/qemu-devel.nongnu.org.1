Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4AF802988
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:35:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9woV-0007B0-1k; Sun, 03 Dec 2023 19:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wo7-0005Nt-TE; Sun, 03 Dec 2023 19:27:33 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnq-0000J9-R2; Sun, 03 Dec 2023 19:27:31 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d852ac9bb2so5121977b3.2; 
 Sun, 03 Dec 2023 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649633; x=1702254433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY8sUeibQtSIKqZZj4hPgQKFQsYZHNo91+gsd8Kiers=;
 b=fZsGZFok2UTtwRLZ/hGBxHwpmuxEBsKxgI+MfzinmWC9brpaRvGFIthx11gNN5RrrJ
 JCu+z6uqXY4wJoLoxV97TlNjsYjVRY9+b4demjscZj+4xHDqZyQmXZUd1lfKdh6khLTJ
 TV0dQcNvPsvzAFeLVCI1LI9qJs9BpalQ5zE5epbxSa9JRHNKmELJEpCrYhl4QqYYfZM1
 JIV3qeJbROSAUo2NLBvOd/TAxwCe3ZrU+f72uAa3ccAM9vxkYS9br0fH/pL6dBPSHVKt
 4cEXYFXjAseMX4tCro7wubbaRu+H4eizz2Lcd7YVPucJoENgEDEfZ9MEtMf/shCsQHMh
 fqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649633; x=1702254433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY8sUeibQtSIKqZZj4hPgQKFQsYZHNo91+gsd8Kiers=;
 b=eRAuyKE8xeHkOSUkd+0gJs6Dl8KivuEHlNquadKQfa7qV4txCwQ1ZoR8cNGtVgPygS
 R8pAE1zrIK0noYV3lk2J/BgsovVMxl5yFNssQxJKlWkJu9Y4Jk530r579EDLA+3oWsE2
 WQHxruhnaSD/Gs7o34fkuW/X0fF9XKeHwi8CPE+wOJVRRKEBySm9wsnuw9II04CtDD5p
 bqFRluoiWgkNxjA3pJLVuTN84F1IFxr0gS1HS3+kZxTHchP2H8deGL1rtjU46Rwrn9ye
 CwUcczhBZNMD2wRCkk+yXRpFLPfybG2zA8tfNCe7WDsztSqtP0klXfmGPfnpZRDv+1vr
 KYYA==
X-Gm-Message-State: AOJu0YxGzEQ80P0exE9m8vqRaNQBYhUbKZgDTnb3va0YFqt7uNq3RWHP
 f8oT6g4dd6VjvUKeBZSoBUin2/NH3ZwVIw==
X-Google-Smtp-Source: AGHT+IFiPPiKHR14iVoOSaKlzfj5LLeRQwIVj2Cb73JKiCBtLvu0w/1j5+Fpu7NrehqWc30fkXnHQA==
X-Received: by 2002:a81:ad5b:0:b0:5ce:c6db:7dc4 with SMTP id
 l27-20020a81ad5b000000b005cec6db7dc4mr1734612ywk.13.1701649633313; 
 Sun, 03 Dec 2023 16:27:13 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:12 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 39/45] Add mailbox tests tags. Part 3
Date: Sun,  3 Dec 2023 18:26:13 -0600
Message-Id: <20231204002619.1367044-40-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


