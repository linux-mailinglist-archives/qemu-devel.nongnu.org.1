Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A179DAD1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwT-0000Ew-1X; Tue, 12 Sep 2023 17:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwQ-0000En-IR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwN-0007T1-Ih
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebbfso2466534b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554137; x=1695158937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ReoiDQaxC2qH22+a0QiwGp2r8VR4BZ4EV2b4LRNB448=;
 b=PlhVB8jl3U3eb/T3/k1oXJiAidlGoqW4s1Hj4TT5OVyKTudqRm/EcYrLihiIi4Apn7
 u7ILwBS64RpVryLqDx/aAq6abbtzmhOVm0H3FgEcFxwaL7NI8Pd7E61rS6YuDP/0q44C
 HMfpjHADfDa2oMg9R9HSDHxCl6+Dqqnxa5iBSaA5+8/w8fqwh+D7ygQqNYNShWNSrd3T
 pOzz53Hj2wCd1W0MQBzIVcYTQibFimbOSeAR069vKDrXuw8REz/+ziJj2uULvsGqzMAm
 nROCoa/BwmOFwhXaX4xgzLTMgGlvl+BpAbPuCiJyffDbFenUnHFwQFMEX8rj/uJMxndc
 qikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554137; x=1695158937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ReoiDQaxC2qH22+a0QiwGp2r8VR4BZ4EV2b4LRNB448=;
 b=QeOAPmpb4LiXD4eFF/T/yOrxiI4Hj4Nr13YHj2tI8lq7FFZEeia4Nal8/B4tkKZ2Y/
 p6SFMR92z/QiTG5cKGA4SGO8YgPk5Or5+dw9tq3/rkH1WwhISGnt0roqWrc6kRMiB2Vj
 lp/p3SPpXpYdcW8qWMW8aYxtnwu+GfX2ORjalyH7O/jXYqcCioMgJ2+ETHpzoZ7qOZpW
 TIVFOyYKvuNmdgCCHgRqbc/CvsaWud3vvKo12m8DWEGIx9vD7uqf1Xsh5l4Z/SQzSB5f
 wG0nzRbefdFPOyRkz6rPr12R/CsHQyM6G7AA9v8DmJw2FSQ/efudcFZag8fbo5f4zDnN
 FQ4A==
X-Gm-Message-State: AOJu0YwedKlf91K8xzXr+vX5xlcbuQrVCdNC1VCjcVQohLfmkIj5s1eW
 QtAlR5RiO71JWTZuJ9H/1Ak=
X-Google-Smtp-Source: AGHT+IEALSaG3MFqNeG02QsMG+3Wr6DC06VxN724jvkyhg4csl4gP/5dUpDZRiz+srrt1qtsfIKvNg==
X-Received: by 2002:a05:6a20:3d04:b0:132:c07d:9dd2 with SMTP id
 y4-20020a056a203d0400b00132c07d9dd2mr843986pzi.39.1694554136990; 
 Tue, 12 Sep 2023 14:28:56 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:28:56 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v6 0/9] Native Library Calls
Date: Wed, 13 Sep 2023 05:28:33 +0800
Message-Id: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x430.google.com
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

Yeqi Fu (9):
  build: Implement logic for sharing cross-building config files
  build: Implement libnative library and the build machinery for
    libnative
  linux-user: Implement native-bypass option support
  tcg: Add tcg opcodes and helpers for native library calls
  target/i386: Add support for native library calls
  target/mips: Add support for native library calls
  target/arm: Add support for native library calls
  tests/tcg/multiarch: Add nativecall.c test
  docs/user: Add doc for native library calls

 Makefile                                |   2 +
 accel/tcg/tcg-runtime.c                 |  66 ++++++++++
 accel/tcg/tcg-runtime.h                 |  12 ++
 common-user/native/Makefile.include     |   8 ++
 common-user/native/Makefile.target      |  22 ++++
 common-user/native/libnative.S          |  51 ++++++++
 configs/targets/aarch64-linux-user.mak  |   1 +
 configs/targets/arm-linux-user.mak      |   1 +
 configs/targets/i386-linux-user.mak     |   1 +
 configs/targets/mips-linux-user.mak     |   1 +
 configs/targets/mips64-linux-user.mak   |   1 +
 configs/targets/x86_64-linux-user.mak   |   1 +
 configure                               | 100 +++++++++++----
 docs/user/index.rst                     |   1 +
 docs/user/native_calls.rst              |  91 ++++++++++++++
 include/exec/helper-head.h              |   1 +
 include/native/native-defs.h            |  41 +++++++
 include/native/native.h                 |   7 ++
 include/tcg/tcg-op-common.h             |  13 ++
 include/tcg/tcg-op.h                    |   2 +
 include/tcg/tcg.h                       |   8 ++
 linux-user/main.c                       |  20 +++
 linux-user/syscall.c                    |  55 +++++++++
 target/arm/tcg/translate-a64.c          |  32 +++++
 target/arm/tcg/translate.c              |  29 +++++
 target/arm/tcg/translate.h              |   5 +
 target/i386/tcg/translate.c             |  38 ++++++
 target/mips/tcg/translate.c             |  30 ++++-
 tcg/tcg-op.c                            |  36 ++++++
 tcg/tcg.c                               | 154 ++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target     |  32 +++++
 tests/tcg/multiarch/native/nativecall.c | 132 ++++++++++++++++++++
 32 files changed, 970 insertions(+), 24 deletions(-)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.S
 create mode 100644 docs/user/native_calls.rst
 create mode 100644 include/native/native-defs.h
 create mode 100644 include/native/native.h
 create mode 100644 tests/tcg/multiarch/native/nativecall.c

-- 
2.34.1


