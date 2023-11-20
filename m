Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF37F16EB
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:13:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tc-0006Eq-Co; Mon, 20 Nov 2023 10:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tC-0005lk-EZ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:42 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55t7-0001BR-A1
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:41 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso6230197e87.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492915; x=1701097715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GhWMV+0iDAi0XLi9YRgQkl+PlaH1vOD2mZj4D/Ej3lY=;
 b=Z0U3aWi0nbQHnF3KLJjWv2xyAALsoIevI7j9dWJK2I2dAuDSMyECvJ/5mMFomOcCYJ
 TkPWLoDYhU3gaGfREtZ62wwYawWGMPInfiPKTxyERWlOAHUT3uh3eeTlr0fChzIIGxwz
 pAysY2D98A2tPmKSKl5/QLB7ivqbc671OAqtW7eLk1j4QODD+CJ7vmkmyw0lK2pfulTo
 kshRcOQtc9y4hEU2aaaAcomVY3RXPRmEuVhQ+zEYHTbnI1GXmUbObdLnl8FD7h+DE5yr
 wDWV6xsit2/gnAq+hv/Hk/OXUUPSuRHiafK11vPmQ4EYcq/DSo3L06I7pdnBq/BlhfuF
 ppRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492915; x=1701097715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhWMV+0iDAi0XLi9YRgQkl+PlaH1vOD2mZj4D/Ej3lY=;
 b=FsxiVDGhlhrzaShEKhQFJcwl2MabnjyfabnAehrN4grCqgV1qaMC2wjEXn2hM7aLyP
 EaSFHNwAlcdvAXyBY0qFdCOb6mKu+WS3J5Yj2JB8tuzMinG3HdrOzDekgeVKWLnnDq/q
 ggB6+PZCuyDYASD5I9ShY4uv+q+HA8faRhaZtQRaO9ffd8D52ZMH/QFcFs0sfDdi2t8M
 G5NFd/yvYOPxwYMAfTY2Ka1zEwOfMc3TeM1yzeYdVNCZFiNv/136BbMrQRRTRh2dtdYC
 EktyhFxUKmJZhYS50iP0bLAkQ1eMfT4jyILJ0b1tud/zVOr395IV6YuY+iaNWiZAZf8r
 /jgQ==
X-Gm-Message-State: AOJu0Yz7KBvSrIJq8/tCoql7qeV/dMDOrf5QbXwLNQwY7M/F8NyjBqrj
 MPTY62Xd3p+xmPr6Te3H7DvHYg==
X-Google-Smtp-Source: AGHT+IEUfnhHgyrp93OqYEoR4VAd8cPGCy70O8fMul4c4RXK5i4NFz6mU9dz8jdWYhm9QTWmwEP9RQ==
X-Received: by 2002:a05:6512:b8e:b0:50a:b2d5:9c8d with SMTP id
 b14-20020a0565120b8e00b0050ab2d59c8dmr1300899lfv.55.1700492914817; 
 Mon, 20 Nov 2023 07:08:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f6-20020a7bc8c6000000b004030e8ff964sm17695496wml.34.2023.11.20.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F15A0655DF;
 Mon, 20 Nov 2023 15:08:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 00/14] random fixes for 8.2 pre-PR (tests, plugins, docs,
 semihosting)
Date: Mon, 20 Nov 2023 15:08:19 +0000
Message-Id: <20231120150833.2552739-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

I've just been trying to clear some of the bugs against various
subsystems. These are mostly testing changes and a minor tweak I found
while checking up on semihosting behaviour. Enabling arm-softmmu
check-tcg tests expands our testing abilities slightly for the 32 bit
side of the family.

For v2
------

 - fixed up register test for ppc64/s390x
 - added gdbstub doc patch
 - review comments for arm-softmmu testing
 - changed handling of "native" cross for linux-user

I intend to roll the PR on Wednesday.

The following need still review:

  tests/tcg: finesse the registers check for "hidden" regs
  configure: don't try a "native" cross for linux-user
  tests/tcg: enable semiconsole test for Arm
  tests/tcg: enable arm softmmu tests
  docs/system: clarify limits of using gdbstub in system emulation
  docs/emulation: expand warning about semihosting
  tests/tcg: fixup Aarch64 semiconsole test

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

 docs/about/deprecated.rst                     |  15 +
 docs/about/emulation.rst                      |   5 +-
 docs/system/gdb.rst                           |  13 +-
 configure                                     |  27 +-
 hw/core/loader.c                              |   2 +-
 hw/nios2/10m50_devboard.c                     |   1 +
 hw/nios2/generic_nommu.c                      |   1 +
 tests/tcg/arm/system/semiconsole.c            |  42 +++
 .gitlab-ci.d/buildtest.yml                    |  12 +-
 .gitlab-ci.d/cirrus.yml                       |   6 +-
 .../cirrus/{macos-12.vars => macos-13.vars}   |   2 +-
 .gitlab-ci.d/container-cross.yml              |  11 +-
 .gitlab-ci.d/containers.yml                   |   2 +-
 .gitlab-ci.d/crossbuilds.yml                  |  14 +-
 contrib/plugins/Makefile                      |   2 +-
 plugins/meson.build                           |   2 +-
 tests/docker/Makefile.include                 |   3 -
 .../dockerfiles/debian-i686-cross.docker      | 182 +++++++++++
 tests/docker/dockerfiles/debian-native.docker |  54 ----
 .../{debian-amd64.docker => debian.docker}    |   7 +-
 .../dockerfiles/fedora-i386-cross.docker      |  40 ---
 tests/lcitool/refresh                         |  18 +-
 tests/plugin/meson.build                      |   3 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |   5 +-
 tests/tcg/arm/Makefile.softmmu-target         |  76 ++++-
 tests/tcg/arm/system/boot.S                   | 301 ++++++++++++++++++
 tests/tcg/arm/system/kernel.ld                |  24 ++
 .../tcg/arm/{ => system}/test-armv6m-undef.S  |   0
 .../tcg/arm/{ => system}/test-armv6m-undef.ld |   0
 tests/tcg/multiarch/gdbstub/registers.py      |  87 +++--
 tests/tcg/ppc64/Makefile.target               |   7 -
 tests/tcg/s390x/Makefile.target               |   4 -
 32 files changed, 775 insertions(+), 193 deletions(-)
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


