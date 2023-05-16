Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCA7057C0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yo-0006jf-IY; Tue, 16 May 2023 15:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yl-0006il-CH
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yj-0002rN-R7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-52079a12451so10504194a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266128; x=1686858128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03Saz/Ae1+wLFRqHrvpgcnIMM8UibULuCXSb3tQDXYE=;
 b=qtT+PdeqQZ8Q4G7WB6SKOklaEmeHqzjTfL4HvBwgX/RJKSS0Z8Fc3CjqB3mV1wpL4z
 aVxUBck0eZ4uvvuKkT96k2s4xYngTXJce2hRQHZKbd4wZRjqOCg7BAXscHCSCfHuh72w
 BO4XcZxBnV+rJZgNOkD1FkHtAYYQdnTP9Mz2Pf1nVgg8V3WZhOeuURkXonheQ1VPbjm4
 KlG0c+vadRegMVtIdRB1ixAAavlq62OMABsgBNj7uUgkD0WiDeGL4HBMEn4a7vit+y3w
 6V2075D8nUlxCMdvAWU/c8FB0BkzDWT7zjVcPsEAco5L//IOhyvXng/37zGgieDtF+MN
 7T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266128; x=1686858128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03Saz/Ae1+wLFRqHrvpgcnIMM8UibULuCXSb3tQDXYE=;
 b=bbg9SHQmyx/GZcWD1CHD7L9PLHw91ydKt01sHfsEXSjKSNxwnNugl+n6FYvP4Aquj2
 ADgMVNPomYTpp3B4FjcjE8tmcWrp2lwOqoXBcckWESJYt1jWv2fYjkUEisgsSXAhz5P0
 SkMChtgxbRqeUfGfUW57+n227FaLn64XTGXw9us6o13rZNsr6U9EydGpkGxWfXvKDiKm
 MscI+P3W6N3/UBS3oXQFERb13M6KAUKj+Nz0ObL2buGcixjN4aczu6Z90L5MOWlje4e4
 lOxglBzwItkd4c1PTmMkcTy9V8KUtZIcIQICWpJ7bJu88nELpO/NWuWJXtfGWZK/WROI
 Q7Pg==
X-Gm-Message-State: AC+VfDzmnhrvbDJns8FHeg1F78mgLkN4Wa5j0ZkSZvEFu56b8sTS7Zm6
 yMs3n5+rXY/Ydx81W4PoB6ktRgMD4PAJMn5XNww=
X-Google-Smtp-Source: ACHHUZ7D2SvqUjlNiAHRUc2r+8J5S6vCVDl7XMRFv8BP+Y0OVK6VIpS22EJS59Csr5ydj4Wfkk0GSg==
X-Received: by 2002:a05:6a20:7354:b0:101:1d1d:43a4 with SMTP id
 v20-20020a056a20735400b001011d1d43a4mr34273036pzc.15.1684266128632; 
 Tue, 16 May 2023 12:42:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/80] target/sparc64: Remove tcg_out_movi_s13 case from
 tcg_out_movi_imm32
Date: Tue, 16 May 2023 12:40:49 -0700
Message-Id: <20230516194145.1749305-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Shuffle the order in tcg_out_movi_int to check s13 first, and
drop this check from tcg_out_movi_imm32.  This might make the
sequence for in_prologue larger, but not worth worrying about.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 15d6a9fd73..2689599fd6 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -407,15 +407,10 @@ static void tcg_out_movi_s13(TCGContext *s, TCGReg ret, int32_t arg)
 
 static void tcg_out_movi_imm32(TCGContext *s, TCGReg ret, int32_t arg)
 {
-    if (check_fit_i32(arg, 13)) {
-        /* A 13-bit constant sign-extended to 64-bits.  */
-        tcg_out_movi_s13(s, ret, arg);
-    } else {
-        /* A 32-bit constant zero-extended to 64 bits.  */
-        tcg_out_sethi(s, ret, arg);
-        if (arg & 0x3ff) {
-            tcg_out_arithi(s, ret, ret, arg & 0x3ff, ARITH_OR);
-        }
+    /* A 32-bit constant zero-extended to 64 bits.  */
+    tcg_out_sethi(s, ret, arg);
+    if (arg & 0x3ff) {
+        tcg_out_arithi(s, ret, ret, arg & 0x3ff, ARITH_OR);
     }
 }
 
@@ -426,18 +421,18 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     tcg_target_long hi, lo = (int32_t)arg;
     tcg_target_long test, lsb;
 
-    /* A 32-bit constant, or 32-bit zero-extended to 64-bits.  */
-    if (type == TCG_TYPE_I32 || arg == (uint32_t)arg) {
-        tcg_out_movi_imm32(s, ret, arg);
-        return;
-    }
-
     /* A 13-bit constant sign-extended to 64-bits.  */
     if (check_fit_tl(arg, 13)) {
         tcg_out_movi_s13(s, ret, arg);
         return;
     }
 
+    /* A 32-bit constant, or 32-bit zero-extended to 64-bits.  */
+    if (type == TCG_TYPE_I32 || arg == (uint32_t)arg) {
+        tcg_out_movi_imm32(s, ret, arg);
+        return;
+    }
+
     /* A 13-bit constant relative to the TB.  */
     if (!in_prologue) {
         test = tcg_tbrel_diff(s, (void *)arg);
-- 
2.34.1


