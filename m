Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B8177275C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT116-00008O-JB; Mon, 07 Aug 2023 10:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10z-00006x-No
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10w-0005Qo-Te
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so38565715e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417716; x=1692022516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f9tizgWmwswfKOu+cgNjVcEdMF1Xn+daiPSP9q+Z8ZE=;
 b=p9rcZRTBeieaHL+BJsJLO7dahJwcjjghxx6q18PYSKE9AWGmhdet5aTsarn5db5Gn5
 ItAGExS8FZqz6ufTxCl29CwoOcYJbKwHg3gilZtU5KgvPRAV9sfrgfQOgCh6Ha7FwsGO
 +O9F62W5/yWGPrsHEJvVMNWDJbOBqs1nbUL6mzJa87SwQafbywCNEUruyxwb+u8b5+dn
 I8Qln5QzWRvUNnw1jm0G1P46F3ICtn5voZYjoX7klD1uTbof7HZyT4f2CHSKfuIXTvy6
 ARbCFBvB5LFM6MJKsU9IXp/Tkq1V65qr4Tp9RnvN/vrbm08bxRbRYO8I26GPtoG1ZGhy
 Jxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417716; x=1692022516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9tizgWmwswfKOu+cgNjVcEdMF1Xn+daiPSP9q+Z8ZE=;
 b=ZawZvG42BRVIRbNtggRyqQOQfV0953ZAOoLOUNJLAzoF2FyV+TGW4A8l5rk10JOuWv
 mBOhbSVrY5AIPBpegKiJz+v2VQiv7mbJJSfuJPtCaZhBgTjjoDQJ1oLcd3E+UVk33M0f
 oi+kHQSEo3g2F6VaIQr97MeybXA+zdGZEGV05GHX94Z0PXI6Vm1qVow0y7JqQ/8a/YYY
 W2a/NQWRU36r7X2QDqJkBe1qbrZmxt/lBh2NcxcmfJFeXmR4mMRN600nG6bwAmL4pGAe
 dO0r/oL4DKMV7tb4wxH7Dlb7TV3UxmnUNPSiFhblNCm43xFI1KycQbRgZVRA7+28Mvvf
 Y4Xw==
X-Gm-Message-State: AOJu0YznzUiNkYt+1pineS6v2vSTPWiM7W5RkCv9t0IetoWAgf/CocsH
 MFPCpSABs7blFDkXNseAxgU1wyocX5lwMiSvD0Q=
X-Google-Smtp-Source: AGHT+IFTo4j0XqGjM40BkhEmsBX5ERltHno8ZAOuh3ppTA20nI2/Jb60L6Pa9fe/SE8xFp9+2JADug==
X-Received: by 2002:a05:600c:2193:b0:3fb:f926:4937 with SMTP id
 e19-20020a05600c219300b003fbf9264937mr5737546wme.31.1691417716489; 
 Mon, 07 Aug 2023 07:15:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] target/arm/ptw: Cleanups and a few bugfixes
Date: Mon,  7 Aug 2023 15:14:59 +0100
Message-Id: <20230807141514.19075-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While I was fixing a ptw bug recently, I noticed that we had a
somewhat confusing mix of ptw->in_space and ptw->in_secure, where in
theory the two are supposed to be in sync and you can figure out the
in_secure state from the in_space.  This patch series' principal aim
is to clean that up by removing the in_secure and out_secure fields
in the S1Translate struct.

The first three patches are fixes for (minor) bugs I noticed
while I was trying to do this refactoring because they're
in or around places that were using in_secure.
The next four are basically plumbing: passing ARMSecurityState
arguments instead of boolean is_secure arguments.
The next four patches then can get rid of uses of the
in_secure and out_secure fields and drop them entirely.
Finally, the last four patches are minor bug fixes for
various corner cases that I noticed while I was testing this.

Changes v1->v2:
 * in patch 6, avoid calling arm_hcr_el2_eff_secstate()
   with ARMSS_Root, rather than making it return 0
 * new patch 7 ("Pass an ARMSecuritySpace to
   arm_is_el2_enabled_secstate()")

Only patches 6 and 7 still need review.

thanks
-- PMM

Peter Maydell (15):
  target/arm/ptw: Don't set fi->s1ptw for UnsuppAtomicUpdate fault
  target/arm/ptw: Don't report GPC faults on stage 1 ptw as stage2
    faults
  target/arm/ptw: Set s1ns bit in fault info more consistently
  target/arm/ptw: Pass ptw into get_phys_addr_pmsa*() and
    get_phys_addr_disabled()
  target/arm/ptw: Pass ARMSecurityState to regime_translation_disabled()
  target/arm/ptw: Pass an ARMSecuritySpace to arm_hcr_el2_eff_secstate()
  target/arm: Pass an ARMSecuritySpace to arm_is_el2_enabled_secstate()
  target/arm/ptw: Only fold in NSTable bit effects in Secure state
  target/arm/ptw: Remove last uses of ptw->in_secure
  target/arm/ptw: Remove S1Translate::in_secure
  target/arm/ptw: Drop S1Translate::out_secure
  target/arm/ptw: Set attributes correctly for MMU disabled data
    accesses
  target/arm/ptw: Check for block descriptors at invalid levels
  target/arm/ptw: Report stage 2 fault level for stage 2 faults on stage
    1 ptw
  target/arm: Adjust PAR_EL1.SH for Device and Normal-NC memory types

 target/arm/cpu.h    |  15 ++--
 target/arm/helper.c |  23 +++++-
 target/arm/ptw.c    | 192 +++++++++++++++++++++++++++-----------------
 3 files changed, 146 insertions(+), 84 deletions(-)

-- 
2.34.1


