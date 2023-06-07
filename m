Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90AA72668C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wRl-0006yw-GE; Wed, 07 Jun 2023 12:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wRL-0006yb-SR
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:55:24 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wRG-0001Zt-W4
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:55:19 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-75d518f6f74so377555585a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686156912; x=1688748912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0P5WffgCUYQGlH/E0Lhd3aJYet1tELH+EQMgsv6cOg=;
 b=N9zJ4mhw6dRasUUJCCVLohlTPekW1CZT5rA0LT65RVlqsMgHSdjv04HYO3TWq30fYe
 JSVv7xz7nuvRhqNjXRmdWQKLKr0XGwQVoK9FtavKIKLprXAP5FNSY170s0nHEIx5G+SF
 MhqtUnl+ETxjNwtNggZ0ny4SK0u6CDN41Nk3KAFKCVCLT7HABw2XwsKERYRhbyhpBkSR
 dqZSBo1oDlwpsxHpQmoUevNHoDp7Xs6AIUVzKPmk95g7D7pvTQeL93cNyRbQ/db8Ntwy
 5t0xsCdJmhcyboi0+WMbdhxco22g91fWYWPGC8JQBc4cQ6ZDr+nLiCcNNblEMb8hs8Te
 8YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686156912; x=1688748912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0P5WffgCUYQGlH/E0Lhd3aJYet1tELH+EQMgsv6cOg=;
 b=kaV4VEKmRqzl+I5j/hMCIXrLk6uQVg22vIOEzLDeOXBBqc4C+joY0vWpiEtGwwt804
 NWqw+mp/ZPL+STcvP7jmFZ1rTXED2hXPDNbGrCe8rCfZoEIfeLTqONT3c+KuRDAmSbxX
 O7kherxTwTkULP6Qp5IxneLyUkzq+jE3dBrqvZe/uCr1xOlM/5IbZ3ojv0AX7+VtEWf0
 IP4Dj0n4CBJ5xYM4N6w2uip74NWIfEl0DfhBt8M/Zbt3UxFxbqMxrYXr4HJ2LYWXjVSO
 QNFfTQKRC3dFcWETNB7i4CkK/MssZUNt67IZpnWTFoqIly9R80JEAXpSbrpc9I6jd1u7
 HJKQ==
X-Gm-Message-State: AC+VfDwgGQ+c+sMTJSSRAxPGR8TI1taRbtdCnO04X+LebZzXGJYvayYk
 PB2b1TnVbIrcaoKE6l9iALEXFuNKB8CAZpnk
X-Google-Smtp-Source: ACHHUZ4D3tUrrfeAEM1DZ8KNOXJXw4F3t85Gn3o518VkWFS5mn5m6x/fKVG1LvHoHBrPe8fwBhhVog==
X-Received: by 2002:a17:90a:6097:b0:259:bdb:6956 with SMTP id
 z23-20020a17090a609700b002590bdb6956mr2479713pji.7.1686156545868; 
 Wed, 07 Jun 2023 09:49:05 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:05 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v2 0/6] Native Library Calls
Date: Thu,  8 Jun 2023 00:47:44 +0800
Message-Id: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch introduces a set of feature instructions for native calls
and provides helpers to translate these instructions to corresponding
native functions. A shared library is also implemented, where native
functions are rewritten as feature instructions. At runtime, user
programs load the shared library, and feature instructions are
executed when native functions are called. This patch is applicable
to user programs with architectures x86, x86_64, arm, aarch64, mips,
and mips64. To build, compile libnative.c into a shared library for
the user program's architecture and run the
'../configure --enable-user-native-call && make' command.

Yeqi Fu (6):
  build: Add configure options for native calls
  Add the libnative library
  target/i386: Add native library calls
  target/mips: Add native library calls
  target/arm: Add native library calls
  linux-user: Add '-native-bypass' option

 Makefile                             |  4 ++
 common-user/native/Makefile.include  |  9 ++++
 common-user/native/Makefile.target   | 22 ++++++++++
 common-user/native/libnative.c       | 65 ++++++++++++++++++++++++++++
 configure                            | 50 +++++++++++++++++++++
 docs/devel/build-system.rst          |  4 ++
 include/native/libnative.h           | 11 +++++
 include/native/native-func.h         | 11 +++++
 include/qemu/envlist.h               |  1 +
 linux-user/main.c                    | 23 ++++++++++
 meson.build                          |  8 ++++
 meson_options.txt                    |  2 +
 scripts/meson-buildoptions.sh        |  4 ++
 target/arm/helper.c                  | 47 ++++++++++++++++++++
 target/arm/helper.h                  |  6 +++
 target/arm/tcg/translate-a64.c       | 22 ++++++++++
 target/arm/tcg/translate.c           | 25 ++++++++++-
 target/arm/tcg/translate.h           | 19 ++++++++
 target/i386/helper.h                 |  6 +++
 target/i386/tcg/translate.c          | 20 +++++++++
 target/i386/tcg/user/meson.build     |  1 +
 target/i386/tcg/user/native_helper.c | 65 ++++++++++++++++++++++++++++
 target/mips/helper.h                 |  6 +++
 target/mips/tcg/meson.build          |  1 +
 target/mips/tcg/native_helper.c      | 55 +++++++++++++++++++++++
 target/mips/tcg/translate.c          | 20 ++++++++-
 target/mips/tcg/translate.h          | 12 +++++
 util/envlist.c                       | 56 ++++++++++++++++++++++++
 28 files changed, 573 insertions(+), 2 deletions(-)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.c
 create mode 100644 include/native/libnative.h
 create mode 100644 include/native/native-func.h
 create mode 100644 target/i386/tcg/user/native_helper.c
 create mode 100644 target/mips/tcg/native_helper.c

-- 
2.34.1


