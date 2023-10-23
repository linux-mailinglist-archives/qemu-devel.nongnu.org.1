Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC557D3ECE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRW-0006EE-DQ; Mon, 23 Oct 2023 14:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRB-0005h8-Cs
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR9-0008Hd-BM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so3585052b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084838; x=1698689638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PSV1d0+Nd9u1BeAFewAMmI3bPYXAWKfgIrndrhftjU=;
 b=BL9aQF2lHkAHP1eTr96IYV/dM6QUqd7Sb0iHbDzdieZt5Ubpw+IyidJZGm51jugnhk
 ZK2Xc8Y+uIFhXW1aLJ/9NEYUFEqhcOMrS+LOL32UDSaiGC+CixuHRW92kbFmhn/3vnRq
 MqAvDJpI1ndUQTqTZHfdFS0wI7ZlNq2UNjwTUW1IYzMBNXeIdvHsBcquMurYXZfDubU4
 xsO7ol0/6J+hfjxd0xVJf9lLI48O4TSJx4VrvEECiifi12phWCeEcGS+pv27hNJ4DBHG
 NDTVwwM23emKVmUXlZCTybDUbsSvleUmiNd1Bu2/UO93S6+8zLa2+8d6QGbOVlCxtmyu
 IAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084838; x=1698689638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PSV1d0+Nd9u1BeAFewAMmI3bPYXAWKfgIrndrhftjU=;
 b=fuO30cjx3mMwIiRQI7/tBHsSIVD+Tz/3jHICmkL4O2BCE1O4kAR/XSD7TubijJhCtP
 U7ETZqfPPTRM3INJvEAp7lgEO9BVwvcUH700IBo9BY9HSGPiXjYfrj0V7aC6tuUq/b95
 S6/jnddrtNPIsUnKFgAtvT8/FVH18FsaqJtFTQYuLejLvab6CD8dnYfJxXrhzOM+LtpG
 SdIVv2SitXYRj5kdmoB3MFhx99IpQwfKJR1y5DG3wYCjg4adX0qwVDWe/Va6ZIjAgAkY
 UUKMbO1BBICPqNn8m3doM3GP7Nc7nNMD57O+Lhcu6QRADmPZGe3bCzohyg1gSHpBhAM/
 OhZQ==
X-Gm-Message-State: AOJu0YxmvwRp7pa9r+Se5xxwkvqYLFS0tjbu6iHOyayTj/sPfS3IWzhZ
 UvGc9sB5v9RMSKpi27vIbE0t+FA9cnwI/7oFTjw=
X-Google-Smtp-Source: AGHT+IGu4WeNFtpxmwjlwuFVX8IKzIHK0LXuCk5U+E3o4ifC4Qnny/wjAOny34MDIY+rgBqTGJU9aw==
X-Received: by 2002:a05:6a20:54a9:b0:174:c134:81fa with SMTP id
 i41-20020a056a2054a900b00174c13481famr450321pzk.17.1698084837515; 
 Mon, 23 Oct 2023 11:13:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 30/38] tcg: add negsetcondi
Date: Mon, 23 Oct 2023 11:13:21 -0700
Message-Id: <20231023181329.171490-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

This can be useful to write a shift bit extraction that does not
depend on TARGET_LONG_BITS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20231019104648.389942-15-pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  4 ++++
 include/tcg/tcg-op.h        |  2 ++
 tcg/tcg-op.c                | 12 ++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 56d4e9cb9f..a0bae5df01 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -346,6 +346,8 @@ void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
+                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -544,6 +546,8 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
+                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 3ead59e459..e81dd7dd9e 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -199,6 +199,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
 #define tcg_gen_setcondi_tl tcg_gen_setcondi_i64
 #define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i64
+#define tcg_gen_negsetcondi_tl tcg_gen_negsetcondi_i64
 #define tcg_gen_mul_tl tcg_gen_mul_i64
 #define tcg_gen_muli_tl tcg_gen_muli_i64
 #define tcg_gen_div_tl tcg_gen_div_i64
@@ -317,6 +318,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
 #define tcg_gen_setcondi_tl tcg_gen_setcondi_i32
 #define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i32
+#define tcg_gen_negsetcondi_tl tcg_gen_negsetcondi_i32
 #define tcg_gen_mul_tl tcg_gen_mul_i32
 #define tcg_gen_muli_tl tcg_gen_muli_i32
 #define tcg_gen_div_tl tcg_gen_div_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b4dbb2f2ba..828eb9ee46 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -291,6 +291,12 @@ void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
     }
 }
 
+void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
+                             TCGv_i32 arg1, int32_t arg2)
+{
+    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
+}
+
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1602,6 +1608,12 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
+void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
+                             TCGv_i64 arg1, int64_t arg2)
+{
+    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
+}
+
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.34.1


