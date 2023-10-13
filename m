Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D77C80DC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpe-0007U3-IH; Fri, 13 Oct 2023 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpc-0007S7-Eu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpa-0000or-QT
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so19110755e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186857; x=1697791657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULFeTIXj6bX1JE5sE4td36JwncG3JzFJuXREJ6wp7rc=;
 b=mIOYQLyAyjaagTsWweBwVnjlONwTEOlAoYV/ejQGrcdTR22vYx7XGm96wrHnqdzAfA
 sDB2PUBjBdaO9Lp08481dwGbWpvEYcpJcCQYiXf1WtlakUYupyJy0D+5uTRSlOmXwmJr
 UZRj2hPbiLQv0oCiyN79YNfqc/ED5fqR65wz+2HDsG5rwQcVC7DRx36CZ5cR1Bty8qw1
 vtUn8UW5INPPwyfY7Tng76Wzfe7t6F0uRi04/oTcfujxgMYrq7amxsCG6/C6FLgULQCp
 Nr6NbLfGbu1NaDGDTk79N7JZEooKkkWC43WLNMoaUnTA006hdo/RTx+iCMavSwryw/8F
 Z7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186857; x=1697791657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULFeTIXj6bX1JE5sE4td36JwncG3JzFJuXREJ6wp7rc=;
 b=XqSEV2lVXdhWMupONYHSmHZmcijJPS0p1XtrqMOC2eaWg+/yJSGH6LQL7FQEp8JNlx
 Ll/yK+XNmyOGHvHw7t9Ej29GFn4tLyGK8ETXQp20KF0P1fv3W38w5j3UGRipjFayuSek
 Ng7bycmPGe9iJIJDE8sZzOEPncPemCfTroF54aEm/GANXpCTu7SOuFZUh8N+ieAGksaY
 zGglEazc1ifa/5zPWJJF7E2lZPhzfsEQwcx+wqAaKtAhG2oXD32giBOZmfaiHJb/nMOx
 dLRZyQzyJrAauK2blXRU0UDL1G+TBHa1/4ydfz2Mb0gTpDO7gGhdXpGSlqfELR0nA4vX
 s7xQ==
X-Gm-Message-State: AOJu0YzTXbIcapBkuzOL0bsZzROgX3AqZUsx14i6su7FThdAAsvyhL1I
 0px3wTLg8MxV+qcts7qNkRZo4ID3Rf4wuAN6+Kk=
X-Google-Smtp-Source: AGHT+IFjKN7MdsezpwMW/lGsuR0FoPqe9jy/hBVkKOJnOu+uP1KLuB1AKvGQvG9tlaPOkwMQk0rqaw==
X-Received: by 2002:a05:600c:ad0:b0:405:375d:b860 with SMTP id
 c16-20020a05600c0ad000b00405375db860mr24379109wmr.21.1697186857149; 
 Fri, 13 Oct 2023 01:47:37 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:36 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [RFC PATCH v3 13/78] hw/adc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:41 +0300
Message-Id: <9d4eebb3c55f9a6cf7b3df5e09b6b692a028e024.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

(Cédric Le Goater review is for aspeed_adc.c)

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/adc/aspeed_adc.c | 12 ++++++------
 hw/adc/zynq-xadc.c  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 0d29663129..f9f5f7bb17 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -119,7 +119,7 @@ static uint64_t aspeed_adc_engine_read(void *opaque, hwaddr addr,
                           __func__, s->engine_id, reg - BOUNDS_CHANNEL_0);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case HYSTERESIS_CHANNEL_8 ... HYSTERESIS_CHANNEL_15:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
@@ -127,7 +127,7 @@ static uint64_t aspeed_adc_engine_read(void *opaque, hwaddr addr,
                           __func__, s->engine_id, reg - HYSTERESIS_CHANNEL_0);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case BOUNDS_CHANNEL_0 ... BOUNDS_CHANNEL_7:
     case HYSTERESIS_CHANNEL_0 ... HYSTERESIS_CHANNEL_7:
     case ENGINE_CONTROL:
@@ -145,7 +145,7 @@ static uint64_t aspeed_adc_engine_read(void *opaque, hwaddr addr,
                           __func__, s->engine_id, reg - DATA_CHANNEL_1_AND_0);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case DATA_CHANNEL_1_AND_0 ... DATA_CHANNEL_7_AND_6:
         value = read_channel_sample(s, reg);
         /* Allow 16-bit reads of the data registers */
@@ -194,7 +194,7 @@ static void aspeed_adc_engine_write(void *opaque, hwaddr addr, uint64_t value,
                           __func__, s->engine_id, reg - DATA_CHANNEL_1_AND_0);
             return;
         }
-        /* fallthrough */
+        fallthrough;
     case BOUNDS_CHANNEL_8 ... BOUNDS_CHANNEL_15:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
@@ -202,7 +202,7 @@ static void aspeed_adc_engine_write(void *opaque, hwaddr addr, uint64_t value,
                           __func__, s->engine_id, reg - BOUNDS_CHANNEL_0);
             return;
         }
-        /* fallthrough */
+        fallthrough;
     case DATA_CHANNEL_1_AND_0 ... DATA_CHANNEL_7_AND_6:
     case BOUNDS_CHANNEL_0 ... BOUNDS_CHANNEL_7:
         value &= ASPEED_ADC_LH_MASK;
@@ -214,7 +214,7 @@ static void aspeed_adc_engine_write(void *opaque, hwaddr addr, uint64_t value,
                           __func__, s->engine_id, reg - HYSTERESIS_CHANNEL_0);
             return;
         }
-        /* fallthrough */
+        fallthrough;
     case HYSTERESIS_CHANNEL_0 ... HYSTERESIS_CHANNEL_7:
         value &= (ASPEED_ADC_HYST_EN | ASPEED_ADC_LH_MASK);
         break;
diff --git a/hw/adc/zynq-xadc.c b/hw/adc/zynq-xadc.c
index 032e19cbd0..a74de3a4fd 100644
--- a/hw/adc/zynq-xadc.c
+++ b/hw/adc/zynq-xadc.c
@@ -235,7 +235,7 @@ static void zynq_xadc_write(void *opaque, hwaddr offset, uint64_t val,
             break;
         case CMD_WRITE:
             s->xadc_regs[xadc_reg] = xadc_data;
-            /* fallthrough */
+            fallthrough;
         case CMD_NOP:
             xadc_push_dfifo(s, 0);
             break;
-- 
2.39.2


