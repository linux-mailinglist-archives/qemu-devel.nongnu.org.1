Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F994709A
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Aug 2024 23:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiPI-0000fL-IM; Sun, 04 Aug 2024 17:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiPG-0000bo-1D
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:46 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiPB-0005ib-3y
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a8caef11fso1135951866b.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722805479; x=1723410279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0tXcCXJohj8h7cWfoRrfKhlyjeqU/qsIHPq7f62cRA=;
 b=O49gOdmjRiBVPYNU+b3wUjHsEa7jCy4n4VRxLbnR5t34t4lCo9Z8XfOTakwFk81QD3
 vUFHQjBaojYdziRReNoqrnHGc5AVP5oFHfg+d9RNyvfD8qpMX6gFuUaahUicVXwkTiBT
 JmdmtML/vbNiXGRsy23eEONcyOsIuxQy5mHzg6ZtS2mfqypM/97k1dmGdqfDe1zA3gJD
 ifSz0sD4aQwHq2HxkVJK0TyEfON/uHhyrNl0qn4B3jDGIi4EYptUgVNHma0KzmIhZP+J
 uc9zjXbcZaT2fvEdS4/AM83KUUOQqO0uuVYDjEgbCyIu4V1D7EIAJ8zALK76M+HgE+9k
 DW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722805479; x=1723410279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0tXcCXJohj8h7cWfoRrfKhlyjeqU/qsIHPq7f62cRA=;
 b=Xh8CQ1vrcI+Vq2ASQ9+SBIuxoBpdX8EgkbI1CXM547BSx6+kPZs2+JzxeSAS7+vMVM
 4swqf4en0G2nUUhI4Mpbs+zjiBtSld6+9emA3FL/1MCK+y62fe2mBG17kjiHyQhu04O6
 bE0EIE0EF8TwRFGQyU6KGys9qmagFKrTfjakiHe56ck0EWqt2Av3dtjxCdNqnvpC9MAa
 g/u5zNJTPXVfGEdMP3H+xehnHUmvaZo0W3TS4zIFBgXE45oZq8Md3h8dFvw2+Vo0E2Bp
 gMDRL6DDkcvep8skaBZaJqHjhyUew1BNKELVwDB8nmgZ2Ybu9J7fdtz5kqvKR1v07x4z
 DAOw==
X-Gm-Message-State: AOJu0YzTJFEu1ErgdDbTBeh8GT5dZ4kwoKgu/T2ftKn9wPiLKO8AH6+S
 xE4Y6vtlm1imAHwcHhX8tRhhCbAx/VVRiZOwh0AyYqGxagnTKB2kqG50OFtmGW/9XPD0r8TySlu
 1vAU=
X-Google-Smtp-Source: AGHT+IEeKrsaZKVcxT19X3LB1n3AM9XfY47zROT3dEinfqBEOJlJ1VsKO3aQcI6B9sTJMFPyaUJAAA==
X-Received: by 2002:a17:907:9707:b0:a77:c043:5b5a with SMTP id
 a640c23a62f3a-a7dc4ffee29mr731137666b.39.1722805478539; 
 Sun, 04 Aug 2024 14:04:38 -0700 (PDT)
Received: from localhost.localdomain (adsl-146.37.6.160.tellas.gr.
 [37.6.160.146]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d437a5sm366348766b.101.2024.08.04.14.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 14:04:38 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Subject: [RFC PATCH v6 5/5] rust: add PL011 device model
Date: Mon,  5 Aug 2024 00:04:16 +0300
Message-ID: <rust-pl011-rfc-v6-5.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
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

This commit adds a re-implementation of hw/char/pl011.c in Rust.

How to build:

1. Configure a QEMU build with:
   --enable-system --target-list=aarch64-softmmu --enable-rust
2. Launching a VM with qemu-system-aarch64 should use the Rust version
   of the pl011 device

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Note: subproject dependencies licenses are not correct.
---
 MAINTAINERS                                   |   5 +
 hw/arm/Kconfig                                |  33 +-
 rust/Kconfig                                  |   1 +
 rust/hw/Kconfig                               |   2 +
 rust/hw/char/Kconfig                          |   3 +
 rust/hw/char/meson.build                      |   1 +
 rust/hw/char/pl011/.gitignore                 |   2 +
 rust/hw/char/pl011/Cargo.lock                 | 125 ++++
 rust/hw/char/pl011/Cargo.toml                 |  26 +
 rust/hw/char/pl011/README.md                  |  31 +
 rust/hw/char/pl011/meson.build                |  28 +
 rust/hw/char/pl011/rustfmt.toml               |   1 +
 rust/hw/char/pl011/src/definitions.rs         |  26 +
 rust/hw/char/pl011/src/device.rs              | 586 ++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs        |  58 ++
 rust/hw/char/pl011/src/lib.rs                 | 584 +++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs          |  56 ++
 rust/hw/meson.build                           |   1 +
 rust/meson.build                              |   2 +
 subprojects/.gitignore                        |  11 +
 subprojects/arbitrary-int.wrap                |   9 +
 subprojects/bilge-impl.wrap                   |  10 +
 subprojects/bilge.wrap                        |  10 +
 subprojects/either.wrap                       |  10 +
 subprojects/itertools.wrap                    |  10 +
 .../packagefiles/arbitrary-int/meson.build    |  19 +
 .../packagefiles/bilge-impl/meson.build       |  36 ++
 subprojects/packagefiles/bilge/meson.build    |  25 +
 subprojects/packagefiles/either/meson.build   |  21 +
 .../packagefiles/itertools/meson.build        |  25 +
 .../proc-macro-error-attr/meson.build         |  27 +
 .../packagefiles/proc-macro-error/meson.build |  32 +
 .../packagefiles/proc-macro2/meson.build      |  26 +
 subprojects/packagefiles/quote/meson.build    |  25 +
 subprojects/packagefiles/syn/meson.build      |  33 +
 .../packagefiles/unicode-ident/meson.build    |  19 +
 subprojects/proc-macro-error-attr.wrap        |  10 +
 subprojects/proc-macro-error.wrap             |  11 +
 subprojects/proc-macro2.wrap                  |  10 +
 subprojects/quote.wrap                        |  10 +
 subprojects/syn.wrap                          |  11 +
 subprojects/unicode-ident.wrap                |  10 +
 42 files changed, 1970 insertions(+), 11 deletions(-)
 create mode 100644 rust/hw/Kconfig
 create mode 100644 rust/hw/char/Kconfig
 create mode 100644 rust/hw/char/meson.build
 create mode 100644 rust/hw/char/pl011/.gitignore
 create mode 100644 rust/hw/char/pl011/Cargo.lock
 create mode 100644 rust/hw/char/pl011/Cargo.toml
 create mode 100644 rust/hw/char/pl011/README.md
 create mode 100644 rust/hw/char/pl011/meson.build
 create mode 120000 rust/hw/char/pl011/rustfmt.toml
 create mode 100644 rust/hw/char/pl011/src/definitions.rs
 create mode 100644 rust/hw/char/pl011/src/device.rs
 create mode 100644 rust/hw/char/pl011/src/device_class.rs
 create mode 100644 rust/hw/char/pl011/src/lib.rs
 create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/hw/meson.build
 create mode 100644 subprojects/arbitrary-int.wrap
 create mode 100644 subprojects/bilge-impl.wrap
 create mode 100644 subprojects/bilge.wrap
 create mode 100644 subprojects/either.wrap
 create mode 100644 subprojects/itertools.wrap
 create mode 100644 subprojects/packagefiles/arbitrary-int/meson.build
 create mode 100644 subprojects/packagefiles/bilge-impl/meson.build
 create mode 100644 subprojects/packagefiles/bilge/meson.build
 create mode 100644 subprojects/packagefiles/either/meson.build
 create mode 100644 subprojects/packagefiles/itertools/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-attr/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2/meson.build
 create mode 100644 subprojects/packagefiles/quote/meson.build
 create mode 100644 subprojects/packagefiles/syn/meson.build
 create mode 100644 subprojects/packagefiles/unicode-ident/meson.build
 create mode 100644 subprojects/proc-macro-error-attr.wrap
 create mode 100644 subprojects/proc-macro-error.wrap
 create mode 100644 subprojects/proc-macro2.wrap
 create mode 100644 subprojects/quote.wrap
 create mode 100644 subprojects/syn.wrap
 create mode 100644 subprojects/unicode-ident.wrap

diff --git a/MAINTAINERS b/MAINTAINERS
index 018f3a9420..2b3d96fa2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1188,6 +1188,11 @@ F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
 F: docs/system/arm/nrf.rst
 
+ARM PL011 Rust device
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/hw/char/pl011/
+
 AVR Machines
 -------------
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..45438c1bc4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -20,7 +20,8 @@ config ARM_VIRT
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL031 # RTC
     select PL061 # GPIO
     select GPIO_PWR
@@ -80,7 +81,8 @@ config HIGHBANK
     select AHCI
     select ARM_TIMER # sp804
     select ARM_V7M
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL022 # SPI
     select PL031 # RTC
     select PL061 # GPIO
@@ -93,7 +95,8 @@ config INTEGRATOR
     depends on TCG && ARM
     select ARM_TIMER
     select INTEGRATOR_DEBUG
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL031 # RTC
     select PL041 # audio
     select PL050 # keyboard/mouse
@@ -119,7 +122,8 @@ config MUSCA
     default y
     depends on TCG && ARM
     select ARMSSE
-    select PL011
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL031
     select SPLIT_IRQ
     select UNIMP
@@ -228,7 +232,8 @@ config Z2
     depends on TCG && ARM
     select PFLASH_CFI01
     select WM8750
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PXA2XX
 
 config REALVIEW
@@ -248,7 +253,8 @@ config REALVIEW
     select WM8750 # audio codec
     select LSI_SCSI_PCI
     select PCI
-    select PL011  # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL031  # RTC
     select PL041  # audio codec
     select PL050  # keyboard/mouse
@@ -273,7 +279,8 @@ config SBSA_REF
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL031 # RTC
     select PL061 # GPIO
     select USB_XHCI_SYSBUS
@@ -297,7 +304,8 @@ config STELLARIS
     select ARM_V7M
     select CMSDK_APB_WATCHDOG
     select I2C
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL022 # SPI
     select PL061 # GPIO
     select SSD0303 # OLED display
@@ -356,7 +364,8 @@ config VEXPRESS
     select ARM_TIMER # sp804
     select LAN9118
     select PFLASH_CFI01
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL041 # audio codec
     select PL181  # display
     select REALVIEW
@@ -440,7 +449,8 @@ config RASPI
     default y
     depends on TCG && ARM
     select FRAMEBUFFER
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select SDHCI
     select USB_DWC2
     select BCM2835_SPI
@@ -515,7 +525,8 @@ config XLNX_VERSAL
     select ARM_GIC
     select CPU_CLUSTER
     select DEVICE_TREE
-    select PL011
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select CADENCE
     select VIRTIO_MMIO
     select UNIMP
diff --git a/rust/Kconfig b/rust/Kconfig
index e69de29bb2..f9f5c39098 100644
--- a/rust/Kconfig
+++ b/rust/Kconfig
@@ -0,0 +1 @@
+source hw/Kconfig
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
new file mode 100644
index 0000000000..4d934f30af
--- /dev/null
+++ b/rust/hw/Kconfig
@@ -0,0 +1,2 @@
+# devices Kconfig
+source char/Kconfig
diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
new file mode 100644
index 0000000000..a1732a9e97
--- /dev/null
+++ b/rust/hw/char/Kconfig
@@ -0,0 +1,3 @@
+config X_PL011_RUST
+    bool
+    default y if HAVE_RUST
diff --git a/rust/hw/char/meson.build b/rust/hw/char/meson.build
new file mode 100644
index 0000000000..5716dc43ef
--- /dev/null
+++ b/rust/hw/char/meson.build
@@ -0,0 +1 @@
+subdir('pl011')
diff --git a/rust/hw/char/pl011/.gitignore b/rust/hw/char/pl011/.gitignore
new file mode 100644
index 0000000000..71eaff2035
--- /dev/null
+++ b/rust/hw/char/pl011/.gitignore
@@ -0,0 +1,2 @@
+# Ignore generated bindings file overrides.
+src/bindings.rs.inc
diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/hw/char/pl011/Cargo.lock
new file mode 100644
index 0000000000..411bfed9c9
--- /dev/null
+++ b/rust/hw/char/pl011/Cargo.lock
@@ -0,0 +1,125 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "arbitrary-int"
+version = "1.2.7"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
+
+[[package]]
+name = "bilge"
+version = "0.2.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57"
+dependencies = [
+ "arbitrary-int",
+ "bilge-impl",
+]
+
+[[package]]
+name = "bilge-impl"
+version = "0.2.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8"
+dependencies = [
+ "itertools",
+ "proc-macro-error",
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "either"
+version = "1.12.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
+
+[[package]]
+name = "itertools"
+version = "0.11.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
+dependencies = [
+ "either",
+]
+
+[[package]]
+name = "pl011"
+version = "0.1.0"
+dependencies = [
+ "arbitrary-int",
+ "bilge",
+ "bilge-impl",
+ "qemu_api",
+]
+
+[[package]]
+name = "proc-macro-error"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
+dependencies = [
+ "proc-macro-error-attr",
+ "proc-macro2",
+ "quote",
+ "version_check",
+]
+
+[[package]]
+name = "proc-macro-error-attr"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "version_check",
+]
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.84"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "qemu_api"
+version = "0.1.0"
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "syn"
+version = "2.0.66"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+
+[[package]]
+name = "version_check"
+version = "0.9.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
new file mode 100644
index 0000000000..67a6973da6
--- /dev/null
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -0,0 +1,26 @@
+[package]
+name = "pl011"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0 OR GPL-3.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "pl011 device model for QEMU"
+repository = "https://gitlab.com/epilys/rust-for-qemu"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
+arbitrary-int = { version = "1.2.7" }
+bilge = { version = "0.2.0" }
+bilge-impl = { version = "0.2.0" }
+qemu_api = { path = "../../../qemu-api" }
+
+# Do not include in any global workspace
+[workspace]
diff --git a/rust/hw/char/pl011/README.md b/rust/hw/char/pl011/README.md
new file mode 100644
index 0000000000..cd7dea3163
--- /dev/null
+++ b/rust/hw/char/pl011/README.md
@@ -0,0 +1,31 @@
+# PL011 QEMU Device Model
+
+This library implements a device model for the PrimeCell® UART (PL011)
+device in QEMU.
+
+## Build static lib
+
+Host build target must be explicitly specified:
+
+```sh
+cargo build --target x86_64-unknown-linux-gnu
+```
+
+Replace host target triplet if necessary.
+
+## Generate Rust documentation
+
+To generate docs for this crate, including private items:
+
+```sh
+cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+```
+
+To include direct dependencies like `bilge` (bitmaps for register types):
+
+```sh
+cargo tree --depth 1 -e normal --prefix none \
+ | cut -d' ' -f1 \
+ | xargs printf -- '-p %s\n' \
+ | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+```
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
new file mode 100644
index 0000000000..a17a823cf5
--- /dev/null
+++ b/rust/hw/char/pl011/meson.build
@@ -0,0 +1,28 @@
+if not config_host_data.get('CONFIG_HAVE_RUST')
+  subdir_done()
+endif
+
+add_languages('rust', required: true)
+
+
+arbitrary_int_dep = subproject('arbitrary-int').get_variable('arbitrary_int_dep')
+bilge_dep = subproject('bilge').get_variable('bilge_dep')
+bilge_impl_dep = subproject('bilge-impl').get_variable('bilge_impl_dep')
+
+_libpl011_rs = static_library(
+  'pl011',
+  files('src/lib.rs'),
+  rust_abi: 'c',
+  rust_args: rust_args + [
+    '--edition', '2021',
+  ],
+  dependencies: [
+    bilge_dep,
+    bilge_impl_dep,
+    qemu_api,
+  ],
+)
+
+specific_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
+  link_whole: [_libpl011_rs],
+)])
diff --git a/rust/hw/char/pl011/rustfmt.toml b/rust/hw/char/pl011/rustfmt.toml
new file mode 120000
index 0000000000..39f97b043b
--- /dev/null
+++ b/rust/hw/char/pl011/rustfmt.toml
@@ -0,0 +1 @@
+../rustfmt.toml
\ No newline at end of file
diff --git a/rust/hw/char/pl011/src/definitions.rs b/rust/hw/char/pl011/src/definitions.rs
new file mode 100644
index 0000000000..66070559d4
--- /dev/null
+++ b/rust/hw/char/pl011/src/definitions.rs
@@ -0,0 +1,26 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+//! Definitions required by QEMU when registering the device.
+
+use core::mem::MaybeUninit;
+
+use qemu_api::bindings::*;
+
+use crate::device::PL011State;
+use qemu_api::definitions::ObjectImpl;
+
+pub const TYPE_PL011: &std::ffi::CStr = c"pl011";
+
+#[used]
+pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
+    name: PL011State::TYPE_INFO.name,
+    unmigratable: true,
+    ..unsafe { MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
+};
+
+qemu_api::module_init! {
+    qom: register_type => {
+        type_register_static(&PL011State::TYPE_INFO);
+    }
+}
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
new file mode 100644
index 0000000000..150787f70c
--- /dev/null
+++ b/rust/hw/char/pl011/src/device.rs
@@ -0,0 +1,586 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use crate::{
+    memory_ops::PL011_OPS,
+    registers::{self, Interrupt},
+    RegisterOffset,
+};
+use core::{
+    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
+    ptr::{addr_of, addr_of_mut, NonNull},
+};
+use qemu_api::bindings::{self, *};
+use qemu_api::definitions::ObjectImpl;
+
+static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
+
+const DATA_BREAK: u32 = 1 << 10;
+
+/// QEMU sourced constant.
+pub const PL011_FIFO_DEPTH: usize = 16_usize;
+
+#[repr(C)]
+#[derive(Debug)]
+/// PL011 Device Model in QEMU
+pub struct PL011State {
+    pub parent_obj: SysBusDevice,
+    pub iomem: MemoryRegion,
+    pub readbuff: u32,
+    #[doc(alias = "fr")]
+    pub flags: registers::Flags,
+    #[doc(alias = "lcr")]
+    pub line_control: registers::LineControl,
+    #[doc(alias = "rsr")]
+    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
+    #[doc(alias = "cr")]
+    pub control: registers::Control,
+    pub dmacr: u32,
+    pub int_enabled: u32,
+    pub int_level: u32,
+    pub read_fifo: [u32; PL011_FIFO_DEPTH],
+    pub ilpr: u32,
+    pub ibrd: u32,
+    pub fbrd: u32,
+    pub ifl: u32,
+    pub read_pos: usize,
+    pub read_count: usize,
+    pub read_trigger: usize,
+    #[doc(alias = "chr")]
+    pub char_backend: CharBackend,
+    /// QEMU interrupts
+    ///
+    /// ```text
+    ///  * sysbus MMIO region 0: device registers
+    ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
+    ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
+    ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
+    ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
+    ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
+    ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
+    /// ```
+    #[doc(alias = "irq")]
+    pub interrupts: [qemu_irq; 6usize],
+    #[doc(alias = "clk")]
+    pub clock: NonNull<Clock>,
+    #[doc(alias = "migrate_clk")]
+    pub migrate_clock: bool,
+}
+
+impl ObjectImpl for PL011State {
+    type Class = PL011Class;
+    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { PL011State };
+    const TYPE_NAME: &'static CStr = c"pl011";
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
+    const ABSTRACT: bool = false;
+    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
+    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+}
+
+#[repr(C)]
+pub struct PL011Class {
+    _inner: [u8; 0],
+}
+
+impl qemu_api::definitions::Class for PL011Class {
+    const CLASS_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+    > = Some(crate::device_class::pl011_class_init);
+    const CLASS_BASE_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+    > = None;
+}
+
+#[used]
+pub static CLK_NAME: &CStr = c"clk";
+
+impl PL011State {
+    pub fn init(&mut self) {
+        let dev = addr_of_mut!(*self).cast::<DeviceState>();
+        // SAFETY:
+        //
+        // self and self.iomem are guaranteed to be valid at this point since callers
+        // must make sure the `self` reference is valid.
+        unsafe {
+            memory_region_init_io(
+                addr_of_mut!(self.iomem),
+                addr_of_mut!(*self).cast::<Object>(),
+                &PL011_OPS,
+                addr_of_mut!(*self).cast::<c_void>(),
+                Self::TYPE_INFO.name,
+                0x1000,
+            );
+            let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
+            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
+            for irq in self.interrupts.iter_mut() {
+                sysbus_init_irq(sbd, irq);
+            }
+        }
+        // SAFETY:
+        //
+        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy, we can
+        // overwrite the undefined value without side effects. This is safe since all PL011State
+        // instances are created by QOM code which calls this function to initialize the fields;
+        // therefore no code is able to access an invalid self.clock value.
+        unsafe {
+            self.clock = NonNull::new(qdev_init_clock_in(
+                dev,
+                CLK_NAME.as_ptr(),
+                None, /* pl011_clock_update */
+                addr_of_mut!(*self).cast::<c_void>(),
+                ClockEvent_ClockUpdate,
+            ))
+            .unwrap();
+        }
+    }
+
+    pub fn read(
+        &mut self,
+        offset: hwaddr,
+        _size: core::ffi::c_uint,
+    ) -> std::ops::ControlFlow<u64, u64> {
+        use RegisterOffset::*;
+
+        std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
+            Err(v) if (0x3f8..0x400).contains(&v) => {
+                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
+            }
+            Err(_) => {
+                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                0
+            }
+            Ok(DR) => {
+                // s->flags &= ~PL011_FLAG_RXFF;
+                self.flags.set_receive_fifo_full(false);
+                let c = self.read_fifo[self.read_pos];
+                if self.read_count > 0 {
+                    self.read_count -= 1;
+                    self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
+                }
+                if self.read_count == 0 {
+                    // self.flags |= PL011_FLAG_RXFE;
+                    self.flags.set_receive_fifo_empty(true);
+                }
+                if self.read_count + 1 == self.read_trigger {
+                    //self.int_level &= ~ INT_RX;
+                    self.int_level &= !registers::INT_RX;
+                }
+                // Update error bits.
+                self.receive_status_error_clear = c.to_be_bytes()[3].into();
+                self.update();
+                // Must call qemu_chr_fe_accept_input, so return Continue:
+                return std::ops::ControlFlow::Continue(c.into());
+            }
+            Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
+            Ok(FR) => u16::from(self.flags).into(),
+            Ok(FBRD) => self.fbrd.into(),
+            Ok(ILPR) => self.ilpr.into(),
+            Ok(IBRD) => self.ibrd.into(),
+            Ok(LCR_H) => u16::from(self.line_control).into(),
+            Ok(CR) => {
+                // We exercise our self-control.
+                u16::from(self.control).into()
+            }
+            Ok(FLS) => self.ifl.into(),
+            Ok(IMSC) => self.int_enabled.into(),
+            Ok(RIS) => self.int_level.into(),
+            Ok(MIS) => u64::from(self.int_level & self.int_enabled),
+            Ok(ICR) => {
+                // "The UARTICR Register is the interrupt clear register and is write-only"
+                // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
+                0
+            }
+            Ok(DMACR) => self.dmacr.into(),
+        })
+    }
+
+    pub fn write(&mut self, offset: hwaddr, value: u64) {
+        // eprintln!("write offset {offset} value {value}");
+        use RegisterOffset::*;
+        let value: u32 = value as u32;
+        match RegisterOffset::try_from(offset) {
+            Err(_bad_offset) => {
+                eprintln!("write bad offset {offset} value {value}");
+            }
+            Ok(DR) => {
+                // ??? Check if transmitter is enabled.
+                let ch: u8 = value as u8;
+                // XXX this blocks entire thread. Rewrite to use
+                // qemu_chr_fe_write and background I/O callbacks
+
+                // SAFETY: self.char_backend is a valid CharBackend instance after it's been
+                // initialized in realize().
+                unsafe {
+                    qemu_chr_fe_write_all(addr_of_mut!(self.char_backend), &ch, 1);
+                }
+                self.loopback_tx(value);
+                self.int_level |= registers::INT_TX;
+                self.update();
+            }
+            Ok(RSR) => {
+                self.receive_status_error_clear = 0.into();
+            }
+            Ok(FR) => {
+                // flag writes are ignored
+            }
+            Ok(ILPR) => {
+                self.ilpr = value;
+            }
+            Ok(IBRD) => {
+                self.ibrd = value;
+            }
+            Ok(FBRD) => {
+                self.fbrd = value;
+            }
+            Ok(LCR_H) => {
+                let value = value as u16;
+                let new_val: registers::LineControl = value.into();
+                // Reset the FIFO state on FIFO enable or disable
+                if bool::from(self.line_control.fifos_enabled())
+                    ^ bool::from(new_val.fifos_enabled())
+                {
+                    self.reset_fifo();
+                }
+                if self.line_control.send_break() ^ new_val.send_break() {
+                    let mut break_enable: c_int = new_val.send_break().into();
+                    // SAFETY: self.char_backend is a valid CharBackend instance after it's been
+                    // initialized in realize().
+                    unsafe {
+                        qemu_chr_fe_ioctl(
+                            addr_of_mut!(self.char_backend),
+                            CHR_IOCTL_SERIAL_SET_BREAK as i32,
+                            addr_of_mut!(break_enable).cast::<c_void>(),
+                        );
+                    }
+                    self.loopback_break(break_enable > 0);
+                }
+                self.line_control = new_val;
+                self.set_read_trigger();
+            }
+            Ok(CR) => {
+                // ??? Need to implement the enable bit.
+                let value = value as u16;
+                self.control = value.into();
+                self.loopback_mdmctrl();
+            }
+            Ok(FLS) => {
+                self.ifl = value;
+                self.set_read_trigger();
+            }
+            Ok(IMSC) => {
+                self.int_enabled = value;
+                self.update();
+            }
+            Ok(RIS) => {}
+            Ok(MIS) => {}
+            Ok(ICR) => {
+                self.int_level &= !value;
+                self.update();
+            }
+            Ok(DMACR) => {
+                self.dmacr = value;
+                if value & 3 > 0 {
+                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
+                    eprintln!("pl011: DMA not implemented");
+                }
+            }
+        }
+    }
+
+    #[inline]
+    fn loopback_tx(&mut self, value: u32) {
+        if !self.loopback_enabled() {
+            return;
+        }
+
+        // Caveat:
+        //
+        // In real hardware, TX loopback happens at the serial-bit level
+        // and then reassembled by the RX logics back into bytes and placed
+        // into the RX fifo. That is, loopback happens after TX fifo.
+        //
+        // Because the real hardware TX fifo is time-drained at the frame
+        // rate governed by the configured serial format, some loopback
+        // bytes in TX fifo may still be able to get into the RX fifo
+        // that could be full at times while being drained at software
+        // pace.
+        //
+        // In such scenario, the RX draining pace is the major factor
+        // deciding which loopback bytes get into the RX fifo, unless
+        // hardware flow-control is enabled.
+        //
+        // For simplicity, the above described is not emulated.
+        self.put_fifo(value);
+    }
+
+    fn loopback_mdmctrl(&mut self) {
+        if !self.loopback_enabled() {
+            return;
+        }
+
+        /*
+         * Loopback software-driven modem control outputs to modem status inputs:
+         *   FR.RI  <= CR.Out2
+         *   FR.DCD <= CR.Out1
+         *   FR.CTS <= CR.RTS
+         *   FR.DSR <= CR.DTR
+         *
+         * The loopback happens immediately even if this call is triggered
+         * by setting only CR.LBE.
+         *
+         * CTS/RTS updates due to enabled hardware flow controls are not
+         * dealt with here.
+         */
+
+        //fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
+        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
+        //fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
+        //fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
+        //fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
+        //fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
+        //
+        self.flags.set_ring_indicator(self.control.out_2());
+        self.flags.set_data_carrier_detect(self.control.out_1());
+        self.flags.set_clear_to_send(self.control.request_to_send());
+        self.flags
+            .set_data_set_ready(self.control.data_transmit_ready());
+
+        // Change interrupts based on updated FR
+        let mut il = self.int_level;
+
+        il &= !Interrupt::MS;
+        //il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
+        //il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
+        //il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
+        //il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
+
+        if self.flags.data_set_ready() {
+            il |= Interrupt::DSR as u32;
+        }
+        if self.flags.data_carrier_detect() {
+            il |= Interrupt::DCD as u32;
+        }
+        if self.flags.clear_to_send() {
+            il |= Interrupt::CTS as u32;
+        }
+        if self.flags.ring_indicator() {
+            il |= Interrupt::RI as u32;
+        }
+        self.int_level = il;
+        self.update();
+    }
+
+    fn loopback_break(&mut self, enable: bool) {
+        if enable {
+            self.loopback_tx(DATA_BREAK);
+        }
+    }
+
+    fn set_read_trigger(&mut self) {
+        //#if 0
+        //    /* The docs say the RX interrupt is triggered when the FIFO exceeds
+        //       the threshold.  However linux only reads the FIFO in response to an
+        //       interrupt.  Triggering the interrupt when the FIFO is non-empty seems
+        //       to make things work.  */
+        //    if (s->lcr & LCR_FEN)
+        //        s->read_trigger = (s->ifl >> 1) & 0x1c;
+        //    else
+        //#endif
+        self.read_trigger = 1;
+    }
+
+    pub fn realize(&mut self) {
+        // SAFETY: self.char_backend has the correct size and alignment for a
+        // CharBackend object, and its callbacks are of the correct types.
+        unsafe {
+            qemu_chr_fe_set_handlers(
+                addr_of_mut!(self.char_backend),
+                Some(pl011_can_receive),
+                Some(pl011_receive),
+                Some(pl011_event),
+                None,
+                addr_of_mut!(*self).cast::<c_void>(),
+                core::ptr::null_mut(),
+                true,
+            );
+        }
+    }
+
+    pub fn reset(&mut self) {
+        self.line_control.reset();
+        self.receive_status_error_clear.reset();
+        self.dmacr = 0;
+        self.int_enabled = 0;
+        self.int_level = 0;
+        self.ilpr = 0;
+        self.ibrd = 0;
+        self.fbrd = 0;
+        self.read_trigger = 1;
+        self.ifl = 0x12;
+        self.control.reset();
+        self.flags = 0.into();
+        self.reset_fifo();
+    }
+
+    pub fn reset_fifo(&mut self) {
+        self.read_count = 0;
+        self.read_pos = 0;
+
+        /* Reset FIFO flags */
+        self.flags.reset();
+    }
+
+    pub fn can_receive(&self) -> bool {
+        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+        self.read_count < self.fifo_depth()
+    }
+
+    pub fn event(&mut self, event: QEMUChrEvent) {
+        if event == bindings::QEMUChrEvent_CHR_EVENT_BREAK && !self.fifo_enabled() {
+            self.put_fifo(DATA_BREAK);
+            self.receive_status_error_clear.set_break_error(true);
+        }
+    }
+
+    #[inline]
+    pub fn fifo_enabled(&self) -> bool {
+        matches!(self.line_control.fifos_enabled(), registers::Mode::FIFO)
+    }
+
+    #[inline]
+    pub fn loopback_enabled(&self) -> bool {
+        self.control.enable_loopback()
+    }
+
+    #[inline]
+    pub fn fifo_depth(&self) -> usize {
+        // Note: FIFO depth is expected to be power-of-2
+        if self.fifo_enabled() {
+            return PL011_FIFO_DEPTH;
+        }
+        1
+    }
+
+    pub fn put_fifo(&mut self, value: c_uint) {
+        let depth = self.fifo_depth();
+        assert!(depth > 0);
+        let slot = (self.read_pos + self.read_count) & (depth - 1);
+        self.read_fifo[slot] = value;
+        self.read_count += 1;
+        // s->flags &= ~PL011_FLAG_RXFE;
+        self.flags.set_receive_fifo_empty(false);
+        if self.read_count == depth {
+            //s->flags |= PL011_FLAG_RXFF;
+            self.flags.set_receive_fifo_full(true);
+        }
+
+        if self.read_count == self.read_trigger {
+            self.int_level |= registers::INT_RX;
+            self.update();
+        }
+    }
+
+    pub fn update(&mut self) {
+        let flags = self.int_level & self.int_enabled;
+        for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
+            // SAFETY: self.interrupts have been initialized in init().
+            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
+        }
+    }
+}
+
+/// Which bits in the interrupt status matter for each outbound IRQ line ?
+pub const IRQMASK: [u32; 6] = [
+    /* combined IRQ */
+    Interrupt::E
+        | Interrupt::MS
+        | Interrupt::RT as u32
+        | Interrupt::TX as u32
+        | Interrupt::RX as u32,
+    Interrupt::RX as u32,
+    Interrupt::TX as u32,
+    Interrupt::RT as u32,
+    Interrupt::MS,
+    Interrupt::E,
+];
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011State`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
+    assert!(!opaque.is_null());
+    let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_ref().can_receive().into()
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011State`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+///
+/// The buffer and size arguments must also be valid.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_receive(
+    opaque: *mut core::ffi::c_void,
+    buf: *const u8,
+    size: core::ffi::c_int,
+) {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    if state.as_ref().loopback_enabled() {
+        return;
+    }
+    if size > 0 {
+        assert!(!buf.is_null());
+        state.as_mut().put_fifo(*buf.cast::<c_uint>())
+    }
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011State`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_mut().event(event)
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer for `chr`.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_create(
+    addr: u64,
+    irq: qemu_irq,
+    chr: *mut Chardev,
+) -> *mut DeviceState {
+    let dev: *mut DeviceState = unsafe { qdev_new(PL011State::TYPE_INFO.name) };
+    assert!(!dev.is_null());
+    let sysbus: *mut SysBusDevice = dev as *mut SysBusDevice;
+
+    qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
+    sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
+    sysbus_mmio_map(sysbus, 0, addr);
+    sysbus_connect_irq(sysbus, 0, irq);
+    dev
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011State`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
+    assert!(!obj.is_null());
+    let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
+    state.as_mut().init();
+}
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
new file mode 100644
index 0000000000..6b99239133
--- /dev/null
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -0,0 +1,58 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use core::ptr::NonNull;
+
+use qemu_api::bindings::*;
+
+use crate::{definitions::VMSTATE_PL011, device::PL011State};
+
+qemu_api::declare_properties! {
+    PL011_PROPERTIES,
+    qemu_api::define_property!(
+        c"chardev",
+        PL011State,
+        char_backend,
+        unsafe { &qdev_prop_chr },
+        CharBackend
+    ),
+    qemu_api::define_property!(
+        c"migrate-clk",
+        PL011State,
+        migrate_clock,
+        unsafe { &qdev_prop_bool },
+        bool
+    ),
+}
+
+qemu_api::device_class_init! {
+    pl011_class_init,
+    props => PL011_PROPERTIES,
+    realize_fn => Some(pl011_realize),
+    reset_fn => Some(pl011_reset),
+    vmsd => VMSTATE_PL011,
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011State`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mut *mut Error) {
+    assert!(!dev.is_null());
+    let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
+    state.as_mut().realize();
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that has
+/// the same size as [`PL011State`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+#[no_mangle]
+pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
+    assert!(!dev.is_null());
+    let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
+    state.as_mut().reset();
+}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
new file mode 100644
index 0000000000..697d2ef5a6
--- /dev/null
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -0,0 +1,584 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+//
+// PL011 QEMU Device Model
+//
+// This library implements a device model for the PrimeCell® UART (PL011)
+// device in QEMU.
+//
+#![doc = include_str!("../README.md")]
+//! # Library crate
+//!
+//! See [`PL011State`](crate::device::PL011State) for the device model type and
+//! the [`registers`] module for register types.
+
+#![deny(
+    rustdoc::broken_intra_doc_links,
+    rustdoc::redundant_explicit_links,
+    clippy::correctness,
+    clippy::suspicious,
+    clippy::complexity,
+    clippy::perf,
+    clippy::cargo,
+    clippy::nursery,
+    clippy::style,
+    // restriction group
+    clippy::dbg_macro,
+    clippy::as_underscore,
+    clippy::assertions_on_result_states,
+    // pedantic group
+    clippy::doc_markdown,
+    clippy::borrow_as_ptr,
+    clippy::cast_lossless,
+    clippy::option_if_let_else,
+    clippy::missing_const_for_fn,
+    clippy::cognitive_complexity,
+    clippy::missing_safety_doc,
+    )]
+
+extern crate bilge;
+extern crate bilge_impl;
+extern crate qemu_api;
+
+pub mod definitions;
+pub mod device;
+pub mod device_class;
+pub mod memory_ops;
+
+/// Offset of each register from the base memory address of the device.
+///
+/// # Source
+/// ARM DDI 0183G, Table 3-1 p.3-3
+#[doc(alias = "offset")]
+#[allow(non_camel_case_types)]
+#[repr(u64)]
+#[derive(Debug)]
+pub enum RegisterOffset {
+    /// Data Register
+    ///
+    /// A write to this register initiates the actual data transmission
+    #[doc(alias = "UARTDR")]
+    DR = 0x000,
+    /// Receive Status Register or Error Clear Register
+    #[doc(alias = "UARTRSR")]
+    #[doc(alias = "UARTECR")]
+    RSR = 0x004,
+    /// Flag Register
+    ///
+    /// A read of this register shows if transmission is complete
+    #[doc(alias = "UARTFR")]
+    FR = 0x018,
+    /// Fractional Baud Rate Register
+    ///
+    /// responsible for baud rate speed
+    #[doc(alias = "UARTFBRD")]
+    FBRD = 0x028,
+    /// `IrDA` Low-Power Counter Register
+    #[doc(alias = "UARTILPR")]
+    ILPR = 0x020,
+    /// Integer Baud Rate Register
+    ///
+    /// Responsible for baud rate speed
+    #[doc(alias = "UARTIBRD")]
+    IBRD = 0x024,
+    /// line control register (data frame format)
+    #[doc(alias = "UARTLCR_H")]
+    LCR_H = 0x02C,
+    /// Toggle UART, transmission or reception
+    #[doc(alias = "UARTCR")]
+    CR = 0x030,
+    /// Interrupt FIFO Level Select Register
+    #[doc(alias = "UARTIFLS")]
+    FLS = 0x034,
+    /// Interrupt Mask Set/Clear Register
+    #[doc(alias = "UARTIMSC")]
+    IMSC = 0x038,
+    /// Raw Interrupt Status Register
+    #[doc(alias = "UARTRIS")]
+    RIS = 0x03C,
+    /// Masked Interrupt Status Register
+    #[doc(alias = "UARTMIS")]
+    MIS = 0x040,
+    /// Interrupt Clear Register
+    #[doc(alias = "UARTICR")]
+    ICR = 0x044,
+    /// DMA control Register
+    #[doc(alias = "UARTDMACR")]
+    DMACR = 0x048,
+    ///// Reserved, offsets `0x04C` to `0x07C`.
+    //Reserved = 0x04C,
+}
+
+impl core::convert::TryFrom<u64> for RegisterOffset {
+    type Error = u64;
+
+    fn try_from(value: u64) -> Result<Self, Self::Error> {
+        macro_rules! case {
+            ($($discriminant:ident),*$(,)*) => {
+                /* check that matching on all macro arguments compiles, which means we are not
+                 * missing any enum value; if the type definition ever changes this will stop
+                 * compiling.
+                 */
+                const fn _assert_exhaustive(val: RegisterOffset) {
+                    match val {
+                        $(RegisterOffset::$discriminant => (),)*
+                    }
+                }
+
+                match value {
+                    $(x if x == Self::$discriminant as u64 => Ok(Self::$discriminant),)*
+                     _ => Err(value),
+                }
+            }
+        }
+        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR }
+    }
+}
+
+pub mod registers {
+    //! Device registers exposed as typed structs which are backed by arbitrary
+    //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
+    //!
+    //! All PL011 registers are essentially 32-bit wide, but are typed here as
+    //! bitmaps with only the necessary width. That is, if a struct bitmap
+    //! in this module is for example 16 bits long, it should be conceived
+    //! as a 32-bit register where the unmentioned higher bits are always
+    //! unused thus treated as zero when read or written.
+    use bilge::prelude::*;
+
+    // TODO: FIFO Mode has different semantics
+    /// Data Register, `UARTDR`
+    ///
+    /// The `UARTDR` register is the data register.
+    ///
+    /// For words to be transmitted:
+    ///
+    /// - if the FIFOs are enabled, data written to this location is pushed onto
+    ///   the transmit
+    /// FIFO
+    /// - if the FIFOs are not enabled, data is stored in the transmitter
+    ///   holding register (the
+    /// bottom word of the transmit FIFO).
+    ///
+    /// The write operation initiates transmission from the UART. The data is
+    /// prefixed with a start bit, appended with the appropriate parity bit
+    /// (if parity is enabled), and a stop bit. The resultant word is then
+    /// transmitted.
+    ///
+    /// For received words:
+    ///
+    /// - if the FIFOs are enabled, the data byte and the 4-bit status (break,
+    ///   frame, parity,
+    /// and overrun) is pushed onto the 12-bit wide receive FIFO
+    /// - if the FIFOs are not enabled, the data byte and status are stored in
+    ///   the receiving
+    /// holding register (the bottom word of the receive FIFO).
+    ///
+    /// The received data byte is read by performing reads from the `UARTDR`
+    /// register along with the corresponding status information. The status
+    /// information can also be read by a read of the `UARTRSR/UARTECR`
+    /// register.
+    ///
+    /// # Note
+    ///
+    /// You must disable the UART before any of the control registers are
+    /// reprogrammed. When the UART is disabled in the middle of
+    /// transmission or reception, it completes the current character before
+    /// stopping.
+    ///
+    /// # Source
+    /// ARM DDI 0183G 3.3.1 Data Register, UARTDR
+    #[bitsize(16)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    #[doc(alias = "UARTDR")]
+    pub struct Data {
+        _reserved: u4,
+        pub data: u8,
+        pub framing_error: bool,
+        pub parity_error: bool,
+        pub break_error: bool,
+        pub overrun_error: bool,
+    }
+
+    // TODO: FIFO Mode has different semantics
+    /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
+    ///
+    /// The UARTRSR/UARTECR register is the receive status register/error clear
+    /// register. Receive status can also be read from the `UARTRSR`
+    /// register. If the status is read from this register, then the status
+    /// information for break, framing and parity corresponds to the
+    /// data character read from the [Data register](Data), `UARTDR` prior to
+    /// reading the UARTRSR register. The status information for overrun is
+    /// set immediately when an overrun condition occurs.
+    ///
+    ///
+    /// # Note
+    /// The received data character must be read first from the [Data
+    /// Register](Data), `UARTDR` before reading the error status associated
+    /// with that data character from the `UARTRSR` register. This read
+    /// sequence cannot be reversed, because the `UARTRSR` register is
+    /// updated only when a read occurs from the `UARTDR` register. However,
+    /// the status information can also be obtained by reading the `UARTDR`
+    /// register
+    ///
+    /// # Source
+    /// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register,
+    /// UARTRSR/UARTECR
+    #[bitsize(8)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    pub struct ReceiveStatusErrorClear {
+        pub framing_error: bool,
+        pub parity_error: bool,
+        pub break_error: bool,
+        pub overrun_error: bool,
+        _reserved_unpredictable: u4,
+    }
+
+    impl ReceiveStatusErrorClear {
+        pub fn reset(&mut self) {
+            // All the bits are cleared to 0 on reset.
+            *self = 0.into();
+        }
+    }
+
+    impl Default for ReceiveStatusErrorClear {
+        fn default() -> Self {
+            0.into()
+        }
+    }
+
+    #[bitsize(16)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    /// Flag Register, `UARTFR`
+    #[doc(alias = "UARTFR")]
+    pub struct Flags {
+        /// CTS Clear to send. This bit is the complement of the UART clear to
+        /// send, `nUARTCTS`, modem status input. That is, the bit is 1
+        /// when `nUARTCTS` is LOW.
+        pub clear_to_send: bool,
+        /// DSR Data set ready. This bit is the complement of the UART data set
+        /// ready, `nUARTDSR`, modem status input. That is, the bit is 1 when
+        /// `nUARTDSR` is LOW.
+        pub data_set_ready: bool,
+        /// DCD Data carrier detect. This bit is the complement of the UART data
+        /// carrier detect, `nUARTDCD`, modem status input. That is, the bit is
+        /// 1 when `nUARTDCD` is LOW.
+        pub data_carrier_detect: bool,
+        /// BUSY UART busy. If this bit is set to 1, the UART is busy
+        /// transmitting data. This bit remains set until the complete
+        /// byte, including all the stop bits, has been sent from the
+        /// shift register. This bit is set as soon as the transmit FIFO
+        /// becomes non-empty, regardless of whether the UART is enabled
+        /// or not.
+        pub busy: bool,
+        /// RXFE Receive FIFO empty. The meaning of this bit depends on the
+        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
+        /// is disabled, this bit is set when the receive holding
+        /// register is empty. If the FIFO is enabled, the RXFE bit is
+        /// set when the receive FIFO is empty.
+        pub receive_fifo_empty: bool,
+        /// TXFF Transmit FIFO full. The meaning of this bit depends on the
+        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
+        /// is disabled, this bit is set when the transmit holding
+        /// register is full. If the FIFO is enabled, the TXFF bit is
+        /// set when the transmit FIFO is full.
+        pub transmit_fifo_full: bool,
+        /// RXFF Receive FIFO full. The meaning of this bit depends on the state
+        /// of the FEN bit in the UARTLCR_H register. If the FIFO is
+        /// disabled, this bit is set when the receive holding register
+        /// is full. If the FIFO is enabled, the RXFF bit is set when
+        /// the receive FIFO is full.
+        pub receive_fifo_full: bool,
+        /// Transmit FIFO empty. The meaning of this bit depends on the state of
+        /// the FEN bit in the [Line Control register](LineControl),
+        /// `UARTLCR_H`. If the FIFO is disabled, this bit is set when the
+        /// transmit holding register is empty. If the FIFO is enabled,
+        /// the TXFE bit is set when the transmit FIFO is empty. This
+        /// bit does not indicate if there is data in the transmit shift
+        /// register.
+        pub transmit_fifo_empty: bool,
+        /// `RI`, is `true` when `nUARTRI` is `LOW`.
+        pub ring_indicator: bool,
+        _reserved_zero_no_modify: u7,
+    }
+
+    impl Flags {
+        pub fn reset(&mut self) {
+            // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are 1
+            self.set_receive_fifo_full(false);
+            self.set_transmit_fifo_full(false);
+            self.set_busy(false);
+            self.set_receive_fifo_empty(true);
+            self.set_transmit_fifo_empty(true);
+        }
+    }
+
+    impl Default for Flags {
+        fn default() -> Self {
+            let mut ret: Self = 0.into();
+            ret.reset();
+            ret
+        }
+    }
+
+    #[bitsize(16)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    /// Line Control Register, `UARTLCR_H`
+    #[doc(alias = "UARTLCR_H")]
+    pub struct LineControl {
+        /// 15:8 - Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify: u8,
+        /// 7 SPS Stick parity select.
+        /// 0 = stick parity is disabled
+        /// 1 = either:
+        /// • if the EPS bit is 0 then the parity bit is transmitted and checked
+        /// as a 1 • if the EPS bit is 1 then the parity bit is
+        /// transmitted and checked as a 0. This bit has no effect when
+        /// the PEN bit disables parity checking and generation. See Table 3-11
+        /// on page 3-14 for the parity truth table.
+        pub sticky_parity: bool,
+        /// WLEN Word length. These bits indicate the number of data bits
+        /// transmitted or received in a frame as follows: b11 = 8 bits
+        /// b10 = 7 bits
+        /// b01 = 6 bits
+        /// b00 = 5 bits.
+        pub word_length: WordLength,
+        /// FEN Enable FIFOs:
+        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
+        /// 1-byte-deep holding registers 1 = transmit and receive FIFO
+        /// buffers are enabled (FIFO mode).
+        pub fifos_enabled: Mode,
+        /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
+        /// are transmitted at the end of the frame. The receive
+        /// logic does not check for two stop bits being received.
+        pub two_stops_bits: bool,
+        /// EPS Even parity select. Controls the type of parity the UART uses
+        /// during transmission and reception:
+        /// - 0 = odd parity. The UART generates or checks for an odd number of
+        ///   1s in the data and parity bits.
+        /// - 1 = even parity. The UART generates or checks for an even number
+        ///   of 1s in the data and parity bits.
+        /// This bit has no effect when the `PEN` bit disables parity checking
+        /// and generation. See Table 3-11 on page 3-14 for the parity
+        /// truth table.
+        pub parity: Parity,
+        /// 1 PEN Parity enable:
+        ///
+        /// - 0 = parity is disabled and no parity bit added to the data frame
+        /// - 1 = parity checking and generation is enabled.
+        ///
+        /// See Table 3-11 on page 3-14 for the parity truth table.
+        pub parity_enabled: bool,
+        /// BRK Send break.
+        ///
+        /// If this bit is set to `1`, a low-level is continually output on the
+        /// `UARTTXD` output, after completing transmission of the
+        /// current character. For the proper execution of the break command,
+        /// the software must set this bit for at least two complete
+        /// frames. For normal use, this bit must be cleared to `0`.
+        pub send_break: bool,
+    }
+
+    impl LineControl {
+        pub fn reset(&mut self) {
+            // All the bits are cleared to 0 when reset.
+            *self = 0.into();
+        }
+    }
+
+    impl Default for LineControl {
+        fn default() -> Self {
+            0.into()
+        }
+    }
+
+    #[bitsize(1)]
+    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+    /// `EPS` "Even parity select", field of [Line Control
+    /// register](LineControl).
+    pub enum Parity {
+        /// - 0 = odd parity. The UART generates or checks for an odd number of
+        ///   1s in the data and parity bits.
+        Odd = 0,
+        /// - 1 = even parity. The UART generates or checks for an even number
+        ///   of 1s in the data and parity bits.
+        Even = 1,
+    }
+
+    #[bitsize(1)]
+    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+    /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
+    /// register](LineControl).
+    pub enum Mode {
+        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
+        /// 1-byte-deep holding registers
+        Character = 0,
+        /// 1 = transmit and receive FIFO buffers are enabled (FIFO mode).
+        FIFO = 1,
+    }
+
+    impl From<Mode> for bool {
+        fn from(val: Mode) -> Self {
+            matches!(val, Mode::FIFO)
+        }
+    }
+
+    #[bitsize(2)]
+    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+    /// `WLEN` Word length, field of [Line Control register](LineControl).
+    ///
+    /// These bits indicate the number of data bits transmitted or received in a
+    /// frame as follows:
+    pub enum WordLength {
+        /// b11 = 8 bits
+        _8Bits = 0b11,
+        /// b10 = 7 bits
+        _7Bits = 0b10,
+        /// b01 = 6 bits
+        _6Bits = 0b01,
+        /// b00 = 5 bits.
+        _5Bits = 0b00,
+    }
+
+    /// Control Register, `UARTCR`
+    ///
+    /// The `UARTCR` register is the control register. All the bits are cleared
+    /// to `0` on reset except for bits `9` and `8` that are set to `1`.
+    ///
+    /// # Source
+    /// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
+    #[bitsize(16)]
+    #[doc(alias = "UARTCR")]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    pub struct Control {
+        /// `UARTEN` UART enable: 0 = UART is disabled. If the UART is disabled
+        /// in the middle of transmission or reception, it completes the current
+        /// character before stopping. 1 = the UART is enabled. Data
+        /// transmission and reception occurs for either UART signals or SIR
+        /// signals depending on the setting of the SIREN bit.
+        pub enable_uart: bool,
+        /// `SIREN` `SIR` enable: 0 = IrDA SIR ENDEC is disabled. `nSIROUT`
+        /// remains LOW (no light pulse generated), and signal transitions on
+        /// SIRIN have no effect. 1 = IrDA SIR ENDEC is enabled. Data is
+        /// transmitted and received on nSIROUT and SIRIN. UARTTXD remains HIGH,
+        /// in the marking state. Signal transitions on UARTRXD or modem status
+        /// inputs have no effect. This bit has no effect if the UARTEN bit
+        /// disables the UART.
+        pub enable_sir: bool,
+        /// `SIRLP` SIR low-power IrDA mode. This bit selects the IrDA encoding
+        /// mode. If this bit is cleared to 0, low-level bits are transmitted as
+        /// an active high pulse with a width of 3/ 16th of the bit period. If
+        /// this bit is set to 1, low-level bits are transmitted with a pulse
+        /// width that is 3 times the period of the IrLPBaud16 input signal,
+        /// regardless of the selected bit rate. Setting this bit uses less
+        /// power, but might reduce transmission distances.
+        pub sir_lowpower_irda_mode: u1,
+        /// Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify: u4,
+        /// `LBE` Loopback enable. If this bit is set to 1 and the SIREN bit is
+        /// set to 1 and the SIRTEST bit in the Test Control register, UARTTCR
+        /// on page 4-5 is set to 1, then the nSIROUT path is inverted, and fed
+        /// through to the SIRIN path. The SIRTEST bit in the test register must
+        /// be set to 1 to override the normal half-duplex SIR operation. This
+        /// must be the requirement for accessing the test registers during
+        /// normal operation, and SIRTEST must be cleared to 0 when loopback
+        /// testing is finished. This feature reduces the amount of external
+        /// coupling required during system test. If this bit is set to 1, and
+        /// the SIRTEST bit is set to 0, the UARTTXD path is fed through to the
+        /// UARTRXD path. In either SIR mode or UART mode, when this bit is set,
+        /// the modem outputs are also fed through to the modem inputs. This bit
+        /// is cleared to 0 on reset, to disable loopback.
+        pub enable_loopback: bool,
+        /// `TXE` Transmit enable. If this bit is set to 1, the transmit section
+        /// of the UART is enabled. Data transmission occurs for either UART
+        /// signals, or SIR signals depending on the setting of the SIREN bit.
+        /// When the UART is disabled in the middle of transmission, it
+        /// completes the current character before stopping.
+        pub enable_transmit: bool,
+        /// `RXE` Receive enable. If this bit is set to 1, the receive section
+        /// of the UART is enabled. Data reception occurs for either UART
+        /// signals or SIR signals depending on the setting of the SIREN bit.
+        /// When the UART is disabled in the middle of reception, it completes
+        /// the current character before stopping.
+        pub enable_receive: bool,
+        /// `DTR` Data transmit ready. This bit is the complement of the UART
+        /// data transmit ready, `nUARTDTR`, modem status output. That is, when
+        /// the bit is programmed to a 1 then `nUARTDTR` is LOW.
+        pub data_transmit_ready: bool,
+        /// `RTS` Request to send. This bit is the complement of the UART
+        /// request to send, `nUARTRTS`, modem status output. That is, when the
+        /// bit is programmed to a 1 then `nUARTRTS` is LOW.
+        pub request_to_send: bool,
+        /// `Out1` This bit is the complement of the UART Out1 (`nUARTOut1`)
+        /// modem status output. That is, when the bit is programmed to a 1 the
+        /// output is 0. For DTE this can be used as Data Carrier Detect (DCD).
+        pub out_1: bool,
+        /// `Out2` This bit is the complement of the UART Out2 (`nUARTOut2`)
+        /// modem status output. That is, when the bit is programmed to a 1, the
+        /// output is 0. For DTE this can be used as Ring Indicator (RI).
+        pub out_2: bool,
+        /// `RTSEn` RTS hardware flow control enable. If this bit is set to 1,
+        /// RTS hardware flow control is enabled. Data is only requested when
+        /// there is space in the receive FIFO for it to be received.
+        pub rts_hardware_flow_control_enable: bool,
+        /// `CTSEn` CTS hardware flow control enable. If this bit is set to 1,
+        /// CTS hardware flow control is enabled. Data is only transmitted when
+        /// the `nUARTCTS` signal is asserted.
+        pub cts_hardware_flow_control_enable: bool,
+    }
+
+    impl Control {
+        pub fn reset(&mut self) {
+            *self = 0.into();
+            self.set_enable_receive(true);
+            self.set_enable_transmit(true);
+        }
+    }
+
+    impl Default for Control {
+        fn default() -> Self {
+            let mut ret: Self = 0.into();
+            ret.reset();
+            ret
+        }
+    }
+
+    /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
+    pub const INT_OE: u32 = 1 << 10;
+    pub const INT_BE: u32 = 1 << 9;
+    pub const INT_PE: u32 = 1 << 8;
+    pub const INT_FE: u32 = 1 << 7;
+    pub const INT_RT: u32 = 1 << 6;
+    pub const INT_TX: u32 = 1 << 5;
+    pub const INT_RX: u32 = 1 << 4;
+    pub const INT_DSR: u32 = 1 << 3;
+    pub const INT_DCD: u32 = 1 << 2;
+    pub const INT_CTS: u32 = 1 << 1;
+    pub const INT_RI: u32 = 1 << 0;
+    pub const INT_E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
+    pub const INT_MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
+
+    #[repr(u32)]
+    pub enum Interrupt {
+        OE = 1 << 10,
+        BE = 1 << 9,
+        PE = 1 << 8,
+        FE = 1 << 7,
+        RT = 1 << 6,
+        TX = 1 << 5,
+        RX = 1 << 4,
+        DSR = 1 << 3,
+        DCD = 1 << 2,
+        CTS = 1 << 1,
+        RI = 1 << 0,
+    }
+
+    impl Interrupt {
+        pub const E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
+        pub const MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
+    }
+}
+
+// TODO: You must disable the UART before any of the control registers are
+// reprogrammed. When the UART is disabled in the middle of transmission or
+// reception, it completes the current character before stopping
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
new file mode 100644
index 0000000000..5e185b7cd7
--- /dev/null
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -0,0 +1,56 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use core::{mem::MaybeUninit, ptr::NonNull};
+
+use qemu_api::bindings::*;
+
+use crate::device::PL011State;
+
+pub static PL011_OPS: MemoryRegionOps = MemoryRegionOps {
+    read: Some(pl011_read),
+    write: Some(pl011_write),
+    read_with_attrs: None,
+    write_with_attrs: None,
+    endianness: device_endian_DEVICE_NATIVE_ENDIAN,
+    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed().assume_init() },
+    impl_: MemoryRegionOps__bindgen_ty_2 {
+        min_access_size: 4,
+        max_access_size: 4,
+        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed().assume_init() }
+    },
+};
+
+#[no_mangle]
+unsafe extern "C" fn pl011_read(
+    opaque: *mut core::ffi::c_void,
+    addr: hwaddr,
+    size: core::ffi::c_uint,
+) -> u64 {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    let val = state.as_mut().read(addr, size);
+    match val {
+        std::ops::ControlFlow::Break(val) => val,
+        std::ops::ControlFlow::Continue(val) => {
+            // SAFETY: self.char_backend is a valid CharBackend instance after it's been
+            // initialized in realize().
+            let cb_ptr = core::ptr::addr_of_mut!(state.as_mut().char_backend);
+            unsafe { qemu_chr_fe_accept_input(cb_ptr) };
+
+            val
+        }
+    }
+}
+
+#[no_mangle]
+unsafe extern "C" fn pl011_write(
+    opaque: *mut core::ffi::c_void,
+    addr: hwaddr,
+    data: u64,
+    _size: core::ffi::c_uint,
+) {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_mut().write(addr, data)
+}
diff --git a/rust/hw/meson.build b/rust/hw/meson.build
new file mode 100644
index 0000000000..860196645e
--- /dev/null
+++ b/rust/hw/meson.build
@@ -0,0 +1 @@
+subdir('char')
diff --git a/rust/meson.build b/rust/meson.build
index a903c7c602..4c858e9d1f 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -11,3 +11,5 @@ _lib_bindings_rs = static_library(
 )
 
 subdir('qemu-api')
+
+subdir('hw')
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index adca0266be..50f173f90d 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,3 +6,14 @@
 /keycodemapdb
 /libvfio-user
 /slirp
+/arbitrary-int-1.2.7
+/bilge-0.2.0
+/bilge-impl-0.2.0
+/either-1.12.0
+/itertools-0.11.0
+/proc-macro-error-1.0.4
+/proc-macro-error-attr-1.0.4
+/proc-macro2-1.0.84
+/quote-1.0.36
+/syn-2.0.66
+/unicode-ident-1.0.12
diff --git a/subprojects/arbitrary-int.wrap b/subprojects/arbitrary-int.wrap
new file mode 100644
index 0000000000..d8535bdc1e
--- /dev/null
+++ b/subprojects/arbitrary-int.wrap
@@ -0,0 +1,9 @@
+[wrap-file]
+directory = arbitrary-int-1.2.7
+source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
+source_filename = arbitrary-int-1.2.7.tar.gz
+source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
+patch_directory = arbitrary-int
+
+[provide]
+dependency_names = arbitrary_int_dep
diff --git a/subprojects/bilge-impl.wrap b/subprojects/bilge-impl.wrap
new file mode 100644
index 0000000000..f0d0c22fc9
--- /dev/null
+++ b/subprojects/bilge-impl.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = bilge-impl-0.2.0
+source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
+source_filename = bilge-impl-0.2.0.tar.gz
+source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
+#method = cargo
+patch_directory = bilge-impl
+
+[provide]
+dependency_names = bilge_impl_dep
diff --git a/subprojects/bilge.wrap b/subprojects/bilge.wrap
new file mode 100644
index 0000000000..a37638e356
--- /dev/null
+++ b/subprojects/bilge.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = bilge-0.2.0
+source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
+source_filename = bilge-0.2.0.tar.gz
+source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
+#method = cargo
+patch_directory = bilge
+
+[provide]
+dependency_names = bilge-0.2.0-rs
diff --git a/subprojects/either.wrap b/subprojects/either.wrap
new file mode 100644
index 0000000000..df2f09a986
--- /dev/null
+++ b/subprojects/either.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = either-1.12.0
+source_url = https://crates.io/api/v1/crates/either/1.12.0/download
+source_filename = either-1.12.0.tar.gz
+source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
+#method = cargo
+patch_directory = either
+
+[provide]
+dependency_names = either_dep
diff --git a/subprojects/itertools.wrap b/subprojects/itertools.wrap
new file mode 100644
index 0000000000..93961e00ab
--- /dev/null
+++ b/subprojects/itertools.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = itertools-0.11.0
+source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
+source_filename = itertools-0.11.0.tar.gz
+source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
+#method = cargo
+patch_directory = itertools
+
+[provide]
+dependency_names = itertools_dep
diff --git a/subprojects/packagefiles/arbitrary-int/meson.build b/subprojects/packagefiles/arbitrary-int/meson.build
new file mode 100644
index 0000000000..6ce8eac79a
--- /dev/null
+++ b/subprojects/packagefiles/arbitrary-int/meson.build
@@ -0,0 +1,19 @@
+project('arbitrary-int', 'rust',
+  version: '1.2.7',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+_arbitrary_int_rs = static_library(
+  'arbitrary_int',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2021',
+  ],
+  dependencies: [],
+)
+
+arbitrary_int_dep = declare_dependency(
+  link_with: _arbitrary_int_rs,
+)
diff --git a/subprojects/packagefiles/bilge-impl/meson.build b/subprojects/packagefiles/bilge-impl/meson.build
new file mode 100644
index 0000000000..6413afaa4d
--- /dev/null
+++ b/subprojects/packagefiles/bilge-impl/meson.build
@@ -0,0 +1,36 @@
+project('bilge-impl', 'rust',
+  version: '0.2.0',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+itertools_dep = subproject('itertools').get_variable('itertools_dep')
+proc_macro_error_attr_dep = subproject('proc-macro-error-attr').get_variable('proc_macro_error_attr_dep')
+proc_macro_error_dep = subproject('proc-macro-error').get_variable('proc_macro_error_dep')
+quote_dep = subproject('quote').get_variable('quote_dep')
+syn_dep = subproject('syn').get_variable('syn_dep')
+proc_macro2_dep = subproject('proc-macro2').get_variable('proc_macro2_dep')
+
+rust = import('rust')
+
+_bilge_impl_rs = rust.proc_macro(
+  'bilge_impl',
+  files('src/lib.rs'),
+  rust_args: [
+    '--edition', '2021',
+    '--cfg', 'use_fallback',
+    '--cfg', 'feature="syn-error"',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    itertools_dep,
+    proc_macro_error_attr_dep,
+    proc_macro_error_dep,
+    quote_dep,
+    syn_dep,
+    proc_macro2_dep,
+  ],
+)
+
+bilge_impl_dep = declare_dependency(
+  link_with: _bilge_impl_rs,
+)
diff --git a/subprojects/packagefiles/bilge/meson.build b/subprojects/packagefiles/bilge/meson.build
new file mode 100644
index 0000000000..05d257da61
--- /dev/null
+++ b/subprojects/packagefiles/bilge/meson.build
@@ -0,0 +1,25 @@
+project(
+  'bilge',
+  'rust',
+  version : '0.2.0',
+  license : 'MIT or Apache-2.0',
+)
+
+arbitrary_int_dep = subproject('arbitrary-int').get_variable('arbitrary_int_dep')
+bilge_impl_dep = subproject('bilge-impl').get_variable('bilge_impl_dep')
+
+lib = static_library(
+  'bilge',
+  'src/lib.rs',
+  override_options : ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi : 'rust',
+  native : true,
+  dependencies: [
+    arbitrary_int_dep,
+    bilge_impl_dep,
+  ],
+)
+
+bilge_dep = declare_dependency(
+  link_with : [lib],
+)
diff --git a/subprojects/packagefiles/either/meson.build b/subprojects/packagefiles/either/meson.build
new file mode 100644
index 0000000000..e6ab0e849b
--- /dev/null
+++ b/subprojects/packagefiles/either/meson.build
@@ -0,0 +1,21 @@
+project('either', 'rust',
+  version: '1.12.0',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+_either_rs = static_library(
+  'either',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2018',
+    '--cfg', 'feature="use_std"',
+    '--cfg', 'feature="use_alloc"',
+  ],
+  dependencies: [],
+)
+
+either_dep = declare_dependency(
+  link_with: _either_rs,
+)
diff --git a/subprojects/packagefiles/itertools/meson.build b/subprojects/packagefiles/itertools/meson.build
new file mode 100644
index 0000000000..d897a615f0
--- /dev/null
+++ b/subprojects/packagefiles/itertools/meson.build
@@ -0,0 +1,25 @@
+project('itertools', 'rust',
+  version: '0.11.0',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+either_dep = subproject('either').get_variable('either_dep')
+
+_itertools_rs = static_library(
+  'itertools',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2018',
+    '--cfg', 'feature="use_std"',
+    '--cfg', 'feature="use_alloc"',
+  ],
+  dependencies: [
+    either_dep,
+  ],
+)
+
+itertools_dep = declare_dependency(
+  link_with: _itertools_rs,
+)
diff --git a/subprojects/packagefiles/proc-macro-error-attr/meson.build b/subprojects/packagefiles/proc-macro-error-attr/meson.build
new file mode 100644
index 0000000000..ed0f05e9e6
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro-error-attr/meson.build
@@ -0,0 +1,27 @@
+project('proc-macro-error-attr', 'rust',
+  version: '1.12.0',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+proc_macro2_dep = subproject('proc-macro2').get_variable('proc_macro2_dep')
+quote_dep = subproject('quote').get_variable('quote_dep')
+
+rust = import('rust')
+_proc_macro_error_attr_rs = rust.proc_macro(
+  'proc_macro_error_attr',
+  files('src/lib.rs'),
+  rust_args: [
+    '--edition', '2018',
+    '--cfg', 'use_fallback',
+    '--cfg', 'feature="syn-error"',
+    '--cfg', 'feature="proc-macro"'
+  ],
+  dependencies: [
+    proc_macro2_dep,
+    quote_dep,
+  ],
+)
+
+proc_macro_error_attr_dep = declare_dependency(
+  link_with: _proc_macro_error_attr_rs,
+)
diff --git a/subprojects/packagefiles/proc-macro-error/meson.build b/subprojects/packagefiles/proc-macro-error/meson.build
new file mode 100644
index 0000000000..4c9e4f70ef
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro-error/meson.build
@@ -0,0 +1,32 @@
+project('proc-macro-error', 'rust',
+  version: '1.0.4',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+proc_macro_error_attr_dep = subproject('proc-macro-error-attr').get_variable('proc_macro_error_attr_dep')
+proc_macro2_dep = subproject('proc-macro2').get_variable('proc_macro2_dep')
+quote_dep = subproject('quote').get_variable('quote_dep')
+syn_dep = subproject('syn').get_variable('syn_dep')
+
+_proc_macro_error_rs = static_library(
+  'proc_macro_error',
+  files('src/lib.rs'),
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2018',
+    '--cfg', 'use_fallback',
+    '--cfg', 'feature="syn-error"',
+    '--cfg', 'feature="proc-macro"',
+    '-A', 'non_fmt_panics'
+  ],
+  dependencies: [
+    proc_macro_error_attr_dep,
+    proc_macro2_dep,
+    quote_dep,
+    syn_dep,
+  ],
+)
+
+proc_macro_error_dep = declare_dependency(
+  link_with: _proc_macro_error_rs,
+)
diff --git a/subprojects/packagefiles/proc-macro2/meson.build b/subprojects/packagefiles/proc-macro2/meson.build
new file mode 100644
index 0000000000..9efb441b7a
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro2/meson.build
@@ -0,0 +1,26 @@
+project('proc-macro2', 'rust',
+  version: '1.0.84',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+unicode_ident_dep = subproject('unicode-ident').get_variable('unicode_ident_dep')
+
+_proc_macro2_rs = static_library(
+  'proc_macro2',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2021',
+    '--cfg', 'feature="proc-macro"',
+    '--cfg', 'span_locations',
+    '--cfg', 'wrap_proc_macro',
+  ],
+  dependencies: [
+    unicode_ident_dep,
+  ],
+)
+
+proc_macro2_dep = declare_dependency(
+  link_with: _proc_macro2_rs,
+)
diff --git a/subprojects/packagefiles/quote/meson.build b/subprojects/packagefiles/quote/meson.build
new file mode 100644
index 0000000000..4570e93b19
--- /dev/null
+++ b/subprojects/packagefiles/quote/meson.build
@@ -0,0 +1,25 @@
+project('quote', 'rust',
+  version: '1.12.0',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+proc_macro2_dep = subproject('proc-macro2').get_variable('proc_macro2_dep')
+
+_quote_rs = static_library(
+  'quote',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2021',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    proc_macro2_dep,
+    ],
+)
+
+quote_dep = declare_dependency(
+  link_with: _quote_rs,
+)
+
diff --git a/subprojects/packagefiles/syn/meson.build b/subprojects/packagefiles/syn/meson.build
new file mode 100644
index 0000000000..104791f5c7
--- /dev/null
+++ b/subprojects/packagefiles/syn/meson.build
@@ -0,0 +1,33 @@
+project('syn', 'rust',
+  version: '2.0.66',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+quote_dep = subproject('quote').get_variable('quote_dep')
+proc_macro2_dep = subproject('proc-macro2').get_variable('proc_macro2_dep')
+unicode_ident_dep = subproject('unicode-ident').get_variable('unicode_ident_dep')
+
+_syn_rs = static_library(
+  'syn',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2021',
+    '--cfg', 'feature="full"',
+    '--cfg', 'feature="derive"',
+    '--cfg', 'feature="parsing"',
+    '--cfg', 'feature="printing"',
+    '--cfg', 'feature="clone-impls"',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    quote_dep,
+    proc_macro2_dep,
+    unicode_ident_dep,
+  ],
+)
+
+syn_dep = declare_dependency(
+  link_with: _syn_rs,
+)
diff --git a/subprojects/packagefiles/unicode-ident/meson.build b/subprojects/packagefiles/unicode-ident/meson.build
new file mode 100644
index 0000000000..c81217de09
--- /dev/null
+++ b/subprojects/packagefiles/unicode-ident/meson.build
@@ -0,0 +1,19 @@
+project('unicode-ident', 'rust',
+  version: '1.0.12',
+  license: 'GPL-2.0-or-later',
+  default_options: [])
+
+_unicode_ident_rs = static_library(
+  'unicode_ident',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  rust_abi: 'rust',
+  rust_args: [
+    '--edition', '2021',
+  ],
+  dependencies: [],
+)
+
+unicode_ident_dep = declare_dependency(
+  link_with: _unicode_ident_rs,
+)
diff --git a/subprojects/proc-macro-error-attr.wrap b/subprojects/proc-macro-error-attr.wrap
new file mode 100644
index 0000000000..f24dbaadf3
--- /dev/null
+++ b/subprojects/proc-macro-error-attr.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = proc-macro-error-attr-1.0.4
+source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
+source_filename = proc-macro-erro-attrr-1.0.4.tar.gz
+source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
+#method = cargo
+patch_directory = proc-macro-error-attr
+
+[provide]
+dependency_names = proc_macro_error_attr_dep
diff --git a/subprojects/proc-macro-error.wrap b/subprojects/proc-macro-error.wrap
new file mode 100644
index 0000000000..95110ef94f
--- /dev/null
+++ b/subprojects/proc-macro-error.wrap
@@ -0,0 +1,11 @@
+[wrap-file]
+directory = proc-macro-error-1.0.4
+source_url = https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
+source_filename = proc-macro-error-1.0.4.tar.gz
+source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
+#method = cargo
+patch_directory = proc-macro-error
+
+[provide]
+dependency_names = proc_macro_error_dep
+
diff --git a/subprojects/proc-macro2.wrap b/subprojects/proc-macro2.wrap
new file mode 100644
index 0000000000..70849b9944
--- /dev/null
+++ b/subprojects/proc-macro2.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = proc-macro2-1.0.84
+source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
+source_filename = proc-macro2-1.0.84.0.tar.gz
+source_hash = ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
+#method = cargo
+patch_directory = proc-macro2
+
+[provide]
+dependency_names = proc_macro2_dep
diff --git a/subprojects/quote.wrap b/subprojects/quote.wrap
new file mode 100644
index 0000000000..82836107cb
--- /dev/null
+++ b/subprojects/quote.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = quote-1.0.36
+source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
+source_filename = quote-1.0.36.0.tar.gz
+source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
+#method = cargo
+patch_directory = quote
+
+[provide]
+dependency_names = quote_dep
diff --git a/subprojects/syn.wrap b/subprojects/syn.wrap
new file mode 100644
index 0000000000..f5ebe033de
--- /dev/null
+++ b/subprojects/syn.wrap
@@ -0,0 +1,11 @@
+[wrap-file]
+directory = syn-2.0.66
+source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
+source_filename = syn-2.0.66.0.tar.gz
+source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
+#method = cargo
+patch_directory = syn
+
+[provide]
+dependency_names = syn_dep
+
diff --git a/subprojects/unicode-ident.wrap b/subprojects/unicode-ident.wrap
new file mode 100644
index 0000000000..7b5304ccac
--- /dev/null
+++ b/subprojects/unicode-ident.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = unicode-ident-1.0.12
+source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
+source_filename = unicode-ident-1.0.12.tar.gz
+source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
+#method = cargo
+patch_directory = unicode-ident
+
+[provide]
+dependency_names = unicode_ident_dep
-- 
γαῖα πυρί μιχθήτω


