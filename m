Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6CE74006D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:10:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDl-0000Bs-HC; Tue, 27 Jun 2023 12:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDd-00008m-MM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDb-00055o-FE
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fa99742af9so22699555e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882022; x=1690474022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=00vN80eN+UK46fJC9GY1TERCNz4HcC0Ilii0GRuupFE=;
 b=BEEyoxSz96vrppioHktTdfLTKXqtQ0y7xCF/v3nAFjRFDSlgDiD7c2jBEQZRbYp7v+
 5fb/5gHK3HIKV/cPKfZ5geiwpEVn0prx60GSv7/gtdaxTn+UsGrgBlubHR5e1evwZ3R5
 QiqhFRRLjvv1IeheJvGeCXFjRbFTvpN9jvOn24sJ2RWBo2kPoE/h6c+KRQ1JPNk+Ag1A
 Vi5yvcfgrcidErc06aro9EBKHZ+70j/847XJ1R6BL+N5dSBAId5DOTaw2mr7b7bIwEnL
 z9OfdGH46tDKwR445LByXgJLOFxcKvr3EuFiovLJ8WEv4yMLX/NEfd/AgKNP3/qf9+nZ
 +PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882022; x=1690474022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=00vN80eN+UK46fJC9GY1TERCNz4HcC0Ilii0GRuupFE=;
 b=LtUFnbw+z0NPREdW4ICxvj8Cu7NEL+5+u6mXUXI1b4kH5H8isVC2xvEjNUc07ye56r
 jnWDoHjcoMGhRs7Gr37HD2vjTjHR4mnILZZOeQN77VRxUeT+0ps2PKPVlvUkz22mc76m
 QU56UcK8MaBmZ6r4XCkwZtPqmNx9MuCsGK9vFLXqxYquB/dZngW7G/W60SbiBw7L+Dbr
 K4DoyyzlH6ptmuLox65gSgxhPF8kb6CZgqPQY7IpO7YbxP0sN1A/bkwXiRh4vyKyxWrF
 riAger1c4xvaggPbyNCjMJXI+EkmEKJ/2ewBAVME9FBOF4HQdRQTdDDxIJ5QcZvcP2Ey
 TOhQ==
X-Gm-Message-State: AC+VfDwMqcyvFTP1r7YpCkRpV8yLE0IgWRGoAQAViWjV7TtAb6srpGRv
 zUo9GiMafcuAPskHe68P9hsKtw==
X-Google-Smtp-Source: ACHHUZ4LVXJsOLN3fgogdZn3RF455NSTmysDA2OQsey5I5r/N4EXYfB0z4vbOc1ePGeB78ew+ppFaA==
X-Received: by 2002:a1c:7514:0:b0:3f8:fe2a:25c2 with SMTP id
 o20-20020a1c7514000000b003f8fe2a25c2mr21469511wmc.38.1687882021609; 
 Tue, 27 Jun 2023 09:07:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c210800b003f9b4330880sm11262112wml.29.2023.06.27.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C6D3A1FFBB;
 Tue, 27 Jun 2023 17:07:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 00/36] maintainer omnibus: testing, fuzz, plugins,
 documentation (pre-PR)
Date: Tue, 27 Jun 2023 17:06:24 +0100
Message-Id: <20230627160700.2955547-1-alex.bennee@linaro.org>
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

As softfreeze is fast approaching I thought it would be work combining
my various trees into an omnibus series to ease the review and
merging.

The testing updates exposed a number of latent leaks that confused the
oss-fuzz jobs (hence the test-fuzz addition to help debug that). This
also includes some minor plugin updates and finally some documentation
updates that clean-up and expose the QOM and QDEV APIs which are so
core to emulating anything in QEMU.

v2
  - applied a bunch of review tags
  - added missing doc suggestions from Paolo
  - tweaked the plugin fix for CI

v3
  - few more tags
  - checkpatch cleanups

Alex Bennée (21):
  gitlab: reduce testing scope of check-gcov
  tests/tcg: add mechanism to handle plugin arguments
  qemu-keymap: properly check return from xkb_keymap_mod_get_index
  scripts/oss-fuzz: add a suppression for keymap
  tests/qtests: clean-up and fix leak in generic_fuzz
  tests/docker: add test-fuzz
  Makefile: add lcitool-refresh to UNCHECKED_GOALS
  tests/lcitool: update to latest version
  tests/lcitool: add an explicit gcc-native package
  tests/lcitool: introduce qemu-minimal
  tests/docker: convert riscv64-cross to lcitool
  plugins: force slow path when plugins instrument memory ops
  plugins: fix memory leak while parsing options
  plugins: update lockstep to use g_memdup2
  docs/devel: add some front matter to the devel index
  include/migration: mark vmstate_register() as a legacy function
  include/hw/qdev-core: fixup kerneldoc annotations
  docs/devel: split qom-api reference into new file
  docs/devel: introduce some key concepts for QOM development
  gdbstub: lightly refactor connection to avoid snprintf
  gdbstub: clean-up vcont handling to avoid goto

Ani Sinha (1):
  docs/devel: remind developers to run CI container pipeline when
    updating images

Daniel P. Berrangé (2):
  gitlab: explicit set artifacts publishing criteria
  gitlab: ensure coverage job also publishes meson log

Erik Skultety (1):
  tests/lcitool: Bump fedora container versions

Ilya Leoshkevich (8):
  linux-user: Expose do_guest_openat() and do_guest_readlink()
  linux-user: Add "safe" parameter to do_guest_openat()
  linux-user: Emulate /proc/self/smaps
  gdbstub: Expose gdb_get_process() and gdb_get_first_cpu_in_process()
  gdbstub: Report the actual qemu-user pid
  gdbstub: Add support for info proc mappings
  docs: Document security implications of debugging
  tests/tcg: Add a test for info proc mappings

Marcin Juszkiewicz (1):
  tests/avocado: update firmware to enable sbsa-ref/max

Nicholas Piggin (1):
  gdbstub: Permit reverse step/break to provide stop response

Philippe Mathieu-Daudé (1):
  docs/devel/qom.rst: Correct code style

 MAINTAINERS                                   |   1 +
 docs/devel/index-api.rst                      |   2 +
 docs/devel/index-process.rst                  |   2 +
 docs/devel/index-tcg.rst                      |   2 +
 docs/devel/index.rst                          |  24 +-
 docs/devel/qdev-api.rst                       |   7 +
 docs/devel/qom-api.rst                        |   9 +
 docs/devel/qom.rst                            |  65 +++-
 docs/devel/tcg.rst                            |   2 +
 docs/devel/testing.rst                        |   6 +
 docs/system/gdb.rst                           |  15 +
 Makefile                                      |   2 +-
 gdbstub/internals.h                           |   7 +
 include/exec/cpu-all.h                        |   2 +-
 include/hw/core/cpu.h                         |  17 +
 include/hw/qdev-core.h                        | 367 ++++++++++++------
 include/migration/vmstate.h                   |  10 +-
 linux-user/qemu.h                             |   3 +
 accel/tcg/cputlb.c                            |   5 +-
 accel/tcg/user-exec.c                         |   8 +-
 contrib/plugins/cache.c                       |   2 +-
 contrib/plugins/drcov.c                       |   2 +-
 contrib/plugins/execlog.c                     |   2 +-
 contrib/plugins/hotblocks.c                   |   2 +-
 contrib/plugins/hotpages.c                    |   2 +-
 contrib/plugins/howvec.c                      |   2 +-
 contrib/plugins/hwprofile.c                   |   2 +-
 contrib/plugins/lockstep.c                    |   4 +-
 gdbstub/gdbstub.c                             | 115 ++++--
 gdbstub/softmmu.c                             |  19 +-
 gdbstub/user-target.c                         | 139 +++++++
 linux-user/syscall.c                          | 128 ++++--
 qemu-keymap.c                                 |  24 +-
 target/arm/tcg/sve_helper.c                   |   4 -
 tests/plugin/bb.c                             |   2 +-
 tests/plugin/insn.c                           |   2 +-
 tests/plugin/mem.c                            |   2 +-
 tests/plugin/syscall.c                        |   2 +-
 tests/qtest/fuzz/generic_fuzz.c               |  11 +-
 .gitlab-ci.d/buildtest-template.yml           |   4 +-
 .gitlab-ci.d/buildtest.yml                    |   7 +-
 .gitlab-ci.d/crossbuild-template.yml          |   1 +
 .gitlab-ci.d/crossbuilds.yml                  |   2 +
 .gitlab-ci.d/opensbi.yml                      |   1 +
 scripts/oss-fuzz/lsan_suppressions.txt        |   3 +
 tests/avocado/machine_aarch64_sbsaref.py      |  23 +-
 tests/docker/dockerfiles/alpine.docker        |   4 +-
 .../dockerfiles/debian-amd64-cross.docker     |   1 +
 .../dockerfiles/debian-arm64-cross.docker     |   1 +
 .../dockerfiles/debian-armel-cross.docker     |   1 +
 .../dockerfiles/debian-armhf-cross.docker     |   1 +
 .../dockerfiles/debian-mips64el-cross.docker  |   1 +
 .../dockerfiles/debian-mipsel-cross.docker    |   1 +
 .../dockerfiles/debian-ppc64el-cross.docker   |   1 +
 .../dockerfiles/debian-riscv64-cross.docker   | 119 +++---
 .../dockerfiles/debian-s390x-cross.docker     |   1 +
 .../dockerfiles/fedora-win32-cross.docker     |   5 +-
 .../dockerfiles/fedora-win64-cross.docker     |   5 +-
 tests/docker/dockerfiles/fedora.docker        |   4 +-
 tests/docker/test-fuzz                        |  28 ++
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu-minimal.yml       |  27 ++
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |  18 +-
 tests/tcg/Makefile.target                     |   8 +-
 tests/tcg/aarch64/Makefile.target             |   8 +
 tests/tcg/multiarch/Makefile.target           |   9 +-
 .../multiarch/gdbstub/test-proc-mappings.py   |  65 ++++
 68 files changed, 1061 insertions(+), 313 deletions(-)
 create mode 100644 docs/devel/qdev-api.rst
 create mode 100644 docs/devel/qom-api.rst
 create mode 100755 tests/docker/test-fuzz
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml
 create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py

-- 
2.39.2


