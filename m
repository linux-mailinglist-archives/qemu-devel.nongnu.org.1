Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEEA7D26F5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quht9-00072Z-VK; Sun, 22 Oct 2023 19:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht4-000722-Ak
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:38 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht1-0006fr-PP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:38 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1e58a522e41so1934157fac.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017374; x=1698622174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qhRQ5cjhPPcxooOsW4OyomDwyqILh84TD72hMJ6WeNE=;
 b=BTx61ZakaysWjvs6jX38O63q6b99GUuSCBnGgtaDX61KHqde16kmz0RuQvxOygJh5i
 6XyUEUCG8MgLqTQF9+bP6rmtAzE8h9PRQZRz1xLLwSEPonXF2+8S779eLqqnRfNXw+1q
 MzPZBwS9HQ0n8N9ivketz0Bw/+D5w5rL+aWbKdj3WKKgtcOpg1iNAgJKGPORPQG6Wwpi
 H8sasmcCYoV5QeW+NsJ0gKLeO9/2Jpiv3EwrXwdELcojjYzSbSIcI+1m/A+ol1QcIvcg
 qLx+DTY0JeB18jNcp+bg1E1d94qSIWhy7e7hSghcvsh9VAfe7oTPwXd4mWGLN5Z0kS92
 gO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017374; x=1698622174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhRQ5cjhPPcxooOsW4OyomDwyqILh84TD72hMJ6WeNE=;
 b=VotFLZ+07nrakIRPSQ2FEjfAw/rY3EdZFd/QNKxyJvLXoLuPmIRLvOCtGI049dJipa
 NSlanDMscN69SmOgs1NaeWdqWEiBCsHXIXCRWB3qyXBjPh3BGrQ6QedPD2Hzpa8CT9b4
 L6QO/UYTKD84gQ5cyrNm1XrCDGUdPvSkjWplAMZP+DSKYF/rO1WvX2X7fTgNddMIWXBm
 tWrvEyDmQbGJxpUU+qBAeIT2BWWaLKB89Z2/xQeGHC2qda8CyIE8friwLWNx4xzDYwA8
 bR7Y1hqs5rS9ulEEMMvthSq0OKzVhx9ju/eytCIuVlUXXqrxRVZOppqhAY5dj70NOQeL
 fAXA==
X-Gm-Message-State: AOJu0YwZ5qRMVRwsV+wpL8Kp89TC4l19RMv8Y4aVi42kOwvXuo7rADOS
 u3pNs1UkQH4zLA5nWIDACMfQkXjtIIbgqRBB2jQ=
X-Google-Smtp-Source: AGHT+IFRQm1EZxix8swG1LFSiJjYdUdYOrnuiKyX+e2zsUoAWDvl83loZMnvMeQRYZ6MW1TPtctiqA==
X-Received: by 2002:a05:6871:230d:b0:19f:aee0:e169 with SMTP id
 sf13-20020a056871230d00b0019faee0e169mr9453222oab.30.1698017374005; 
 Sun, 22 Oct 2023 16:29:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 00/94] target/sparc: Convert to decodetree
Date: Sun, 22 Oct 2023 16:27:58 -0700
Message-Id: <20231022232932.80507-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

Changes for v5:
  * Add Mark's a-b and t-b.

  * Fixes to features:
    - Use CPU_FEATURE_BIT_* in feature_name[] (patch 7).
    - Don't allow features to be set/unset in nonsensical ways (new patch 8).

  * Adjustments to ifdefs:
    - Make avail_FOO() constant when the feature must be set/unset.
      This fixes the do_wrhtstate build issue Mark saw.
    - Introduce envN_field_offsetof().
    - Remove TCG globals only used for {RD,WR}{PR,HPR} (new patches 30-32).
      

r~


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
 target/sparc/translate.c            | 6968 +++++++++++++--------------
 target/sparc/vis_helper.c           |   59 -
 target/sparc/meson.build            |    3 +
 14 files changed, 4025 insertions(+), 3780 deletions(-)
 create mode 100644 target/sparc/cpu-feature.h.inc
 create mode 100644 target/sparc/insns.decode

-- 
2.34.1


