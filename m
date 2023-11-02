Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AAA7DF8F7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfP-0003oT-3I; Thu, 02 Nov 2023 13:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003Go-FE
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeS-0002hD-La
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5094727fa67so1489934e87.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946718; x=1699551518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sgDJG5akxTAKePXGw4lqiUSqBtfv2oC7eu7relbo21k=;
 b=jtCdb26NTFuiGeyHLsl7Dg/73PJ1MzK/qJsVQzd/Sn99frgjU/iWWAmgLTfLxMZ7yv
 9blL8YfUrQTxNnfKsWME1txpWwp/0LTa32dbfMtuwf0m8VJLuOuXnQjg52lsatltnm4A
 AtcaBx4unMsMmQ7SmkxFPv60xXCOTaUA3pmgEY0j6kd9Ypd0/eWtvqZuEtR7w0zG8z+t
 q6mdmwZD29SmL5E0O5bzzHCEt/uSqMjMQlrIO6EgACfNaZO0+/IHYGExpA7pKza1v8XS
 kqQmvqKyP7CKkEMRg+kAzc/V7a6ydoMbT+JlVhKi1w6k08wpLwKB+WAtxMT2luaUuhGA
 Pn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946718; x=1699551518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgDJG5akxTAKePXGw4lqiUSqBtfv2oC7eu7relbo21k=;
 b=NeAuZt2mZ33tigwDZ3TZMvNKp52XIuSleK5ENzuK66oeIDh5H/lTmGTJgiB8Inpili
 mTrkpsbRt59kd6a/MLmRAFnEssOxc7tpuDUaiJGh+AuHT6r94c/tj17KO/b3EMBVu44n
 OlRdtJcK875uBHgKFz9n70XCEAjhrWMjYTN2k+948vJaWQfCkApVyJOQXb92nEE2xDTo
 1O428dUHoO/P/ijC64hz9XJylQemIwcRaD2YgKuBN8/9JZ+cSqLupS3UboHRF1F7FSnZ
 htTdbBvEHd3iiQSq0ku6qDDjezdEw5rOHels5AXPaSsHoG8koM9MtADKm8Su9dT1O0Pb
 NM2A==
X-Gm-Message-State: AOJu0YzOCc0ztQczIIFiWXUl42s11Znhw3c8TgJt80aE3H3Kwo5WIXnI
 YJrKZffKgZmwCwYDPpZc5FYrrGIbxwNRmi6dtjE=
X-Google-Smtp-Source: AGHT+IElpN7cTRenOxQRVJxKKQvmDF0XJhrCBET9R7uj5uniMjxEY0DQaNdQgPqc+yRG3BXFJgzVKg==
X-Received: by 2002:ac2:5e86:0:b0:507:9702:c11d with SMTP id
 b6-20020ac25e86000000b005079702c11dmr13281349lfq.64.1698946718357; 
 Thu, 02 Nov 2023 10:38:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/33] hw/input/stellaris_input: Rename to stellaris_gamepad
Date: Thu,  2 Nov 2023 17:38:04 +0000
Message-Id: <20231102173835.609985-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

This source file implements a stellaris gamepad device; rename
it so that it is a closer match to the device name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231030114802.3671871-2-peter.maydell@linaro.org
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


