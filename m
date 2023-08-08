Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93920773AB3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYP-0001D1-I3; Tue, 08 Aug 2023 10:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYA-0001CV-5A
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:07 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNY6-00009u-HC
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc6624623cso23297395ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504339; x=1692109139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aBIkb4jvPILmWT/uZb5pTiVCZf51hNPEsXjEbWpzlBI=;
 b=aLco9V7LzesxWZpXiHDZF5AdiW9bAZ/g6lbyieSPw5ish3PeyeBc/SB7NnccxQPntx
 b5myfbDnRzHylUm0AtMr0XvFrzWEVzWJd6R05eUYrVFgG2xxBD4U+Z2sLTrpZLCrqm+m
 2a2576TBzUpJkUvGwcQuar4fej5XlHy9AVsU4uZZ71d3IGAnEsVLYD04DQjJFPqj0iay
 WbeCgf2z2KpkpG+0WyqxUcVg1xWnJi4JUHb7WigAWz8gE/CbTaCMhPFWogL80NHsQn4v
 jWX+RKuhA9Qrnysrlq7pzIekGMIWHhNj9hD3ymVgRZZwYRnmUplzMF4FQsMmK+1rDziP
 Mvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504339; x=1692109139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBIkb4jvPILmWT/uZb5pTiVCZf51hNPEsXjEbWpzlBI=;
 b=A2N15xAKJJqUrbqWc0hZImeaR1J0AM+wsWQDc2/iU8HaNWC//hVlAPIjSLwtFFY3BQ
 IXUwnsowp46yptpbWP3qCZbnRDXjWTieS1ry+k1EBafzMUOV9jmafGMiMXvjz+RtNEo/
 sGHd+x8ZSOyI11bOV8r21PmfUb2HjkUYt9xBhUuPifUvpW5jd8qJnmrSiW4jcEZwvxer
 BphKCFU+WcH+umAzgf2o00S289vILy7zQfZSA08DpwtWL/9c2iJxNBc/ZSZaFStl6VDw
 w4wPIlF0cNFZMa1jgnSkDi37vcL5oWO8gm+PmMye9BCsEdWGh2uqz6Wqe9BHEcEMX7Yq
 XSYg==
X-Gm-Message-State: AOJu0Yw3sACz8HfxYEraaZcUsPdtdDO8mDVNEmBjpHdaBq/1UEjZ4Go3
 YObdFKgvysdoUWFlFh0h2gs=
X-Google-Smtp-Source: AGHT+IGnQ3W1pczp4lSG3+0JFU1O0RIwrAc7jnzihv5jqC0lJga6fL7tAfHyPvwt0rvb/L5yAd2+Cg==
X-Received: by 2002:a17:902:7489:b0:1bc:1270:1bfd with SMTP id
 h9-20020a170902748900b001bc12701bfdmr12809083pll.55.1691504338547; 
 Tue, 08 Aug 2023 07:18:58 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:18:57 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v4 00/11] Native Library Calls
Date: Tue,  8 Aug 2023 22:17:28 +0800
Message-Id: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Executing a program under QEMU's user mode subjects the entire
program, including all library calls, to translation. It's important
to understand that many of these library functions are optimized
specifically for the guest architecture. Therefore, their
translation might not yield the most efficient execution.

When the semantics of a library function are well defined, we can
capitalize on this by substituting the translated version with a call
to the native equivalent function.

To achieve tangible results, focus should be given to functions such
as memory-related ('mem*') and string-related ('str*') functions.
These subsets of functions often have the most significant effect
on overall performance, making them optimal candidates for
optimization.

Yeqi Fu (11):
  build: Implement logic for sharing cross-building config files
  build: Implement libnative library and the build machinery for
    libnative
  linux-user: Implement envlist_appendenv and add tests for envlist
  linux-user: Implement native-bypass option support
  linux-user/elfload: Add support for parsing symbols of native
    libraries.
  tcg: Add tcg opcodes and helpers for native library calls
  target/i386: Add support for native library calls
  target/mips: Add support for native library calls
  target/arm: Add support for native library calls
  tests/tcg/multiarch: Add nativecall.c test
  docs/user: Add doc for native library calls

 Makefile                                |   2 +
 accel/tcg/tcg-runtime.h                 |  22 ++++
 common-user/native/Makefile.include     |   9 ++
 common-user/native/Makefile.target      |  22 ++++
 common-user/native/libnative.c          |  67 ++++++++++++
 configs/targets/aarch64-linux-user.mak  |   1 +
 configs/targets/arm-linux-user.mak      |   1 +
 configs/targets/i386-linux-user.mak     |   1 +
 configs/targets/mips-linux-user.mak     |   1 +
 configs/targets/mips64-linux-user.mak   |   1 +
 configs/targets/x86_64-linux-user.mak   |   1 +
 configure                               |  96 ++++++++++++----
 docs/user/index.rst                     |   1 +
 docs/user/native_calls.rst              |  90 +++++++++++++++
 include/native/libnative.h              |   8 ++
 include/native/native.h                 |   9 ++
 include/qemu/envlist.h                  |  13 +++
 include/tcg/tcg-op-common.h             |  11 ++
 include/tcg/tcg.h                       |   9 ++
 linux-user/elfload.c                    |  85 +++++++++++++-
 linux-user/main.c                       |  38 +++++++
 target/arm/tcg/translate-a64.c          |  14 +++
 target/arm/tcg/translate.c              |  11 ++
 target/i386/tcg/translate.c             |  27 +++++
 target/mips/tcg/translate.c             |  21 +++-
 tcg/tcg-op.c                            | 140 ++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target     |  17 +++
 tests/tcg/multiarch/native/nativecall.c |  98 +++++++++++++++++
 tests/unit/meson.build                  |   1 +
 tests/unit/test-envlist.c               |  94 ++++++++++++++++
 util/envlist.c                          |  71 ++++++++++--
 31 files changed, 943 insertions(+), 39 deletions(-)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.c
 create mode 100644 docs/user/native_calls.rst
 create mode 100644 include/native/libnative.h
 create mode 100644 include/native/native.h
 create mode 100644 tests/tcg/multiarch/native/nativecall.c
 create mode 100644 tests/unit/test-envlist.c

-- 
2.34.1


