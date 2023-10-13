Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335EE7C810D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtN-0000jB-7t; Fri, 13 Oct 2023 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsP-0006Ej-Lg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsN-0001YP-Qn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso343505f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187030; x=1697791830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cl281DmBBuKIqdhIrNfrN36TM+jchj7MoFXFzERONDk=;
 b=EzfGpCrXelaxjgqm0DluPazW/CzyE+SgerwHk26LzH8J8GMGLnP2LgTHG0EQBHm1ug
 U9W2K2npuSlcdUNhAFA5fpDEOeEf6PUKl7lgE6buXSm/LbG3F63FvRyzfoMe6OqaPa7U
 9zXIAo/ZN2KVi/3AMdpbYlwCrGyXr4NAQdNEjTKAHaoyy9V42jhQ8IXh73ac4G/V9FTU
 d4/p9HPLITBtyj5xaMDEjrRie6jRdQi7DqsruuO6p6Q3x6KBFSBZuTRiLhGNrC+usVAc
 0ZFcCGHs4iO5WQ6fIbZsPxf0JgtEe+LLXvV+Da9m88wArGHzMm1dzqiRuhdbPZBtylQe
 DFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187030; x=1697791830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cl281DmBBuKIqdhIrNfrN36TM+jchj7MoFXFzERONDk=;
 b=wCfJnfgREzWnSkiOxjKLKw5ARDMeYuROwKbDS+nBQl5p6WU+6nijPtkXHk2+LYb/vt
 FOxEsilPTNWsgwR9cn/U9v63wkMc+yqfP7fjEwgYurB3dhzl5Fn0q+YtAliEZLvO1pjb
 v41/BBGvY9+xuDbIug46GX9cUG9cD9h4v4aScg9sUg9mFhuzLsFk1uTis/eJCR7kJnNN
 4h5Tg+dc/NRC8yZ4LiNs+YD1YodMHACMt26nqY7bBvn4N9W0BxflwoI9/INALmiwsb5W
 Bvin/RbSXA516UKqNXf78Ak/SHvEbyrFDNfO97glyIh8udnVD4upo/tIPRmxhE0lCbup
 C23g==
X-Gm-Message-State: AOJu0Yz9xsjMhU/5drb1sK3j3FH7GqDhtDGA8WPou9+om355KvpgtTB9
 SbPGl8NTT/FQW6ht7IEK//lwB1hf1wyeiEuq6D0=
X-Google-Smtp-Source: AGHT+IGS4zIyUj8AFl888CEwOonekVT13vkiWD9Nf1VJLv6xkDBvjHvPF53jxwTz8Zy01REXMOVhWg==
X-Received: by 2002:adf:f005:0:b0:321:52fb:5703 with SMTP id
 j5-20020adff005000000b0032152fb5703mr24008995wro.13.1697187030197; 
 Fri, 13 Oct 2023 01:50:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:29 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:OMAP)
Subject: [RFC PATCH v3 62/78] hw/gpio: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:30 +0300
Message-Id: <0af2d84ed03108dc0ba318fd4125114605f71a27.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/gpio/omap_gpio.c  | 2 +-
 hw/i2c/bitbang_i2c.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index a3341d70f1..82a9ea4810 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -563,7 +563,7 @@ static void omap2_gpio_module_writep(void *opaque, hwaddr addr,
         cur = omap2_gpio_module_read(opaque, addr & ~3) &
                 ~(mask << ((addr & 3) << 3));
 
-        /* Fall through.  */
+        fallthrough;
     case 0x18:	/* GPIO_IRQSTATUS1 */
     case 0x28:	/* GPIO_IRQSTATUS2 */
     case 0x60:	/* GPIO_CLEARIRQENABLE1 */
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index de5f5aacf5..3d768ae564 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -156,7 +156,7 @@ int bitbang_i2c_set(bitbang_i2c_interface *i2c, int line, int level)
     case RECEIVING_BIT7:
         i2c->buffer = i2c_recv(i2c->bus);
         trace_bitbang_i2c_recv(i2c->buffer);
-        /* Fall through... */
+        fallthrough;
     case RECEIVING_BIT6 ... RECEIVING_BIT0:
         data = i2c->buffer >> 7;
         /* will end up in SENDING_ACK */
-- 
2.39.2


