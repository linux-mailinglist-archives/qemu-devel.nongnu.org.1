Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0E735996
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtk-0002SE-TO; Mon, 19 Jun 2023 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFst-0000fD-HE
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsq-0002HQ-JH
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f8c65020dfso38305085e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184970; x=1689776970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WujVdOKi9RCxKInfSs8dGaEsk8ZvAlc/bj1Lv/doR/M=;
 b=Lph+GZMlYY1hpVO4vt6KITaAKwP8CEOQbfonULAf3AKAg0GNFs61MwXrPxTiTjjf5q
 X9vWvg0na4n+x5+alyAqs9+YE4M/CjrK1sZVoBoLa2OP6jNX9pcBwNS9tcMf3FpvyPhc
 giSgA8GBDSAwFUUhPIhcXJb1Ine4O4zrLKarR1p7CESX/Ei/0o/z75TmBEZ1Yu63eeSG
 oSbTwAQ1x7fpm4FKHnu5nHKrQOJRUgonc/vCEWSPXoULpP/riPv4x8EB8kQ0UgVdAPJf
 XEuRYGuqdIpIT+kovLlJSBc/kvBkf7DDxOEWir8UE8OG2IKuzIkMaq7krzsRRTO4tQXi
 JtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184970; x=1689776970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WujVdOKi9RCxKInfSs8dGaEsk8ZvAlc/bj1Lv/doR/M=;
 b=BBEMzrgHZVVBynvqUo8Djwy3YR4IylRpGuZAHb4csmd8hklbCXB/RX1OcL5Ey+Z3Vu
 PF8rPx/VOJ5eClOSf/ATINK9rP0762vwnOOHJyk9xFf1DyOtrjcUN127ZrLrNcm1dtFS
 KCvEOVWhlWVNHXp+IYdlveimC72hp7wFbyaRL/ehlC69sQhJBW6K6PENt+8eGgfxlNcF
 fWZSZzYiPk0cUNifAi7GUoGKfBl/xgdn0m8TY8CsMyhARMjPqB2cpm02bGbTY/4oZEF0
 ElyLvBoF/33cw7AHEtSQHkFBBIM97AYO2Bv405ab1StiHzSCdZxEPYAFitCSbbY+rPJA
 RX2w==
X-Gm-Message-State: AC+VfDwKdL/zBuz6B9o2NGyqfsnC9RQKZ8kME9rlMmXip3elOxWfe6QI
 h11RAwOryaDX/CgCR8i8WbiaMX8OVRDLu78QnfY=
X-Google-Smtp-Source: ACHHUZ4GdNYQr/d0RTM/OJdx1uYCaV9Wm7W3icsxRSc/SosW+Fr47ZAsnEYq56GP6JMYmfwZpp9zuw==
X-Received: by 2002:a1c:770b:0:b0:3f9:b29b:a83f with SMTP id
 t11-20020a1c770b000000b003f9b29ba83fmr1383930wmi.19.1687184970778; 
 Mon, 19 Jun 2023 07:29:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/33] hw/misc/bcm2835_property: Replace magic frequency values
 by definitions
Date: Mon, 19 Jun 2023 15:29:13 +0100
Message-Id: <20230619142914.963184-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sergey Kambalin <sergey.kambalin@auriga.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230612223456.33824-4-philmd@linaro.org
Message-Id: <20230531155258.8361-1-sergey.kambalin@auriga.com>
[PMD: Split from bigger patch: 4/4]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/raspi_platform.h | 5 +++++
 hw/misc/bcm2835_property.c      | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 4a56dd4b890..83f2588fc52 100644
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
index 7d398a6f750..2e4fe969bf8 100644
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
2.34.1


