Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2018821636
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU2t-0003DL-55; Mon, 01 Jan 2024 20:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2r-0003DB-QG
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:17 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2q-0006yE-20
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:17 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28c179bf45cso6046632a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160694; x=1704765494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Phs6kFH0yDoEdmVot2tnW2SYoFAes1gd+B7yhP9pAk=;
 b=JKg0oTPr4SZO/7votEoAxx3KNegUKG+1kYM2yH/YBR1L6aJJjzbgCaL+yMdxPkIU5n
 l6GXpSYOF8lT8BEW4+vyzoL4xeWL2aSzaiYUeECMZyjH9utdoAp9r3pUxny5ST1peAJW
 5CPbx/69/iyqylObOhwtwyle79ANXic6UysRk3bTN+yPUq8od6B1OzliCcmi6OLay0pf
 rfqgRkWukR8gGIz65C3eHtuhc5hGfe0A0vG6KR2oVJk8ilqQjbw66MGjcTae4A+LFWsm
 UxWKYNjafQGVkkxiCfjfbk34cqdCZvnL9udJ6h2cnjHOUuHsKSusOJiZGNZSqYUSD6bV
 C4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160694; x=1704765494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Phs6kFH0yDoEdmVot2tnW2SYoFAes1gd+B7yhP9pAk=;
 b=AY0AfbQfDDwVMckYraUDfd3qWeuXlr0p6wt3YESBnFwVV37SUdEslKFYdIzdcon40U
 D9B1Bb83EnrXqgKxm11yHDyMgScSkQl2Eyh2uh8dKFA6ugARTPB5n3o2SHabE/xhBWQK
 4+lfGXleYqfdjiBn1dQNfZ3lOy0cLm+Smbp2SaynzI218VxQ4t8+hRPTNdp1TWnxfP/m
 rnBn//0b7nh6LX8UDWO7BT9XtTjGXsd8PYj3+GD1wu3oD2W+VW43MdS/ABMMvJg56bY1
 woUedtZRHlG1BqWpt6eJtPsBkgNTBKGhBwKSNtRUWk2NmPQw/MPBh8kDgO96gN5+VB7v
 FaHg==
X-Gm-Message-State: AOJu0Yyy/FjCTkRfU3z/m6ktUwkKJdMP8rtZahELBTwhTAzit38x93yf
 mI+ucBwWWzlzA9xPFdYJHADTxR8EdAjz2PMtNnEiLOmgMYs=
X-Google-Smtp-Source: AGHT+IEWW6MtVUoreTR3b9cOO+411no0Tx+aux1JDeLUSQp0nuL6ZsI9sAPRNA2xI2x66sk6+NsaHw==
X-Received: by 2002:a05:6a20:6a1c:b0:196:8ad0:9a11 with SMTP id
 p28-20020a056a206a1c00b001968ad09a11mr8460182pzk.96.1704160694148; 
 Mon, 01 Jan 2024 17:58:14 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/33] linux-user: Improve host and guest page size handling
Date: Tue,  2 Jan 2024 12:57:35 +1100
Message-Id: <20240102015808.132373-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Changes for v3:
  * Rebase.

Blurb from v1:

While working on mmap issues for 8.1, I noticed a lot of corner
cases of host != guest page size that we implement poorly.
This seems to be particularly visible on Apple M1 with 16k pages,
more so than Power with 64k pages for some reason.

Objective 1 is to deprecate and (essentially) disable the -p option.

The effect of -p is apparently confusing, so much so that our own
testsuite misuses it.  One cannot really change the host page size,
and pretending otherwise means that we don't treat the host memory
system correctly, and stuff breaks.

I have not yet done the same work for bsd-user.

Objective 2 is to allow the guest page size to change to match the host.

There are corner cases of host != guest page size will fail in odd ways.
For case of host > guest page size, the issues could be solved with
softmmu, allowing a non-linear mapping between host and guest addresses
and also disconnecting host and guest page permissions.

However, host < guest page has issues with SIGBUS which I believe to be
totally unfixable.  At minimum one would need to monitor changes to all
files mapped in the address space, but I'm sure there is much more.

But as always the best behaviour is obtained when the host and guest
page sizes match -- there are no corner cases to contend with.

There are a set of guests which can be configured to use multiple page
sizes, and therefore software developed for those guests (usually) does
not hard-code a particular page size.  For those, we can allow the
page size to vary and let the guest match the host.

I have only changed aarch64, alpha and ppc guests so far, as those
are both easy to test and, especially for the case of alpha's default
8k page size, prone to failure.


r~


Richard Henderson (33):
  accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
  linux-user: Adjust SVr4 NULL page mapping
  linux-user: Remove qemu_host_page_{size,mask} in probe_guest_base
  linux-user: Remove qemu_host_page_size from create_elf_tables
  linux-user/hppa: Simplify init_guest_commpage
  linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
  linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
  linux-user: Remove qemu_host_page_{size,mask} from mmap.c
  linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
  linux-user: Remove HOST_PAGE_ALIGN from mmap.c
  migration: Remove qemu_host_page_size
  hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
  softmmu/physmem: Remove qemu_host_page_size
  softmmu/physmem: Remove HOST_PAGE_ALIGN
  linux-user: Remove qemu_host_page_size from main
  linux-user: Split out target_mmap__locked
  linux-user: Move some mmap checks outside the lock
  linux-user: Fix sub-host-page mmap
  linux-user: Split out mmap_end
  linux-user: Do early mmap placement only for reserved_va
  linux-user: Split out mmap_h_eq_g
  linux-user: Split out mmap_h_lt_g
  linux-user: Split out mmap_h_gt_g
  tests/tcg: Remove run-test-mmap-*
  tests/tcg: Extend file in linux-madvise.c
  *-user: Deprecate and disable -p pagesize
  cpu: Remove page_size_init
  accel/tcg: Disconnect TargetPageDataNode from page size
  linux-user: Allow TARGET_PAGE_BITS_VARY
  target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
  linux-user: Bound mmap_min_addr by host page size
  target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
  target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only

 docs/about/deprecated.rst                 |   7 +
 docs/user/main.rst                        |   3 -
 bsd-user/qemu.h                           |   7 +
 include/exec/cpu-common.h                 |   7 -
 include/hw/core/cpu.h                     |   2 -
 target/alpha/cpu-param.h                  |  16 +-
 target/arm/cpu-param.h                    |   6 +-
 target/ppc/cpu-param.h                    |   9 +-
 accel/tcg/translate-all.c                 |   1 -
 accel/tcg/user-exec.c                     |  31 +-
 bsd-user/main.c                           |  21 +-
 cpu-target.c                              |  13 -
 hw/tpm/tpm_ppi.c                          |   3 +-
 linux-user/elfload.c                      |  67 +-
 linux-user/main.c                         |  33 +-
 linux-user/mmap.c                         | 714 +++++++++++++---------
 migration/ram.c                           |  22 +-
 system/physmem.c                          |  17 +-
 system/vl.c                               |   1 -
 target/arm/cpu.c                          |  51 +-
 tests/tcg/multiarch/linux/linux-madvise.c |   2 +
 tests/tcg/alpha/Makefile.target           |   3 -
 tests/tcg/arm/Makefile.target             |   3 -
 tests/tcg/hppa/Makefile.target            |   3 -
 tests/tcg/i386/Makefile.target            |   3 -
 tests/tcg/m68k/Makefile.target            |   3 -
 tests/tcg/multiarch/Makefile.target       |   9 -
 tests/tcg/ppc/Makefile.target             |  12 -
 tests/tcg/sh4/Makefile.target             |   3 -
 tests/tcg/sparc64/Makefile.target         |   6 -
 30 files changed, 626 insertions(+), 452 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

-- 
2.34.1


