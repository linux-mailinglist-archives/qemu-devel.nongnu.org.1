Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12273B706
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfnY-0003s1-2g; Fri, 23 Jun 2023 08:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003kW-Mu
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:12 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmh-0003g0-Rn
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:08 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f86a7a5499so712044e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522861; x=1690114861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j/vIHDwzFrIfz7Vm9fv4XCwyKtM7op7qmDeBZqPYxDg=;
 b=UZsjfxWwQvhGk54oTi9Lvnr77Q2tGBdwoViKoVm9SC054lTJKGUyyBaGo4CMiW0bjb
 Q2vxGES5epGE2mZ2WmcsWsR/+CmOwMaEzQENEZjuX2Sd9AQXeBcPzOQ8tFIkGfQwlSj4
 pPVuDAX7TpcvJPA/jBkq9CD87r3ES6ni1pH241P3TwcZ8/gsewvDt/9QqO2nF6n6CRru
 PEwNHrG5H1z+7zmoW9zAHxBrWiz4YD6PmlYj0bdXJYlSCEQS7rRKzmft6K/PtDiLMyaS
 YUDoZq8Xr3/tjAJTzLrhDhCC17vBMGikuvQ/a+Msn/9o5W5gbqgShLR0fOyeP7dIr+Of
 DLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522861; x=1690114861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/vIHDwzFrIfz7Vm9fv4XCwyKtM7op7qmDeBZqPYxDg=;
 b=fbnWNjqgLYTxeikwe8gExTP3s3MfklDwTbV9xuS4mZ7ZLGjGcC45XXcl4SxdJufdaZ
 6aaaRbdQekOfW0WHAIL+SLSmbjRwEI4Ma07cOqQWLvB04x/S5wJDT/ekTnECsQcJb8K+
 ++0EHB31ED5UAbOP6r+Dp68wmDcNhnkKfqO8BEuQTidUjdlfmrDZvXPDMm4voP68FH/j
 MDhKSiBmuD1r/+a9TpfU6Zo19rqbDaPINtUKBVoSGu9JPjRSPj+/AfMd+2h+ihTt0JcO
 GMYuJOSfedEvzppWDggo98wurJo108AlugznGJDXTezGxJuFLH0hQdVhAEhhcUoqqYwx
 wppw==
X-Gm-Message-State: AC+VfDzhYNhaIuoF3hGLorlRxyH0i4uSYD7msnFsh83uwRaPtadpr03p
 Vxs7TxHi71uRyZldfu3TaMF38A==
X-Google-Smtp-Source: ACHHUZ41FOZskEHSZ7HKiqU+bvTp4/N68kyCciZB0jYSQHeC34DYIOrFWyz4Mllkh6QUGYQZNWpV2A==
X-Received: by 2002:a05:6512:1319:b0:4f8:661f:60a4 with SMTP id
 x25-20020a056512131900b004f8661f60a4mr10427129lfu.41.1687522861361; 
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a1c720c000000b003f90b58df65sm2177937wmc.29.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 841341FFBB;
 Fri, 23 Jun 2023 13:21:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/26] maintainer omnibus: testing, fuzz, plugins,
 documentation
Date: Fri, 23 Jun 2023 13:20:34 +0100
Message-Id: <20230623122100.1640995-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

Please review.

Alex Bennée (20):
  gitlab: reduce testing scope of check-gcov
  tests/tcg: add mechanism to handle plugin arguments
  qemu-keymap: use modern name for Arabic keymap
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

 docs/devel/index-api.rst                      |   2 +
 docs/devel/index-process.rst                  |   2 +
 docs/devel/index-tcg.rst                      |   2 +
 docs/devel/index.rst                          |  24 +-
 docs/devel/qdev-api.rst                       |   7 +
 docs/devel/qom-api.rst                        |   9 +
 docs/devel/qom.rst                            |  54 ++-
 docs/devel/tcg.rst                            |   2 +
 docs/devel/testing.rst                        |   6 +
 Makefile                                      |   2 +-
 include/exec/cpu-all.h                        |   2 +-
 include/hw/core/cpu.h                         |  17 +
 include/hw/qdev-core.h                        | 365 ++++++++++++------
 include/migration/vmstate.h                   |   9 +-
 accel/tcg/cputlb.c                            |   4 +-
 accel/tcg/user-exec.c                         |   6 +-
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
 tests/plugin/insn.c                           |   2 +-
 tests/plugin/mem.c                            |   2 +-
 tests/plugin/syscall.c                        |   2 +-
 tests/qtest/fuzz/generic_fuzz.c               |  11 +-
 .gitlab-ci.d/buildtest-template.yml           |   4 +-
 .gitlab-ci.d/buildtest.yml                    |   7 +-
 .gitlab-ci.d/crossbuild-template.yml          |   1 +
 .gitlab-ci.d/crossbuilds.yml                  |   2 +
 .gitlab-ci.d/opensbi.yml                      |   1 +
 pc-bios/keymaps/meson.build                   |   2 +-
 scripts/oss-fuzz/lsan_suppressions.txt        |   3 +
 tests/avocado/machine_aarch64_sbsaref.py      |  22 +-
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
 59 files changed, 627 insertions(+), 230 deletions(-)
 create mode 100644 docs/devel/qdev-api.rst
 create mode 100644 docs/devel/qom-api.rst
 create mode 100755 tests/docker/test-fuzz
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml

-- 
2.39.2


