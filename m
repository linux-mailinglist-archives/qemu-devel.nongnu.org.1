Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F1707FE8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbzr-0001F9-EL; Thu, 18 May 2023 07:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzbzl-00017J-5i
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzbzi-0002wR-Fp
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684410029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jsp9Rz/RiAMhhnfqdRSgeGT3Jp89em2uupPBnxoLaIk=;
 b=PXODJRWFr/dMDLsWUm0cysfT0qanCgkoXEYkAYTYwXB0gz8RDSgZK9YGNlwJ4Sfxn/uL4V
 w+m/6W8AayJBL2VOHaNxL86lTKqAB2vJIhnG6lUrmwIsy7+cMdRXzfQdVoOfiEZTlfsi6V
 mwkDU2ftDwFYwibJ+tWNjXtmVpjlD8A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534--EzH4XfHPB-CXQHSBKyw4A-1; Thu, 18 May 2023 07:40:28 -0400
X-MC-Unique: -EzH4XfHPB-CXQHSBKyw4A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso47476666b.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684410027; x=1687002027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jsp9Rz/RiAMhhnfqdRSgeGT3Jp89em2uupPBnxoLaIk=;
 b=KnT5ovxzgIoB0z69Pue1r2ZBVANQwLbjqV7YI5Jl6+/xz8DeVuHxgoa1rsOT4yhvs9
 vAxiE+lIkh//Y+7l6m5I6O22czcddwNdZhpUesW+qD0xlX/xFH6gX7FJelAPSwJ4r88J
 TFvXipzMlSTqqgn5mkKyeEZ0tnZncvU50cY0mhQ5I8TREKCaC+Kf1WwpbMB5BokJxWVE
 /3k6rxeG/8Ha5Z5Pwonrzfg/G3ZzAgbhoJeggxmEE4gCyeVBgyuspSOVzL21izrlv6c+
 ahE5sT/tdOmyLFhvVPM2HqDrytw+iS0IPwE6yc4Z+o9YAs/RLm2zDh80Y0TmeGYqU4xZ
 jZRQ==
X-Gm-Message-State: AC+VfDyNvJVfUD5PABe9fEY18HCnxBL/5GaqvUqt/5dKHkP7cEo2L1AQ
 w7baS3WdvgnRNmRUf7vdrNsBg99U1wE1xGMrEOvPbmmZnrzkJaQzhh2di8SFO/yQQbndtM5FyDc
 HDTtSZ2TkWZX5ooS4UopBu5MrTIztn6rJ5qJSUdLKswRj7PVIUsB9hSSjUxhmubxFQGD69qb4Mt
 U=
X-Received: by 2002:a17:907:d9e:b0:96f:4225:9003 with SMTP id
 go30-20020a1709070d9e00b0096f42259003mr729898ejc.4.1684410026935; 
 Thu, 18 May 2023 04:40:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/IhLbscUkcegVhXotwLaPmO3r1rpi0JpNchQFEb3fxrUj6uSDGxUjmM5pTzz8hk5C4Zl53Q==
X-Received: by 2002:a17:907:d9e:b0:96f:4225:9003 with SMTP id
 go30-20020a1709070d9e00b0096f42259003mr729880ejc.4.1684410026411; 
 Thu, 18 May 2023 04:40:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a170906125400b009571293d6acsm856634eja.59.2023.05.18.04.40.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:40:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
Date: Thu, 18 May 2023 13:40:24 +0200
Message-Id: <20230518114025.1006732-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit d27e7c359330ba7020bdbed7ed2316cb4cf6ffc1:

  qapi/parser: Drop two bad type hints for now (2023-05-17 10:18:33 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to fe3ab4eb2de46076cbafcbc86b22e71ad24894c6:

  docs/devel: update build system docs (2023-05-18 13:35:28 +0200)

----------------------------------------------------------------
* kvm: enable dirty ring for arm64
* target/i386: new features
* target/i386: AVX fixes
* configure: create a python venv unconditionally
* meson: bump to 0.63.0 and move tests from configure
* meson: Pass -j option to sphinx
* drop support for Python 3.6
* fix check-python-tox
* fix "make clean" in the source directory

----------------------------------------------------------------
v2->v3:
        fix cut-and-paste typo in "build: move warning flag selection to meson"

Emanuele Giuseppe Esposito (2):
      target/i386: add support for FLUSH_L1D feature
      target/i386: add support for FB_CLEAR feature

Fabiano Rosas (1):
      meson: Pass -j option to sphinx

Gavin Shan (4):
      migration: Add last stage indicator to global dirty log
      kvm: Synchronize the backup bitmap in the last stage
      kvm: Add helper kvm_dirty_ring_init()
      kvm: Enable dirty ring for arm64

John Snow (23):
      python: update pylint configuration
      python: add mkvenv.py
      mkvenv: add better error message for broken or missing ensurepip
      mkvenv: add nested venv workaround
      mkvenv: add ensure subcommand
      mkvenv: add --diagnose option to explain "ensure" failures
      mkvenv: add console script entry point generation
      mkvenv: use pip's vendored distlib as a fallback
      mkvenv: avoid ensurepip if pip is installed
      mkvenv: work around broken pip installations on Debian 10
      tests/docker: add python3-venv dependency
      tests/vm: Configure netbsd to use Python 3.10
      tests/vm: add py310-expat to NetBSD
      python: add vendor.py utility
      configure: create a python venv unconditionally
      python/wheels: add vendored meson package
      configure: use 'mkvenv ensure meson' to bootstrap meson
      qemu.git: drop meson git submodule
      tests: Use configure-provided pyvenv for tests
      configure: move --enable-docs and --disable-docs back to configure
      configure: bootstrap sphinx with mkvenv
      configure: add --enable-pypi and --disable-pypi
      configure: Add courtesy hint to Python version failure message

Paolo Bonzini (33):
      target/i386: fix operand size for VCOMI/VUCOMI instructions
      tests/tcg/i386: correct mask for VPERM2F128/VPERM2I128
      tcg: round-robin: do not use mb_read for rr_current_cpu
      coverity: the definitive COMPONENTS.md update
      scsi-generic: fix buffer overflow on block limits inquiry
      python: shut up "pip install" during "make check-minreqs"
      Python: Drop support for Python 3.6
      mkvenv: mark command as required
      python: bump some of the dependencies
      meson: regenerate meson-buildoptions.sh
      meson: require 0.63.0
      meson: use prefer_static option
      meson: remove static_kwargs
      meson: add more version numbers to the summary
      meson: drop unnecessary declare_dependency()
      build: move glib detection and workarounds to meson
      configure: remove pkg-config functions
      configure, meson: move --enable-modules to Meson
      meson: prepare move of QEMU_CFLAGS to meson
      build: move sanitizer tests to meson
      build: move SafeStack tests to meson
      build: move coroutine backend selection to meson
      build: move stack protector flag selection to meson
      build: move warning flag selection to meson
      build: move remaining compiler flag tests to meson
      build: move compiler version check to meson
      build: move --disable-debug-info to meson
      configure: remove compiler sanity check
      configure: do not rerun the tests with -Werror
      configure: remove unnecessary mkdir
      configure: reorder option parsing code
      configure: remove unnecessary check
      docs/devel: update build system docs

Ricky Zhou (3):
      target/i386: Fix and add some comments next to SSE/AVX instructions.
      target/i386: Fix exception classes for SSE/AVX instructions.
      target/i386: Fix exception classes for MOVNTPS/MOVNTPD.

Steve Sistare (1):
      make: clean after distclean deletes source files

Xinyu Li (1):
      target/i386: fix avx2 instructions vzeroall and vpermdq

 .gitlab-ci.d/buildtest-template.yml                |   4 +-
 .gitlab-ci.d/buildtest.yml                         |   6 +-
 .gitmodules                                        |   3 -
 Makefile                                           |   6 +-
 accel/kvm/kvm-all.c                                | 108 ++-
 accel/tcg/tcg-accel-ops-rr.c                       |  11 +-
 configure                                          | 980 ++++-----------------
 contrib/plugins/Makefile                           |   7 +-
 docs/about/build-platforms.rst                     |   2 +-
 docs/conf.py                                       |   9 -
 docs/devel/acpi-bits.rst                           |   6 +-
 docs/devel/build-system.rst                        | 296 ++++---
 docs/devel/testing.rst                             |  14 +-
 docs/meson.build                                   |  14 +-
 docs/sphinx/dbusdomain.py                          |   4 +
 docs/sphinx/fakedbusdoc.py                         |   5 +
 docs/sphinx/qmp_lexer.py                           |   5 +
 hw/scsi/scsi-generic.c                             |  14 +-
 include/exec/memory.h                              |   9 +-
 include/sysemu/kvm_int.h                           |   1 +
 meson                                              |   1 -
 meson.build                                        | 661 +++++++++-----
 meson_options.txt                                  |  15 +-
 migration/dirtyrate.c                              |   4 +-
 migration/ram.c                                    |  20 +-
 python/Makefile                                    |  19 +-
 python/scripts/mkvenv.py                           | 897 +++++++++++++++++++
 python/scripts/vendor.py                           |  74 ++
 python/setup.cfg                                   |  46 +-
 python/tests/flake8.sh                             |   1 +
 python/tests/isort.sh                              |   1 +
 python/tests/minreqs.txt                           |  19 +-
 python/tests/mypy.sh                               |   1 +
 python/tests/pylint.sh                             |   1 +
 python/wheels/meson-0.63.3-py3-none-any.whl        | Bin 0 -> 926526 bytes
 qga/meson.build                                    |   2 +-
 scripts/ci/org.centos/stream/8/x86_64/test-avocado |   4 +-
 scripts/coverity-scan/COMPONENTS.md                |  45 +-
 scripts/device-crash-test                          |   2 +-
 scripts/meson-buildoptions.py                      |   3 +
 scripts/meson-buildoptions.sh                      |  31 +-
 scripts/qapi/mypy.ini                              |   2 +-
 softmmu/memory.c                                   |  10 +-
 target/i386/cpu.c                                  |   4 +-
 target/i386/cpu.h                                  |   3 +
 target/i386/ops_sse.h                              |   8 +
 target/i386/tcg/decode-new.c.inc                   |  90 +-
 target/i386/tcg/emit.c.inc                         |   2 +-
 tcg/meson.build                                    |   2 +-
 tests/Makefile.include                             |  10 +-
 .../dockerfiles/debian-all-test-cross.docker       |   3 +-
 .../docker/dockerfiles/debian-hexagon-cross.docker |   3 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   3 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   3 +-
 tests/qemu-iotests/meson.build                     |   2 +-
 tests/qtest/meson.build                            |   2 +-
 tests/requirements.txt                             |   7 +-
 tests/tcg/i386/test-avx.py                         |   2 +-
 tests/unit/meson.build                             |   2 +-
 tests/vm/netbsd                                    |   2 +
 util/{coroutine-win32.c => coroutine-windows.c}    |   0
 util/meson.build                                   |   6 +-
 62 files changed, 2165 insertions(+), 1352 deletions(-)
 delete mode 160000 meson
 create mode 100644 python/scripts/mkvenv.py
 create mode 100755 python/scripts/vendor.py
 create mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
 rename util/{coroutine-win32.c => coroutine-windows.c} (100%)
-- 
2.40.1


