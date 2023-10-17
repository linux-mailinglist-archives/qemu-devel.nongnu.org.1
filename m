Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF487CC319
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsj6N-0006Xh-Sf; Tue, 17 Oct 2023 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6K-0006WW-Q2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6I-0003uE-Rv
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4056ce55e7eso54067855e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697545385; x=1698150185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z+dBuj8Vl8/qNTxYaFNacqekLLopYIUokXsNr5A2Ax0=;
 b=nbQemaBD6mN3ypdwiDW+xa3XVsFTpTk04eumBwonl5G7MtDVWSFI2CyU4Y1N7lztN4
 I/IaxgNi27qhcoHIOlqREsdpD5d7QrsOeKE5WyeX4kY4t/d2gw/ZGFR4CHqqtGv2S6hi
 iDt5EdctNAvWdSlvCQoYFgSNBW/0apO4qsUWVK5Od2ZGS2lRhvCFnUnt1JJDcCvxaLPe
 M6HPOsr3CkYH43PSzVvmBPMDaOdihYZWYVsyLgxpKgGbmmkXfZ27NDl0g7M69Fkm7Kut
 ZanwEgrQtZs5hx3ij2gfW/maa9bY5aoDdT3I2Kze+ZsDpkgLB18a+G7ts1Xc0b33m97G
 EYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697545385; x=1698150185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+dBuj8Vl8/qNTxYaFNacqekLLopYIUokXsNr5A2Ax0=;
 b=FUp+8fIjMYBHd48mE9WuEta/BMwKUaeb8wISNKgE9Nh5y0vVIp9gOj/otocqITbniD
 u00o6JaTrbf9rcW1KcRyY7YCO3n9x9yVFo1F4MY0rs+E8ffXWHUBXOjpvQutialYmiSe
 YUhOEhVxA4haqYDsMMB+8Z/BQynw46nmXogj97BntzNIWIsilw5mF3IlAc6kgYyuEIY+
 O+NfBuTiiHikAsjCOcH61p5pSMiRtHL/y6Jx461stVYRq+6KH3FJeU8QxclMN61GiltC
 2nOlTJRJ0cI8YUN7Ity8SRnKzhcK0wjqPVpatpMhhTnGofRGpI94Rzst4SfrPY4ssImm
 VqPw==
X-Gm-Message-State: AOJu0YytBza94gdlp2W9iNnza/h0TA8aKoMa7UoQ+ENoGjb1QOd4qt8H
 EUc93QLNa9HuNhdv+Qu91nzV2HljcI4W3L7bhkA=
X-Google-Smtp-Source: AGHT+IE+EMfT27Fh3oKcnKaPGVRzzrWVzzgP2p9yXd+kZ08LZ+9eXddZOgxnHs92eoGviyF0YW1TVg==
X-Received: by 2002:adf:f882:0:b0:32d:9a36:b518 with SMTP id
 u2-20020adff882000000b0032d9a36b518mr1594160wrp.69.1697545384721; 
 Tue, 17 Oct 2023 05:23:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0032da4c98ab2sm1590905wrs.35.2023.10.17.05.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:23:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/input/stellaris_input: Rename to stellaris_gamepad
Date: Tue, 17 Oct 2023 13:22:57 +0100
Message-Id: <20231017122302.1692902-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017122302.1692902-1-peter.maydell@linaro.org>
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

This source file implements a stellaris gamepad device; rename
it so that it is a closer match to the device name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


