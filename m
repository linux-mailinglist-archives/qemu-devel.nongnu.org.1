Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0B7E33F3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRW-0004NU-8w; Mon, 06 Nov 2023 22:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRR-0004Ca-Qi
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:49 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRP-0001Np-Un
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:49 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so628431a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326466; x=1699931266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZCnWYkK+U1pZwjN+BpVp2KIVyq7cUxKa4TKDY4mlg8c=;
 b=h4Wl1UNf/GB2EQsmTOsWyMxokYzZIkCL+ngkjd4TqmUY2lts+szNK354YA+ZOZJPxN
 ZFyGJnfUgCIM4fMap0krORuka3SQfr48dSJSryQ8u+Zwxw69lvjDxIHzKWGPndIrEb4I
 BCRR2e6Fe4UzZt+sOoa3Sm8jO81EYK+v4lZRkoRljzw9cIN4HL5RoR4l/4E1zIdftPTR
 fHbemJ8fcfFfpQLqEpUn03OXL53H42pVEci5SzTM/U8vN7fFK2jG5w2vVg5s02fXjdqN
 7PFz3IqHQSjDkaJ48go8orv3MjTXz4dLrEeyQqGa5JYeRI3ZfZmUR/Y9KAHfpsnBZqR6
 N5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326466; x=1699931266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCnWYkK+U1pZwjN+BpVp2KIVyq7cUxKa4TKDY4mlg8c=;
 b=Kc5IrSNaWQl4O3gknqDP6P33OP0gkkooNazfmyPRSg4tneOxjLZCslAL+IAC5Y3qQV
 wPY5z/LKGgQ3ti0HxpDZYwQJtUQjp2Cc3ya5hI4IvKzUk/6mXW2HiLQQN1X1/AiVJbkX
 OGA4BvT6FbVbPNjhlh/1T6+SHgfdf/sIq7zDraTahNOochvu4Lp7kvAkIQgtNQIJW6cS
 cemsuGztMfES7nIcz5t7zF9H0JnvzY2ZP0ZVmo2/qMqKasO2oSI8WF2PS95q/NBL3VRY
 XQrBJfr5ITL4V8H8gYvbudEBxtbgIj8zsULscyPemXUmIQnGd6flROboNoFB2g401NDD
 K6LQ==
X-Gm-Message-State: AOJu0Yxv8gGV9vr7yKJM4vVedFPuYWk7rnHztY+SXyFiXT5EPmvPrjRI
 IGTm9gVeG9A+zTnYPC5FMoqY9Pm6SHGVJHfrW5s=
X-Google-Smtp-Source: AGHT+IEq/ByblSMRIUMUL8aOPVNO9VyHv8+CMisSBTT6Xj38vzrDnpmAeCS1f7dlELYTyH/Yslt1UQ==
X-Received: by 2002:a05:6a21:4841:b0:181:8e2:ba3c with SMTP id
 au1-20020a056a21484100b0018108e2ba3cmr22231767pzc.19.1699326466699; 
 Mon, 06 Nov 2023 19:07:46 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/85] target/hppa: Implement CLRBTS, POPBTS, PUSHBTS, PUSHNOM
Date: Mon,  6 Nov 2023 19:03:33 -0800
Message-Id: <20231107030407.8979-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 2 ++
 target/hppa/translate.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6f0c3f6ea5..ba7731b517 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -381,6 +381,8 @@ bl              111010 ..... ..... 101 ........... n:1 .        &BL l=2 \
                 disp=%assemble_22
 b_gate          111010 ..... ..... 001 ........... .   .        @bl
 blr             111010 l:5   x:5   010 00000000000 n:1 0
+nopbts          111010 00000 00000 010 0---------1   0 1    # clrbts/popbts
+nopbts          111010 00000 ----- 010 00000000000   0 1    # pushbts/pushnom
 bv              111010 b:5   x:5   110 00000000000 n:1 0
 bve             111010 b:5   00000 110 10000000000 n:1 -        l=0
 bve             111010 b:5   00000 111 10000000000 n:1 -        l=2
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 897b44d7e3..91249d89ca 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3782,6 +3782,12 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
 #endif
 }
 
+static bool trans_nopbts(DisasContext *ctx, arg_nopbts *a)
+{
+    /* All branch target stack instructions implement as nop. */
+    return ctx->is_pa20;
+}
+
 /*
  * Float class 0
  */
-- 
2.34.1


