Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B458C7D9BC6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0h-0007lc-TV; Fri, 27 Oct 2023 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0J-0007Lk-U2
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0G-0008Bb-CH
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso17021765e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417599; x=1699022399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kurXcGyQg+iVSy8QLhx9etYA4XnqvmAMFyclbQPpsa4=;
 b=Oydjx04eBMNEL+kVPQDzyw3JEXsBM6CwrkdzIkMQNJzHAZYnYf3mEGEDpSjGhOhCBa
 kHr/shyJATHXGUxULhvR0tjfKa5Dt7Jjbg9IfbQBQL6jUMwcGjfzWkRGc9m4gngUXUtK
 kJ/sugkw0O6YjrURKEHpc8zvfljrC/iuvKNwDxjEIZk6GshXAIKx0c2hOHTKtpHHsMjD
 0DXn5W+BGniWwkUkKWorQFhRGnGur/1GuwR1HhJem4rgsIaOs3bzlwTeyy0zGG3d8Vq7
 TFNC5/oTN2/DgxPzm6w2oAhkr8r3ek6TtLaM8HRJxDpJ9yeCywfJI/ZuKFBjBzL7Nn90
 6mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417599; x=1699022399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kurXcGyQg+iVSy8QLhx9etYA4XnqvmAMFyclbQPpsa4=;
 b=wLQHPypqMD5dB4fz+3PaEA4X+gM6w2bq0oSJv/TpDkaxrgacgqTD92Q/HIcynLSOHV
 m3uRV2fthTKstoTVRuAS7iwetaM40bTGrb0k6diR02sUaw0P8h+bRq/tnFAGrqgKsOSB
 Vo/gg0S6WKFvLoP9n1j9AyqtexQNHNwL+xPMH1MVRAw7xGIKueLKsra99DxuSPnyP28P
 t700D8hb3OxPiAkv+pFu/p5Pvlx0uSJBsxfP66wpfFaqEZTnsM/CesgFcYuuBMO+3dJT
 nWIAZOhy9UUhj4gYc4Snn3ITJUDFeuFv+GOcjPHJ8qMsMBL3fEmxUrKsHDpd/tC6BTGf
 YRog==
X-Gm-Message-State: AOJu0YyMNwn27S50OM2sfszCw0mEvg/OMPN69MAD5DtkmiaV8456lgQK
 CavtOtLwi6VocIRWVsBb6tjL1U2JdKkFxH8hmBU=
X-Google-Smtp-Source: AGHT+IF9mIO+7dTFl08EIkEdJFEINczrE4/HmBvO/ELKaGQe8aG5gFFWfbKfhOiw3Bi6xWM1Yue2yA==
X-Received: by 2002:a05:600c:5119:b0:409:2f7:d771 with SMTP id
 o25-20020a05600c511900b0040902f7d771mr2690915wms.4.1698417598859; 
 Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] misc/led: LED state is set opposite of what is expected
Date: Fri, 27 Oct 2023 15:39:31 +0100
Message-Id: <20231027143942.3413881-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Testing of the LED state showed that when the LED polarity was
set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
the input GPIO of the LED, the LED was being turn off when it was
expected to be turned on.

Fixes: ddb67f6402 ("hw/misc/led: Allow connecting from GPIO output")
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Message-id: 20231024191945.4135036-1-milesg@linux.vnet.ibm.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/led.c b/hw/misc/led.c
index f6d6d68bce5..42bb43a39a2 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -63,7 +63,7 @@ static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
     LEDState *s = LED(opaque);
 
     assert(line == 0);
-    led_set_state(s, !!new_state != s->gpio_active_high);
+    led_set_state(s, !!new_state == s->gpio_active_high);
 }
 
 static void led_reset(DeviceState *dev)
-- 
2.34.1


