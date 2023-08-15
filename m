Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5E77CE85
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOU-0005m5-F6; Tue, 15 Aug 2023 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOS-0005kV-Kv
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:36 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOM-0006FZ-07
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:36 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fe9f226cdbso4676862e87.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111088; x=1692715888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qeUKY95QFqLo9QI2QA4rRd/AuW9ucHYdf8Xoc9W9FlA=;
 b=GXWfbueubvYAOiYK/OrcZf1vmU5gfUCz6BJqSxtf2DfgaaM+9W2+u6WEDqTlzZCJ0c
 H6GrBOr7Bnxj539wF0Ha7mxtSoU2/yE3618XwR18m2fs/Qo9niB+e18eTcER4JZR55UK
 OkFBiy87ujOaJu75Efq9ggWkpqbs1LRU9ranCCw8VAQMhcS1O/lJ6OjXJWl31//+8mx3
 VLV4XfyVUDD35h9PR/nSvNcfdjrFFMGWcYDRTvRBsitica+GDPQefF2hXtDk6Z325SVK
 zVL5EWm2q2bUWHcyCrJ1OdAt/wfEidYsm/RIO9SoGUdrY0lzLd0PpNas8pB1A7k5X4f9
 Y4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111088; x=1692715888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qeUKY95QFqLo9QI2QA4rRd/AuW9ucHYdf8Xoc9W9FlA=;
 b=ZrVvkynbxu3fq8z3YVsJT6K1OYfFLcTZbPMVBAG5liM7Y8gVRd2hgDXHRp8ipX+H8F
 JzM+kFkE/3V7BGfmwxXU41uI+Cy3Dd8jgfPU3gR19lCvsK94I9B16ELG5HVCKLwVIEbH
 ihu7UJJiTR8+bizwLl2qeclkNR8b4G1REqHj2aKMNVzogxcfQlrhdLsWJyy/T5GVXAMz
 b8OV6S0hISrB+f00AGYs44H0YFzBsGRoCk3QI9WLLx1cA/ZANh55T4/0BFkxJy6hJPux
 j68pwN7egY+Ggs789MLHYgUoZCaJlHQRcDxjLeeaBGOOOyQ6cTgcGJSCaFsa0NNVU4OG
 4qqQ==
X-Gm-Message-State: AOJu0YyBs4UpV3IjbH29hHz6D1iobmF/QT9DzRqeYr8sdD8qmJjCmaAA
 NwD6fHD4Ijv6VQaCxFojF7XROA==
X-Google-Smtp-Source: AGHT+IGxD611crhe6HAnbexcSNyZ6kMdKFZuQ4m+mXMlCS0E7qrCrBe1OjLpiRL751nyWAaFBMzZAQ==
X-Received: by 2002:a05:6512:3c87:b0:4fb:cb10:64d0 with SMTP id
 h7-20020a0565123c8700b004fbcb1064d0mr11091970lfv.29.1692111087593; 
 Tue, 15 Aug 2023 07:51:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a22-20020a05600c225600b003fe20db88ebsm18117157wmm.31.2023.08.15.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C513C1FFBB;
 Tue, 15 Aug 2023 15:51:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/9] gdbstub and testing fixes for 8.2
Date: Tue, 15 Aug 2023 15:51:17 +0100
Message-Id: <20230815145126.3444183-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

This is the current state for my maintainer queue for when the tree
re-opens. It includes the previous testing/next fixes as well as some
more cleanups to modernise the gdbstub tests and code. It also
includes Matheus' fixes for SIGINT.

The following patches need review:

  gdbstub: replace global gdb_has_xml with a function
  gdbstub: refactor get_feature_xml
  gdbstub: remove unused user_ctx field
  tests/tcg: clean-up gdb confirm/pagination settings
  tests: remove test-gdbstub.py
  tests/tcg: remove quoting for info output

Alex Bennée (7):
  tests/docker: cleanup non-verbose output
  tests/tcg: remove quoting for info output
  tests: remove test-gdbstub.py
  tests/tcg: clean-up gdb confirm/pagination settings
  gdbstub: remove unused user_ctx field
  gdbstub: refactor get_feature_xml
  gdbstub: replace global gdb_has_xml with a function

Daniel P. Berrangé (1):
  gitlab: enable ccache for many build jobs

Matheus Branco Borella (1):
  gdbstub: fixes cases where wrong threads were reported to GDB on
    SIGINT

 docs/devel/ci-jobs.rst.inc                    |   7 +
 gdbstub/internals.h                           |   3 +-
 include/exec/gdbstub.h                        |  10 +-
 gdbstub/gdbstub.c                             | 119 +++++++-----
 gdbstub/softmmu.c                             |   1 -
 gdbstub/user.c                                |   1 -
 target/arm/gdbstub.c                          |   8 +-
 target/ppc/gdbstub.c                          |   4 +-
 tests/tcg/multiarch/system/interrupt.c        |  28 +++
 .gitlab-ci.d/buildtest-template.yml           |  11 ++
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
 28 files changed, 293 insertions(+), 280 deletions(-)
 create mode 100644 tests/tcg/multiarch/system/interrupt.c
 delete mode 100644 tests/guest-debug/test-gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/interrupt.py

-- 
2.39.2


