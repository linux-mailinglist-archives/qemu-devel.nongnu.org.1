Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D23704673
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp9E-0005Un-OK; Tue, 16 May 2023 03:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8v-0004mn-Ik; Tue, 16 May 2023 03:30:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8o-00005g-Dx; Tue, 16 May 2023 03:30:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f509ec3196so13892045e9.1; 
 Tue, 16 May 2023 00:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684222236; x=1686814236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEml0GErhel0ml9Ii8awK5BwqiSZJZmHxWuaMIWAew0=;
 b=NbYrhxdEtQuiE6u5t5W+m+/zKGG32k4wsqI6w0MO4/MkoBvUSAHf6EBgYnjCmj4W+M
 VOXn0XJD3XGoepa9A6xJEI0RvlG/Qr8i+jtBsAOiEcdYl+/vxkAEj4k6oQWwxMVlptKs
 AItMluTLQ5WUqd+iaw1Fjlmr5ZtkP0J2jtMz0nM4fsFPVvhRrqsoBquI9SVFv7wTnaxx
 v+/AMD1xva28MbWTrH95ZYoLZrhDlSLz59Df7olN5TpuwacTRUW2nUkagRXtbgoI29W6
 se6G1OjmrEgaqVhTiGCsTg5D+YiCX5lY9uka4XwMXEB2soXhk8pdA0vzxzY1qHhbO07+
 0Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222236; x=1686814236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SEml0GErhel0ml9Ii8awK5BwqiSZJZmHxWuaMIWAew0=;
 b=L0GH0bLNjl0ChcRVcsS9cPtU2Zgk0BFB+YBx72y5MhOQOdcbsEKHwCeZ8SbCdiShaG
 M4PSRU/EelnWmX0ewKoaGM+4wPd07BD4SVPP8eY15UpYrC3F0Mia0YNihL6hyi9a20Vx
 lodj6g9hCxjdHldKTi8hLgOWfykYIqrZvniPYRWPQKTE9seqGuEKnj2+epntyJFbujXf
 VZeTkOr66DLaOkjsTcTleUmsQhdnwtUtPqDFH6cUddfldhvgdRsBpXzUAX4k1NVqsJ/a
 4wQ6y759hLj6nWzcOCE4j9nGT1AC8EHDRF3p/keubYhxnwOb7AWDI1YJymEMVg2Hn495
 kkfw==
X-Gm-Message-State: AC+VfDyeNmxnzNhw8CjgIAJd+ojl+2oRrDhY4iV93lMFXRy+r3O4sEeQ
 lyE5STTaJiTS7KeR46rgsK4caVYBSZ/RZg==
X-Google-Smtp-Source: ACHHUZ6+quyTbmttw2KdXLvJcUMvpZQKMX6MgQ7Sb3H1NzaZzTf8RZJ06ghrw56c+wojiI7/UhkdKA==
X-Received: by 2002:adf:f84b:0:b0:309:3860:8d23 with SMTP id
 d11-20020adff84b000000b0030938608d23mr253986wrq.16.1684222235629; 
 Tue, 16 May 2023 00:30:35 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 y12-20020a5d614c000000b003062c609115sm1559997wrt.21.2023.05.16.00.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 00:30:35 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PULL 7/8] editing the meson and KConfig files to add tivac to qemu
 build system
Date: Tue, 16 May 2023 10:29:58 +0300
Message-Id: <20230516072959.49994-8-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516072959.49994-1-m.elsayed4420@gmail.com>
References: <20230516072959.49994-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
---
 .gitignore                              |   1 +
 README.rst                              | 150 ++----------------------
 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/Kconfig                          |  13 ++
 hw/arm/meson.build                      |   3 +
 hw/char/Kconfig                         |   3 +
 hw/char/meson.build                     |   1 +
 hw/char/trace-events                    |   4 +
 hw/gpio/Kconfig                         |   3 +
 hw/gpio/meson.build                     |   1 +
 hw/gpio/trace-events                    |   4 +
 hw/misc/Kconfig                         |   3 +
 hw/misc/meson.build                     |   1 +
 hw/misc/trace-events                    |   5 +
 hw/timer/Kconfig                        |   3 +
 hw/timer/meson.build                    |   1 +
 hw/timer/trace-events                   |   5 +
 hw/watchdog/Kconfig                     |   3 +
 hw/watchdog/meson.build                 |   1 +
 hw/watchdog/trace-events                |   3 +
 20 files changed, 72 insertions(+), 137 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1ea59f4819..009ab2ee4b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 .gdb_history
 cscope.*
 tags
+compile_commands.json
 TAGS
 GPATH
 GRTAGS
diff --git a/README.rst b/README.rst
index 21df79ef43..37ea8cb56c 100644
--- a/README.rst
+++ b/README.rst
@@ -1,46 +1,8 @@
 ===========
-QEMU README
+QEMU_TivaC README
 ===========
 
-QEMU is a generic and open source machine & userspace emulator and
-virtualizer.
-
-QEMU is capable of emulating a complete machine in software without any
-need for hardware virtualization support. By using dynamic translation,
-it achieves very good performance. QEMU can also integrate with the Xen
-and KVM hypervisors to provide emulated hardware while allowing the
-hypervisor to manage the CPU. With hypervisor support, QEMU can achieve
-near native performance for CPUs. When QEMU emulates CPUs directly it is
-capable of running operating systems made for one machine (e.g. an ARMv7
-board) on a different machine (e.g. an x86_64 PC board).
-
-QEMU is also capable of providing userspace API virtualization for Linux
-and BSD kernel interfaces. This allows binaries compiled against one
-architecture ABI (e.g. the Linux PPC64 ABI) to be run on a host using a
-different architecture ABI (e.g. the Linux x86_64 ABI). This does not
-involve any hardware emulation, simply CPU and syscall emulation.
-
-QEMU aims to fit into a variety of use cases. It can be invoked directly
-by users wishing to have full control over its behaviour and settings.
-It also aims to facilitate integration into higher level management
-layers, by providing a stable command line interface and monitor API.
-It is commonly invoked indirectly via the libvirt library when using
-open source applications such as oVirt, OpenStack and virt-manager.
-
-QEMU as a whole is released under the GNU General Public License,
-version 2. For full licensing details, consult the LICENSE file.
-
-
-Documentation
-=============
-
-Documentation can be found hosted online at
-`<https://www.qemu.org/documentation/>`_. The documentation for the
-current development version that is available at
-`<https://www.qemu.org/docs/master/>`_ is generated from the ``docs/``
-folder in the source tree, and is built by `Sphinx
-<https://www.sphinx-doc.org/en/master/>`_.
-
+QEMU_TivaC aims to provide a TivaC support for the QEMU project. The project is far from being complete (so far) but im working on it.
 
 Building
 ========
@@ -52,9 +14,11 @@ of other UNIX targets. The simple steps to build QEMU are:
 
 .. code-block:: shell
 
+  git clone git@github.com:moesay/qemu_TivaC.git
+  cd qemu_TivaC
   mkdir build
   cd build
-  ../configure
+  ../configure --target-list=arm-softmmu
   make
 
 Additional information can also be found online via the QEMU website:
@@ -64,108 +28,20 @@ Additional information can also be found online via the QEMU website:
 * `<https://wiki.qemu.org/Hosts/W32>`_
 
 
-Submitting patches
-==================
-
-The QEMU source code is maintained under the GIT version control system.
-
-.. code-block:: shell
-
-   git clone https://gitlab.com/qemu-project/qemu.git
-
-When submitting patches, one common approach is to use 'git
-format-patch' and/or 'git send-email' to format & send the mail to the
-qemu-devel@nongnu.org mailing list. All patches submitted must contain
-a 'Signed-off-by' line from the author. Patches should follow the
-guidelines set out in the `style section
-<https://www.qemu.org/docs/master/devel/style.html>`_ of
-the Developers Guide.
-
-Additional information on submitting patches can be found online via
-the QEMU website
-
-* `<https://wiki.qemu.org/Contribute/SubmitAPatch>`_
-* `<https://wiki.qemu.org/Contribute/TrivialPatches>`_
+Usage
+=====
 
-The QEMU website is also maintained under source control.
+After building QEMU_TivaC, you can use it with gdb through the provided gdbstub.
 
 .. code-block:: shell
 
-  git clone https://gitlab.com/qemu-project/qemu-web.git
+   qemu-system-arm -M tivac -kernel <your elf file path> -s -S -D log_file.txt -d unimp -serial file:qemu_serial_op.txt -monitor stdio -nographic
 
-* `<https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/>`_
-
-A 'git-publish' utility was created to make above process less
-cumbersome, and is highly recommended for making regular contributions,
-or even just for sending consecutive patch series revisions. It also
-requires a working 'git send-email' setup, and by default doesn't
-automate everything, so you may want to go through the above steps
-manually for once.
-
-For installation instructions, please go to
-
-*  `<https://github.com/stefanha/git-publish>`_
-
-The workflow with 'git-publish' is:
+Now, QEMU_TivaC is ready to be attached to gdb. In a different terminal run arm gdb and attach QEMU_TivaC to it.
 
 .. code-block:: shell
 
-  $ git checkout master -b my-feature
-  $ # work on new commits, add your 'Signed-off-by' lines to each
-  $ git publish
-
-Your patch series will be sent and tagged as my-feature-v1 if you need to refer
-back to it in the future.
-
-Sending v2:
-
-.. code-block:: shell
-
-  $ git checkout my-feature # same topic branch
-  $ # making changes to the commits (using 'git rebase', for example)
-  $ git publish
-
-Your patch series will be sent with 'v2' tag in the subject and the git tip
-will be tagged as my-feature-v2.
-
-Bug reporting
-=============
-
-The QEMU project uses GitLab issues to track bugs. Bugs
-found when running code built from QEMU git or upstream released sources
-should be reported via:
-
-* `<https://gitlab.com/qemu-project/qemu/-/issues>`_
-
-If using QEMU via an operating system vendor pre-built binary package, it
-is preferable to report bugs to the vendor's own bug tracker first. If
-the bug is also known to affect latest upstream code, it can also be
-reported via GitLab.
-
-For additional information on bug reporting consult:
-
-* `<https://wiki.qemu.org/Contribute/ReportABug>`_
-
-
-ChangeLog
-=========
-
-For version history and release notes, please visit
-`<https://wiki.qemu.org/ChangeLog/>`_ or look at the git history for
-more detailed information.
-
-
-Contact
-=======
-
-The QEMU community can be contacted in a number of ways, with the two
-main methods being email and IRC
-
-* `<mailto:qemu-devel@nongnu.org>`_
-* `<https://lists.nongnu.org/mailman/listinfo/qemu-devel>`_
-* #qemu on irc.oftc.net
-
-Information on additional methods of contacting the community can be
-found online via the QEMU website:
+   arm-none-eabi-gdb <your elf file path>
+   (gdb) target remote :1234
 
-* `<https://wiki.qemu.org/Contribute/StartHere>`_
+For the original QEMU readme, go to `<https://github.com/qemu/qemu>`_
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 1b49a7830c..d3490f6d11 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -43,3 +43,4 @@ CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
+CONFIG_TIVAC=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b53bd7f0b2..ef8046ab1b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -581,3 +581,16 @@ config ARMSSE
     select UNIMP
     select SSE_COUNTER
     select SSE_TIMER
+
+config TM4C123GH6PM_SOC
+    bool
+    select ARM_V7M
+    select TM4C123_USART
+    select TM4C123_SYSCTL
+    select TM4C123_GPIO
+    select TM4C123_WDT
+    select TM4C123_GPTM
+
+config TIVAC
+    bool
+    select TM4C123GH6PM_SOC
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b545ba0e4f..29503388a5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -62,10 +62,13 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
+arm_ss.add(when: 'CONFIG_TM4C123GH6PM_SOC', if_true: files('tm4c123gh6pm_soc.c'))
+arm_ss.add(when: 'CONFIG_TIVAC', if_true: files('tivac.c'))
 
 softmmu_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 softmmu_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 
+
 hw_arch += {'arm': arm_ss}
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 6b6cf2fc1d..88da979b75 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -71,3 +71,6 @@ config GOLDFISH_TTY
 
 config SHAKTI_UART
     bool
+
+config TM4C123_USART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 0807e00ae4..8461748c8d 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -33,6 +33,7 @@ softmmu_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 softmmu_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_USART', if_true: files('tm4c123_usart.c'))
 softmmu_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 2ecb36232e..47b7e3b772 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_usart.c
+tm4c123_usart_read(uint64_t offset) " offset: 0x%" PRIu64
+tm4c123_usart_write(uint64_t offset, uint64_t value) " offset: 0x%" PRIu64 " - value: 0x%" PRIu64
+
 # parallel.c
 parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s] addr 0x%02x val 0x%02x"
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index d2cf3accc8..1b843d669a 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,3 +16,6 @@ config GPIO_PWR
 
 config SIFIVE_GPIO
     bool
+
+config TM4C123_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index b726e6d27a..b253e8ce67 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -12,3 +12,4 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_GPIO', if_true: files('tm4c123_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 9736b362ac..22d282495d 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_gpio.c
+tm4c123_gpio_read(uint64_t offset) " offset: 0x%" PRIx64
+tm4c123_gpio_write(uint64_t offset, uint64_t value) " offset: 0x%" PRIx64 " - value: 0x%" PRIx64
+
 # npcm7xx_gpio.c
 npcm7xx_gpio_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
 npcm7xx_gpio_write(const char *id, uint64_t offset, uint64_t value) "%s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2ef5781ef8..c8be9ae285 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -180,4 +180,7 @@ config AXP209_PMU
     bool
     depends on I2C
 
+config TM4C123_SYSCTL
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a40245ad44..95ddb4b1b4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -141,3 +141,4 @@ softmmu_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
 softmmu_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_SYSCTL', if_true: files('tm4c123_sysctl.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c47876a902..0c40b49457 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_sysctl.c
+tm4c123_sysctl_read(uint64_t offset) " offset: 0x%" PRIu64
+tm4c123_sysctl_write(uint64_t offset, uint64_t value) " offset: 0x%" PRIu64 " - value: 0x%"PRIu64
+tm4c123_sysctl_update_system_clock(uint32_t value) "New clock value = %"PRIu32" Hz"
+
 # allwinner-cpucfg.c
 allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "id %u, reset_addr 0x%" PRIx32
 allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 010be7ed1f..aaf42e3f3f 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -60,3 +60,6 @@ config STELLARIS_GPTM
 
 config AVR_TIMER16
     bool
+
+config TM4C123_GPTM
+    bool
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 03092e2ceb..118593e959 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -36,5 +36,6 @@ softmmu_ss.add(when: 'CONFIG_STM32F2XX_TIMER', if_true: files('stm32f2xx_timer.c
 softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
 specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_GPTM', if_true: files('tm4c123_gptm.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 3eccef8385..e40b445630 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_gptm.c
+tm4c123_gptm_read(uint32_t offset) "offset: 0x%"PRIx32
+tm4c123_gptm_write(uint32_t offset, uint32_t value) "offset: 0x%"PRIx32" - value: 0x%"PRIx32
+tm4c123_gptm_build_interval_value(uint32_t talir, uint32_t tblir, uint64_t result) "TALIR: 0x%"PRIx32" - TBLIR: 0x%"PRIx32" - value: 0x%"PRIx64
+
 # slavio_timer.c
 slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
 slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 861fd00334..ada7163055 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -24,3 +24,6 @@ config WDT_SBSA
 config ALLWINNER_WDT
     bool
     select PTIMER
+
+config TM4C123_WDT
+    bool
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 5dcd4fbe2f..cc48d2dec9 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -7,4 +7,5 @@ softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
 softmmu_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
+softmmu_ss.add(when: 'CONFIG_TM4C123_WDT', if_true: files('tm4c123_watchdog.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_watchdog.c'))
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index 2739570652..802aed4a6f 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -1,5 +1,8 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# tm4c123_wdt.c
+tm4c123_wdt_write(uint64_t offset, uint64_t data) "TM4C123-WDT Write: [ Offset 0x%" PRIx64 " - Data 0x%" PRIx64 "]"
+
 # allwinner-wdt.c
 allwinner_wdt_read(uint64_t offset, uint64_t data, unsigned size) "Allwinner watchdog read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 allwinner_wdt_write(uint64_t offset, uint64_t data, unsigned size) "Allwinner watchdog write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.34.1


