Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A17DACD1
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77m-0007TS-PV; Sun, 29 Oct 2023 10:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77i-0007PN-5F
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77d-00054Y-6y
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso28784195e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591035; x=1699195835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KrpCfFApHrW+9I/ixbzKq9mDo7ePiZQt1VbBn8wPZ7o=;
 b=hgrlN8zc1VDtxqEBlX/A31Pg9zH+DHfHd2wxc8sEIcnlZ21RNcNGxJO3yynDh0O5Ro
 bm/V7LydVT79EPSMCCByVfnS+HT5gPBOpjpY4D86xZKImGeBHKx0Ak1iqHsxhL1q2yFi
 KTJSCVKndpsVxtvgfzJ6Tdz3rpiqL8tm3A7+AdC8gl+7rfHoJFqTJyK6xBx7BifytUrE
 hrM4S20JNpBwv9HWaAOY6tnJTpz2bNmsb57dh9npCkbDfsmrNFT73PX2cXvG7H9OoVWt
 bul4nm4A6ZTnQWDUCg0XY+1gV4yUarlk2MEy/M92sT8wyJk27ZnykgJTEHuDNYvuOyVL
 cMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591035; x=1699195835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KrpCfFApHrW+9I/ixbzKq9mDo7ePiZQt1VbBn8wPZ7o=;
 b=vCnKW2rjpfVQqKFIDIWFBbbIaOe6fUdvE//R2Wt5LOyiEYcKGdKQaRGd2hlZPHat/T
 8Ri3wcXhA+Tr1Sflavh05TEAb7d8LRkzO6lTirUscCIhVMoIOLlmltVVEx4EoPUtiCS4
 QUlvB5oOBVJe1Rj99lglL1/W4gsoutZbLA+1d2Ceu5/lmkTzQD6cGq2aGUiORl4VlO38
 oRZDUhwqoPiRXTZ8g0eO6I84Bnm0h3kBdvqbHr6A3sUjNyVDJf1iaGGYId4k1OGlx/EC
 kA6I/jttQQOBi6jOt/9HPuuf0RGNO2s1fDo/5uhkIcQmbMjLFY1ZsxZjHn2uOw21vY2k
 7g0Q==
X-Gm-Message-State: AOJu0Ywd07iQUPORNQe+akWtwQu/O7wE+vzNf85pke3sfaJQeV9LvjXo
 s1sSSTpB1GsJe3Ud4rl+vQm4Tg==
X-Google-Smtp-Source: AGHT+IFUEjy59ptD2E0JrZws/0ACf6Zf+DF7/wfqVl5wst0yLYPv4EAJ2ceNpHMJwrkHA7kTPsat5Q==
X-Received: by 2002:a05:600c:354c:b0:406:84b2:67f with SMTP id
 i12-20020a05600c354c00b0040684b2067fmr6375852wmq.20.1698591034756; 
 Sun, 29 Oct 2023 07:50:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 je12-20020a05600c1f8c00b004080f0376a0sm6730174wmb.42.2023.10.29.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CCF25F7A0;
 Sun, 29 Oct 2023 14:50:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 00/19] Maintainer updates for testing, gdb,
 semihosting and plugins (pre-PR)
Date: Sun, 29 Oct 2023 14:50:14 +0000
Message-Id: <20231029145033.592566-1-alex.bennee@linaro.org>
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

This collects up a number of fixes across my various maintainer trees.
There will be a longer plugins related one coming later but I wanted
to turn these around first. The update to bookworm was delayed from
the last release but I've now "solved" that by moving sh4 and alpha
into a legacy container stuck on bullseye.

v2
  - further split the first alpha patch
  - re-base and merge conflicts
  - address comments and tags

The following still need review:

  tests/docker: upgrade debian-all-test-cross to bookworm (1 acks, 1 sobs, 0 tbs)
  tests/docker: use debian-all-test-cross for sparc64
  tests/docker: move sh4 to use debian-legacy-test-cross
  gitlab: add build-loongarch to matrix
  gitlab: clean-up build-soft-softmmu job
  gitlab: split alpha testing into a legacy container

Akihiko Odaki (3):
  tests/tcg: Add -fno-stack-protector
  gdbstub: Check if gdb_regs is NULL
  plugins: Remove an extra parameter

Alex Bennée (13):
  gitlab: split alpha testing into a legacy container
  gitlab: clean-up build-soft-softmmu job
  gitlab: add build-loongarch to matrix
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

 configure                                     | 37 +++++++++++-
 accel/tcg/plugin-gen.c                        |  9 +--
 contrib/plugins/lockstep.c                    |  2 +
 gdbstub/gdbstub.c                             | 34 ++++++-----
 semihosting/config.c                          |  3 +-
 tests/tcg/mips/hello-mips.c                   |  4 +-
 .gitlab-ci.d/buildtest.yml                    | 34 +++++++++--
 .gitlab-ci.d/container-cross.yml              | 59 +++----------------
 tests/docker/Makefile.include                 |  8 ---
 .../dockerfiles/debian-all-test-cross.docker  | 26 ++++----
 .../dockerfiles/debian-alpha-cross.docker     | 19 ------
 .../dockerfiles/debian-hppa-cross.docker      | 19 ------
 .../debian-legacy-test-cross.docker           | 47 +++++++++++++++
 .../dockerfiles/debian-loongarch-cross.docker | 22 ++++++-
 .../dockerfiles/debian-m68k-cross.docker      | 19 ------
 .../dockerfiles/debian-mips-cross.docker      | 19 ------
 .../dockerfiles/debian-mips64-cross.docker    | 19 ------
 .../debian-powerpc-test-cross.docker          | 23 --------
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
 30 files changed, 194 insertions(+), 288 deletions(-)
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


