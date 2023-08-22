Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CB783A66
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLWz-00028M-3w; Tue, 22 Aug 2023 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLWw-000274-Cz
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLWt-0001vB-Gc
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso41085435e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688217; x=1693293017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4zgAXTYE81eKryd8EEg3T25AM2J+pN7VJ77zhTZKjk=;
 b=iOGi83QklKbSWNsyecZUYCiQRPifFyjQLpqpAz75el8112/vj/GbTQgo3vQX4dx3wC
 AYYyLZ0zuQQvgqmG6Ex4ylJ9rshTzD2TWI9BUTqtCxqCc1tkijb+gZY9lM99DEsPL0AY
 DJSnfzihTWT8nhsGY8y1lSOuXfMk/qyyc72vg0JTHpVxUlX/segHsGMXQNyniw3XDlzN
 hSaRoW00Mm04vDwOraXNsij2pNbhIi5sCzHxc7oO+gMLvWLFgidkAjojRImcgIcN16uQ
 tU//nBa1eUiQl2Z+qn7HNByzFlWFx3O0t1VdV9BgUQYuiKqoZEt5uUj9/EKO6Y3pWKmk
 Vexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688217; x=1693293017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4zgAXTYE81eKryd8EEg3T25AM2J+pN7VJ77zhTZKjk=;
 b=l8aYKMEUjbud5E9Nf21jensYizaRsBMM0VTclgQpvWq1iBR/83n5RI0+2TkXLahG3D
 Bl0Crakj1gEQWpEBgaVSiU51n7PT0/+FVZI42PHD2/xcPHJdgsjX4malghobSFe2Uwkb
 oOsC3dQ0DenoJ0Paf09jFBgRIbkA0lO5fRFzjuRgTYwQcAgT6WCMPolHmtiMwt7g+O0t
 fm6HqILLMrgPKCVd3JfxBE7uW0ukhKVmojfmTUXk1DeCZzpb/OXY/vjXGE6U7aBOx1qR
 Lt5mRjWQgjGMXc4IOjfwxTYie/m9to58X5wlRbAXzKqjQcmM+D7rOkxcL2NIklfUNgMY
 AoFA==
X-Gm-Message-State: AOJu0YykEzPP716TFEkLtAwaO7++jqSIP6ZH2OjS7u4X67vGysFQwULZ
 oj32en1ouVBaioPVP9P4b1nVLf20sFt6rLYENg7R8Q==
X-Google-Smtp-Source: AGHT+IEM3korHTN1cK6yTc39JnGqT/IDeJ2AXRyoC3GXlZM+Z8elEaBlVTSoy0bcl2cOIpPlFPHAfA==
X-Received: by 2002:a1c:7918:0:b0:3fe:fac5:ec52 with SMTP id
 l24-20020a1c7918000000b003fefac5ec52mr522787wme.41.1692688216650; 
 Tue, 22 Aug 2023 00:10:16 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d6247000000b003195504c754sm14858141wrv.31.2023.08.22.00.10.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:10:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/19] Based-on:
 https://patchew.org/QEMU/20230821125959.28666-1-philmd@linaro.org/
Date: Tue, 22 Aug 2023 09:09:53 +0200
Message-ID: <20230822071013.34884-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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


