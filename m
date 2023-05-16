Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57ED704B38
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysNQ-0007Wp-3S; Tue, 16 May 2023 06:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysNM-0007WT-Eo
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysNK-0007sC-GO
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMwjzMBAum8SbNhlTOfOESPXBYh7WPKYeyRrHca04hI=;
 b=GzT+dzvO8vdBLy8PEZuaTty8K6/PyFxYURlXihAT+TC2T1BbaRpYsWLiJWebSdtGUWQbD9
 h2vbigPUuOvs5JMKGRsZ4mzlyVhGGVQabx3HHfBSaztq13jmbjIQP81JXajBJn50gi/W5T
 Z9h826UhBlIgh7zylUANnBnABhpJ0H0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-uHkVlk7PO9SzYQjybC9HQA-1; Tue, 16 May 2023 06:57:47 -0400
X-MC-Unique: uHkVlk7PO9SzYQjybC9HQA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-50d89279d95so4525077a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684234666; x=1686826666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMwjzMBAum8SbNhlTOfOESPXBYh7WPKYeyRrHca04hI=;
 b=O9JJ606gT0+9CAA0MylTbhQByNQCSr3ksRzyYTbdYmoN5vJ/aMrFx+DKtUT7tJy8iS
 hcM/a+Y1xRQP0aIkNDyq+/LQnxkSXVuOf2pxW3oY3UcV7CPJg8f90zc5gFvfzJOVbkMV
 Rj/Os7kaJRa+Y8qxqUGa2PPu6gQH2BEj1nUdxUkeJpLF4kHixuFU+wmcUySLi+fROWTN
 EwJ9wr/u5M5Jdf2kCXA9d/VonXC1RVfHJOt0DsI5CXZK2bmGexAm1YtUBNawG2Uim58C
 wjCkbUkKdMVGHDUOMRsvXeJ+Q6tygwTs617/be2yL5Bt2RtjkBJ/IdkeeJNeQ8kcmIp8
 AwMw==
X-Gm-Message-State: AC+VfDz3anGDUstgm1w4la1jlB01lcJLxE+734QMGLGz8PQSZvCl0KDS
 tSAcs7EQg4MDnQNXW3tY4h1eGqDp9xEOC7qy+kqq52nmvEgL2Asr7ThSYhqd4Ax6wV2ejZecBU4
 Zod3M7ZZpg7vSb9OlWKYEp0RlKz88vwIRtwIZn7XV13Zo5ogBlNszRXJv2plqNYRp/wgjgJu1iI
 o=
X-Received: by 2002:a17:907:1691:b0:94e:b3a1:a3d5 with SMTP id
 hc17-20020a170907169100b0094eb3a1a3d5mr34115283ejc.21.1684234666051; 
 Tue, 16 May 2023 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LCF7PmFJfvpuEu1uoQbGsY8nce7tklTQ2LHRvkccJ6W1QKWCnos3qjFtwJwJWhqAybSqkEQ==
X-Received: by 2002:a17:907:1691:b0:94e:b3a1:a3d5 with SMTP id
 hc17-20020a170907169100b0094eb3a1a3d5mr34115266ejc.21.1684234665755; 
 Tue, 16 May 2023 03:57:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 jz20-20020a170906bb1400b0096a742beb68sm7176421ejb.201.2023.05.16.03.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 03:57:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 00/27] configure: create a python venv and ensure meson,
 sphinx
Date: Tue, 16 May 2023 12:57:10 +0200
Message-Id: <20230516105738.526631-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516105738.526631-1-pbonzini@redhat.com>
References: <20230516105738.526631-1-pbonzini@redhat.com>
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

This patch series creates a mandatory python virtual environment
("venv") during configure time and uses it to ensure the availability of
meson and sphinx.

See https://www.qemu.org/2023/03/24/python/ for motivations. The summary
is that the goal of this series is to ensure that the `python` used to
run meson is the same `python` used to run Sphinx, tests, and any
build-time python scripting we have. As it stands, meson and sphinx (and
their extensions) *may* run in a different python environment than the
one configured and chosen by the user at configure/build time.

The effective change of this series is that QEMU will now
unconditionally create a venv at configure-time and will ensure that
meson (and sphinx, if docs are enabled) are available through that venv.

Some important points as a pre-emptive "FAQ":

- Works for Python 3.6 and up, on Fedora, OpenSuSE, Red Hat, CentOS,
  Alpine, Debian, Ubuntu, NetBSD, OpenBSD, and hopefully everywhere
  No new dependencies (...for most platforms. Debian and NetBSD get an
  asterisk, see patch 4).

- The venv is unconditionally created and lives at {build_dir}/pyvenv.
  The python interpreter used by this venv is always the one identified
  by configure. (Which in turn is always the one specified by --python
  or $PYTHON).  --meson and --sphinx-build disappear.

- *almost* all python scripts in qemu.git executed as part of the build
  system, meson, sphinx, avocado tests, vm tests or CI are always
  executed within this venv.  iotests are not yet integrated.

- Missing dependencies, when possible, are fetched and installed
  on-demand automatically to make developer environments "just work".
  However, it remains possible to build and test fully offline.  Right
  now, online behavior is only triggered by --enable-docs, and even
  in that case...

- ... distribution packaged 'meson' and 'sphinx' are still utilized
  whenever possible as the highest preference.

- The bundled 'meson' takes the shape of a .whl file, replacing the
  git submodule.  qemu-qmp will follow suit, while Sphinx will not be
  bundled just like it already isn't.

- about 13% of the mkvenv.py script is devoted to supporting Python
  3.7 and Debian 10. ¯\_(ツ)_/¯

Tested with "make check-minreqs" after every patch and with GitLab at
https://gitlab.com/bonzini/qemu/-/pipelines/868627762.

Enjoy!

John and Paolo

v1->v2:
- integrate distlib for script generation and also to look up
  installed packages
- print a more precise error for --diagnose when running in an
  isolated venv
- reorganized code to avoid ensurepip, so that it is not spread
  across multiple patches
- made non-fatal errors a bit less scary


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

Paolo Bonzini (4):
  python: shut up "pip install" during "make check-minreqs"
  Python: Drop support for Python 3.6
  mkvenv: mark command as required
  python: bump some of the dependencies

 .gitlab-ci.d/buildtest-template.yml           |   4 +-
 .gitlab-ci.d/buildtest.yml                    |   6 +-
 .gitmodules                                   |   3 -
 configure                                     | 152 +--
 docs/about/build-platforms.rst                |   2 +-
 docs/conf.py                                  |   9 -
 docs/devel/acpi-bits.rst                      |   6 +-
 docs/devel/testing.rst                        |  14 +-
 docs/meson.build                              |   2 +-
 meson                                         |   1 -
 meson_options.txt                             |   2 -
 python/Makefile                               |  19 +-
 python/scripts/mkvenv.py                      | 897 ++++++++++++++++++
 python/scripts/vendor.py                      |  74 ++
 python/setup.cfg                              |  46 +-
 python/tests/flake8.sh                        |   1 +
 python/tests/isort.sh                         |   1 +
 python/tests/minreqs.txt                      |  19 +-
 python/tests/mypy.sh                          |   1 +
 python/tests/pylint.sh                        |   1 +
 python/wheels/meson-0.61.5-py3-none-any.whl   | Bin 0 -> 862509 bytes
 .../org.centos/stream/8/x86_64/test-avocado   |   4 +-
 scripts/device-crash-test                     |   2 +-
 scripts/meson-buildoptions.sh                 |   3 -
 scripts/qapi/mypy.ini                         |   2 +-
 tests/Makefile.include                        |  10 +-
 .../dockerfiles/debian-all-test-cross.docker  |   3 +-
 .../dockerfiles/debian-hexagon-cross.docker   |   3 +-
 .../dockerfiles/debian-riscv64-cross.docker   |   3 +-
 .../dockerfiles/debian-tricore-cross.docker   |   3 +-
 tests/requirements.txt                        |   7 +-
 tests/vm/netbsd                               |   2 +
 32 files changed, 1167 insertions(+), 135 deletions(-)
 delete mode 160000 meson
 create mode 100644 python/scripts/mkvenv.py
 create mode 100755 python/scripts/vendor.py
 create mode 100644 python/wheels/meson-0.61.5-py3-none-any.whl

-- 
2.40.1


