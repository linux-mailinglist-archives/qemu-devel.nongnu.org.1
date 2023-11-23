Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D087F6372
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:58:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C44-0005wV-G7; Thu, 23 Nov 2023 10:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C43-0005wE-0S
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C40-0002Jn-8l
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b34563987so6024665e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754981; x=1701359781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jkxllu0oEF6IrKVjQEyfqs3Q5IPxiZYA8SIQAF9gyvE=;
 b=U/T1G1Ca+xUfUuY9cLr89oKlkpmccUpabVgQdHzjiAfGL9XD9324Q4ueOXBWtRnBMg
 xU+ykKNLrkW4c/38u1WWF1/Uee1aFbwsWLiLX7bfISiCeGxjUd8uheX0OuPOWjvsB2uz
 Cv57IqfwOrNYC4zwC37fZVWB1kAvZJyouUQ/yKGlS8whigKL7DrJUfHalkqSeWWcgRGH
 ynq0pVEq+as6QNNsHGfhVX04IyX/dB4GGo1KfS6bi7BRLlaGzEtf9NloIKKtxji4i6e4
 ANQ57unzDpHWxGyOVrLYukiQNXUfzuFFMYB0YdXahLS+1MpDqG2qF3wZpsvKEwBDU2r2
 gKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754981; x=1701359781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jkxllu0oEF6IrKVjQEyfqs3Q5IPxiZYA8SIQAF9gyvE=;
 b=unsOzHiNIe9bf12/ujNY90rkZGadBrT2AodaaU9kbAYRaUyN3oz8rBjhBAAMFy5iN/
 JMzpyZtIfbJoTOUJ8E1LZnrr052m1x/8ZY2JhMt5SApbt7GIggZbguucgRxhg7MgWMdh
 AxxMEVWxLcN6E/HyFMgc53XVH/vcKAI7Mm5r8ncJw8GUwiUF8cAT1j8v/peZEcrez2Sb
 wkrM+8vOru6XW7Mu35J1C9dG7cmq+3S0kwE58K0kBbWMv2nW2BTBMkHTkW3NmuPG+Jsc
 u0gq/y7peHZJCRCPCvC47nSD19iUvfqVXI+vFZf20Lpi/ESEtuZVhN7WHl3bloVLBUs4
 ViKA==
X-Gm-Message-State: AOJu0YzzxJCV/RCzt/L5ucSH6jdBpynDw8z7PM8Yq0KK410a0iIfDHtB
 ayS1cwtlddrcVqSPdFonSCTRoUqrP0uyFUlBJN8O6g==
X-Google-Smtp-Source: AGHT+IE6r9H4aIp7vMDbIgmCMCqUeO5LKfX7e5v609jwVFd4Xf282EnYNNbEWTPub9LvIRA+z4PO9Q==
X-Received: by 2002:a05:600c:4691:b0:406:44fc:65c9 with SMTP id
 p17-20020a05600c469100b0040644fc65c9mr2784718wmo.8.1700754981474; 
 Thu, 23 Nov 2023 07:56:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh5-20020a05600c3d0500b00405d9a950a2sm3156246wmb.28.2023.11.23.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFD795F756;
 Thu, 23 Nov 2023 15:56:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/14] random fixes for 8.2 (tests, plugins, docs, semihosting)
Date: Thu, 23 Nov 2023 15:56:06 +0000
Message-Id: <20231123155620.3042891-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

The following changes since commit b93c4313f2f40897bdafba15620c8fef6c20e721:

  Merge tag 'pull-riscv-to-apply-20231122' of https://github.com/alistair23/qemu into staging (2023-11-22 09:39:23 -0500)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-for-8.2-fixes-231123-1

for you to fetch changes up to 6ef164188d005d7636f7ed8a1033cc4083498301:

  tests/tcg: finesse the registers check for "hidden" regs (2023-11-23 14:10:06 +0000)

----------------------------------------------------------------
various random fixes for 8.2

  - replace fedora-i386 cross compiler with debian
  - update cirrus MacOS image to Ventura
  - merge debian-native and debian-amd64 docker images
  - fix compile of plugins on Windows mingw cross
  - add some doc notes on semihosting READC
  - add some doc notes on gdbstub
  - skip loading debug symbols if we have failed
  - enable arm-softmmu TCG tests
  - don't attempt to use native cross builds for linux-user
  - clean up registers gdb test case (ppc64/s390x)

----------------------------------------------------------------
Alex Bennée (10):
      tests/docker: merge debian-native with debian-amd64
      tests/tcg: fixup Aarch64 semiconsole test
      docs/emulation: expand warning about semihosting
      docs/system: clarify limits of using gdbstub in system emulation
      hw/core: skip loading debug on all failures
      testing: move arm system tests into their own folder
      tests/tcg: enable arm softmmu tests
      tests/tcg: enable semiconsole test for Arm
      configure: don't try a "native" cross for linux-user
      tests/tcg: finesse the registers check for "hidden" regs

Daniel P. Berrangé (1):
      tests/docker: replace fedora-i386 with debian-i686

Greg Manning (1):
      plugins: fix win plugin tests on cross compile

Philippe Mathieu-Daudé (2):
      .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
      target/nios2: Deprecate the Nios II architecture

 docs/about/deprecated.rst                          |  15 +
 docs/about/emulation.rst                           |   5 +-
 docs/system/gdb.rst                                |  13 +-
 configure                                          |  27 +-
 hw/core/loader.c                                   |   2 +-
 hw/nios2/10m50_devboard.c                          |   1 +
 hw/nios2/generic_nommu.c                           |   1 +
 tests/tcg/arm/system/semiconsole.c                 |  42 +++
 .gitlab-ci.d/buildtest.yml                         |  12 +-
 .gitlab-ci.d/cirrus.yml                            |   6 +-
 .../cirrus/{macos-12.vars => macos-13.vars}        |   2 +-
 .gitlab-ci.d/container-cross.yml                   |  11 +-
 .gitlab-ci.d/containers.yml                        |   2 +-
 .gitlab-ci.d/crossbuilds.yml                       |  14 +-
 contrib/plugins/Makefile                           |   2 +-
 plugins/meson.build                                |   2 +-
 tests/docker/Makefile.include                      |   3 -
 tests/docker/dockerfiles/debian-i686-cross.docker  | 182 ++++++++++++
 tests/docker/dockerfiles/debian-native.docker      |  54 ----
 .../{debian-amd64.docker => debian.docker}         |   7 +-
 tests/docker/dockerfiles/fedora-i386-cross.docker  |  40 ---
 tests/lcitool/refresh                              |  18 +-
 tests/plugin/meson.build                           |   3 +-
 tests/tcg/aarch64/Makefile.softmmu-target          |   5 +-
 tests/tcg/arm/Makefile.softmmu-target              |  76 ++++-
 tests/tcg/arm/system/boot.S                        | 319 +++++++++++++++++++++
 tests/tcg/arm/system/kernel.ld                     |  24 ++
 tests/tcg/arm/{ => system}/test-armv6m-undef.S     |   0
 tests/tcg/arm/{ => system}/test-armv6m-undef.ld    |   0
 tests/tcg/multiarch/gdbstub/registers.py           |  95 ++++--
 tests/tcg/ppc64/Makefile.target                    |   7 -
 tests/tcg/s390x/Makefile.target                    |   4 -
 32 files changed, 798 insertions(+), 196 deletions(-)
 create mode 100644 tests/tcg/arm/system/semiconsole.c
 rename .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} (95%)
 create mode 100644 tests/docker/dockerfiles/debian-i686-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-native.docker
 rename tests/docker/dockerfiles/{debian-amd64.docker => debian.docker} (96%)
 delete mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker
 create mode 100644 tests/tcg/arm/system/boot.S
 create mode 100644 tests/tcg/arm/system/kernel.ld
 rename tests/tcg/arm/{ => system}/test-armv6m-undef.S (100%)
 rename tests/tcg/arm/{ => system}/test-armv6m-undef.ld (100%)

-- 
2.39.2


