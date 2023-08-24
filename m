Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF67875AF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:41:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMf-0006Ep-4Q; Thu, 24 Aug 2023 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMc-0006Ch-FE
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMY-00085n-21
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso232715e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895152; x=1693499952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YycZVtWAqh18UOqjLgbCV/FJBbrD5YwStlZMfvKCjE0=;
 b=Zz52aMwH9B/gof9vivVLZUmAM+z37uZc7HljnuRlFJuq4X+Y/662SXeGi6pV76eE5/
 Jhbv3fcYJomvRz/2xWoriIDLC9pi5uM2ILGFGTRUBZToa9Vo6FGHNDyPOC++cEXuElJY
 ONYu3hYjZBnv9QH7bz85dG3UpQE3S8j0QCK4mIAZON0KlE9LwyPOUyIezhzJJ5GQ+r6t
 /+nHrzH0R9CfUfN33a5NWkIODGajVvkF/HQTmg6gkycoeq3ARvJZMHp21dfOioBNXyHY
 7nQ6WXfpvKQ9bZQ6nQg2sGnEox2KyhZLJnNKEYlwAtESk+KfmxGKJYIPy7R43XqXkAvp
 uAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895152; x=1693499952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YycZVtWAqh18UOqjLgbCV/FJBbrD5YwStlZMfvKCjE0=;
 b=HWkF6XHR7iWbyUnYAVtOHWqH1mxpTXYYCf6hBIS55Lcfn/k28fyDkG4Vq6cfZOdbUK
 6UINYn9lhIoEYIf/aqq3nZggIHGCriDkEcwmFyNIJIf2h8bw5swAPfYOOg/9i2iE5zAj
 orCRfyvyTKE36AsBBOXOuPn4Nc/jvJ5gWarE1bj5y0VjeakL9xgMhIHvFpS4ZPO2j76f
 vqV4+U8EtKcbI7AUDm35vKrE47jR6wX4K2wPGe5y7do/QxuvgHzVL7ZU0JXifLEhfu+n
 OOUH28pGAnGCtgkIe10agr894yQwdLtlZWGjXvEs8qEtOi8Wy97AN6uxGn8rvgTC0nNM
 qHgA==
X-Gm-Message-State: AOJu0Yx66PalcXduBGoQqme/vGc8Mu/UyFUHKYgvs05oVnAIx/eSK71b
 k0SzHbPOdpQ8gsM/t5+TjKZHsQ==
X-Google-Smtp-Source: AGHT+IHO+LXhU2xth7rsbqe2CiuhrJ7bIX6JGE+Ggg1UZ8gJF4Kbq+LHfWtIQqPns3YleOM5SWMMhg==
X-Received: by 2002:a05:600c:204:b0:3fc:7eb:1119 with SMTP id
 4-20020a05600c020400b003fc07eb1119mr12188286wmi.15.1692895152160; 
 Thu, 24 Aug 2023 09:39:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a5d4647000000b0031c4d4be245sm13660014wrs.93.2023.08.24.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 32BD81FFBB;
 Thu, 24 Aug 2023 17:39:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 00/12] gdbstub and testing fixes for 8.2
Date: Thu, 24 Aug 2023 17:38:58 +0100
Message-Id: <20230824163910.1737079-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

This is the current state for my maintainer queue getting ready for
the first PR into the tree. It includes the previous testing/next
fixes as well as some more cleanups to modernise the gdbstub tests and
code. It also includes Matheus' fixes for SIGINT.

v2
  - added style patch
  - added comment move for gdbstub

The following patches still need review:

  gdbstub: move comment for gdb_register_coprocessor
  gdbstub: replace global gdb_has_xml with a function
  gdbstub: refactor get_feature_xml
  gdbstub: remove unused user_ctx field (1 acks, 1 sobs, 0 tbs)
  tests: remove test-gdbstub.py
  tests/tcg: remove quoting for info output

Alex Bennée (9):
  tests/docker: cleanup non-verbose output
  tests/tcg: remove quoting for info output
  docs/style: permit inline loop variables
  tests: remove test-gdbstub.py
  tests/tcg: clean-up gdb confirm/pagination settings
  gdbstub: remove unused user_ctx field
  gdbstub: refactor get_feature_xml
  gdbstub: replace global gdb_has_xml with a function
  gdbstub: move comment for gdb_register_coprocessor

Daniel P. Berrangé (1):
  gitlab: enable ccache for many build jobs

Matheus Branco Borella (1):
  gdbstub: fixes cases where wrong threads were reported to GDB on
    SIGINT

Thomas Huth (1):
  .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2

 docs/devel/ci-jobs.rst.inc                    |   7 +
 docs/devel/style.rst                          |   9 +-
 gdbstub/internals.h                           |   3 +-
 include/exec/gdbstub.h                        |  20 +-
 gdbstub/gdbstub.c                             | 126 ++++++++-----
 gdbstub/softmmu.c                             |   1 -
 gdbstub/user.c                                |   1 -
 target/arm/gdbstub.c                          |   8 +-
 target/ppc/gdbstub.c                          |   4 +-
 tests/tcg/multiarch/system/interrupt.c        |  28 +++
 .gitlab-ci.d/buildtest-template.yml           |  11 ++
 .gitlab-ci.d/cirrus.yml                       |   2 +-
 .gitlab-ci.d/crossbuild-template.yml          |  26 +++
 .gitlab-ci.d/windows.yml                      |  13 +-
 tests/docker/Makefile.include                 |   6 +-
 .../dockerfiles/debian-hexagon-cross.docker   |   9 +-
 tests/guest-debug/run-test.py                 |   2 +
 tests/guest-debug/test-gdbstub.py             | 177 ------------------
 tests/tcg/aarch64/Makefile.target             |   2 +-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   |   3 -
 tests/tcg/aarch64/gdbstub/test-sve.py         |   3 -
 tests/tcg/multiarch/gdbstub/interrupt.py      |  97 ++++++++++
 tests/tcg/multiarch/gdbstub/memory.py         |   3 -
 tests/tcg/multiarch/gdbstub/sha1.py           |   4 -
 .../multiarch/gdbstub/test-proc-mappings.py   |   4 -
 .../multiarch/gdbstub/test-qxfer-auxv-read.py |   4 -
 .../gdbstub/test-thread-breakpoint.py         |   4 -
 .../multiarch/system/Makefile.softmmu-target  |  16 +-
 tests/tcg/s390x/gdbstub/test-signals-s390x.py |   4 -
 tests/tcg/s390x/gdbstub/test-svc.py           |   4 -
 30 files changed, 312 insertions(+), 289 deletions(-)
 create mode 100644 tests/tcg/multiarch/system/interrupt.c
 delete mode 100644 tests/guest-debug/test-gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/interrupt.py

-- 
2.39.2


