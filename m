Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D11E7638C3
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:15:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWx-00038f-DJ; Wed, 26 Jul 2023 09:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWp-000311-3r; Wed, 26 Jul 2023 09:26:11 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWk-0003Ul-Iz; Wed, 26 Jul 2023 09:26:10 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fe10f0f4d1so1052171e87.0; 
 Wed, 26 Jul 2023 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377964; x=1690982764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhx3mwFxn6oVr0xHJIBhgwgL3tFkhgNI5fgTZq9i7e8=;
 b=imsGvZLMXq00Sw3rPmgD4SBDBYbTLbrmd2lufeML7kYFNuOWnzXOkH8YaGH06WH22e
 pk+tXHeaNYEIpnVx7xDR90YBA/p6QJRWqVx/D3/QhWzg7TELjyZkF3+NID/TP6WU5Fh3
 XJ6cytRk/Ya/q6uPsXBg2E5SuWmJt1NaQ9GRldzG2AleR87CZ0PBkn2DjOR3JR2EFjn5
 F8JmDktWFBOw64f+IsMnbA1nfmYNVbi3yUpAjMB6Ch/6/NHONsjWSBG1a4N6KBrxm4R5
 0ZUDO5+t5Q+EZ1BkDkvsyO+vvLn2r1bCWqrOLvpbrL5R8Z0TohrPIDVYWVM6bkGmMLl5
 sS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377964; x=1690982764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhx3mwFxn6oVr0xHJIBhgwgL3tFkhgNI5fgTZq9i7e8=;
 b=Jtsmcs1/lmbkBJfAupnLg+m/O2t5Uj8zZJUKnJp9yhZIPh8ZN1c6rO1QkEmPaecQRn
 G8hyYtfg5zAzuTXGp8aFaC3ia6JmC1ugefjhi5PtkDvoNZKt143S5flVKPLHeB5EFYgC
 4w8kHg1N0wlYZ0kxDItmm4cfLJpzJaTM7uybehLL2/SRODZ2Dq/lUcj7GVItWSpzFL+8
 UnvyOLmc6nxAZeN9cqGMP56xB+NG5uhCxzStE0gwZQYBP3JtRuvbBIHYnSQGpEWHNsi2
 iQzsGIMZ8xwfIFCRGYDqudcFPOO0TKnUQQT3yZwt3zDpAcW9i7e8B6b6OmV5iiS8yb3c
 d6GA==
X-Gm-Message-State: ABy/qLbD2CfyYnMfy6gnvK47L6ssfVDdJrF9EM1I5DXp+Njcc1xKIWmJ
 jTNVWQ4Xz/2mTjsnx6rn8/BP9bSA8ng=
X-Google-Smtp-Source: APBJJlH9kDX8ksnxs78Vb4wWq6DwKCCbEAR0d52aOqIu4/orKo31VGjlTRUG1DiuW9azRRGHx2OONQ==
X-Received: by 2002:ac2:4c08:0:b0:4f8:5e65:b61b with SMTP id
 t8-20020ac24c08000000b004f85e65b61bmr1455084lfq.65.1690377964116; 
 Wed, 26 Jul 2023 06:26:04 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:26:03 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 37/44] Add mailbox tests tags. Part 1
Date: Wed, 26 Jul 2023 16:25:05 +0300
Message-Id: <20230726132512.149618-38-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x129.google.com
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
 tests/qtest/bcm2838-mailbox.h | 185 ++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index df223f2cf7..1fc34d092d 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -179,6 +179,191 @@ typedef struct {                                                        \
     };                                                                  \
 } TypeName
 
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_VARIANT_t,
+    struct {},
+    struct {
+        uint32_t variant;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_BOARD_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_ARM_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_VC_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_DEVICE_POWER_STATE_t,
+    struct {
+        uint32_t device_id;
+        uint32_t enabled : 1;
+        uint32_t wait    : 1;
+        uint32_t reserved: 30;
+    },
+    struct {
+        uint32_t device_id;
+        uint32_t enabled : 1;
+        uint32_t wait    : 1;
+        uint32_t reserved: 30;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_STATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t enabled    : 1;
+        uint32_t not_present: 1;
+        uint32_t reserved   : 30;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MIN_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCKS_t,
+    struct {},
+    struct {
+        uint32_t root_clock;
+        uint32_t arm_clock;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_ALLOCATE_BUFFER_t,
+    struct {
+        uint32_t alignment;
+    },
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_RELEASE_FRAMEBUFFER_t,
+    struct {},
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_BLANK_FRAMEBUFFER_t,
+    struct {
+        uint32_t on      : 1;
+        uint32_t reserved: 31;
+    },
+    struct {
+        uint32_t on      : 1;
+        uint32_t reserved: 31;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FB_PHYS_WIDTH_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_FB_PHYS_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_FB_PHYS_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FB_VIRT_WIDTH_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_FB_VIRT_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_FB_VIRT_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
 
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
-- 
2.34.1


