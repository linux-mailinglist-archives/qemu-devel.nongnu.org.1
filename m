Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1757DEA25
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:36:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXh-0005hX-Op; Wed, 01 Nov 2023 21:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXY-0005Up-DE
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXU-0001T6-8q
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6c32a20d5dbso152057b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888622; x=1699493422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8KMijT5BRG/XgxSXOrKXNRoT7wL1vkrpStXGeBhOig=;
 b=og3iY1W8LiEGlQblUPQir9ffAZrFVMESvxVkTllmnK+gwCtjYQeXGbpHpsOBrDfFYp
 D6bXXakVSeIVcwxVfh+eDPaGJv6g0S48oM8hUQ1OZDJua96Dsxy5UyKSdf8GSP+ts6bu
 I5DsvdF88JuiX4I5Tidym8dotbXmRwKeSS+dLMykJv2mncmsc0foVe/RPlIKc0Qf723/
 xHJFzRXxOhbmzxk/suaAgkTx0v/gVTQrxrvl5JOFgle2xaEHfR2JhUm9Njvdwq/XKLnq
 gJxkrmi2O+Gz3sKmeXuAXBR5I/hbYgjPUAlomd+4nojhVPh1b6cG+ION6/0kvTbf90S3
 u2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888622; x=1699493422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8KMijT5BRG/XgxSXOrKXNRoT7wL1vkrpStXGeBhOig=;
 b=WvrBPYU/glCbfsxz4JswHHAjXCL3uNa/Cfga3EeDHpOFS/UiuxT+4eDVhJcXlDjlkh
 HBMTUtUOK4z8MF0kCu2g2YGj1vkG7be97kCXaZk32gXwUsVpMn+X/nv/+/Xj56sF3cL0
 X9jFqqoCz9fpIJUPcunwYONIC3V1f9w7ZrLpKUYGURUU1qj0HP1Ngr3UYHAeK7paLijR
 0/fU8mX4dQjH3iVujlSWHOHdz2g0DU7fVkL2bHHaHtUbfA5/U7g1Z19OPMrdUWWKpP1V
 ygQQwA4YRWB1GHw0VJTL9JlIHpOiJqKhaprISgFuxcrEpAEQniqMeWMzAIVl5Qtd2oBk
 MHQQ==
X-Gm-Message-State: AOJu0Yw5vjwebtWDGTtoeknHPl5IhoqPV4RlHVfrVyEo1xdCU/RIbZgI
 vWsc8xGCtAnD7jd8BC+vzo1j4rxN8NHcLall/LY=
X-Google-Smtp-Source: AGHT+IF+TjryKkwSYNlcmp9MUCMv+NeEJ4jqe1npD1ANt2V6fbg6Z2OPsrnQ53naiuSHuJv1FIzSzw==
X-Received: by 2002:a05:6a00:939a:b0:6b8:3375:4885 with SMTP id
 ka26-20020a056a00939a00b006b833754885mr16595731pfb.1.1698888617568; 
 Wed, 01 Nov 2023 18:30:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 00/88] target/hppa: Implement hppa64 cpu
Date: Wed,  1 Nov 2023 18:28:48 -0700
Message-Id: <20231102013016.369010-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

This is the pa2.0 cpu that should populate Helge's C3700 workstation.

I have adjusted both user and system binaries to always support the
64-bit cpu but default to the 32-bit cpu.

Changes for v3:
  * Rebased.
  * Improve TLB lookups and flushing:
    - Separate PSW.P mmu_idx, so that we don't need to flush when
      PSW.P changes.  This was the majority of all TLB flushing.
    - Use an interval tree for TLB lookup, rather than a linear
      search across an array.
  * Incorporate some of Helge's machine patches.


r~


Helge Deller (9):
  target/hppa: sar register allows only 5 bits on 32-bit CPU
  target/hppa: Fix interruption based on default PSW
  target/hppa: Add pa2.0 cpu local tlb flushes
  target/hppa: Clear upper bits in mtctl for pa1.x
  hw/pci-host/astro: Map Astro chip into 64-bit I/O memory region
  hw/pci-host/astro: Trigger CPU irq on CPU HPA in high memory
  hw/hppa: Turn on 64-bit CPU for C3700 machine
  hw/hppa: Allow C3700 with 64-bit and B160L with 32-bit CPU only
  hw/hppa: Map PDC ROM and I/O memory area into lower memory

Richard Henderson (79):
  target/hppa: Include PSW_P in tb flags and mmu index
  target/hppa: Rename hppa_tlb_entry to HPPATLBEntry
  target/hppa: Use IntervalTreeNode in HPPATLBEntry
  target/hppa: Always report one page to tlb_set_page
  target/hppa: Split out hppa_flush_tlb_range
  target/hppa: Populate an interval tree with valid tlb entries
  tcg: Improve expansion of deposit of constant
  tcg: Improve expansion of deposit into a constant
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
 target/hppa/cpu.h                   |  180 ++-
 target/hppa/helper.h                |   55 +-
 target/hppa/insns.decode            |  189 ++-
 hw/hppa/machine.c                   |  167 ++-
 hw/pci-host/astro.c                 |   11 +-
 linux-user/hppa/cpu_loop.c          |    4 -
 linux-user/hppa/signal.c            |    6 +-
 target/hppa/cpu.c                   |   70 +-
 target/hppa/gdbstub.c               |   32 +-
 target/hppa/helper.c                |  101 +-
 target/hppa/int_helper.c            |   77 +-
 target/hppa/machine.c               |  190 ++-
 target/hppa/mem_helper.c            |  436 ++++--
 target/hppa/op_helper.c             |  310 +++-
 target/hppa/sys_helper.c            |   14 +-
 target/hppa/translate.c             | 2144 ++++++++++++++++-----------
 tcg/tcg-op.c                        |  323 ++--
 target/hppa/trace-events            |    1 +
 23 files changed, 2790 insertions(+), 1563 deletions(-)

-- 
2.34.1


