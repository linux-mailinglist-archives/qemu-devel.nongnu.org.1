Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3964716D47
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o2-0006JX-EF; Tue, 30 May 2023 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nq-0005vd-Mk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44no-0004b7-U1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64fbfe0d037so120756b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474079; x=1688066079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j8DFII/Utn3dXL/8Iq9AplYqonrV9FdyNAmYCoypIto=;
 b=KRfuYxHgpXd/9YtJG6gOew0ToRT+0hPkFoTgxaeik3t2+NOsfN15ECTzgCxqU6vPNY
 c4ynNjbhF8uOTUPW2IGQ+xvPvWS6KeDm7PMHoW2brhTn9stg2ywGCN0h3X1OIv8kxKez
 CMtBNtzqBsbfg3Y2Bv4JTARESOiq0ss+UrCWc9QhcdejmrY7NJDDXJAWamcZ7WG5F30V
 qglLYQWAftsrIzWvuMv2GzbIw6+H5wSqmk5hDp9YdFOiM+znvbBH4k/xZ2BCM09zRLPI
 NXwIqfU1r/hZfoBJkeNTrMIYLDLbltFsEMxeSmZk6PsTgmH7wmiU9nEhf1/zWrH6m5eH
 ArLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474079; x=1688066079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8DFII/Utn3dXL/8Iq9AplYqonrV9FdyNAmYCoypIto=;
 b=SCevgg5ioXKox6CsqKvBtiSh79AuPb0ukt6bdWShVCNku9GycqQIMyb1Tl0+ikGjVN
 kLOgne6LTmkFdI89Jbxli0m37O0knPB0GMsrtHtMKBYJDzDsruqyMxYo7ywuOwYpyNlD
 pUZlrrOTN2ipA1LLZpL4n4SJtIExpi2UwGCbKBlsoFMrgcWQUYTfh2Cs0HBkzOk5l0EK
 7woyUgIG1NcLlsTbfTeb5Mr41fqNYJbW8rEkYdS/dzI3o7zYZJWHAxLpiPg0JL1bEpxj
 bn+sdIIu8vfDAHK9PpFsYKsGBlOXZdj//3NJEZdZds2JnSyDZNFy7Teh7giZveAa7Fj0
 oEfg==
X-Gm-Message-State: AC+VfDyRS+FP2b1OyooEDphB3cnetXbZtLdW3wQ0WVfakR4bLltQB0B1
 psroHDXAIi+a77deYR8IAGTB5wWOKJObHK+pgdU=
X-Google-Smtp-Source: ACHHUZ7FYnEE2m9fZB7pXEJfwtnWoQcFx6Ghnl2czK8z/Idxk0UhRJYUMCNBqHwY4FqyqA08q2vXcw==
X-Received: by 2002:a05:6a20:7d84:b0:10e:96a4:e31d with SMTP id
 v4-20020a056a207d8400b0010e96a4e31dmr13636326pzj.22.1685474079407; 
 Tue, 30 May 2023 12:14:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 00/20] target/arm: Implement FEAT_LSE2
Date: Tue, 30 May 2023 12:14:18 -0700
Message-Id: <20230530191438.411344-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

All prerequisites are upstream.  There are still outstanding patches
to improve the atomic16 support, but those are all optimizations.

Patches needing r-b:
  16-target-arm-Relax-ordered-atomic-alignment-checks-.patch


r~


Richard Henderson (20):
  target/arm: Add commentary for CPUARMState.exclusive_high
  target/arm: Add feature test for FEAT_LSE2
  target/arm: Introduce finalize_memop_{atom,pair}
  target/arm: Use tcg_gen_qemu_ld_i128 for LDXP
  target/arm: Use tcg_gen_qemu_{st,ld}_i128 for do_fp_{st,ld}
  target/arm: Use tcg_gen_qemu_st_i128 for STZG, STZ2G
  target/arm: Use tcg_gen_qemu_{ld,st}_i128 in gen_sve_{ld,st}r
  target/arm: Sink gen_mte_check1 into load/store_exclusive
  target/arm: Load/store integer pair with one tcg operation
  target/arm: Hoist finalize_memop out of do_gpr_{ld,st}
  target/arm: Hoist finalize_memop out of do_fp_{ld,st}
  target/arm: Pass memop to gen_mte_check1*
  target/arm: Pass single_memop to gen_mte_checkN
  target/arm: Check alignment in helper_mte_check
  target/arm: Add SCTLR.nAA to TBFLAG_A64
  target/arm: Relax ordered/atomic alignment checks for LSE2
  target/arm: Move mte check for store-exclusive
  tests/tcg/aarch64: Use stz2g in mte-7.c
  tests/tcg/multiarch: Adjust sigbus.c
  target/arm: Enable FEAT_LSE2 for -cpu max

 docs/system/arm/emulation.rst  |   1 +
 target/arm/cpu.h               |  16 +-
 target/arm/internals.h         |   3 +-
 target/arm/tcg/helper-a64.h    |   3 +
 target/arm/tcg/translate-a64.h |   4 +-
 target/arm/tcg/translate.h     |  65 ++++-
 target/arm/tcg/cpu64.c         |   1 +
 target/arm/tcg/helper-a64.c    |   7 +
 target/arm/tcg/hflags.c        |   6 +
 target/arm/tcg/mte_helper.c    |  18 ++
 target/arm/tcg/translate-a64.c | 477 ++++++++++++++++++++++-----------
 target/arm/tcg/translate-sve.c | 106 +++++---
 target/arm/tcg/translate.c     |   1 +
 tests/tcg/aarch64/mte-7.c      |   3 +-
 tests/tcg/multiarch/sigbus.c   |  13 +-
 15 files changed, 523 insertions(+), 201 deletions(-)

-- 
2.34.1


