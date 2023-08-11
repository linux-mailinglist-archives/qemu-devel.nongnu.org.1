Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C97799BA
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsM-0003Fe-Nd; Fri, 11 Aug 2023 17:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsI-0003CC-IK
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:50 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00027m-Le
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2685bcd046eso1447561a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790033; x=1692394833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LE9h0+JfIrr87JPl4JPF+OrALN1dYoTWFGst92ndGEg=;
 b=DbkIMus2kema7j7uKiMy8f7oJ6D89W9BgSdYxZqM71Vsl7XZpsG9b2MZ2p/SuaeUYP
 nBDBBz88p91h2zKEXeukuNPOJylbOfNw5CA8KaOsGckq5KaH73h8tNb84Ttr0/NZTv+g
 MVXfNu/OfK5IdGWVeFg3WuGv12mvSEYcx2zJhPyd0LyzDWYIFaX+Gk4E70b9FrQ4RCHM
 L/VhoejbyzWHzJZTQhG3kpVimbk32yDZg2qWuD8ZnRFdJJyUC5o7bOSz55diZoCHHqJK
 L+bbbCCvI4isj4fatycAKGeWQ8KUcjlFmK6lPIyrkKbu2Ck36lTQkL18+midFnCtydov
 lucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790033; x=1692394833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LE9h0+JfIrr87JPl4JPF+OrALN1dYoTWFGst92ndGEg=;
 b=jGRIicRuRm81M6aOZcXU5eMf2ANTFzIV8WuW8fb4YMcPW0MoVSk0MkSNMVD2KEGsfh
 Mx/QJ8oARswkzjzqcWJ95l+sspiuUkwNmsWv4Znz+AY7RzhJcByjssFK9AMjOoZ9dNnx
 glzsYYy/TBoXYX/SPlJCdqvHFd8sF9quMgTzHIBIpc2rl4PTlOBbTwGtpCj74gFeiTuo
 ZrdY3pxliMMzfoHwPl/NK5Lgy9Qk7zuXL4TNTFUa1i7vZmjNqG5EeJOt04FklTkslAln
 AJXCtm/TLJvfZh9A/dznFJrHprNKJnx4SQzkcpTmVfRa5JsrwNRDKM+PD3kdEUObCWYw
 RyNg==
X-Gm-Message-State: AOJu0YywRJ5xOdMrx4HDf9RRwJrEtD2BUO3FPf0G0eryuLUqUWzk7XCM
 5U4kWgv3GItVOi4Yi0cPO2dYTj/33smcpawEl2k=
X-Google-Smtp-Source: AGHT+IENTRjhTbVF1Xg6ka7S1TXH/UPS09fEK7XME3afAq3QohCOBaIItgvq/D/oE42oQPbB13su3Q==
X-Received: by 2002:a17:90b:3c4:b0:268:10a3:cea8 with SMTP id
 go4-20020a17090b03c400b0026810a3cea8mr2277924pjb.9.1691790032879; 
 Fri, 11 Aug 2023 14:40:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/11] target/arm: Implement cortex-a710
Date: Fri, 11 Aug 2023 14:40:20 -0700
Message-Id: <20230811214031.171020-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

This is one of the first generation Armv9 cores, and gives us something
concrete to test in that area.  Notably, it supports MTE.

Changes for v2:
  * Check GMBS during realize.
  * Fix access checks for neoverse implementation registers.
    Mostly just traps EL1/EL2 if EL2/EL3 enabled.
  * Add make_ccsidr64 helper.
  * Reduce MTE with no tag memory to MTE=1.
  * Suppress FEAT_TRBE.
  * Implement HPDS2 as a no-op.
  * Rewrite a710 implementation registers; do try to share code with
    neoverse, because the traps are different.  This of course solves
    the renaming and renumbering issues too.


r~


Richard Henderson (11):
  target/arm: Reduce dcz_blocksize to uint8_t
  target/arm: Allow cpu to configure GM blocksize
  target/arm: Support more GM blocksizes
  target/arm: When tag memory is not present, set MTE=1
  target/arm: Introduce make_ccsidr64
  target/arm: Apply access checks to neoverse-n1 special registers
  target/arm: Apply access checks to neoverse-v1 special registers
  target/arm: Implement RMR_EL3 for neoverse-v1
  target/arm: Suppress FEAT_TRBE (Trace Buffer Extension)
  target/arm: Implement FEAT_HPDS2 as a no-op
  target/arm: Implement cortex-a710

 docs/system/arm/emulation.rst  |   1 +
 docs/system/arm/virt.rst       |   1 +
 target/arm/cpregs.h            |   2 +
 target/arm/cpu.h               |   5 +-
 target/arm/internals.h         |   6 -
 target/arm/tcg/translate.h     |   2 +
 hw/arm/virt.c                  |   1 +
 target/arm/cpu.c               |  28 ++-
 target/arm/helper.c            |  15 +-
 target/arm/tcg/cpu32.c         |   2 +-
 target/arm/tcg/cpu64.c         | 347 ++++++++++++++++++++++++++++++---
 target/arm/tcg/mte_helper.c    |  90 +++++++--
 target/arm/tcg/translate-a64.c |   5 +-
 13 files changed, 437 insertions(+), 68 deletions(-)

-- 
2.34.1


