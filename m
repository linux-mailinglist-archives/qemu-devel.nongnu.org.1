Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508AD78D06C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb83k-0002rO-1o; Tue, 29 Aug 2023 19:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83h-0002Xz-SD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb83f-0001Lh-4L
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:23:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so39268345ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693351417; x=1693956217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4dMU2MqKObUooD8HDCDWw/oHlyWw4B/N3RU9lW80i4=;
 b=win5P34Jqvz28SdQazFc1ShNtCVztv1M/kxWfqKNAQKapaFn6724xPfLsocVqDBL1p
 UsatMJzMwe9IgHVzjaNl5FmrL/Z+0DPQl3k3CjXBhUgFsNUixMAd3DQ3TyXGAMiu4psA
 zXfHq/nQlleawCfAWd5+w4VlnXrrnmZo4egGwybRyGbt1g0MLaPQzSWSBSrX1J4ibS8R
 4TZDmG8mQYFVJas5yYzFXD0OK9mNV+pr3UY6HSjWgbT/VzrnYGEyu1dVBawCsuS9cUxr
 ykkI1siBoomtv19p95qCtaYR2TTavdjNkZXEv4GAPQ8PSH8HvCMyIkmv3jHJ7Krwoinc
 MqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693351417; x=1693956217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4dMU2MqKObUooD8HDCDWw/oHlyWw4B/N3RU9lW80i4=;
 b=dZlRPWFuv9rMi0KQq0HfbQP0tTqwy3YH119EhncfB6z8ozHp8CF5LxqiuhCy4POd3T
 7hIenS1QTXGPjAvccXbUVoXIV9X/+t5NcAo1ApE5c2jkoc5eB5JyT7TcWPUKVOLcxgZh
 vV75cl7MHa4s91TiED9/bAH7Lgj//iDbRNSk9B7an5LWVbY5Gnly/Iv36H08EUAh4BkP
 SbpHAIIgpAx+JuFGsMqPicOYz9T014tpTtNbYQzdJ88aUx9L/u3cDLW0TXGFlPcrsi7P
 5Dx5lPQ3vsX/eH1ecciyQOG7j8hAbu2ingDto2qJw+qXnUKlP6iRn6GFwZhGywo/unE3
 FwEw==
X-Gm-Message-State: AOJu0YwADJ1zZnJZ1WRWfy9VCPY8Lw6Mntkqz9l8ngPt9jCgYa10t+vh
 AlAJsO6rE42HsZ6NEYQI+iPunXInEjkW4hlAHXM=
X-Google-Smtp-Source: AGHT+IErCsCmlYm4pvFBKSoLReQA0dXe8dWuTdkNp68x+7WZqa1M4BwEApZdX2pGzskZEDygfvAQzw==
X-Received: by 2002:a17:902:efc1:b0:1bc:2abb:4e98 with SMTP id
 ja1-20020a170902efc100b001bc2abb4e98mr472913plb.21.1693351417117; 
 Tue, 29 Aug 2023 16:23:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001b9dadf8bd2sm9829970plg.190.2023.08.29.16.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 16:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: aaron@os.amperecomputing.com,
	qemu-arm@nongnu.org
Subject: [PATCH v5 00/12] Implement Most ARMv8.3 Pointer Authentication
 Features
Date: Tue, 29 Aug 2023 16:23:23 -0700
Message-Id: <20230829232335.965414-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Changes for v5:
  * Updates for review.
  * Include linux-user ESR changes.

Patch 10 is the only one without review.


r~


Aaron Lindsay (6):
  target/arm: Add ID_AA64ISAR2_EL1
  target/arm: Add feature detection for FEAT_Pauth2 and extensions
  target/arm: Implement FEAT_EPAC
  target/arm: Implement FEAT_Pauth2
  targer/arm: Inform helpers whether a PAC instruction is 'combined'
  target/arm: Implement FEAT_FPAC and FEAT_FPACCOMBINE

Richard Henderson (6):
  tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
  target/arm: Don't change pauth features when changing algorithm
  target/arm: Implement FEAT_PACQARMA3
  linux-user/aarch64: Add ESR signal frame for SIGSEGV, SIGBUS
  linux-user/aarch64: Fix normal SIGILL si_code
  linux-user/aarch64: Add ESR signal frame for PACFAIL

 docs/system/arm/cpu-features.rst  |  21 ++--
 docs/system/arm/emulation.rst     |   7 ++
 target/arm/cpu.h                  |  49 ++++++--
 target/arm/syndrome.h             |   7 ++
 target/arm/tcg/helper-a64.h       |   4 +
 tests/tcg/aarch64/pauth.h         |  23 ++++
 linux-user/aarch64/cpu_loop.c     |   7 +-
 linux-user/aarch64/signal.c       |  58 +++++++++-
 target/arm/arm-qmp-cmds.c         |   2 +-
 target/arm/cpu64.c                |  86 ++++++++++----
 target/arm/helper.c               |   4 +-
 target/arm/hvf/hvf.c              |   1 +
 target/arm/kvm64.c                |   2 +
 target/arm/tcg/cpu64.c            |   2 +
 target/arm/tcg/pauth_helper.c     | 180 ++++++++++++++++++++++++------
 target/arm/tcg/tlb_helper.c       |   8 +-
 target/arm/tcg/translate-a64.c    |  12 +-
 tests/qtest/arm-cpu-features.c    |  12 +-
 tests/tcg/aarch64/pauth-2.c       |  77 +++++++++++--
 tests/tcg/aarch64/pauth-4.c       |  18 ++-
 tests/tcg/aarch64/pauth-5.c       |  10 ++
 tests/tcg/aarch64/Makefile.target |   6 +-
 22 files changed, 497 insertions(+), 99 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth.h

-- 
2.34.1


