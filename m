Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC57548E6
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiG-00040l-9j; Sat, 15 Jul 2023 09:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfi9-0003zR-F4
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfi6-0001CZ-RC
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-314417861b9so2777761f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429200; x=1692021200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SK/klrksjVFslz546HPa2crXql9gcKyBXNpat8DXeUo=;
 b=vDToQEo7YXP9v9ia/DDSE8anSg92aRY+arRdavvzPhZvVAKkk+vQcpLU7q7Pwc8l+C
 TI/5ohtD5BL3xrAqv5M/50ED7eGnzE+IhpnSUYX8r6ixNg+pTvYSUTQA5TMngv6UFVVL
 408+wd8DSXexh04gHrNXhrFFpSSqYa+AANyZtExhxwELQpk4J5XJOKfxsuffuMAJjzyE
 S3Vba4q/qn+Ekjr9SUndBj6sHJavcNPCW5FafTrh6IinP20X/PzSHFRMbEQBXusSHbsB
 ljQ2beiHRnyZnYLTxCx8hhlU5DZWmXspoqEUVgn509PLDmX5GezMPVu/+mofRN4qyNS7
 hN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429200; x=1692021200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SK/klrksjVFslz546HPa2crXql9gcKyBXNpat8DXeUo=;
 b=RE8/lMUCgR4a/yMXoh15hPDHyJc0JeKQP3QYSycsFLB4K4H/5ASk3fgpN9ViyjnE6w
 zPxXQhssJVe+Y906jatBSyAAsiKTXMGT4tNSZ8shl+imUu9U8HADyKmd6uOKxooAszo5
 4RADF4xM2iVA02uUZYwKsvX75J52bwQFzzxNV1vKt4WBgTy5EayxCcEUJaK8Bfj41dIn
 ay9wMMBzOY2sLp5Ibn9qOEzjm+CeLVGQRTysOsTl47zIwIt7X4iSTPr1+ibRsq0nqseb
 kHt9LGnrA1SzIeE8ag+ih9Ry+cr8FRJGXY22ENtwxZrLak8X5RBm52cE9ViF+q+/G/7h
 Xsag==
X-Gm-Message-State: ABy/qLaaSWZWFF8w9n1ZG9SSfsZixNDLaCZn9ZP2vqMd1zst+7WHWAlB
 feOLzAQUBWOZujRMDkVHnjR72G4qhXGWAN4sTAwVrg==
X-Google-Smtp-Source: APBJJlGtfofyie4EuMj/7ovhwPGcQByRRzMq6H4jqq2s5mV+b0eB2w/eoTdIcuxnoW7tJO/FP7UL+w==
X-Received: by 2002:adf:de8e:0:b0:314:4439:151a with SMTP id
 w14-20020adfde8e000000b003144439151amr7041545wrl.6.1689429199702; 
 Sat, 15 Jul 2023 06:53:19 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/47] tcg + linux-user patch queue
Date: Sat, 15 Jul 2023 14:52:30 +0100
Message-Id: <20230715135317.7219-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 4633c1e2c576fbabfe5c8c93f4b842504b69c096:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-07-14 16:39:46 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230715

for you to fetch changes up to 76f9d6ad19494290eb2f00d33c6a582ce3447991:

  tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128 (2023-07-15 08:02:49 +0100)

----------------------------------------------------------------
tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128
accel/tcg: Introduce page_check_range_empty
accel/tcg: Introduce page_find_range_empty
accel/tcg: Accept more page flags in page_check_range
accel/tcg: Return bool from page_check_range
accel/tcg: Always lock pages before translation
linux-user: Use abi_* types for target structures in syscall_defs.h
linux-user: Fix abi_llong alignment for microblaze and nios2
linux-user: Fix do_shmat type errors
linux-user: Implement execve without execveat
linux-user: Make sure initial brk is aligned
linux-user: Use a mask with strace flags
linux-user: Implement MAP_FIXED_NOREPLACE
linux-user: Widen target_mmap offset argument to off_t
linux-user: Use page_find_range_empty for mmap_find_vma_reserved
linux-user: Use 'last' instead of 'end' in target_mmap and subroutines
linux-user: Remove can_passthrough_madvise
linux-user: Simplify target_madvise
linux-user: Drop uint and ulong types
linux-user/arm: Do not allocate a commpage at all for M-profile CPUs
bsd-user: Use page_check_range_empty for MAP_EXCL
bsd-user: Use page_find_range_empty for mmap_find_vma_reserved

----------------------------------------------------------------
Andreas Schwab (1):
      linux-user: Make sure initial brk(0) is page-aligned

Juan Quintela (1):
      linux-user: Drop uint and ulong

Philippe Mathieu-Daudé (1):
      linux-user/arm: Do not allocate a commpage at all for M-profile CPUs

Pierrick Bouvier (1):
      linux-user/syscall: Implement execve without execveat

Richard Henderson (43):
      linux-user: Reformat syscall_defs.h
      linux-user: Remove #if 0 block in syscall_defs.h
      linux-user: Use abi_uint not uint32_t in syscall_defs.h
      linux-user: Use abi_int not int32_t in syscall_defs.h
      linux-user: Use abi_ullong not uint64_t in syscall_defs.h
      linux-user: Use abi_llong not int64_t in syscall_defs.h
      linux-user: Use abi_uint not unsigned int in syscall_defs.h
      linux-user: Use abi_ullong not unsigned long long in syscall_defs.h
      linux-user: Use abi_llong not long long in syscall_defs.h
      linux-user: Use abi_int not int in syscall_defs.h
      linux-user: Use abi_ushort not unsigned short in syscall_defs.h
      linux-user: Use abi_short not short in syscall_defs.h
      linux-user: Use abi_uint not unsigned in syscall_defs.h
      include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze
      include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
      linux-user: Fix do_shmat type errors
      accel/tcg: Split out cpu_exec_longjmp_cleanup
      tcg: Fix info_in_idx increment in layout_arg_by_ref
      linux-user: Fix formatting of mmap.c
      linux-user/strace: Expand struct flags to hold a mask
      linux-user: Split TARGET_MAP_* out of syscall_defs.h
      linux-user: Split TARGET_PROT_* out of syscall_defs.h
      linux-user: Populate more bits in mmap_flags_tbl
      accel/tcg: Introduce page_check_range_empty
      bsd-user: Use page_check_range_empty for MAP_EXCL
      linux-user: Implement MAP_FIXED_NOREPLACE
      linux-user: Split out target_to_host_prot
      linux-user: Widen target_mmap offset argument to off_t
      linux-user: Rewrite target_mprotect
      linux-user: Rewrite mmap_frag
      accel/tcg: Introduce page_find_range_empty
      bsd-user: Use page_find_range_empty for mmap_find_vma_reserved
      linux-user: Use page_find_range_empty for mmap_find_vma_reserved
      linux-user: Use 'last' instead of 'end' in target_mmap
      linux-user: Rewrite mmap_reserve
      linux-user: Rename mmap_reserve to mmap_reserve_or_unmap
      linux-user: Simplify target_munmap
      accel/tcg: Accept more page flags in page_check_range
      accel/tcg: Return bool from page_check_range
      linux-user: Remove can_passthrough_madvise
      linux-user: Simplify target_madvise
      accel/tcg: Always lock pages before translation
      tcg: Use HAVE_CMPXCHG128 instead of CONFIG_CMPXCHG128

 accel/tcg/internal.h               |   30 +-
 accel/tcg/tcg-runtime.h            |    2 +-
 bsd-user/qemu.h                    |    2 +-
 include/exec/cpu-all.h             |   40 +-
 include/exec/helper-proto-common.h |    2 +
 include/exec/user/abitypes.h       |    5 +-
 linux-user/aarch64/target_mman.h   |    8 +
 linux-user/alpha/target_mman.h     |   13 +
 linux-user/generic/target_mman.h   |   58 +
 linux-user/hppa/target_mman.h      |   10 +
 linux-user/mips/target_mman.h      |   18 +
 linux-user/mips64/target_mman.h    |    2 +-
 linux-user/ppc/target_mman.h       |    8 +
 linux-user/qemu.h                  |    2 +-
 linux-user/sparc/target_mman.h     |    9 +
 linux-user/syscall_defs.h          | 2260 +++++++++++++++++-------------------
 linux-user/user-mmap.h             |    2 +-
 linux-user/xtensa/target_mman.h    |   18 +
 accel/tcg/cpu-exec.c               |   63 +-
 accel/tcg/cputlb.c                 |    2 +-
 accel/tcg/tb-maint.c               |  242 ++--
 accel/tcg/translate-all.c          |   43 +-
 accel/tcg/translator.c             |   34 +-
 accel/tcg/user-exec.c              |   74 +-
 bsd-user/mmap.c                    |   50 +-
 linux-user/elfload.c               |   21 +-
 linux-user/mmap.c                  |  704 +++++------
 linux-user/strace.c                |   61 +-
 linux-user/syscall.c               |   68 +-
 target/hppa/op_helper.c            |    2 +-
 target/riscv/vector_helper.c       |    2 +-
 target/sparc/ldst_helper.c         |    2 +-
 tcg/tcg-op-ldst.c                  |    2 +-
 tcg/tcg.c                          |    2 +-
 accel/tcg/atomic_common.c.inc      |    2 +-
 accel/tcg/ldst_atomicity.c.inc     |    4 +-
 36 files changed, 2043 insertions(+), 1824 deletions(-)

