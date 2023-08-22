Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A552783AA3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:14:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLah-0008MN-17; Tue, 22 Aug 2023 03:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLaf-0008Lt-Gj
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLac-0002ou-LM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3198d2745feso3708034f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688449; x=1693293249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=myxeYLIL/URYI+sfliHeNkqxZxppH1f+abhEXYHEC9Y=;
 b=Mju+wxKNT4XI0KlZgHuEimPtBOCIBu7FDdPeErV5TAFyniG0GwRSAT0wHyTOKyIuCL
 4KUw90y/KHdl/e9qz0k3IbYAKJSsIKK7KQXihhGlIo2YwQyYYBZxiTtm1XJLqLam5dog
 18ppOTwuiRvp2THJori/Qqipd31AWN/gEiEvkBH7s5HyxmFutW36gDfYN7D85601bHEm
 lHGSUmL1ZANlP9/K76sB+1v+ddNRh+SrxZ0qBr+RSI0IMJAZ2c/EquiHDKRwqbjl7MDp
 ZtiKnhbQFm3uhyJF5zM0A2ystim/1LRlBvFXSnpBsAQTxhVs3YZqQ/3lU4WhnLR4AS4l
 OHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688449; x=1693293249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=myxeYLIL/URYI+sfliHeNkqxZxppH1f+abhEXYHEC9Y=;
 b=g5JQ3LfFIzLJ5Fyy0n3LEcRqo7dgyKP3OfN0pzjvDOSCbHCQuTtNVFZDX05VbDSmal
 Z9RvmwZw4u+D02c0emN78WpiEh5/Pdhz6IQ1iGL7G7ZRlCg5nHy1eCSi2G1anxRMmJdT
 isTap72lzchpaBBHu7zZSqBzWrd6S6JOSJoFLSfM1BarDCIqG8uBZ2Oo6v5xk6zAXgKF
 oPkWW5sKs7alWCoB/lonn0d7RQs1d0jCM5mLlU75JauxG3UAOnkneyZ5SmaHS0MPJjTT
 VWVHccuUONLsQQa59yMkusJ45XqryE/0PJ3AIYNyYjeCpl8UtrvWFz+T3Fe3bvLp/51D
 wonw==
X-Gm-Message-State: AOJu0YzSGZL3C5fpEdJmMcpWALQ8qpyQg6nICd97IFIdYa1a0gW9ZUXL
 QJexxPgqwMiK3/6+CdyrjVWVnclwqqFZiRH2KiKKUw==
X-Google-Smtp-Source: AGHT+IHU8+MmOZPYn5JlUr2E2cAMfjpyillzj5F8+FGIQ72/MhVjqhtNo6YHxEMLH/bKLCOMc4Wscg==
X-Received: by 2002:adf:e711:0:b0:318:70:a4ac with SMTP id
 c17-20020adfe711000000b003180070a4acmr6624411wrm.17.1692688448788; 
 Tue, 22 Aug 2023 00:14:08 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a5d4211000000b0030ae499da59sm14727590wrq.111.2023.08.22.00.14.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:14:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 00/19] Add some checks before translating
 instructions
Date: Tue, 22 Aug 2023 09:13:46 +0200
Message-ID: <20230822071405.35386-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Based-on: https://patchew.org/QEMU/20230821125959.28666-1-philmd@linaro.org/

(all series reviewed, for Song Gao to pick whichever v4/v5 is preferred)

Hi,

This series adds some checks before translating instructions

This includes:

CPUCFG[1].IOCSR

CPUCFG[2].FP
CPUCFG[2].FP_SP
CPUCFG[2].FP_DP
CPUCFG[2].LSPW
CPUCFG[2].LAM
CPUCFG[2].LSX

V5:
- Split 2 patches, extracting helpers
- R-b

V4:
- Rebase;
- Split patch 'Add LoongArch32 cpu la132' in two patch; (PMD)
- Remove unrelated cpucfgX;(PMD)
- R-b.

V3:
- Rebase;
- The la32 instructions following Table 2 at [2].

V2:
- Add a check parameter to the TRANS macro.
- remove TRANS_64.
- Add avail_ALL/64/FP/FP_SP/FP_DP/LSPW/LAM/LSX/IOCSR
  to check instructions.

[1]: https://patchew.org/QEMU/20230809083258.1787464-1-c@jia.je/
[2]: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions

Jiajie Chen (11):
  target/loongarch: Support LoongArch32 TLB entry
  target/loongarch: Support LoongArch32 DMW
  target/loongarch: Support LoongArch32 VPPN
  target/loongarch: Add LA64 & VA32 to DisasContext
  target/loongarch: Extract make_address_x() helper
  target/loongarch: Extract make_address_i() helper
  target/loongarch: Extract make_address_pc() helper
  target/loongarch: Extract set_pc() helper
  target/loongarch: Truncate high 32 bits of address in VA32 mode
  target/loongarch: Sign extend results in VA32 mode
  target/loongarch: Add LoongArch32 cpu la132

Song Gao (8):
  target/loongarch: Add a check parameter to the TRANS macro
  target/loongarch: Add avail_64 to check la64-only instructions
  hw/loongarch: Remove restriction of la464 cores in the virt machine
  target/loongarch: Add avail_FP/FP_SP/FP_DP to check fpu instructions
  target/loongarch: Add avail_LSPW to check LSPW instructions
  target/loongarch: Add avail_LAM to check atomic instructions
  target/loongarch: Add avail_LSX to check LSX instructions
  target/loongarch: Add avail_IOCSR to check iocsr instructions

 target/loongarch/cpu-csr.h                    |   22 +-
 target/loongarch/cpu.h                        |   22 +
 target/loongarch/translate.h                  |   19 +-
 hw/loongarch/virt.c                           |    5 -
 target/loongarch/cpu.c                        |   46 +-
 target/loongarch/gdbstub.c                    |    2 +-
 target/loongarch/op_helper.c                  |    4 +-
 target/loongarch/tlb_helper.c                 |   66 +-
 target/loongarch/translate.c                  |   46 +
 target/loongarch/insn_trans/trans_arith.c.inc |   98 +-
 .../loongarch/insn_trans/trans_atomic.c.inc   |   85 +-
 target/loongarch/insn_trans/trans_bit.c.inc   |   56 +-
 .../loongarch/insn_trans/trans_branch.c.inc   |   27 +-
 target/loongarch/insn_trans/trans_extra.c.inc |   24 +-
 .../loongarch/insn_trans/trans_farith.c.inc   |   96 +-
 target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +
 target/loongarch/insn_trans/trans_fcnv.c.inc  |   56 +-
 .../loongarch/insn_trans/trans_fmemory.c.inc  |   62 +-
 target/loongarch/insn_trans/trans_fmov.c.inc  |   52 +-
 target/loongarch/insn_trans/trans_lsx.c.inc   | 1434 +++++++++--------
 .../loongarch/insn_trans/trans_memory.c.inc   |  118 +-
 .../insn_trans/trans_privileged.c.inc         |   24 +-
 target/loongarch/insn_trans/trans_shift.c.inc |   34 +-
 23 files changed, 1386 insertions(+), 1020 deletions(-)

-- 
2.41.0


