Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BE270DDF6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMq-0000t8-87; Tue, 23 May 2023 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMm-0000dx-7n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMk-00019A-GM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d41763796so2898780b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849673; x=1687441673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpw127Ta4vkSOaFTONTeoYtJ2r7Ne1NfMPdNp5TPUr4=;
 b=tssVLQie36mMRrgMz2fQzeO84WWvyi/xL9+zIaxJClTgvaFW+5E3KKy2vwxFUNOzOk
 EVOiT/tC9YTPNfPuu4deHC3qxNpXxLtR9UfvtcsoCGgU8jRiMvnoH8USF5tNJjzu0s/T
 w/9YppwLkAORQB5qMFVMFlg6tEk5c6vVtQWa4SmRv5qzEcXtgeA0ccVLnUytdKCtc+nv
 JXhATby9QSMoyav/7un9hPe6FEmKfsa4P2w0No3aTJKeihFXhBi4XlDQzHx7MgZDMjpj
 XMqV+zrTDtzxlrS3fn5t81Rx+/mJWenF0HLdu2QnhENdZYN2xjeQq+t3B6WmDnQHMh2l
 PokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849673; x=1687441673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpw127Ta4vkSOaFTONTeoYtJ2r7Ne1NfMPdNp5TPUr4=;
 b=aM72vIqR6ogq5jXG4YpPAw7hn7sI9yOqBggfxpQf5ih5C7H3fVM1nDV+Nmv4si9EXX
 qCxZjtgGLePha032GvWBWK63vqaFJX0ssIRpp9WWFl/BDq4VUgOnHzDY/sbrFqc57UWF
 RXnuXuwl6h7ZLQiOoyXnlemDdzzM8JnonK6gshKpCdpUztcjq1quppsn8y/sWKiDFXcV
 gUyXMbAuo0bQFbDl9KNqWz5jpXwqiKRJUpRNgH/tFxQbxrw8hSCG6yVUFJs+wAXPu9wE
 Hz7QwVxs7OUe5IWu83xfzZ9ko0wrrM2f91k6dy2hyljxLf8N81EdmqRvCdxqWt6J+n0+
 rePA==
X-Gm-Message-State: AC+VfDyEIYcLlTMfbK+tKRNjb8dU3lHQHQUrQ/ehr5cWmvdE36rgA/ri
 PYkSweqFMLMPH2VbGEGugQ32eb81X4Dniw27dNo=
X-Google-Smtp-Source: ACHHUZ76O1wpYdq6bzqBk05lUkcXGyeatAdAHKFl1eNR8XuVb/W8eLdyU4o1hWdNl2fHKTVNWzajEA==
X-Received: by 2002:a05:6a00:2484:b0:64d:5c4c:7e20 with SMTP id
 c4-20020a056a00248400b0064d5c4c7e20mr10703963pfv.26.1684849673220; 
 Tue, 23 May 2023 06:47:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 21/27] accel/tcg: Eliminate #if on HAVE_ATOMIC128 and
 HAVE_CMPXCHG128
Date: Tue, 23 May 2023 06:47:27 -0700
Message-Id: <20230523134733.678646-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
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

These symbols will shortly become dynamic runtime tests and
therefore not appropriate for the preprocessor.  Use the
matching CONFIG_* symbols for that purpose.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h  | 2 ++
 host/include/generic/host/atomic128-ldst.h | 2 +-
 accel/tcg/cputlb.c                         | 2 +-
 accel/tcg/user-exec.c                      | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
index 80de58e06d..58630107bc 100644
--- a/host/include/aarch64/host/atomic128-cas.h
+++ b/host/include/aarch64/host/atomic128-cas.h
@@ -37,6 +37,8 @@ static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 
     return int128_make128(oldl, oldh);
 }
+
+# define CONFIG_CMPXCHG128 1
 # define HAVE_CMPXCHG128 1
 #endif
 
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 46911dfb61..06a62e9dd0 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -33,7 +33,7 @@ atomic16_set(Int128 *ptr, Int128 val)
 }
 
 # define HAVE_ATOMIC128 1
-#elif !defined(CONFIG_USER_ONLY) && HAVE_CMPXCHG128
+#elif defined(CONFIG_CMPXCHG128) && !defined(CONFIG_USER_ONLY)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_read(Int128 *ptr)
 {
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9cb0b697d1..0bd06bf894 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -3038,7 +3038,7 @@ void cpu_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
 #include "atomic_template.h"
 #endif
 
-#if HAVE_CMPXCHG128 || HAVE_ATOMIC128
+#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1e085b1210..dc8d6b5d40 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1371,7 +1371,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #include "atomic_template.h"
 #endif
 
-#if HAVE_ATOMIC128 || HAVE_CMPXCHG128
+#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
-- 
2.34.1


