Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0C82C13B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI3b-0001UJ-Qf; Fri, 12 Jan 2024 08:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOI3a-0001SY-3B
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:58:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOI3X-0003vn-Mv
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:58:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e6977d936so324785e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705067921; x=1705672721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Zuc+Lj0f2rU6ef765YNz5uR5mxcw0c3Fpks+jclxOk=;
 b=OA5PqcfLZrKZAknN0y+AyZVwo1EgetKswCVX4JfJjOBn5MbOaWxqpuJfAM0kYyEndD
 LHHbV3ElG/LgULrYxFktDaLnDpMjF0WV6Ilv4tw6QqAq8PQr/O2MbsQu6N/YN0EeB1C1
 qb4V1GAfX2LxzGR/zQiWcc265m7TMixnBf5zmgfdXSpEeorJ/X/HRv0Ew3L3MDIuFkq2
 6f3xNSjKux2z56t+I+xdNxScwRptN95ugzFtaq0ym3Pmbn16Ys2bdkVQmThvlNHh1EX2
 fm4S0B10IABp1EPq93D078uKtXVQd/7cAbR/Y0ozTlf1uVNb9LSNkj3kt+IvUUdlmeoq
 4fXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067921; x=1705672721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Zuc+Lj0f2rU6ef765YNz5uR5mxcw0c3Fpks+jclxOk=;
 b=KBkngoVSfkbbaM9iUwJXo9S3A1qMgQuJRwqJrTb9vTWgPEHWe2oVIQxHdsvpsYRKZy
 tgTkI0LUzRGIVJycrP4+FieXQ6daFYT4+KgsQ07vLdT5qi9AGlzzbKFL1EiS5EIgjlDl
 bxxCGOC5ziOUM7Y+ZdK0pH6C7JSsOJpqB2sLKbbtElKuJ2baKcJJxbMntuvTFr1tml9z
 zjvSKED3w9ysAnNUmu979QG5gUug/YUc3WRAWlFuj2DZ626+Xz0aUhBewMRHNYnfyOii
 fB8XkkjELXHreGCY+1uxyhjO0aPynpvWKECCgY5womEdwd5GiDYxs8LQqciYghtnhh5A
 dZGw==
X-Gm-Message-State: AOJu0Yy+NkeZUmJNVT5ylLItEAW/l33+fdy9ojpInCJpd1j2PH2ckitC
 +LbmVvNsoBzVTGXjurY8AqGpVOQNtFAi99mhdoqS7nS4Voo=
X-Google-Smtp-Source: AGHT+IFkhpifuD9ps6wE48XfGcrMtppch4k/3fHJTk5N0PbR1j+3rHz7g9bd+/NcgobxQCnbdVOF6w==
X-Received: by 2002:a05:600c:214e:b0:40d:8780:2aff with SMTP id
 v14-20020a05600c214e00b0040d87802affmr660274wml.131.1705067921006; 
 Fri, 12 Jan 2024 05:58:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o8-20020a05600c510800b0040e624995f1sm4639223wms.8.2024.01.12.05.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:58:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F9A75F760;
 Fri, 12 Jan 2024 13:58:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/22] testing and misc updates
Date: Fri, 12 Jan 2024 13:58:40 +0000
Message-Id: <20240112135840.3828701-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

The following changes since commit 3fab43d2f638b98765b0f8ef033ec93e3ea6b809:

  Merge tag 'firmware/edk2-20231213-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-01-11 15:19:42 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-testing-updates-120124-2

for you to fetch changes up to 139db3cc5967e995e039c9cc2228c627cef7c1cf:

  tests/avocado: partially revert unmasking of replay_linux tests (2024-01-12 13:23:48 +0000)

----------------------------------------------------------------
testing and misc updates

  - add LE microblaze test to avocado
  - use modern snapshot=on to avoid trashing disk image
  - use plain bool for fe_is_open
  - various updates to qtest timeouts
  - enable meson test timeouts
  - tweak the readthedocs environment
  - partially revert un-flaking x86_64

----------------------------------------------------------------
Alex Bennée (5):
      tests/avocado: use snapshot=on in kvm_xen_guest
      gitlab: include microblazeel in testing
      chardev: use bool for fe_is_open
      readthodocs: fully specify a build environment
      tests/avocado: partially revert unmasking of replay_linux tests

Daniel P. Berrangé (12):
      qtest: bump min meson timeout to 60 seconds
      qtest: bump migration-test timeout to 8 minutes
      qtest: bump qom-test timeout to 15 minutes
      qtest: bump npcm7xx_pwm-test timeout to 5 minutes
      qtest: bump test-hmp timeout to 4 minutes
      qtest: bump pxe-test timeout to 10 minutes
      qtest: bump prom-env-test timeout to 6 minutes
      qtest: bump boot-serial-test timeout to 3 minutes
      qtest: bump qos-test timeout to 2 minutes
      qtest: bump aspeed_smc-test timeout to 6 minutes
      qtest: bump bios-table-test timeout to 9 minutes
      mtest2make: stop disabling meson test timeouts

Thomas Huth (5):
      tests/avocado: Add a test for a little-endian microblaze machine
      tests/qtest: Bump the device-introspect-test timeout to 12 minutes
      tests/unit: Bump test-aio-multithread test timeout to 2 minutes
      tests/unit: Bump test-crypto-block test timeout to 5 minutes
      tests/fp: Bump fp-test-mulAdd test timeout to 3 minutes

 docs/requirements.txt               |  2 ++
 include/chardev/char-fe.h           | 19 ++++++++++++-------
 chardev/char-fe.c                   | 16 ++++++++--------
 chardev/char.c                      |  2 +-
 .gitlab-ci.d/buildtest.yml          |  4 ++--
 .readthedocs.yml                    | 19 ++++++++++++-------
 scripts/mtest2make.py               |  3 ++-
 tests/avocado/kvm_xen_guest.py      |  2 +-
 tests/avocado/machine_microblaze.py | 26 ++++++++++++++++++++++++++
 tests/avocado/replay_kernel.py      |  3 +++
 tests/fp/meson.build                |  2 +-
 tests/qtest/meson.build             | 25 +++++++++++++------------
 tests/unit/meson.build              |  2 ++
 13 files changed, 85 insertions(+), 40 deletions(-)
 create mode 100644 docs/requirements.txt

-- 
2.39.2


