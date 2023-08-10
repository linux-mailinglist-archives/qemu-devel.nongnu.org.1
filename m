Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE5776E22
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 04:37:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTvWp-0000ux-ES; Wed, 09 Aug 2023 22:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvWj-0000tw-BD
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:35:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvWh-0004x1-Os
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:35:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-687087d8ddaso403908b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691634950; x=1692239750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CpX0550wKMCux/3GBST6e64zt0DiUd6H3+LGhoX5Le4=;
 b=nxE6HNRCusB6fZYY6XNCichRSFLYz/wJ+Z80eX+cTtzkebnHEr7zNV/9ryCAMh/VX9
 xa9dGe5ZUocQ1flZzigcxXUPIFGccTSyLGesSW4yFyd6kA+GF+FV0XZi6h4x6+P2Pmyy
 nDenJJBTgak0vLbieRfJqbJh+zUOBmW0olwE4qBVYhcwtwLb6366JA1RzdjRfbBVYtlP
 KT/Fo/Y/usHC8XJxEhcjEeO4RcKBGJxJDOYUwayOfy64lOl67qzOTMiQBPvXwZ727lwU
 JXpXyiOO58QRMER1Y5U08BrjpUw7xNBA0/wX335ELzn11snWJvp36BvIBqiBXFySH3FF
 YOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691634950; x=1692239750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpX0550wKMCux/3GBST6e64zt0DiUd6H3+LGhoX5Le4=;
 b=l0wTCD218XY1Cvyb1SUq4n0ACVq4D3iJd7w+JBOdlDPKZKXDHwX3Ra7Q6jteyUStof
 Cmrv1LEYvXGmtD1G7NDVW2oePQ7PpoHBEBmkmNTyjhPTsku7Majxq7Y99nTK7Mzlxm8q
 XlzbNmsF9rp6MWURd+weEmK8WoxHRFGlQsEQeUQhXThy0uc430vVe3YXBpFeL18U5XV2
 slAgjrQK22Qsj71h5Jfur9qUn1p7GReWiDBt5SVUSaUC5Us7rZesXx1YmrD8Lp9hoRMk
 fai1J7FWBrWG62zoRKHWKO5ImuSHdm8+AzUUFBrsnmhx5POk40NKBrvr3wjGrijSEQ94
 EwwA==
X-Gm-Message-State: AOJu0Yy8F5KSLEYlwtf1UJsdD/uUJ+cXwM8rVtEJ73ZKEV03ShISXMvF
 nB+xrLrHVvf0QCRX5JpXOH6VpGCNgxRKnDhyaEs=
X-Google-Smtp-Source: AGHT+IFhJdrxAZzXSEj0lkiMQ+wk6BekqZA7OjS/Gc7j7LTe6kQdIRMvQR0BqW5z2ZF1tpRhheeecA==
X-Received: by 2002:a05:6a20:1583:b0:11d:8a8f:655d with SMTP id
 h3-20020a056a20158300b0011d8a8f655dmr1541785pzj.4.1691634950092; 
 Wed, 09 Aug 2023 19:35:50 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 z7-20020aa791c7000000b0066ebaeb149dsm287283pfa.88.2023.08.09.19.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 19:35:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-8.2 0/5] target/arm: Implement cortex-a710
Date: Wed,  9 Aug 2023 19:35:43 -0700
Message-Id: <20230810023548.412310-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is one of the first generation Armv9 cores, and gives us something
concrete to test in that area.  Notably, it supports MTE.

The first patch is a bug fix of sorts for neoverse-v1, as we don't,
and won't, support FEAT_TRF.

The only thing missing for the a710 is FEAT_MPAM.  I haven't looked
at that properly, and I believe that there may already be some work
done on that within Linaro -- even if a stub implementation.


r~


Richard Henderson (5):
  target/arm: Disable FEAT_TRF in neoverse-v1
  target/arm: Reduce dcz_blocksize to uint8_t
  target/arm: Allow cpu to configure GM blocksize
  target/arm: Support more GM blocksizes
  target/arm: Implement cortex-a710

 docs/system/arm/virt.rst       |   1 +
 target/arm/cpu.h               |   5 +-
 target/arm/internals.h         |   6 --
 target/arm/tcg/translate.h     |   2 +
 hw/arm/virt.c                  |   1 +
 target/arm/helper.c            |  11 ++-
 target/arm/tcg/cpu64.c         | 172 ++++++++++++++++++++++++++++++++-
 target/arm/tcg/mte_helper.c    |  91 ++++++++++++++---
 target/arm/tcg/translate-a64.c |   5 +-
 9 files changed, 263 insertions(+), 31 deletions(-)

-- 
2.34.1


