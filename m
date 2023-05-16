Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D182705805
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eJ-0002Uz-8L; Tue, 16 May 2023 15:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cK-0000O9-HT
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:53 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cE-0003ls-7a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-24df161f84bso39447a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266344; x=1686858344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxwdqiALkoPj7zCiSvoG+AA0MPWC8VroDhK0qwZ8X3s=;
 b=K7iw/zdQrBnI8GDVFlyQx6tBh+Un2TcFnqQxCv6RsR8WjJbUaCdj+TX1fXibI/zqJY
 aPARHzdP46BCxbj8nDdvdYliXHXlCOH9gIPuxKI/YfbWHlEFyD/Hniu/UJgj7aga4tTV
 V+CuucMQYCgb1S9nPt2bBdmK5F42+yYpeN5vbzqbpZzCPwojXCB9dMH6IKXbLZBbU18M
 V8uOXnVuwHDEL4vSpujZ12rAsfJAplHu9TGph/mI+v5ZyVR6RcfLjbTVs7PnN9ZeQGTx
 ULUxcASSCeauZ64ZcwhuDRHpwijeAwDqYXEKVb6aRwmp1auuO5NIDUz/jRklkr8j+kDR
 4Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266344; x=1686858344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxwdqiALkoPj7zCiSvoG+AA0MPWC8VroDhK0qwZ8X3s=;
 b=VgLgXAyUqFg6qu3TDTmkiAgXbv6nLZXoXRaNXPfLswWirseXs0QW46HDUduiLjb0dV
 FtgaKrEu22x9Au+yI55SGwWglPvIhiwN5pQrblurQ91E+3Rc3z3K/q7Y3XyRFqj/bjKN
 At+6Yz2DHVtyBpICvvmq+8NZcEpGEQDczp/cdcDhZsLBtBPaB8dtMdiLKHvn02eoNBhO
 ztL09tJaD5VjrMa26u6wLXoXhkUWNhGp9ykR4Y504peOT/bjdmb65PbxR/vOEke7+CpM
 Yy06qdntWgFfY1RrTgx+YQVMqlbJGnvhecsNYNODFF/yuRRkG1nren/JjmnTjGki0K0D
 4QyA==
X-Gm-Message-State: AC+VfDw77S3X56UyEWyxuZ62IoBVxy++hcq3Cv3uMYeQfv30aYOzqxBe
 qTiW+716RMrU9+UZ2ZUElU4ow/r7PncIu/N7Ov8=
X-Google-Smtp-Source: ACHHUZ5tkTCAFMYR7AwtkQpELeyYQ+CYqcWzi8f2qAn5txSzsBLoI+Y7M/ruA/epm5ySc6sWp7jXUA==
X-Received: by 2002:a17:90a:4611:b0:23d:3549:82b7 with SMTP id
 w17-20020a17090a461100b0023d354982b7mr36673367pjg.46.1684266344398; 
 Tue, 16 May 2023 12:45:44 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 65/80] tcg: Remove TCGv from tcg_gen_atomic_*
Date: Tue, 16 May 2023 12:41:30 -0700
Message-Id: <20230516194145.1749305-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Expand from TCGv to TCGTemp inline in the translators,
and validate that the size matches tcg_ctx->addr_type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h | 184 ++++++++++++++++++++++++++++++----------
 tcg/tcg-op-ldst.c    | 198 ++++++++++++++++++++++++++++---------------
 2 files changed, 267 insertions(+), 115 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index e556450ba9..35c5700183 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -858,56 +858,148 @@ tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv a, TCGArg i, MemOp m)
     tcg_gen_qemu_st_i128_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
 }
 
-void tcg_gen_atomic_cmpxchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGv_i32,
-                                TCGArg, MemOp);
-void tcg_gen_atomic_cmpxchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGv_i64,
-                                TCGArg, MemOp);
-void tcg_gen_atomic_cmpxchg_i128(TCGv_i128, TCGv, TCGv_i128, TCGv_i128,
-                                 TCGArg, MemOp);
+void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_i32,
+                                    TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_i64,
+                                    TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+                                     TCGv_i128, TCGArg, MemOp, TCGType);
 
-void tcg_gen_nonatomic_cmpxchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGv_i32,
-                                   TCGArg, MemOp);
-void tcg_gen_nonatomic_cmpxchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGv_i64,
-                                   TCGArg, MemOp);
-void tcg_gen_nonatomic_cmpxchg_i128(TCGv_i128, TCGv, TCGv_i128, TCGv_i128,
-                                    TCGArg, MemOp);
+void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+                                        TCGv_i128, TCGArg, MemOp, TCGType);
 
-void tcg_gen_atomic_xchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_xchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
+void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                 TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_xchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                 TCGArg, MemOp, TCGType);
 
-void tcg_gen_atomic_fetch_add_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_add_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_and_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_and_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_or_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_or_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_xor_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_xor_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_smin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_smin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_umin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_umin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_smax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_smax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_umax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_fetch_umax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
+void tcg_gen_atomic_fetch_add_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_add_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_and_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_and_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_or_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                     TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_or_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                     TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_xor_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_xor_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_smin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_smin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_umin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_umin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_smax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_smax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_umax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_umax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
 
-void tcg_gen_atomic_add_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_add_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_and_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_and_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_or_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_smin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_smin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_umin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_umin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_smax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_smax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
-void tcg_gen_atomic_umax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
-void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
+void tcg_gen_atomic_add_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_add_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_and_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_and_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_or_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                     TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_or_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                     TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_xor_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_xor_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                      TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_smin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_smin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_umin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_umin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_smax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_smax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_umax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_umax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
+                                       TCGArg, MemOp, TCGType);
+
+#define DEF_ATOMIC2(N, S)                                               \
+    static inline void N##_##S(TCGv_##S r, TCGv a, TCGv_##S v,          \
+                               TCGArg i, MemOp m)                       \
+    { N##_##S##_chk(r, tcgv_tl_temp(a), v, i, m, TCG_TYPE_TL); }
+
+#define DEF_ATOMIC3(N, S)                                               \
+    static inline void N##_##S(TCGv_##S r, TCGv a, TCGv_##S o,          \
+                               TCGv_##S n, TCGArg i, MemOp m)           \
+    { N##_##S##_chk(r, tcgv_tl_temp(a), o, n, i, m, TCG_TYPE_TL); }
+
+DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
+DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i64)
+DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i128)
+
+DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i32)
+DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i64)
+DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i128)
+
+DEF_ATOMIC2(tcg_gen_atomic_xchg, i32)
+DEF_ATOMIC2(tcg_gen_atomic_xchg, i64)
+
+DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umin, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umin, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smax, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smax, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umax, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umax, i64)
+
+DEF_ATOMIC2(tcg_gen_atomic_add_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_add_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_and_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_and_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_or_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_or_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_xor_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_xor_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_smin_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_smin_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_umin_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_umin_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_smax_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_smax_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
+
+#undef DEF_ATOMIC2
+#undef DEF_ATOMIC3
 
 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 84a03bf6ed..281a80db41 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -443,22 +443,21 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     ret[1] = mop_2;
 }
 
-static TCGv_i64 maybe_extend_addr64(TCGv addr)
+static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
 {
-#if TARGET_LONG_BITS == 32
-    TCGv_i64 a64 = tcg_temp_ebb_new_i64();
-    tcg_gen_extu_i32_i64(a64, addr);
-    return a64;
-#else
-    return addr;
-#endif
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
+        return a64;
+    }
+    return temp_tcgv_i64(addr);
 }
 
 static void maybe_free_addr64(TCGv_i64 a64)
 {
-#if TARGET_LONG_BITS == 32
-    tcg_temp_free_i64(a64);
-#endif
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        tcg_temp_free_i64(a64);
+    }
 }
 
 static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
@@ -742,17 +741,18 @@ static void * const table_cmpxchg[(MO_SIZE | MO_BSWAP) + 1] = {
     WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_cmpxchgo_be)
 };
 
-void tcg_gen_nonatomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
-                                   TCGv_i32 newv, TCGArg idx, MemOp memop)
+static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
+                                              TCGv_i32 cmpv, TCGv_i32 newv,
+                                              TCGArg idx, MemOp memop)
 {
     TCGv_i32 t1 = tcg_temp_ebb_new_i32();
     TCGv_i32 t2 = tcg_temp_ebb_new_i32();
 
     tcg_gen_ext_i32(t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_i32(t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_i32(t2, addr, idx, memop);
+    tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
     tcg_temp_free_i32(t2);
 
     if (memop & MO_SIGN) {
@@ -763,15 +763,26 @@ void tcg_gen_nonatomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
     tcg_temp_free_i32(t1);
 }
 
-void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
-                                TCGv_i32 newv, TCGArg idx, MemOp memop)
+void tcg_gen_nonatomic_cmpxchg_i32_chk(TCGv_i32 retv, TCGTemp *addr,
+                                       TCGv_i32 cmpv, TCGv_i32 newv,
+                                       TCGArg idx, MemOp memop,
+                                       TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
+    tcg_gen_nonatomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
+}
+
+static void tcg_gen_atomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
+                                           TCGv_i32 cmpv, TCGv_i32 newv,
+                                           TCGArg idx, MemOp memop)
 {
     gen_atomic_cx_i32 gen;
     TCGv_i64 a64;
     MemOpIdx oi;
 
     if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
-        tcg_gen_nonatomic_cmpxchg_i32(retv, addr, cmpv, newv, idx, memop);
+        tcg_gen_nonatomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
         return;
     }
 
@@ -789,14 +800,25 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
     }
 }
 
-void tcg_gen_nonatomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
-                                   TCGv_i64 newv, TCGArg idx, MemOp memop)
+void tcg_gen_atomic_cmpxchg_i32_chk(TCGv_i32 retv, TCGTemp *addr,
+                                    TCGv_i32 cmpv, TCGv_i32 newv,
+                                    TCGArg idx, MemOp memop,
+                                    TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
+    tcg_gen_atomic_cmpxchg_i32_int(retv, addr, cmpv, newv, idx, memop);
+}
+
+static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
+                                              TCGv_i64 cmpv, TCGv_i64 newv,
+                                              TCGArg idx, MemOp memop)
 {
     TCGv_i64 t1, t2;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
-        tcg_gen_nonatomic_cmpxchg_i32(TCGV_LOW(retv), addr, TCGV_LOW(cmpv),
-                                      TCGV_LOW(newv), idx, memop);
+        tcg_gen_nonatomic_cmpxchg_i32_int(TCGV_LOW(retv), addr, TCGV_LOW(cmpv),
+                                          TCGV_LOW(newv), idx, memop);
         if (memop & MO_SIGN) {
             tcg_gen_sari_i32(TCGV_HIGH(retv), TCGV_LOW(retv), 31);
         } else {
@@ -810,9 +832,9 @@ void tcg_gen_nonatomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 
     tcg_gen_ext_i64(t2, cmpv, memop & MO_SIZE);
 
-    tcg_gen_qemu_ld_i64(t1, addr, idx, memop & ~MO_SIGN);
+    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_i64(t2, addr, idx, memop);
+    tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
     tcg_temp_free_i64(t2);
 
     if (memop & MO_SIGN) {
@@ -823,11 +845,22 @@ void tcg_gen_nonatomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
-                                TCGv_i64 newv, TCGArg idx, MemOp memop)
+void tcg_gen_nonatomic_cmpxchg_i64_chk(TCGv_i64 retv, TCGTemp *addr,
+                                       TCGv_i64 cmpv, TCGv_i64 newv,
+                                       TCGArg idx, MemOp memop,
+                                       TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
+    tcg_gen_nonatomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop);
+}
+
+static void tcg_gen_atomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
+                                           TCGv_i64 cmpv, TCGv_i64 newv,
+                                           TCGArg idx, MemOp memop)
 {
     if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
-        tcg_gen_nonatomic_cmpxchg_i64(retv, addr, cmpv, newv, idx, memop);
+        tcg_gen_nonatomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop);
         return;
     }
 
@@ -856,8 +889,8 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
     }
 
     if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_atomic_cmpxchg_i32(TCGV_LOW(retv), addr, TCGV_LOW(cmpv),
-                                   TCGV_LOW(newv), idx, memop);
+        tcg_gen_atomic_cmpxchg_i32_int(TCGV_LOW(retv), addr, TCGV_LOW(cmpv),
+                                       TCGV_LOW(newv), idx, memop);
         if (memop & MO_SIGN) {
             tcg_gen_sari_i32(TCGV_HIGH(retv), TCGV_LOW(retv), 31);
         } else {
@@ -870,7 +903,8 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 
         tcg_gen_extrl_i64_i32(c32, cmpv);
         tcg_gen_extrl_i64_i32(n32, newv);
-        tcg_gen_atomic_cmpxchg_i32(r32, addr, c32, n32, idx, memop & ~MO_SIGN);
+        tcg_gen_atomic_cmpxchg_i32_int(r32, addr, c32, n32,
+                                       idx, memop & ~MO_SIGN);
         tcg_temp_free_i32(c32);
         tcg_temp_free_i32(n32);
 
@@ -883,8 +917,18 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
     }
 }
 
-void tcg_gen_nonatomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
-                                    TCGv_i128 newv, TCGArg idx, MemOp memop)
+void tcg_gen_atomic_cmpxchg_i64_chk(TCGv_i64 retv, TCGTemp *addr,
+                                    TCGv_i64 cmpv, TCGv_i64 newv,
+                                    TCGArg idx, MemOp memop, TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
+    tcg_gen_atomic_cmpxchg_i64_int(retv, addr, cmpv, newv, idx, memop);
+}
+
+static void tcg_gen_nonatomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
+                                               TCGv_i128 cmpv, TCGv_i128 newv,
+                                               TCGArg idx, MemOp memop)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         /* Inline expansion below is simply too large for 32-bit hosts. */
@@ -892,12 +936,8 @@ void tcg_gen_nonatomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
                                   ? gen_helper_nonatomic_cmpxchgo_le 
                                   : gen_helper_nonatomic_cmpxchgo_be);
         MemOpIdx oi = make_memop_idx(memop, idx);
-        TCGv_i64 a64;
+        TCGv_i64 a64 = maybe_extend_addr64(addr);
 
-        tcg_debug_assert((memop & MO_SIZE) == MO_128);
-        tcg_debug_assert((memop & MO_SIGN) == 0);
-
-        a64 = maybe_extend_addr64(addr);
         gen(retv, cpu_env, a64, cmpv, newv, tcg_constant_i32(oi));
         maybe_free_addr64(a64);
     } else {
@@ -907,7 +947,7 @@ void tcg_gen_nonatomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 z = tcg_constant_i64(0);
 
-        tcg_gen_qemu_ld_i128(oldv, addr, idx, memop);
+        tcg_gen_qemu_ld_i128_int(oldv, addr, idx, memop);
 
         /* Compare i128 */
         tcg_gen_xor_i64(t0, TCGV128_LOW(oldv), TCGV128_LOW(cmpv));
@@ -921,7 +961,7 @@ void tcg_gen_nonatomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
                             TCGV128_HIGH(newv), TCGV128_HIGH(oldv));
 
         /* Unconditional writeback. */
-        tcg_gen_qemu_st_i128(tmpv, addr, idx, memop);
+        tcg_gen_qemu_st_i128_int(tmpv, addr, idx, memop);
         tcg_gen_mov_i128(retv, oldv);
 
         tcg_temp_free_i64(t0);
@@ -931,20 +971,28 @@ void tcg_gen_nonatomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
     }
 }
 
-void tcg_gen_atomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
-                                 TCGv_i128 newv, TCGArg idx, MemOp memop)
+void tcg_gen_nonatomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
+                                        TCGv_i128 cmpv, TCGv_i128 newv,
+                                        TCGArg idx, MemOp memop,
+                                        TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & (MO_SIZE | MO_SIGN)) == MO_128);
+    tcg_gen_nonatomic_cmpxchg_i128_int(retv, addr, cmpv, newv, idx, memop);
+}
+
+static void tcg_gen_atomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
+                                            TCGv_i128 cmpv, TCGv_i128 newv,
+                                            TCGArg idx, MemOp memop)
 {
     gen_atomic_cx_i128 gen;
 
     if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
-        tcg_gen_nonatomic_cmpxchg_i128(retv, addr, cmpv, newv, idx, memop);
+        tcg_gen_nonatomic_cmpxchg_i128_int(retv, addr, cmpv, newv, idx, memop);
         return;
     }
 
-    tcg_debug_assert((memop & MO_SIZE) == MO_128);
-    tcg_debug_assert((memop & MO_SIGN) == 0);
     gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
-
     if (gen) {
         MemOpIdx oi = make_memop_idx(memop, idx);
         TCGv_i64 a64 = maybe_extend_addr64(addr);
@@ -964,7 +1012,17 @@ void tcg_gen_atomic_cmpxchg_i128(TCGv_i128 retv, TCGv addr, TCGv_i128 cmpv,
     tcg_gen_movi_i64(TCGV128_HIGH(retv), 0);
 }
 
-static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
+void tcg_gen_atomic_cmpxchg_i128_chk(TCGv_i128 retv, TCGTemp *addr,
+                                     TCGv_i128 cmpv, TCGv_i128 newv,
+                                     TCGArg idx, MemOp memop,
+                                     TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & (MO_SIZE | MO_SIGN)) == MO_128);
+    tcg_gen_atomic_cmpxchg_i128_int(retv, addr, cmpv, newv, idx, memop);
+}
+
+static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
                                 TCGArg idx, MemOp memop, bool new_val,
                                 void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -973,17 +1031,17 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
 
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    tcg_gen_qemu_ld_i32(t1, addr, idx, memop);
+    tcg_gen_qemu_ld_i32_int(t1, addr, idx, memop);
     tcg_gen_ext_i32(t2, val, memop);
     gen(t2, t1, t2);
-    tcg_gen_qemu_st_i32(t2, addr, idx, memop);
+    tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
 
     tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
     tcg_temp_free_i32(t1);
     tcg_temp_free_i32(t2);
 }
 
-static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
+static void do_atomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
                              TCGArg idx, MemOp memop, void * const table[])
 {
     gen_atomic_op_i32 gen;
@@ -1005,7 +1063,7 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
     }
 }
 
-static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
+static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
                                 TCGArg idx, MemOp memop, bool new_val,
                                 void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -1014,40 +1072,36 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    tcg_gen_qemu_ld_i64(t1, addr, idx, memop);
+    tcg_gen_qemu_ld_i64_int(t1, addr, idx, memop);
     tcg_gen_ext_i64(t2, val, memop);
     gen(t2, t1, t2);
-    tcg_gen_qemu_st_i64(t2, addr, idx, memop);
+    tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
 
     tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
     tcg_temp_free_i64(t1);
     tcg_temp_free_i64(t2);
 }
 
-static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
+static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
                              TCGArg idx, MemOp memop, void * const table[])
 {
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
     if ((memop & MO_SIZE) == MO_64) {
-#ifdef CONFIG_ATOMIC64
-        gen_atomic_op_i64 gen;
-        TCGv_i64 a64;
-        MemOpIdx oi;
+        gen_atomic_op_i64 gen = table[memop & (MO_SIZE | MO_BSWAP)];
 
-        gen = table[memop & (MO_SIZE | MO_BSWAP)];
-        tcg_debug_assert(gen != NULL);
+        if (gen) {
+            MemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+            TCGv_i64 a64 = maybe_extend_addr64(addr);
+            gen(ret, cpu_env, a64, val, tcg_constant_i32(oi));
+            maybe_free_addr64(a64);
+            return;
+        }
 
-        oi = make_memop_idx(memop & ~MO_SIGN, idx);
-        a64 = maybe_extend_addr64(addr);
-        gen(ret, cpu_env, a64, val, tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
-#else
         gen_helper_exit_atomic(cpu_env);
         /* Produce a result, so that we have a well-formed opcode stream
            with respect to uses of the result in the (dead) code following.  */
         tcg_gen_movi_i64(ret, 0);
-#endif /* CONFIG_ATOMIC64 */
     } else {
         TCGv_i32 v32 = tcg_temp_ebb_new_i32();
         TCGv_i32 r32 = tcg_temp_ebb_new_i32();
@@ -1075,9 +1129,12 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le)     \
     WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be)     \
 };                                                                      \
-void tcg_gen_atomic_##NAME##_i32                                        \
-    (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, MemOp memop)    \
+void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
+                                     TCGv_i32 val, TCGArg idx,          \
+                                     MemOp memop, TCGType addr_type)    \
 {                                                                       \
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
+    tcg_debug_assert((memop & MO_SIZE) <= MO_32);                       \
     if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
@@ -1085,9 +1142,12 @@ void tcg_gen_atomic_##NAME##_i32                                        \
                             tcg_gen_##OP##_i32);                        \
     }                                                                   \
 }                                                                       \
-void tcg_gen_atomic_##NAME##_i64                                        \
-    (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, MemOp memop)    \
+void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
+                                     TCGv_i64 val, TCGArg idx,          \
+                                     MemOp memop, TCGType addr_type)    \
 {                                                                       \
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
+    tcg_debug_assert((memop & MO_SIZE) <= MO_64);                       \
     if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
     } else {                                                            \
-- 
2.34.1


