Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5377DA914
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFT-0004gj-LR; Sat, 28 Oct 2023 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFQ-0004fz-5z
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:28 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFO-00045g-FU
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5b97ca78da8so82735a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522324; x=1699127124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XDHPSY2ccwCspRFwURoZVt9pF74p1usCYNs9T3LJZr8=;
 b=AVIgFfkXJ2CcYBjh2/MP/4uEgZFImW8Qq1qp7qkFRjHQPo3gWOG0jOKsY5t6/GLVPG
 nRFSIId2sb0KnIblrnm/GcxpY3D013H2twuCpXcpcxM0XqxM0nasvQvwcXgLBWMEC4j6
 KKK/p++p+AvoBWmZieuda/lATJgkVXaggTXAxKJ9Squkf6TrijyGaSuk2D2EkVX5RjF1
 jPEXo+F+XT3H0UpTh9Wlyzc1zinjR4q5VUf1gbt/kE/2be9xBYDbCRgUtX2MI05urCk1
 nwqcc3ETm9xqhr6PMkW1b71wykm0GyGzsHV3NIUHCiuZp5teY5HsBpGmqkeRr4twn054
 bV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522324; x=1699127124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDHPSY2ccwCspRFwURoZVt9pF74p1usCYNs9T3LJZr8=;
 b=Yk4qwH0REvcXIqr2dOvYa+Ky7d6TldE2OuVHXIN5wM5hDFt8230xzpJg/4iec0/dyf
 8zBEmY6XvyUD5QInjsbYW+F/dJ9ENVLPe5ms+4xnQO/hS3a/QtQQNtO5PtuUby8zR07k
 R1UHW7JKCkFJeLnMalr5rwvnhWn10Ru3k79uN1Z1oYW9QzkSMPXst5yDaGqTw9U5eh4G
 V37jyHDFJ3PFW5Nj+SXs2yzetRasufNeO3TlgFYp/U2Ghc1Qo2jmjE8y1+xIdA0ujFqG
 2ooDjFB2rznOlP5ieRiGA4WX3TWvW7Y9QBwDgrS6/OFzv6IXzPctTqrIjdgLuz44DzIF
 xvYA==
X-Gm-Message-State: AOJu0YzDXUd5kNJ8ir2SodWVcK/rBxWFPUQxfl9ICslIns2GaBk4U7L2
 oSb/Psl/OHnoVMEmMVnH8TaMwdhJ6TzFgEWz3Vo=
X-Google-Smtp-Source: AGHT+IEwhccEY18U2zbpaigkMh5pHpmyT5YBKJ8uPvCGX9udF7rJLpt/GvszJxekUTRH6Vdw1K1ckQ==
X-Received: by 2002:a17:903:1211:b0:1bb:994c:bc43 with SMTP id
 l17-20020a170903121100b001bb994cbc43mr5757741plh.18.1698522324172; 
 Sat, 28 Oct 2023 12:45:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 00/35] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:44:47 -0700
Message-Id: <20231028194522.245170-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Expose a pair of comparison operators that map to the "test"
comparison that is available on many architectures.

Changes for v2:
  * Add TCGCond to tcg_target_const_match.
    This fixes a long-standing issue with ppc and s390x backends,
    in that CMPI for signed comparisons has signed immediate and
    CMPLI for unsigned comparisons has unsigned immediate.
    But now allows different immediates for the TST comparisons.
  * tcg/i386: Generate TEST x,x for power-of-two in {7,15,31,63}.
  * tcg/i386: Generate BT n,x for other power-of-two.
  * tcg/ppc: tcg_target_const_match improvements
  * tcg/s390x: tcg_target_const_match improvements
  * target/m68k: Use TST{EQ,NE} for gen_fcc_cond.

I wanted more testing, so I went looking for low-hanging fruit.
I didn't see any within target/arm, probably due to how we represent NZCV,
and I didn't want to overlap anything that Paolo might be doing with
target/i386, so I landed on trget/m68k.  Tested via our float_convd.


r~


Richard Henderson (35):
  tcg: Introduce TCG_COND_TST{EQ,NE}
  tcg/optimize: Split out arg_is_const_val
  tcg/optimize: Split out do_constant_folding_cond1
  tcg/optimize: Do swap_commutative2 in do_constant_folding_cond2
  tcg/optimize: Split out arg_new_constant
  tcg/optimize: Handle TCG_COND_TST{EQ,NE}
  tcg: Add TCGConst argument to tcg_target_const_match
  tcg/aarch64: Support TCG_COND_TST{EQ,NE}
  tcg/aarch64: Generate TBZ, TBNZ
  tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
  tcg/arm: Support TCG_COND_TST{EQ,NE}
  tcg/i386: Pass x86 condition codes to tcg_out_cmov
  tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
  tcg/i386: Support TCG_COND_TST{EQ,NE}
  tcg/i386: Improve TSTNE/TESTEQ vs powers of two
  tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
  tcg/mips: Support TCG_COND_TST{EQ,NE}
  tcg/riscv: Support TCG_COND_TST{EQ,NE}
  tcg/sparc64: Implement tcg_out_extrl_i64_i32
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
  target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
  target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
  target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
  target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond

 docs/devel/tcg-ops.rst           |   2 +
 include/tcg/tcg-cond.h           |  49 +++-
 tcg/aarch64/tcg-target-con-set.h |   5 +-
 tcg/aarch64/tcg-target-con-str.h |   1 +
 tcg/i386/tcg-target-con-set.h    |   6 +-
 tcg/i386/tcg-target-con-str.h    |   1 +
 tcg/ppc/tcg-target-con-set.h     |   5 +-
 tcg/ppc/tcg-target-con-str.h     |   1 +
 tcg/s390x/tcg-target-con-set.h   |   8 +-
 tcg/s390x/tcg-target-con-str.h   |   3 +-
 target/alpha/translate.c         |  94 +++----
 target/m68k/translate.c          |  74 +++--
 tcg/optimize.c                   | 464 +++++++++++++++++++++++--------
 tcg/tcg.c                        |  38 ++-
 tcg/tci.c                        |  14 +
 tcg/aarch64/tcg-target.c.inc     | 165 ++++++++---
 tcg/arm/tcg-target.c.inc         |  62 +++--
 tcg/i386/tcg-target.c.inc        | 178 ++++++++----
 tcg/loongarch64/tcg-target.c.inc |  59 ++--
 tcg/mips/tcg-target.c.inc        |  44 ++-
 tcg/ppc/tcg-target.c.inc         | 277 +++++++++++++-----
 tcg/riscv/tcg-target.c.inc       |  23 +-
 tcg/s390x/tcg-target.c.inc       | 246 ++++++++++------
 tcg/sparc64/tcg-target.c.inc     |  70 +++--
 tcg/tci/tcg-target.c.inc         |   3 +-
 25 files changed, 1342 insertions(+), 550 deletions(-)

-- 
2.34.1


