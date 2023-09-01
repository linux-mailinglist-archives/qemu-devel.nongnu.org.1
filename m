Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8178F6FD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtow-0006Rr-49; Thu, 31 Aug 2023 22:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtou-0006Rf-EH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:36 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtor-0001Na-SG
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:36 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-56a3e6bce68so1063271a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535012; x=1694139812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VgtVEtfsGPNKYq8tMsndmynxnaxH/hCwV+PXhCi2NPE=;
 b=JJDeMRVa7mjvBkgvt6MzvFHt6sIuD/d/j4QExUuvN48i6E/niQGFECl9pWyGz6iDWF
 bB5URooKl5q75/t5To31gW0dK38EiJuAkgJrfKthwVt44ECIGjKYuMPFMsNDeoF86sEP
 dqtIlJvV2lZqTGr+m2s+LD0OvOt7JGSoV2TTeLtqZxO6IMe+WL0iVee2fPB2j6QScY+h
 23tdSSlH5AtZrGRJFphgCGXlWUXU2vZI/qy0M4zan9sX/64IFOEesslmUPdGVZ1DuMQv
 Jonmf85GYr2VB0nyXnlLOgNn93q++y97Qp6e5DFq2vWT0T0CBZmJ50d4lzhOwMdEiJcx
 UoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535012; x=1694139812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VgtVEtfsGPNKYq8tMsndmynxnaxH/hCwV+PXhCi2NPE=;
 b=CWqnftMpUTl3OefnfGeFB3bqp+AEbjSDSF7E4ZvWvjNm4I+rkNO9w8lkDc1UVUg5Aj
 /A3xPBAWL+xBNTNQ5OsftlISh8mB+ojFi+VvPINMUa2MzIbz8JjlL/eQUvswJ+Gf0RMN
 g8qB2cujGnmdEIxVeLE79je8f1e68U200agTOPnURO15XvMUxWy0/OpDhGCNx8h10T1F
 nm45S6Je3pLrzGEbR58okVyQOsOSOa5qfgC6mZdIUnGjNlRp/nPDiop+iJnlHJC4mU1j
 4sGZnuJ070zVVALPmkmmCaP7Kj4YeUXV1CiF90A3s3TzHEU5OnT6ruXKXKgP3Wc0DEoi
 BL2Q==
X-Gm-Message-State: AOJu0YwBCKPBtZAUGur5UPTO0cDlkirbaG/pbw0CmliHEwDapLTw919j
 mhJ7peQ3b4IeT9ifPAbhiyEqYM1MLOWkO9fzq8E=
X-Google-Smtp-Source: AGHT+IHkPZMlfo4rE/RgiAh1c6ZQOh3LgX2oDLnpjsVr2rTZEw8LHdj25C0zm739UQw+v1xVGbO3Ew==
X-Received: by 2002:a05:6a21:7787:b0:14c:d105:2d7e with SMTP id
 bd7-20020a056a21778700b0014cd1052d7emr1457381pzc.30.1693535012261; 
 Thu, 31 Aug 2023 19:23:32 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 00/33] linux-user: Improve host and guest page size handling
Date: Thu, 31 Aug 2023 19:22:58 -0700
Message-Id: <20230901022331.115247-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Based-on: 20230829220228.928506-1-richard.henderson@linaro.org
("[PATCH v5 00/20] linux-user: Implement VDSOs")

Changes for v2:
  * Minor adjustments to bsd-user.
  * Update docs for deprecation.
  * Philippe's r-b.

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
 30 files changed, 626 insertions(+), 452 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

-- 
2.34.1


