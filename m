Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EA777C64
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:39:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iT-0005Ik-PC; Thu, 10 Aug 2023 11:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iS-0005Hg-GR
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:48 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iN-0003DJ-U5
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:48 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so16368281fa.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681802; x=1692286602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QpJlLC+2rPb/GCH1pCbOPBgLpIEQvbMEnU2tGVcF2MQ=;
 b=Pw0utXnsmDKFz87cK5160z6HTHc2XQRm8KhcD+V+UCB5cQSyauzPykRAPxNrXJ6Yon
 1Bb7GRvrbrkoRAYW7ddpyBZgTsdjAbqhn7yJ/ptNai+egThcLCBfmz82oXxwZuSOmrIz
 vUTqOZzp+dhmJ2hbzNYJ8diAgwMHbOhULALrBnj88wDRo465iA0WZx0cxX2dLqTBRfkU
 L4FQ7ZNsonTGwQUMthGEp6VgEK6y+F8+hUTVtwHoVmMnqsXvjWUsmy7Wbu+3rArd+qZJ
 GGrEnn9QO8bRJ4VsHxCRFg/q93rrFDX/o82z6eryfRjVlswQ1aYtXY7JIEopMkmVpL4a
 myOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681802; x=1692286602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpJlLC+2rPb/GCH1pCbOPBgLpIEQvbMEnU2tGVcF2MQ=;
 b=Yx0Nj+MGfe4K1Nomg3OL4SLvslYi+zUCWv+PmXE1z/5jDnLxGTT/xOCnYe/j2TDwGW
 /7cTg8iwg53pXLCjhRelxe43nTGKkpHVud4/+OhkSCxY7I+L2bQNIfkyu3osMVqpU1ry
 9VPrcgYj6LZYrXsN1DXGjpZB3j5A8w8bIR9TFuPeR1JBhUkRvsRsl/T8JNfdBlyyyLu9
 d1+YRjyM/M0/F9tluEPpFGtUUDFIOUtiD6B+H2qlxHKzA+QakEJ/6VotLdZcVdz0VRmZ
 sJEnexXIAzyZAlyCuHgI6NKqpLTgjkt4EQw2C/uh14bfIOJoj02vBPGfMdkYIVbrQx0B
 FzkQ==
X-Gm-Message-State: AOJu0YynPKQ2W8o9eKowiKk25cparKRKoKetnWfsjJHzgDGIUnHz3uVB
 3xPD0lznoRCIn5Ws7dLJyfX49Q==
X-Google-Smtp-Source: AGHT+IHDLwEDS2FGaKCPqH9YbO9rnvrXLu4htgkQXlEWBZ1zsBI0gMQEl1HwwObGhAsZxjRiE6K+zQ==
X-Received: by 2002:a2e:8653:0:b0:2b7:4169:fcf5 with SMTP id
 i19-20020a2e8653000000b002b74169fcf5mr2434628ljj.37.1691681801772; 
 Thu, 10 Aug 2023 08:36:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a05600c214100b003fe215e4492sm2511175wml.4.2023.08.10.08.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B01921FFBB;
 Thu, 10 Aug 2023 16:36:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 0/8] some testing and gdbstub fixes
Date: Thu, 10 Aug 2023 16:36:32 +0100
Message-Id: <20230810153640.1879717-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is mostly gdbstub focused but I cleaned up some bits while I was
in the testing makefiles. This is mostly to make the "check-tcg"
output as clean as possible without ugly line wraps. I tried to
eliminate the gdbstub info() output but sadly this is harder than
expected.

I've tweaked the gdbstub handling for Ctrl-c packets as suggested by
Matheus. While I was there I also noticed we were being a bit precious
about gdb sending preemptive ACKS so I fixed that as well.

I don't know if this is all late 8.1-rc material but its fairly simple
testing updates and the ccache stuff from Daniel should help as well.

Alex Bennée (7):
  tests/docker: cleanup non-verbose output
  tests/tcg: remove quoting for info output
  tests: remove test-gdbstub.py
  tests/tcg: clean-up gdb confirm/pagination settings
  tests/tcg: ensure system-mode gdb tests start stopped
  gdbstub: more fixes for client Ctrl-C handling
  gdbstub: don't complain about preemptive ACK chars

Daniel P. Berrangé (1):
  gitlab: enable ccache for many build jobs

 docs/devel/ci-jobs.rst.inc                    |   7 +
 gdbstub/gdbstub.c                             |  10 +-
 .gitlab-ci.d/buildtest-template.yml           |  11 ++
 .gitlab-ci.d/crossbuild-template.yml          |  26 +++
 .gitlab-ci.d/windows.yml                      |  13 +-
 gdbstub/trace-events                          |   1 +
 tests/docker/Makefile.include                 |   6 +-
 .../dockerfiles/debian-hexagon-cross.docker   |   9 +-
 tests/guest-debug/run-test.py                 |  11 +-
 tests/guest-debug/test-gdbstub.py             | 177 ------------------
 tests/tcg/aarch64/Makefile.target             |   2 +-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   |   3 -
 tests/tcg/aarch64/gdbstub/test-sve.py         |   3 -
 tests/tcg/multiarch/gdbstub/memory.py         |   3 -
 tests/tcg/multiarch/gdbstub/sha1.py           |   4 -
 .../multiarch/gdbstub/test-proc-mappings.py   |   4 -
 .../multiarch/gdbstub/test-qxfer-auxv-read.py |   4 -
 .../gdbstub/test-thread-breakpoint.py         |   4 -
 .../multiarch/system/Makefile.softmmu-target  |   4 +-
 tests/tcg/s390x/gdbstub/test-signals-s390x.py |   4 -
 tests/tcg/s390x/gdbstub/test-svc.py           |   4 -
 21 files changed, 83 insertions(+), 227 deletions(-)
 delete mode 100644 tests/guest-debug/test-gdbstub.py

-- 
2.39.2


