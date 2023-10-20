Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 325AE7D1214
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:01:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqzR-0005pj-D3; Fri, 20 Oct 2023 11:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtqz8-0005p7-Ur
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:00:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtqz5-0000E3-Sz
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:00:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so6775545ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814018; x=1698418818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/12Z0Tn9o2AAjwwuNBPjagYOai6yiWS/C68jCFk1gCA=;
 b=sYDl3r0RlWggxlUy3tQ9rtQbaS8FGj0xFdPsHahM/BSRwCR58Dv7s1Ad9pTsS/GBrY
 kA8H1JCPPjEf8xygrq5zJtTBFhddBzv1whTeTFeySGgdCrgf4WPf6qifnUWPaurgsD7P
 xJHc6fLEGWrbGoMJM4SxJ3ZZ1ewPrVEvIWK0GNMWn2A7wO4V8aTvsHKfFiJKL+4UxfsE
 e+kP9cduRtHV79SjZfUR7LUzomyxf3232xW4Hkdj7ppzMF/19b1w7pbOzrlF4PqGGodi
 hQf62JRuJNIRr7FoIKmjDo7ySO2nsrc3jPgIVfjrcCdmO1JSee9ZnQ6NKgDu7wnSNbwu
 r6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814018; x=1698418818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/12Z0Tn9o2AAjwwuNBPjagYOai6yiWS/C68jCFk1gCA=;
 b=TigR9OgHYUzmf1F/2OGCP/K/5S3BQfixQpsU/zTmKzA917rR5ho6o0SUye8fxNWGyS
 gyKfXpisnBwseSwyXprZe2IrE+3YW3zcg1qyUHfJmFBE6Z9+6WEjIfjfnGmH6MoQlEbj
 TsgZQqrZySFhzO/d7xBNKjbMO8MVwUFWMGf674LW0Tp+bXyvzI/JVdDJOsR6QdJzTekf
 Zmmuph7SdULaSQnMnpKvNroGhRuosYPTGi93mVmGN2m7XnGO05bfxFMC5+Zhh5irqKNZ
 nkN9XeoGnbitnloRv09tNQN4COZxLwjXiSr7Pj1zXSRLc/zlLKXxZaY3h97WTffWa1tA
 5RQw==
X-Gm-Message-State: AOJu0YzDABwmOrf3suba2PAH9esfpAMjpyNKX4f+fTQ01+vHy/C2kbvv
 rPLGnOakyGBiIMPgaqv7lPmmx1GLUTR1EdmmrGA=
X-Google-Smtp-Source: AGHT+IEwFfibr/sapjpnSLbVOu9cjisBDA+8Q+CIgEEWHfaYqnmth61/zFzg2aiFMQG1SUHbPs6dkA==
X-Received: by 2002:a17:903:2803:b0:1ca:1a1f:d2cd with SMTP id
 kp3-20020a170903280300b001ca1a1fd2cdmr1818505plb.56.1697814017776; 
 Fri, 20 Oct 2023 08:00:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm1627438plb.46.2023.10.20.08.00.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:00:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/29] tcg patch queue
Date: Fri, 20 Oct 2023 08:00:14 -0700
Message-Id: <20231020150015.23434-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

v2: Fix FreeBSD build error in patch 18.

r~


The following changes since commit 0d239e513e0117e66fa739fb71a43b9383a108ff:

  Merge tag 'pull-lu-20231018' of https://gitlab.com/rth7680/qemu into staging (2023-10-19 10:20:57 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231018-2

for you to fetch changes up to a75f704d972b9408f5e2843784b3add48c724c52:

  target/i386: Use i128 for 128 and 256-bit loads and stores (2023-10-19 21:11:44 -0700)

----------------------------------------------------------------
tcg: Drop unused tcg_temp_free define
tcg: Introduce tcg_use_softmmu
tcg: Optimize past conditional branches
tcg: Use constant zero when expanding with divu2
tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB
tcg/ppc: Use ADDPCIS for power9
tcg/ppc: Use prefixed instructions for power10
tcg/ppc: Disable TCG_REG_TB for Power9/Power10

----------------------------------------------------------------
Jordan Niethe (1):
      tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB

Mike Frysinger (1):
      tcg: drop unused tcg_temp_free define

Richard Henderson (27):
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

 include/tcg/tcg-op-common.h      |   3 +
 include/tcg/tcg-op.h             |   2 -
 include/tcg/tcg.h                |   8 +-
 target/i386/tcg/translate.c      |  63 ++---
 tcg/optimize.c                   |   8 +-
 tcg/tcg-op-ldst.c                |  14 +-
 tcg/tcg-op.c                     |  38 ++-
 tcg/tcg.c                        |  13 +-
 tcg/aarch64/tcg-target.c.inc     | 177 ++++++------
 tcg/arm/tcg-target.c.inc         | 203 +++++++-------
 tcg/i386/tcg-target.c.inc        | 198 +++++++-------
 tcg/loongarch64/tcg-target.c.inc | 126 +++++----
 tcg/mips/tcg-target.c.inc        | 231 ++++++++--------
 tcg/ppc/tcg-target.c.inc         | 561 ++++++++++++++++++++++++++-------------
 tcg/riscv/tcg-target.c.inc       | 189 ++++++-------
 tcg/s390x/tcg-target.c.inc       | 161 ++++++-----
 16 files changed, 1102 insertions(+), 893 deletions(-)

