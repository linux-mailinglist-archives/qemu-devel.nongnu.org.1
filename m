Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2247DEA4A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:42:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMco-0001AH-Dx; Wed, 01 Nov 2023 21:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaw-0006O7-M9
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMau-0001vG-U1
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so3627775ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888839; x=1699493639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIuthBYkKwOmsBB1Uq0crYfKMoKtW6F7fMd/Il2eA/A=;
 b=iHQlFS6aJx9e6rFNrll7NzmgCyIKxM4MuOl7NFYgy3e2opRtPZiGQTVYSjG1Zc4uVO
 gIKRcrvTokQARS5dxRpCzKuhSwuM4ykTMmhT4ZVVGYvNxa/l5cR3mSDttzNn0Cr2YHVk
 6rvoENrOPL65CS2QjMzEEJVpkIg7d6wCZ75HNwNRQhIBjr6+IHpGXT63wsUBM1GVZrv5
 eTkQJagRvfm8fqhE06aXoruUH09xSn/Zkor+yMh+ZBUeXQkmqxxk5R6kQgUqPy+TEutS
 a7rWVwmd7ac9i++V7sJNyC3sTc5y7TlVZLOZC5p0BZi2UHwE/Y77ZnKcWdVs6VjfCivq
 xPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888839; x=1699493639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIuthBYkKwOmsBB1Uq0crYfKMoKtW6F7fMd/Il2eA/A=;
 b=tlTSqbOnHFiKkBEfmNMHLNbrKvJ2IyevQJEhSQB3KYD4ZhqB44MN9t84dlGpZ23niW
 eBxN9IatEghYMZEIPzg+G+JS3asQ7jAXi3X3fHekHxCNv/k2Q594+6+3Dmcn6EPy2kTK
 TO1/HT3odniVRs4WaCoUH92wwKomDpkv45NMqKfhBdZKDX+LUANeiMrLpZyCUVberEMh
 EdJEN5WZee7y6cl7/qdMoB0uPGq+Q5w0ozXAOmrfE/KP3oF1zCCpzOE3vKI46fkq/jJm
 FgB7yZGaGsDszSW0j9tn4K+KVFaeVEuXGHK7X9a0Pzh6suHfrAo90TiGbPk4Xh7gPQ4s
 JzFQ==
X-Gm-Message-State: AOJu0YwgDfkXrGPEr9iLWPsC7mij06i7ZFNqPew2vqrbpGDuVwk20MGF
 8dpxFAT0gqp2lU1Yy9K5lKzh1WJ+8zCKv3258z0=
X-Google-Smtp-Source: AGHT+IEna11v2Uf9wLB9Dg0n5RLwXA++z9PwQjdC6MTtXFAc+tqrfp9TMzjP2oNC9CON2e6Un5N0Jg==
X-Received: by 2002:a17:902:d50d:b0:1cc:339b:62af with SMTP id
 b13-20020a170902d50d00b001cc339b62afmr17258524plg.16.1698888839657; 
 Wed, 01 Nov 2023 18:33:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 47/88] target/hppa: Decode CMPIB double-word
Date: Wed,  1 Nov 2023 18:29:35 -0700
Message-Id: <20231102013016.369010-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/hppa/insns.decode | 10 ++++++++--
 target/hppa/translate.c  | 11 ++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index fc327e2bb3..48f09c9b06 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -51,6 +51,7 @@
 %pos_to_m       0:1      !function=pos_to_m
 %neg_to_m       0:1      !function=neg_to_m
 %a_to_m         2:1      !function=neg_to_m
+%cmpbid_c       13:2     !function=cmpbid_c
 
 ####
 # Argument set definitions
@@ -69,6 +70,7 @@
 &rrb_c_f        disp n c f r1 r2
 &rrb_c_d_f      disp n c d f r1 r2
 &rib_c_f        disp n c f r i
+&rib_c_d_f      disp n c d f r i
 
 ####
 # Format definitions
@@ -88,6 +90,8 @@
                 &rrb_c_d_f disp=%assemble_12
 @rib_cf         ...... r:5 ..... c:3 ........... n:1 .  \
                 &rib_c_f disp=%assemble_12 i=%im5_16
+@rib_cdf        ...... r:5 ..... c:3 ........... n:1 .  \
+                &rib_c_d_f disp=%assemble_12 i=%im5_16
 
 ####
 # System
@@ -303,8 +307,10 @@ cmpb            100000 ..... ..... ... ........... . .  @rrb_cdf d=0 f=0
 cmpb            100010 ..... ..... ... ........... . .  @rrb_cdf d=0 f=1
 cmpb            100111 ..... ..... ... ........... . .  @rrb_cdf d=1 f=0
 cmpb            101111 ..... ..... ... ........... . .  @rrb_cdf d=1 f=1
-cmpbi           100001 ..... ..... ... ........... . .  @rib_cf f=0
-cmpbi           100011 ..... ..... ... ........... . .  @rib_cf f=1
+cmpbi           100001 ..... ..... ... ........... . .  @rib_cdf d=0 f=0
+cmpbi           100011 ..... ..... ... ........... . .  @rib_cdf d=0 f=1
+cmpbi           111011 r:5 ..... f:1 .. ........... n:1 . \
+                &rib_c_d_f d=1 disp=%assemble_12 c=%cmpbid_c i=%im5_16
 
 addb            101000 ..... ..... ... ........... . .  @rrb_cf f=0
 addb            101010 ..... ..... ... ........... . .  @rrb_cf f=1
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6cd06fbc0d..7f767fea64 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -329,6 +329,12 @@ static int expand_shl11(DisasContext *ctx, int val)
     return val << 11;
 }
 
+/* Translate CMPI doubleword conditions to standard. */
+static int cmpbid_c(DisasContext *ctx, int val)
+{
+    return val ? val : 4; /* 0 == "*<<" */
+}
+
 
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
@@ -3122,9 +3128,12 @@ static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 
 static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 {
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     nullify_over(ctx);
     return do_cmpb(ctx, a->r, tcg_constant_reg(a->i),
-                   a->c, a->f, false, a->n, a->disp);
+                   a->c, a->f, a->d, a->n, a->disp);
 }
 
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
-- 
2.34.1


