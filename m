Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F342F7D1AE8
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4al-00074t-1R; Sat, 21 Oct 2023 01:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ah-000747-TI
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:03 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4af-0008Jp-OC
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so1497374b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866319; x=1698471119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gwaFbKF3XaA6AxRC/WRGZg9TvJmEyppaDeDi79CnphQ=;
 b=Lz/nHDpwjNxx8jdq4Vadiix1HwjjUfJd1LmONUa2Ee7Is5Fdksm8JR8xzuTiXFCVMt
 8bPinfhaqtfq3FUVD2b5hGTdNhikzzZKJwhr9Uo+zaIgk9wjEEWvEJ7cH7BqQPOURHAY
 KswT8y8xRzg8I+7R3pboASjfq/VbyWs5HHMT2F9twO36i3w9odNUtg8oDIeYDHHIMIG6
 fVLd2vT0wvtsO4PzI5fJWFpJGWr1M9+9Lx2M9PCdNJUiRdFltOg48SSKVGVUAEuKef/U
 Sa6YrT9oLxWb5GQ3YCxbCQgB9QTlqqUjnnTDyoJsEy6tf3yzMA+P+tn7UfHgIVwMhTjd
 1WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866319; x=1698471119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gwaFbKF3XaA6AxRC/WRGZg9TvJmEyppaDeDi79CnphQ=;
 b=Yg9cIopygH70tvb7CRymN0D972JDsbmZZBHOUxM4kBfvNd8wyqgft2ZWGJixIZw1sL
 f7w/FajpHuu74MDrXKi9B/bx3Snad+W8sryne3K6tJaQXfaJaIpVoFWq4NEhkNrDFEqS
 twaUvmBtyVSRwWstXXh4Wt6HR52AejfvIIEwDggIo/NcKYCTw6/5cUsQ3DpaPDupvJSv
 OdMzbZ0cD4D1EhfyvjPsz8TPAw6c+ULc0C8o7CiI3AfeTm+VWHMJD/m5Bf9IuxZy+4lM
 l91LRnWo8rLOLaGJ43j1J+yV1LZRCpVqS4SXPVeGM/aEJwvqSv30WaVPIWaX06QU8H4f
 CtOQ==
X-Gm-Message-State: AOJu0Yzp9Id89fA0AlswZMSmbzAuD/4H9PwwefqOE8pTYdwPsHw5IRWy
 ZMhGuKwNeSxtNh75FyDhC/1CHphoYlQfr9CQYEw=
X-Google-Smtp-Source: AGHT+IELKq9/cu66beaHb16V9KUsNdBmR3LGl+T1ZfQIntWnqmVYksHSmsAkapuUsbpnTKqEVETvtg==
X-Received: by 2002:a05:6a00:1991:b0:6be:4e6e:2a85 with SMTP id
 d17-20020a056a00199100b006be4e6e2a85mr4040246pfl.30.1697866319531; 
 Fri, 20 Oct 2023 22:31:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 00/90] target/sparc: Convert to decodetree
Date: Fri, 20 Oct 2023 22:30:28 -0700
Message-Id: <20231021053158.278135-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/sparc/insns.decode           |  547 +++
 target/sparc/cpu.c                  |   41 +-
 target/sparc/fop_helper.c           |   17 +-
 target/sparc/helper.c               |    8 -
 target/sparc/ldst_helper.c          |   17 +-
 target/sparc/translate.c            | 7072 +++++++++++++--------------
 target/sparc/vis_helper.c           |   59 -
 target/sparc/meson.build            |    3 +
 14 files changed, 4127 insertions(+), 3751 deletions(-)
 create mode 100644 target/sparc/cpu-feature.h.inc
 create mode 100644 target/sparc/insns.decode

-- 
2.34.1


