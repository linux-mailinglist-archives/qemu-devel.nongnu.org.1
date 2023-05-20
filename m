Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE870A912
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQV-0003wK-4l; Sat, 20 May 2023 12:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQG-0003ja-So
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQA-0003CN-0p
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae5dc9eac4so26547465ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600025; x=1687192025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSXjZgIGjllrMA9XNuenvDLTD+dbMABgvhmoFNTKWzQ=;
 b=cR0s5s+lF8pjYqJZrBb0EyoeLMRd5TCsLMYTNLhJXgLPlnvZPSuDrrkQj5/hIIHAva
 S0idrUSUl5f8iQ6O/DLbYcfJiNloEKS/oLNITSHc5Lca+3HXraAlAS2M65D3l+iWPA2e
 m9rc5Z8hnRX5dvbtEBAM1RftiwwwFk4bxY1J3rcOBv4JKwgx2tWM72Iakxx/e06rZrUJ
 GHrjtX7lRul7/eUuThAgxXGUsLSzlFTA78pveZO96VJ5MIkX3HMkLeinEtQszQV8cCNg
 LL8PYtwqqmho9jUZrQ/f+oWuK0/M8a8rVEySLD3xxWcqSQIAwWKVzfeUNKIIQobExENH
 SyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600025; x=1687192025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSXjZgIGjllrMA9XNuenvDLTD+dbMABgvhmoFNTKWzQ=;
 b=YxTvbEPDWtaBZzmEQ78KnUC3DdstcQdDVuCHiwfLewUV/Atsl0WkKOz+1++qLvt/X2
 vMHBDvce9Y4lTART8Omn95PZSK4TDkcTOTO/3ZBQJF85vICFEUjj9gnDjSrE4UFN2FsR
 7EsYV+Qo1LvkjOcXumygnskKffkW9pU9NmxuaR1zNnC43f+iAVN5MlWqgqlc7N2ZF33r
 fOjFxZLnruXJzi/1ihTFfWl95enJ9LhcvSiRcKlDx+cbwPwFhrPNZCxpDFjbOmYjKcEh
 x/6xhwJfkON/QDVJVf9rrpl+tFSor4tR6J7Fg2eLSZwvJjQppc/4xUd9EVBmm2GPvP6a
 dz1w==
X-Gm-Message-State: AC+VfDzfgAkx0bV2aR8Y5SUFTEZHk2ngxBg6j3pNrCimy6a0ixsX48tq
 DHv4RBa9XeUwijRiFF9Fne4/pAav6y9ep3u7GCw=
X-Google-Smtp-Source: ACHHUZ79+l94Iyt5CCOJvTXL+nk7mDHF6Lr3c+5DzYrgMAfRr3e3CpTe0Qkfq0gKmfhc+n6d6uNqUg==
X-Received: by 2002:a17:903:1210:b0:1ac:b363:83a6 with SMTP id
 l16-20020a170903121000b001acb36383a6mr6381627plh.17.1684600024836; 
 Sat, 20 May 2023 09:27:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:27:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/27] accel/tcg: Eliminate #if on HAVE_ATOMIC128 and
 HAVE_CMPXCHG128
Date: Sat, 20 May 2023 09:26:28 -0700
Message-Id: <20230520162634.3991009-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 33f365ce67..ff0451d1aa 100644
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


