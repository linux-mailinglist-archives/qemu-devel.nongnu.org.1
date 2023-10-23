Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5304D7D3EF0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzR0-0005XI-B9; Mon, 23 Oct 2023 14:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQq-0005Tn-Io
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:41 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQj-00084o-HY
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:40 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-584042a01eeso2273640eaf.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084811; x=1698689611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WjzvqQCuN3vfcxEAuX13c66rOumAyotiYigjyRFcdp0=;
 b=G/n5F8OpXqSDnVwjG7QQK92q7v73hxxxevZptPftsIek7d3EUO6W0nv1sQxcUBxhL0
 fW5DFRovlNyBBkPMSsR0SAKgz5mI0IeBhSLUzTsjz2HlFizuyuzJTtS5fhR1Kq2D+khQ
 VVdpPMzTG0hirMWHZWOCgrWGZoiEfVup773fvNUF3JXrLDwijUxcbBj6tGanGmstMXHQ
 ThVJJ/agCYUslyNYJNjIvzO/s2wxDNjZQ9pCX3hGzsnMs/wmVn0MLfhFokab9hNMuTyR
 swkSCUv51N/ZWqREk1x1+UiMtkNoCIBa8IUDhe7TlDbBqNBmsUPPQBfSlg9CKHxQ0QHl
 mHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084811; x=1698689611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WjzvqQCuN3vfcxEAuX13c66rOumAyotiYigjyRFcdp0=;
 b=kjpp/vFqwMakY9bwNjMZCBmC9FLaexewYRDsy6Y+Uq5GLW5oGquiVn51Sa5TBkqzMk
 VeRIO2ijKIdztoOnJi+xT08f5ucSOvOv3Aa0kKqRi9cr7l/vl7BG3S0sAgRsAYcXNA52
 JGUtnY+L5+/X4pFRNysQ4JcBMIJm2Vjggl8TH65SfBQNvlOluDxZfCzpxPSG5Frp3qmx
 C00Ehxo38zF0E0GyFhYclGA1f5Nw47wKK8MPie/l74ZTZXgngC9KP18XuLWzO21NIPtU
 NsGO+hiQwRgXgJBDP1x3+Tt8uaFO1hAlRMYWB5/c6UyhPD6cLGV1UPZn4QxD8mtqI9Hf
 RxlQ==
X-Gm-Message-State: AOJu0Yx1n0rV2buHRwFwGtCLrOFoJ+QsG50HZ3ID+XVp8Zpt/1w/ntjQ
 iEHsrtWQpLz4moxkyiPqllQqicdZ1HpKuav9y6s=
X-Google-Smtp-Source: AGHT+IHoLHN0htTfR6vJxzH/KvwfECEs2XmJC1m2j/GR9CBYOzlDUMWd7aVT1hGYCSO5ToOFJruwpQ==
X-Received: by 2002:a05:6359:6d9a:b0:168:e7f4:8fc9 with SMTP id
 tg26-20020a0563596d9a00b00168e7f48fc9mr1711247rwb.24.1698084811401; 
 Mon, 23 Oct 2023 11:13:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/38] tcg patch queue
Date: Mon, 23 Oct 2023 11:12:51 -0700
Message-Id: <20231023181329.171490-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

v3: Rebase and add a few more patches.


r~


The following changes since commit 384dbdda94c0bba55bf186cccd3714bbb9b737e9:

  Merge tag 'migration-20231020-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-20 06:46:53 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231023

for you to fetch changes up to e40df3522b384d3b7dd38187d735bd6228b20e47:

  target/xtensa: Use tcg_gen_sextract_i32 (2023-10-22 16:44:49 -0700)

----------------------------------------------------------------
tcg: Drop unused tcg_temp_free define
tcg: Introduce tcg_use_softmmu
tcg: Optimize past conditional branches
tcg: Use constant zero when expanding with divu2
tcg: Add negsetcondi
tcg: Define MO_TL
tcg: Export tcg_gen_ext_{i32,i64,tl}
target/*: Use tcg_gen_ext_*
tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB
tcg/ppc: Use ADDPCIS for power9
tcg/ppc: Use prefixed instructions for power10
tcg/ppc: Disable TCG_REG_TB for Power9/Power10
tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB
tcg/ppc: Use ADDPCIS for power9
tcg/ppc: Use prefixed instructions for power10
tcg/ppc: Disable TCG_REG_TB for Power9/Power10

----------------------------------------------------------------
Jordan Niethe (1):
      tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB

Mike Frysinger (1):
      tcg: drop unused tcg_temp_free define

Paolo Bonzini (2):
      tcg: add negsetcondi
      tcg: Define MO_TL

Richard Henderson (34):
      tcg/ppc: Untabify tcg-target.c.inc
      tcg/ppc: Reinterpret tb-relative to TB+4
      tcg/ppc: Use ADDPCIS in tcg_out_tb_start
      tcg/ppc: Use ADDPCIS in tcg_out_movi_int
      tcg/ppc: Use ADDPCIS for the constant pool
      tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
      tcg/ppc: Use PADDI in tcg_out_movi
      tcg/ppc: Use prefixed instructions in tcg_out_mem_long
      tcg/ppc: Use PLD in tcg_out_movi for constant pool
      tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
      tcg/ppc: Use PLD in tcg_out_goto_tb
      tcg/ppc: Disable TCG_REG_TB for Power9/Power10
      tcg: Introduce tcg_use_softmmu
      tcg: Provide guest_base fallback for system mode
      tcg/arm: Use tcg_use_softmmu
      tcg/aarch64: Use tcg_use_softmmu
      tcg/i386: Use tcg_use_softmmu
      tcg/loongarch64: Use tcg_use_softmmu
      tcg/mips: Use tcg_use_softmmu
      tcg/ppc: Use tcg_use_softmmu
      tcg/riscv: Do not reserve TCG_GUEST_BASE_REG for guest_base zero
      tcg/riscv: Use tcg_use_softmmu
      tcg/s390x: Use tcg_use_softmmu
      tcg: Use constant zero when expanding with divu2
      tcg: Optimize past conditional branches
      tcg: Add tcg_gen_{ld,st}_i128
      target/i386: Use i128 for 128 and 256-bit loads and stores
      tcg: Export tcg_gen_ext_{i32,i64,tl}
      target/arm: Use tcg_gen_ext_i64
      target/i386: Use tcg_gen_ext_tl
      target/m68k: Use tcg_gen_ext_i32
      target/rx: Use tcg_gen_ext_i32
      target/tricore: Use tcg_gen_*extract_tl
      target/xtensa: Use tcg_gen_sextract_i32

 include/exec/target_long.h       |   2 +
 include/tcg/tcg-op-common.h      |   9 +
 include/tcg/tcg-op.h             |   6 +-
 include/tcg/tcg.h                |   8 +-
 target/arm/tcg/translate-a64.c   |  37 +--
 target/i386/tcg/translate.c      |  91 +++----
 target/m68k/translate.c          |  23 +-
 target/rx/translate.c            |  11 +-
 target/tricore/translate.c       |  20 +-
 target/xtensa/translate.c        |  12 +-
 tcg/optimize.c                   |   8 +-
 tcg/tcg-op-ldst.c                |  28 +-
 tcg/tcg-op.c                     |  50 +++-
 tcg/tcg.c                        |  13 +-
 tcg/aarch64/tcg-target.c.inc     | 177 ++++++------
 tcg/arm/tcg-target.c.inc         | 203 +++++++-------
 tcg/i386/tcg-target.c.inc        | 198 +++++++-------
 tcg/loongarch64/tcg-target.c.inc | 126 +++++----
 tcg/mips/tcg-target.c.inc        | 231 ++++++++--------
 tcg/ppc/tcg-target.c.inc         | 561 ++++++++++++++++++++++++++-------------
 tcg/riscv/tcg-target.c.inc       | 189 ++++++-------
 tcg/s390x/tcg-target.c.inc       | 161 ++++++-----
 22 files changed, 1152 insertions(+), 1012 deletions(-)

