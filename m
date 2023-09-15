Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E07A21FB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARF-0003BH-F1; Fri, 15 Sep 2023 11:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARD-0003Am-FO
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARA-00028j-Lk
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40472c3faadso20003145e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790531; x=1695395331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RAqS8uEx4Y3JErdFibsx7PoTedmxWh9Y1+zmtw22ro0=;
 b=ghBmKvaPrETAVJZx8luUyYJ+xOFd2uAEn9ArVSRpH8UYBbII4afy5SWmzhCXFvcfAi
 qorE9ltnPD7xrT/C+QaV3kB/WdHeiWh9NwDYdlkzYPo0SpQTW9i3NjeTSouTUuJKnYR8
 Kw4qeTSwi1477N4lnzvm0RX191K+Cb0SO50oOElbHY8jz0uaqDCPKK0+24+5gkx5OXiT
 bmQbZcjU2GPEHFS0SeDBQ4fw92dVPwZJ+8RwZxP7Nc//7tBtuCIKLh3YP4kMzY0NerK4
 Mw2SWtPYRnA7E0gAuWdd5/Aw/eBwOIdoodsu0JMbDR2Dx8+egZ4vIpy/Ljd1S5B96OxC
 ioQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790531; x=1695395331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RAqS8uEx4Y3JErdFibsx7PoTedmxWh9Y1+zmtw22ro0=;
 b=U0sXUjSDbSMrKeh+wDPIFuwkE9XlbzEm6rgOo583BRt6DDijcraq6PkCXGAPAcHKqb
 cLOkzljfbBSwp9gmint9nVTUANCrkhJvRSAqihz9oe/CjOOp/COBSlKq5olBTlqcvSzY
 NgIwTXN0Zvrm7eCCksyiRKJmeLojgkMwPGPo9xPz9KIrNMcUE9TbXb5YFWJ2J+51jnfB
 Gk+CCn1qFSBP1cnoL6GwG59tfEIwogOWk0jL+WAXej23Xk36ZXKYrT5dble0FsXh/8e2
 vUdZpivHM2yFYDtzp+EK97SBqGUd8jvklmMqEGI9huEd2qEdC+H0LmJTDP7aGp/I4Rmf
 lONw==
X-Gm-Message-State: AOJu0YyFGxzK+rQFN8m/Ox8kOfPndDHHzVspDBGYxeZskWEJqxh6XU4f
 nsPcg1xfG+jE3c7QB+/7IeLuVCjvV9slpxtV+kA=
X-Google-Smtp-Source: AGHT+IE4zKTMhvw9B3F7QY5CYy5lHGKy2soaYdSVNCIIzPXR8MSwLdAE8q/GiHiulR7Ih8o5LrEcDQ==
X-Received: by 2002:a1c:7914:0:b0:404:6ed9:98d1 with SMTP id
 l20-20020a1c7914000000b004046ed998d1mr1948854wme.41.1694790530670; 
 Fri, 15 Sep 2023 08:08:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c020700b003fe2de3f94fsm4831957wmi.12.2023.09.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D58731FFBB;
 Fri, 15 Sep 2023 16:08:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/9] testing updates (back to green!)
Date: Fri, 15 Sep 2023 16:08:40 +0100
Message-Id: <20230915150849.595896-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-150923-1

for you to fetch changes up to 5acd4bf25dc9becd05b8772b94982722e1fa76a3:

  tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (2023-09-15 15:17:52 +0100)

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
      tests: update Debian images to Bookworm
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
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/debian-amd64.docker          | 10 +++-------
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/debian-armel-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
 .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
 tests/lcitool/libvirt-ci                              |  2 +-
 tests/lcitool/refresh                                 | 18 +++++++++---------
 23 files changed, 93 insertions(+), 65 deletions(-)


-- 
2.39.2


