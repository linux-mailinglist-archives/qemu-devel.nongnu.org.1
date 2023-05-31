Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB247174B6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3t-000769-P4; Wed, 31 May 2023 00:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3p-0006sl-Ii
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3n-0006An-GK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso5913628b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505820; x=1688097820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lLJ+OrJ6ZDoNmYA/4Pv3PzTB4pxZ5PUcgKGyl5lAA2g=;
 b=LUiCXAJTu77xq4A3gkmcONvnBd4ybBhi7enh9S43dotqsgy4EO4U50IaP0EQw3TFsC
 OKahk8heBUdU5MMJs18zINVDYvcPyI/obB8szuD9QV/yit9zoK88fqm2aZXUGTyZoy8b
 z85fV7/0/hcHf/PRMBdgU/FNitAbgiOekFF+K2PlKCMPmf8mGBZfuFnZ9U01UCfJGQHP
 npDk5GZ9LvTwGOPRT6/KolBmtS4vfF7g9uvR0gyflsUuEWtNGaNmQ1ufd3/6WUeIlh/h
 1D2+IpgxMbvnTYLv8cfoFuUFd8mtOIqrPpdDYWiqSTT/Rj03rTqYRbB4JE4b7qmbmHyr
 S5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505820; x=1688097820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLJ+OrJ6ZDoNmYA/4Pv3PzTB4pxZ5PUcgKGyl5lAA2g=;
 b=IGALE3UYxTDtveEVpca6vIjWuIoXgmX5ZZBLnjz7XD2J1pd3LNgPY3Cvqkd5ZVs90z
 inurFMNTnzyGkj5X11Gx118+nA+w1slAoPnbUKvD5suJWrpzau1id/oNQzeqDBnh5glE
 2Cn4NU3xKBopPenwksN6wvAyNNBY6h17BlZ87zpd2Fi6sdbUhn5s5oNqjlGLB0AS/wrW
 DK0CriNnftYp406vp94t2fsQf361lklYeM7P7FGtJVKkL6X6fAgCF3W1TFvvszbHFZ6b
 C0ntVHvXKWtSikKRb5VRCxFkwQzmFxuZX8AZgfjxdXzKcfWu8nkIcOYKBfQjPr3+fdp8
 ZvFA==
X-Gm-Message-State: AC+VfDxcT/ZKsNQJ+NEiDMW0CShTGnkS7xj/qyIvFr55frdKcFatAAQX
 AGrimfBMa6Pu7IakXVxYZUyHjoqQeymPID0OPy0=
X-Google-Smtp-Source: ACHHUZ7U+4l+L8EqqRu8zEbaV1TXPeLhRLYXVY8JZLLZSDfslIwXfYPDeFjdRi6QlCkxRzyGYg/OUQ==
X-Received: by 2002:a05:6a20:7491:b0:10f:7e62:3806 with SMTP id
 p17-20020a056a20749100b0010f7e623806mr5391743pzd.22.1685505820572; 
 Tue, 30 May 2023 21:03:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/48] target/arm: Fix test of TCG_OVERSIZED_GUEST
Date: Tue, 30 May 2023 21:02:54 -0700
Message-Id: <20230531040330.8950-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The symbol is always defined, even if to 0.
We wanted to test for TCG_OVERSIZED_GUEST == 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 69c05cd9da..b0d2a05403 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -418,6 +418,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
+#ifdef TARGET_AARCH64
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -473,7 +474,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
      * we know that TCG_OVERSIZED_GUEST is set, which means that we are
      * running in round-robin mode and could only race with dma i/o.
      */
-#ifndef TCG_OVERSIZED_GUEST
+#if !TCG_OVERSIZED_GUEST
 # error "Unexpected configuration"
 #endif
     bool locked = qemu_mutex_iothread_locked();
@@ -497,6 +498,10 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 #endif
 
     return cur_val;
+#else
+    /* AArch32 does not have FEAT_HADFS. */
+    g_assert_not_reached();
+#endif
 }
 
 static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
-- 
2.34.1


