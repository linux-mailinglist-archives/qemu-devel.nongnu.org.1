Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E65800E2D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95CG-0004sV-Rr; Fri, 01 Dec 2023 10:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Bz-0004qi-7M
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:36 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Bv-0003sn-Hh
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b54261534so21010505e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443550; x=1702048350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+tDJnAu9PEhvcX0JgYZpbmjnCUVVRPU/BOiTOTt6dDM=;
 b=dSiJVO+FT3/N3yZywb8OLZHd3CW3N7C4qyzsrEN2gaw+nrd6K/IVnh5gzDLNefJNkW
 uUUowKNnBz4v/L1Dqm8rkhqPdyoCXrKQ5CxiHfa+Zbd3dipHZbAvfffFlepE3SvAMiVS
 8z32LU9PIDmc355PMmrW9+3VGz4LRdnBZL3zfMwxHdxFFa9pq3FB8JHEB4HFN+YWe1hd
 G48LCzlT/L3iMClVspyFalR8srI4FQ2F55rLNvZGu832nWtPpndXRsRiwORKbBgEBaAL
 hYkqdU/5s0s2o6hAqrALGIbUbNv5rUU71eBXmxq+AWhZcEu7stfEnHzm3NjArv/FIGr4
 Kdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443550; x=1702048350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tDJnAu9PEhvcX0JgYZpbmjnCUVVRPU/BOiTOTt6dDM=;
 b=ZqcCHWd07kvz8HpWtRZMcZUWonA8IupjDT2NfxWn/l56WCtjO7uAraOI1YygZenhjT
 0UKxQpE1BI8v29fj5UupHdOoVkroi/Wvfir6NKDCAVNTCM6DeadQMjYpD3nzFyeNl2ql
 P7J1JZ76TBGkOzIIT5T+or6afUDqpjSSyMfmM3e96kdrt9ZZ9RK6YeU9HyCXwl0WkoiA
 jy5Q5mKFnp/RfkZNsfkmMfWJu3uNE3187N9IU2SbnJ7tLl0dNEXMSbDwrTq80KL5AAwR
 gjv1Ss/f+v62ATmMlIgjl9At7SUDzCgrF5dtiMO07hTj1ooAsX8XzXXRQdCG+WZXpDiv
 Lxaw==
X-Gm-Message-State: AOJu0YxsRi0S+nvYpdrerQjdl/QOrmXCPMva3hzdTtRcphHS/o1b/5cv
 xrqf4fd/bJQGoCKeo+IFDxw9cWr6/8FMzMSvDkDgyQ==
X-Google-Smtp-Source: AGHT+IFnAxKunXvySl9j6Ukt8xaEE/J/wTRk9YpB4PkEQhJtunx4uraGVBAUxntdkgdEYxAA7HJt8A==
X-Received: by 2002:a05:600c:2218:b0:40b:5e59:99b8 with SMTP id
 z24-20020a05600c221800b0040b5e5999b8mr319449wml.216.1701443549580; 
 Fri, 01 Dec 2023 07:12:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh12-20020a05600c3d0c00b0040b2976eb02sm5729799wmb.10.2023.12.01.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:12:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1DBF5FB5F;
 Fri,  1 Dec 2023 15:12:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/6] gdbstub, avocado and gitlab updates
Date: Fri,  1 Dec 2023 15:12:22 +0000
Message-Id: <20231201151228.2610209-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

  https://gitlab.com/stsquad/qemu.git tags/pull-more-8.2-fixes-011223-1

for you to fetch changes up to a7a740cce1ec49568e7ebd8e776279e59e2fb5b6:

  gitlab: add optional job to run flaky avocado tests (2023-12-01 14:12:05 +0000)

----------------------------------------------------------------
Flaky avocado tests, gdbstub and gitlab tweaks

  - gdbstub, properly halt when QEMU is having IO issues
  - convert skipIf(GITLAB_CI) to skipUnless(QEMU_TEST_FLAKY_TESTS)
  - drop mips malta cpio test as assets expire in Debian archive
  - tag sbsa-ref tests as TCG only
  - build the correct microblaze for avocado-system-ubuntu
  - add optional flaky tests job to CI

----------------------------------------------------------------
Alex Bennée (6):
      gdbstub: use a better signal when we halt for IO reasons
      docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
      tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test
      tests/avocado: tag sbsa tests as tcg only
      gitlab: build the correct microblaze target
      gitlab: add optional job to run flaky avocado tests

 docs/devel/testing.rst                   | 32 ++++++++++++++--------
 gdbstub/internals.h                      |  1 +
 gdbstub/system.c                         |  2 +-
 .gitlab-ci.d/buildtest.yml               | 32 +++++++++++++++++++++-
 tests/avocado/boot_linux.py              | 10 +++++--
 tests/avocado/boot_linux_console.py      | 47 +++-----------------------------
 tests/avocado/intel_iommu.py             |  6 ++--
 tests/avocado/linux_initrd.py            |  7 +++--
 tests/avocado/machine_aarch64_sbsaref.py |  4 +++
 tests/avocado/machine_aspeed.py          | 10 +++++--
 tests/avocado/machine_mips_malta.py      | 10 +++++--
 tests/avocado/machine_rx_gdbsim.py       | 10 +++++--
 tests/avocado/machine_s390_ccw_virtio.py |  3 +-
 tests/avocado/replay_kernel.py           |  8 ++++--
 tests/avocado/reverse_debugging.py       | 16 +++++++----
 tests/avocado/smmu.py                    |  6 ++--
 tests/avocado/tuxrun_baselines.py        |  5 ++--
 17 files changed, 125 insertions(+), 84 deletions(-)


-- 
2.39.2


