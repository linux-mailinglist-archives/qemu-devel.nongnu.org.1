Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B172D47F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8q86-0001df-P7; Mon, 12 Jun 2023 18:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q84-0001d2-Vc
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q82-0007qT-Rj
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:16 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5149b63151aso8186368a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609312; x=1689201312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acR2Pn0tGnoCbeXDQipgDu1pq2FuVznnGrfx1Nr5E24=;
 b=wobFW+0eSCmRsA8i92SfreZPVOUQxUL+ZJ7Y0RJmxWOowQJxrhA2UwXUEzjpdUNxDn
 aNd/Mk0fyqoeoyejUmDQTuHjmUE4+P5r1FnZyD5FEqd35H5BVB7kxYKiHEEO6yWMQdrW
 bI3wNhAlLQjiwchBhAMR5nxjpg0ZXcKvbaJTy0ImrsnUxjO6u5iIN5oXHe2r1z/D9zDt
 4IJm5tL8HKNpBFUb8ZSzijvybCiym3xRR4NzaL9PgHtyT4HSwfh76A3p7+AFdD8IUGo9
 Xqd5pouxnLaIQd+gcCXjwW27TiWKD+QpeRw/wNRUrJF7cUmHPoV3maRluCC4A1Y2l9Z4
 m1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609312; x=1689201312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acR2Pn0tGnoCbeXDQipgDu1pq2FuVznnGrfx1Nr5E24=;
 b=NHFQkd8i4oSnwzAi/VO4oZCdc5r1WolPMvtyte/GnrtQlA6RxW6pfpN4hmbBBn8a9g
 LhoeT8hjmpL1pQpD0zZYNNxf1YK1rcwHnPv0YhCAHm8KH1r6ce4lZw0S+rgo5yB/udF8
 HpLkEXHfmTSXT8iY8PnXpT48PVGlpp2daUl+qJNDfEz/xSu6WeoyOl4aIJnEBdQX9VnE
 76xQijacBxuwx8PctOVpl+JPD7VLxhKxK3L2S4ZJ9Sj5T063P6R3h2l4kYDxPeV0GOYd
 uVFyyKQJRo2SoBP92SZZWYMfbO1UEEEVRZhqJMVOaIRwB2DncnTjG/qhs/S9j1FiCWmc
 EOOg==
X-Gm-Message-State: AC+VfDzaSldu1/kuWcF6FB6ZxnfpzK3W6DAH2+Y/nu3JXm+EFId/BoUl
 RItVUGTfSdnG8eUh6LSU4YGYHHa5vw+Nqwl6z3uRZQ==
X-Google-Smtp-Source: ACHHUZ5dtz07wTdpTUXyOBe4BUCZ5dDocqmG5AHHyCVHIY1Yf2JvTZWq2nCcwZup0OmVkylvkoQ0pg==
X-Received: by 2002:a17:906:d542:b0:94f:36a0:da45 with SMTP id
 cr2-20020a170906d54200b0094f36a0da45mr12688507ejc.29.1686609312623; 
 Mon, 12 Jun 2023 15:35:12 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 gt26-20020a170906f21a00b009600ce4fb53sm5771155ejb.37.2023.06.12.15.35.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jun 2023 15:35:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH v3 3/4] hw/misc/bcm2835_property: Replace magic frequency
 values by definitions
Date: Tue, 13 Jun 2023 00:34:55 +0200
Message-Id: <20230612223456.33824-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612223456.33824-1-philmd@linaro.org>
References: <20230612223456.33824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

From: Sergey Kambalin <sergey.kambalin@auriga.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
[PMD: Split from bigger patch: 4/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
FIXME: RPI_FIRMWARE_DEFAULT_CLK_RATE is raspi1-specific... Good enough for now?
---
 include/hw/arm/raspi_platform.h | 5 +++++
 hw/misc/bcm2835_property.c      | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 4a56dd4b89..83f2588fc5 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -170,4 +170,9 @@
 #define INTERRUPT_ILLEGAL_TYPE0        6
 #define INTERRUPT_ILLEGAL_TYPE1        7
 
+/* Clock rates */
+#define RPI_FIRMWARE_EMMC_CLK_RATE    50000000
+#define RPI_FIRMWARE_UART_CLK_RATE    3000000
+#define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000
+
 #endif
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 7d398a6f75..2e4fe969bf 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -17,6 +17,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "hw/arm/raspi_platform.h"
 
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
@@ -121,13 +122,14 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case RPI_FWREQ_GET_MIN_CLOCK_RATE:
             switch (ldl_le_phys(&s->dma_as, value + 12)) {
             case RPI_FIRMWARE_EMMC_CLK_ID:
-                stl_le_phys(&s->dma_as, value + 16, 50000000);
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_EMMC_CLK_RATE);
                 break;
             case RPI_FIRMWARE_UART_CLK_ID:
-                stl_le_phys(&s->dma_as, value + 16, 3000000);
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_UART_CLK_RATE);
                 break;
             default:
-                stl_le_phys(&s->dma_as, value + 16, 700000000);
+                stl_le_phys(&s->dma_as, value + 16,
+                            RPI_FIRMWARE_DEFAULT_CLK_RATE);
                 break;
             }
             resplen = 8;
-- 
2.38.1


