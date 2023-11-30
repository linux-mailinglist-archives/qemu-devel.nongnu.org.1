Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1047FF3A6
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:35:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8j3J-0007bG-Qy; Thu, 30 Nov 2023 10:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8j2t-0007Vn-NO
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:33:44 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8j2n-0004zp-Rn
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:33:41 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c9d3aad61fso5824171fa.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701358414; x=1701963214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDxRHuSfYIYlC3JXkbLWh47yli6QU/M0/quwbVcTvXo=;
 b=f4/AqgtmLUxThoq+ZsnntRpE+dxPtgF7KC2T1vM3Nk6SiSRQ6g396RcwtrXVWhUCsw
 XHUyLg31Zmh3g2haibsphwaCeiYYMArB6wEbnwyJN4D6qrXNuXnsBsf3dJXHIiQOhHPO
 CXu/1O9jZL5SA0eY1irV7TtSRULhrVFEmuG0z9yh9jF4ub7jClyqLQzPx6zXWqeVAeeq
 fWQsAHGO6b8vukygs9IjpIXXM7CQ3UYfOIwqklX51MBGm8kk9x9YZAdf37aVHSFKuRsC
 4ldkDzXll+7O+E94eG5rgK/5zgIXcgDglFgVP3IVsN8u2l5L0PGIDcXOmHLg0pbmUw2h
 uvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701358414; x=1701963214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDxRHuSfYIYlC3JXkbLWh47yli6QU/M0/quwbVcTvXo=;
 b=pDi+tZE67BRVhbJRWxJG2cDIXv0G+uFaIL2AI6zmuPkVBM9wTHTol1wA4hAYXRsUCj
 LmFINQXW9Ug0auJChktXUeJrBkm3+x1rK9De/UK7zAWSH9AfDnu8OPQzGnXaalijkAbk
 8z5QmO97KCXKrReauI4MfQ/P+mZ4ews2slVR4QGuRFwzMJxQD5tKVWIfd7clvLCWELqo
 3ApMSyql/IvljoqNBK4Ym/64Y+mf/Q5x1QL/3bMUyx3hUtoi3py7fB+9Hpxhjo1n1FXi
 FZOIx3HeQQ8jtisvPBksrwd2xUwu8jYh+AIo0qWZXv280quXrrog2N/0Q4wsWkdSjwD/
 inHQ==
X-Gm-Message-State: AOJu0YxF7iqPsfmrEJSpuuriTQZx63TkuU/Eds+z7USDGUXQpCJsPXNm
 S1WZlIqKIxJdFBglRpLuxowHlA==
X-Google-Smtp-Source: AGHT+IHyywHJC5G+ib61dpmzb10ZnyQ4rg+qSa2DNaMFpHM/ilFpk5jkgp5oHjC3bbx+4CIeohG/eA==
X-Received: by 2002:a2e:a58d:0:b0:2c9:99ca:1317 with SMTP id
 m13-20020a2ea58d000000b002c999ca1317mr10836853ljp.24.1701358414410; 
 Thu, 30 Nov 2023 07:33:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c474300b0040b36050f1bsm2331660wmo.44.2023.11.30.07.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 07:33:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 718D55F794;
 Thu, 30 Nov 2023 15:33:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/3] final fixes for 8.2
Date: Thu, 30 Nov 2023 15:33:30 +0000
Message-Id: <20231130153333.2424775-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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

8.2 is looking fairly stable but I do have one bug fix for gdbstub
which I came across while debugging something else. The changes for
avocado rationalise all flaky tests under the QEMU_TEST_FLAKY_TESTS
environment variable. The final patch re-adds the flaky tests to the
CI as a manually run allow_fail job so we can still attempt to debug
their failure in the place they tend to fall over.

Alex.

Alex Bennée (3):
  gdbstub: use a better signal when we halt for IO reasons
  docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
  gitlab: add optional job to run flaky avocado tests

 docs/devel/testing.rst                   | 32 ++++++++++++++++--------
 gdbstub/internals.h                      |  1 +
 gdbstub/system.c                         |  2 +-
 .gitlab-ci.d/buildtest.yml               | 30 ++++++++++++++++++++++
 tests/avocado/boot_linux.py              | 10 +++++---
 tests/avocado/boot_linux_console.py      |  6 +++--
 tests/avocado/intel_iommu.py             |  6 +++--
 tests/avocado/linux_initrd.py            |  7 ++++--
 tests/avocado/machine_aspeed.py          | 10 +++++---
 tests/avocado/machine_mips_malta.py      | 10 +++++---
 tests/avocado/machine_rx_gdbsim.py       | 10 +++++---
 tests/avocado/machine_s390_ccw_virtio.py |  3 ++-
 tests/avocado/replay_kernel.py           |  7 ++++--
 tests/avocado/reverse_debugging.py       | 16 ++++++++----
 tests/avocado/smmu.py                    |  6 +++--
 tests/avocado/tuxrun_baselines.py        |  5 ++--
 16 files changed, 119 insertions(+), 42 deletions(-)

-- 
2.39.2


