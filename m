Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3787ABC14F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 16:51:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1py-0000SR-OL; Mon, 19 May 2025 10:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pv-0000QG-32
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pq-00012O-Pr
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so31117415e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666280; x=1748271080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BygWdv7/tDO5ALXb8h6QMuJ2wk4/0l16+7gCvaB1RJ0=;
 b=foX1zpYb7JmLIustiVUDnnEEzJWAJb4n8bVqVnLlguNnOfO5ewx0WslKt521In+l/b
 6TK/j3DrI2t2RNDwWd4YQrRw+RFsyK2kSxXwoUJgqtPZHh1J//imsa0iN9Nbq1BV5oPv
 tZ6l3WIUdMrggSwXPUuvc8pRG1hiRZ8r/NZ8hDJ3IzNcy01n3jOpO5I+OyvGAM1ac4/N
 YFXWsduU1gz6VwfrSTtilbrU8lXJw1RRb99QSeTeWF5onyH8LQlzXup+rdxMyJNmJU9p
 WTusoCl+w/prJDkO+qRQlwRzyJ3zdeJQ7YYVHf1mBz3oiwvQvDoF0VO8lw5MEbLoZuYu
 5TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666280; x=1748271080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BygWdv7/tDO5ALXb8h6QMuJ2wk4/0l16+7gCvaB1RJ0=;
 b=pjgeIPsmFO4WtDNozq+GjqBqJGNZveF/MlqfVjuK78jR4wbMGpXPLBaK6cGoEkXU+S
 rNFuHny3d4e0fA8AtGYFA/TSR609VndMDkyqrIdo4fO5e4Hsj2WLKa6w8UKhadPTp1+2
 +ck7D6D86mXSuOD4jQNhylMzkNNtXR4W9jGemfBVqn+aUAAQtGs6rI1oh5nxr/02J1xK
 Adisf2pijd8f/Txq4MfnJmCK6YgILDftwYajY6SNn0V6URZTrXHp95yPkUm+hq5cbYcA
 8VEGtOdUOakXnVt1Jl5+sWJMbp2r5Qva230fctDYzkDXyyiTKSzUKp6i+ZgcbKKe8Xuc
 9X6Q==
X-Gm-Message-State: AOJu0Yw5ZZFukmduMt96z/MMFYK7+76SrxMo+8xPEHABvifPizf5U6Gl
 9JtpHYVz/cd+pI174Cm9tT8ddlKe9yYPa9X3QrDaLw1WZsy+YvDlnSThpfN734cDZ8VwKOJHIfz
 lY+y6
X-Gm-Gg: ASbGncvFHiT5nte9ip/cn+5cWhuI3px3VIIfWAfOR+1S83JPiK9D9Sodb4JMwGiOeSD
 rOJybmgQQ9e/hPP4AHnJI/JafAi8bW259i51MaubiKFehF5DLe26FkY4L1SphTDI4UNaLHx3xsk
 20BAtgMLb3xySwd7NtCPs11UG9S6cltBcq/2d5evf+BHPCXGFdtYLQ37niJrpWNrwqNVJE7T9h3
 rjAKTtpCpnxVzkK5WwrnHBMYOEPaAW62s+Rq0cEJqtKt/nbPs105ZI0Uz7sgBDqBwBbezn+26b6
 nbE4h31IZtbvBpT5wP4Lo1Er+Rda9SlG2phgpTdkDoW+XEi+ZCQKmcljDw==
X-Google-Smtp-Source: AGHT+IEPHbFdWY2MqGCilpqVun03+uRqCtsMlt3RbVkuFn0b1G4O/dFiaZh9aJhQ0wLhnNessbm+ug==
X-Received: by 2002:a05:600c:a42:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-442fd6276f7mr120108075e9.14.1747666279767; 
 Mon, 19 May 2025 07:51:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd50b9b2sm145672035e9.12.2025.05.19.07.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:51:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 3/4] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
Date: Mon, 19 May 2025 15:51:13 +0100
Message-ID: <20250519145114.2786534-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519145114.2786534-1-peter.maydell@linaro.org>
References: <20250519145114.2786534-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The x86 DE bit in the FPU and MXCSR status is supposed to be set
when an input denormal is consumed. We didn't previously report
this from softfloat, so the x86 code either simply didn't set
the DE bit or else incorrectly wired it up to denormal_flushed,
depending on which register you looked at.

Now we have input_denormal_used we can wire up these DE bits
with the semantics they are supposed to have.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4732b718129..b3b23823fda 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -215,7 +215,7 @@ static void merge_exception_flags(CPUX86State *env, int old_flags)
                        (new_flags & float_flag_overflow ? FPUS_OE : 0) |
                        (new_flags & float_flag_underflow ? FPUS_UE : 0) |
                        (new_flags & float_flag_inexact ? FPUS_PE : 0) |
-                       (new_flags & float_flag_input_denormal_flushed ? FPUS_DE : 0)));
+                       (new_flags & float_flag_input_denormal_used ? FPUS_DE : 0)));
 }
 
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
@@ -3254,6 +3254,7 @@ void update_mxcsr_status(CPUX86State *env)
 
     /* Set exception flags.  */
     set_float_exception_flags((mxcsr & FPUS_IE ? float_flag_invalid : 0) |
+                              (mxcsr & FPUS_DE ? float_flag_input_denormal_used : 0) |
                               (mxcsr & FPUS_ZE ? float_flag_divbyzero : 0) |
                               (mxcsr & FPUS_OE ? float_flag_overflow : 0) |
                               (mxcsr & FPUS_UE ? float_flag_underflow : 0) |
@@ -3270,14 +3271,8 @@ void update_mxcsr_status(CPUX86State *env)
 void update_mxcsr_from_sse_status(CPUX86State *env)
 {
     int flags = get_float_exception_flags(&env->sse_status);
-    /*
-     * The MXCSR denormal flag has opposite semantics to
-     * float_flag_input_denormal_flushed (the softfloat code sets that flag
-     * only when flushing input denormals to zero, but SSE sets it
-     * only when not flushing them to zero), so is not converted
-     * here.
-     */
     env->mxcsr |= ((flags & float_flag_invalid ? FPUS_IE : 0) |
+                   (flags & float_flag_input_denormal_used ? FPUS_DE : 0) |
                    (flags & float_flag_divbyzero ? FPUS_ZE : 0) |
                    (flags & float_flag_overflow ? FPUS_OE : 0) |
                    (flags & float_flag_underflow ? FPUS_UE : 0) |
-- 
2.43.0


