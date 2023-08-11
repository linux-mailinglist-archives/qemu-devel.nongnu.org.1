Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196C779536
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLp-0005ix-IS; Fri, 11 Aug 2023 12:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLm-0005iZ-B5
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:50:58 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLk-0001L3-96
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:50:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5656a5b83e4so867486a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772654; x=1692377454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fLFw0NZFZ/4Nyu3VnEPjte6UxvD85yImT8QmSVJiFWg=;
 b=LIlbmqni/aTU+xIkX/5pQcVq+sutyiPaTEM40cJMgHUgzDiRaAt5QRuTsCiTQQ96oe
 XI/+xUtO5z1fUbGowuq8MgUHPazP5Cc3GOd0M+B9MxVj9LxPO7eta0T7gqjUvZC/SzxY
 WQhRLMdWY9Uw5T/I6Rc6dQYUkXDqy+F+o83rlEpouV34IEnqD5BVIOkKNKt426UmTzCG
 xaZd2ePCFiHU2aD27qwYMwYF4xL2wib69JBNs1RHcassz63c+xl2N5Tx7jrXsIcWQ1pA
 Oycb6kUn9gO2bPabOWlM+mivI18UTJlYAbOFMmACLJbqZYrWJP+yEf3aFXvIDOstXsNh
 jK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772654; x=1692377454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fLFw0NZFZ/4Nyu3VnEPjte6UxvD85yImT8QmSVJiFWg=;
 b=amhCHhtHeBStFZ9SeS7cevsasgdAcjYLLqdfnXvsE72FfNn/9qF5RJ6F085vsWLDoS
 hwjS/Xc11u4ZngCm1msckFKbgmh3b651iqvTer8tBrM3Z+S3BeGV/IgVAiRAmdMIg8Zt
 rujDQK0yrLq/mYHThU7kHvGgrEt84piF0/yqKf+TkFAdzFcFjmsk4sB86YiE3KCv6mWI
 RQVoAhbDv6Tt1TKfQzrI1hJx/syGvZwPmntvUPjxPMnkLu+dMtnt8k7aTPN8O65jq1Wd
 8E+YaF3lNS1yuJL+fTeyx6KEZ7mpci0c7OKcEpLL2x5iPdYxZjXTmc+tNvjhqsht3/6D
 tY6Q==
X-Gm-Message-State: AOJu0YyeNk9Gn1KFlH1lKGG9k9RQz6OsLfTjYGFFtlZQ1wCCmY9GcfCM
 dBFjPEOjL/PbnzoN9RYfFVCVpLJzN/4cIKEeYVI=
X-Google-Smtp-Source: AGHT+IFeAPM+Jcq7XFKRWPk/EiXbvjY9OKu7xTWuANl9GETQBRrl8Ez6qGCkNVvDPc54AfyTGooLKg==
X-Received: by 2002:a17:90a:7388:b0:263:53be:5120 with SMTP id
 j8-20020a17090a738800b0026353be5120mr1594938pjg.36.1691772654091; 
 Fri, 11 Aug 2023 09:50:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 00/15] linux-user: Implement VDSOs
Date: Fri, 11 Aug 2023 09:50:37 -0700
Message-Id: <20230811165052.161080-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

It's time for another round on implementing the VDSO for linux-user.
We are now seeing applications built that absolutely require it, 
and have no fallback for the VDSO to be absent.

For instance,

  https://gitlab.com/qemu-project/qemu/-/issues/1267

uses musl and will currently branch to NULL executing the mmap
syscall, because the __kernel_vsyscall symbol is not found.

This is just a rebase of v2 from 2021:

  https://lists.nongnu.org/archive/html/qemu-devel/2021-07/msg01311.html

and does nothing to address the cross-compilation issues.

I am more hopful that cross-compilation can be solved now, due
to the work on Native Library Calls:

  https://patchew.org/QEMU/20230808141739.3110740-1-fufuyqqqqqq@gmail.com/

But frankly, even with cross-compilation enabled there will be
hosts which do not have the cross-compilers and I believe we will
still have to check the binaries into the repository.  As they are
all on the order of 5 to 6k, I really do not see this as a problem.


r~


PS: This patch set is now 13 years old:

  https://lists.nongnu.org/archive/html/qemu-devel/2010-04/msg00187.html
  https://lists.gnu.org/archive/html/qemu-devel/2013-07/msg04036.html

Let's see if we can get this resolved before it can vote.


Richard Henderson (15):
  linux-user: Introduce imgsrc_read, imgsrc_read_alloc
  linux-user: Tidy loader_exec
  linux-user: Do not clobber bprm_buf swapping ehdr
  linux-user: Use ImageSource in load_elf_image
  linux-user: Use ImageSource in load_symbols
  linux-user: Replace bprm->fd with bprm->src.fd
  linux-user: Load vdso image if available
  linux-user: Add gen-vdso tool
  linux-user/aarch64: Add vdso and use it for rt_sigreturn
  target/arm: Add isar_feature_aa32_a32
  linux-user/arm: Add vdso and use it for rt_sigreturn
  linux-user/hppa: Add vdso and use it for rt_sigreturn
  linux-user/i386: Add vdso and use it for sigreturn
  linux-user/x86_64: Add vdso
  linux-user/riscv: Add vdso and use it for sigreturn

 linux-user/loader.h              |  60 ++++-
 target/arm/cpu.h                 |   5 +
 linux-user/arm/signal.c          |  30 ++-
 linux-user/elfload.c             | 365 ++++++++++++++++++++-----------
 linux-user/flatload.c            |   8 +-
 linux-user/gen-vdso.c            | 223 +++++++++++++++++++
 linux-user/hppa/signal.c         |   1 -
 linux-user/linuxload.c           | 137 ++++++++++--
 target/arm/tcg/cpu32.c           |   7 +
 linux-user/gen-vdso-elfn.c.inc   | 306 ++++++++++++++++++++++++++
 linux-user/aarch64/Makefile.vdso |  11 +
 linux-user/aarch64/meson.build   |  11 +
 linux-user/aarch64/vdso-be.so    | Bin 0 -> 6000 bytes
 linux-user/aarch64/vdso-le.so    | Bin 0 -> 6000 bytes
 linux-user/aarch64/vdso.S        |  77 +++++++
 linux-user/aarch64/vdso.ld       |  74 +++++++
 linux-user/arm/Makefile.vdso     |  17 ++
 linux-user/arm/meson.build       |  18 ++
 linux-user/arm/vdso-arm-be.so    | Bin 0 -> 5648 bytes
 linux-user/arm/vdso-arm-le.so    | Bin 0 -> 5648 bytes
 linux-user/arm/vdso-thm-be.so    | Bin 0 -> 5620 bytes
 linux-user/arm/vdso-thm-le.so    | Bin 0 -> 5620 bytes
 linux-user/arm/vdso.S            | 209 ++++++++++++++++++
 linux-user/arm/vdso.ld           |  74 +++++++
 linux-user/hppa/Makefile.vdso    |   6 +
 linux-user/hppa/meson.build      |   6 +
 linux-user/hppa/vdso.S           | 149 +++++++++++++
 linux-user/hppa/vdso.ld          |  75 +++++++
 linux-user/hppa/vdso.so          | Bin 0 -> 5196 bytes
 linux-user/i386/Makefile.vdso    |   5 +
 linux-user/i386/meson.build      |   7 +
 linux-user/i386/vdso.S           | 181 +++++++++++++++
 linux-user/i386/vdso.ld          |  76 +++++++
 linux-user/i386/vdso.so          | Bin 0 -> 5528 bytes
 linux-user/meson.build           |   8 +-
 linux-user/riscv/Makefile.vdso   |  11 +
 linux-user/riscv/meson.build     |   9 +
 linux-user/riscv/vdso-32.so      | Bin 0 -> 5624 bytes
 linux-user/riscv/vdso-64.so      | Bin 0 -> 6120 bytes
 linux-user/riscv/vdso.S          | 207 ++++++++++++++++++
 linux-user/riscv/vdso.ld         |  76 +++++++
 linux-user/x86_64/Makefile.vdso  |   5 +
 linux-user/x86_64/meson.build    |   6 +
 linux-user/x86_64/vdso.S         | 122 +++++++++++
 linux-user/x86_64/vdso.ld        |  74 +++++++
 linux-user/x86_64/vdso.so        | Bin 0 -> 6008 bytes
 46 files changed, 2467 insertions(+), 189 deletions(-)
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
 create mode 100644 linux-user/riscv/Makefile.vdso
 create mode 100644 linux-user/riscv/meson.build
 create mode 100755 linux-user/riscv/vdso-32.so
 create mode 100755 linux-user/riscv/vdso-64.so
 create mode 100644 linux-user/riscv/vdso.S
 create mode 100644 linux-user/riscv/vdso.ld
 create mode 100644 linux-user/x86_64/Makefile.vdso
 create mode 100644 linux-user/x86_64/vdso.S
 create mode 100644 linux-user/x86_64/vdso.ld
 create mode 100755 linux-user/x86_64/vdso.so

-- 
2.34.1


