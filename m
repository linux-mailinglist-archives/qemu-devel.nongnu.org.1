Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF957D1741
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:45:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLK-0007em-V1; Fri, 20 Oct 2023 16:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLJ-0007eV-4d
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLH-000880-D8
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so1175958b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834613; x=1698439413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yGgH1h0sKyG0MUFLHGWTfqEo1rXRrhi6xJz7d40ZK7w=;
 b=HkrPF56uEaPte/dtm615s9eK3nyrFITSoCaksd+ieUXzJByoZNBw/H3jVl8InCJ44r
 tzgVjSY72PLFv1mbaLRccyukNQwDRMPneIExsjp6Ne69rS26+8Z5WoKm61cIvT0uSfbo
 JytBoytRGKTaJhmWaCmFB5T4+9eJH+QiJT3E3ojkiTF6k6M/ihIsnuMzYd/phmMIUvRl
 mJ2EoulH6IuJ7mvjPQXVRz+s7pjq6wMReNmv0PtG/AX50Uz5DNT7p/qJ5jUyWWY7SeqR
 pMu+/a2yyKSVzocfOtH67r+pUu9sMTRNh3QLJYMZo5Ty8f9MRM2JT1jc1+jV2BJJqC9A
 nNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834613; x=1698439413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yGgH1h0sKyG0MUFLHGWTfqEo1rXRrhi6xJz7d40ZK7w=;
 b=uyHCRjlnatWpsjEV/6Vte5AxGM7awI/5nd4i/Dw0IXMUjHhFENpZw1HOUAU5VWd2QT
 ZzPJ5BSSuVMQNKunUFq2aoRbL/qJ87K/Qzttgr6F1fjSU1h+9qYWh8iKM8DeWUCIlA8L
 5tI+BVQHLpbsBPI35zhVXl4lGwHf3spCCBb+pv/0yVEyYUZki14weOden1xzhxkFvJ4j
 BK7FPJO3x6I3ArGFxD8LhYYOYbuJfXCdB/x1twy/YlID/nYmzmfb0g9chE5r26oUIzp9
 XrJY+cSWaZp17IvWfxDgY56EwbTO6kpqgMkmFCQymLdxDzep1bCV6rrFOQfeoHfnGpKv
 TYFQ==
X-Gm-Message-State: AOJu0Yz++4QiMpl975jW6QihRYsqQuNBBhvwoGJswKv5thsNjZdy1PhO
 hYg6roqizqML1GwE10k8tkT79ZpV0HfXlz33U/4=
X-Google-Smtp-Source: AGHT+IHiZe/8nw4ysHo7S3Rmi2XYEEQQEWTqHH34Pq4ksBVkJtsIfxaIlESP649yptL/YbRpu26mgg==
X-Received: by 2002:a62:f245:0:b0:6be:4df:2c9c with SMTP id
 y5-20020a62f245000000b006be04df2c9cmr2504257pfl.28.1697834613173; 
 Fri, 20 Oct 2023 13:43:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 00/65] target/hppa: Implement hppa64-cpu
Date: Fri, 20 Oct 2023 13:42:26 -0700
Message-Id: <20231020204331.139847-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

This is the pa2.0 cpu that should populate Helge's C3700 workstation.

I have adjusted both user and system binaries to always support the
64-bit cpu but default to the 32-bit cpu.

I have not yet copied the linux kernel sigframe hackery to save
the upper halves of the registers across signals.  I couldn't get
hppa-linux-gcc to produce 64-bit code with -march=2.0.  I did some
some manual testing with hppa64-linux-gnu, but that expects lp64
and a full 64-bit system library, so the tests has to be small
and self-contained and also required some manual adjustment for
the .got pointer references.

Changes for v2:
  * Rebased, fixing conflicts with the now merged C3700.
  * hppa_is_pa20 uses classes, like riscv_cpu_is_dynamic.


r~


Helge Deller (2):
  target/hppa: sar register allows only 5 bits on 32-bit CPU
  target/hppa: Fix interruption based on default PSW

Richard Henderson (63):
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
  target/hppa: Simplify trans_dep*_imm
  include/hw/elf: Remove truncating signed casts
  hw/hppa: Translate phys addresses for the cpu
  linux-user/hppa: Drop EXCP_DUMP from handled exceptions

 configs/targets/hppa-linux-user.mak |    1 +
 include/hw/elf_ops.h                |   17 +-
 linux-user/hppa/target_elf.h        |    2 +-
 target/hppa/cpu-param.h             |   22 +-
 target/hppa/cpu-qom.h               |    1 +
 target/hppa/cpu.h                   |  100 +-
 target/hppa/helper.h                |   53 +-
 target/hppa/insns.decode            |  169 ++-
 hw/hppa/machine.c                   |  126 +-
 linux-user/hppa/cpu_loop.c          |    4 -
 linux-user/hppa/signal.c            |    6 +-
 target/hppa/cpu.c                   |   70 +-
 target/hppa/gdbstub.c               |   32 +-
 target/hppa/helper.c                |   99 +-
 target/hppa/int_helper.c            |   31 +-
 target/hppa/machine.c               |   13 +-
 target/hppa/mem_helper.c            |  142 +-
 target/hppa/op_helper.c             |  310 +++-
 target/hppa/sys_helper.c            |   13 +-
 target/hppa/translate.c             | 2029 +++++++++++++++------------
 tcg/tcg-op.c                        |  323 +++--
 21 files changed, 2194 insertions(+), 1369 deletions(-)

-- 
2.34.1


