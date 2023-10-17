Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0C47CBADB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdJz-0008Lm-5z; Tue, 17 Oct 2023 02:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJx-0008Kw-JD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:49 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJv-0003o9-Lr
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:49 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-564b6276941so3956351a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523165; x=1698127965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMPlDVBbil/8ZDjYJof5cOYEC8a/A11w7jMjPm2ybSM=;
 b=g0aSvlLPqAIjAvt4dlHXUjSSZboI2UGrKxivGjtNYP35DPXhg4PF9y+rrzGQJs9L/l
 PA6iby+P0r/sLyM4PFc6WdshqXAcUlxS34PXzSolIGnHzhtL6yYrpRvnZG9gPISf3fTP
 02xmGUPjaJZ99muWv2U3m3/BC/m43mW6pP9D91cznAZfzch5QOseUOiLihkKiTHzHgPU
 jrN7KrLDHnqFQB7ZjcGD2dx1m/yoDuf9DHhkMxM+f/+3C2hMRjqwAtuE4vBc+TDLzyqL
 Cgly9SnXJCPUBBjmZmz8FhVncCUm9cZZ1usDDosNU1LzUqx/SkyovZLykabQyR1z9/xx
 j59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523165; x=1698127965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMPlDVBbil/8ZDjYJof5cOYEC8a/A11w7jMjPm2ybSM=;
 b=TwX1d/LT2dTsZPC/6C8HGuvRJ7XyWbsuCZKw52Kf1KHpp46+f2bGt6rdElDtUCtex6
 oEYJ/X8uBtnb4n9WwBAsUG1B5VhbXtp+hsUCQ4AI43hxpqU2YaGYBonpXY+TR315zR4k
 Rk6u1WgsDdMWnwad79Y2TMvDnn+aADatuWr7f9dsgFZnXSos8yOFFVW/LMbS+Wla3Vd7
 dNDbiol+iXEhh3Qrs3qpv2cqgGRCVsJu1NbLczHOpIiouQ/RpJxGKEcr+L+0p9K7uhht
 vIiKZHEIFljVPTEUCtrmAGrUhKKh+VnqBssOKyFSXF/+fmBJqQSXmP1qhyFHslS9GRYU
 ru7A==
X-Gm-Message-State: AOJu0YzL8WdZl7la3Ze222gSSHy0kMwBPF/XKu9dHntrwb4lFHNm0AxE
 pwbxVJCztUTQVQ0IAakHoDn6l7WVBmv7ehJofy4=
X-Google-Smtp-Source: AGHT+IEyiefnqKLDIG1HxZEy2p/qoK436zkedCiIz+d9qe/C+9IHgAtRJYYAH9G26aU0MjZVz2gtvg==
X-Received: by 2002:a17:903:2642:b0:1c7:245a:7fea with SMTP id
 je2-20020a170903264200b001c7245a7feamr1521262plb.58.1697523165517; 
 Mon, 16 Oct 2023 23:12:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/90] target/sparc: Convert to decodetree
Date: Mon, 16 Oct 2023 23:11:14 -0700
Message-Id: <20231017061244.681584-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

While doing some other testing the other day, I noticed my sparc64
chroot running particularly slowly.  I think I know what the problem
is there, but fixing that was going to be particularly ugly with the
existing sparc translator.

So I've converted the translator to something more managable.  :-)

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
 target/sparc/insns.decode           |  540 +++
 target/sparc/cpu.c                  |   41 +-
 target/sparc/fop_helper.c           |   17 +-
 target/sparc/ldst_helper.c          |   17 +-
 target/sparc/translate.c            | 6833 +++++++++++++--------------
 target/sparc/vis_helper.c           |   59 -
 target/sparc/meson.build            |    3 +
 13 files changed, 3985 insertions(+), 3639 deletions(-)
 create mode 100644 target/sparc/cpu-feature.h.inc
 create mode 100644 target/sparc/insns.decode

-- 
2.34.1


