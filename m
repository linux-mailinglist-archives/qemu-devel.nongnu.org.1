Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10A7CEB4A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzO-00082f-E9; Wed, 18 Oct 2023 18:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzL-00080a-EY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzJ-0002Rk-BU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9b70b9656so47865385ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667959; x=1698272759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AdUTYqC6VfPLHXyehHvPJXNvcdf9+sSHqxpbhS8YlG4=;
 b=z0wTgsgR7S6f8cP8c1r9DWrucAy9XH7kxB5BjNzo84fIFqFIcW2ocTpy9M/Qj9Lk9I
 0kkVTsF7h8mFAXqxFhzSSoAWG9XHG2OUtDmAluOuXuToLKdMhncFjZ/Xi2Ar87wdOsbG
 DDr6yjI9iyNN91CouqNCNGEYJAB4RMgEmDrmB2B/TEYg3n1Va4DEYjcxg6VQ0TpRKDM3
 l/1zVeaY++grf/dhFxeIa30VaufBFbCgFUC2PqJUVzMuWC5lMRPnUnFDcb7kpDyZ1Oyz
 SFisBf1ajxkEek4de1DSqzFeWu7LjYDPI7r0RRw//ceOm+4lmMEoetu5//MxYXfeq4SB
 XP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667959; x=1698272759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AdUTYqC6VfPLHXyehHvPJXNvcdf9+sSHqxpbhS8YlG4=;
 b=s0d2QeC3xaZfnMSc4+D0Y/m9UnzHVxDNTcDI/ZQJ31jaKGUSKOfyKTGqn3jtAHLrbT
 id39yDPtHZGlcwYqfn8ovPGgj69yIhyKJkHlJK7cTIQ4nDqM9DIG0HajnH84vWjkd4fk
 U1bMDcEP012m1juSyFv5fQUu4tYoBn9lBUIaBkJQrJmMFCHRNpzYWL8X50v+QR5e89GY
 BZg9NGvZuHE4KKyfF/UTsdP+dyhVAxVYq32eQOGIXD1HkagsUrAfeNY368xCxWgpmXqK
 r9EnsQjzit4H7X//qYFaT6Y1Cemxz1BqfvQgAva0lfYmrV3wjaguR45QV94spmMwtUY2
 Tg+w==
X-Gm-Message-State: AOJu0YxM/76LQB1wyLz4bx7vrX2UqFgF/TmTjaNUtOzlumYffA9kMcVb
 /gUQ2ZtC94rrY4kCOsET/P7ycU23pWeHAvNKm7U=
X-Google-Smtp-Source: AGHT+IGNzturcYTO0brYASWoEpIt/6hQjIB9gX76YVnyYrYmgL2K5NkuMIYyK/iFijNHCeu4bd7MYQ==
X-Received: by 2002:a17:903:8a:b0:1c6:b83:4720 with SMTP id
 o10-20020a170903008a00b001c60b834720mr651555pld.63.1697667959069; 
 Wed, 18 Oct 2023 15:25:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.25.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:25:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] tcg patch queue
Date: Wed, 18 Oct 2023 15:25:28 -0700
Message-Id: <20231018222557.1562065-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231018

for you to fetch changes up to b540757b7f711eaf069f530916005cf8cfe7c00f:

  target/i386: Use i128 for 128 and 256-bit loads and stores (2023-10-18 12:33:08 -0700)

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
 tcg/i386/tcg-target.c.inc        | 184 +++++++------
 tcg/loongarch64/tcg-target.c.inc | 126 +++++----
 tcg/mips/tcg-target.c.inc        | 231 ++++++++--------
 tcg/ppc/tcg-target.c.inc         | 561 ++++++++++++++++++++++++++-------------
 tcg/riscv/tcg-target.c.inc       | 189 ++++++-------
 tcg/s390x/tcg-target.c.inc       | 161 ++++++-----
 16 files changed, 1093 insertions(+), 888 deletions(-)

