Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B57C8F12
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiI-00069t-FA; Fri, 13 Oct 2023 17:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiG-00069M-Cq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:52 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiE-0000Oy-KA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:52 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57de9237410so1473773eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232528; x=1697837328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yd2wXvDut8MVmmcxopqcz13LPn+MVM1PctiQlc4/cOQ=;
 b=GWp9HuhFiSaWkqzP6g3ZtBcaOQ3vG6WCKwozVFvYW3KCXNBmT7Ikor+4MfaXhe6Y/g
 ktfiOVXGFBtWbJpZW1VNINI4kvDaQ7wvbaE4TYbW0wOJIzmX2KgDEthFZZKQfo2Jk1lj
 b40+tZPEo74vFHmHG30tZD1VxL2ejH6IOmc/PRJ7XcycIZiBxDmw9if030pv0mVZRu7F
 aym8Wp40jIG7Bbk8nNM7oNWpTO56vI4sn+GWKqoMbXV1Tm9NmcA7Ifng1Wv2YjPAT04F
 pF8Wfcdk9tQ2ozVQoE8K/klRYF+Q0LQfTqJHqJitCKuETKNGwsCCwxBtchN6qpHselTD
 W6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232528; x=1697837328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yd2wXvDut8MVmmcxopqcz13LPn+MVM1PctiQlc4/cOQ=;
 b=Lira/uF3znzssgt7Ieha7Ua/DpcwrhUot7bK4fgrkJf9Enbu4cyTlpmB2AQ+39NCUk
 cGyr4ZubD4EGczncLI7BcsMyMMnJ1GnTgMB5PFmtgx+UOxMPGaxULkCmfGNymezqDXuK
 T96VYfSs1YAh8XW6POWTABlyg97ZdfqyvoylVJQdfWrHMOdBlg9NiWlIy5xJIDyGvK6y
 2IkcfHWQDF/BXrezg3mTeDJPw/zBHpeFH+zlstMsDr1BIMM1m1tk/WwcerAeZx2KJx7n
 RiVlFoETdXRyPcp1bWJjMTzPxkqO2WdpthTi9wvSvZR+UdcpsuMp8lxGFKcvkZ6S1oYk
 x9sg==
X-Gm-Message-State: AOJu0YzsSoOEFkCSefqDoTi6M/y4L5MK1pd3MxwtJLDYoTdlOsO5MydQ
 CIF1A3ZKBCrSCkjVCPUBnE3wyay74L1YuRX/wDs=
X-Google-Smtp-Source: AGHT+IHBYxBOeChJYir7EFyhIgZyUjh5SCYoN7BLvL+XEjLvFpm8jRauyByUNONNJiYUndsatK2b8w==
X-Received: by 2002:a05:6358:788:b0:142:d097:3725 with SMTP id
 n8-20020a056358078800b00142d0973725mr31021869rwj.9.1697232528149; 
 Fri, 13 Oct 2023 14:28:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 00/85] target/sparc: Convert to decodetree
Date: Fri, 13 Oct 2023 14:27:21 -0700
Message-Id: <20231013212846.165724-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

I've only done avocado testing so far, fingers crossed.


r~


Richard Henderson (85):
  target/sparc: Set TCG_GUEST_DEFAULT_MO
  configs: Enable MTTCG for sparc, sparc64
  target/sparc: Remove always-set cpu features
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
 target/sparc/cpu.h                  |   73 +-
 target/sparc/helper.h               |   15 +-
 target/sparc/insns.decode           |  541 +++
 target/sparc/cpu.c                  |    8 +-
 target/sparc/fop_helper.c           |   17 +-
 target/sparc/translate.c            | 6692 +++++++++++++--------------
 target/sparc/vis_helper.c           |   59 -
 target/sparc/meson.build            |    3 +
 11 files changed, 3804 insertions(+), 3612 deletions(-)
 create mode 100644 target/sparc/insns.decode

-- 
2.34.1


