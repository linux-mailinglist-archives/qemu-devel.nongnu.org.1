Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB1D7D7A3A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvpLm-0001sS-QE; Wed, 25 Oct 2023 21:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLi-0001rL-AP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvpLg-000341-Fu
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:39:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so2757775ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698284387; x=1698889187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3I9nizKVluJjWOS7Ntil0G+hzizNGtF2y9jpiXdsHc=;
 b=qoII4+rVqK83dyh3M+HfxJJ4Aolu3vz2hE2qy/CbdrVkeD+JGMHIZUhho0zMFLJnOd
 n6NuR0EBoSH9tIBMRMVvzOhHMpNHnw/sFftgLZUp7fd/buT6kSmf++S8jFFfN1O3+xlz
 mjr1gn8mYVm3PP8vG4hRwQNGtBBNdqRAxipuvkHm2MJDVjueVW6vNtrJkh2kIFEqLdhz
 canUzqao8/IrATkeepWlCpvgb3MdojWDs2oR4n+SJaNhIcwb5iGObDgUbz7MNwkbGagE
 hfvzViNBYjHHYNgStQXExpb7egCTgYkpSCwCNnVjFdb7MZVKCwUszDzma7qBGTeO2NYB
 eIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698284387; x=1698889187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3I9nizKVluJjWOS7Ntil0G+hzizNGtF2y9jpiXdsHc=;
 b=t6xE/SKvksE3s/0p801DofGUDTsVDXnVVXT2yRLSKfN+H50GHwkFH9mG0RLP0G8osr
 AbMGa12MNncYH0yS0w0PKP5VqQaHHGKqap044uAnCR5Y1aUPNjRKCDRCqE49WTFNxRBX
 XqQy8p7KL36V/MPd6wv0jB+Kw2do586R4HxO1PFzea7NqMg57NedloyM7K+TsnRwuzNq
 qcfB8av9BvHQJUK69TfScAx4pGPOcDJb0MoVq/Jv7PAuL3yg/QcHgIW/FFILmY8dsC6M
 bMJVAnxO2/MvgN39KVda/HdZUN1M2ZzZGqvm0M6fUFU86H5qzgAp7lG9U6xyUK+e7yIz
 ppZQ==
X-Gm-Message-State: AOJu0YzOdtvdaowiZ/o9TzrO3Cww/HM427Pp1KnPXjXEmsbAVlCjiRVq
 +iKP40FOQJzvK5b3wczzriGcEUi4cEd8pyCNspE=
X-Google-Smtp-Source: AGHT+IGSQYvDUIcF+ASq3NxMcRn6ReGZfOszVPZRs9GPiqh5nplGK1+jXp0E4QSbqSrEY5kpPwlzXA==
X-Received: by 2002:a17:902:d4cf:b0:1c5:ec97:1718 with SMTP id
 o15-20020a170902d4cf00b001c5ec971718mr18926174plg.6.1698284387204; 
 Wed, 25 Oct 2023 18:39:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y6-20020a170902864600b001c0c86a5415sm9817032plt.154.2023.10.25.18.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 18:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 1/4] tcg: Canonicalize subi to addi during opcode generation
Date: Wed, 25 Oct 2023 18:39:42 -0700
Message-Id: <20231026013945.1152174-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026013945.1152174-1-richard.henderson@linaro.org>
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 59deb3cbbb..3fce9bd8f4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -147,12 +147,7 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sub_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
+    tcg_gen_addi_i32(ret, arg1, -arg2);
 }
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1258,6 +1253,13 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
+    TCGTemp *ts2 = tcgv_i64_temp(arg2);
+
+    /* Canonicalize subi into addi. */
+    if (ts2->kind == TEMP_CONST) {
+        tcg_gen_addi_i64(ret, arg1, -ts2->val);
+        return;
+    }
     tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                      TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
 }
@@ -1354,16 +1356,7 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_sub_i64(ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
-                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
-    }
+    tcg_gen_addi_i64(ret, arg1, -arg2);
 }
 
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-- 
2.34.1


