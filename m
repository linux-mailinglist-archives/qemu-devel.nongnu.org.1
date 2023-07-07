Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2E74B826
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:41:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGC-0004hY-LF; Fri, 07 Jul 2023 16:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGA-0004hH-Hm
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:40:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsG8-0004Wj-Ti
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:40:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so24429355e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762455; x=1691354455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=txzOaLe2cehlMgiFYGOJxKKmE2wb3z//zRdHPmMkHdI=;
 b=z1/JMaoigwbQ+FN7/S7beAyxB6EBVbpNPsxORlwnScPrard/LA0t7Lcz2NHwNJpqWi
 ZhKd281QU56ThQfAlkH2Q1RBb66zfSozHEg9C6zmU0XogySB/rQ16oRz472MXwFbhhGU
 EycnFuBLfpXUI40SiFh/WQUVIKJ6Y0VsbzoMGifCVV2J1gwcf4LsXXe4F7RMYEBAf/B7
 aQBc30UlrkX48rUaEjHnNxZcnPtAJic4nVIsZhzktDGwadcYRY/lHFnPYATJJ7y9lDd1
 c3Qpqxuv/jlRzZuSWzh18l4E3/j5Y3XTWnM3KwJ3dOti7ulFmAuf5cBJ9U05j8dgsfzz
 N+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762455; x=1691354455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=txzOaLe2cehlMgiFYGOJxKKmE2wb3z//zRdHPmMkHdI=;
 b=aH9Exd9iId40Pzjtq7t7+r3qHc6dj27bV0g9w/FNGqw5NBkELcIsi52/o8Kqxu+Xaq
 iwwWzutaOn8h131qtMuI4omxvsshgYxzHOsn0Mb40xifxLzhzHYNh/mSWSpYZMR4iUyH
 r0oqPCjVDyYJREX/mOTqKZKx7hUoEoHDWg20jAf/7sKJtc0xfziSQktml61yYF4nLzbB
 xom+ZYgrMN0vRbdL5D5YoUe7wIFgiu8oYyoMIwqDdlM4utIbZK4C8TVRKT+EhOQC/3/l
 G1e6gWz2Db16a0kEcgD4Ylk1BcbrXvQqqdzY1uoXESZcLVLCJtfpp1PbCrOYAoTUF9yR
 x28g==
X-Gm-Message-State: ABy/qLb1bhs+XWt+4d469BgUSht8QoXovXAk1PB85hhjXAPeSsG5xiJF
 Wr9uYaCd/LlvwvtBIvj18L10iKUfJfL5VSAGKMm84A==
X-Google-Smtp-Source: APBJJlHZUJAneQfyFUwplE97L55qlPqfT5cCmhlIfUug/MvHn+mJEouDFJbvfy5PITYDgACgJn0Epg==
X-Received: by 2002:a7b:cb90:0:b0:3fa:98c3:7dbd with SMTP id
 m16-20020a7bcb90000000b003fa98c37dbdmr4489594wmi.41.1688762455346; 
 Fri, 07 Jul 2023 13:40:55 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 00/24] linux-user: mmap range fixes
Date: Fri,  7 Jul 2023 21:40:28 +0100
Message-Id: <20230707204054.8792-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Changes for v2:
  * Apply r-b,
  * Fix bsd-user typo.

r~

Richard Henderson (24):
  linux-user: Use assert in mmap_fork_start
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

 bsd-user/qemu.h                  |   2 +-
 include/exec/cpu-all.h           |  40 +-
 linux-user/aarch64/target_mman.h |   3 +
 linux-user/alpha/target_mman.h   |  13 +
 linux-user/generic/target_mman.h |  58 +++
 linux-user/hppa/target_mman.h    |  10 +
 linux-user/mips/target_mman.h    |  13 +
 linux-user/mips64/target_mman.h  |   2 +-
 linux-user/ppc/target_mman.h     |   3 +
 linux-user/qemu.h                |   2 +-
 linux-user/sparc/target_mman.h   |   4 +
 linux-user/syscall_defs.h        |  96 +----
 linux-user/user-mmap.h           |   2 +-
 linux-user/xtensa/target_mman.h  |  13 +
 accel/tcg/user-exec.c            |  72 +++-
 bsd-user/mmap.c                  |  50 +--
 linux-user/mmap.c                | 708 ++++++++++++++++---------------
 linux-user/strace.c              |  61 +--
 linux-user/syscall.c             |  22 +-
 target/hppa/op_helper.c          |   2 +-
 target/riscv/vector_helper.c     |   2 +-
 target/sparc/ldst_helper.c       |   2 +-
 accel/tcg/ldst_atomicity.c.inc   |   4 +-
 23 files changed, 640 insertions(+), 544 deletions(-)

-- 
2.34.1


