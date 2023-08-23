Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873778617B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOf-00008r-6E; Wed, 23 Aug 2023 16:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008RE-8F
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOW-0005Wu-Rt
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso37596335ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822238; x=1693427038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrRdZQsCRn1Wwa7rMBULMSKKjtejp0k93c02stP4yQw=;
 b=ICBhFU/jmx8oy3yv4d7pZJ95QTqltuUzHO/Vf7VNmzrijl6sLXCTnWqAw0Hvssu0DF
 H43OweOF47gb7+DyBxx4PmqdQTGQtB8fUXu/t8f6Eq4volxcgktZwOLQq59FR8MULxUo
 xc8XKoDMZ0KweRDUqCn/8tNZAS5WG1NiSSc3FmUmT33FIl6/F7lXr3fjTKj4HzlG8+oj
 zefn53n00NlG5JSjgFCiRDzOukJ2HucF57PTP1HHeJyDRk5NH8PVfjvDAqBpDqfLT9CA
 mfQwMGN+pQNBOQNpvd4i2KdB7FGHsZJlykTtM1B7StMGCwopmB8iLdmV01360AmmTYyu
 +yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822238; x=1693427038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrRdZQsCRn1Wwa7rMBULMSKKjtejp0k93c02stP4yQw=;
 b=lGKXdXexJiZ8V+UZo7sOjz1skC3ACmilt6pt2SA7DxBlikqrmmOeqM3K/rkjjHY0LA
 b+IqI9GvWIPEUXlMPUefEyuL/0NpQN6gE7W2QNw7I4PnAs1bOUsgfFsXBtZZiY9dRAz2
 v8cln6mW0Qhhv1/byBMsOBb3Uujfdb7NkBKhXN+ByZKLoU2is/UrOYAZh4exC6HMRQzI
 MvdiBqLSEx4m1GNxoscF44uqsC11LM0ddTiK+X8xy3x1iuG9bwaaU/wSoJ4BEVieTNz6
 vHm16BSZrBNkEKSDDhOLYpjY5XsPRqk28/4WPXCsc3gTBDKX/HOxrHqs41GnIqdm808p
 U94w==
X-Gm-Message-State: AOJu0Yx+fqaIDEuF3tPUi7lx7D79CQj+g7t4aGOXq4xSXi4FrvRq3owa
 exVHszd/Q9usouww/hfehIB9MIn7myYG97la0Jg=
X-Google-Smtp-Source: AGHT+IHB0R7lD7nqniL3E9xzngvcjX4Sinl1Yx554BF5zhwEBDN27056MaLxnnmOYIcTgmLXFiu16A==
X-Received: by 2002:a17:902:ee4d:b0:1b8:ae24:c207 with SMTP id
 13-20020a170902ee4d00b001b8ae24c207mr10375307plo.68.1692822238387; 
 Wed, 23 Aug 2023 13:23:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 33/48] tcg/i386: Merge tcg_out_setcond{32,64}
Date: Wed, 23 Aug 2023 13:23:11 -0700
Message-Id: <20230823202326.1353645-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Pass a rexw parameter instead of duplicating the functions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 33f66ba204..010432d3a9 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1527,23 +1527,16 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_setcond32(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg arg1, TCGArg arg2, int const_arg2)
+static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
+                            TCGArg dest, TCGArg arg1, TCGArg arg2,
+                            int const_arg2)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, 0);
+    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
 }
 
-#if TCG_TARGET_REG_BITS == 64
-static void tcg_out_setcond64(TCGContext *s, TCGCond cond, TCGArg dest,
-                              TCGArg arg1, TCGArg arg2, int const_arg2)
-{
-    tcg_out_cmp(s, arg1, arg2, const_arg2, P_REXW);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
-    tcg_out_ext8u(s, dest, dest);
-}
-#else
+#if TCG_TARGET_REG_BITS == 32
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
@@ -2568,8 +2561,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
                        arg_label(args[3]), 0);
         break;
-    case INDEX_op_setcond_i32:
-        tcg_out_setcond32(s, args[3], a0, a1, a2, const_a2);
+    OP_32_64(setcond):
+        tcg_out_setcond(s, rexw, args[3], a0, a1, a2, const_a2);
         break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond32(s, args[5], a0, a1, a2, const_a2, args[3]);
@@ -2721,9 +2714,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
-    case INDEX_op_setcond_i64:
-        tcg_out_setcond64(s, args[3], a0, a1, a2, const_a2);
-        break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond64(s, args[5], a0, a1, a2, const_a2, args[3]);
         break;
-- 
2.34.1


