Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A87A8E31
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4MM-0007C7-Re; Wed, 20 Sep 2023 17:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qj4ML-0007Bv-Ga
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:03:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qj4MJ-0007UF-OP
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:03:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405082a8c77so2862065e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695243821; x=1695848621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mbgKQ5jdexkmgGCv+7WmdFw9lhog++a3jaGh+gFC7pI=;
 b=Wt+ddCqHK/2YhsnbaVtfzUDxM6tV0bLJev53HMNI5mT7IH9dzG36jxtkU5NHDzWHhi
 JeXkW870wrQu6y7bCaydaHq68LpqWCv0wfW5I1/ve2QoGAOwC91GaP/2hkn08Ge4eYFk
 RJ9vYz0ZmcuKuKCYJaejsiRzKG0FPgmVk2Opnio63vPzNIbfo+NUJpL9RQUmeg0l4v3v
 wKZlPPAbhdmRQjFfUDeA53RnYSTRnJzIVfNpiqUEPiw5fcSwtaXnTkAMSd+ZBlaP/vO+
 2ckFSfWOSaXRIZMw1S28CqiDpJUDwoFwcfqbVd+t69HJkAuoN3mIslINA0gy6s0F/9EC
 9Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695243821; x=1695848621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbgKQ5jdexkmgGCv+7WmdFw9lhog++a3jaGh+gFC7pI=;
 b=JnqiQ1xFj2FAUJMT398HVgV2JO71T3j861wNMTCwQ6r6HFwDfJoRMzUudJJS+YI6IW
 ID4bX81Z5r1aLTGT1VAoyjS2hjDV5tC9hINu0JYk9NTzPiftqaSKjmnjbcYfPQ1J/7Qu
 r9dZhiVVF7P4YACMoiru4rccSZ1AC4SP5ItKWyl4YIe6y61TqV9BhzEVhcqKsoQapdeR
 w3qVMxIlczhawh280xG7HUfZq4r7JL5GVxZjmjeXjqiuKF0DQDbd5GcRLH9hOWQh/wu+
 7Uv+ru2CwWH9jd0Kj0ULIjPiUWzSavQx+Ku0Ue9h8AzzwmmdlWhpKAQUi+J33kCYTvPS
 xB+g==
X-Gm-Message-State: AOJu0YxO5ry+GftC3/sj15O9/p7btzpNBbNo7d04Z22F45SbOQt5f/un
 VqKYkYRV3kIPBWV6KdGhPzdfih8PqPK4rXdXSqolMw==
X-Google-Smtp-Source: AGHT+IEuRaW7+LYbJiElLtShVD55kUNIe2qVhc0ZXnipSAbWwRZ3+4LQtN7vZZFP40DelMzVUgzMKg==
X-Received: by 2002:a7b:c84e:0:b0:405:1c34:9dc4 with SMTP id
 c14-20020a7bc84e000000b004051c349dc4mr3792145wml.2.1695243820963; 
 Wed, 20 Sep 2023 14:03:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bw17-20020a0560001f9100b003217cbab88bsm1279659wrb.16.2023.09.20.14.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:03:40 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 651CF1FFBF;
 Wed, 20 Sep 2023 17:17:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 0/9] testing updates (back to green!)
Date: Wed, 20 Sep 2023 17:17:11 +0100
Message-Id: <20230920161711.1295646-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:

  Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-testing-200923-1

for you to fetch changes up to f959c3d87ccfa585b105de6964a6261e368cc1da:

  tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (2023-09-20 15:06:33 +0100)

----------------------------------------------------------------
testing updates:

  - update most Debian to bookworm
  - fix some typos
  - update loongarch toolchain
  - fix microbit test
  - handle GitLab/Cirrus timeout discrepancy
  - improve avocado console handling
  - disable mips avocado images pending bugfix

----------------------------------------------------------------
Alex Bennée (2):
      tests: update most Debian images to Bookworm
      gitlab: fix typo/spelling in comments

Daniel P. Berrangé (4):
      microbit: add missing qtest_quit() call
      qtest: kill orphaned qtest QEMU processes on FreeBSD
      gitlab: make Cirrus CI timeout explicit
      gitlab: make Cirrus CI jobs gating

Nicholas Piggin (1):
      tests/avocado: Fix console data loss

Philippe Mathieu-Daudé (1):
      tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884

Richard Henderson (1):
      tests/docker: Update docker-loongarch-cross toolchain

 tests/qtest/libqtest.c                                |  7 +++++++
 tests/qtest/microbit-test.c                           |  2 ++
 .gitlab-ci.d/base.yml                                 |  2 +-
 .gitlab-ci.d/cirrus.yml                               |  4 +++-
 .gitlab-ci.d/cirrus/build.yml                         |  2 ++
 python/qemu/machine/machine.py                        | 19 +++++++++++++++++++
 tests/avocado/avocado_qemu/__init__.py                |  2 +-
 tests/avocado/boot_linux_console.py                   |  7 +++++++
 tests/avocado/machine_mips_malta.py                   |  6 ++++++
 tests/avocado/replay_kernel.py                        |  7 +++++++
 tests/avocado/tuxrun_baselines.py                     |  4 ++++
 tests/docker/dockerfiles/debian-amd64-cross.docker    |  9 +++------
 tests/docker/dockerfiles/debian-amd64.docker          |  9 +++------
 tests/docker/dockerfiles/debian-arm64-cross.docker    |  9 +++------
 tests/docker/dockerfiles/debian-armhf-cross.docker    |  9 +++------
 .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  |  9 +++------
 tests/docker/dockerfiles/debian-s390x-cross.docker    |  9 +++------
 tests/lcitool/libvirt-ci                              |  2 +-
 tests/lcitool/refresh                                 | 17 +++++++++--------
 20 files changed, 88 insertions(+), 49 deletions(-)

-- 
2.39.2


