Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68F7DC1B7
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZdy-00010M-2U; Mon, 30 Oct 2023 17:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZde-0000ye-Nh
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdZ-0006TT-Tl
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so11455645ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700648; x=1699305448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oxxsGG9wfpZDkBYVEhXj5D4YMQzrgk7Qf0QWMXgX0f0=;
 b=umNc/RnboQTjMQxaSy6Lp8oWB9ET242V79U2G88p/J94Qe9QmYu7/00I21wwR7vKtS
 qYdrUGs1ZcVWlHGFC5q4ccEqwyR8bfWB/KUDDjagOwUdf1bsRph9O++4NUebzkNbU6Yx
 OJICQAMUip7jXiHDvkfIN2DiCj2BpA+BRy657k06vP77ClGiPyEcrAM0shP0M5MfUejS
 f+FBM6TIqivMcynhj0EaSWl1EzJZk3n32ru1V0mfLef5K31w4M7fErMmHpsHk3eGRRq6
 PKV7g7SEo6WaA+iEg1sgftkEzHLs2YUputMcvTxXQdeDY2UoU34AI2qQM9Fa0YdF3/f+
 Pn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700648; x=1699305448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxxsGG9wfpZDkBYVEhXj5D4YMQzrgk7Qf0QWMXgX0f0=;
 b=XRrj9FJ1pWEN3A0BXqtR6XDRTMX1KntmoyBYj4FS5mqMtdyzCqPeW/TT4Fcd5pyHyu
 x6zGyO0/PmANzWlpyBNI4AkYWH4xc1KXGJRjjtraWr5Skk0W6MKazBPYLkRU+iarrtJX
 Ge8INGySUe68HX+vMWlHtKGzdZMOQ4mK9VuN+vATuotGYq0ZfTlwxgto/OUr7dmFNlLQ
 wcTmo4RoKawEZZLgZxMMAKk4kmK5WWiUunedd6MTDAnVQON4I6/Q+g2ixxXYrF1Y6oNU
 I58Kwj1hs7O5Mx1c1dJnkNNBonJitz1vx+nsOUBQEBYSpOiBB49vm3K6eSlnzBhgD2Ru
 o4bg==
X-Gm-Message-State: AOJu0YwIbuykB1b2rpGl1UhHZbgXQvDhB2h+Lo4D3hQf3+1xp5cHduoz
 TqTTI1cwxmQl+y/bKhSc0FLRy8W/0QlTE7Nybjw=
X-Google-Smtp-Source: AGHT+IHrzPBjhGqlHBa8PvFw4FQ9FIMQq52tv6HbyZqmI8LZFTulnsIOLK8gS0qQq6lia+rkkyEj9A==
X-Received: by 2002:a17:902:c9cc:b0:1cc:2ef7:2abe with SMTP id
 q12-20020a170902c9cc00b001cc2ef72abemr4536799pld.48.1698700648297; 
 Mon, 30 Oct 2023 14:17:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] linux-user patch queue
Date: Mon, 30 Oct 2023 14:17:06 -0700
Message-Id: <20231030211727.165090-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The following changes since commit fd9a38fd437c4c31705071c240f4be11394ca1f8:

  Merge tag 'pull-hex-20231018' of https://github.com/quic/qemu into staging (2023-10-30 13:42:29 +0900)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20231030

for you to fetch changes up to 335b8f700c42a011cf2855c47bf098be3d35bde4:

  build: Add update-linux-vdso makefile rule (2023-10-30 13:41:56 -0700)

----------------------------------------------------------------
linux-user: Fix guest signal remapping after adjusting SIGABRT
linux-user: Implement VDSOs

----------------------------------------------------------------
Richard Henderson (21):
      linux-user: Fix guest signal remapping after adjusting SIGABRT
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
      linux-user: Show vdso address in /proc/pid/maps
      build: Add update-linux-vdso makefile rule

 Makefile                                |  10 +
 linux-user/arm/vdso-asmoffset.h         |   3 +
 linux-user/hppa/vdso-asmoffset.h        |  12 ++
 linux-user/i386/vdso-asmoffset.h        |   6 +
 linux-user/loader.h                     |  60 +++++-
 linux-user/loongarch64/vdso-asmoffset.h |   8 +
 linux-user/ppc/vdso-asmoffset.h         |  20 ++
 linux-user/qemu.h                       |   1 +
 linux-user/riscv/vdso-asmoffset.h       |   9 +
 linux-user/s390x/vdso-asmoffset.h       |   2 +
 linux-user/arm/signal.c                 |  55 +++--
 linux-user/elfload.c                    | 359 ++++++++++++++++++++------------
 linux-user/flatload.c                   |   8 +-
 linux-user/gen-vdso.c                   | 223 ++++++++++++++++++++
 linux-user/hppa/signal.c                |  24 ++-
 linux-user/i386/signal.c                |  11 +
 linux-user/linuxload.c                  | 137 +++++++++---
 linux-user/loongarch64/signal.c         |  17 +-
 linux-user/ppc/signal.c                 |  31 ++-
 linux-user/riscv/signal.c               |   8 +
 linux-user/s390x/signal.c               |   7 +-
 linux-user/signal.c                     |   9 +-
 linux-user/syscall.c                    |   2 +
 linux-user/gen-vdso-elfn.c.inc          | 314 ++++++++++++++++++++++++++++
 linux-user/aarch64/Makefile.vdso        |  15 ++
 linux-user/aarch64/meson.build          |  11 +
 linux-user/aarch64/vdso-be.so           | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so           | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S               |  71 +++++++
 linux-user/aarch64/vdso.ld              |  72 +++++++
 linux-user/arm/Makefile.vdso            |  17 ++
 linux-user/arm/meson.build              |  12 ++
 linux-user/arm/vdso-be.so               | Bin 0 -> 2648 bytes
 linux-user/arm/vdso-le.so               | Bin 0 -> 2648 bytes
 linux-user/arm/vdso.S                   | 174 ++++++++++++++++
 linux-user/arm/vdso.ld                  |  67 ++++++
 linux-user/hppa/Makefile.vdso           |  11 +
 linux-user/hppa/meson.build             |   5 +
 linux-user/hppa/vdso.S                  | 165 +++++++++++++++
 linux-user/hppa/vdso.ld                 |  77 +++++++
 linux-user/hppa/vdso.so                 | Bin 0 -> 2104 bytes
 linux-user/i386/Makefile.vdso           |  11 +
 linux-user/i386/meson.build             |   7 +
 linux-user/i386/vdso.S                  | 143 +++++++++++++
 linux-user/i386/vdso.ld                 |  76 +++++++
 linux-user/i386/vdso.so                 | Bin 0 -> 2672 bytes
 linux-user/loongarch64/Makefile.vdso    |  11 +
 linux-user/loongarch64/meson.build      |   4 +
 linux-user/loongarch64/vdso.S           | 130 ++++++++++++
 linux-user/loongarch64/vdso.ld          |  73 +++++++
 linux-user/loongarch64/vdso.so          | Bin 0 -> 3560 bytes
 linux-user/meson.build                  |   9 +-
 linux-user/ppc/Makefile.vdso            |  20 ++
 linux-user/ppc/meson.build              |  12 ++
 linux-user/ppc/vdso-32.ld               |  70 +++++++
 linux-user/ppc/vdso-32.so               | Bin 0 -> 3020 bytes
 linux-user/ppc/vdso-64.ld               |  68 ++++++
 linux-user/ppc/vdso-64.so               | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso-64le.so             | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso.S                   | 239 +++++++++++++++++++++
 linux-user/riscv/Makefile.vdso          |  15 ++
 linux-user/riscv/meson.build            |   7 +
 linux-user/riscv/vdso-32.so             | Bin 0 -> 2900 bytes
 linux-user/riscv/vdso-64.so             | Bin 0 -> 3856 bytes
 linux-user/riscv/vdso.S                 | 187 +++++++++++++++++
 linux-user/riscv/vdso.ld                |  74 +++++++
 linux-user/s390x/Makefile.vdso          |  11 +
 linux-user/s390x/meson.build            |   6 +
 linux-user/s390x/vdso.S                 |  61 ++++++
 linux-user/s390x/vdso.ld                |  72 +++++++
 linux-user/s390x/vdso.so                | Bin 0 -> 3464 bytes
 linux-user/x86_64/Makefile.vdso         |  11 +
 linux-user/x86_64/meson.build           |   4 +
 linux-user/x86_64/vdso.S                |  78 +++++++
 linux-user/x86_64/vdso.ld               |  73 +++++++
 linux-user/x86_64/vdso.so               | Bin 0 -> 2968 bytes
 76 files changed, 3286 insertions(+), 219 deletions(-)
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

