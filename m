Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53F711347
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQI-0008P4-Vc; Thu, 25 May 2023 14:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQG-0008Nr-9N
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQE-0005su-8k
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d293746e0so40495b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038244; x=1687630244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PneTciLLHvR8ijTIsGWmXOZ1ZAuNdvQTSQFoTklUNzc=;
 b=FdcTBW64RRUoynap/2/OVZIWKalrZ8cMUCcZGE46XN1GJrDRcdkxy0whF5o0u87tbu
 wEf0vD2x9+s4VP1bQyMVZPrgK0f+LsYCzfB8SnFqnTPl7xBoBYu1VBjXOmPTM7nJXebg
 5gRHRqljVlno4aa9xJB3hpQPx9bP+prF5yHLi6JlciAZMrggzLw04dMqnGGq2pehiPrb
 Wkd0GymtxCxJgUF+IxqIWGaCFbwzlhRBvxlkQ7JyHrgccQQeTZGYrrzx3MX4GV8zEJBz
 FHdk71hBMGYsYDYH3UBBYlmxFPxKvf90qdPlTPsf8mDAGRzHUbmjnLChMO4A3eS74FUB
 TiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038244; x=1687630244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PneTciLLHvR8ijTIsGWmXOZ1ZAuNdvQTSQFoTklUNzc=;
 b=Kui87z/ERDT64DqQw8Ob4JkdHNh3Ok+89/0KvIEFkEJRARfs2D8qvtD634dYDWY35P
 XPAOUQlSFcVRDRG3H5YMBV5l0XbToQFS/bVlzQ8685LzKKbrhn2Xd40kBkkGHZAPCLCW
 EoeBaVtQiZrjRlE6DBR4QsnnghBZUxRaKb5c0Q86D/Fzwe+gk7GAEcive7o59lxrheEd
 H5OdOsB7VFVNBrSnYSeEbcHddvWbT3+DB5O3+uphWHmj1wTKwjti38B/Lvy81NfKF3rZ
 GrPJy4bfQtnOYJyFj9lf5B8QakvYu0+qNiJK/X0hTi2iOZNwFr3ggbUfGFn0j+Ge0u8w
 spAw==
X-Gm-Message-State: AC+VfDynbco2FLRbMpoAE80+PmFV5ZBmOGEVXT0NdPe4YiLVQxrWNvch
 P/KYTeuNf5+MCaMVOcblwNWef3vx4xON6y2zdlU=
X-Google-Smtp-Source: ACHHUZ6H+OKXX6BG0lFm3QYm6gGwMsAmbYQq6sfcepSpXpZIoqIuxqi7KeSpNdN6eQKZmOMsOsGRfw==
X-Received: by 2002:a05:6a20:938d:b0:107:35ed:28a7 with SMTP id
 x13-20020a056a20938d00b0010735ed28a7mr25292829pzh.8.1685038244638; 
 Thu, 25 May 2023 11:10:44 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] tcg/mips: Aggressively use the constant pool for n64
 calls
Date: Thu, 25 May 2023 11:10:21 -0700
Message-Id: <20230525181036.1559435-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Repeated calls to a single helper are common -- especially
the ones for softmmu memory access.  Prefer the constant pool
to longer sequences to increase sharing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 3b840ecc4c..068deab8c9 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1101,9 +1101,19 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
 
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
-    /* Note that the ABI requires the called function's address to be
-       loaded into T9, even if a direct branch is in range.  */
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T9, (uintptr_t)arg);
+    /*
+     * Note that __mips_abicalls requires the called function's address
+     * to be loaded into $25 (t9), even if a direct branch is in range.
+     *
+     * For n64, always drop the pointer into the constant pool.
+     * We can re-use helper addresses often and do not want any
+     * of the longer sequences tcg_out_movi may try.
+     */
+    if (sizeof(uintptr_t) == 8) {
+        tcg_out_movi_pool(s, TCG_REG_T9, (uintptr_t)arg, TCG_REG_TB);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T9, (uintptr_t)arg);
+    }
 
     /* But do try a direct branch, allowing the cpu better insn prefetch.  */
     if (tail) {
-- 
2.34.1


