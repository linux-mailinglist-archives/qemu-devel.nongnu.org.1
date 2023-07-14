Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05130753F46
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0T-0007BV-GY; Fri, 14 Jul 2023 11:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0R-0007AN-1p
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0P-00074v-G5
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-316eabffaa6so1619558f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349611; x=1691941611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/EJg2t+NohoMxOA2O/a5DEFZTUDueNlOq7nEQNzI7k=;
 b=tJv+EczJol1fQAcGCVyIz44Ukac7ek/zW9YqYGlQ8JMGoOfyhgOb3i0RO/nn0lNdDF
 ffpC+EpZN4p39s6u2GpHgo7DQE00cc4DcSO5GePbGzgvmcHCVGMMLB0X8sgtcaUyBtJL
 jR+Q6Ingft46lkwDfjPJi2CamtqnPhdFJ91sPkfmlV2+5iKyqVOqIlZqOzOhGv8Xrf2C
 U98Czwzn/hStPdhakSNFpSy/eveaUy49qp82iopF9YYeFGkXKhM7M3hhS72FIa7ktFYb
 91rPO2gV+3LWypF7QydSJZCLI8yC6v65q9nUA96noP1y4tYyjb0hOrJEZu452UNRBPAw
 lqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349611; x=1691941611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e/EJg2t+NohoMxOA2O/a5DEFZTUDueNlOq7nEQNzI7k=;
 b=XfqT6IrZjmfzpw6EdmQkerpIMViKra8Vkg9sRWeE+3CM+p3i1QqOV1AGFePCFBxWVA
 7ZjylyxpcNvn6VTzDeBZx+Bvuze3+E7SM/PhtF9ZUc+S5zIfSVp3D1sHnIP16pksgV+P
 eFcpiPMonuq70+MwK0jsDq5/u4MlKw2qD3GFT4XkIhUnuAZzHbVg0Zox+kudvGOoB9tj
 QFqEOKjIKrfnu6KI8+gVk3AHw8vBTm+gBVwrusdLmMlygwo0QA+Wzm+gCtnpihg493Cp
 x4bN8T6bNAkH+lACS1oziVNlawKXepmsZnhF/PgtE6bVkMJJjJraIf8nD25EB9RoeorC
 uz5g==
X-Gm-Message-State: ABy/qLY5KrV1q8i7R1+02mZ9/DbzqXcn3LN1TWoBZ8+gbcTr18P4bweZ
 8OI8dYwqH5gHWjmY+p8I3+YD0pj2KEn3px/s4Ag=
X-Google-Smtp-Source: APBJJlH88vZvVQa7ObrfBfleUxCkD63WlFh+HbKl3BBUojVxN7kd839JZXOiCSVO17U8hciTkMpypA==
X-Received: by 2002:a05:6000:1cce:b0:309:1532:8287 with SMTP id
 bf14-20020a0560001cce00b0030915328287mr4136703wrb.19.1689349610961; 
 Fri, 14 Jul 2023 08:46:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/14] target/arm/ptw: Cleanups and a few bugfixes
Date: Fri, 14 Jul 2023 16:46:34 +0100
Message-Id: <20230714154648.327466-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Based-on: 20230710152130.3928330-1-peter.maydell@linaro.org
("target/arm: Fix ptw bugs introduced by FEAT_RME changes")

While I was fixing the ptw bug in the series above, I noticed
that we had a somewhat confusing mix of ptw->in_space and
ptw->in_secure, where in theory the two are supposed to be
in sync and you can figure out the in_secure state from the
in_space. This patch series' principal aim is to clean that
up by removing the in_secure and out_secure fields in the
S1Translate struct.

The first three patches are fixes for (minor) bugs I noticed
while I was trying to do this refactoring because they're
in or around places that were using in_secure.
The next three are basically plumbing: passing ARMSecurityState
arguments instead of boolean is_secure arguments.
The next four patches then can get rid of uses of the
in_secure and out_secure fields and drop them entirely.
Finally, the last four patches are minor bug fixes for
various corner cases that I noticed while I was testing this.

I don't expect to land this series until we reopen for
8.2 development, but I might as well put it out on the
list for review, since I've written it.

thanks
-- PMM

Peter Maydell (14):
  target/arm/ptw: Don't set fi->s1ptw for UnsuppAtomicUpdate fault
  target/arm/ptw: Don't report GPC faults on stage 1 ptw as stage2
    faults
  target/arm/ptw: Set s1ns bit in fault info more consistently
  target/arm/ptw: Pass ptw into get_phys_addr_pmsa*() and
    get_phys_addr_disabled()
  target/arm/ptw: Pass ARMSecurityState to regime_translation_disabled()
  target/arm/ptw: Pass an ARMSecuritySpace to arm_hcr_el2_eff_secstate()
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

 target/arm/cpu.h    |   2 +-
 target/arm/helper.c |  22 ++++-
 target/arm/ptw.c    | 190 +++++++++++++++++++++++++++-----------------
 3 files changed, 135 insertions(+), 79 deletions(-)

-- 
2.34.1


