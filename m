Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CB73837C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwnm-0006Zz-DN; Wed, 21 Jun 2023 08:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnk-0006Z9-Md
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:08 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwni-0000Fk-SW
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:08 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51a2de3385fso7739602a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349944; x=1689941944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rAlG+17uYbn7z1dUbnSUSzcIUYLPGuyIhBKFla2/xV4=;
 b=G+TzgQLaO8hS2VnlLm5E3hWjjyXUy/V4LAgFB50QspZ+2X8eRyPsP4vtMRLdHpx4M9
 pLkq5hNstQKgWxvuSfKtU0idY9PXUbKrfCSVQx07RWztGKCdFgAF8R1LJdUBMmc0P0Xu
 7vyOs3MLP3wTyHZLvv9NgIFzn+9B1/4grbcfYtJs852Dqds7Yq1Gp8oX7mHom9zgFRy5
 qvwm07RaInxo7K7GC+uJY8ja3a/qjapTqgMxIaNrwop2LRIfPJEHECNNzoOgEG57jiqd
 rDbeSaCHGkTCpb7B9g+J3AiSrBBrB1zf7eAONUPt27FlZ5p7VhFyrzKnn+aO9713ffEK
 4QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349944; x=1689941944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rAlG+17uYbn7z1dUbnSUSzcIUYLPGuyIhBKFla2/xV4=;
 b=Tt1s5/4CHEhhwCtkQ42lgS4uZ9O3hF9U7MA8/YMIg9F/ZzJ84P/TM/hUfeAWoUteQ3
 M0G370YdZ79IAhEq3EykgjsPUpza8yPBfF3z4HvsfsPZv/S6utCFYedPOJFx2/O4szTA
 eGWLM37j3VGbYtibGiz+vEh44+JMyCORzJjkd0rw77Nuqfn4dXqKi6qO4v/XiR2Inx9Y
 8/oouCcVD7okxO+q4R3rSHe5jc98IW3pIul7Ufu5z1I9XrXZMobEle4D1cRfcRVasYit
 2eKxuwtLDOJrcglGPBMy8gvLuZRfrOhpFERw+R7X71NoGTIOU34aM432CvWCB4NBBTur
 MmxQ==
X-Gm-Message-State: AC+VfDy9Aivdkk8v/C21R852Td2buA9wA0LcIpqT+2xRUN8nNIMchzEh
 aw7nJqza3bryMMCt8NJ4vMV+g9wC5LDZsiFMcIsZJPmP
X-Google-Smtp-Source: ACHHUZ7FODTuBFITKV6lcRIYELgO5vBWS2cNWvkfo/KewlZ1biwm1X+pIsXxMXQEscuPIw8itXqfog==
X-Received: by 2002:aa7:d04f:0:b0:51a:2edb:49ab with SMTP id
 n15-20020aa7d04f000000b0051a2edb49abmr10451265edo.28.1687349944697; 
 Wed, 21 Jun 2023 05:19:04 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/9] {tcg,aarch64}: Add TLB_CHECK_ALIGNED
Date: Wed, 21 Jun 2023 14:18:53 +0200
Message-Id: <20230621121902.1392277-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

v1: https://lore.kernel.org/qemu-devel/20230223204342.1093632-1-richard.henderson@linaro.org/

Prerequisites and some of v1 merged since February.
Split TLB_DISCARD_WRITE renumber to a separate patch,
since there are now dependencies in tcg/.


r~


Richard Henderson (9):
  accel/tcg: Store some tlb flags in CPUTLBEntryFull
  accel/tcg: Move TLB_WATCHPOINT to TLB_SLOW_FLAGS_MASK
  accel/tcg: Renumber TLB_DISCARD_WRITE
  target/arm: Support 32-byte alignment in pow2_align
  exec/memattrs: Remove target_tlb_bit*
  accel/tcg: Add tlb_fill_flags to CPUTLBEntryFull
  accel/tcg: Add TLB_CHECK_ALIGNED
  target/arm: Do memory type alignment check when translation disabled
  target/arm: Do memory type alignment check when translation enabled

 include/exec/cpu-all.h     |  29 ++++++--
 include/exec/cpu-defs.h    |   9 +++
 include/exec/memattrs.h    |  12 ----
 accel/tcg/cputlb.c         | 142 +++++++++++++++++++++++++------------
 target/arm/ptw.c           |  28 ++++++++
 target/arm/tcg/hflags.c    |  34 ++++++++-
 target/arm/tcg/translate.c |   8 +--
 target/sparc/mmu_helper.c  |   2 +-
 tcg/tcg-op-ldst.c          |   2 +-
 9 files changed, 190 insertions(+), 76 deletions(-)

-- 
2.34.1


