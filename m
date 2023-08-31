Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D878E4E0
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 04:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbXsH-0004sQ-E3; Wed, 30 Aug 2023 22:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsF-0004rt-Gl
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsD-0007oE-62
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:35 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26f4bc74131so192341a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 19:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693450652; x=1694055452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QgLnonjbO7Jdbnpmqe9YH5rGnq5Uoej6SGIYLJtCId0=;
 b=GIlbk0wVCEerOcfla3RwFn0RD2lorG/wQYwaiRhCwcGENv6GpPvWury+5WGW2NXxPk
 PB+S1NQoOW3idNegOzuhX/76w7+I+CPj5OGzMrNdzv8ZZn62zENt9rtUVc8BhxZKkSmr
 cjxyXtLqvOgZQ6m71a4YDBWO/OQOsEC55u+MryBZnFM2ZX9ZZrKgFZC6mISeKEZ2wkak
 pC/xqgB4mHouOhQuhOatNvhXvByt/sj9fgdz4RoWUC9DXWsGKmrOUjyVFxvMLRqfqkbw
 NGrOGWoEsI4zIcU7vG5H53W63AHBwS5M1K5WuG6RHwrzE58AJGExhiiRMiiZVQL3dSvW
 BziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450652; x=1694055452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QgLnonjbO7Jdbnpmqe9YH5rGnq5Uoej6SGIYLJtCId0=;
 b=E3t5IGCcjBHoOYnWzm4ZOSZ2hfjWIC0DcNoOlhn6X3DU8nfM0i+3r7vHfFqrlJ6v17
 nLvGCcRYi2dqoZA3KsMUgVFaq4BNRqdkFOz1iTkx4HZkVZjUcCrmRKHhn/0i7B1MpZ5K
 nmM6BghcpEKjffeQ3trJ1XZdnEq1vjVHUCnUiPTs+KY0nnCcqydNhuFpv0tMCLZz3X01
 NoDPeNNgcv9y+p+JBTtQ0U4Ei511K7nLfTiyw8ZlwMlZmPB9YWSfteFgiypigCXgqcBO
 8AEVUGXEZs+i36I0QaRVwPocko/zHdGKsU+2Iy/51aExOkmnZzYcPvV4u+mn5y/DiaKn
 UEpQ==
X-Gm-Message-State: AOJu0YwlY3/nBS1f8BK5m1V/YdDULK45d431YMsrDti+umVCF/FUoUst
 NeJZ5kh7dKOtjNp4OfP7JXzcE84vVE6sqmGe250=
X-Google-Smtp-Source: AGHT+IHoW8cfvbPaaOk8iIrlJRac9t+gTU89zu7sEfhSyCrTZTUJ+LokIJoWBBc9b4zwmWIugV6LRQ==
X-Received: by 2002:a17:90b:38cc:b0:263:f521:da3e with SMTP id
 nn12-20020a17090b38cc00b00263f521da3emr2083533pjb.2.1693450651530; 
 Wed, 30 Aug 2023 19:57:31 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 dw24-20020a17090b095800b00265c742a262sm288142pjb.4.2023.08.30.19.57.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 19:57:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] tcg: Optimize loads and stores to env
Date: Wed, 30 Aug 2023 19:57:25 -0700
Message-Id: <20230831025729.1194388-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

This is aimed at improving gvec generated code, which involves large
numbers of loads and stores to the env slots of the guest cpu vector
registers.  The final patch helps eliminate redundant zero-extensions
that can appear with e.g. avx2 and sve.

From the small amount of timing that I have done, there is no change.
But of course as we all know, x86 is very good with redundant memory.
And frankly, I haven't found a good test case for measuring.
What I need is an algorithm with lots of integer vector code that can
be expanded with gvec.  Most of what I've found is either fp (out of
line) or too simple (small translation blocks with little scope for
optimization).

That said, it appears to be simple enough, and does eliminate some
redundant operations, even in places that I didn't expect.


r~


Richard Henderson (4):
  tcg: Don't free vector results
  tcg/optimize: Pipe OptContext into reset_ts
  tcg: Optimize env memory operations
  tcg: Eliminate duplicate env store operations

 tcg/optimize.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++--
 tcg/tcg-op-gvec.c |  39 ++------
 2 files changed, 225 insertions(+), 40 deletions(-)

-- 
2.34.1


