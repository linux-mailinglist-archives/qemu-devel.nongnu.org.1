Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6C82A41C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJI-0004QX-LH; Wed, 10 Jan 2024 17:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJG-0004Q6-1q
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:30 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJE-0002Og-82
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:29 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so3834076276.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926666; x=1705531466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDLkiIiuMWJLnnYxUs/vsP2E2v2LV+NUnxs22kj9jnQ=;
 b=tlCDzn6q8zsjXDCxtHLwrWRHADV+bDBPtZaczBxgllKJbzNJX/eZHdW0urNyoFDYqE
 Y2v4i9QKoZxuAe2wq8GVK2YaJQDRds4zo9MwJ+OtQQnUPinbLt2H4lJOsARdK4qDOH9A
 4CHTRPpCooOIVWtXJFclxngGpoZUeFk6SOkQ+6ABB8kh9Tk9CPWSMyD8yIBAimGNYQuT
 1wufd6QmYN1dqAvqKMgVhx6NXNOYHMHOC/ltRmIRwpIPuwoFFf9o6TzSzxwlSzEO5GeD
 x7Cf5WShfySuhc9PUSd/0u0HP6bRFxnnpC6ZnVbUSmIW4jFruPZXx+8EpIdiadAnv+cS
 Vl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926666; x=1705531466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDLkiIiuMWJLnnYxUs/vsP2E2v2LV+NUnxs22kj9jnQ=;
 b=ee1TuTrpbv/8cT55HrxnA//Tb1IDFgQfI12eGN7gG5s2rEI1qVIb71gBKIpBc1ULhn
 dLZdiUVYys6XmxjohHL9m3qCt29D0GyspXhl7deP4cgY40fC9XsDEiMc+9KwMssIp/7w
 KP8aXQ3SV+jH0wugz4Gusxb0vtgWONwhqv6LtQS/EMszkFXhgW1nFU6vUqa7UC4EI3Wu
 GEQVFtBUXhmo8cALJdGBzjX7CuGwurekzENst3uWH+fYtLkAA068MLH1S6mO8Y71s7fJ
 WK1j+fqmIgcRmKnP+tu7T3HXzRZDDZl2aAiXDrVbCd+1f4Mc4EF3L5Rf8t4dERAJ4he4
 iwuA==
X-Gm-Message-State: AOJu0YzIFnrXsI+wu8vbBrwUPbzHKikvbpfzjDcpQYLeZEUPXVQ9/1uk
 QoPsicTflhdv54nkC3E9nrXLQSRhc89nEN2SfHIK/45gq8Rwe1d3
X-Google-Smtp-Source: AGHT+IFzxzvcBEg/vxAS4AoNjP6dezmrcXGtqAYMJA23t6qhjSZ8muuqczFFGFAy9hrxji9hviV8JQ==
X-Received: by 2002:a25:4fd7:0:b0:dbe:3abd:3e7c with SMTP id
 d206-20020a254fd7000000b00dbe3abd3e7cmr320766ybb.83.1704926666545; 
 Wed, 10 Jan 2024 14:44:26 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:44:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 00/38] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:43:30 +1100
Message-Id: <20240110224408.10444-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2e.google.com
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

Expose a pair of comparison operators that map to the "test"
comparison that is available on many architectures.

Changes for v3:
  * Make support for TCG_COND_TST* optional (paolo)
  * Drop riscv, loongarch64 and (unposted) mips backend changes.
  * Incorporate Paolo's tcg/i386 TEST improvements
  * Convert some target/s390x cases for even more testing.
  * Probably some bug fixes in there too...


r~


Paolo Bonzini (1):
  tcg/i386: Use TEST r,r to test 8/16/32 bits

Richard Henderson (37):
  tcg: Introduce TCG_COND_TST{EQ,NE}
  tcg: Introduce TCG_TARGET_HAS_tst
  tcg/optimize: Split out arg_is_const_val
  tcg/optimize: Split out do_constant_folding_cond1
  tcg/optimize: Do swap_commutative2 in do_constant_folding_cond2
  tcg/optimize: Handle TCG_COND_TST{EQ,NE}
  tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported
  target/alpha: Pass immediate value to gen_bcond_internal()
  target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
  target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
  target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
  target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
  target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
  target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
  target/s390x: Improve general case of disas_jcc
  tcg: Add TCGConst argument to tcg_target_const_match
  tcg/aarch64: Support TCG_COND_TST{EQ,NE}
  tcg/aarch64: Generate TBZ, TBNZ
  tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
  tcg/arm: Factor tcg_out_cmp() out
  tcg/arm: Support TCG_COND_TST{EQ,NE}
  tcg/i386: Pass x86 condition codes to tcg_out_cmov
  tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
  tcg/i386: Support TCG_COND_TST{EQ,NE}
  tcg/i386: Improve TSTNE/TESTEQ vs powers of two
  tcg/sparc64: Hoist read of tcg_cond_to_rcond
  tcg/sparc64: Pass TCGCond to tcg_out_cmp
  tcg/sparc64: Support TCG_COND_TST{EQ,NE}
  tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
  tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
  tcg/ppc: Tidy up tcg_target_const_match
  tcg/ppc: Add TCG_CT_CONST_CMP
  tcg/ppc: Support TCG_COND_TST{EQ,NE}
  tcg/s390x: Split constraint A into J+U
  tcg/s390x: Add TCG_CT_CONST_CMP
  tcg/s390x: Support TCG_COND_TST{EQ,NE}
  tcg/tci: Support TCG_COND_TST{EQ,NE}

 docs/devel/tcg-ops.rst           |   2 +
 include/tcg/tcg-cond.h           |  74 +++--
 tcg/aarch64/tcg-target-con-set.h |   5 +-
 tcg/aarch64/tcg-target-con-str.h |   1 +
 tcg/aarch64/tcg-target.h         |   2 +
 tcg/arm/tcg-target.h             |   2 +
 tcg/i386/tcg-target-con-set.h    |   6 +-
 tcg/i386/tcg-target-con-str.h    |   1 +
 tcg/i386/tcg-target.h            |   2 +
 tcg/loongarch64/tcg-target.h     |   2 +
 tcg/mips/tcg-target.h            |   2 +
 tcg/ppc/tcg-target-con-set.h     |   5 +-
 tcg/ppc/tcg-target-con-str.h     |   1 +
 tcg/ppc/tcg-target.h             |   2 +
 tcg/riscv/tcg-target.h           |   2 +
 tcg/s390x/tcg-target-con-set.h   |   8 +-
 tcg/s390x/tcg-target-con-str.h   |   3 +-
 tcg/s390x/tcg-target.h           |   2 +
 tcg/sparc64/tcg-target.h         |   2 +
 tcg/tcg-internal.h               |   2 +
 tcg/tci/tcg-target.h             |   2 +
 target/alpha/translate.c         |  94 +++---
 target/m68k/translate.c          |  74 +++--
 target/s390x/tcg/translate.c     | 100 +++----
 target/sparc/translate.c         |   4 +-
 tcg/optimize.c                   | 474 +++++++++++++++++++++++--------
 tcg/tcg.c                        |  40 ++-
 tcg/tci.c                        |  14 +
 tcg/aarch64/tcg-target.c.inc     | 165 ++++++++---
 tcg/arm/tcg-target.c.inc         |  62 ++--
 tcg/i386/tcg-target.c.inc        | 201 +++++++++----
 tcg/loongarch64/tcg-target.c.inc |   3 +-
 tcg/mips/tcg-target.c.inc        |   3 +-
 tcg/ppc/tcg-target.c.inc         | 294 ++++++++++++++-----
 tcg/riscv/tcg-target.c.inc       |   3 +-
 tcg/s390x/tcg-target.c.inc       | 246 +++++++++++-----
 tcg/sparc64/tcg-target.c.inc     |  65 +++--
 tcg/tci/tcg-target.c.inc         |   3 +-
 38 files changed, 1378 insertions(+), 595 deletions(-)

-- 
2.34.1


