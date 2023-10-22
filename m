Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF847D213F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRVy-0000HL-SK; Sun, 22 Oct 2023 02:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVs-0000H9-Rj
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:37 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVq-0001TZ-Rr
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:36 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1e993765c1bso1703983fac.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954433; x=1698559233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E23RLHw0a5tRywlziro+4KzWcQ+R1vOlwoFm/ma0qm0=;
 b=dJHiyb9BbJGBfv63EYAeqGvxNt8vAjCQbOhD9Eji5G9Rnk2+M7z2zVFDs8oQHN0GJ9
 OQu5Xvf8xB1zQHBHTzKg9ELMGKFszHDOdWGqDUdwZKiXBHiATqBtNfo1IuwI9zf/5LJc
 B7Sz4O4OdjnRgRb6urag4l7OAh5ER5QuH+iF6Zdb7jvd25IJvyPxCJQBV0qNn2XPFiLn
 1Jzph054NN2kQx1fJftBRgsSMBRKlvuMThoIjBY47YGovH5lRHxBlPaHu3ZFOlekVce4
 U5I3CZA54+ggiGl5oVHp3yfoB/8ASHx5juWz8gKrAXiYfWxAdOHfUo3Tk8KRn9Amry2E
 /3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954433; x=1698559233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E23RLHw0a5tRywlziro+4KzWcQ+R1vOlwoFm/ma0qm0=;
 b=ZFxd5pV4d1/1Q9V/SQFntCwec2dx11uQiqfJhhaP7qW6ItVjxzPrZttQkrg1nP1o6z
 q2iJKOCpW7MOs+BN33CNDtDLbw7lnDLfjAMbHAvWVoXYiCM52+9mrquE0aiLXTQ6ddWO
 j9SZe8Rhneyq3dr4bdKwUu4MG5XwNoaMNSOmK+S2dHolVYQNiQYhzSD+l6kU0XL9KdDb
 Q/KO326q+WHxwo8g+rJzi1yFELjpp3T42Dx42APBOQMHoPc4Wul6HDBjH/tQICPxA/j8
 Te8zDfGU1CaojRWYP2XBuW5AtkM2I5LXrkVEG4QWuasRhcjo17yez90mKvpz9uOxmFhV
 Apqg==
X-Gm-Message-State: AOJu0YwY1A+dgNqy+2dTHRPjXRfQaRfcF2ez2XPiWGSi5qiSwB/njzs4
 5+aMZNgExjjtiRMZD6aT1/yd+ZSxcVPV/k1x5D8=
X-Google-Smtp-Source: AGHT+IFMEmRTou4anIWzyRhqMDVMP6VPsDcJpwsHngbdvQttP+Ar7WYVHIGtkX11P0hXTlu2xwnwog==
X-Received: by 2002:a05:6870:4154:b0:1e9:c1f4:a3d7 with SMTP id
 r20-20020a056870415400b001e9c1f4a3d7mr7310689oad.38.1697954433006; 
 Sat, 21 Oct 2023 23:00:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 00/90] target/sparc: Convert to decodetree
Date: Sat, 21 Oct 2023 22:59:01 -0700
Message-Id: <20231022060031.490251-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

Changes for v4:
  * Implement htstate for RDHPR, WRHPR.
    This was the issue with sun4v rom, "wrhpr %g0, %htstate".
    Previously we "implemented" this with nop.  But since we
    have env->htstate[], add the obvious implementation.
  * The fp asi reorg got lost with "sizes", one of which was for
    the size of the access, and the other was a proxy for the
    original instruction.  This broke "stda reg, [addr] #ASI_FL8_P",
    used in Mark's netbsd image.

Changes for v3:
  * Relax v8 simm13 checking for Tcc.
  * Split gen_op_addx_int and reorganize to not clobber current cc_op.
  * Do not replicate decoding for insns that can set cc_op.

Changes for v2:
  * Fixes for JMPL, RETT, SAVE and RESTORE.
  * Fixes for FMOV etc, which had lost gen_op_clear_ieee_excp_and_FTT.
  * Allow conditional exceptions to be raised out of line
    Use this for gen_check_align and conditional trap.
  * Keep properties and feature bits in sync.


r~


Richard Henderson (90):
  target/sparc: Clear may_lookup for npc == DYNAMIC_PC
  target/sparc: Implement check_align inline
  target/sparc: Avoid helper_raise_exception in helper_st_asi
  target/sparc: Set TCG_GUEST_DEFAULT_MO
  configs: Enable MTTCG for sparc, sparc64
  target/sparc: Define features via cpu-feature.h.inc
  target/sparc: Use CPU_FEATURE_BIT_* for cpu properties
  target/sparc: Remove sparcv7 cpu features
  target/sparc: Add decodetree infrastructure
  target/sparc: Define AM_CHECK for sparc32
  target/sparc: Move CALL to decodetree
  target/sparc: Move BPcc and Bicc to decodetree
  target/sparc: Move BPr to decodetree
  target/sparc: Move FBPfcc and FBfcc to decodetree
  target/sparc: Merge gen_cond with only caller
  target/sparc: Merge gen_fcond with only caller
  target/sparc: Merge gen_branch_[an] with only caller
  target/sparc: Pass DisasCompare to advance_jump_cond
  target/sparc: Move SETHI to decodetree
  target/sparc: Move Tcc to decodetree
  target/sparc: Move RDASR, STBAR, MEMBAR to decodetree
  target/sparc: Move RDPSR, RDHPR to decodetree
  target/sparc: Move RDWIM, RDPR to decodetree
  target/sparc: Move RDTBR, FLUSHW to decodetree
  target/sparc: Move WRASR to decodetree
  target/sparc: Move WRPSR, SAVED, RESTORED to decodetree
  target/sparc: Move WRWIM, WRPR to decodetree
  target/sparc: Move WRTBR, WRHPR to decodetree
  target/sparc: Move basic arithmetic to decodetree
  target/sparc: Move ADDC to decodetree
  target/sparc: Move MULX to decodetree
  target/sparc: Move UMUL, SMUL to decodetree
  target/sparc: Move SUBC to decodetree
  target/sparc: Move UDIVX, SDIVX to decodetree
  target/sparc: Move UDIV, SDIV to decodetree
  target/sparc: Move TADD, TSUB, MULS to decodetree
  target/sparc: Move SLL, SRL, SRA to decodetree
  target/sparc: Move MOVcc, MOVR to decodetree
  target/sparc: Move POPC to decodetree
  target/sparc: Convert remaining v8 coproc insns to decodetree
  target/sparc: Move JMPL, RETT, RETURN to decodetree
  target/sparc: Move FLUSH, SAVE, RESTORE to decodetree
  target/sparc: Move DONE, RETRY to decodetree
  target/sparc: Split out resolve_asi
  target/sparc: Drop ifdef around get_asi and friends
  target/sparc: Split out ldst functions with asi pre-computed
  target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for GET_ASI_DTWINX
  target/sparc: Move simple integer load/store to decodetree
  target/sparc: Move asi integer load/store to decodetree
  target/sparc: Move LDSTUB, LDSTUBA to decodetree
  target/sparc: Move SWAP, SWAPA to decodetree
  target/sparc: Move CASA, CASXA to decodetree
  target/sparc: Move PREFETCH, PREFETCHA to decodetree
  target/sparc: Split out fp ldst functions with asi precomputed
  target/sparc: Move simple fp load/store to decodetree
  target/sparc: Move asi fp load/store to decodetree
  target/sparc: Move LDFSR, STFSR to decodetree
  target/sparc: Merge LDFSR, LDXFSR implementations
  target/sparc: Move EDGE* to decodetree
  target/sparc: Move ARRAY* to decodetree
  target/sparc: Move ADDRALIGN* to decodetree
  target/sparc: Move BMASK to decodetree
  target/sparc: Move FMOVS, FNEGS, FABSS, FSRC*S, FNOT*S to decodetree
  target/sparc: Move FMOVD, FNEGD, FABSD, FSRC*D, FNOT*D to decodetree
  target/sparc: Use tcg_gen_vec_{add,sub}*
  target/sparc: Move gen_ne_fop_FFF insns to decodetree
  target/sparc: Move gen_ne_fop_DDD insns to decodetree
  target/sparc: Move PDIST to decodetree
  target/sparc: Move gen_gsr_fop_DDD insns to decodetree
  target/sparc: Move gen_fop_FF insns to decodetree
  target/sparc: Move gen_fop_DD insns to decodetree
  target/sparc: Move FSQRTq to decodetree
  target/sparc: Move gen_fop_FFF insns to decodetree
  target/sparc: Move gen_fop_DDD insns to decodetree
  target/sparc: Move gen_fop_QQQ insns to decodetree
  target/sparc: Move FSMULD to decodetree
  target/sparc: Move FDMULQ to decodetree
  target/sparc: Move gen_fop_FD insns to decodetree
  target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
  target/sparc: Move FqTOs, FqTOi to decodetree
  target/sparc: Move FqTOd, FqTOx to decodetree
  target/sparc: Move FiTOq, FsTOq to decodetree
  target/sparc: Move FdTOq, FxTOq to decodetree
  target/sparc: Move FMOVq, FNEGq, FABSq to decodetree
  target/sparc: Move FMOVR, FMOVcc, FMOVfcc to decodetree
  target/sparc: Convert FCMP, FCMPE to decodetree
  target/sparc: Move FPCMP* to decodetree
  target/sparc: Move FPACK16, FPACKFIX to decodetree
  target/sparc: Convert FZERO, FONE to decodetree
  target/sparc: Remove disas_sparc_legacy

 configs/targets/sparc-softmmu.mak   |    1 +
 configs/targets/sparc64-softmmu.mak |    1 +
 linux-user/sparc/target_syscall.h   |    6 +-
 target/sparc/cpu.h                  |   76 +-
 target/sparc/helper.h               |   16 +-
 target/sparc/cpu-feature.h.inc      |   14 +
 target/sparc/insns.decode           |  547 ++
 target/sparc/cpu.c                  |   41 +-
 target/sparc/fop_helper.c           |   17 +-
 target/sparc/helper.c               |    8 -
 target/sparc/ldst_helper.c          |   17 +-
 target/sparc/translate.c            | 7115 +++++++++++++--------------
 target/sparc/vis_helper.c           |   59 -
 target/sparc/meson.build            |    3 +
 14 files changed, 4170 insertions(+), 3751 deletions(-)
 create mode 100644 target/sparc/cpu-feature.h.inc
 create mode 100644 target/sparc/insns.decode

-- 
2.34.1


