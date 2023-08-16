Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4E877E83E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKs0-00026o-BK; Wed, 16 Aug 2023 14:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKry-00025h-Jh
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:46 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrt-0001IX-Sg
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:46 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdbbede5d4so45981885ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209019; x=1692813819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hu8kIVHTXe6dGUOzmh0Q41rDn3UWf6T+Qf4TIvDk+z8=;
 b=t2HtR/AXP3AYlDFF9Kn+Bh3S9UgoqUSJWcAO2ASTflhwjUMAy2Fs6a+i8kduj4Z913
 hfGlRNteMIJpNheAxKQFzHxx4jelLSGAUPNRhVwJpJC0kpnf47bRMLUv+O9rZHur3W2b
 Xvbxox/9CgMK1LtCvbUYPywR/EHxEDmdEiSC8TXAtKPMgAJCFuW6ta1q1hpEAbbJcHyj
 wiGLfAxAzPdIRKce3nlZD2Z3nJO5on9r+D41im/FvG+sZWtsZVc77TDYf5HM/Kk9jAGz
 iOQqZeWdOdbBwba3cO3Ev6TI/7IBVZNe7NJI9sov94NDp7+9k31DO76i+1JGgODFkEZt
 twUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209019; x=1692813819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hu8kIVHTXe6dGUOzmh0Q41rDn3UWf6T+Qf4TIvDk+z8=;
 b=InEU1L9OCnVCcQJH1AwfrYQU16d79RcdPmJP8O449OmRLOFK/fX+xp59BIHa2mS2rl
 my3zwMW1I7ZqEZsAP7s0ptyW1BEDmdpY2P447k/4gy9+zTvqe1qvl1zZ9nBg6MA2PrWS
 QVhpWSDIzIOXKujgYQzHUb7xY/5K1XLdu+DEzcW/x2hRvzQOmEfiijnJ+Iwbd4rTC2Xk
 roGcE9jKHiZyGKZ9gr0y/yX18Lb1N5zwIeePJIf2+4LkYS1aqd91cVa1+lfTppU+ql0s
 G4LFye3bgvJUNcSKJwmyUowFmgwRiM/9/5R99UePqN2F1BZCuC/3dFmEC5jOqUeYEtqJ
 E2jg==
X-Gm-Message-State: AOJu0Yz6ogzLRadYAOUHhsTNhEHNtVAJYRD4yI89NrsbqmPe8Tslapke
 6HLMWVVjmbRkew8mbN6k8YGi7IOqVTyzKqS1MeI=
X-Google-Smtp-Source: AGHT+IFkZI8S3N3BOgmdk23Jhcp81eYc5ozkT8GKDS+jbzwA6oFUd2wiG1EgrT3kWnalz6qvnGaYtw==
X-Received: by 2002:a17:903:1c2:b0:1bc:28a8:f856 with SMTP id
 e2-20020a17090301c200b001bc28a8f856mr2623525plh.47.1692209019449; 
 Wed, 16 Aug 2023 11:03:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/18] linux-user: Implement VDSOs
Date: Wed, 16 Aug 2023 11:03:20 -0700
Message-Id: <20230816180338.572576-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Still no integrated cross-compile, however:

Changes for v4:
  * Force all vdso to have a single load segment.
    This will prevent problems with varying host/guest page size.
  * Tidy some of the assembly with macros.
  * Implement loongarch, ppc, s390x.

Just in case the list eats a binary:
  https://gitlab.com/rth7680/qemu/-/tree/lu-vdso


r~


Richard Henderson (18):
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

 linux-user/hppa/vdso-asmoffset.h        |  12 +
 linux-user/i386/vdso-asmoffset.h        |   6 +
 linux-user/loader.h                     |  60 +++-
 linux-user/loongarch64/vdso-asmoffset.h |   8 +
 linux-user/ppc/vdso-asmoffset.h         |  20 ++
 linux-user/riscv/vdso-asmoffset.h       |   9 +
 linux-user/s390x/vdso-asmoffset.h       |   2 +
 linux-user/arm/signal.c                 |  30 +-
 linux-user/elfload.c                    | 381 +++++++++++++++---------
 linux-user/flatload.c                   |   8 +-
 linux-user/gen-vdso.c                   | 223 ++++++++++++++
 linux-user/hppa/signal.c                |  24 +-
 linux-user/i386/signal.c                |  11 +
 linux-user/linuxload.c                  | 137 +++++++--
 linux-user/loongarch64/signal.c         |  17 +-
 linux-user/ppc/signal.c                 |  31 +-
 linux-user/riscv/signal.c               |   8 +
 linux-user/s390x/signal.c               |   7 +-
 linux-user/gen-vdso-elfn.c.inc          | 314 +++++++++++++++++++
 linux-user/aarch64/Makefile.vdso        |  12 +
 linux-user/aarch64/meson.build          |  12 +
 linux-user/aarch64/vdso-be.so           | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so           | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S               |  73 +++++
 linux-user/aarch64/vdso.ld              |  72 +++++
 linux-user/arm/Makefile.vdso            |  17 ++
 linux-user/arm/meson.build              |  18 ++
 linux-user/arm/vdso-arm-be.so           | Bin 0 -> 2712 bytes
 linux-user/arm/vdso-arm-le.so           | Bin 0 -> 2712 bytes
 linux-user/arm/vdso-thm-be.so           | Bin 0 -> 2684 bytes
 linux-user/arm/vdso-thm-le.so           | Bin 0 -> 2684 bytes
 linux-user/arm/vdso.S                   | 193 ++++++++++++
 linux-user/arm/vdso.ld                  |  67 +++++
 linux-user/hppa/Makefile.vdso           |   6 +
 linux-user/hppa/meson.build             |   6 +
 linux-user/hppa/vdso.S                  | 165 ++++++++++
 linux-user/hppa/vdso.ld                 |  77 +++++
 linux-user/hppa/vdso.so                 | Bin 0 -> 2104 bytes
 linux-user/i386/Makefile.vdso           |   5 +
 linux-user/i386/meson.build             |   7 +
 linux-user/i386/vdso.S                  | 143 +++++++++
 linux-user/i386/vdso.ld                 |  76 +++++
 linux-user/i386/vdso.so                 | Bin 0 -> 2672 bytes
 linux-user/loongarch64/Makefile.vdso    |   7 +
 linux-user/loongarch64/meson.build      |   4 +
 linux-user/loongarch64/vdso.S           | 130 ++++++++
 linux-user/loongarch64/vdso.ld          |  73 +++++
 linux-user/loongarch64/vdso.so          | Bin 0 -> 3560 bytes
 linux-user/meson.build                  |   9 +-
 linux-user/ppc/Makefile.vdso            |  18 ++
 linux-user/ppc/meson.build              |  12 +
 linux-user/ppc/vdso-32.ld               |  70 +++++
 linux-user/ppc/vdso-32.so               | Bin 0 -> 3020 bytes
 linux-user/ppc/vdso-64.ld               |  68 +++++
 linux-user/ppc/vdso-64.so               | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso-64le.so             | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso.S                   | 239 +++++++++++++++
 linux-user/riscv/Makefile.vdso          |  11 +
 linux-user/riscv/meson.build            |   9 +
 linux-user/riscv/vdso-32.so             | Bin 0 -> 2652 bytes
 linux-user/riscv/vdso-64.so             | Bin 0 -> 3528 bytes
 linux-user/riscv/vdso.S                 | 186 ++++++++++++
 linux-user/riscv/vdso.ld                |  74 +++++
 linux-user/s390x/Makefile.vdso          |   5 +
 linux-user/s390x/meson.build            |   6 +
 linux-user/s390x/vdso.S                 |  61 ++++
 linux-user/s390x/vdso.ld                |  69 +++++
 linux-user/s390x/vdso.so                | Bin 0 -> 3464 bytes
 linux-user/x86_64/Makefile.vdso         |   5 +
 linux-user/x86_64/meson.build           |   6 +
 linux-user/x86_64/vdso.S                |  78 +++++
 linux-user/x86_64/vdso.ld               |  73 +++++
 linux-user/x86_64/vdso.so               | Bin 0 -> 2968 bytes
 73 files changed, 3259 insertions(+), 211 deletions(-)
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
 create mode 100755 linux-user/arm/vdso-arm-be.so
 create mode 100755 linux-user/arm/vdso-arm-le.so
 create mode 100755 linux-user/arm/vdso-thm-be.so
 create mode 100755 linux-user/arm/vdso-thm-le.so
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


