Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 924DB7174B0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D49-0007Uh-0B; Wed, 31 May 2023 00:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3z-0007GH-VI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:56 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3x-0006Er-N9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:55 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-19f0e612589so3520613fac.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505831; x=1688097831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9aXuPsURqhPhLqx/28EbBnQZsWqWz9MC6q73z7SWJdQ=;
 b=Yq3mQgUb5/6emPH3ykyZ1Jj2s3AAWiEEiFlm/aIQnm7S+NGPQTnZtxknu6ArUMxKY1
 ey3Nsf0IGG0bMz2ZC5ba00bwD49VRzAPgEZXyj0R9zSa6C2mt62XOCUlMtiDynO6LuFz
 68p2w4z9cTbtd4GOglYSMa/Kqb4Bdq5+u3MPBTiWBgeRJgB/3JZLZiTvB/Uji0v23Hz8
 OjKN4Jb4/IxScSsm8Xup9e3X//Imb7E2cMVVCKrLr3F6cyMn4W7R/tQMRo00qRIWqtVA
 q7EImH6KlnmrxszCaC+Gp9qzEq0YeVdv8shPY4VxhnBGEh9PNF1ucNJr50h/seF3HENq
 6TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505831; x=1688097831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aXuPsURqhPhLqx/28EbBnQZsWqWz9MC6q73z7SWJdQ=;
 b=Dclcp4mfPZyYfgIuuZqRLRanrsjj+qUDZ/6IUQdZdavhISRGcUmNHzkakOlnRd5ZK+
 0N4S2245M9MfgyBj5Fwxw7RamerNTFnOdtEOBUotzSn32KDVdSr3l1PwHg5q/SMgbjYy
 p2zAvJn4OUqCkA1U0furuwo/bRxQTx1zAwmkPTWvrI/dxdvIlT7lXWqMnta8cJFbPSYe
 n+y2BPZHwhQfqulKoFmfzajoHqnvUOJgRbCBS1Z+HzgZ+KIfCCqgDSADRPp7rjaCHBVi
 hjvInVbXb7pW6JEh0vaPBlwz9ib42ysvPJbguK7+6V+QxpeKhEpASE20QMkV17vjDhC6
 R5Iw==
X-Gm-Message-State: AC+VfDxVNvWs64dgu7pkMRnGeNBnS0NqSyINn+fDh/NzUq6jnNedLfns
 Cqd4glKZP9H5cLVk8RZrog2B+C8Z1aBs+Ty1tgg=
X-Google-Smtp-Source: ACHHUZ5Ev92ZR21HCV8AWrRJFPmXJNnSYRs/gP/A7K6JFa4MJCVcVIByVPHkq/RXHN8aibW7E7LNqQ==
X-Received: by 2002:a54:4588:0:b0:398:2f01:ec40 with SMTP id
 z8-20020a544588000000b003982f01ec40mr2798428oib.57.1685505831442; 
 Tue, 30 May 2023 21:03:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 26/48] tcg: Add guest_mo to TCGContext
Date: Tue, 30 May 2023 21:03:08 -0700
Message-Id: <20230531040330.8950-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

This replaces of TCG_GUEST_DEFAULT_MO in tcg-op-ldst.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h         | 1 +
 accel/tcg/translate-all.c | 5 +++++
 tcg/tcg-op-ldst.c         | 4 +---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 813c733910..9f607e2664 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -521,6 +521,7 @@ struct TCGContext {
     uint8_t tlb_dyn_max_bits;
 #endif
     uint8_t insn_start_words;
+    TCGBar guest_mo;
 
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7cff2c5915..7ea927be3c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -367,6 +367,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         (int)offsetof(ArchCPU, neg.tlb.f) - (int)offsetof(ArchCPU, env);
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
+#ifdef TCG_GUEST_DEFAULT_MO
+    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+#else
+    tcg_ctx->guest_mo = TCG_MO_ALL;
+#endif
 
  tb_overflow:
 
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 3c00bf0c95..9bcf63b041 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -104,9 +104,7 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
 
 static void tcg_gen_req_mo(TCGBar type)
 {
-#ifdef TCG_GUEST_DEFAULT_MO
-    type &= TCG_GUEST_DEFAULT_MO;
-#endif
+    type &= tcg_ctx->guest_mo;
     type &= ~TCG_TARGET_DEFAULT_MO;
     if (type) {
         tcg_gen_mb(type | TCG_BAR_SC);
-- 
2.34.1


