Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC958749D8C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOze-0005TN-S0; Thu, 06 Jul 2023 09:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzP-0004sJ-NA
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzL-0000qQ-QB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so7355805e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649914; x=1691241914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mo6lbSM2xrIR3d0xk5zr6GIHyKRZCcR8FqP58OQlFRA=;
 b=wT5pq6yBizCNCD9UTdWd2y16kFeQjSfAu/Ism3wd58NCmMT9NqdflZu+xduwsFFiVR
 BxYqsGMkChb1Fxbn++ap2gbd6g53U24t2SEfgMUDU/SaFyoBKpYToEK4f1RcGIjtp6Gq
 2DUDB1LioMEc9lwDEVJyDSrkubE35lgFxJ2AFxSjkt+EFGgQrwiR+sfroyGUI9Q8UhVq
 Sssc+P8ISegXYVqqBq1ZBRwDliBykUHtHuJeH2cQ++LuTM2MVQOo3RVFbwW8y42Pfh47
 ujCOzhIl2tDTi3lYESZfrCoKMw0ihkXQ7enuMyJ7KyJrU1lwI1GbiP/U5t6/F372dUm0
 3ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649914; x=1691241914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mo6lbSM2xrIR3d0xk5zr6GIHyKRZCcR8FqP58OQlFRA=;
 b=GHdgTjfxMlkspVl5vKqTYqmBx4bPPQ3hWE48QYhAz2AvqJTIygC2M3WbokO0/wtDYY
 8hNrWtXMG3gcR9Fjwd2Rau/6MQkbPVTA1/Lng+25l8BLSxOrZt4il+Taxu0YMq2OOCN7
 NqEqfKcRqyoRwbMQoLvLXtIKWquR+qdpJaI7VKrLsQ0nuQ9kkH2hugKmIGzJG7fnoEaM
 5yz6tAb3xLLkbYCxPCWgQPLkN6BDx//P5fv5vPsVj1JI1l2EYNmoDJ5tm5xyeoKZlfsf
 5SlBbC3o0AzA77qANa2p6jWllHYSRyXH9J20KF4w29lGwX7NE5+ELPKkp63h3G3R4bSn
 QtTg==
X-Gm-Message-State: ABy/qLY5FDYIEpQuUwUL1QOMFB2DQso/+vZN876jUCH6FGQfHL8m2yBT
 5seaUs9ywupTRSoJDP6VZiXJw1sF00mgQ9NoWTs=
X-Google-Smtp-Source: APBJJlG1Q5Df94FqtujlxaFcXddSNx40fUFU/hRZxGA6l6sU8xt3UnbnwfgyVNIzlcp1xdDHvSkEdA==
X-Received: by 2002:adf:f1cd:0:b0:313:f85f:6eac with SMTP id
 z13-20020adff1cd000000b00313f85f6eacmr1481000wro.12.1688649914312; 
 Thu, 06 Jul 2023 06:25:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/14] target-arm queue
Date: Thu,  6 Jul 2023 14:24:58 +0100
Message-Id: <20230706132512.3534397-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Changes v1->v2 (fixing CI failures in v1, added a couple of
extra patches in an attempt to avoid having to do a last
minute arm pullreq next week):
 * new patch to hopefully fix the build issue with the SVE/SME sysregs test
 * dropped the IC IVAU test case patch
 * new patch: fix over-length shift
 * new patches: define neoverse-v1

thanks
-- PMM

The following changes since commit 2a6ae69154542caa91dd17c40fd3f5ffbec300de:

  Merge tag 'pull-maintainer-ominbus-030723-1' of https://gitlab.com/stsquad/qemu into staging (2023-07-04 08:36:44 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230706

for you to fetch changes up to c41077235168140cdd4a34fce9bd95c3d30efe9c:

  target/arm: Avoid over-length shift in arm_cpu_sve_finalize() error case (2023-07-06 13:36:51 +0100)

----------------------------------------------------------------
target-arm queue:
 * Add raw_writes ops for register whose write induce TLB maintenance
 * hw/arm/sbsa-ref: use XHCI to replace EHCI
 * Avoid splitting Zregs across lines in dump
 * Dump ZA[] when active
 * Fix SME full tile indexing
 * Handle IC IVAU to improve compatibility with JITs
 * xlnx-canfd-test: Fix code coverity issues
 * gdbstub: Guard M-profile code with CONFIG_TCG
 * allwinner-sramc: Set class_size
 * target/xtensa: Assert that interrupt level is within bounds
 * Avoid over-length shift in arm_cpu_sve_finalize() error case
 * Define new 'neoverse-v1' CPU type

----------------------------------------------------------------
Akihiko Odaki (1):
      hw: arm: allwinner-sramc: Set class_size

Eric Auger (1):
      target/arm: Add raw_writes ops for register whose write induce TLB maintenance

Fabiano Rosas (1):
      target/arm: gdbstub: Guard M-profile code with CONFIG_TCG

John Högberg (1):
      target/arm: Handle IC IVAU to improve compatibility with JITs

Peter Maydell (5):
      tests/tcg/aarch64/sysregs.c: Use S syntax for id_aa64zfr0_el1 and id_aa64smfr0_el1
      target/xtensa: Assert that interrupt level is within bounds
      target/arm: Suppress more TCG unimplemented features in ID registers
      target/arm: Define neoverse-v1
      target/arm: Avoid over-length shift in arm_cpu_sve_finalize() error case

Richard Henderson (3):
      target/arm: Avoid splitting Zregs across lines in dump
      target/arm: Dump ZA[] when active
      target/arm: Fix SME full tile indexing

Vikram Garhwal (1):
      tests/qtest: xlnx-canfd-test: Fix code coverity issues

Yuquan Wang (1):
      hw/arm/sbsa-ref: use XHCI to replace EHCI

 docs/system/arm/sbsa.rst          |   5 +-
 docs/system/arm/virt.rst          |   1 +
 hw/arm/sbsa-ref.c                 |  24 ++++---
 hw/arm/virt.c                     |   1 +
 hw/misc/allwinner-sramc.c         |   1 +
 target/arm/cpu.c                  |  98 +++++++++++++++++++++--------
 target/arm/cpu64.c                |   4 +-
 target/arm/gdbstub.c              |   4 ++
 target/arm/helper.c               |  70 +++++++++++++++++----
 target/arm/tcg/cpu64.c            | 128 ++++++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c    |  24 +++++--
 target/xtensa/exc_helper.c        |   3 +
 tests/qtest/xlnx-canfd-test.c     |  33 ++++------
 tests/tcg/aarch64/sme-outprod1.c  |  83 ++++++++++++++++++++++++
 tests/tcg/aarch64/sysregs.c       |  11 ++--
 hw/arm/Kconfig                    |   2 +-
 tests/tcg/aarch64/Makefile.target |  16 ++---
 17 files changed, 415 insertions(+), 93 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-outprod1.c

