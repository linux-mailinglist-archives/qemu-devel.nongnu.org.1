Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16F7B3D96
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 04:18:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmPWN-0000Fa-5z; Fri, 29 Sep 2023 22:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPWG-0000E0-7Z
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmPW1-0001yS-I8
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 22:15:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27758c8f579so7860560a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696040131; x=1696644931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KoBkFaix/7dll0Vuje13LKyPYe0pk/ugwgB43PM6YAU=;
 b=HhVCbEM1t/iiK5SWEJvQ3xuzsjYpei0sxIshuXbs/2FZ8lUis93m2fHmDLd+Wo7xRz
 Pvz1TJEI4yrTBxUcDp7U14F9BwI/Ri8fBaEC/Pd/xSNjiAKPbA3VSsICcljs4b0UUred
 veWp3ATvAHaqXCW+lMST4ZiuA0Ewzk8bnYPJ3QLZPYiaK8vU/7bY4UKB8DFGFRS9VFX0
 x5whYScRUrTys0bVzticp5z8ORas9Lj0NqnuS5pzIUOPVayXwnrkz/Exppc9nSiAejxx
 8cVA2VVGAwKhKSUBs4bBCERAA8Fw/eTpdfgFvgc4eiQ5PoMUlnmH4llKTVeI40GR3m6n
 OE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696040131; x=1696644931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoBkFaix/7dll0Vuje13LKyPYe0pk/ugwgB43PM6YAU=;
 b=QVm2qqJ03N0QE+2N08DflYHZd6p6HhArEyx86vTTl2MIfEmFe48K/IzBui8nVQdofR
 A9mFI2SE1ILMm2shniY9M+azuwc7ls8irjjMywprgF2uw6PjvW5Omf7EQ2DP/OZMDh7x
 mJupq7chAUosYRYLahI/emawvbhu6ghNP3pZuTckkTn4qlzuwPMjBdhnCGUPE9dWLSq/
 tZCBshjL6Kc0ORM/W9OZAE3G7u4PN1LBV3MKhi81feOexkKr2c1ifu+AtBCX3x7vQZdX
 ThP9o958OsnuBNnGH586CWaioChsKr/3eL65+5sGLMSk++Tcb9rKdicEjwGtIEe2WYuq
 /59Q==
X-Gm-Message-State: AOJu0Yxs7cU/3aVt58JegVb6h5Y60f4PLhbFZBrGgyYbdpD4h9sHP3/b
 x7jIeiMghHfqaBoxdgVIwKOcJX7ZGE1J9fQw0qA=
X-Google-Smtp-Source: AGHT+IHA1XLiqEpMSY0CAcAaQCVod/xj/WoojXOMjeeo+YSYzMLFtGNtaP9DH+MyuaKIgVEhCfkIvg==
X-Received: by 2002:a17:90a:64c1:b0:276:5786:e1a0 with SMTP id
 i1-20020a17090a64c100b002765786e1a0mr5478370pjm.13.1696040131163; 
 Fri, 29 Sep 2023 19:15:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fv21-20020a17090b0e9500b002775281b9easm2130692pjb.50.2023.09.29.19.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 19:15:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v6 00/19] linux-user: Implement VDSOs
Date: Fri, 29 Sep 2023 19:15:10 -0700
Message-Id: <20230930021529.987950-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Becase b4 eats a binaries:
  https://gitlab.com/rth7680/qemu/-/tree/lu-vdso

Changes for v6:
  * Revert build-vdso.sh and meson rules.
  * Add update-linux-vdso makefile rule.  Since this is run manually,
    we no longer have a problem with docker images failing to update
    and causing the normal build to fail.

Changes for v5:
  * Integrated cross-compile, via new build-vdso.sh and meson rules.
    However, keep the binaries in the tree for hosts which do not
    have all of the cross-compile machinery.
  * Update our loongarch64 docker image to avoid a binutils bug.

r~


Richard Henderson (19):
  linux-user: Introduce imgsrc_read, imgsrc_read_alloc
  linux-user: Tidy loader_exec
  linux-user: Do not clobber bprm_buf swapping ehdr
  linux-user: Use ImageSource in load_elf_image
  linux-user: Use ImageSource in load_symbols
  linux-user: Replace bprm->fd with bprm->src.fd
  linux-user: Load vdso image if available
  linux-user: Add gen-vdso tool
  linux-user/i386: Add vdso
  linux-user/x86_64: Add vdso
  linux-user/aarch64: Add vdso
  linux-user/arm: Add vdso
  linux-user/hppa: Add vdso
  linux-user/riscv: Add vdso
  linux-user/loongarch64: Add vdso
  linux-user/ppc: Add vdso
  linux-user/s390x: Rename __SIGNAL_FRAMESIZE to STACK_FRAME_OVERHEAD
  linux-user/s390x: Add vdso
  build: Add update-linux-vdso makefile rule

 Makefile                                |  10 +
 linux-user/arm/vdso-asmoffset.h         |   3 +
 linux-user/hppa/vdso-asmoffset.h        |  12 +
 linux-user/i386/vdso-asmoffset.h        |   6 +
 linux-user/loader.h                     |  60 +++-
 linux-user/loongarch64/vdso-asmoffset.h |   8 +
 linux-user/ppc/vdso-asmoffset.h         |  20 ++
 linux-user/riscv/vdso-asmoffset.h       |   9 +
 linux-user/s390x/vdso-asmoffset.h       |   2 +
 linux-user/arm/signal.c                 |  55 ++--
 linux-user/elfload.c                    | 358 +++++++++++++++---------
 linux-user/flatload.c                   |   8 +-
 linux-user/gen-vdso.c                   | 223 +++++++++++++++
 linux-user/hppa/signal.c                |  24 +-
 linux-user/i386/signal.c                |  11 +
 linux-user/linuxload.c                  | 137 +++++++--
 linux-user/loongarch64/signal.c         |  17 +-
 linux-user/ppc/signal.c                 |  31 +-
 linux-user/riscv/signal.c               |   8 +
 linux-user/s390x/signal.c               |   7 +-
 linux-user/gen-vdso-elfn.c.inc          | 314 +++++++++++++++++++++
 linux-user/aarch64/Makefile.vdso        |  15 +
 linux-user/aarch64/meson.build          |  11 +
 linux-user/aarch64/vdso-be.so           | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so           | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S               |  71 +++++
 linux-user/aarch64/vdso.ld              |  72 +++++
 linux-user/arm/Makefile.vdso            |  17 ++
 linux-user/arm/meson.build              |  12 +
 linux-user/arm/vdso-be.so               | Bin 0 -> 2648 bytes
 linux-user/arm/vdso-le.so               | Bin 0 -> 2648 bytes
 linux-user/arm/vdso.S                   | 174 ++++++++++++
 linux-user/arm/vdso.ld                  |  67 +++++
 linux-user/hppa/Makefile.vdso           |  11 +
 linux-user/hppa/meson.build             |   5 +
 linux-user/hppa/vdso.S                  | 165 +++++++++++
 linux-user/hppa/vdso.ld                 |  77 +++++
 linux-user/hppa/vdso.so                 | Bin 0 -> 2104 bytes
 linux-user/i386/Makefile.vdso           |  11 +
 linux-user/i386/meson.build             |   7 +
 linux-user/i386/vdso.S                  | 143 ++++++++++
 linux-user/i386/vdso.ld                 |  76 +++++
 linux-user/i386/vdso.so                 | Bin 0 -> 2672 bytes
 linux-user/loongarch64/Makefile.vdso    |  11 +
 linux-user/loongarch64/meson.build      |   4 +
 linux-user/loongarch64/vdso.S           | 130 +++++++++
 linux-user/loongarch64/vdso.ld          |  73 +++++
 linux-user/loongarch64/vdso.so          | Bin 0 -> 3560 bytes
 linux-user/meson.build                  |   9 +-
 linux-user/ppc/Makefile.vdso            |  20 ++
 linux-user/ppc/meson.build              |  12 +
 linux-user/ppc/vdso-32.ld               |  70 +++++
 linux-user/ppc/vdso-32.so               | Bin 0 -> 3020 bytes
 linux-user/ppc/vdso-64.ld               |  68 +++++
 linux-user/ppc/vdso-64.so               | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso-64le.so             | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso.S                   | 239 ++++++++++++++++
 linux-user/riscv/Makefile.vdso          |  15 +
 linux-user/riscv/meson.build            |   7 +
 linux-user/riscv/vdso-32.so             | Bin 0 -> 2888 bytes
 linux-user/riscv/vdso-64.so             | Bin 0 -> 3840 bytes
 linux-user/riscv/vdso.S                 | 186 ++++++++++++
 linux-user/riscv/vdso.ld                |  74 +++++
 linux-user/s390x/Makefile.vdso          |  11 +
 linux-user/s390x/meson.build            |   6 +
 linux-user/s390x/vdso.S                 |  61 ++++
 linux-user/s390x/vdso.ld                |  69 +++++
 linux-user/s390x/vdso.so                | Bin 0 -> 3464 bytes
 linux-user/x86_64/Makefile.vdso         |  11 +
 linux-user/x86_64/meson.build           |   4 +
 linux-user/x86_64/vdso.S                |  78 ++++++
 linux-user/x86_64/vdso.ld               |  73 +++++
 linux-user/x86_64/vdso.so               | Bin 0 -> 2968 bytes
 73 files changed, 3274 insertions(+), 214 deletions(-)
 create mode 100644 linux-user/arm/vdso-asmoffset.h
 create mode 100644 linux-user/hppa/vdso-asmoffset.h
 create mode 100644 linux-user/i386/vdso-asmoffset.h
 create mode 100644 linux-user/loongarch64/vdso-asmoffset.h
 create mode 100644 linux-user/ppc/vdso-asmoffset.h
 create mode 100644 linux-user/riscv/vdso-asmoffset.h
 create mode 100644 linux-user/s390x/vdso-asmoffset.h
 create mode 100644 linux-user/gen-vdso.c
 create mode 100644 linux-user/gen-vdso-elfn.c.inc
 create mode 100644 linux-user/aarch64/Makefile.vdso
 create mode 100644 linux-user/aarch64/meson.build
 create mode 100755 linux-user/aarch64/vdso-be.so
 create mode 100755 linux-user/aarch64/vdso-le.so
 create mode 100644 linux-user/aarch64/vdso.S
 create mode 100644 linux-user/aarch64/vdso.ld
 create mode 100644 linux-user/arm/Makefile.vdso
 create mode 100755 linux-user/arm/vdso-be.so
 create mode 100755 linux-user/arm/vdso-le.so
 create mode 100644 linux-user/arm/vdso.S
 create mode 100644 linux-user/arm/vdso.ld
 create mode 100644 linux-user/hppa/Makefile.vdso
 create mode 100644 linux-user/hppa/vdso.S
 create mode 100644 linux-user/hppa/vdso.ld
 create mode 100755 linux-user/hppa/vdso.so
 create mode 100644 linux-user/i386/Makefile.vdso
 create mode 100644 linux-user/i386/vdso.S
 create mode 100644 linux-user/i386/vdso.ld
 create mode 100755 linux-user/i386/vdso.so
 create mode 100644 linux-user/loongarch64/Makefile.vdso
 create mode 100644 linux-user/loongarch64/meson.build
 create mode 100644 linux-user/loongarch64/vdso.S
 create mode 100644 linux-user/loongarch64/vdso.ld
 create mode 100755 linux-user/loongarch64/vdso.so
 create mode 100644 linux-user/ppc/Makefile.vdso
 create mode 100644 linux-user/ppc/vdso-32.ld
 create mode 100755 linux-user/ppc/vdso-32.so
 create mode 100644 linux-user/ppc/vdso-64.ld
 create mode 100755 linux-user/ppc/vdso-64.so
 create mode 100755 linux-user/ppc/vdso-64le.so
 create mode 100644 linux-user/ppc/vdso.S
 create mode 100644 linux-user/riscv/Makefile.vdso
 create mode 100644 linux-user/riscv/meson.build
 create mode 100755 linux-user/riscv/vdso-32.so
 create mode 100755 linux-user/riscv/vdso-64.so
 create mode 100644 linux-user/riscv/vdso.S
 create mode 100644 linux-user/riscv/vdso.ld
 create mode 100644 linux-user/s390x/Makefile.vdso
 create mode 100644 linux-user/s390x/vdso.S
 create mode 100644 linux-user/s390x/vdso.ld
 create mode 100755 linux-user/s390x/vdso.so
 create mode 100644 linux-user/x86_64/Makefile.vdso
 create mode 100644 linux-user/x86_64/vdso.S
 create mode 100644 linux-user/x86_64/vdso.ld
 create mode 100755 linux-user/x86_64/vdso.so

-- 
2.34.1


