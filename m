Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E880120E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:50:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97e8-0002U0-Pv; Fri, 01 Dec 2023 12:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r97e6-0002TY-PX
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:49:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r97e5-00030L-3i
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:49:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b31232bf0so21786925e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701452983; x=1702057783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DynwqO9cmsMzFQCzxt60QEjNKY5QSTNh5LDfwHkcP0A=;
 b=FGHCdiJNQBS6661S/gu6+ZdISzTgmSNSYxbVdaktVJ8ykXVS3QqsiR4xn0eC5k/rqH
 7l0iwpHIDB3hQLQj1HWEU+/5uSbP1kxTOgkLosVk9Vm0PzTSce4cq/UmPB7WMUbLZyY1
 PYo+bNP5PEjPMSkd8xvw1bH3ZInkf/T2l7G/o59E5YNNLNX1j+Bk7kPun9BS3A0FS4Bp
 miXmWMHxnf9+01kilhlNkfFTDZ6LbNf7vUMKCXPjfVP4jgoxK8zigvdx9Zxj+YiPqDyQ
 Y1+YnAu7x5ZhcrlPVd44bkqAhLNrGX24jm2sBctfsMBwtmeGpArBO7lxXzB6FVBX+iNT
 +LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701452983; x=1702057783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DynwqO9cmsMzFQCzxt60QEjNKY5QSTNh5LDfwHkcP0A=;
 b=Mqu2pkPrA95DsBHoGhS5cvMU9R1LkMrsCp0pvumWasQ/SCwnfOf4u3Qoee8Hups0ZH
 2OnFCCyUv0m3Jfr623wOgbAcwi2UyzVSbufYkT0KVumrAajA/QGK8SvkBqZtRBnkzgbd
 HKdQREEZDbrYZRz8ctgHEkkFNbesZSONpXn7+1kpFnGfx5ZjUYx7d+/THPkpw6ytrHaV
 gDHwm4yFRe+M++Q97+wr1n2yH+dd89BI/EZZD3bVdLARAjgUYcPf+/0yknuTrcE3cgkD
 FB+p13q3jaJjI0Kzj9JewR5U7rxxpmEKhqVW8xZ3jDUUNPd2LMSr1yQ0DlIu3SL8k0Np
 WHHQ==
X-Gm-Message-State: AOJu0YyuYnm/GNH9ArlZblljdQdo9sf4sDnInX6GywrG7ZqCgYZYwKme
 6SYm+gArD/Ycnb/4nYTYff8wKg==
X-Google-Smtp-Source: AGHT+IEi5NLtz5P+kBtarp/caXq94Qn4Q9/Qj7K/tAxE+FgEKPjEnXYqKsy/ebIo0lHxMKSN5v8WxQ==
X-Received: by 2002:adf:f452:0:b0:32f:8248:e00 with SMTP id
 f18-20020adff452000000b0032f82480e00mr1044749wrp.51.1701452983353; 
 Fri, 01 Dec 2023 09:49:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fs20-20020a05600c3f9400b0040b5517ae31sm8973635wmb.6.2023.12.01.09.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:49:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE3E05FB5F;
 Fri,  1 Dec 2023 17:49:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 0/5] gdbstub, avocado and gitlab updates
Date: Fri,  1 Dec 2023 17:49:42 +0000
Message-Id: <20231201174942.2668112-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:

  Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-more-8.2-fixes-011223-2

for you to fetch changes up to 5d25fcb702406286a17806dd53d10eec1d2cc34f:

  gitlab: add optional job to run flaky avocado tests (2023-12-01 17:47:20 +0000)

----------------------------------------------------------------
Flaky avocado tests, gdbstub and gitlab tweaks

  - gdbstub, properly halt when QEMU is having IO issues
  - convert skipIf(GITLAB_CI) to skipUnless(QEMU_TEST_FLAKY_TESTS)
  - tag sbsa-ref tests as TCG only
  - build the correct microblaze for avocado-system-ubuntu
  - add optional flaky tests job to CI

----------------------------------------------------------------
Alex Bennée (5):
      gdbstub: use a better signal when we halt for IO reasons
      docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
      tests/avocado: tag sbsa tests as tcg only
      gitlab: build the correct microblaze target
      gitlab: add optional job to run flaky avocado tests

 docs/devel/testing.rst                   | 32 +++++++++++++++++++++-----------
 gdbstub/internals.h                      |  1 +
 gdbstub/system.c                         |  2 +-
 .gitlab-ci.d/buildtest.yml               | 32 +++++++++++++++++++++++++++++++-
 tests/avocado/boot_linux.py              | 10 +++++++---
 tests/avocado/boot_linux_console.py      |  6 ++++--
 tests/avocado/intel_iommu.py             |  6 ++++--
 tests/avocado/linux_initrd.py            |  7 +++++--
 tests/avocado/machine_aarch64_sbsaref.py |  4 ++++
 tests/avocado/machine_aspeed.py          | 10 +++++++---
 tests/avocado/machine_mips_malta.py      | 10 +++++++---
 tests/avocado/machine_rx_gdbsim.py       | 10 +++++++---
 tests/avocado/machine_s390_ccw_virtio.py |  3 ++-
 tests/avocado/replay_kernel.py           |  8 ++++++--
 tests/avocado/reverse_debugging.py       | 16 +++++++++++-----
 tests/avocado/smmu.py                    |  6 ++++--
 tests/avocado/tuxrun_baselines.py        |  5 +++--
 17 files changed, 125 insertions(+), 43 deletions(-)

-- 
2.39.2


