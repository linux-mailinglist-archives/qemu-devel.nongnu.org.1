Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7237D7E3392
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:07:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COM-0006bC-5J; Mon, 06 Nov 2023 22:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO1-0006KY-1T
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:17 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CNu-0000d0-D8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:15 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so42165515ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326248; x=1699931048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yciDkWXrWDW6+nNHWFrnl/F39Ak3anEXEFFrRQOPZt8=;
 b=mZC70pRsyEXmlUIVEeYqedu95809KRggW31mweD1cMLtoEN/FnAx5ZgTPlrySU4dQC
 lYqsRu9b19VtkhMZLzXSCrTAR1lRqEtjxKcVF4ZfsYydYetxP7a3DOPeroU2NXXF5rtP
 wpYXEH85WoxZGGxgqaouLYi26PsxXHTSkVFFAyxf8xHSXWBfCLJl3s0CbZ9kiMPZwNWN
 ucvQg6bgEfrs0qMGqhDMfJYUDOD9/tDSwxd9NRamLCR24ZioWMvOfxre0sGJzVBQsLlq
 WYquYOtWlV/hePbkAj4/tY5VNxsIBjLx+zQEdo0mfyfYbREMUV+HKTiCWzW3rfLolgsl
 0e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326248; x=1699931048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yciDkWXrWDW6+nNHWFrnl/F39Ak3anEXEFFrRQOPZt8=;
 b=fq2RG6ijQ4R8fqdeHEGUf7PB/0LXPkasx0oNX9lTHa5nhQZEeKlrgeQ23fGQRU2f9J
 wjqlACllltho+9tHVONTrZiPASbLKpVBuHpjZVhuo4j96iHPoGdCBoViLOscv2+OK7Xa
 tKCzYoT0iUzhWZktyO+3PT+scDe3xCVCFP7id5brZeAZA+eY8RyhsoPpzIGpeGAvHH0d
 CW2AjHaSRMs05scV5pcwLmkfjrrxfPuFJmkBD5eT2GL6ePyUFgi8hwm/FViKW/0oq4Wd
 0HvLgM4I3YNTBnXW0aCDNneiy4KYoqorSSz6q0/vVYjrIFJa+WmzLn7DYeBxY6skQhaS
 XmaA==
X-Gm-Message-State: AOJu0YwH5qU02t9zYVbxDOIiZl0/7VeFgcb3AOn7wCp53lBHE4M5N5I2
 g37fFHcdPMVZXT/FtshLn5upAW9DpHerMJytveA=
X-Google-Smtp-Source: AGHT+IGZFNHeTqTtWPy1iIP1pkTMSIRl0/48MT9ZJp2P1VyDmQD1XxwOg1Ltv9flmlXXtinZnddZXw==
X-Received: by 2002:a17:903:434d:b0:1cc:3f6b:a4b6 with SMTP id
 lo13-20020a170903434d00b001cc3f6ba4b6mr22179538plb.56.1699326248575; 
 Mon, 06 Nov 2023 19:04:08 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/85] target/hppa patch queue
Date: Mon,  6 Nov 2023 19:02:42 -0800
Message-Id: <20231107030407.8979-1-richard.henderson@linaro.org>
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

  https://gitlab.com/rth7680/qemu.git tags/pull-pa-20231106

for you to fetch changes up to 3d1611bfa129182d2e867e8a9da7d2fc6efefce5:

  hw/hppa: Allow C3700 with 64-bit and B160L with 32-bit CPU only (2023-11-06 18:49:34 -0800)

----------------------------------------------------------------
target/hppa: Implement PA2.0 instructions
hw/hppa: Map astro chip 64-bit I/O mem
hw/hppa: Turn on 64-bit cpu for C3700

----------------------------------------------------------------
Helge Deller (8):
      target/hppa: sar register allows only 5 bits on 32-bit CPU
      target/hppa: Fix interruption based on default PSW
      target/hppa: Add pa2.0 cpu local tlb flushes
      target/hppa: Clear upper bits in mtctl for pa1.x
      hw/pci-host/astro: Map Astro chip into 64-bit I/O memory region
      hw/pci-host/astro: Trigger CPU irq on CPU HPA in high memory
      hw/hppa: Turn on 64-bit CPU for C3700 machine
      hw/hppa: Allow C3700 with 64-bit and B160L with 32-bit CPU only

Richard Henderson (77):
      target/hppa: Include PSW_P in tb flags and mmu index
      target/hppa: Rename hppa_tlb_entry to HPPATLBEntry
      target/hppa: Use IntervalTreeNode in HPPATLBEntry
      target/hppa: Always report one page to tlb_set_page
      target/hppa: Split out hppa_flush_tlb_range
      target/hppa: Populate an interval tree with valid tlb entries
      target/hppa: Remove get_temp
      target/hppa: Remove get_temp_tl
      target/hppa: Remove load_const
      target/hppa: Fix hppa64 case in machine.c
      target/hppa: Fix load in do_load_32
      target/hppa: Truncate rotate count in trans_shrpw_sar
      target/hppa: Fix trans_ds for hppa64
      target/hppa: Fix do_add, do_sub for hppa64
      target/hppa: Fix bb_sar for hppa64
      target/hppa: Fix extrw and depw with sar for hppa64
      target/hppa: Introduce TYPE_HPPA64_CPU
      target/hppa: Make HPPA_BTLB_ENTRIES variable
      target/hppa: Implement cpu_list
      target/hppa: Implement hppa_cpu_class_by_name
      target/hppa: Update cpu_hppa_get/put_psw for hppa64
      target/hppa: Handle absolute addresses for pa2.0
      target/hppa: Adjust hppa_cpu_dump_state for hppa64
      target/hppa: Fix hppa64 addressing
      target/hppa: Pass DisasContext to copy_iaoq_entry
      target/hppa: Always use copy_iaoq_entry to set cpu_iaoq_[fb]
      target/hppa: Use copy_iaoq_entry for link in do_ibranch
      target/hppa: Mask inputs in copy_iaoq_entry
      target/hppa: Pass d to do_cond
      target/hppa: Pass d to do_sub_cond
      target/hppa: Pass d to do_log_cond
      target/hppa: Pass d to do_sed_cond
      target/hppa: Pass d to do_unit_cond
      linux-user/hppa: Fixes for TARGET_ABI32
      target/hppa: Drop attempted gdbstub support for hppa64
      target/hppa: Remove TARGET_HPPA64
      target/hppa: Decode d for logical instructions
      target/hppa: Decode d for unit instructions
      target/hppa: Decode d for cmpclr instructions
      target/hppa: Decode d for add instructions
      target/hppa: Decode d for sub instructions
      target/hppa: Decode d for bb instructions
      target/hppa: Decode d for cmpb instructions
      target/hppa: Decode CMPIB double-word
      target/hppa: Decode ADDB double-word
      target/hppa: Implement LDD, LDCD, LDDA, STD, STDA
      target/hppa: Implement DEPD, DEPDI
      target/hppa: Implement EXTRD
      target/hppa: Implement SHRPD
      target/hppa: Implement CLRBTS, POPBTS, PUSHBTS, PUSHNOM
      target/hppa: Implement STDBY
      target/hppa: Implement IDTLBT, IITLBT
      hw/hppa: Use uint32_t instead of target_ureg
      target/hppa: Remove TARGET_REGISTER_BITS
      target/hppa: Remove most of the TARGET_REGISTER_BITS redirections
      target/hppa: Remove remaining TARGET_REGISTER_BITS redirections
      target/hppa: Adjust vmstate_env for pa2.0 tlb
      target/hppa: Use tcg_temp_new_i64 not tcg_temp_new
      target/hppa: Replace tcg_gen_*_tl with tcg_gen_*_i64
      target/hppa: Implement HADD
      target/hppa: Implement HSUB
      target/hppa: Implement HAVG
      target/hppa: Implement HSHL, HSHR
      target/hppa: Implement HSHLADD, HSHRADD
      target/hppa: Implement MIXH, MIXW
      target/hppa: Implement PERMH
      target/hppa: Precompute zero into DisasContext
      target/hppa: Return zero for r0 from load_gpr
      include/hw/elf: Remove truncating signed casts
      hw/hppa: Translate phys addresses for the cpu
      linux-user/hppa: Drop EXCP_DUMP from handled exceptions
      target/hppa: Implement pa2.0 data prefetch instructions
      target/hppa: Avoid async_safe_run_on_cpu on uniprocessor system
      target/hppa: Add unwind_breg to CPUHPPAState
      target/hppa: Create raise_exception_with_ior
      target/hppa: Update IIAOQ, IIASQ for pa2.0
      target/hppa: Improve interrupt logging

 configs/targets/hppa-linux-user.mak |    1 +
 include/hw/elf_ops.h                |   17 +-
 linux-user/hppa/target_elf.h        |    2 +-
 target/hppa/cpu-param.h             |   22 +-
 target/hppa/cpu-qom.h               |    1 +
 target/hppa/cpu.h                   |  180 +--
 target/hppa/helper.h                |   55 +-
 target/hppa/insns.decode            |  189 ++-
 hw/hppa/machine.c                   |  152 ++-
 hw/pci-host/astro.c                 |   11 +-
 linux-user/hppa/cpu_loop.c          |    4 -
 linux-user/hppa/signal.c            |    6 +-
 target/hppa/cpu.c                   |   70 +-
 target/hppa/gdbstub.c               |   32 +-
 target/hppa/helper.c                |  101 +-
 target/hppa/int_helper.c            |   77 +-
 target/hppa/machine.c               |  190 ++--
 target/hppa/mem_helper.c            |  436 +++++--
 target/hppa/op_helper.c             |  310 ++++-
 target/hppa/sys_helper.c            |   14 +-
 target/hppa/translate.c             | 2147 ++++++++++++++++++++---------------
 target/hppa/trace-events            |    1 +
 22 files changed, 2576 insertions(+), 1442 deletions(-)

