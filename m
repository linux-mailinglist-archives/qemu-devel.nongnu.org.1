Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A670743CAF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4g-0007bX-NG; Fri, 30 Jun 2023 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4c-0007aL-Ek
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4Z-0003JL-P0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so2061079f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131321; x=1690723321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+Bi6ZomvekyWwQBC9VpThRHcbVdvWAoc703NTG3BqE=;
 b=AUIVIdlBt8MZ/WQXX6ZQOyarcBYBVx9uKyqV5jGlKbQaBE/v7p+dUqCVp6x9fnMfKo
 meGnKg6L7hgNa+YSN6sfD1KwjtT4GJAgp4CE/RfIGPvfsFSLfeuYinbKTOe/yHPN81so
 3sHw+0+lRvkh4PlgD7wWTUGGLPHaPgtnHxtv134RovS1jY2UIJt/1Zc67ghP09hVdS0m
 OboD2p8/6DDZMpSZQZ7/cqnCh2YNuq1f6Q/t9QX9LgB4PK/6oArZ6EFADgvY3Mk1baLi
 J79ZNGdlQaHEW/p2o4LfqkkIbLYf4LFPTj90BAa4xY9pH6arrJP8WWBjnoNrzK5eEvp1
 PWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131321; x=1690723321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+Bi6ZomvekyWwQBC9VpThRHcbVdvWAoc703NTG3BqE=;
 b=BXbjhi96M7gd522PlIRWAwsEMNY4aI4qdkjRdjAnXksMoA5hcdQ+GoVHOVVV+93mBS
 3HfYgEtRv6tdYmZpeLOIgWmmMuYJ8+fePuMl1bQMTFMrC7/0juWsPj15yLtuW2XQES2x
 oJYgg7opi79vY3uvo+WtSSexn26dr4pgc9n4AeWPdF8mf+JVuQu8kdosGIM8SgO3uw7V
 ntHzFaq5l9rwNN8AlLm116gtnZVxQmT5VBkfY7ebGPwpnuBz7pdnRR8K1g4b2HfWod4d
 Av7OonZPqsc2EzbkCgpZFCo5w0xwLZmTpR2FfyMZ10Q4ZqXsNvGHwuAUdq6blI3WmJOC
 SQwA==
X-Gm-Message-State: ABy/qLY8FNKavbSp8Fo8G0z5IAvHX5o6XhAvYfjjeZiXkYF0GGcL86/j
 yb5ds0rd51xAHpipceWNJQSl+iK75dKijnTbRb6e+g==
X-Google-Smtp-Source: APBJJlGLUoGphVtU6zHOL8bqsV/NWteHgde9FLw2BfwNA0JR9FJpcIptlNRKl+Yh2LDu6A0IA6+O7w==
X-Received: by 2002:adf:fd43:0:b0:313:f5f8:a331 with SMTP id
 h3-20020adffd43000000b00313f5f8a331mr2553362wrs.34.1688131321379; 
 Fri, 30 Jun 2023 06:22:01 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH for-8.1? 00/24] linux-user: mmap range fixes
Date: Fri, 30 Jun 2023 15:21:35 +0200
Message-Id: <20230630132159.376995-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

Supercedes: 20230629080835.71371-1-richard.henderson@linaro.org

While the above should make its way back into 8.0.N, we can do better
than simply avoiding the last page for automatically placed pages.
After this patch set, nothing in linux-user/mmap.c uses "end".

In the process, this fixes a couple of inefficiencies, where we
were probing pages one by one instead of walking the interval tree.

This also passes MJT's hppa fenics-basix test case.


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
 include/exec/cpu-all.h           |  39 +-
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
 bsd-user/mmap.c                  |  49 +--
 linux-user/mmap.c                | 702 ++++++++++++++++---------------
 linux-user/strace.c              |  61 +--
 linux-user/syscall.c             |  22 +-
 target/hppa/op_helper.c          |   2 +-
 target/riscv/vector_helper.c     |   2 +-
 target/sparc/ldst_helper.c       |   2 +-
 accel/tcg/ldst_atomicity.c.inc   |   4 +-
 23 files changed, 638 insertions(+), 538 deletions(-)

-- 
2.34.1


