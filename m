Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776957A5A40
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:58:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUgd-0002d3-Vs; Tue, 19 Sep 2023 02:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiUgY-0002aP-5I
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:58:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiUgH-00071Y-GN
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:58:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-403012f276dso57299765e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695106675; x=1695711475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JQUGCkvOcWKzXPT1T/Olz5X/Z9WjqXtsa/S6qktBprg=;
 b=zqYClQFlBsQNZ1+HvKlSRE/gDFVJCPYMvJZQU2YusX5vKGeqKvQpIyQYWMEjpTU9/O
 7tR2b3bznhhRtEBxllOzKDImX9v37nNSXMVc8VDbrtUkGEfzZ4qBW+pPZ9+dyOEojN3B
 bXmWJ15IASfWzqXVL9QueQhv+leqktY8oUiozp9C9FEwiPm0itEj3+BrdSE8ExmzZRl+
 +7LaTBD/bt/W1O5W8aXYY9njVaIZrAPUdulpLNywap07MnKc5I86jvsUdsqTGJnL7RBt
 tHb2pUGpXM66osf8zVRQlrtw8Rp4+88HzrL+EJuiBVLSrWaYKnq+t41749gqrbcg7qCI
 85HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695106675; x=1695711475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQUGCkvOcWKzXPT1T/Olz5X/Z9WjqXtsa/S6qktBprg=;
 b=xMIIlrS0hf8Xcd2OmNHb7AVhARYC/VSpDErh2hX7ZTstwDLdQB+UYfsYHIMNPDJ6XV
 iz/lWTqmRizGovbT4BZYvxLC8RDsI1TgmxI/UNgRynIQ0J0GkzqZHDpVOvm2P70p5OAX
 gD/S9jJFNqXjDwrWZFjkOGR7hncr2I8p5YkrjdTRgjEnv533xb/489xNZPH2vBLXy0NE
 g2v+G8JT0nM2Fj9UkHhbOMuDqubxgkeRQHhi8WdBsmj7XoqTmiV3dcsjzIiPOk7s1uDQ
 qns5Kzh3S06wfnCHTPOTznZVVybWANnJuIkSe8MPlm4jZQa4XR0yCiTc0An58iTwmWo8
 /22w==
X-Gm-Message-State: AOJu0YyKrVNdztEOfkqeAkCtYoe60o+9ScBiSfJH2uhX2uvbcV6gl0mQ
 99GGG0rxY5rb6or5d7C41wR99w==
X-Google-Smtp-Source: AGHT+IFRqW635l2O5omS0ZEpmoH9MZLVoY9YxTE3QN7ybGRSKXo4Nbe76gBpo4fFdjkJ6R8XV1iQzw==
X-Received: by 2002:a05:600c:2055:b0:3fb:efe2:34a2 with SMTP id
 p21-20020a05600c205500b003fbefe234a2mr9191291wmg.5.1695106675250; 
 Mon, 18 Sep 2023 23:57:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c11ce00b003fee8502999sm17095787wmi.18.2023.09.18.23.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 23:57:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CECD1FFBB;
 Tue, 19 Sep 2023 07:57:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 0/9] testing updates (back to green!)
Date: Tue, 19 Sep 2023 07:57:54 +0100
Message-Id: <20230919065754.1091394-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit 13d6b1608160de40ec65ae4c32419e56714bbadf:

  Merge tag 'pull-crypto-20230915' of https://gitlab.com/rth7680/qemu into staging (2023-09-18 11:04:21 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-190923-1

for you to fetch changes up to bb3c01212b54595f5bbdbe235cb353b220f94943:

  tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (2023-09-19 07:46:02 +0100)

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
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/debian-amd64.docker          | 10 +++-------
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/debian-armel-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
 .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
 tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
 tests/lcitool/libvirt-ci                              |  2 +-
 tests/lcitool/refresh                                 | 17 +++++++++--------
 23 files changed, 91 insertions(+), 58 deletions(-)

-- 
2.39.2


