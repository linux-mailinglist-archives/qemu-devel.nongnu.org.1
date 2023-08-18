Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F562781543
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7is-0004uj-4I; Fri, 18 Aug 2023 18:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ip-0004th-QS
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:35 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7il-0004LR-7g
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-689f9576babso1189360b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396809; x=1693001609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PpfItaz3tt0i3+oBgiUE0ScVCwqJMcf75OhTCKNQzPg=;
 b=x6n0OcmHlImhSHXkh7ltvWwZiHvCUgdTAy/0697tJSujSFyb3/O4CVbT8LycPqyP33
 NPUrGn6/teLakg1Fh5v7ZSiyCATKekh5G6gCOMZn+pkXOXwEpKriG7FfvhTxUX4wGQYM
 jFYh+HjU0dZvm4IpbVracrpE31z9zUhsVXNZgMOUxgpKRQ735MJY2uw9bDZKjDNnZfab
 CRg0J4SBNHaY0SHt39siRpEREE9vL07hw75f+J0cqUm4u2p/KNQlKM+gom9wX4ocXQAo
 /L1FuUDK7G1ytQCB7DjEv7mKRO2h0E9JywoG7Q0plKoEzN+HNUGHUQ0coaXEz0YlEqvB
 uEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396809; x=1693001609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PpfItaz3tt0i3+oBgiUE0ScVCwqJMcf75OhTCKNQzPg=;
 b=fp5WHoHvtfTbwjiDd99XPF6/VbbU1kY68dSPBw+5UscMORvn9jDk65f/EJ1vMBs6J3
 6+Uk/gVnCHaZ2jaeZPCn6E0VOLQU6BwCJyjqw9KSteBvr9z74SYSG3wJBxQpGLh7tdld
 UlYSScg1dotwBFC5oC96kvL6NeFRZfY5aHWOGVPyuJ5BLIrsRxwFph4t2B2z8louKKWU
 V0+7Sei8Dg8DVCgNs54fcPd1sjrASBMgvQ/dD0qLvyguNe4K6Ow+tUFdhPjlrGbfpVVC
 G12DrsKR3Lk/pSlN6F7QwDqnMaErz4gW1Rh5manVOhvKEg77vojfXOmtOr3wQMVXjHJY
 XA9w==
X-Gm-Message-State: AOJu0YwMCsrutZw1CvjNn4cNJgHaOU07mRQAvV4K4Z15V1/fMuSUbOS3
 6rKkuMuHSQVbrvnDiSprDrLsmYCDjrXMv5wBmQk=
X-Google-Smtp-Source: AGHT+IHN5wN9tS8x7+vv8/mpl6tH0bT/ySb49Rgzzt3CohLWvdLKmXlNeObFtOQVX9+J26KpyrHN2Q==
X-Received: by 2002:a05:6a20:2455:b0:122:10f9:f635 with SMTP id
 t21-20020a056a20245500b0012210f9f635mr691052pzc.19.1692396808811; 
 Fri, 18 Aug 2023 15:13:28 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
	qemu-s390x@nongnu.org
Subject: [PATCH v2 00/23] tcg: Introduce negsetcond opcodes
Date: Fri, 18 Aug 2023 15:13:04 -0700
Message-Id: <20230818221327.150194-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes for v2:
  * Drop "tcg/i386: Add cf parameter to tcg_out_cmp" patch.

Patches needing review:
  15: tcg/s390x: Implement negsetcond_*


r~


Cc: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org


Richard Henderson (23):
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
 tcg/i386/tcg-target.c.inc                  | 255 +++++++++++++--------
 tcg/ppc/tcg-target.c.inc                   | 149 ++++++++----
 tcg/riscv/tcg-target.c.inc                 |  45 ++++
 tcg/s390x/tcg-target.c.inc                 |  78 ++++---
 tcg/sparc64/tcg-target.c.inc               |  36 ++-
 35 files changed, 567 insertions(+), 265 deletions(-)

-- 
2.34.1


