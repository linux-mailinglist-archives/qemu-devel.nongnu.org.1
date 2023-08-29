Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A900978C975
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1NZ-0004mQ-Mq; Tue, 29 Aug 2023 12:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NP-0004lh-TW
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NL-0004NI-QX
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso2325523f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325729; x=1693930529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSJH+ZasLhVsZE5dwPT8pz3+Mk05fhAlnGZgRttVJr8=;
 b=IBaaKLcuL7QuoNghWxdyJoQXFHwcLL7pkO10tdx0nWpFvqEZCZygGve+VSg9vuP9fD
 IEzyaRxafn8CMB3amYLyA3HA3M/gyGBy3hFGR5iGYAM2qb+bX1FQByweO0S++9jytJeX
 FrL5WcKyQutWzWx6ZaXVb9L4T56bbkDi7QW++ENB+R/PXHCxu7fggSiVYXAy4IU94XLm
 XMo/A6g6kjRKXfM19Y3hIXFIh6z+4/RUKy4Nv9QujapdVD0Te27ML0+fC55a4K9sgf+T
 tyrBDuxyTs4NXvMWm/0TQTz+jEc3KGHlTTWlMrUMZbX+5cdiAg0WJ3U8+qWXegvr4a0d
 M11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325729; x=1693930529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSJH+ZasLhVsZE5dwPT8pz3+Mk05fhAlnGZgRttVJr8=;
 b=edH/2CbzdPFi1T0NBCWg5n9DANWgA/17ft8IuMI2if3SMfDUdbdtX3tZXFPEN5u3Ot
 Jaa5K0jyCh7lCRQEg2ivyYVdR2cicXw/3Ewu4GhEEa1FXGyy07B4Bi6994nMVuJ+Cxgm
 NE2vNAs2eph1fVU5caX2LmDPsC0C/CTn84wKaQ218Td+gLCvftntgoO/RpRiwiTIFC7F
 VBMPPUjnRvjUoBJ+ICSpBgVhA0d9N7xY1lqSKpEsJVWP9UhigLlkNtwuL440mY1/uR4/
 Mk1woioPgOSwzRvs/H2Pj/bkf/lyV0ZSBpNnnmTqXXUQu39qTF9cuGYzdk1h/pXIaDSd
 6qIQ==
X-Gm-Message-State: AOJu0YyUxKjkyAPvfzR7ayHAgGp87/VGyHa9Br4ohPmkh6aAY1iBaka7
 NJBjm10ODKYK5s/KVaVvOJkSGw==
X-Google-Smtp-Source: AGHT+IECfeeuUUhswvD3N2cg2jbDcK5tLe2uHZL5oIVb9KkMBvqKajlq7KFWSF29mxPdr5yFvpnHBQ==
X-Received: by 2002:a5d:4a90:0:b0:31c:6420:ff4 with SMTP id
 o16-20020a5d4a90000000b0031c64200ff4mr15950509wrq.36.1693325729680; 
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4c48000000b003140f47224csm14130762wrt.15.2023.08.29.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 38D301FFBB;
 Tue, 29 Aug 2023 17:15:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 00/12] gdbstub and testing fixes for 8.2 (pre-PR)
Date: Tue, 29 Aug 2023 17:15:16 +0100
Message-Id: <20230829161528.2707696-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

This is the current state for my maintainer queue my first 8.2 PR now
the tree is open. It includes the previous testing/next fixes as well
as some more cleanups to modernise the gdbstub tests and code. It also
includes Matheus' fixes for SIGINT.

v3
  - added r-b tags
  - review comments for get_feature_xml

I'd like to send the PR this week so please review the following patches:

 - gdbstub: refactor get_feature_xml
 - tests: remove test-gdbstub.py
 - tests/tcg: remove quoting for info output

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
 gdbstub/gdbstub.c                             | 144 ++++++++------
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
 30 files changed, 324 insertions(+), 295 deletions(-)
 create mode 100644 tests/tcg/multiarch/system/interrupt.c
 delete mode 100644 tests/guest-debug/test-gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/interrupt.py

-- 
2.39.2


