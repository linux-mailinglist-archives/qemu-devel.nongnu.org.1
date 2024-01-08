Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF982729E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:14:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKC-0004CO-4h; Mon, 08 Jan 2024 10:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKA-0004C7-KW
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:13:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrK7-0001WL-Pa
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:13:57 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso21353915e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726833; x=1705331633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wxvMzPxh296I68JWNGMKS8OkH2KDxTMj4C9d3DjgZGQ=;
 b=iVpU0cJ5EexII5CU167MkSOHfLnD+wbqXhauTiPROWkAchU2fKMrV5hQVQY/XRxLii
 F5IWUsqdkdoVHfOK1pKHR837kRw5LpuMyE2CoinkNdC/04XYVXc+8lsWTsR0WsMT80uz
 5FYjEt92wMGuAsVS8Vq6yxZxtxBv0N7+YDwNU2kTL+U6wyceNFvUi1f+weZlSes0ffNB
 BFPnILNGbhYR4kXD1SftzHj9J+dl6VXc3d4llRtRk+boyZ9O2zDWuX/noLK4u9najX5L
 HiyOLosb/Tovw//5juyRcj2McO/0eBgw8TaeEQrP+/rCHgqsE/KzNjuoPJtH1s1rH+vP
 tawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726833; x=1705331633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxvMzPxh296I68JWNGMKS8OkH2KDxTMj4C9d3DjgZGQ=;
 b=tR1RcAl6B4F3eThuWR87VUVMQzvuJ9EJehz+dinyBUb4cFC/hMxwkPwGpr0uCaqtC6
 DMiJcy3iJfCDPJMZNvJenEUg+4ngZsBpU07PIksnZRL91WN40eUpVtV4W5YFS+shd31X
 JzFJiztLGoxjoKi8cJOIFmpH+HaFvHxJRVmYkvyOBPe9mIkkxEmqiI/asbT0Y7D2zZN4
 sH+RSZuhejC4129+RF9pdcf3fxgsoLqa5zXas02LTZTS3074cXEMKq0iBxpPT4Sgfdje
 PtpKD7NhoggXyZoPBFNgq+7nptdMN7K0jEsB7W6N1DHqLZTY9ICW93sChugJaShqMssh
 EcGg==
X-Gm-Message-State: AOJu0Yx5CxLf/uUg7mOpq7g47eOCn8k5QL4JREwm7Kc+AhIrQawLXl1e
 wWxchQguwVYnvvUusm24veRBS0i/Edd9UQ==
X-Google-Smtp-Source: AGHT+IEruWEPSuig06aDsYr5Dhb1xW0rckJz95kn4rr7Ltu8vY1712FAW8JeEm/TKikqfYmy7vfWNA==
X-Received: by 2002:a05:600c:4683:b0:40e:4174:fbe0 with SMTP id
 p3-20020a05600c468300b0040e4174fbe0mr1562694wmo.140.1704726833532; 
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b16-20020a056000055000b0033763a9ea2dsm5469345wrf.63.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFB615F756;
 Mon,  8 Jan 2024 15:13:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/13] replay fixes for replay_kernel
Date: Mon,  8 Jan 2024 15:13:39 +0000
Message-Id: <20240108151352.2199097-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d37328:

  Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into staging (2024-01-05 16:08:58 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-replay-fixes-080124-1

for you to fetch changes up to c2ef5ee89d76f0ab77c4dd6a1c9eeed4d35d20ed:

  tests/avocado: remove skips from replay_kernel (2024-01-08 13:59:06 +0000)

----------------------------------------------------------------
Record/replay fixes for replay_kernel tests

  - add a 32 bit x86 replay test case
  - fix some typos
  - use modern snapshot setting for tests
  - update replay_dump for current ABI
  - remove stale replay variables
  - improve kdoc for ReplayState
  - introduce common error path for replay
  - always fully drain chardevs when in replay
  - catch unexpected waitio on playback
  - remove flaky tags from replay_kernel tests

----------------------------------------------------------------
Alex Bennée (13):
      tests/avocado: add a simple i386 replay kernel test
      tests/avocado: fix typo in replay_linux
      tests/avocado: modernise the drive args for replay_linux
      scripts/replay-dump: update to latest format
      scripts/replay_dump: track total number of instructions
      replay: remove host_clock_last
      replay: add proper kdoc for ReplayState
      replay: make has_unread_data a bool
      replay: introduce a central report point for sync errors
      replay/replay-char: use report_sync_error
      replay: stop us hanging in rr_wait_io_event
      chardev: force write all when recording replay logs
      tests/avocado: remove skips from replay_kernel

 include/sysemu/replay.h        |   5 ++
 replay/replay-internal.h       |  50 +++++++++++-----
 accel/tcg/tcg-accel-ops-rr.c   |   2 +-
 chardev/char.c                 |  12 ++++
 replay/replay-char.c           |   6 +-
 replay/replay-internal.c       |   5 +-
 replay/replay-snapshot.c       |   7 ++-
 replay/replay.c                | 132 +++++++++++++++++++++++++++++++++++++++++
 scripts/replay-dump.py         |  95 ++++++++++++++++++++++++++---
 tests/avocado/replay_kernel.py |  27 +++++----
 tests/avocado/replay_linux.py  |   9 ++-
 11 files changed, 303 insertions(+), 47 deletions(-)

-- 
2.39.2


