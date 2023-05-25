Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D22FB71135D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQG-0008NY-4K; Thu, 25 May 2023 14:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQE-0008MV-9D
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQC-0005s4-Lo
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ae557aaf1dso16287715ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038242; x=1687630242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FUzpLs9aS0xZGs3D7oQgohBF0T77jPZ8ssH36+mnmc=;
 b=Nt/44HrWO+tj5qfdoKz2JxGUqeh2uVFDYfVf785bjDSC17JBhJPbFj8IyxyP37acLn
 jflgbwaUXENA+7SrNFGvy27oEEYroZ7LnGyrYi9epOR/Ga267JRP9ER11v9DiQqOPbZf
 3ncMxEu+hCpTq12blUTRqnsQ1X6T5h0oPQS2yvmHbCjNc/CyTBMKTtAo9bK3K+01sAHr
 H1Yu96ktqwaYp7zZYOSG793hzk1fOTt3YLw8rSMDa7qOIgHpqUUUeYXNkpf6O5CEfUgC
 U6qAr6r9ejDA9CKR9yF1dZKEY+b45a6WzYNaUWVbvGNr75PU9Us19U3NfLcnFUWchj4M
 8i7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038242; x=1687630242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FUzpLs9aS0xZGs3D7oQgohBF0T77jPZ8ssH36+mnmc=;
 b=jdWMcq0wuRO3CS9FfM7e7w861arG7IYNATm80y+0vhXoiD7PoN6fYoNNm8r1IVb5Q1
 r2DHlK6I0rcZhgsHDd2yavAof+qxnYaORUDFd4x6xYkAc770dN0qu6GOFfYSbbH0NHMY
 Jz0FkU/wgoLO/ykhsAnwXGMtEI96xyRrdsE6QPXx6JL5KJTc+GRjzufpOYpihNabHGyK
 Zi+RM4anp5oZbeJwz9Hcyltk25KUh+MlzWezIZjSWiVLIAD5n6DjF6yNadiXiVfAUISW
 sJlbIJda/Frgjytx/AJhkeILlFrmLoSdVG1jkZ8i3wLzyIblyyiEu2maU+a7X6VdLoB6
 7+mw==
X-Gm-Message-State: AC+VfDxKzEITpx6VOAVeWTtDUGlw9Ej/VSn7XF+mVCrTbUAcyR5gA9Nh
 EV3qVXtkkRKaTS5wIsV3UnVsAxZ9bHHV2lUnazw=
X-Google-Smtp-Source: ACHHUZ40EXjUlL/HZSaRgiWsZVxAe+F8pVQWH14AmCxBS/JpUPvJMnzzH7URVpp0WqfiSbQznmgkmQ==
X-Received: by 2002:a17:902:e887:b0:1ae:8e80:ba89 with SMTP id
 w7-20020a170902e88700b001ae8e80ba89mr2969602plg.0.1685038242029; 
 Thu, 25 May 2023 11:10:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/23] tcg/mips: Split out tcg_out_movi_one
Date: Thu, 25 May 2023 11:10:18 -0700
Message-Id: <20230525181036.1559435-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Emit all constants that can be loaded in exactly one insn.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6f03b44ac0..bbff510c46 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -510,20 +510,34 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     return true;
 }
 
+static bool tcg_out_movi_one(TCGContext *s, TCGReg ret, tcg_target_long arg)
+{
+    if (arg == (int16_t)arg) {
+        tcg_out_opc_imm(s, OPC_ADDIU, ret, TCG_REG_ZERO, arg);
+        return true;
+    }
+    if (arg == (uint16_t)arg) {
+        tcg_out_opc_imm(s, OPC_ORI, ret, TCG_REG_ZERO, arg);
+        return true;
+    }
+    if (arg == (int32_t)arg && (arg & 0xffff) == 0) {
+        tcg_out_opc_imm(s, OPC_LUI, ret, TCG_REG_ZERO, arg >> 16);
+        return true;
+    }
+    return false;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg)
 {
     if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
     }
-    if (arg == (int16_t)arg) {
-        tcg_out_opc_imm(s, OPC_ADDIU, ret, TCG_REG_ZERO, arg);
-        return;
-    }
-    if (arg == (uint16_t)arg) {
-        tcg_out_opc_imm(s, OPC_ORI, ret, TCG_REG_ZERO, arg);
+
+    if (tcg_out_movi_one(s, ret, arg)) {
         return;
     }
+
     if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
         tcg_out_opc_imm(s, OPC_LUI, ret, TCG_REG_ZERO, arg >> 16);
     } else {
-- 
2.34.1


