Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF5781150
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31X-000885-7g; Fri, 18 Aug 2023 13:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31V-00083h-Bv
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31S-0007vW-UT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc7b25c699so8643095ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378749; x=1692983549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gJhn3SDOpovHJc+3PRF1k3E6afjKTpsPuv4C7KZM31E=;
 b=aCHvLYdO7DnFtkWJnzBYtHf7ytYMNkAiWrykDKjdZgkZrmR+2e/WAVQniz43EX/S5x
 YkmYu17zoQB/dE/23VU6wZv6hYGjdSRktZe1cs4woCNh5KWrjNXj+uUzxeGqF4dcpm+N
 JaJYB5SWMA3dsSkK8ekRoKvUWsYTZoaod0ePnn5hmtFmK08w7qj9Sdcfp0kx81TCrNMj
 fOOAu2gOXDt2+qsZe9nBJVH88B89KbUtFLykIIIuMnsYlD3RKyIGZZdGh/8srlVnNGGJ
 0/JnaR0Jb9McyLRsMIu7lXDnbk1KDt999uAuAvJZviYM0+t3tuVpkRK/Gsq2/+zA2daI
 AH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378749; x=1692983549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJhn3SDOpovHJc+3PRF1k3E6afjKTpsPuv4C7KZM31E=;
 b=E+KL76z1KLakZBaybBogP+gedFVZjZicUhSF7nEM7C9PmN2Hh9JgmygDZATCxpnMyT
 gUQc704MD2z4764nQlfd+YZWq2yb0CFokZEudRR/UwsnPZKrPuwbZw7/R6K7CdYrI3H3
 SpEJKDCgoCmASsc5rvXafRRrcXcbqaIeEJzRyBlKYVaUGQpkTIHxJI31FnImAN0GI/ZJ
 xdjQoMYQL567B8cMjcssqi4Xrp0da7Vs+Y5fx9c9yD2FuQV9CeJlUcCGYlxr3xA7SS3K
 XYngU0aPYYOB6YmnezAo7xEWhK/UJdbsRbd5hJtEyNIeMeiDYL/M+6/BkNsnZkCqptCo
 87lA==
X-Gm-Message-State: AOJu0Ywxl81GTzaO1lrL/2AU1t/Ubo+7Xrwys97HwJ5H4Yv5qmN7ZrzQ
 HThtq17NLUyrQP/zl5pwsGO1luYvEV1fk5VcKbI=
X-Google-Smtp-Source: AGHT+IFyE6wnV+XU75oPYC+Ykwquzqnh2fSqQiJD8E/b4ot2Xvj+65ePeJ8O174hCFnmM/yIEzvfpg==
X-Received: by 2002:a17:902:b78c:b0:1bc:239:a7e3 with SMTP id
 e12-20020a170902b78c00b001bc0239a7e3mr3013935pls.44.1692378749173; 
 Fri, 18 Aug 2023 10:12:29 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/33] linux-user: Improve host and guest page size handling
Date: Fri, 18 Aug 2023 10:11:54 -0700
Message-Id: <20230818171227.141728-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


PS: There are probably minor conflicts without
Based-on: 20230816180338.572576-1-richard.henderson@linaro.org
("[PATCH v4 00/18] linux-user: Implement VDSOs")

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
  linux-user: Deprecate and disable -p pagesize
  cpu: Remove page_size_init
  accel/tcg: Disconnect TargetPageDataNode from page size
  linux-user: Allow TARGET_PAGE_BITS_VARY
  target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
  linux-user: Bound mmap_min_addr by host page size
  target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
  target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only

 bsd-user/qemu.h                           |   7 +
 include/exec/cpu-common.h                 |   7 -
 include/hw/core/cpu.h                     |   2 -
 target/alpha/cpu-param.h                  |  16 +-
 target/arm/cpu-param.h                    |   6 +-
 target/ppc/cpu-param.h                    |   9 +-
 accel/tcg/translate-all.c                 |   1 -
 accel/tcg/user-exec.c                     |  31 +-
 bsd-user/main.c                           |  12 +
 cpu.c                                     |  13 -
 hw/tpm/tpm_ppi.c                          |   3 +-
 linux-user/elfload.c                      |  67 +-
 linux-user/main.c                         |  33 +-
 linux-user/mmap.c                         | 714 +++++++++++++---------
 migration/ram.c                           |  22 +-
 softmmu/physmem.c                         |  17 +-
 softmmu/vl.c                              |   1 -
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
 28 files changed, 614 insertions(+), 445 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

-- 
2.34.1


