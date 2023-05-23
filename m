Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D971370DE5F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:02:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STJ-0006nA-5n; Tue, 23 May 2023 09:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SST-00054S-Vg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSR-00037V-HC
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so4211806b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850026; x=1687442026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4h70UmOuZApqGwH8fl/aBGmj5U+73aMDvSoJL1qlazg=;
 b=DQKN1RmhsM1WfV3sb9RmlkUxVXfYbojqu1dvscpbTZbzz7nREbkM7i/8ahnlouwUqF
 PlvxwIAN6HgS3fyOREULmzlaZsP12JPsC7ZRKMhwYAEKrwSwmCiH8Ty8hihVKvYMAhDU
 iFusDgOQF9uQnCVs9uuCwcRvx1zPkrqCM3uleWN0qFmqV4OP/EXa0T1SUG0iRT653JIL
 CN8t0LdtIy+ZZoLf/zpDZKutkKaUXzYv38h2thiczlhMt+AowyGmhdC+vrXp+9xGkeRr
 pxxFW6O183wKDNE3nvQFtMGTegPv41UyKLONejg8YHtGUppJAOWB76pxTvGAyq8sloQT
 KOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850026; x=1687442026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h70UmOuZApqGwH8fl/aBGmj5U+73aMDvSoJL1qlazg=;
 b=KEvSK6w3rw9WLSKMB1wuwMLSG1+EWWS11WiEwZ5+zVEuxSngBpXWE9mFcz6wCVkAi7
 lhjMnv6+fF5HTfLocT+dqBpjRe1AODsV+mOkFjCwbl4lwcUsCKNzaxeBDs/zY4LpqzzX
 jHtyEA3k8ce7cSM38VCBQv5jjsi7sKGYgcu1U/DXbwtr1LWTJ2XG0NuYBCNkJLYDYVGj
 PL6XVG4f3dAwZT3F1Q9+6UmSW0NpcCGb/PDwcahSpLPJtmaHxIG/HZw+K4qJH600Vjv0
 vXFi6htinI+ap2uziplMX8tyYSK0OOR6+OIcusD5mS3qVEBZJAgahvWVr9pad++R4+US
 8YVA==
X-Gm-Message-State: AC+VfDzTHM9ukrgpISnsW9rzslSQxQT2unuXXaAzPHbkiIkT2flkU2qH
 zJb6sXeajGoYgAboJooNyN8LY2rMRWYLgv37sx8=
X-Google-Smtp-Source: ACHHUZ7K2MwO88dnYrW4hPovmBpKD9E9afT6WvzsJulTNx7HKJxobgo3Kwfpc3axC/6SaIx1JYxJ3Q==
X-Received: by 2002:a05:6a00:a14:b0:647:2ce5:57c4 with SMTP id
 p20-20020a056a000a1400b006472ce557c4mr19913958pfh.5.1684850026152; 
 Tue, 23 May 2023 06:53:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/52] tcg: Add guest_mo to TCGContext
Date: Tue, 23 May 2023 06:52:57 -0700
Message-Id: <20230523135322.678948-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 03ebe58099..181f276b18 100644
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
index aae74f4341..55338ef0d7 100644
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


