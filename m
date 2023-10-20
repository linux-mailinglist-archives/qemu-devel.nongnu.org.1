Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19337D179F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP2-000218-GL; Fri, 20 Oct 2023 16:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOy-0001xZ-VK
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOw-0001Cb-RA
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1086347b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834841; x=1698439641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojJYI0tVlCUuFtnD7VBP+O6EPwqAH+K63czDDMFmTyw=;
 b=Ksrz+ISLyq6PPcLMVsKFVMm/qsb/zAETjxx/TFOafqtZofZAxXUPEFgyLnLWemhtJX
 wECaoK0uQuAyGYS+y9ZXZ5wOtj39tpJ7EB3+d9BKnUewTDMaT8nhF1BB6tG1Ok1zpogH
 mfHFgpaHKadc8CyMI6GvqWpl7PohcYwqBxr8bAs6aSHYPh3yzaItODMMON1lKxnlYA0X
 ANQ7+gNoNOXhPG4XY2XEWwU7kOYfxM9JhHqjW5CipyfIFTgUSvwybA4+D6HhLrxUcFtB
 rXGClQ5qJBG5LQ/f31uDw7CzWIJLpTtVexXdAMLloxBu2n8ArHm5x/9YHOVIP663h3op
 NuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834841; x=1698439641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojJYI0tVlCUuFtnD7VBP+O6EPwqAH+K63czDDMFmTyw=;
 b=syWo1+RoH/Z2W3oaJlgEYtnoNwjiY0tuhiSDs/2MV36u2uHzCqSwv+90jPCexDvQd1
 9bRKVS4fN0TyCJCrmdHcifXHZcEoIBI7pEDCt0MA1eyBkfuFuz3XrmY19uUEsbnKYv5d
 rm8Dmgw0Rm7dkA4IP29bBnTwVYa9yr8nrN+LbjhWbC3xyMpsSpHnkzXV5J88AbEHhqcH
 TnmPgXAMhxstB1q68BjN5avuASds8GW/XjdibQTmXoX+KESoVZcbO+S0tHmvR16Q1hLh
 2CPGoGM4/EGTnDZ3WV1+FznvCNflCL3PapMy1Edvi/hGhNpRBnbA4hmRqcETfGOnxaGr
 Zn+Q==
X-Gm-Message-State: AOJu0YyghM+hz5F1jr8Vm8M6CtCbxzhPdgeYdjRt3k6Ltsfh3wqYmtk5
 xwSwy9Qms6qJnk/34jxQpZ/OK0oigHUAyuu0PaE=
X-Google-Smtp-Source: AGHT+IEQztEZArhli5JNLEGK58SqsY2ndwQKX4IcoP/8fi2yffwo+EVGSYEo3PJDuyDkAhsn3YA7kw==
X-Received: by 2002:a05:6a20:2324:b0:172:913c:ba36 with SMTP id
 n36-20020a056a20232400b00172913cba36mr2507969pzc.24.1697834841639; 
 Fri, 20 Oct 2023 13:47:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 55/65] target/hppa: Implement HSHL, HSHR
Date: Fri, 20 Oct 2023 13:43:21 -0700
Message-Id: <20231020204331.139847-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  5 +++++
 target/hppa/translate.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index fb0f9d6dbd..f0c4866ca2 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -69,6 +69,7 @@
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_d_sh    t r1 r2 cf d sh
+&rri            t r i
 &rri_cf         t r i cf
 &rri_cf_d       t r i cf d
 
@@ -216,6 +217,10 @@ hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
 
 havg            000010 ..... ..... 00000010 11 0 .....  @rrr
 
+hshl            111110 00000 r:5   100010 i:4  0 t:5    &rri
+hshr_s          111110 r:5   00000 110011 i:4  0 t:5    &rri
+hshr_u          111110 r:5   00000 110010 i:4  0 t:5    &rri
+
 hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c1ca4db099..353d51cc8b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2761,6 +2761,26 @@ static bool do_multimedia(DisasContext *ctx, arg_rrr *a,
     return nullify_end(ctx);
 }
 
+static bool do_multimedia_sh(DisasContext *ctx, arg_rri *a,
+                             void (*fn)(TCGv_i64, TCGv_i64, int64_t))
+{
+    TCGv_i64 r, dest;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r = load_gpr(ctx, a->r);
+    dest = dest_gpr(ctx, a->t);
+
+    fn(dest, r, a->i);
+    save_gpr(ctx, a->t, dest);
+
+    return nullify_end(ctx);
+}
+
 static bool trans_hadd(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_add16_i64);
@@ -2781,6 +2801,21 @@ static bool trans_havg(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_havg);
 }
 
+static bool trans_hshl(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_shl16i_i64);
+}
+
+static bool trans_hshr_s(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_sar16i_i64);
+}
+
+static bool trans_hshr_u(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_shr16i_i64);
+}
+
 static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
-- 
2.34.1


