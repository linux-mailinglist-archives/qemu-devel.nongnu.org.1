Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2167884D8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTxe-0006zI-Pp; Fri, 25 Aug 2023 06:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxc-0006z8-PW
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxa-0004iN-I8
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:36 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a9b40fc500so73511b6e.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692958953; x=1693563753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AVZwPt4GdiDESenwGL03NONcE+TGzw/6HeSMwxCtziA=;
 b=DhXn2bpgZAohjnpI9ZYEZDbhQgcZfmQw1MQCnRKFeR2tA1gfKdVDaH7u2Wav3cMCdk
 L+zYeHIX0MyAhZiaBVTlRM9qay3GZe++7Xy9Fx3eO4T4YP1c7XELi5G7J2v3QdBoR42G
 4jXPmeF+8F3AkHeCGYZ8oVUZN+YBHDz7Lx5FG2INePtWQiRfreM0rFOVN0pUzSH4jAsD
 iLDJohMOFevA37n0gqDAS6jabZaSmuOgacn27oMCtdPJe0S5E108Klb1GZMgi6ZG7Nl3
 3F5mIApx76BsVWj46Rn8Ur4qcaSnOB9zTElXh5UlnPknfEw29GFt060R626cGU3vKmxk
 YW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692958953; x=1693563753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVZwPt4GdiDESenwGL03NONcE+TGzw/6HeSMwxCtziA=;
 b=IcmeG3vPgDvqCyfE+50VgQfwbQ9jK5f39K/+KMR1HbQdra4JFoFLoPa3D74PMuce7I
 eHJ2U92klS8h8eH8ZPFj98cPY3TmqnQMDeTvww3eAqhPlkbhWyZre9ZLVVFRDg7RSqxU
 L30porY/iOiOiHliXyFcb78xeJ+TEJ0Jg8fx53BX6/Ao7BAueAiJcWeKR/8w7HlhNoZg
 /pqCfoXAo2AxJR3PWBKlFwT1tmu7P0sRtSsjGbYMUschIXfaDSH7OOD2XgWq+NxlNJzB
 oD1nn7/N8TEeK+4n8X0ZwLmuMVCnWC8cazSJZ3BGwNR7/wkqD7LiAZpmtJYtei1++yBb
 HsvA==
X-Gm-Message-State: AOJu0Ywa5k/dlQfb+N3n9ZYpIwFVU/LxlJe31hZIMlsR0mKX/pIwESz5
 v77a9gKv2OE66nR7TQiro7M=
X-Google-Smtp-Source: AGHT+IEdZ9YYn2CRvksczF2F2Pmhk+sleIcRZzqPdf1B25SHPVx7FtZcUvlL1RR8r9+IMhc6vSEsiQ==
X-Received: by 2002:a05:6808:13c3:b0:3a7:7e66:2198 with SMTP id
 d3-20020a05680813c300b003a77e662198mr2833662oiw.32.1692958952996; 
 Fri, 25 Aug 2023 03:22:32 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa781c5000000b0068a077847c7sm1220954pfn.135.2023.08.25.03.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:22:32 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v5 00/10] Native Library Calls
Date: Fri, 25 Aug 2023 18:19:58 +0800
Message-Id: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-oi1-x230.google.com
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

Yeqi Fu (10):
  build: Implement logic for sharing cross-building config files
  build: Implement libnative library and the build machinery for
    libnative
  linux-user: Implement envlist_appendenv and add tests for envlist
  linux-user: Implement native-bypass option support
  tcg: Add tcg opcodes and helpers for native library calls
  target/i386: Add support for native library calls
  target/mips: Add support for native library calls
  target/arm: Add support for native library calls
  tests/tcg/multiarch: Add nativecall.c test
  docs/user: Add doc for native library calls

 Makefile                                |   2 +
 accel/tcg/tcg-runtime.h                 |  22 +++
 common-user/native/Makefile.include     |   9 ++
 common-user/native/Makefile.target      |  22 +++
 common-user/native/libnative.S          |  69 +++++++++
 configs/targets/aarch64-linux-user.mak  |   1 +
 configs/targets/arm-linux-user.mak      |   1 +
 configs/targets/i386-linux-user.mak     |   1 +
 configs/targets/mips-linux-user.mak     |   1 +
 configs/targets/mips64-linux-user.mak   |   1 +
 configs/targets/x86_64-linux-user.mak   |   1 +
 configure                               | 100 +++++++++---
 docs/user/index.rst                     |   1 +
 docs/user/native_calls.rst              |  90 +++++++++++
 include/native/native-defs.h            |  42 ++++++
 include/native/native.h                 |   9 ++
 include/qemu/envlist.h                  |  13 ++
 include/tcg/tcg-op-common.h             |  11 ++
 include/tcg/tcg.h                       |   9 ++
 linux-user/main.c                       |  38 +++++
 linux-user/syscall.c                    |  21 +++
 target/arm/tcg/translate-a64.c          |  31 ++++
 target/arm/tcg/translate.c              |  28 ++++
 target/arm/tcg/translate.h              |   5 +
 target/i386/tcg/translate.c             |  37 +++++
 target/mips/tcg/translate.c             |  36 ++++-
 tcg/tcg-op.c                            | 193 +++++++++++++++++++++++-
 tests/tcg/multiarch/Makefile.target     |  30 ++++
 tests/tcg/multiarch/native/nativecall.c | 121 +++++++++++++++
 tests/unit/meson.build                  |   1 +
 tests/unit/test-envlist.c               |  94 ++++++++++++
 util/envlist.c                          |  67 ++++++--
 32 files changed, 1072 insertions(+), 35 deletions(-)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.S
 create mode 100644 docs/user/native_calls.rst
 create mode 100644 include/native/native-defs.h
 create mode 100644 include/native/native.h
 create mode 100644 tests/tcg/multiarch/native/nativecall.c
 create mode 100644 tests/unit/test-envlist.c

-- 
2.34.1


