Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8387DCF88
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:45:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyT-0004mv-B2; Tue, 31 Oct 2023 10:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyR-0004lp-44
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:07 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyO-00026u-Q5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:06 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so84232711fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763443; x=1699368243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfvlvqawlXGtKtC3BXTxlqpbSIo4WFWq89L+fFkxV3k=;
 b=wofQB9XyYHu/cDELnNB058YUiuuYLpeqwsP+qgg0qws9wmSwpqsp7dSd7eH3vE/XFe
 LaIYNSELkapqKfI4uC9XVFGnhhNZSa72OUst/VyInIJkLqLyKd3IX+8bwwuZEbVQaYg6
 6V0C6QNIW4b0ZH3rUVjXFgnyPrxtKzTqV3dbfZTM6hmrPkK88h2/aZ0/ZcQ6qyrPXPjx
 TOkysioGLvOPKlvsB03haqMMM5r257TMMKMXAUELzxkjTEjk+wseAjtKoWCix5k7UDt0
 2Y2GGs0wTdCIziuYE+VIVgkvYSMr60AlgVtxMRxOzu5LuEwTVhm5aGl6hv8OaMRLhRKC
 QPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763443; x=1699368243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfvlvqawlXGtKtC3BXTxlqpbSIo4WFWq89L+fFkxV3k=;
 b=qGyESOnPnpdbL+UMJ8mmwcqrXPZc+IRaHfIS76ZFNh70AeJRnGgsrZ9o8dXIp011ij
 ASd05Vv6KS4K14Pp6lFlpmtnbO7hk/5zW3AHV0lewVsCYZ4sOyWCxbah2maNtKdplmKw
 pRIh+Oqm1RHwwdrlYAssS0dkfrJYC+W+6DWIUaRPpsYr+c+kETNWvvd1TOBs3VqaQ8mY
 O/2w1smWNGnmOJF92vlHiUVZSW6GjzRjAVquppsVxKnPF/NPabVPA13Ylxv+Zhqx4qrp
 mmOWCXVH86JRCNLjtve3re3uNKp2uu7OsY9+ovzika4iAPKsaXP8Ms/07b14MacOa1GT
 oLpA==
X-Gm-Message-State: AOJu0Yz6WYfZyWxiNSBhUKTe1qqzSBx/q9d836H5Z6kgN+xJUtUyv0/3
 rn/165gFqrgNxlE31oct0IBSPRtzDCC54P9Alt0=
X-Google-Smtp-Source: AGHT+IHTclmcLL1jMuJxnozPDh+st20PEK7/LY6igNuDTVibMPbZiWaLK4vG7xSZLQX30kxJsvH92A==
X-Received: by 2002:a2e:9f08:0:b0:2c5:1d9a:4dc1 with SMTP id
 u8-20020a2e9f08000000b002c51d9a4dc1mr9684696ljk.5.1698763442594; 
 Tue, 31 Oct 2023 07:44:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j28-20020a05600c1c1c00b003fe15ac0934sm970073wms.1.2023.10.31.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C423E65711;
 Tue, 31 Oct 2023 14:44:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/19] Updates for testing, gitlab, gdbstub,
 plugins and semihosting
Date: Tue, 31 Oct 2023 14:43:42 +0000
Message-Id: <20231031144401.1238210-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
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

The following changes since commit 516fffc9933cb21fad41ca8f7bf465d238d4d375:

  Merge tag 'pull-lu-20231030' of https://gitlab.com/rth7680/qemu into staging (2023-10-31 07:12:40 +0900)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-halloween-omnibus-311023-2

for you to fetch changes up to 7f4527626910f21c9e4421236ee7a6383eb3ce2b:

  contrib/plugins: Close file descriptor on error return (2023-10-31 14:10:21 +0000)

----------------------------------------------------------------
Maintainer updates for testing, gitlab, gdbstub and plugins:

  - add dtc package to openbsd VMs
  - use -fno-stack-protector for non-stdlib tests
  - split alpha and sh4 compilers into legacy image
  - harmonise other compilers into debian-all-test-cross
  - fix NULL check in gdb_regs
  - fix memleak in semihosting
  - remove unused parameter in plugin code
  - fix fd leak in lockstep plugin

----------------------------------------------------------------
Akihiko Odaki (3):
      tests/tcg: Add -fno-stack-protector
      gdbstub: Check if gdb_regs is NULL
      plugins: Remove an extra parameter

Alex Bennée (13):
      gitlab: split alpha testing into a legacy container
      gitlab: clean-up build-soft-softmmu job
      gitlab: add build-loongarch to matrix
      tests/docker: use debian-legacy-test-cross for alpha
      tests/docker: move sh4 to use debian-legacy-test-cross
      tests/docker: use debian-all-test-cross for power
      tests/docker: use debian-all-test-cross for hppa
      tests/docker: use debian-all-test-cross for m68k
      tests/docker: use debian-all-test-cross for mips64
      tests/docker: use debian-all-test-cross for mips
      tests/docker: use debian-all-test-cross for riscv64
      tests/docker: use debian-all-test-cross for sparc64
      tests/docker: upgrade debian-all-test-cross to bookworm

Cong Liu (1):
      contrib/plugins: Close file descriptor on error return

Matheus Tavares Bernardino (1):
      semihosting: fix memleak at semihosting_arg_fallback

Thomas Huth (1):
      tests/vm/openbsd: Use the system dtc package

 configure                                          | 38 ++++++++++++--
 accel/tcg/plugin-gen.c                             |  9 ++--
 contrib/plugins/lockstep.c                         |  2 +
 gdbstub/gdbstub.c                                  | 34 ++++++++-----
 semihosting/config.c                               |  3 +-
 tests/tcg/mips/hello-mips.c                        |  4 +-
 .gitlab-ci.d/buildtest.yml                         | 34 +++++++++++--
 .gitlab-ci.d/container-cross.yml                   | 59 +++-------------------
 tests/docker/Makefile.include                      |  8 ---
 .../dockerfiles/debian-all-test-cross.docker       | 26 +++++-----
 tests/docker/dockerfiles/debian-alpha-cross.docker | 19 -------
 tests/docker/dockerfiles/debian-hppa-cross.docker  | 19 -------
 .../dockerfiles/debian-legacy-test-cross.docker    | 49 ++++++++++++++++++
 .../dockerfiles/debian-loongarch-cross.docker      | 22 +++++++-
 tests/docker/dockerfiles/debian-m68k-cross.docker  | 19 -------
 tests/docker/dockerfiles/debian-mips-cross.docker  | 19 -------
 .../docker/dockerfiles/debian-mips64-cross.docker  | 19 -------
 .../dockerfiles/debian-powerpc-test-cross.docker   | 23 ---------
 .../dockerfiles/debian-riscv64-test-cross.docker   | 19 -------
 tests/docker/dockerfiles/debian-sh4-cross.docker   | 19 -------
 .../docker/dockerfiles/debian-sparc64-cross.docker | 19 -------
 tests/tcg/Makefile.target                          |  2 +-
 tests/tcg/aarch64/Makefile.target                  |  2 +-
 tests/tcg/arm/Makefile.target                      |  2 +-
 tests/tcg/cris/Makefile.target                     |  2 +-
 tests/tcg/hexagon/Makefile.target                  |  2 +-
 tests/tcg/i386/Makefile.target                     |  2 +-
 tests/tcg/minilib/Makefile.target                  |  2 +-
 tests/tcg/mips/Makefile.target                     |  2 +-
 tests/vm/openbsd                                   |  6 ++-
 30 files changed, 196 insertions(+), 289 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-hppa-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mips64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-powerpc-test-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-riscv64-test-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker

-- 
2.39.2


