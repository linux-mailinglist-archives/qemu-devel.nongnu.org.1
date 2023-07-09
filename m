Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3D74C761
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAO-0008De-Tp; Sun, 09 Jul 2023 14:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAE-0008DR-JJ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAA-0000DB-6f
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso38014745e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927376; x=1691519376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gkmuf4L0OI5wcKr4WVTcr5LnQ0uH5Smo7a7q0ycBiDo=;
 b=oxZsKCmHaaijYfHN/EZmG2d0zs8dvcsEOvBEyRkRVkQUTqKsiqT6c97B6P6hQAzHr5
 4EvBKKwL76KbjHPjpixTsKMWozeJpsnztX+chehndxShzGCPen/sbpJLPcUxgb1+fWqy
 IdIzzPaeO2CYBq/98oYrwawRFV7leOsXBFszmf4pLAlUWhMgQbvHf/cDCOnN8xqsf75f
 gZaNrMlxKQ9o1rwYYyumQtnUCrY0HqoyFPsOkstVU0OpGvj85iN31zuUp0HwDqrYlB93
 u/vXpJsOuzZT+JwMqXr1IkMVUfCvHYgTtQIdtlsWumFQa9L2mJFmtWqm99gDMrxW2ee0
 tpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927376; x=1691519376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkmuf4L0OI5wcKr4WVTcr5LnQ0uH5Smo7a7q0ycBiDo=;
 b=AD/CoBU0YMVaBTUS16UzhrjidlC8skbcPfqC3Wdz+bEWuGNYi/fUoYbWTIKJvZDei5
 G41BSdCXqlxbxRDyUpnMuKSRMvpBkreIAK0EuY5CuYWbrk7/WmeWHsnw+dyaPOLNtVFy
 cpR7aD2MwfZvKX18RbwTWQAH3SV+rKyDZEvpmoNFAsfrSK+8FmeSwScP9PvwKSlcO25Q
 Vejr5o8mjt//5LFzRzs7Q+lxAI8hBfrKgtY1mqiavIJr20KeMf5Jjezbt6UXz1N3WoT9
 2etN/bu/mj9/bxl65cMjJQV1lX/p/wdn2uFpdq2HC9NQ1luBHcetdQoMoDvlk0IeXGlx
 yqbg==
X-Gm-Message-State: ABy/qLYisLQvf43suqSzr22pqXpQmZrsCbAfnHheaajt7Ufioys/vPXZ
 txoWVzWwMsIibuers61yjJFrbW0lcgT4tf96+xg0Qw==
X-Google-Smtp-Source: APBJJlHSL+6yWvSzIlE4baOnaFlbzGW2tCLo9HXse4UtaEehG23i8x5b61+xvsyrwd/oqARGSNlmhw==
X-Received: by 2002:a7b:c394:0:b0:3fb:e356:b60d with SMTP id
 s20-20020a7bc394000000b003fbe356b60dmr8459599wmj.38.1688927376034; 
 Sun, 09 Jul 2023 11:29:36 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 00/45] linux-user: patch roundup
Date: Sun,  9 Jul 2023 19:28:12 +0100
Message-Id: <20230709182934.309468-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

I think this is all of the linux-user patches from the list
that are outstanding, except for 

    20230524054647.1093758-1-richard.henderson@linaro.org
    "linux-user/i386: Properly align signal frame"

which failed testing under cross-i386-tci.  I'll have another look
at that later this week, as it's a bug fix.  If I've missed any,
please shout.


Patches lacking review:
  03-linux-user-Use-abi_uint-not-uint32_t-in-syscall_defs.patch
  07-linux-user-Use-abi_uint-not-unsigned-int-in-syscall_.patch
  10-linux-user-Use-abi_int-not-int-in-syscall_defs.h.patch
  12-host-include-i386-Implement-aes-round.h.patch
  13-host-include-aarch64-Implement-aes-round.h.patch
  14-include-exec-user-Set-ABI_LLONG_ALIGNMENT-to-4-for-m.patch
  15-include-exec-user-Set-ABI_LLONG_ALIGNMENT-to-4-for-n.patch
  28-linux-user-Implement-MAP_FIXED_NOREPLACE.patch
  31-linux-user-Rewrite-target_mprotect.patch
  32-linux-user-Rewrite-mmap_frag.patch
  33-accel-tcg-Introduce-page_find_range_empty.patch
  34-bsd-user-Use-page_find_range_empty-for-mmap_find_vma.patch
  35-linux-user-Use-page_find_range_empty-for-mmap_find_v.patch
  37-linux-user-Rewrite-mmap_reserve.patch
  38-linux-user-Rename-mmap_reserve-to-mmap_reserve_or_un.patch
  39-linux-user-Simplify-target_munmap.patch
  41-accel-tcg-Return-bool-from-page_check_range.patch
  42-linux-user-Remove-can_passthrough_madvise.patch
  43-linux-user-Simplify-target_madvise.patch


r~


Andreas Schwab (1):
  linux-user: Make sure initial brk(0) is page-aligned

Juan Quintela (1):
  linux-user: Drop uint and ulong

Pierrick Bouvier (1):
  linux-user/syscall: Implement execve without execveat

Richard Henderson (41):
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

Robbin Ehn (1):
  linux-user/riscv: Add syscall riscv_hwprobe

 bsd-user/qemu.h                  |    2 +-
 include/exec/cpu-all.h           |   40 +-
 include/exec/user/abitypes.h     |    5 +-
 linux-user/aarch64/target_mman.h |    8 +
 linux-user/alpha/target_mman.h   |   13 +
 linux-user/generic/target_mman.h |   58 +
 linux-user/hppa/target_mman.h    |   10 +
 linux-user/mips/target_mman.h    |   18 +
 linux-user/mips64/target_mman.h  |    2 +-
 linux-user/ppc/target_mman.h     |    8 +
 linux-user/qemu.h                |    2 +-
 linux-user/riscv/syscall32_nr.h  |    1 +
 linux-user/riscv/syscall64_nr.h  |    1 +
 linux-user/sparc/target_mman.h   |    9 +
 linux-user/syscall_defs.h        | 2260 ++++++++++++++----------------
 linux-user/user-mmap.h           |    2 +-
 linux-user/xtensa/target_mman.h  |   18 +
 accel/tcg/cpu-exec.c             |   43 +-
 accel/tcg/user-exec.c            |   72 +-
 bsd-user/mmap.c                  |   50 +-
 linux-user/mmap.c                |  704 +++++-----
 linux-user/strace.c              |   61 +-
 linux-user/syscall.c             |  214 ++-
 target/hppa/op_helper.c          |    2 +-
 target/riscv/vector_helper.c     |    2 +-
 target/sparc/ldst_helper.c       |    2 +-
 tcg/tcg.c                        |    2 +-
 accel/tcg/ldst_atomicity.c.inc   |    4 +-
 28 files changed, 1931 insertions(+), 1682 deletions(-)

-- 
2.34.1


