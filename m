Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9C7057FC
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yt-0006lr-Kc; Tue, 16 May 2023 15:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yq-0006ks-1B
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yn-0002jw-V2
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so8110268b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266133; x=1686858133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wb0Auln9ncK1FIC00yKgRrVnu9FaIzhjuMCmgHUtjOQ=;
 b=ReEUNC0sIAIqj9J9LzHnMiJpJA2tuMeubm3vwilclHc5a7p6wk4c2axs7/sSCq/NUg
 lDEz+pE2kyjj3VKPdUwZNAnBbQfhfWDJ89+8mW9ey8b0LVtmr2C9tggG8WlETB0fI+t6
 z0kZz1CvnHi7lutjmZyZlp9cBPT9VGg/W4f0di/xoovTuRpm9XiTlsenrfEK5byF7E7Q
 3WCRzzo7sR8EWF3TJytPP06bsRWc9zIQJ9eA5iGP8GrJAF56xXVgaGqn032vAt13aD0r
 x3brpq5nMopRRP+LZK7AjEwKSvJmqlQ8lIIotICJX2LWu6OhSFmACpCSn2wsrP7SI4yJ
 +mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266133; x=1686858133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wb0Auln9ncK1FIC00yKgRrVnu9FaIzhjuMCmgHUtjOQ=;
 b=H3PMXU4tsvlTXtY36a55fEi5vKYNXyjMhs5N91IDMkX3Q9YskJeLwx2CehqxuQMGFu
 +eOLteMJKutEqGzXOgdp9zwZwMBtdtgko0uZ5llwkFcMJ2KTmm87jGcx5J0+4pHPdGc1
 6I3MEJvFRuLqhHuGVuflPpaZchPKTgWwMTvxi2XyRK1/ZR52VwL6yXWF26v6ts/FvLoq
 lwjiVWLj1AR36SHPa/yzngTQCb+UBfg4FI89UyRMWWcfzqUTCvR5kOLljWDnL7I/tcD4
 1jK2iFFU7IIqmejgFZTY8JwC6VMoQBoYnUI70r5iiEWi9nv9Mn7whHhnRLyjt/ziG8/9
 DnbQ==
X-Gm-Message-State: AC+VfDw4Cm4S+p0Dey7q/R4G+PjZnMDPkhg1bVNDpSTMtSqAtmvu3/6Z
 M3O2g16mQk3MfoyXf//cWCeEohv/TBfATd8+TPg=
X-Google-Smtp-Source: ACHHUZ4mE2TbzJDueSEub/DX+L3AvzGQEL8udvtwReEwoXf17nmFc/EeMRRrl9iFDTnDmTKpSYGjXw==
X-Received: by 2002:a05:6a20:a115:b0:100:c3fe:a653 with SMTP id
 q21-20020a056a20a11500b00100c3fea653mr35368928pzk.29.1684266133258; 
 Tue, 16 May 2023 12:42:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 29/80] tcg/loongarch64: Check the host supports unaligned
 accesses
Date: Tue, 16 May 2023 12:40:54 -0700
Message-Id: <20230516194145.1749305-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

This should be true of all loongarch64 running Linux.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e651ec5c71..33d8e67513 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -30,6 +30,7 @@
  */
 
 #include "../tcg-ldst.c.inc"
+#include <asm/hwcap.h>
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
@@ -1674,6 +1675,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_target_init(TCGContext *s)
 {
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+
+    /* Server and desktop class cpus have UAL; embedded cpus do not. */
+    if (!(hwcap & HWCAP_LOONGARCH_UAL)) {
+        error_report("TCG: unaligned access support required; exiting");
+        exit(EXIT_FAILURE);
+    }
+
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
-- 
2.34.1


