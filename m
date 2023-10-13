Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B87C8C1E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgE-00014F-Kv; Fri, 13 Oct 2023 13:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg7-00012B-1F
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:23 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg5-0005Y9-L5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:22 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c4fc2ce697so1565563a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217020; x=1697821820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6ypWKYmP3E0vSS+zdR/mRhAnNRJOT7ENlr0UKfEKr4=;
 b=S0f9JsuOtosawzF3qrXkxTbcA7TuGVMP/hf/BWEuUfcu2mHAiorMSU35QOGg26I2CA
 8cxjPynzuGVIxRR1+W6CbvEmnDm7H068Hz4tUCRj2WhUlWkY3H6GBLERs4TtASceFO0L
 1eg7aZZ2uG5WrXaD74JwFX187jnS7W/9N9p2CnvDjvUah01pL4fuapMSkrf8oXEzpowm
 64cP0tAdUOG0hBll3ycb59CbIz7bSf+LT7TuNd89MlLVjkfDMXmDlJxCmTWu3o24ONAY
 RAXXWXkZeVMMOvUlSYi6f6se8ZSLYqJUNv4lVmupWLlQsUPh3+10uO4X/d9GYK0nlpe2
 D8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217020; x=1697821820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6ypWKYmP3E0vSS+zdR/mRhAnNRJOT7ENlr0UKfEKr4=;
 b=LG07yoJCFI5pMPOBcmleEZxG7ZjRlW8upWfPiJ08QPJkec91GxR+mPt4IV+kvB0UId
 AmTRz/Zl8Ni9PJwQoGT2IcKwGPw1ccOx+pQehatQKNQizDgCBk/ch7bNWScCa7UAjOHX
 cU7foue8WLd3STBwyPYU2Jgu/7r8FCSlKeR07d1CMn2SVvjBqF6NWp2SAi1XyzefSITk
 4DhyQOXQazDPcbvFp4BgDE1+3HTkyQdWhM2gGmZOW16u3IwIo2VNlHV6YtkAx8AbW4TA
 eJaeLd7iHs7F6AV1qQaA1gUxXaNAzyjjZVqDNpsEdIJO/NopAWQdLiVh9BZnOJo/I7wD
 w/Kg==
X-Gm-Message-State: AOJu0YzcpDlu4XwE7T88C4EbdHBAU7gMHN7ugHcxdHr2CCkkjW+6/ftM
 ERjKGdN1r2CKb0mEgAB+Z5wbtkqOHlSHRpfoP8o=
X-Google-Smtp-Source: AGHT+IEo0jbRzZClBd4pMsYRimhqWoDWnZ+Bfo8qN5N10VWX17JdEoE2CyrOpL2MVCbmabc7fdRN6w==
X-Received: by 2002:a05:6830:12d0:b0:6b9:8357:6150 with SMTP id
 a16-20020a05683012d000b006b983576150mr28231659otq.35.1697217020533; 
 Fri, 13 Oct 2023 10:10:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 07/13] tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
Date: Fri, 13 Oct 2023 10:10:06 -0700
Message-Id: <20231013171012.122980-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 720f92ff33..6337b1e8be 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2593,6 +2593,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 static void tcg_out_goto_tb(TCGContext *s, int which)
 {
     uintptr_t ptr = get_jmp_target_addr(s, which);
+    int16_t lo;
 
     /* Direct branch will be patched by tb_target_set_jmp_target. */
     set_jmp_insn_offset(s, which);
@@ -2602,9 +2603,15 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     if (USE_REG_TB) {
         ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
+    } else if (have_isa_3_00) {
+        ptrdiff_t offset = tcg_pcrel_diff(s, (void *)ptr) - 4;
+        lo = offset;
+        tcg_out_addpcis(s, TCG_REG_TMP1, offset - lo);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, lo);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
+        lo = ptr;
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - lo);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, lo);
     }
 
     tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
-- 
2.34.1


