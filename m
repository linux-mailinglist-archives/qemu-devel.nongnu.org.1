Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B37DB940
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:49:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQke-0007rK-2N; Mon, 30 Oct 2023 07:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkb-0007or-Ds
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkY-0007Hg-4i
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32deb2809daso2759843f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666484; x=1699271284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pm1CVuPPnKuyid7/qwQ4aH08/PxePci45dgYY6sxK0=;
 b=tEhrO7c9dNphMlRIKhcNdKcZoMOdCTWMqP2O4wcH0ywjf6m5uZ+jBqS/NgtmMbbCnm
 hOc2EpDRjsmTJNITJphCGaR1yfnYqOEYlu4J0GEH2Sxmz2kRJbgjw1n6lIuXnXa4hUYL
 jGdakFpUZM6hCJc73Qm/AB5qi+k60/dkUpvjggTCy79dYGMsXNY0ZmgLmaHLSyImGrZq
 99mEVCjvbjQsbOOIH04UUGSmBtNSlfT8cHs9qPOsI5rSMeAexT3kYY+XjYyiF5u685Jn
 Y53PJ0zgdHOJtXUV9S9hNeCyZb3VrngyZv4B+8CcsdBml9EGQgD/u7L43sbpc+K40Flg
 gEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666484; x=1699271284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pm1CVuPPnKuyid7/qwQ4aH08/PxePci45dgYY6sxK0=;
 b=wxuqkH9tKPGuiSTS3IwVRPOTYB1AtJFcy0tEXXh1PcXsVCZFiIsHVLtROxvOm6SD7I
 OBxZjed8Pa0oCM01CXVkiO+ZF8j26IUh5AN1FkTfLc+lZQPC+896g3U9PzDrwNgBbeE5
 GVyBoPDKkwVZhbYQzRKPQV4lbHkIhMYXKGXFKnZ9T2B/SySOVO5nHKlm+OYG5GOk/917
 3aJVjZJ1QIHcIp9ALw4g8iy1iS6qIJBPo069U2+VX7vsTdwSXI7cagHq9/BD5ngYdUkx
 OVABbvQYW6juJh5phfOK7dA7V/qMnK79omYoeLfY4QDxAq51sk/kcsBJGw0Yi868W2LV
 XO7w==
X-Gm-Message-State: AOJu0Yyb18Cu5IP1fxXMk89v2rDUUyZ05D3KMFv0KiNfKi5b6HNWO/9n
 s22Xh7JgfoV6eAgII031gpdfag==
X-Google-Smtp-Source: AGHT+IEQQRmX/8YBkqDbFvj4BbzR2Tt6qZNMs852SbVyMuZ3R6uageHYLo877e2upOEYDIdscCEbpQ==
X-Received: by 2002:a5d:4c45:0:b0:32d:8961:d864 with SMTP id
 n5-20020a5d4c45000000b0032d8961d864mr6580246wrt.48.1698666484487; 
 Mon, 30 Oct 2023 04:48:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 az30-20020adfe19e000000b0032f7d7ec4adsm5262268wrb.92.2023.10.30.04.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 04:48:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 1/6] hw/input/stellaris_input: Rename to stellaris_gamepad
Date: Mon, 30 Oct 2023 11:47:57 +0000
Message-Id: <20231030114802.3671871-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030114802.3671871-1-peter.maydell@linaro.org>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

This source file implements a stellaris gamepad device; rename
it so that it is a closer match to the device name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/input/{gamepad.h => stellaris_gamepad.h} | 6 +++---
 hw/arm/stellaris.c                                  | 2 +-
 hw/input/{stellaris_input.c => stellaris_gamepad.c} | 2 +-
 hw/arm/Kconfig                                      | 2 +-
 hw/input/Kconfig                                    | 2 +-
 hw/input/meson.build                                | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/input/{gamepad.h => stellaris_gamepad.h} (77%)
 rename hw/input/{stellaris_input.c => stellaris_gamepad.c} (98%)

diff --git a/include/hw/input/gamepad.h b/include/hw/input/stellaris_gamepad.h
similarity index 77%
rename from include/hw/input/gamepad.h
rename to include/hw/input/stellaris_gamepad.h
index 6f6aa2406aa..23cfd3c95f3 100644
--- a/include/hw/input/gamepad.h
+++ b/include/hw/input/stellaris_gamepad.h
@@ -8,11 +8,11 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef HW_INPUT_GAMEPAD_H
-#define HW_INPUT_GAMEPAD_H
+#ifndef HW_INPUT_STELLARIS_GAMEPAD_H
+#define HW_INPUT_STELLARIS_GAMEPAD_H
 
 
-/* stellaris_input.c */
+/* stellaris_gamepad.c */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
 
 #endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index aa5b0ddfaa5..96585dd7106 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -23,7 +23,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
-#include "hw/input/gamepad.h"
+#include "hw/input/stellaris_gamepad.h"
 #include "hw/irq.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_gamepad.c
similarity index 98%
rename from hw/input/stellaris_input.c
rename to hw/input/stellaris_gamepad.c
index e6ee5e11f1b..3bab557cab3 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_gamepad.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/input/gamepad.h"
+#include "hw/input/stellaris_gamepad.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e683484405..841f3131ea5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -291,7 +291,7 @@ config STELLARIS
     select SSD0303 # OLED display
     select SSD0323 # OLED display
     select SSI_SD
-    select STELLARIS_INPUT
+    select STELLARIS_GAMEPAD
     select STELLARIS_ENET # ethernet
     select STELLARIS_GPTM # general purpose timer module
     select UNIMP
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 55865bb3869..f86e98c8293 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -20,7 +20,7 @@ config PL050
 config PS2
     bool
 
-config STELLARIS_INPUT
+config STELLARIS_GAMEPAD
     bool
 
 config TSC2005
diff --git a/hw/input/meson.build b/hw/input/meson.build
index c0d44821800..640556bbbcc 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -5,7 +5,7 @@ system_ss.add(when: 'CONFIG_LM832X', if_true: files('lm832x.c'))
 system_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
 system_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
 system_ss.add(when: 'CONFIG_PS2', if_true: files('ps2.c'))
-system_ss.add(when: 'CONFIG_STELLARIS_INPUT', if_true: files('stellaris_input.c'))
+system_ss.add(when: 'CONFIG_STELLARIS_GAMEPAD', if_true: files('stellaris_gamepad.c'))
 system_ss.add(when: 'CONFIG_TSC2005', if_true: files('tsc2005.c'))
 
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
-- 
2.34.1


