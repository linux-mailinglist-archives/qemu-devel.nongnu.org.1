Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89072D47E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8q8B-0001el-56; Mon, 12 Jun 2023 18:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q88-0001e3-2Y
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8q86-0007rX-I9
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:35:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51478f6106cso8471451a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609317; x=1689201317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qu0YkZGL/goBV8MNatIwrKy50fK2dB6nGF+E/AAnJcw=;
 b=ohccGuMzFzrNl9EFwbE5JDyln4H5edIrf2w3BmuLRfV2Ri7GTzBjZ8vxJEDU7wIOrf
 OqxSfqxU9nOIM0P6Qz+lvNF9FjRktJwRnAY/UdyIVmbNPxunJ6zbqKG+Fh9mb3tLyFU+
 njlaOn2vm48okCkw8Vvn2YaJM4xyvxaSLZ3dEemLiftAxsWkube0dZDvDH5GmErslmlz
 1TEMMeKkmeBpyDALN1P4rfYEF7EjrC1Q9ggHsCVy6mbaGS9SR8bZbYNTIRQb7sQbQXxE
 Qhz0kLSsabEYKV2dx5lnegK8oUOJ7qpUHoiBmJiYAt+5YrjzDK/X3QdXD9W+TMpJHzKw
 Lwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609317; x=1689201317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu0YkZGL/goBV8MNatIwrKy50fK2dB6nGF+E/AAnJcw=;
 b=fKo7JsJseSdZrl7O7vCBKvzuhEuUx1sGeUe5yFXnOzKEENpo3+b2vvmI8sw6SIogFo
 v9KrTOV7Uj3D51j49Ft2qoJ1n1+BreC/nelXBbnpXVCBU35nQNHlajSxQAkBqdyOsMW3
 Osck4sYa5Otzp793cDF2wKH5a0H3RLn6ml1ySjf1l5si1J/4XwcF6F8cZCIu2wL/eefv
 94jZ2kE8+AWksj/qjUogI7ziY5d0po2g/dYxhvpMHik9qdyo7476V5vsLHrGCaYw2yFC
 GVSBCUhhuFySZf1DfEmCwrfBMCtRH6hyAd7etFcMur6SVUnNHdqX1E6QOMNexUZcLzN8
 qdXA==
X-Gm-Message-State: AC+VfDwkYWwW2ysNimYqqqLn6JJobCoKzeA8KZlTJ/uDTTsLTLCU7gIm
 87860rz4aTDBc4MkwCfOePtOqe1SYJGtN7T2kbG30w==
X-Google-Smtp-Source: ACHHUZ6rTDIWcuxTCfOqsO32xqcyAHbrrmnldZCZE8MkolwahpKZ+e2rS9lvBl/7R4Ge1e6h6OYzRg==
X-Received: by 2002:a17:907:320b:b0:96a:3e7:b592 with SMTP id
 xg11-20020a170907320b00b0096a03e7b592mr8758313ejb.25.1686609316954; 
 Mon, 12 Jun 2023 15:35:16 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a170906069600b0097461a7ebdcsm5753892ejb.82.2023.06.12.15.35.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jun 2023 15:35:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH v3 4/4] hw/misc/bcm2835_property: Handle CORE_CLK_ID
 firmware property
Date: Tue, 13 Jun 2023 00:34:56 +0200
Message-Id: <20230612223456.33824-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612223456.33824-1-philmd@linaro.org>
References: <20230612223456.33824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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
[PMD: Split from bigger patch: 3/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TOCHECK: seems raspi3-specific freq. Use a per-soc freq? Good enough for now?
---
 include/hw/arm/raspi_platform.h | 1 +
 hw/misc/bcm2835_property.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 83f2588fc5..92a317950a 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -173,6 +173,7 @@
 /* Clock rates */
 #define RPI_FIRMWARE_EMMC_CLK_RATE    50000000
 #define RPI_FIRMWARE_UART_CLK_RATE    3000000
+#define RPI_FIRMWARE_CORE_CLK_RATE    350000000
 #define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000
 
 #endif
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 2e4fe969bf..4ed9faa54a 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -127,6 +127,9 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             case RPI_FIRMWARE_UART_CLK_ID:
                 stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_UART_CLK_RATE);
                 break;
+            case RPI_FIRMWARE_CORE_CLK_ID:
+                stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_CORE_CLK_RATE);
+                break;
             default:
                 stl_le_phys(&s->dma_as, value + 16,
                             RPI_FIRMWARE_DEFAULT_CLK_RATE);
-- 
2.38.1


