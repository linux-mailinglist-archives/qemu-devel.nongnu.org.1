Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9F82653A
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWX5-0000cH-TW; Sun, 07 Jan 2024 12:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWWr-0000RI-Tc; Sun, 07 Jan 2024 12:01:45 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWWp-0006ub-BU; Sun, 07 Jan 2024 12:01:41 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28d2c1389e8so815458a91.2; 
 Sun, 07 Jan 2024 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646896; x=1705251696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ELojimsRxbTxv9bQNb/kBJ+EXH/u21UnkztfXEpNuHs=;
 b=RWeomhN81Pnyqx21cOElNv1SpVJnULmzTUcBPpxvuRQMVq0uaum+6d5bGUjiU7m2bZ
 GRpbF45iVQ2E7L2juu6++Z0UhKP8FSxYq7S4hxyjNtAk66F3vO49rS1eoUQM9MIOF0Ux
 rthfI1DudyNyZ+YdYWkZSq3sNidpgO+Rj83S0XntzmpxVBLB/BKnkY6+QXMnEowpKf+4
 DmcCBnJiPmJhPlUSfnhyQEJAEbQKCxwkTwgI5I9jLASh7VERjSbRfSliHf5JuCzcQI5f
 yRdMKHUlE4T+cN+M8bsJeGqtqghS/3GPUnUkkUCfg3K0SziGoGWowOx+VJvMRshzQnoo
 NIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646896; x=1705251696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ELojimsRxbTxv9bQNb/kBJ+EXH/u21UnkztfXEpNuHs=;
 b=lIVdFs8vj+dUSeHFUFkDe0u8Tj1QPiGHPGNCvwmbco1KlUmJa3x49hwRxPnFf/sNZH
 sBs6MX1ozqqDZ53+t5KiIG6cb9+KsXTuGBLnYUakFoZENzSdhfO6G3MTqh0Ob12masRH
 yCO4Y1teb5aGMeGpEMZ4unTDml1fDUmFrUdJ62SacYaHyOS/4YhnRkXRL9qBWDDilEzz
 kakVjTdVE3PtPp8tz2bXnKuNyEi3+dVdIWNnQXdBmDsR4W7iEOZdyDJE09c0qY9r9vjZ
 f3EtpJue66eVORRv9LjNTn77toowxPFKkyEwQtSQzdbC/POKRarKUpVq7sYaBxZTYVw7
 XdDQ==
X-Gm-Message-State: AOJu0YxyOG0+q5q6IGd1dqJJoa56APR771sQauW3kr3kMMiTZGpqu7+u
 ZfhhEmA+nr1Q95oWs8clF++Alm0nMhs=
X-Google-Smtp-Source: AGHT+IEdCi/Pgaz4kTdtpnVGws4DgAbvbNR97qHtvesAHH/I3BVeB8b1/zRdqGH7b+d9jRs3sjzduQ==
X-Received: by 2002:a17:903:2305:b0:1d4:42f:d39b with SMTP id
 d5-20020a170903230500b001d4042fd39bmr3520180plh.3.1704646895804; 
 Sun, 07 Jan 2024 09:01:35 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:01:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH 0/9] tests/avocado: ppc additions and other fixes
Date: Mon,  8 Jan 2024 03:01:10 +1000
Message-ID: <20240107170119.82222-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is a set of ppc avocado tests that I have posted before, but
it has also grown a few misc changes, and patch 2 creates a
dependency with the added ppc tests that use the
AVOCADO_ALLOW_LONG_RUNTIME it introduces. I could take patches 2-3
via the ppc tree if they get acked, but happy to rebase ppc tests
if they'd better go via testing tree.

Thanks,
Nick

Nicholas Piggin (9):
  gitlab: fix s390x tag for avocado-system-centos
  tests/avocado: mark boot_linux.py long runtime instead of flaky
  tests/avocado: Mark x86-64 boot_linux.py TCG tests as long runtime
  tests/avocado: Enable replay_linux.py on ppc64 pseries
  tests/avocado: ppc add powernv10 boot_linux_console test
  tests/avocado: Add ppc pseries and powernv hash MMU tests
  tests/avocado: Add pseries KVM boot_linux test
  tests/avocado: ppc add hypervisor tests
  tests/avocado: Add FreeBSD distro boot tests for ppc

 MAINTAINERS                         |   1 +
 docs/devel/testing.rst              |   8 ++
 .gitlab-ci.d/buildtest.yml          |   2 +-
 tests/avocado/boot_freebsd.py       | 106 +++++++++++++++
 tests/avocado/boot_linux.py         |  32 ++---
 tests/avocado/boot_linux_console.py |   8 ++
 tests/avocado/ppc_hv_tests.py       | 201 ++++++++++++++++++++++++++++
 tests/avocado/ppc_powernv.py        |  23 +++-
 tests/avocado/ppc_pseries.py        |  20 ++-
 tests/avocado/replay_linux.py       |  76 ++++++++++-
 10 files changed, 453 insertions(+), 24 deletions(-)
 create mode 100644 tests/avocado/boot_freebsd.py
 create mode 100644 tests/avocado/ppc_hv_tests.py

-- 
2.42.0


