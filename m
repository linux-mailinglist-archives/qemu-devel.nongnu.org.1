Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D8723100
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gck-0001uU-EA; Mon, 05 Jun 2023 16:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcf-0001u7-RT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcc-0003xz-Ck
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53482b44007so2781208a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996168; x=1688588168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RwbeHiXrnAwWu35QTng9LeorJuoL8zzpp/ed/KIDaE=;
 b=GeqpQYS77kmofs43PQ3ezkiRbxIvKgZ5vsvR3SIH70LrWHJGjShj8seZnR6DMO2s55
 AHTpBCVLgIdhwFDyoEhliOLdOZNo810jmT48WcPTtY04whuQhxl17u9Zp/wvsTv9yIwi
 ozQ/TAtN+qxKf1a6tVxG2L973Wfh+IRiRKMzfdkufbzcGu9YCXi/I3qw2hblVNVxNDxW
 SWXhdae1YIs8KwoHF8aGPmgpwAouuS1X4MWMlx6MzjisdPMaEBOhKQ1tYNNW2Cuzuehg
 Y9ehgpmCXZdlgMd9OBWCGIPUsw00FEMNLq5K0cnDEq/Jzk5m3I38l0jyqg3JwNmhzPsR
 Yl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996168; x=1688588168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+RwbeHiXrnAwWu35QTng9LeorJuoL8zzpp/ed/KIDaE=;
 b=Thex/7EsoAePIcRimj/bgnk3TGrJOfCElH3d8g79eizHLayDxG+gxyaBRs1S001Krj
 VZIjyOfkHQJkUHD2UPm3SXAgawfCXJKYOENqbCRunNdSyTgk5rekooHVSD4Ycx/BF3vl
 2XldW571Ay1topvUT69/h/w3NotNn2/AqxRvVdJHCJ03uuCe98b43uB19IfPKV+E3tz3
 kCc0d8Ssg9/iRGEePcLF3otyh1PYwqh46TGekNbSlAUHoym4Src8Be8JPkdDbRZvaYPo
 wuxbbofH0G+rnD0ro6MvGq43PyQMgsDDvyiRICzImRAG4/6efI80q2+wPvMOiKpDp6/g
 Ml1g==
X-Gm-Message-State: AC+VfDy4OwbJAC4x+s8x8yb72tXNApsUzZmWsQPTIH5sDNNocId2MdUD
 7OU7Y+v3XTcoZX14kl1M3AbgIv4GcnbuTiw/CIA=
X-Google-Smtp-Source: ACHHUZ51COJ6nsft56EzAfk3Cmh6UjFkujioS8upBRzdIO9qu2iPyYL3/pFNUVC+eFQmOIxoWL1/EA==
X-Received: by 2002:a05:6a21:338b:b0:10e:43e:e223 with SMTP id
 yy11-20020a056a21338b00b0010e043ee223mr225847pzb.1.1685996168518; 
 Mon, 05 Jun 2023 13:16:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/52] tcg: Move temp_idx and tcgv_i32_temp debug out of line
Date: Mon,  5 Jun 2023 13:15:17 -0700
Message-Id: <20230605201548.1596865-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Removes a multiplicity of calls to __assert_fail, saving up
to 360kiB of .text space as measured on an x86_64 host.

Old     New     Less    %Change
9257272	8888680	368592	3.98%	qemu-system-aarch64
6100968	5911832	189136	3.10%	qemu-system-riscv64
5839112	5707032	132080	2.26%	qemu-system-mips
4447608	4341752	105856	2.38%	qemu-system-s390x

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 30 ++++++++++++++++--------------
 tcg/tcg.c         | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 34035dab81..64c10a63f3 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -630,13 +630,6 @@ static inline void *tcg_splitwx_to_rw(const void *rx)
 }
 #endif
 
-static inline size_t temp_idx(TCGTemp *ts)
-{
-    ptrdiff_t n = ts - tcg_ctx->temps;
-    tcg_debug_assert(n >= 0 && n < tcg_ctx->nb_temps);
-    return n;
-}
-
 static inline TCGArg temp_arg(TCGTemp *ts)
 {
     return (uintptr_t)ts;
@@ -647,16 +640,25 @@ static inline TCGTemp *arg_temp(TCGArg a)
     return (TCGTemp *)(uintptr_t)a;
 }
 
-/* Using the offset of a temporary, relative to TCGContext, rather than
-   its index means that we don't use 0.  That leaves offset 0 free for
-   a NULL representation without having to leave index 0 unused.  */
+#ifdef CONFIG_DEBUG_TCG
+size_t temp_idx(TCGTemp *ts);
+TCGTemp *tcgv_i32_temp(TCGv_i32 v);
+#else
+static inline size_t temp_idx(TCGTemp *ts)
+{
+    return ts - tcg_ctx->temps;
+}
+
+/*
+ * Using the offset of a temporary, relative to TCGContext, rather than
+ * its index means that we don't use 0.  That leaves offset 0 free for
+ * a NULL representation without having to leave index 0 unused.
+ */
 static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
-    uintptr_t o = (uintptr_t)v;
-    TCGTemp *t = (void *)tcg_ctx + o;
-    tcg_debug_assert(offsetof(TCGContext, temps[temp_idx(t)]) == o);
-    return t;
+    return (void *)tcg_ctx + (uintptr_t)v;
 }
+#endif
 
 static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ffd3ccaff7..59624fceec 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1800,6 +1800,25 @@ TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val)
     return tcg_constant_vec(t->base_type, vece, val);
 }
 
+#ifdef CONFIG_DEBUG_TCG
+size_t temp_idx(TCGTemp *ts)
+{
+    ptrdiff_t n = ts - tcg_ctx->temps;
+    assert(n >= 0 && n < tcg_ctx->nb_temps);
+    return n;
+}
+
+TCGTemp *tcgv_i32_temp(TCGv_i32 v)
+{
+    uintptr_t o = (uintptr_t)v - offsetof(TCGContext, temps);
+
+    assert(o < sizeof(TCGTemp) * tcg_ctx->nb_temps);
+    assert(o % sizeof(TCGTemp) == 0);
+
+    return (void *)tcg_ctx + (uintptr_t)v;
+}
+#endif /* CONFIG_DEBUG_TCG */
+
 /* Return true if OP may appear in the opcode stream.
    Test the runtime variable that controls each opcode.  */
 bool tcg_op_supported(TCGOpcode op)
-- 
2.34.1


