Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C99573D480
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGT-0005R7-V8; Sun, 25 Jun 2023 17:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGR-0005Qc-W5
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGQ-0003Oj-E1
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b7fef01fe4so2142775ad.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728436; x=1690320436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/XX2RoPaJvzP+yUYINLnVKws0bFzBHB/Z6HuNyeIH+Q=;
 b=q4aaFEjFWRKh3skEnU0agPaJpz/WcBiDJkzK3iHTHYbmXDvn2kDQs49Iv8jvAgsGZc
 v7S0ijpIKNLYkmXb0YZvUZQZw4LNy0pea57Y7OLCSORd94JwBS6qXKH/okRLa48g8jZZ
 hYgsfZFg2TmDRm9l6twlfzlBLEy735RJQMliaiSWM3zbs7ytmZ6EoRSYyejYfPDSnG9G
 CWCHduo+rpsFTHoX+oYedJQt5/iLxU3EI092WTbQ/MyrRSOG64oIjoZKxoRCBrunwSRQ
 JhBNjTAGF7q65FkqFCw0Wgipqe2o27RBH/BlHM8t5purIjpWPXzdBUHoUTAKFiLzF4Qa
 EtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728436; x=1690320436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XX2RoPaJvzP+yUYINLnVKws0bFzBHB/Z6HuNyeIH+Q=;
 b=Oh6XBEwBtcb5XWFjEGDnBf/5fHk6VOIEp2vKHIw7j1vjD9Q+F8wBPomJTQBgZ8OGVW
 A6K1kxRx3cfdSjsEVGqDKru3OooHbJ+6OUoaLCrK96ErdH8Sx17oN1/+539d3foovSKG
 H5PJfPi7WYwZhAIAw63J6xvqFp1fQT3EMec2mhFRD24qNlNeynEpJMXWp56DJcQFw7um
 vAGB/6BuyAv78YMDyKMae63nW/UI1ga1uvAfrJKLSuh0lP9nZMXNbcKatfqrm5Sz/f47
 ZmkJECnqIVqgSx0NP8LlDJv3afAR92g97Ni+Q/NjgH/2QGYyhIVysq2ayYPB40GGGilQ
 +ldQ==
X-Gm-Message-State: AC+VfDxqV/7JObUmZSQ7HlNLNYHAGsx3/RzlFmSIGBOr6JFa84EBaRRP
 B9CQPWqheo83ndrxI8fHKBg=
X-Google-Smtp-Source: ACHHUZ6cYGgnzAe3xOPotwNElYHRVKh3H4/jbxR0TWeJaYbkR/9uiLtxDV7w3DL3TwrVTeOpB9KDOw==
X-Received: by 2002:a17:903:1205:b0:1b5:4859:ef36 with SMTP id
 l5-20020a170903120500b001b54859ef36mr3157922plh.57.1687728436393; 
 Sun, 25 Jun 2023 14:27:16 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:15 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v3 00/10] Native Library Calls
Date: Mon, 26 Jun 2023 05:26:57 +0800
Message-Id: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch introduces a set of specialized instructions for native calls
and provides helpers to translate these instructions to corresponding
native functions. A shared library is also implemented, where native
functions are rewritten as specialized instructions. At runtime, user
programs load the shared library, and specialized instructions are
executed when native functions are called. This patch is applicable
to user programs with architectures x86, x86_64, arm, aarch64, mips,
and mips64.

Yeqi Fu (10):
  docs: Add specification for native library calls
  build: Add configure options for native calls
  build: Implement libnative library and configure options
  linux-user: Implement envlist_appendenv
  linux-user: Implement native-bypass option support
  accel/tcg: Add support for native library calls
  target/i386: Add support for native library calls
  target/mips: Add support for native library calls
  target/arm: Add support for native library calls
  tests/tcg/multiarch: Add nativecalls.c test

 Makefile                                 |   2 +
 accel/tcg/tcg-runtime.c                  |  37 ++++++++
 accel/tcg/tcg-runtime.h                  |   4 +
 common-user/native/Makefile.include      |   9 ++
 common-user/native/Makefile.target       |  26 ++++++
 common-user/native/libnative.c           | 112 +++++++++++++++++++++++
 configs/targets/aarch64-linux-user.mak   |   1 +
 configs/targets/arm-linux-user.mak       |   1 +
 configs/targets/i386-linux-user.mak      |   1 +
 configs/targets/mips-linux-user.mak      |   1 +
 configs/targets/mips64-linux-user.mak    |   1 +
 configs/targets/x86_64-linux-user.mak    |   1 +
 configure                                |  84 +++++++++++++----
 docs/native_calls.txt                    |  70 ++++++++++++++
 include/native/libnative.h               |  12 +++
 include/native/native-calls.h            |  75 +++++++++++++++
 include/native/native-defs.h             |  65 +++++++++++++
 include/qemu/envlist.h                   |   1 +
 linux-user/main.c                        |  36 ++++++++
 target/arm/tcg/translate-a64.c           |  27 +++++-
 target/arm/tcg/translate.c               |  25 ++++-
 target/arm/tcg/translate.h               |   6 ++
 target/i386/tcg/translate.c              |  33 +++++++
 target/mips/tcg/translate.c              |  26 ++++++
 target/mips/tcg/translate.h              |   2 +
 tests/tcg/multiarch/Makefile.target      |   9 +-
 tests/tcg/multiarch/native/nativecalls.c | 103 +++++++++++++++++++++
 util/envlist.c                           |  61 ++++++++++++
 28 files changed, 810 insertions(+), 21 deletions(-)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.c
 create mode 100644 docs/native_calls.txt
 create mode 100644 include/native/libnative.h
 create mode 100644 include/native/native-calls.h
 create mode 100644 include/native/native-defs.h
 create mode 100644 tests/tcg/multiarch/native/nativecalls.c

-- 
2.34.1


