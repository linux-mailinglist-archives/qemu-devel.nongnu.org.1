Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65908745DA6
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrB-0007Zb-Hh; Mon, 03 Jul 2023 09:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqz-0007OL-Cw
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqw-0005fP-Lr
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso4920323f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391868; x=1690983868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lmetaZ2AX9YHOFA/cIbsV+rLW+2EymnYScxuqRuEY5Y=;
 b=tE9yLvYUo9sCVVjwi+8666wJWQfiIb373jrYHh08J5TZ3+yh/COd+NVaqs2yfioNLc
 MVFc3YIWwtiuxhBOPkV/khMA0RHQT10a2hJQhCUQUxrDu//qpT+3pESTxZ6qf4qiDMSV
 nSgtf2E+KZAGR5J5t9flNaxCiaLAsRr10zLHun0MPjIMh7gBH/+3f/MuoZw9NQZmEyYo
 jSksO7NcO1rMKmL+j3Wu30JE7xq3pDn5pKZPaSHNl0fBREGsK8TOXUiT0uPp1oSqyDLl
 C4087I529EpMshp7Pr7OKE1A7COciPexbOyjMy167eXmRUsxhlaQRKPb87dUzp4ec/Bi
 /UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391868; x=1690983868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lmetaZ2AX9YHOFA/cIbsV+rLW+2EymnYScxuqRuEY5Y=;
 b=dcG6YMMOUzo/sxnbosmN9rGbZmkAYebpCLHqqpVLqP/4Oe8aswJZG6WeIjz3bEzedq
 trdHKj4uTm7tAkIH/9h/l5wHhZzGM/FEMW83mBRE4wLJXCmyTTaqLXdE9zS6JfQonnLD
 TpQodVbXOXIV0X+y/1Um7UHCKhaQn9UKrQJHYEe/CTsUq4es/2bh0BivoKM2SwS4PTxF
 aMNxiZkQ1H5+Kc82WpllhSKaMmtuwoPTi33NjTRtovpl07XYu2Z6NbSJkqZ2XA17oenA
 fiq7S2M9AwxSSi/LDiQ2Q8lXwbS1fCxw7A3232/ibKeUVy1oN+Neq37Y905qa+F6fGKu
 9vlg==
X-Gm-Message-State: ABy/qLZo6I6SLlOwlCvOQoWsYMjUajEK/kXz5bGynWWg+1GPhQXgnbqU
 4mOYrFSkZhVPdGrGAjWfiqz8/vpuMKtDOzBYXO8=
X-Google-Smtp-Source: APBJJlGzeMVFYZ8Ew5AMGc7Otzh2m/bS5U7Hdwaw00hzbSigI/FfgoQ5CiIWQXoXbrCyBmw9oUhm4A==
X-Received: by 2002:a5d:5444:0:b0:313:f1ec:f429 with SMTP id
 w4-20020a5d5444000000b00313f1ecf429mr8074567wrv.46.1688391868523; 
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b0030e5bd253aasm25615416wrj.39.2023.07.03.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4D151FFBB;
 Mon,  3 Jul 2023 14:44:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/38] maintainer updates for 8.1: testing, fuzz, plugins, docs,
 gdbstub
Date: Mon,  3 Jul 2023 14:43:49 +0100
Message-Id: <20230703134427.1389440-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

The following changes since commit d145c0da22cde391d8c6672d33146ce306e8bf75:

  Merge tag 'pull-tcg-20230701' of https://gitlab.com/rth7680/qemu into staging (2023-07-01 08:55:37 +0200)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-030723-1

for you to fetch changes up to a6341482695e1d15f11915f12dba98724efb0697:

  tests/tcg: Add a test for info proc mappings (2023-07-03 12:52:38 +0100)

----------------------------------------------------------------
maintainer updates: testing, fuzz, plugins, docs, gdbstub

 - clean up gitlab artefact handling
 - ensure gitlab publishes artefacts with coverage data
 - reduce testing scope for coverage job
 - mention CI pipeline in developer docs
 - add ability to add plugin args to check-tcg
 - fix some memory leaks and UB in tests
 - suppress xcb leaks from fuzzing output
 - add a test-fuzz to mirror the CI run
 - allow lci-refresh to be run in $SRC
 - update lcitool to latest version
 - add qemu-minimal package set with gcc-native
 - convert riscv64-cross to lcitool
 - update sbsa-ref tests
 - don't include arm_casq_ptw emulation unless TCG
 - convert plugins to use g_memdup2
 - ensure plugins instrument SVE helper mem access
 - improve documentation of QOM/QDEV
 - make gdbstub send stop responses when it should
 - report user-mode pid in gdbstub
 - add support for info proc mappings in gdbstub

----------------------------------------------------------------
Alex Bennée (22):
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
      target/arm: make arm_casq_ptw CONFIG_TCG only
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
      docs/devel: remind developers to run CI container pipeline when updating images

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

Thomas Huth (1):
      tests/avocado: Make the test_arm_bpim2u_gmac test more reliable

 MAINTAINERS                                        |   1 +
 docs/devel/index-api.rst                           |   2 +
 docs/devel/index-process.rst                       |   2 +
 docs/devel/index-tcg.rst                           |   2 +
 docs/devel/index.rst                               |  24 +-
 docs/devel/qdev-api.rst                            |   7 +
 docs/devel/qom-api.rst                             |   9 +
 docs/devel/qom.rst                                 |  65 +++-
 docs/devel/tcg.rst                                 |   2 +
 docs/devel/testing.rst                             |   6 +
 docs/system/gdb.rst                                |  15 +
 Makefile                                           |   2 +-
 gdbstub/internals.h                                |   7 +
 include/exec/cpu-all.h                             |   2 +-
 include/exec/exec-all.h                            |  23 ++
 include/hw/core/cpu.h                              |  17 +
 include/hw/qdev-core.h                             | 368 ++++++++++++++-------
 include/migration/vmstate.h                        |  10 +-
 linux-user/qemu.h                                  |   3 +
 accel/tcg/cputlb.c                                 |  41 ++-
 accel/tcg/user-exec.c                              |   8 +-
 contrib/plugins/cache.c                            |   2 +-
 contrib/plugins/drcov.c                            |   2 +-
 contrib/plugins/execlog.c                          |   2 +-
 contrib/plugins/hotblocks.c                        |   2 +-
 contrib/plugins/hotpages.c                         |   2 +-
 contrib/plugins/howvec.c                           |   2 +-
 contrib/plugins/hwprofile.c                        |   2 +-
 contrib/plugins/lockstep.c                         |   4 +-
 gdbstub/gdbstub.c                                  | 115 ++++---
 gdbstub/softmmu.c                                  |  19 +-
 gdbstub/user-target.c                              | 137 ++++++++
 linux-user/syscall.c                               | 128 +++++--
 qemu-keymap.c                                      |  24 +-
 target/arm/ptw.c                                   |  18 +-
 target/arm/tcg/sve_helper.c                        |   4 -
 tests/plugin/bb.c                                  |   2 +-
 tests/plugin/insn.c                                |   2 +-
 tests/plugin/mem.c                                 |   2 +-
 tests/plugin/syscall.c                             |   2 +-
 tests/qtest/fuzz/generic_fuzz.c                    |  13 +-
 .gitlab-ci.d/buildtest-template.yml                |   4 +-
 .gitlab-ci.d/buildtest.yml                         |   7 +-
 .gitlab-ci.d/crossbuild-template.yml               |   1 +
 .gitlab-ci.d/crossbuilds.yml                       |   2 +
 .gitlab-ci.d/opensbi.yml                           |   1 +
 scripts/oss-fuzz/lsan_suppressions.txt             |   3 +
 tests/avocado/boot_linux_console.py                |   4 +-
 tests/avocado/machine_aarch64_sbsaref.py           |  23 +-
 tests/docker/dockerfiles/alpine.docker             |   4 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |   1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker |   1 +
 tests/docker/dockerfiles/debian-armel-cross.docker |   1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker |   1 +
 .../dockerfiles/debian-mips64el-cross.docker       |   1 +
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   1 +
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   1 +
 .../docker/dockerfiles/debian-riscv64-cross.docker | 119 ++++---
 tests/docker/dockerfiles/debian-s390x-cross.docker |   1 +
 tests/docker/dockerfiles/fedora-win32-cross.docker |   5 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |   5 +-
 tests/docker/dockerfiles/fedora.docker             |   4 +-
 tests/docker/test-fuzz                             |  28 ++
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/projects/qemu-minimal.yml            |  27 ++
 tests/lcitool/projects/qemu.yml                    |   1 +
 tests/lcitool/refresh                              |  18 +-
 tests/tcg/Makefile.target                          |   8 +-
 tests/tcg/aarch64/Makefile.target                  |   8 +
 tests/tcg/multiarch/Makefile.target                |   9 +-
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py  |  65 ++++
 71 files changed, 1125 insertions(+), 331 deletions(-)
 create mode 100644 docs/devel/qdev-api.rst
 create mode 100644 docs/devel/qom-api.rst
 create mode 100755 tests/docker/test-fuzz
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml
 create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py

-- 
2.39.2


