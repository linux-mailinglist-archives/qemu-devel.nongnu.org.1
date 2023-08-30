Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41F78D6B0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaH-0001Az-MM; Wed, 30 Aug 2023 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaD-00018o-Ai
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaA-0000jF-3T
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so4868598f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407248; x=1694012048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zxgkBb7DJJfjgi9PnSBvQheX29hpWVTyPV3mYxBd8Yk=;
 b=KO/sg0Df9hE+IosGIqEAw7YuICclzbQ47EkvgtfQMAULx94A8+6xhVPpuDjwOOgjyW
 SQr3OwvjdX5sPbn198H+HNSB0aalDd/dN4qt8rMslhN1nbfZ+MUOY1yjrZvO/MvMRU7K
 wD2McbB6FK37fb08qqCE4EvwM0CdPlHW54XzT/Wk4wQK7ku1bvvr+J0cJVUky7X+vaBd
 4z/H+TaVJMrm3ZP5yUMXlkshsorMOImLdlEYDiaCsEHZbDrdZ9UsKypTN27AyLElplXK
 rYRZcKBez+QM/k4PBH2AyGvLjLzEMeQ92rNO0Srh5kV3ACwZxNvnT2Vj9MyxhiTSPA4a
 WvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407248; x=1694012048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxgkBb7DJJfjgi9PnSBvQheX29hpWVTyPV3mYxBd8Yk=;
 b=DIBrSug6FLL5pqP+Yu6C5SKWTaY2WrpUh5ojU8Kf0lqzAI53Vone/DrsbxgqWmnsRE
 p0oX5L8b+P7lV0+Z3XTKbhIIsxaHzqQYckwXVRPf8sIywkKbRz9mOZPy5ym2VvCgoB9U
 3JNlHxQPYVEjrUzWrmV8Y06Nu320sfNntQsvg7uIVLQvPuPt1Oz42vpZwj6e+QCLZ5uN
 FSgKq/RGyvVdpuaqRfJGrLm9bMI1Iyl7fKTmkPD8h8KEyGedXnqbd8RycmGwfSJ9ODp1
 8/ARuTsNTVifbFRbR0SARC4EDdzFIPgx7x8FrDcnmCc0yFnovy5QM0u6ZXyC5wtZAvoa
 +uuw==
X-Gm-Message-State: AOJu0Yzwpgh6l8PrgAk4s4JR2319ZH6lLkmsjq5pQphr8UxVYW/73WhW
 7YfZxvlpKCV4v5VPnPDDkQSyGA==
X-Google-Smtp-Source: AGHT+IHfk/nVoB3ZH7gsKUpSVneIILtsTunrJxEpeAaPbBGMLb2NOu/foWT3xflqUiZBsupybEVpjQ==
X-Received: by 2002:a5d:6305:0:b0:30e:3caa:971b with SMTP id
 i5-20020a5d6305000000b0030e3caa971bmr1714734wru.51.1693407248335; 
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a5d51ce000000b0031ad5470f89sm16909153wrv.18.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9AF351FFBB;
 Wed, 30 Aug 2023 15:54:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/12] testing and gdbstub updates
Date: Wed, 30 Aug 2023 15:53:55 +0100
Message-Id: <20230830145407.3064249-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:

  Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-300823-1

for you to fetch changes up to 8dd7a4b3487ab93ff8fddc5f818942ff39d4550f:

  gdbstub: move comment for gdb_register_coprocessor (2023-08-30 14:57:59 +0100)

----------------------------------------------------------------
testing and gdbstub updates:

  - enable ccache for gitlab builds
  - fix various test info leakages for non V=1
  - update style to allow loop vars
  - bump FreeBSD to v13.2
  - clean-up gdbstub tests
  - various gdbstub doc and refactorings

----------------------------------------------------------------
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
      gdbstub: fixes cases where wrong threads were reported to GDB on SIGINT

Thomas Huth (1):
      .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2

 docs/devel/ci-jobs.rst.inc                         |   7 +
 docs/devel/style.rst                               |   9 +-
 gdbstub/internals.h                                |   3 +-
 include/exec/gdbstub.h                             |  20 ++-
 gdbstub/gdbstub.c                                  | 144 ++++++++++-------
 gdbstub/softmmu.c                                  |   1 -
 gdbstub/user.c                                     |   1 -
 target/arm/gdbstub.c                               |   8 +-
 target/ppc/gdbstub.c                               |   4 +-
 tests/tcg/multiarch/system/interrupt.c             |  28 ++++
 .gitlab-ci.d/buildtest-template.yml                |  11 ++
 .gitlab-ci.d/cirrus.yml                            |   2 +-
 .gitlab-ci.d/crossbuild-template.yml               |  26 +++
 .gitlab-ci.d/windows.yml                           |  13 +-
 tests/docker/Makefile.include                      |   6 +-
 .../docker/dockerfiles/debian-hexagon-cross.docker |   9 +-
 tests/guest-debug/run-test.py                      |   2 +
 tests/guest-debug/test-gdbstub.py                  | 177 ---------------------
 tests/tcg/aarch64/Makefile.target                  |   2 +-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py        |   3 -
 tests/tcg/aarch64/gdbstub/test-sve.py              |   3 -
 tests/tcg/multiarch/gdbstub/interrupt.py           |  97 +++++++++++
 tests/tcg/multiarch/gdbstub/memory.py              |   3 -
 tests/tcg/multiarch/gdbstub/sha1.py                |   4 -
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py  |   4 -
 .../tcg/multiarch/gdbstub/test-qxfer-auxv-read.py  |   4 -
 .../multiarch/gdbstub/test-thread-breakpoint.py    |   4 -
 tests/tcg/multiarch/system/Makefile.softmmu-target |  16 +-
 tests/tcg/s390x/gdbstub/test-signals-s390x.py      |   4 -
 tests/tcg/s390x/gdbstub/test-svc.py                |   4 -
 30 files changed, 324 insertions(+), 295 deletions(-)
 create mode 100644 tests/tcg/multiarch/system/interrupt.c
 delete mode 100644 tests/guest-debug/test-gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/interrupt.py

-- 
2.39.2


