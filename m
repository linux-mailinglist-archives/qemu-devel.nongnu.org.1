Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92145707DDF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:17:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzahB-0005z8-Sj; Thu, 18 May 2023 06:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzah6-0005yV-Cr
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzah4-0004Ys-9V
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1TO2JDxIU5a7YqEpIoZkpy8bz37L0aY31+3C73UYAf4=;
 b=AGhUqIklABlLb3b0agA132x8tX/tecginaK5PByKKWhrOPBBS5xH4DNGLQHjs0hCDSO7fz
 AJqX8yktJQqPrBosmwV7vSpq1RK8w3ucMhnOuYb8rJ9Dc5vh4ZI8SE3B2PwzGYn4W8zCr4
 xMGMV4dPivZhxf2t6Y/u9dPAwLJ3F9c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-pgIH_Nk3O_e-tp3kLv2thg-1; Thu, 18 May 2023 06:17:06 -0400
X-MC-Unique: pgIH_Nk3O_e-tp3kLv2thg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-510d8e4416cso1829260a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405024; x=1686997024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1TO2JDxIU5a7YqEpIoZkpy8bz37L0aY31+3C73UYAf4=;
 b=Ethet+KzuKvR+jV7947wPbdyYkGW5vENHjDNp5qIZeA9+cprNuRN3YriE93ZeV5vEu
 5S4TJLepmtyqwTdx7M+2IL7/FfenC3NPXXQ+cfo6g/x7wKlSW4TGuzoBzDLjkxAmbGHV
 KNDU/4dhn55sgNp7iRgCinHto8eelPNW8yfumR/sLFATjdZhDnlTikoGRSzIvRjW70kM
 tPKZIQmwK9XpLqMxGvqha4hiXx3ztsFinhfyu7HTyLF86ZSa217SwDnAzl5SjNj1p/ci
 +wJE3dxbr66SQLTBpjkbeXE1WYBHtoMJG5yEU6MaGkhSo9hxq9GfIz3AQB2bxcR0VP1A
 Gw5A==
X-Gm-Message-State: AC+VfDxOabAmIxs7BXC8j/NG8alImOv0P4O7WI+P7SFj/Cb80jg4ySxg
 eXtE/SRa4zAe7XTtXtkytyXBYKbIp5XdJXCIYXGBSqYFh0PL0iX9zW4ZVLtnnFAB99OHmcbkZkH
 IvBighHnyunKlK1GvDjx0baZI1ZZYQnr+kcCDkS5rm9E1uO/4onT+G/CgwT1Vld9e3+k4WoCrlX
 4=
X-Received: by 2002:a17:907:8691:b0:96a:b504:58ad with SMTP id
 qa17-20020a170907869100b0096ab50458admr17906314ejc.5.1684405024639; 
 Thu, 18 May 2023 03:17:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47OEbuu4/lmCNkCTToYzqGWVoVppDbAYr1k1EENL/k6TqlQqGIcLcI+T0iLSRtFUhfAuMGjg==
X-Received: by 2002:a17:907:8691:b0:96a:b504:58ad with SMTP id
 qa17-20020a170907869100b0096ab50458admr17906296ejc.5.1684405024128; 
 Thu, 18 May 2023 03:17:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 n8-20020aa7c448000000b00509d1c6dcefsm403451edr.13.2023.05.18.03.17.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:17:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/59] i386, build system, KVM changes for 2023-05-18
Date: Thu, 18 May 2023 12:17:01 +0200
Message-Id: <20230518101702.991996-1-pbonzini@redhat.com>
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

for you to fetch changes up to 43663e2f0acc8f56126537c914637b3b32f5a752:

  build: move warning flag selection to meson (2023-05-18 08:53:52 +0200)

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

v1->v2:
        required sphinx-rtd-theme 0.5.0
        interrupted series at likely breakage point

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

Paolo Bonzini (24):
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
 configure                                          | 699 +++-------------
 contrib/plugins/Makefile                           |   7 +-
 docs/about/build-platforms.rst                     |   2 +-
 docs/conf.py                                       |   9 -
 docs/devel/acpi-bits.rst                           |   6 +-
 docs/devel/build-system.rst                        |  11 +-
 docs/devel/testing.rst                             |  14 +-
 docs/meson.build                                   |  14 +-
 docs/sphinx/dbusdomain.py                          |   4 +
 docs/sphinx/fakedbusdoc.py                         |   5 +
 docs/sphinx/qmp_lexer.py                           |   5 +
 hw/scsi/scsi-generic.c                             |  14 +-
 include/exec/memory.h                              |   9 +-
 include/sysemu/kvm_int.h                           |   1 +
 meson                                              |   1 -
 meson.build                                        | 591 +++++++++-----
 meson_options.txt                                  |  15 +-
 migration/dirtyrate.c                              |   4 +-
 migration/ram.c                                    |  20 +-
 python/Makefile                                    |  19 +-
 python/scripts/mkvenv.py                           | 897 +++++++++++++++++++++
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
 scripts/meson-buildoptions.py                      |   1 +
 scripts/meson-buildoptions.sh                      |  28 +-
 scripts/qapi/mypy.ini                              |   2 +-
 softmmu/memory.c                                   |  10 +-
 target/i386/cpu.c                                  |   4 +-
 target/i386/cpu.h                                  |   3 +
 target/i386/ops_sse.h                              |   8 +
 target/i386/tcg/decode-new.c.inc                   |  90 ++-
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
 62 files changed, 1847 insertions(+), 1029 deletions(-)
 delete mode 160000 meson
 create mode 100644 python/scripts/mkvenv.py
 create mode 100755 python/scripts/vendor.py
 create mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
 rename util/{coroutine-win32.c => coroutine-windows.c} (100%)
-- 
2.40.1


