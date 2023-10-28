Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150607DA677
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdB-00069i-4d; Sat, 28 Oct 2023 06:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd8-00068Y-NC
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd5-00038p-R3
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso23561825e9.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489193; x=1699093993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ckA759hPSyt8nZwNqXR0bAUlw3vk+6GLbJPhTNDJqv8=;
 b=UEre3YtKaOoEHg4Hi0Qi86zptXkALutRSlyzVE6TXhT87eCjpadqaIqp+1mcEVPFQT
 Z0maMfcwB7Qtohy28//UPjGKCutib6niQ65a6U+3LMeNQE+NMB7Pltqod/+sizqPtXLQ
 qA34drYkYY5pxIuaBkV3sw0+WjPum6u7/1KJcGcPRmMQrvjlZub/tI5nKS5OLvJCM/f1
 9MnEqTegL7Tw3jppUncIY7dJIW+vHPccgiBwz2x/4DQtBOJ1MkHjgFCZV6qWHGIQDCo3
 8iujh2YqvH1OdbluDcd8vXd30L2VP6DVPI2utA3ah0Uu5htDDbewbHIWu3Add40aSu89
 rmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489193; x=1699093993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ckA759hPSyt8nZwNqXR0bAUlw3vk+6GLbJPhTNDJqv8=;
 b=gD0PgnMiF/fOcrsZihMd84Obcs1MUwaY4ew9k5G1h2HNoKKcnMYXC4aJkAMhKWuiBQ
 j96RoVqrCsw6hDj6BDX9mdOc7CS3/TYlYiBPuks4pITzf79v5bxfhCYcsxusQtxkZI2D
 uc0vNVLzae3lS+rPWzN071Kf/FYkJqfVSn+szWDtDmYpaoqrFa0jR0UW8e6nvF5JO6FU
 oK24zXgnGg0qlpT/8fFpryXwRuEdgKf5sp+Lo3c4Kle3AoboedpnKLJGIBJdGPTioX77
 KLRekoVYRS+TuvCt4aUZR11X6pnaAKZ43f0bbOJMFhcrMo7klwmOFbyDUsrbLlxExaar
 IV0Q==
X-Gm-Message-State: AOJu0YyNIxcjWZC/tj24n3k4Y9Ag8DvcEzTOx2t0jUlekPDI3+twBb3V
 3gxiWRwiwAtPIvqLh9yPie/KRQ==
X-Google-Smtp-Source: AGHT+IG555RWuAU0LKVdzaLPLrnoSRVlq2p33MjezFSo645LMCBaHYpC7hBs1ZY5bHKE3ryFMhPTzA==
X-Received: by 2002:a05:600c:2990:b0:402:ee71:29 with SMTP id
 r16-20020a05600c299000b00402ee710029mr4115486wmd.10.1698489193017; 
 Sat, 28 Oct 2023 03:33:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 3-20020a05600c248300b00406408dc788sm7135731wms.44.2023.10.28.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ECE225F76C;
 Sat, 28 Oct 2023 11:33:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/17] Maintainer updates for testing, gdb,
 semihosting and plugins
Date: Sat, 28 Oct 2023 11:32:54 +0100
Message-Id: <20231028103311.347104-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

This collects up a number of fixes across my various maintainer trees.
There will be a longer plugins related one coming later but I wanted
to turn these around first. The update to bookworm was delayed from
the last release but I've now "solved" that by moving sh4 and alpha
into a legacy container stuck on bullseye.

I've also taken the opportunity to rationalise our zoo of containers
to better sync up with what we actually use on gitlab.

The following still need review:

  plugins: Remove an extra parameter
  tests/docker: upgrade debian-all-test-cross to bookworm
  tests/docker: use debian-all-test-cross for sparc64
  tests/docker: use debian-all-test-cross for riscv64
  tests/docker: use debian-all-test-cross for mips
  tests/docker: use debian-all-test-cross for mips64
  tests/docker: use debian-all-test-cross for m68k
  tests/docker: use debian-all-test-cross for hppa
  tests/docker: use debian-all-test-cross for power
  tests/docker: move sh4 to use debian-legacy-test-cross
  tests/docker: use debian-legacy-test-cross for alpha
  gitlab: split alpha testing into a legacy container

Akihiko Odaki (3):
  tests/tcg: Add -fno-stack-protector
  gdbstub: Check if gdb_regs is NULL
  plugins: Remove an extra parameter

Alex Bennée (11):
  gitlab: split alpha testing into a legacy container
  tests/docker: use debian-legacy-test-cross for alpha
  tests/docker: move sh4 to use debian-legacy-test-cross
  tests/docker: use debian-all-test-cross for power
  tests/docker: use debian-all-test-cross for hppa
  tests/docker: use debian-all-test-cross for m68k
  tests/docker: use debian-all-test-cross for mips64
  tests/docker: use debian-all-test-cross for mips
  tests/docker: use debian-all-test-cross for riscv64
  tests/docker: use debian-all-test-cross for sparc64
  tests/docker: upgrade debian-all-test-cross to bookworm

Cong Liu (1):
  contrib/plugins: Close file descriptor on error return

Matheus Tavares Bernardino (1):
  semihosting: fix memleak at semihosting_arg_fallback

Thomas Huth (1):
  tests/vm/openbsd: Use the system dtc package

 configure                                     | 37 ++++++++++-
 accel/tcg/plugin-gen.c                        |  9 +--
 contrib/plugins/lockstep.c                    |  2 +
 gdbstub/gdbstub.c                             | 34 ++++++-----
 semihosting/config.c                          |  3 +-
 tests/tcg/mips/hello-mips.c                   |  4 +-
 .gitlab-ci.d/buildtest.yml                    | 20 +++++-
 .gitlab-ci.d/container-cross.yml              | 61 ++-----------------
 tests/docker/Makefile.include                 |  7 ---
 .../dockerfiles/debian-all-test-cross.docker  | 26 ++++----
 .../dockerfiles/debian-alpha-cross.docker     | 19 ------
 .../dockerfiles/debian-hppa-cross.docker      | 19 ------
 .../debian-legacy-test-cross.docker           | 47 ++++++++++++++
 .../dockerfiles/debian-m68k-cross.docker      | 19 ------
 .../dockerfiles/debian-mips-cross.docker      | 19 ------
 .../dockerfiles/debian-mips64-cross.docker    | 19 ------
 .../debian-powerpc-test-cross.docker          | 23 -------
 .../debian-riscv64-test-cross.docker          | 19 ------
 .../dockerfiles/debian-sh4-cross.docker       | 19 ------
 .../dockerfiles/debian-sparc64-cross.docker   | 19 ------
 tests/tcg/Makefile.target                     |  2 +-
 tests/tcg/aarch64/Makefile.target             |  2 +-
 tests/tcg/arm/Makefile.target                 |  2 +-
 tests/tcg/cris/Makefile.target                |  2 +-
 tests/tcg/hexagon/Makefile.target             |  2 +-
 tests/tcg/i386/Makefile.target                |  2 +-
 tests/tcg/minilib/Makefile.target             |  2 +-
 tests/tcg/mips/Makefile.target                |  2 +-
 tests/vm/openbsd                              |  6 +-
 29 files changed, 158 insertions(+), 289 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-test-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-riscv64-test-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker

-- 
2.39.2


