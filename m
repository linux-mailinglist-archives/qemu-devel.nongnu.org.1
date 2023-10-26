Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A41197D7928
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2h-0006x7-LU; Wed, 25 Oct 2023 20:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2P-0006wk-0L
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:15:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2L-0004p7-LT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:15:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc04494653so2163055ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279344; x=1698884144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nlr5FPP1VwgBL5f6X7p9IdHN0uUWa91c95Bel79EV2U=;
 b=MnDronF135SZ46guM35ukQQR6JUBkrfAgKJfvPUwu2ahvjjPgJ0Y7M2hfjFHonc26v
 x3c2lzJ5Gef/0brZfFicp7JVqNuerPexL37WkIyhla/BHj8KPe7cuDwUC6Z9GmF7VICl
 2nyWnvhXbveslmW5A4eYp6XkE4s71j7sl0wyFZljwuYdak/CVaKxILqBhuoM8a27Kpy2
 PKQ5qUi+k9A0btVhfcmJQZ2lHSvMLfeQbsA+oDMX2E7+FGG85dZMB+6nc2BB+GaiePrq
 pVu6z/8wpQCkKlZyNS0Esq4+YOPMJ4slFx/TC3DM7jLVERIukMuTjOKUIW3VaSVIav6Y
 D2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279344; x=1698884144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlr5FPP1VwgBL5f6X7p9IdHN0uUWa91c95Bel79EV2U=;
 b=bmw9ENC4z/McDa0nXFbFlSIg4EtYYH68kBWmA4ePa97xZffNVeIMR+GoskqW2Dacw9
 HVPMhqFav9GrMlJW64yzpIq6CTO6SjKTJQyXRcFUXkvS8Jc7poYWe0s5/y14+X4/cUAn
 JPwNxc52GCKbDdCWeau4uCABqt1Gki/d5HjpOd8pY0GB517zqOLADXNu88X+RM/riO+c
 IpMHHRRmrtdv1j5Bt6tUCfMuSJ95vFcVcPwdhSCHs+qrWqCe3iLPCOxh3L+Mh/aIX1MH
 /tbdheHXJDjOMcOdakAxzZqNGR6N9xMSCGCQLm/hDa8Ku6Ce05DWvF/g19JXPniI3loB
 TK+g==
X-Gm-Message-State: AOJu0Yw1ueFDNUVpIzLX9b6cakPpAnPVbLo+RTb8wbe1zubYoxH89vHP
 6CvdMdTSD8hVOnygCuC6hs1Vc1XvuhjCXRMKLkA=
X-Google-Smtp-Source: AGHT+IE6zWufs2YYbq//0rLk65JruawXggl6WxC8aNM1OIMmP9a1OQhbr7G5KiPnr4oSZTEXQrO85w==
X-Received: by 2002:a17:902:ca0b:b0:1c1:d4f4:cd3c with SMTP id
 w11-20020a170902ca0b00b001c1d4f4cd3cmr11502447pld.31.1698279343788; 
 Wed, 25 Oct 2023 17:15:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/94] target/sparc: Convert to decodetree
Date: Wed, 25 Oct 2023 17:13:39 -0700
Message-Id: <20231026001542.1141412-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad94ad:

  Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into staging (2023-10-23 14:45:46 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-sp-20231025

for you to fetch changes up to ba9c09b40b8e19ec50955216b61875d64042fa99:

  target/sparc: Remove disas_sparc_legacy (2023-10-25 01:01:13 -0700)

----------------------------------------------------------------
Convert target/sparc to decodetree.

----------------------------------------------------------------
Richard Henderson (94):
      target/sparc: Clear may_lookup for npc == DYNAMIC_PC
      target/sparc: Implement check_align inline
      target/sparc: Avoid helper_raise_exception in helper_st_asi
      target/sparc: Set TCG_GUEST_DEFAULT_MO
      configs: Enable MTTCG for sparc, sparc64
      target/sparc: Define features via cpu-feature.h.inc
      target/sparc: Use CPU_FEATURE_BIT_* for cpu properties
      target/sparc: Remove sparcv7 cpu features
      target/sparc: Partition cpu features
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
      target/sparc: Remove cpu_wim
      target/sparc: Remove cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr
      target/sparc: Remove cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver
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
 target/sparc/cpu.c                  |   72 +-
 target/sparc/fop_helper.c           |   17 +-
 target/sparc/helper.c               |    8 -
 target/sparc/ldst_helper.c          |   17 +-
 target/sparc/translate.c            | 6971 +++++++++++++++++------------------
 target/sparc/vis_helper.c           |   59 -
 target/sparc/meson.build            |    3 +
 14 files changed, 4028 insertions(+), 3780 deletions(-)
 create mode 100644 target/sparc/cpu-feature.h.inc
 create mode 100644 target/sparc/insns.decode

