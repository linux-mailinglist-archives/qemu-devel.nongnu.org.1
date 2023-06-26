Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6764973EE2B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFB-0002WX-HZ; Mon, 26 Jun 2023 17:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuF9-0002WA-GU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuF7-0004qd-IJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so1822416f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816768; x=1690408768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gSPkroLURnMPa7ET/8pIkXYyMeYLxPA45jCOq/SyqF4=;
 b=I13FhPTBvY3GMM8Huh9rJcfbdbuznJqkPt8BEgmv1O3Fi9JrnS6xz0yqoK5uLngkxI
 pM0g1qMG8A3yHEE7d7UBJ0ZhXva9PMBJnf7QuJA0NNciXC8kocA6dFz+KrSC16p9k/VZ
 mg8uXE56Mb3oftocpWndnaw4GU20fsf7spX/ZpEZYSU6j9o8j5eJRocQSxmc5ZR5f+3o
 CkaaOQlqCe0Od+SGhITTePBH0dRzA3z6VECiSBbheUbusHdYHgjBSVMfv2M5Xy3O4rXu
 Ivs+UOvTAqe37fHODFpLaZI+lup1sbrQBAYEVxNg9spknk9zaN9xuhMaYgfQIwYa4MyC
 ZKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816768; x=1690408768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSPkroLURnMPa7ET/8pIkXYyMeYLxPA45jCOq/SyqF4=;
 b=dzaVCqjHOHloUDIAppft/M/EzvyXbyLIXmCMhS4ybTMthWNJpttAGZ4MyQauGdKFxN
 4wWYwqsrjJrAyOcDeMw4YixibbbhDGr7sz4gRDSQfc0wVwk5Afzg+1KwrsRl/ubtBy82
 +vlwIiPVbyuG7cBWL6CnWmEqVaGV7ZTHI9KcGcH4dtVtZ3F0GDZVgbf3F8ikJ5bJbtlG
 Llt112H25sBfzAGcOcEit3C/2T4sifIr//FiMeJ6p7akXUOOus3VxzcwWKwcMXOYhX9x
 FwRKmDBMX9kzegtBWXVelVj76g25r6JBCDz2Qg5s12dqApG2bv2s2X0i56X8fs6ZHyPL
 p46Q==
X-Gm-Message-State: AC+VfDwO6EjtBzUVF4RZ6iLK/yjCylGCi/Uyr004JCnEt/c8RbCoh3qu
 gtBbrh1sgswncQlKZ8MK0ol2yg==
X-Google-Smtp-Source: ACHHUZ5wqqU43NTmeTRr/f8bz8l8W4+Ha/gaBmv89DTjKzCa+AoBrcmUyY3OOcw1zVuFYc+g6i2gUw==
X-Received: by 2002:a5d:4384:0:b0:313:f442:81f6 with SMTP id
 i4-20020a5d4384000000b00313f44281f6mr2359201wrq.7.1687816767896; 
 Mon, 26 Jun 2023 14:59:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i11-20020adfefcb000000b0030ae3a6be5bsm8456990wrp.78.2023.06.26.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9AF81FFBB;
 Mon, 26 Jun 2023 22:59:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 00/26] maintainer omnibus: testing, fuzz, plugins,
 documentation
Date: Mon, 26 Jun 2023 22:59:00 +0100
Message-Id: <20230626215926.2522656-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

The following patches need review:

 - qemu-keymap: properly check return from xkb_keymap_mod_get_index

Alex Bennée (19):
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

Ani Sinha (1):
  docs/devel: remind developers to run CI container pipeline when
    updating images

Daniel P. Berrangé (2):
  gitlab: explicit set artifacts publishing criteria
  gitlab: ensure coverage job also publishes meson log

Erik Skultety (1):
  tests/lcitool: Bump fedora container versions

Marcin Juszkiewicz (1):
  tests/avocado: update firmware to enable sbsa-ref/max

Philippe Mathieu-Daudé (1):
  docs/devel/qom.rst: Correct code style

Richard Henderson (1):
  tests/plugin: Remove duplicate insn log from libinsn.so

 docs/devel/index-api.rst                      |   2 +
 docs/devel/index-process.rst                  |   2 +
 docs/devel/index-tcg.rst                      |   2 +
 docs/devel/index.rst                          |  24 +-
 docs/devel/qdev-api.rst                       |   7 +
 docs/devel/qom-api.rst                        |   9 +
 docs/devel/qom.rst                            |  65 +++-
 docs/devel/tcg.rst                            |   2 +
 docs/devel/testing.rst                        |   6 +
 Makefile                                      |   2 +-
 include/exec/cpu-all.h                        |   2 +-
 include/hw/core/cpu.h                         |  17 +
 include/hw/qdev-core.h                        | 365 ++++++++++++------
 include/migration/vmstate.h                   |   9 +-
 accel/tcg/cputlb.c                            |   4 +-
 accel/tcg/user-exec.c                         |   8 +-
 contrib/plugins/cache.c                       |   2 +-
 contrib/plugins/drcov.c                       |   2 +-
 contrib/plugins/execlog.c                     |   2 +-
 contrib/plugins/hotblocks.c                   |   2 +-
 contrib/plugins/hotpages.c                    |   2 +-
 contrib/plugins/howvec.c                      |   2 +-
 contrib/plugins/hwprofile.c                   |   2 +-
 contrib/plugins/lockstep.c                    |   4 +-
 qemu-keymap.c                                 |  24 +-
 target/arm/tcg/sve_helper.c                   |   4 -
 tests/plugin/bb.c                             |   2 +-
 tests/plugin/insn.c                           |  11 +-
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
 tests/tcg/i386/Makefile.softmmu-target        |   9 -
 tests/tcg/i386/Makefile.target                |   6 -
 tests/tcg/x86_64/Makefile.softmmu-target      |   9 -
 61 files changed, 632 insertions(+), 270 deletions(-)
 create mode 100644 docs/devel/qdev-api.rst
 create mode 100644 docs/devel/qom-api.rst
 create mode 100755 tests/docker/test-fuzz
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml

-- 
2.39.2


