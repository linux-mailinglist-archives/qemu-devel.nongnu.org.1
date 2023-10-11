Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC677C5033
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXF-0001Oj-BB; Wed, 11 Oct 2023 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX4-0001IJ-LJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX0-0005AM-Hz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405497850dbso61640505e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020411; x=1697625211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cnTKL3QN/BCZ5lrf6sfXfhusnDOmmMy9D3iq6IORyWU=;
 b=hoMpkh25nWlms/flL3wjMVBqS6z4juUDSHlFoWMDjxZrj0groG/EW88Nrvq4IkW10W
 JIiAPIHwFKSLGMb7ONSFQPVR5Jmu4WqbR+WOdmF/R5FTcdGe0ehPm37OCelYfDvkHd4i
 NJ4VUB4rWZbfiGOaApWZZ6c1pPblD1CUdPaO9exSWxtKREdedJcJ7vCAy9OH6mOBCLM6
 F2tMn3pdAwKHqHsyoQ9JdiQaPp6oJXkk7y4WcgmpbzmBpVI4EVXUNRnTElkk+LXr0MoW
 SNCrXznEYZLGv5zgYOztzjlRBR/Q7fM4rhH1DKnYZpMmphAcVzy1A47x0lBxRg/jyn6X
 5e7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020411; x=1697625211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnTKL3QN/BCZ5lrf6sfXfhusnDOmmMy9D3iq6IORyWU=;
 b=boA87Z6TJVoxerPIeNl8918+OQRm8EvM3qPwubER73IQ/1qyS3XlfsA634IDCLAyTq
 byLfCZ1yW7cLDhXa7WC/56JXfCiJTISMPjuRk8/N7tKHf+PyWmoMqC47X1tmTHZDob3q
 OFHpgE3s9/X8pYl84zgx1zApSQzb2uTLtu+Fde4UBHdt719VWrQu7jKsKWuiOGqXVkDp
 bqjxXtlGUFhRL6b41KJpimowPj6amKP+fzhFtF7VYRSSWYUi+UWNFMgUfv5dLcaNVnBk
 tK+2SvLtPQigtBOm9lnXrsOulEBAPOGrundNmxgQxaoWs8LHHpYbDcb9h5T7KkC83L5X
 6PPQ==
X-Gm-Message-State: AOJu0Yx8O7sYSrwJ4ijZRDlfumj33RVqZTkJfMDw+1v9TqvWQ7DEnGn1
 1xl5hcd3fwXgW/oMYQHQpgartlJ13E0FK7baKYc=
X-Google-Smtp-Source: AGHT+IFkPRcagkLbKMpSy8uWqspariWkdTAiGxkFDeON7VMYMgI52TqlP9tJDPTRnGh0yiCqOehulw==
X-Received: by 2002:a5d:4586:0:b0:321:5e2f:37e1 with SMTP id
 p6-20020a5d4586000000b003215e2f37e1mr18066656wrq.19.1697020411071; 
 Wed, 11 Oct 2023 03:33:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e2-20020adfe382000000b00327de0173f6sm15073984wrm.115.2023.10.11.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:30 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D4251FFBB;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/25] testing, gdbstub and plugin updates
Date: Wed, 11 Oct 2023 11:33:04 +0100
Message-Id: <20231011103329.670525-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 0ad0d9dcd16f2ea816a413008ac5191ebef45c95:

  Merge tag 'firmware/seabios-20231010-pull-request' of https://gitlab.com/kraxel/qemu into staging (2023-10-10 10:22:16 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-omnibus-111023-1

for you to fetch changes up to 5b982f3bdeee8f0b2215d53012fea4da7c558cc6:

  contrib/plugins: fix coverity warning in hotblocks (2023-10-11 08:46:39 +0100)

----------------------------------------------------------------
testing, gdbstub and plugin updates

  - enable more sbsa-ref tests in avocado
  - add swtpm to the package lists
  - reduce avocado noise in gitlab by limiting tests
  - make docker engine choice driven by configure and enable override
  - remove unneeded gcc suffix on some cross compilers
  - fix some NULL returns in gdbstub
  - improve locking in execlog plugin
  - introduce the GDBFeature structure
  - consistently set gdb_core_xml_file
  - use cleaner escaping for gdb xml
  - drop ancient gdb_has_xml() test
  - disable multi-instruction GUSA emulation when plugins enabled
  - fix some coverity issues in plugins

----------------------------------------------------------------
Akihiko Odaki (12):
      gdbstub: Fix target_xml initialization
      gdbstub: Fix target.xml response
      plugins: Check if vCPU is realized
      contrib/plugins: Use GRWLock in execlog
      gdbstub: Introduce GDBFeature structure
      target/arm: Move the reference to arm-core.xml
      hw/core/cpu: Return static value with gdb_arch_name()
      gdbstub: Use g_markup_printf_escaped()
      target/arm: Remove references to gdb_has_xml
      target/ppc: Remove references to gdb_has_xml
      gdbstub: Remove gdb_has_xml variable
      gdbstub: Replace gdb_regs with an array

Alex Bennée (9):
      tests/avocado: remove flaky test marking for test_sbsaref_edk2_firmware
      tests/lcitool: add swtpm to the package list
      gitlab: shuffle some targets and reduce avocado noise
      tests/docker: make docker engine choice entirely configure driven
      configure: allow user to override docker engine
      configure: remove gcc version suffixes
      contrib/plugins: fix coverity warning in cache
      contrib/plugins: fix coverity warning in lockstep
      contrib/plugins: fix coverity warning in hotblocks

Marcin Juszkiewicz (1):
      tests/avocado: update firmware to enable OpenBSD test on sbsa-ref

Matt Borgerson (1):
      plugins: Set final instruction count in plugin_gen_tb_end

Richard Henderson (2):
      accel/tcg: Add plugin_enabled to DisasContextBase
      target/sh4: Disable decode_gusa when plugins enabled

 MAINTAINERS                                        |  2 +-
 configure                                          | 13 +--
 meson.build                                        |  2 +-
 gdbstub/internals.h                                |  2 -
 include/exec/gdbstub.h                             | 17 ++--
 include/exec/plugin-gen.h                          |  4 +-
 include/exec/translator.h                          |  2 +
 include/hw/core/cpu.h                              |  4 +-
 target/ppc/internal.h                              |  2 +-
 accel/tcg/plugin-gen.c                             |  6 +-
 accel/tcg/translator.c                             |  3 +-
 contrib/plugins/cache.c                            | 18 ++--
 contrib/plugins/execlog.c                          | 16 ++--
 contrib/plugins/hotblocks.c                        |  2 +-
 contrib/plugins/lockstep.c                         | 13 ++-
 gdbstub/gdbstub.c                                  | 95 +++++++++++-----------
 gdbstub/system.c                                   |  2 +-
 plugins/core.c                                     |  2 +-
 stubs/gdbstub.c                                    |  6 +-
 target/arm/cpu.c                                   |  9 +-
 target/arm/cpu64.c                                 |  4 +-
 target/arm/gdbstub.c                               | 32 +-------
 target/i386/cpu.c                                  |  6 +-
 target/loongarch/cpu.c                             |  8 +-
 target/ppc/gdbstub.c                               | 24 +-----
 target/riscv/cpu.c                                 |  6 +-
 target/s390x/cpu.c                                 |  4 +-
 target/sh4/translate.c                             | 41 +++++++---
 target/tricore/cpu.c                               |  4 +-
 .gitlab-ci.d/buildtest.yml                         | 15 +++-
 .gitlab-ci.d/cirrus/macos-12.vars                  |  2 +-
 scripts/feature_to_c.py                            | 48 +++++++++++
 scripts/feature_to_c.sh                            | 69 ----------------
 tests/avocado/machine_aarch64_sbsaref.py           | 71 +++++++++++++---
 tests/docker/Makefile.include                      |  9 +-
 tests/docker/dockerfiles/alpine.docker             |  1 +
 tests/docker/dockerfiles/centos8.docker            |  1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker |  1 +
 tests/docker/dockerfiles/debian-amd64.docker       |  1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker |  1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker |  1 +
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker |  1 +
 tests/docker/dockerfiles/fedora-win32-cross.docker |  1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker |  1 +
 tests/docker/dockerfiles/fedora.docker             |  1 +
 tests/docker/dockerfiles/opensuse-leap.docker      |  1 +
 tests/docker/dockerfiles/ubuntu2204.docker         |  1 +
 tests/lcitool/libvirt-ci                           |  2 +-
 tests/lcitool/projects/qemu.yml                    |  1 +
 50 files changed, 305 insertions(+), 274 deletions(-)
 create mode 100755 scripts/feature_to_c.py
 delete mode 100644 scripts/feature_to_c.sh

-- 
2.39.2


