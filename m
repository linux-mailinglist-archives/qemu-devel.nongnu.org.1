Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7C773765
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8R-0008R5-0U; Mon, 07 Aug 2023 23:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8P-0008Q1-Np
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:11:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8M-00006n-K1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:11:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-687ca37628eso766313b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464304; x=1692069104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=beXQyTRLGdD+zrgylrsHYTELdRMMXnrVVBuGcJOXCHg=;
 b=iDVMP18rzv9csWNh0WdGZIWaCPqWys/mxgMYr0W1vj2iiEHZhsjWfDozIi+ovBKLoX
 lkK6hFeyxu9BOv5x5CLNiWhIsPU8vduD6z2XaHrfJM6npn+om9dPKIvmCJU/0tB/VTBQ
 2OEc4RQrlNMH2Qzhs/BGRvabkZNxNG/OPQrOl0AvAlwb/qas79DvN8BDwdk/nN6BYAZv
 TcrMHSybUsvHVKYkK2wjCnX7iE9yK3J9/gkQ5j8kX9k9j98aDAlHDgajMWvipLGoRLnH
 RAoWhGvx1zw+tprzQA2lpZGT09axpFLngJnr2/ys/s16f1AG9xPjKkUrgZa2v4jZB2pt
 xSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464304; x=1692069104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=beXQyTRLGdD+zrgylrsHYTELdRMMXnrVVBuGcJOXCHg=;
 b=AMTVoCs2mOP6JlnO+7ihS2Mf/xsMpY+JOMMmhH8sHb6+f4pNjcYa/byDS1GHN9Ymeu
 jHV8dVC8NSJviTT2eKpOUeuSC6tV4dv4Kr7H6KvtP8IuhmUGlJlaraFt6A0fK6+jstkr
 QHmruv3frhhlvCIYH6bHBdd/uU0jMSS83+W3xRTm23xDBTJzDABIokkth2AwucBZS6+0
 dzbZazWvDKhme6GhMkXhw5+JDZciBYjjc+e0f258K3rth+CczjH8jBA6w0xODFrtOo/T
 cP5iw00ibxnh5PnegN9AhHB3T1oBil6KUwzLv21meySTSqH2Rfo6Tzr2/dgL+mYBwIQs
 /Y1w==
X-Gm-Message-State: AOJu0YyN/m1HpqVOc7kEfgmD1TnUeE45hVDg+em6eLQpZJg3zHgClcOH
 3E82HxpSuzHRMEY7Bb1Y612sBDIfEvq8PHqRmsk=
X-Google-Smtp-Source: AGHT+IFY1UNNC7Z5ZNw4sVuvfalGQnnnQH90DfIbJOd0I19n8g2gPOyaJWzBfCME22QH7j3EAkmNXg==
X-Received: by 2002:a05:6a20:549f:b0:12f:bc36:4c67 with SMTP id
 i31-20020a056a20549f00b0012fbc364c67mr14021987pzk.61.1691464304626; 
 Mon, 07 Aug 2023 20:11:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH for-8.2 00/24] tcg: Introduce negsetcond opcodes
Date: Mon,  7 Aug 2023 20:11:19 -0700
Message-Id: <20230808031143.50925-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Introduce two new setcond opcode variants which produce -1 instead
of 1 when the condition.  For most of our hosts, producing -1 is
just as easy as 1, and avoid requiring a separate negate instruction.

Use the new opcode in tcg/tcg-op-gvec.c for integral expansion of
generic vector operations.  I looked through target/ for obvious
pairings of setcond and neg.


r~


Richard Henderson (24):
  tcg: Introduce negsetcond opcodes
  tcg: Use tcg_gen_negsetcond_*
  target/alpha: Use tcg_gen_movcond_i64 in gen_fold_mzero
  target/arm: Use tcg_gen_negsetcond_*
  target/m68k: Use tcg_gen_negsetcond_*
  target/openrisc: Use tcg_gen_negsetcond_*
  target/ppc: Use tcg_gen_negsetcond_*
  target/sparc: Use tcg_gen_movcond_i64 in gen_edge
  target/tricore: Replace gen_cond_w with tcg_gen_negsetcond_tl
  tcg/ppc: Implement negsetcond_*
  tcg/ppc: Use the Set Boolean Extension
  tcg/aarch64: Implement negsetcond_*
  tcg/arm: Implement negsetcond_i32
  tcg/riscv: Implement negsetcond_*
  tcg/s390x: Implement negsetcond_*
  tcg/sparc64: Implement negsetcond_*
  tcg/i386: Merge tcg_out_brcond{32,64}
  tcg/i386: Merge tcg_out_setcond{32,64}
  tcg/i386: Merge tcg_out_movcond{32,64}
  tcg/i386: Add cf parameter to tcg_out_cmp
  tcg/i386: Use CMP+SBB in tcg_out_setcond
  tcg/i386: Clear dest first in tcg_out_setcond if possible
  tcg/i386: Use shift in tcg_out_setcond
  tcg/i386: Implement negsetcond_*

 docs/devel/tcg-ops.rst                     |   6 +
 include/tcg/tcg-op-common.h                |   4 +
 include/tcg/tcg-op.h                       |   2 +
 include/tcg/tcg-opc.h                      |   2 +
 include/tcg/tcg.h                          |   1 +
 tcg/aarch64/tcg-target.h                   |   2 +
 tcg/arm/tcg-target.h                       |   1 +
 tcg/i386/tcg-target.h                      |   2 +
 tcg/loongarch64/tcg-target.h               |   3 +
 tcg/mips/tcg-target.h                      |   2 +
 tcg/ppc/tcg-target.h                       |   2 +
 tcg/riscv/tcg-target.h                     |   2 +
 tcg/s390x/tcg-target.h                     |   2 +
 tcg/sparc64/tcg-target.h                   |   2 +
 tcg/tci/tcg-target.h                       |   2 +
 target/alpha/translate.c                   |   7 +-
 target/arm/tcg/translate-a64.c             |  22 +-
 target/arm/tcg/translate.c                 |  12 +-
 target/m68k/translate.c                    |  24 +-
 target/openrisc/translate.c                |   6 +-
 target/sparc/translate.c                   |  17 +-
 target/tricore/translate.c                 |  16 +-
 tcg/optimize.c                             |  41 +++-
 tcg/tcg-op-gvec.c                          |   6 +-
 tcg/tcg-op.c                               |  42 +++-
 tcg/tcg.c                                  |   6 +
 target/ppc/translate/fixedpoint-impl.c.inc |   6 +-
 target/ppc/translate/vmx-impl.c.inc        |   8 +-
 tcg/aarch64/tcg-target.c.inc               |  12 +
 tcg/arm/tcg-target.c.inc                   |   9 +
 tcg/i386/tcg-target.c.inc                  | 265 +++++++++++++--------
 tcg/ppc/tcg-target.c.inc                   | 149 ++++++++----
 tcg/riscv/tcg-target.c.inc                 |  45 ++++
 tcg/s390x/tcg-target.c.inc                 |  78 ++++--
 tcg/sparc64/tcg-target.c.inc               |  36 ++-
 35 files changed, 572 insertions(+), 270 deletions(-)

-- 
2.34.1


