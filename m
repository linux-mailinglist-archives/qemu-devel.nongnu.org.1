Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380FC2062F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 14:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vET5Q-0008IK-RU; Thu, 30 Oct 2025 09:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vET5M-0008Hz-OY
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:53:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vET5B-0001E0-LF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:53:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so658194f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761832366; x=1762437166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RB+ggqV0a2IwbOZ+e3KfD58x40q0f/jc78TSRG7FPN4=;
 b=TD2pbB52buKqMsgmCCWEtysWgHaHDiTvgHMgyM+odgRcqz3lJojfX7SiOOkSI1QrMc
 nbRI2Hv4HOPUjnN08oW4+shre+uAunrZPeBcCTmYxu3hDmkMCxquFOBC2uuo6+6zPoOM
 u8KHtlND/Jn01c64adPAHWY0zpuPldiiHsKI0gWzb4ip/lLGIO89uaeKs8XlqnRtjtVw
 hsQujpctFFGtwDslSNEqmNnUDdKq/ANMFjnxiCiFBjpGjD0MH2g9kGK88O2xi3FX7Px4
 izZ8FKIOVtWKnvphYqtYKXqXwDVvsfmxA5sqs0greDMQ5HFSY86ywZzHx8gt/svSLC4o
 gCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761832366; x=1762437166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RB+ggqV0a2IwbOZ+e3KfD58x40q0f/jc78TSRG7FPN4=;
 b=r6rV+Xicv/Aa6LjFEodGLasKGQbrXA/YrY7hsjFHLqsGOhkwno0Qds8g8ox6XRGUYt
 Y8ZHsdkoX43Yv/KQpN8znxOf9rtZ94T7XDKPnpbssnRMLZ8TiZCya6exRUE6Ho4yVYy+
 jq8X01IUhStYCd8F4M9dPaC8nf/G4KnoTaaBe2mzzc/v+OMI3XRiF0iN/kORpcjI9M3Q
 1t1Eibm1RnNOrZD8Xxdy2awUi/ZwBS/hyVvtwBvvBhyhOQgihEwlUthHnnufmZCgTBmR
 xvl2rds2pnWDXu9Q4ZIJxfNPxQCOym5ocoaIjVWCuX0AGAfOykMVFsE1e9k2aCfVupt0
 YInw==
X-Gm-Message-State: AOJu0Yx5B1w2AbyfjpDZRoUbbJigpbCSOQIgVWSyilE6vSm6oEO6ERm2
 pdBhRyw6g3PhIkkW1o0ssYq0Rvj+T4KpEYn1soc4HtACNYU0lUoQo7QbZ2MNCaWw4noDSC02qD5
 7rAyfeEDw7Q==
X-Gm-Gg: ASbGnct0k0M6XP/M53prfLlVBO77+JMjddYvsNYIzT28h/ZtX6KOFmza4rlEYoLEYdv
 waA1atoBaf+bLePTQTpH/t3SRd/his80MlAACoaIeSggOms4a+uLiD+YDnMPATDiuXHS8w5IpCc
 5opS+sxKGuyyPGbwcot0GQnMta3od83f1ThKVEhuNEjbluu+q9+7LcXss/t+Tp0JbOfX3XWMdzc
 Bq0VkvMjyqeymvgqiY4UY9Ul+S4NN1SkPsISdP2tMNmKIlzitlvJA1Xsx3DJ8uPwOMroxFJSPMZ
 f97kdlMqGZoD5kISFDiIMz9lei0KPsJ94Zr77OJ/HLwte40ZFTxCsTBkMYDPdK1b9I0kL+dzeou
 1LQ0AQM+9JYBu3Ommjtr7v0q+ywNferdKaUSzTbzr1W+4opbd5mgh+zBrHtWDsI7Yjb6Zq/ELnD
 qxCXPjmFC0Bkcs5CBNE9u0tuvpA6zBwTk9KFYz/iazRSw+Ciw=
X-Google-Smtp-Source: AGHT+IEv8uGP150T6YsmKwiOW+iLeTuPSRnv9+Hd/l6z7CD5Ol7McTnCqf/rTba4h++AwDhvbFep3A==
X-Received: by 2002:a05:6000:4283:b0:429:ba8a:a848 with SMTP id
 ffacd0b85a97d-429ba8aa8e0mr1312336f8f.3.1761832366161; 
 Thu, 30 Oct 2025 06:52:46 -0700 (PDT)
Received: from localhost.localdomain (124.149.216.82.rev.sfr.net.
 [82.216.149.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fc19344sm522315e9.2.2025.10.30.06.52.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Oct 2025 06:52:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL v2 04/23] hw/arm: Filter machine types for
 qemu-system-arm/aarch64 binaries
Date: Thu, 30 Oct 2025 14:51:39 +0100
Message-ID: <20251030135139.20433-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030135139.20433-1-philmd@linaro.org>
References: <20251030135139.20433-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Register machines to be able to run with the qemu-system-arm
and qemu-system-aarch64 binaries, except few machines which
are only available on the qemu-system-aarch64 binary:

  $ git grep TARGET_AARCH64 hw/arm/meson.build
  hw/arm/meson.build:31:arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
  hw/arm/meson.build:50:arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))

  $ git grep -W AARCH64 hw/arm/Kconfig
  hw/arm/Kconfig=185=config SBSA_REF
  hw/arm/Kconfig-186-    bool
  hw/arm/Kconfig-187-    default y
  hw/arm/Kconfig:188:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=413=config XLNX_ZYNQMP_ARM
  hw/arm/Kconfig-414-    bool
  hw/arm/Kconfig-415-    default y if PIXMAN
  hw/arm/Kconfig:416:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=435=config XLNX_VERSAL
  hw/arm/Kconfig-436-    bool
  hw/arm/Kconfig-437-    default y
  hw/arm/Kconfig:438:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=475=config NPCM8XX
  hw/arm/Kconfig-476-    bool
  hw/arm/Kconfig-477-    default y
  hw/arm/Kconfig:478:    depends on TCG && AARCH64
  --
  hw/arm/Kconfig=605=config FSL_IMX8MP_EVK
  hw/arm/Kconfig-606-    bool
  hw/arm/Kconfig-607-    default y
  hw/arm/Kconfig:608:    depends on TCG && AARCH64

  $ git grep -wW TARGET_AARCH64 hw/arm | fgrep -4 MACHINE_TYPE_NAME
  ...
  hw/arm/aspeed.c:1939:#ifdef TARGET_AARCH64
  hw/arm/aspeed.c-1940-    }, {
  hw/arm/aspeed.c-1941-        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),

  hw/arm/aspeed.c-1949-        .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),

  hw/arm/raspi.c:420:#ifdef TARGET_AARCH64
  hw/arm/raspi.c-421-    }, {
  hw/arm/raspi.c-422-        .name           = MACHINE_TYPE_NAME("raspi3ap"),

  hw/arm/raspi.c-429-    }, {
  hw/arm/raspi.c-430-        .name           = MACHINE_TYPE_NAME("raspi3b"),

This can be verified as:

$ diff -u0 <(qemu-system-arm -M help) <(qemu-system-aarch64 -M help)
  @@ -1,0 +2,3 @@
  +xlnx-versal-virt     AMD Versal Virtual development board (alias of amd-versal-virt)
  +amd-versal-virt      AMD Versal Virtual development board
  +amd-versal2-virt     AMD Versal Gen 2 Virtual development board
  @@ -4,0 +8,5 @@
  +ast2700a0-evb        Aspeed AST2700 A0 EVB (Cortex-A35)
  +ast2700-evb          Aspeed AST2700 A1 EVB (Cortex-A35) (alias of ast2700a1-evb)
  +ast2700a1-evb        Aspeed AST2700 A1 EVB (Cortex-A35)
  +ast2700fc            ast2700 full core support (alias of ast2700fc)
  +ast2700fc            ast2700 full core support
  @@ -20,0 +29 @@
  +imx8mp-evk           NXP i.MX 8M Plus EVK Board
  @@ -47,0 +57 @@
  +npcm845-evb          Nuvoton NPCM845 Evaluation Board (Cortex-A35)
  @@ -60,0 +71,3 @@
  +raspi3ap             Raspberry Pi 3A+ (revision 1.0)
  +raspi3b              Raspberry Pi 3B (revision 1.2)
  +raspi4b              Raspberry Pi 4B (revision 1.5)
  @@ -66,0 +80 @@
  +sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
  @@ -99,0 +114 @@
  +xlnx-zcu102          Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs based on the value of smp

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021205741.57109-5-philmd@linaro.org>
---
 hw/arm/aspeed.c            | 27 ++++++++++++++++++++++++++-
 hw/arm/aspeed_ast27x0-fc.c |  2 ++
 hw/arm/b-l475e-iot01a.c    |  2 ++
 hw/arm/bananapi_m2u.c      |  3 ++-
 hw/arm/collie.c            |  2 ++
 hw/arm/cubieboard.c        |  3 ++-
 hw/arm/digic_boards.c      |  3 ++-
 hw/arm/exynos4_boards.c    |  3 +++
 hw/arm/fby35.c             |  2 ++
 hw/arm/highbank.c          |  3 +++
 hw/arm/imx25_pdk.c         |  3 ++-
 hw/arm/imx8mp-evk.c        |  4 +++-
 hw/arm/integratorcp.c      |  3 ++-
 hw/arm/kzm.c               |  3 ++-
 hw/arm/mcimx6ul-evk.c      |  4 +++-
 hw/arm/mcimx7d-sabre.c     |  4 +++-
 hw/arm/microbit.c          |  2 ++
 hw/arm/mps2-tz.c           |  5 +++++
 hw/arm/mps2.c              |  5 +++++
 hw/arm/mps3r.c             |  2 ++
 hw/arm/msf2-som.c          |  3 ++-
 hw/arm/musca.c             |  3 +++
 hw/arm/musicpal.c          |  3 ++-
 hw/arm/netduino2.c         |  3 ++-
 hw/arm/netduinoplus2.c     |  3 ++-
 hw/arm/npcm7xx_boards.c    |  6 ++++++
 hw/arm/npcm8xx_boards.c    |  2 ++
 hw/arm/olimex-stm32-h405.c |  3 ++-
 hw/arm/omap_sx1.c          |  3 +++
 hw/arm/orangepi.c          |  3 ++-
 hw/arm/raspi.c             |  6 ++++++
 hw/arm/raspi4b.c           |  2 ++
 hw/arm/realview.c          |  5 +++++
 hw/arm/sabrelite.c         |  3 ++-
 hw/arm/sbsa-ref.c          |  2 ++
 hw/arm/stellaris.c         |  3 +++
 hw/arm/stm32vldiscovery.c  |  3 ++-
 hw/arm/versatilepb.c       |  3 +++
 hw/arm/vexpress.c          |  3 +++
 hw/arm/virt.c              |  2 ++
 hw/arm/xilinx_zynq.c       |  2 ++
 hw/arm/xlnx-versal-virt.c  |  3 +++
 hw/arm/xlnx-zcu102.c       |  2 ++
 43 files changed, 138 insertions(+), 18 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1bc9e534ba4..ecc7272e67c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -15,6 +15,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/aspeed_eeprom.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
@@ -1967,99 +1968,123 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_dc_scm_v1_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-firework-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fp5280g2_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_gb200nvl_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_catalina_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
+        .interfaces    = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+        .interfaces     = arm_machine_interfaces,
 #ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a0_evb_class_init,
-        }, {
+        .interfaces    = aarch64_machine_interfaces,
+    }, {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .interfaces    = aarch64_machine_interfaces,
 #endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 580ac5f7a12..b96ef3f97ab 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,6 +22,7 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
+#include "hw/arm/machines-qom.h"
 
 #define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);
@@ -220,6 +221,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
+        .interfaces     = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 34ed2e0851b..f1fbc774e52 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/core/split-irq.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/display/dm163.h"
@@ -131,6 +132,7 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
+        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index b750a575f72..0f6d98684b9 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 static struct arm_boot_info bpim2u_binfo;
 
@@ -144,4 +145,4 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
+DEFINE_MACHINE_ARM("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 93bb190f1f9..5a80b7a2238 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -15,6 +15,7 @@
 #include "hw/boards.h"
 #include "strongarm.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
@@ -86,6 +87,7 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
+    .interfaces = arm_machine_interfaces,
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index d665d4edd97..aa51c0a7034 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
 static struct arm_boot_info cubieboard_binfo = {
@@ -125,4 +126,4 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
+DEFINE_MACHINE_ARM("cubieboard", cubieboard_machine_init)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index de56991baca..23b596d0c81 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -29,6 +29,7 @@
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "hw/arm/digic.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/loader.h"
 #include "system/qtest.h"
@@ -145,4 +146,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
+DEFINE_MACHINE_ARM("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 73049741312..89f0e944632 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "system/address-spaces.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
@@ -172,6 +173,7 @@ static const TypeInfo nuri_type = {
     .name = MACHINE_TYPE_NAME("nuri"),
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void smdkc210_class_init(ObjectClass *oc, const void *data)
@@ -192,6 +194,7 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 5a94c847d36..70d3a99d79e 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -14,6 +14,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 #define TYPE_FBY35 MACHINE_TYPE_NAME("fby35")
 OBJECT_DECLARE_SIMPLE_TYPE(Fby35State, FBY35);
@@ -194,6 +195,7 @@ static const TypeInfo fby35_types[] = {
         .class_init = fby35_class_init,
         .instance_size = sizeof(Fby35State),
         .instance_init = fby35_instance_init,
+        .interfaces = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index ff987467a99..bd60ab26898 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -23,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/loader.h"
 #include "net/net.h"
 #include "system/runstate.h"
@@ -365,6 +366,7 @@ static const TypeInfo highbank_type = {
     .name = MACHINE_TYPE_NAME("highbank"),
     .parent = TYPE_MACHINE,
     .class_init = highbank_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void midway_class_init(ObjectClass *oc, const void *data)
@@ -390,6 +392,7 @@ static const TypeInfo midway_type = {
     .name = MACHINE_TYPE_NAME("midway"),
     .parent = TYPE_MACHINE,
     .class_init = midway_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void calxeda_machines_init(void)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index e95ea5e4e18..71a46062032 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
@@ -150,4 +151,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
+DEFINE_MACHINE_ARM("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index b3082fa60d8..fc880a1d44b 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -10,6 +10,7 @@
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "system/qtest.h"
@@ -100,4 +101,5 @@ static void imx8mp_evk_machine_init(MachineClass *mc)
     mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
     mc->default_ram_id = "imx8mp-evk.ram";
 }
-DEFINE_MACHINE("imx8mp-evk", imx8mp_evk_machine_init)
+
+DEFINE_MACHINE_AARCH64("imx8mp-evk", imx8mp_evk_machine_init)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b1d8fbd470a..031380aada2 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -13,6 +13,7 @@
 #include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
@@ -693,7 +694,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
+DEFINE_MACHINE_ARM("integratorcp", integratorcp_machine_init)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 362c1454099..b446dc15470 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
@@ -139,4 +140,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init)
+DEFINE_MACHINE_ARM("kzm", kzm_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 86982cb0772..f47a265650e 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
@@ -76,4 +77,5 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->default_ram_id = "mcimx6ul-evk.ram";
     mc->auto_create_sdcard = true;
 }
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+
+DEFINE_MACHINE_ARM("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 33119610113..fc8f35c5810 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
@@ -76,4 +77,5 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
 }
-DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
+
+DEFINE_MACHINE_ARM("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 525443fdb97..0f3161fd931 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
 
@@ -74,6 +75,7 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 5dd87cc0281..55dd68c57e1 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -52,6 +52,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "system/address-spaces.h"
@@ -1463,24 +1464,28 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index bd378e360b0..fa4b200577f 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "system/address-spaces.h"
@@ -567,24 +568,28 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 48c73acc62e..fcb8777cafd 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
@@ -634,6 +635,7 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
+        .interfaces = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 29c76c68605..c26feccb15b 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -32,6 +32,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/qdev-clock.h"
 #include "system/address-spaces.h"
 #include "hw/arm/msf2-soc.h"
@@ -108,4 +109,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
+DEFINE_MACHINE_ARM("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 250b3b5bf84..a3494c96bf4 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -26,6 +26,7 @@
 #include "system/system.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armsse.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/char/pl011.h"
 #include "hw/core/split-irq.h"
@@ -657,12 +658,14 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 329b162eb20..1ae7cbd95c8 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -15,6 +15,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/boards.h"
@@ -1346,7 +1347,7 @@ static void musicpal_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE("musicpal", musicpal_machine_init)
+DEFINE_MACHINE_ARM("musicpal", musicpal_machine_init)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index df793c77fe1..bce0d6f87a9 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (120MHz) */
 #define SYSCLK_FRQ 120000000ULL
@@ -65,4 +66,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init)
+DEFINE_MACHINE_ARM("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 81b6334cf72..8594081fe47 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (168MHz) */
 #define SYSCLK_FRQ 168000000ULL
@@ -65,4 +66,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
+DEFINE_MACHINE_ARM("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 465a0e5acec..c1e100b1e48 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/npcm7xx.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
@@ -549,22 +550,27 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm750-evb"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("kudo-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("mori-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 3bf3e1f8f16..b179eadef53 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -19,6 +19,7 @@
 #include "chardev/char.h"
 #include "hw/boards.h"
 #include "hw/arm/npcm8xx.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
 #include "hw/qdev-core.h"
@@ -248,6 +249,7 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
+        .interfaces     = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 1f15620f9fd..c5f60383335 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* olimex-stm32-h405 implementation is derived from netduinoplus2 */
 
@@ -71,4 +72,4 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+DEFINE_MACHINE_ARM("olimex-stm32-h405", olimex_stm32_h405_machine_init)
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 5d4a31b7aed..730525be2dc 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -32,6 +32,7 @@
 #include "hw/arm/omap.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/qtest.h"
 #include "system/address-spaces.h"
@@ -219,6 +220,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, const void *data)
@@ -238,6 +240,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index e0956880d11..3e237e78fa1 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 static struct arm_boot_info orangepi_binfo;
 
@@ -124,4 +125,4 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
+DEFINE_MACHINE_ARM("orangepi-pc", orangepi_machine_init)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fbf3e09c030..81d2fa1b67d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
@@ -394,23 +395,28 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
+        .interfaces     = arm_machine_interfaces,
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+        .interfaces     = aarch64_machine_interfaces,
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 4df951a0d82..0422ae0f00b 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -11,6 +11,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/registerfields.h"
@@ -123,6 +124,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .interfaces     = aarch64_machine_interfaces,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 5c9050490b4..b940cbf2c11 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/core/split-irq.h"
 #include "hw/net/lan9118.h"
 #include "hw/net/smc91c111.h"
@@ -431,6 +432,7 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, const void *data)
@@ -452,6 +454,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, const void *data)
@@ -471,6 +474,7 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, const void *data)
@@ -491,6 +495,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index df60d47c6fd..5b4ab7d77a5 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
@@ -113,4 +114,4 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
+DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 15c1ff4b140..cf6e6eb208a 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -35,6 +35,7 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/ide/ide-bus.h"
@@ -922,6 +923,7 @@ static const TypeInfo sbsa_ref_info = {
     .instance_init = sbsa_ref_instance_init,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
+    .interfaces    = aarch64_machine_interfaces,
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 031ea3a24e7..8113bbd5d8b 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -15,6 +15,7 @@
 #include "hw/sd/sd.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
@@ -1427,6 +1428,7 @@ static const TypeInfo lm3s811evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s811evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 /*
@@ -1448,6 +1450,7 @@ static const TypeInfo lm3s6965evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s6965evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void stellaris_machine_init(void)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index e6c1f5b8d7d..c11029f8bd4 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 
 /* stm32vldiscovery implementation is derived from netduinoplus2 */
 
@@ -68,4 +69,4 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
+DEFINE_MACHINE_ARM("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 5cf1a70d10d..6fc1e62789e 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -12,6 +12,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "system/system.h"
@@ -431,6 +432,7 @@ static const TypeInfo versatilepb_type = {
     .name = MACHINE_TYPE_NAME("versatilepb"),
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void versatileab_class_init(ObjectClass *oc, const void *data)
@@ -452,6 +454,7 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 60cd375fe75..f30923a658c 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
@@ -850,6 +851,7 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -857,6 +859,7 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
+    .interfaces = arm_machine_interfaces,
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a7..20e3f1094cb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -37,6 +37,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
@@ -127,6 +128,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .interfaces = arm_aarch64_machine_interfaces, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0372cd0ac46..c82edd3bed1 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -20,6 +20,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/boards.h"
@@ -480,6 +481,7 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
+    .interfaces = arm_machine_interfaces,
 };
 
 static void zynq_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 149b448546e..5e05521a572 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -21,6 +21,7 @@
 #include "hw/arm/fdt.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
@@ -401,12 +402,14 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
+    .interfaces = aarch64_machine_interfaces,
 };
 
 static const TypeInfo versal2_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal2_virt_machine_class_init,
+    .interfaces = aarch64_machine_interfaces,
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 14b6641a713..330f375f63a 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -19,6 +19,7 @@
 #include "qapi/error.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -303,6 +304,7 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
+    .interfaces = aarch64_machine_interfaces,
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
-- 
2.51.0


