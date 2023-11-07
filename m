Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA707E3341
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:51:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9S-0008R6-7M; Mon, 06 Nov 2023 21:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9Q-0008QR-9K
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:12 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9O-0005wW-QF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:12 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ce353df504so3030087a34.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325350; x=1699930150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yATrqhFa0XdJNCrDgxI0k8cWQsLoXGcnoV4EfIA9rFw=;
 b=sybNyylZxTBDZsDb0WKHNor/sx+o/xaFAY/4VSp+D3K2cDePXifK7XlNG9gpd7Fcaf
 SKMd7iYpPYAoVjTk6OeffZtkMVU3+qIwLa6hoDJKoUBm9qvkx57XnBagNHbGO+yyMPTB
 9eXjsiKZqgDd96vjvdEy6fCMopYwJV0EXD0OnDciDfzdFcVnWt8MuONlcmepW9QCuTOg
 Drpq5CZypst2ybaWFsFTfxNcvkIqwQ2Pjl/JLFwJs7JllyJm1WEE3AWlNXZTWb7+ddI1
 6b4uLYOo70bpcMmsRudLI7RNA1Ty0Q3y8v5RDgozzTJ7CkGv3azZ2hUvztKHymr32NI0
 0v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325350; x=1699930150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yATrqhFa0XdJNCrDgxI0k8cWQsLoXGcnoV4EfIA9rFw=;
 b=UYlsDtmZ2LF6TSyWUi8oR0C5nMjYkf1KhHwpIwNuMaiXlpvCzUArUE7FOIQ5YiHukl
 aHOM0Uch3WTrNn/732fiI6+nNEEAAzgapNd+86DJEi8S1SX275jnWSSpjs1S+XKAdAkG
 zukzI5gTpvClBs5I2LLjzVpIWSVWs02r4cn/jpAcHOy2svMyHlyZcVd/m9jHbcNysWgY
 hDWiibvR2M9AR7r7iISpX01aAe9gkE18SWP45oG/3sIywAUluJg0wPMGBS1lIYEu241p
 E5x88Y+NsOJSlPiy+Serqj4A0axvBVUBBRR+CjGrA/vVgDgOMTYBTxkLqeuKCf2dg5GK
 pcJA==
X-Gm-Message-State: AOJu0Yzv1ojyhhMlKrNF90FqDwFRjahOI3qtWcAa+C9rpbHkTfiCQUj8
 EM6QQBCQuvekyqdOBvXaJQ2H8H1Z9d7FiS9o1tA=
X-Google-Smtp-Source: AGHT+IFR8/hJtF7Xw9W3mz9i/FCSSPdsVnXnzY6TcBEhq5Y3M4M4yotKc5bkes+tIO1d78PJdWBmkA==
X-Received: by 2002:a9d:7d90:0:b0:6bb:1036:46de with SMTP id
 j16-20020a9d7d90000000b006bb103646demr30751758otn.30.1699325349806; 
 Mon, 06 Nov 2023 18:49:09 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 32/35] tcg: Canonicalize subi to addi during opcode generation
Date: Mon,  6 Nov 2023 18:48:39 -0800
Message-Id: <20231107024842.7650-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231026013945.1152174-2-richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index de096a6f93..aa6bc6f57d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -372,12 +372,7 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 
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
 
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
@@ -1752,16 +1747,7 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 
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
 
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-- 
2.34.1


