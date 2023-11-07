Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DF7E3334
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C93-00089U-BG; Mon, 06 Nov 2023 21:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C91-00088V-Fh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:47 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C8z-0005pK-GE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:47 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9cbba16084so5068460276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325324; x=1699930124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9NorHXL3DETJ28IyLHCtx5YzL4B4sW0lH9bemPuBFCE=;
 b=txhmWCQZo0ogrSosIPnGh2PORjVd5TRgkio4+uTxDvwr1UgxWYdnuo3kmZGSd1yj3M
 dGtrNjlYLys9pdoko7gbheontCf9EzkSdDiL3vQmHsgOHV0uc+36jityCQQ45XZzgq7E
 IQ1yz1aD1P1IGuLWP64wVZXGYvL6dGyDim3VM22WuE9lKg5iSKmpaC5H6eYNu77hv55i
 PsLD7cR/pYrsMuA/qSVWxd0K9ITXwHcez5ZdvSx8H9/xbFksSDccskNal5jboX0k4etZ
 FNG6EiQ4Oywwt1vRLBG7WT11PAf5KXLZt3nXBfsRyVGL6hMLe4Y0Ak2fImmwwVNazOZ+
 NzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325324; x=1699930124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9NorHXL3DETJ28IyLHCtx5YzL4B4sW0lH9bemPuBFCE=;
 b=MnCByaGJfj5KsyxI61neL1kgr276kpyHwyitjwTKQ+4YyPP4ZH8qaYlK5Br7l/0nXx
 Ena/U2W/qjaUJP0OZ/MaF7/TbzgCaOjfil5qwxtuO7vwxuLB2cnmY05T23S1tWXVjbrZ
 IX3prUZfaoE1IznK3RG/TL2HA5IEYLcY1pZrKUEtIYeDDjhqFI2ayYHa9gz971IJzZJY
 V9//SitcRNvHoo7YYuRaFTKCarCcnO+mQBks309wudIl2jIYkhWOCp+vYpxXNz/XPIey
 GUDUdR0zdcxRWH9pv7qbWSdQZ4rdLzqG1kt38+RJVjP/lyj+VK2uxQI0KvbLOgbS68/O
 aARA==
X-Gm-Message-State: AOJu0YxuAcCJU94V+CZQOb2q/og2eBiAEXC0CnMUk2KLdSJa+TQphurW
 LASqKo3NRtzxHfCR2CXCrZ7ie781Gv//tGwjWEY=
X-Google-Smtp-Source: AGHT+IHtp+Oq+XlD+b0lC/NJuYiHR1jB+EkSZPuTYMGrRorY9GQfPBWKzQrUrtT4MbhRl1L+0jYSTQ==
X-Received: by 2002:a25:6910:0:b0:da0:4afd:61f9 with SMTP id
 e16-20020a256910000000b00da04afd61f9mr28794166ybc.54.1699325323819; 
 Mon, 06 Nov 2023 18:48:43 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/35] tcg patch queue
Date: Mon,  6 Nov 2023 18:48:07 -0800
Message-Id: <20231107024842.7650-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb29.google.com
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

The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:

  Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231106

for you to fetch changes up to d36ce28be424385fc9f7273bf5c15ce815b5cf4e:

  tcg/sparc64: Implement tcg_out_extrl_i64_i32 (2023-11-06 10:48:46 -0800)

----------------------------------------------------------------
util: Add cpuinfo for loongarch64
tcg/loongarch64: Use cpuinfo.h
tcg/loongarch64: Improve register allocation for INDEX_op_qemu_ld_a*_i128
host/include/loongarch64: Add atomic16 load and store
tcg: Move expanders out of line
tcg/mips: Always implement movcond
tcg/mips: Implement neg opcodes
tcg/loongarch64: Implement neg opcodes
tcg: Make movcond and neg required opcodes
tcg: Optimize env memory operations
tcg: Canonicalize sub of immediate to add
tcg/sparc64: Implement tcg_out_extrl_i64_i32

----------------------------------------------------------------
Richard Henderson (35):
      accel/tcg: Move HMP info jit and info opcount code
      tcg: Add C_N2_I1
      tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
      util: Add cpuinfo for loongarch64
      tcg/loongarch64: Use cpuinfo.h
      host/include/loongarch64: Add atomic16 load and store
      accel/tcg: Remove redundant case in store_atom_16
      accel/tcg: Fix condition for store_atom_insert_al16
      tcg: Mark tcg_gen_op* as noinline
      tcg: Move tcg_gen_op* out of line
      tcg: Move generic expanders out of line
      tcg: Move 32-bit expanders out of line
      tcg: Move 64-bit expanders out of line
      tcg: Move vec_gen_* declarations to tcg-internal.h
      tcg: Move tcg_gen_opN declarations to tcg-internal.h
      tcg: Unexport tcg_gen_op*_{i32,i64}
      tcg: Move tcg_constant_* out of line
      tcg: Move tcg_temp_new_*, tcg_global_mem_new_* out of line
      tcg: Move tcg_temp_free_* out of line
      tcg/mips: Split out tcg_out_setcond_int
      tcg/mips: Always implement movcond
      tcg: Remove TCG_TARGET_HAS_movcond_{i32,i64}
      tcg/mips: Implement neg opcodes
      tcg/loongarch64: Implement neg opcodes
      tcg: Remove TCG_TARGET_HAS_neg_{i32,i64}
      tcg: Don't free vector results
      tcg/optimize: Pipe OptContext into reset_ts
      tcg/optimize: Split out cmp_better_copy
      tcg/optimize: Optimize env memory operations
      tcg: Eliminate duplicate env store operations
      tcg/optimize: Split out arg_new_constant
      tcg: Canonicalize subi to addi during opcode generation
      tcg/optimize: Canonicalize subi to addi during optimization
      tcg/optimize: Canonicalize sub2 with constants to add2
      tcg/sparc64: Implement tcg_out_extrl_i64_i32

 accel/tcg/internal-common.h                        |   2 -
 host/include/loongarch64/host/atomic128-ldst.h     |  52 ++
 host/include/loongarch64/host/cpuinfo.h            |  21 +
 .../loongarch64/host/load-extract-al16-al8.h       |  39 ++
 host/include/loongarch64/host/store-insert-al16.h  |  12 +
 include/exec/cputlb.h                              |   1 -
 include/tcg/tcg-op-common.h                        | 538 ++---------------
 include/tcg/tcg-opc.h                              |   8 +-
 include/tcg/tcg-temp-internal.h                    |  56 +-
 include/tcg/tcg.h                                  |  82 ---
 tcg/aarch64/tcg-target.h                           |   4 -
 tcg/arm/tcg-target.h                               |   2 -
 tcg/i386/tcg-target.h                              |   4 -
 tcg/loongarch64/tcg-target-con-set.h               |   2 +-
 tcg/loongarch64/tcg-target.h                       |  12 +-
 tcg/mips/tcg-target.h                              |   4 -
 tcg/ppc/tcg-target.h                               |   4 -
 tcg/riscv/tcg-target.h                             |   4 -
 tcg/s390x/tcg-target.h                             |   4 -
 tcg/sparc64/tcg-target.h                           |   4 -
 tcg/tcg-internal.h                                 |  18 +
 tcg/tci/tcg-target.h                               |   4 -
 accel/tcg/cputlb.c                                 |  17 +-
 accel/tcg/monitor.c                                | 154 +++++
 accel/tcg/translate-all.c                          | 127 ----
 tcg/optimize.c                                     | 370 ++++++++++--
 tcg/tcg-op-gvec.c                                  | 112 ++--
 tcg/tcg-op.c                                       | 636 ++++++++++++++++-----
 tcg/tcg.c                                          | 131 ++++-
 tcg/tci.c                                          |   2 -
 util/cpuinfo-loongarch.c                           |  35 ++
 accel/tcg/ldst_atomicity.c.inc                     |  14 +-
 tcg/loongarch64/tcg-target.c.inc                   |  34 +-
 tcg/mips/tcg-target.c.inc                          | 329 +++++------
 tcg/sparc64/tcg-target.c.inc                       |   5 +
 util/meson.build                                   |   2 +
 36 files changed, 1535 insertions(+), 1310 deletions(-)
 create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
 create mode 100644 host/include/loongarch64/host/cpuinfo.h
 create mode 100644 host/include/loongarch64/host/load-extract-al16-al8.h
 create mode 100644 host/include/loongarch64/host/store-insert-al16.h
 create mode 100644 util/cpuinfo-loongarch.c

