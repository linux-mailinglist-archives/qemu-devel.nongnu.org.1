Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929747D62A2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIR-00009U-Do; Wed, 25 Oct 2023 03:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIM-00008H-NI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIK-0004dQ-2o
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so35992035ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218829; x=1698823629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pDzjcVIxfIMvzQDzwDDOFsz7nrty94QwQm/vY13CkFo=;
 b=wdV7ZZkCm/83pUpbmfH2ylIMGuZ2LAl8BE3eiYAdSCocF6OhuPNIkbZGn9s9Ekhd2m
 MvwSEjLyBAeCj5G6urkiL1LluVVtAS/8zoTEDMFdGWflvhF5k+65OeRq3HDhBjqja964
 4S25pUvMA5GLprEukP8VSHq6CAtH8+pwzzxhhqvxMXwi1aA6dVyxuc9UGPq9kn3pgThE
 yLXjKMwSKtlHPpL8yE1kxIfFg+7NK4hsqLHI4y4NZ0cfJVNy/faNV1svsDbqM+kAUJYe
 P73IjUBGKnKB07Gc0h8tBguUcJd21bIdbQqeQHY1UDOLVAbm0LNhZObqb5hOEIlv386x
 jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218829; x=1698823629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDzjcVIxfIMvzQDzwDDOFsz7nrty94QwQm/vY13CkFo=;
 b=tzod/Eq84YVTDugdRDxkLSxrqjv2UIpPI6Pj0s4QTf4ZgDuqRJvY6q1uke6hWdwhav
 UPMZ46so6IyMRJRBsD4qL2vVL6kWULui58X2b/+0iaDsB5P+B8m6T/PKTszvlcMarv5h
 Ddx6mbK4WGhpX1Dp3lVpBg+tQ1X99XYhBHmqtRQWdosB0Y81u+moKXwp98QZRDIAGjBd
 mj1ejSo78hTEG3HSDmZRSd8+Q565H3v3Ol2Knd6ZYLLMn91aIcsg6N4Uo2vSGhr1A+us
 80ZTJpKNNsI7m81ukl0K/Jjl9DRUXe11TXJYKtnjwfmue4Gg+J6exlb/RAvYn+W9IqJe
 qNLQ==
X-Gm-Message-State: AOJu0YwWpAZfR4D8QDZwqKbpjpKFDi8/x1Z86fkMNQ6iTdlxDMkzigZe
 ZFpWwddlbV8A0nHRdF+9Y+/WymXCfMBYVXHVmMM=
X-Google-Smtp-Source: AGHT+IEV9uwYJAi0e1gMX7Uxdd8kfF+Cr5/IqL8VgotQiN1UWEVfyRjk6FSUuEB0WpvOoQPcMwiudg==
X-Received: by 2002:a17:902:c94d:b0:1c4:fae:bf28 with SMTP id
 i13-20020a170902c94d00b001c40faebf28mr12027624pla.32.1698218828738; 
 Wed, 25 Oct 2023 00:27:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 00/29] tcg: Introduce TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:38 -0700
Message-Id: <20231025072707.833943-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Inspired by some other patch review this week, expose a pair
of comparison operators that map to the "test" comparison
that is available on many architectures.

Convert target/alpha to use this as an exemplar.


r~


Richard Henderson (29):
  tcg: Introduce TCG_COND_TST{EQ,NE}
  tcg/optimize: Split out arg_is_const_val
  tcg/optimize: Split out do_constant_folding_cond1
  tcg/optimize: Do swap_commutative2 in do_constant_folding_cond2
  tcg/optimize: Split out arg_new_constant
  tcg/optimize: Handle TCG_COND_TST{EQ,NE}
  tcg/aarch64: Support TCG_COND_TST{EQ,NE}
  tcg/aarch64: Generate TBZ, TBNZ
  tcg/arm: Support TCG_COND_TST{EQ,NE}
  tcg/i386: Pass x86 condition codes to tcg_out_cmov
  tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
  tcg/i386: Add rexw argument to tcg_out_testi
  tcg/i386: Support TCG_COND_TST{EQ,NE}
  tcg/loongarch64: Support TCG_COND_TST{EQ,NE}
  tcg/mips: Support TCG_COND_TST{EQ,NE}
  tcg/riscv: Support TCG_COND_TST{EQ,NE}
  tcg/sparc64: Implement tcg_out_extrl_i64_i32
  tcg/sparc64: Hoist read of tcg_cond_to_rcond
  tcg/sparc64: Pass TCGCond to tcg_out_cmp
  tcg/sparc64: Support TCG_COND_TST{EQ,NE}
  tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
  tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
  tcg/ppc: Create tcg_out_and_rc
  tcg/ppc: Support TCG_COND_TST{EQ,NE}
  tcg/s390x: Support TCG_COND_TST{EQ,NE}
  tcg/tci: Support TCG_COND_TST{EQ,NE}
  target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
  target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
  target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero

 include/tcg/tcg-cond.h           |  49 +++-
 tcg/aarch64/tcg-target-con-set.h |   4 +-
 target/alpha/translate.c         |  94 +++----
 tcg/optimize.c                   | 444 ++++++++++++++++++++++---------
 tcg/tcg.c                        |   4 +-
 tcg/tci.c                        |  14 +
 docs/devel/tcg-ops.rst           |   2 +
 tcg/aarch64/tcg-target.c.inc     | 156 ++++++++---
 tcg/arm/tcg-target.c.inc         |  59 ++--
 tcg/i386/tcg-target.c.inc        | 111 ++++----
 tcg/loongarch64/tcg-target.c.inc |  56 ++--
 tcg/mips/tcg-target.c.inc        |  41 +++
 tcg/ppc/tcg-target.c.inc         | 213 ++++++++-------
 tcg/riscv/tcg-target.c.inc       |  20 +-
 tcg/s390x/tcg-target.c.inc       | 127 ++++++---
 tcg/sparc64/tcg-target.c.inc     |  67 +++--
 16 files changed, 998 insertions(+), 463 deletions(-)

-- 
2.34.1


