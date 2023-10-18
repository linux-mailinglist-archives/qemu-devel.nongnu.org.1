Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B37CEA46
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESE-00014e-Gm; Wed, 18 Oct 2023 17:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES5-0000is-TK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES2-0004Mg-Ti
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso6378350b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665897; x=1698270697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8/S8sSHxU6SsNqJ7pUVzXGT8Rv+p2JizeJrho9KZ9JM=;
 b=I8h6xbfDiSye8PAScOVCCK2+G99toazOIVwvJQ5wpX+ziCS7njDwpcKy2daI3s/6En
 BgyrG++TjkYB7z73GOF/PnsqLQUuIzVQTMeRmMufC7MNtvq/79Tebq64q/1YT0BYFqut
 NUh1sQNz1nHlLSxwscsX5WDvxvkN5LlBOVLEjOqezPSOvIilcueDoJhdssKo3KKOXFis
 YJD7FuNxev0uRPZj7dOOE4PzOf6gtWRzcllKcbrrEcKag7pXodZZ092l7AnNHn7BsiZG
 j5bMysj5YyQlHduib74e1LmrVnCioIvROfpjZRqb5iw+jaQBssqj5SOco1WTJdMFAfUK
 64Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665897; x=1698270697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/S8sSHxU6SsNqJ7pUVzXGT8Rv+p2JizeJrho9KZ9JM=;
 b=MJxeUc3t7+nKdYm/gsBlC0+56R+kBx3+00wUbb1WOLa8jCcXrjHJqh3POjoiksQNJL
 osKFVqtDyX7VUzX1M52EhAdG1MHV1itGKNa+1NxqOb/a76W8u1Qiw4xte1koAOBimjw5
 Xj9tu4aF0/UqPrUSbDu5pIm8HBI7cojwiAKueb3y7lSboJlsHOQONPnpENhafNKKszfl
 IeY2vz8dy1M2kv0pioI3/NYBBsDj2o2IJLoxoWxyho21s7uMvGyvzvzdpuBgfb6V2Apl
 nl8jPoLXaUq8yGdlfXmjh3fm0KVio5uczZUg81duCjgtEvKIHoZKbZ33zuSFUxx4JaKW
 z4nQ==
X-Gm-Message-State: AOJu0Yx7Sddaeb4aRHHMa9qi//h1JizxMDxI2C7Ss1sn4Wl4/rkvfKoo
 6KrdN7ndyBOeW1MN/30d4NUjYlpdWKcOB1V3Lpg=
X-Google-Smtp-Source: AGHT+IHDoqrz6lhI9JxwUcG5Rq1PE+dzEFoHjvMIVBSKrHsEPEs9rW9AqxCZyjIzX6GjFuJoUAp9Yw==
X-Received: by 2002:a05:6a00:c91:b0:690:ce36:8b00 with SMTP id
 a17-20020a056a000c9100b00690ce368b00mr451446pfv.2.1697665896863; 
 Wed, 18 Oct 2023 14:51:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 00/61] target/hppa: Implement hppa64-cpu
Date: Wed, 18 Oct 2023 14:50:34 -0700
Message-Id: <20231018215135.1561375-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

But! With said adjustments we can run tests/tcg/multilib/sha512,
which uses uint64_t a fair bit.  Bugs were found and fixed.


r~


Helge Deller (2):
  target/hppa: sar register allows only 5 bits on 32-bit CPU
  target/hppa: Fix interruption based on default PSW

Richard Henderson (59):
  include/hw/elf: Remove truncating signed casts
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
  hw/hppa: Translate phys addresses for the cpu
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

 configs/targets/hppa-linux-user.mak |    1 +
 include/hw/elf_ops.h                |   17 +-
 linux-user/hppa/target_elf.h        |    2 +-
 target/hppa/cpu-param.h             |   22 +-
 target/hppa/cpu-qom.h               |    1 +
 target/hppa/cpu.h                   |   99 +-
 target/hppa/helper.h                |   53 +-
 target/hppa/insns.decode            |  169 ++-
 hw/hppa/machine.c                   |   93 +-
 linux-user/hppa/signal.c            |    6 +-
 target/hppa/cpu.c                   |   52 +-
 target/hppa/gdbstub.c               |   26 +-
 target/hppa/helper.c                |   91 +-
 target/hppa/int_helper.c            |   30 +-
 target/hppa/machine.c               |   13 +-
 target/hppa/mem_helper.c            |  141 +-
 target/hppa/op_helper.c             |  310 +++-
 target/hppa/sys_helper.c            |   13 +-
 target/hppa/translate.c             | 2030 +++++++++++++++------------
 19 files changed, 1959 insertions(+), 1210 deletions(-)

-- 
2.34.1


