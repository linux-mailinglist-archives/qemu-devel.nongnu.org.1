Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6778CFE1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n5-0000rX-LN; Tue, 29 Aug 2023 19:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nC-0002Mv-Sv
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:34 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6n9-00047b-Uj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:34 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso16966405ab.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346550; x=1693951350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7g5Fq4BqKCKdoVDe3Q+t3VWUGC5hyKfcutPKjml3IKU=;
 b=avpDFMZ0liazHfylY9I9UOT9i2QfQUoYzrECxFKmWg0SXap4FJSAPxQTB1aYsJIpuS
 JHlVgIpzuLkc8Ago+Ied/7I60Ff6UjyNLDcOuAgus4LteGrzBIR7t6dv0hJ+nUNn/uBm
 fL93S+DZTKzxnv6+LKgZH4h9pDuvjBmeS8kiIXcSNEecmVfbDN4V6ipvV32DDCXQCBXC
 7/1HcgFFg4qQSvlwUzJqQgKnX8xA1fAxGDraGtHrz648mfUrii/KsGbohbycMsrQEbBx
 gYiikQwNHfM+br+r63oYxbpk/32hRM4tqY+KNswUtIhZoCGlQnu8b9ay0Sl30dTv2dps
 sjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346550; x=1693951350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7g5Fq4BqKCKdoVDe3Q+t3VWUGC5hyKfcutPKjml3IKU=;
 b=MUtiSXNhLPkR71RyCI8oNxTaGRhK+xd7/eReCaSgIW3oX3diZyVD2cQz3tHgFyuH2U
 1LLGq+b1bBouvdDM28qHvBuT+KXE9xtLgxLWnHiFLrFpG1HRfth2waJBY/2cm3kJyCD+
 LiwWlrMs08KOpzgBQoqjPboJogEeLautLThHingNijrrMHrL8yCJBPdOyOPgH1HBfqd4
 T0iproAKIiZp7DOAv0nJZS8eBApsTi+2AQx61EkGR9/ngprI0snZg3qzXZ6c24VwaeCR
 Fw25wQBXtU9BVoYQJHN5V2+4wcPoxIuG0mxxRLKnVNyuO9ydzJ7AJLH5x0h+Vc1zpOIP
 0E/w==
X-Gm-Message-State: AOJu0YxT94Pea7vQjTVZh0uGBY7E0lYypid60gaUAD1Ld4wv1WSI/fxi
 LVjnzE5co7UOvy437uEpyfQA4wPu2H6Bhb7ZKIk=
X-Google-Smtp-Source: AGHT+IF0VY2XQXGEV1pj0w1Upgitv2LCANqp3/ZtMuIiLg4OUQMrmApGxg/ju8JhBiC/olA3YH71jA==
X-Received: by 2002:a92:d2c6:0:b0:34c:b981:52d4 with SMTP id
 w6-20020a92d2c6000000b0034cb98152d4mr557841ilg.31.1693346550268; 
 Tue, 29 Aug 2023 15:02:30 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 00/20] linux-user: Implement VDSOs
Date: Tue, 29 Aug 2023 15:02:08 -0700
Message-Id: <20230829220228.928506-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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
  * Integrated cross-compile, via new build-vdso.sh and meson rules.
    However, keep the binaries in the tree for hosts which do not
    have all of the cross-compile machinery.
  * Update our loongarch64 docker image to avoid a binutils bug.

Changes for v4:
  * Force all vdso to have a single load segment.
    This will prevent problems with varying host/guest page size.
  * Tidy some of the assembly with macros.
  * Implement loongarch, ppc, s390x.

Just in case the list eats a binary:
  https://gitlab.com/rth7680/qemu/-/tree/lu-vdso


r~


Richard Henderson (20):
  tests/docker: Update docker-loongarch-cross toolchain
  linux-user: Introduce imgsrc_read, imgsrc_read_alloc
  linux-user: Tidy loader_exec
  linux-user: Do not clobber bprm_buf swapping ehdr
  linux-user: Use ImageSource in load_elf_image
  linux-user: Use ImageSource in load_symbols
  linux-user: Replace bprm->fd with bprm->src.fd
  linux-user: Load vdso image if available
  linux-user: Add gen-vdso tool
  linux-user: Add build-vdso.sh tool
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

 linux-user/hppa/vdso-asmoffset.h              |  12 +
 linux-user/i386/vdso-asmoffset.h              |   6 +
 linux-user/loader.h                           |  60 ++-
 linux-user/loongarch64/vdso-asmoffset.h       |   8 +
 linux-user/ppc/vdso-asmoffset.h               |  20 +
 linux-user/riscv/vdso-asmoffset.h             |   9 +
 linux-user/s390x/vdso-asmoffset.h             |   2 +
 linux-user/arm/signal.c                       |  28 +-
 linux-user/elfload.c                          | 361 +++++++++++-------
 linux-user/flatload.c                         |   8 +-
 linux-user/gen-vdso.c                         | 223 +++++++++++
 linux-user/hppa/signal.c                      |  24 +-
 linux-user/i386/signal.c                      |  11 +
 linux-user/linuxload.c                        | 137 +++++--
 linux-user/loongarch64/signal.c               |  17 +-
 linux-user/ppc/signal.c                       |  31 +-
 linux-user/riscv/signal.c                     |   8 +
 linux-user/s390x/signal.c                     |   7 +-
 linux-user/gen-vdso-elfn.c.inc                | 314 +++++++++++++++
 linux-user/aarch64/meson.build                |  33 ++
 linux-user/aarch64/vdso-be.so                 | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso-le.so                 | Bin 0 -> 3216 bytes
 linux-user/aarch64/vdso.S                     |  73 ++++
 linux-user/aarch64/vdso.ld                    |  72 ++++
 linux-user/arm/meson.build                    |  35 ++
 linux-user/arm/vdso-be.so                     | Bin 0 -> 2680 bytes
 linux-user/arm/vdso-le.so                     | Bin 0 -> 2680 bytes
 linux-user/arm/vdso.S                         | 177 +++++++++
 linux-user/arm/vdso.ld                        |  67 ++++
 linux-user/build-vdso.sh                      |  31 ++
 linux-user/hppa/meson.build                   |  23 ++
 linux-user/hppa/vdso.S                        | 165 ++++++++
 linux-user/hppa/vdso.ld                       |  77 ++++
 linux-user/hppa/vdso.so                       | Bin 0 -> 2104 bytes
 linux-user/i386/meson.build                   |  24 ++
 linux-user/i386/vdso.S                        | 143 +++++++
 linux-user/i386/vdso.ld                       |  76 ++++
 linux-user/i386/vdso.so                       | Bin 0 -> 2672 bytes
 linux-user/loongarch64/meson.build            |  21 +
 linux-user/loongarch64/vdso.S                 | 130 +++++++
 linux-user/loongarch64/vdso.ld                |  73 ++++
 linux-user/loongarch64/vdso.so                | Bin 0 -> 3560 bytes
 linux-user/meson.build                        |  10 +-
 linux-user/ppc/Makefile.vdso                  |  18 +
 linux-user/ppc/meson.build                    |  12 +
 linux-user/ppc/vdso-32.ld                     |  70 ++++
 linux-user/ppc/vdso-32.so                     | Bin 0 -> 3020 bytes
 linux-user/ppc/vdso-64.ld                     |  68 ++++
 linux-user/ppc/vdso-64.so                     | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso-64le.so                   | Bin 0 -> 3896 bytes
 linux-user/ppc/vdso.S                         | 239 ++++++++++++
 linux-user/riscv/meson.build                  |  30 ++
 linux-user/riscv/vdso-32.so                   | Bin 0 -> 2888 bytes
 linux-user/riscv/vdso-64.so                   | Bin 0 -> 3840 bytes
 linux-user/riscv/vdso.S                       | 186 +++++++++
 linux-user/riscv/vdso.ld                      |  74 ++++
 linux-user/s390x/meson.build                  |  24 ++
 linux-user/s390x/vdso.S                       |  61 +++
 linux-user/s390x/vdso.ld                      |  69 ++++
 linux-user/s390x/vdso.so                      | Bin 0 -> 3464 bytes
 linux-user/x86_64/meson.build                 |  20 +
 linux-user/x86_64/vdso.S                      |  78 ++++
 linux-user/x86_64/vdso.ld                     |  73 ++++
 linux-user/x86_64/vdso.so                     | Bin 0 -> 2968 bytes
 .../dockerfiles/debian-loongarch-cross.docker |   2 +-
 65 files changed, 3329 insertions(+), 211 deletions(-)
 create mode 100644 linux-user/hppa/vdso-asmoffset.h
 create mode 100644 linux-user/i386/vdso-asmoffset.h
 create mode 100644 linux-user/loongarch64/vdso-asmoffset.h
 create mode 100644 linux-user/ppc/vdso-asmoffset.h
 create mode 100644 linux-user/riscv/vdso-asmoffset.h
 create mode 100644 linux-user/s390x/vdso-asmoffset.h
 create mode 100644 linux-user/gen-vdso.c
 create mode 100644 linux-user/gen-vdso-elfn.c.inc
 create mode 100644 linux-user/aarch64/meson.build
 create mode 100755 linux-user/aarch64/vdso-be.so
 create mode 100755 linux-user/aarch64/vdso-le.so
 create mode 100644 linux-user/aarch64/vdso.S
 create mode 100644 linux-user/aarch64/vdso.ld
 create mode 100755 linux-user/arm/vdso-be.so
 create mode 100755 linux-user/arm/vdso-le.so
 create mode 100644 linux-user/arm/vdso.S
 create mode 100644 linux-user/arm/vdso.ld
 create mode 100755 linux-user/build-vdso.sh
 create mode 100644 linux-user/hppa/vdso.S
 create mode 100644 linux-user/hppa/vdso.ld
 create mode 100755 linux-user/hppa/vdso.so
 create mode 100644 linux-user/i386/vdso.S
 create mode 100644 linux-user/i386/vdso.ld
 create mode 100755 linux-user/i386/vdso.so
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
 create mode 100644 linux-user/riscv/meson.build
 create mode 100755 linux-user/riscv/vdso-32.so
 create mode 100755 linux-user/riscv/vdso-64.so
 create mode 100644 linux-user/riscv/vdso.S
 create mode 100644 linux-user/riscv/vdso.ld
 create mode 100644 linux-user/s390x/vdso.S
 create mode 100644 linux-user/s390x/vdso.ld
 create mode 100755 linux-user/s390x/vdso.so
 create mode 100644 linux-user/x86_64/vdso.S
 create mode 100644 linux-user/x86_64/vdso.ld
 create mode 100755 linux-user/x86_64/vdso.so

-- 
2.34.1


