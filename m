Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A77E3391
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:07:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPX-0001Vn-9K; Mon, 06 Nov 2023 22:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COd-0007VB-7o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:55 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000hB-4p
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:54 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so39075645ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326272; x=1699931072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LA/AGLVV6ssagQlxsZX0RjDd9+wOPDPuaHlRJKzssek=;
 b=zznQHiHvA8eht5+95wAMy3psq07ldDZ7ZgsGhOeDNjQVzE7TvSQe7aLsnq6F+JdI8v
 zhNJCI2HmK16pJLaVi/v2HNAziXSC287yirgBushTeQHkFdKQF4hcpY1xz+7DHtb5l2j
 HjkGCkxYc6iwr7PK7YeEIzNYC7vjtExTtzFsffq2a4+NCBPKJAF43/yHyyRn0dO10MBy
 cTa3GE0+IzxnccfEuoFWqbaxFB8pahTn+jD/6QbsbHEDdb0X2w0rmfzXzWa8ftguPtvm
 cKA1jAKH9Hz+AxLtM91aQCZxAi7cwSP30h+uyZH2uC9ymZKUijOa2+4M5KGI3f2+zfFD
 Uf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326272; x=1699931072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LA/AGLVV6ssagQlxsZX0RjDd9+wOPDPuaHlRJKzssek=;
 b=I4+pK+mUV1LvPj+wwgHKEtyzoCbYVrpy4BA29Hvk56axcZidoW939+KFJSbxo49nMt
 5T9AkwPvVCUB50/th58u9UyVRO2I8rSRi2/SDJUvfkWIg9zS1igLUFqQfTQDpCmggwZz
 jHoLFfL7mEanQ9RWnrzC8nMktqAaXHOqDY4l16Ad05Qc4Vg73jVPfxImXrQAW3D/ZpF/
 J0NvZBDdvru0pHIbLaVcqKee5J0kbR/iws9IJrhpZtoXHCpgvUuXb36/MWwzSMqJAcl4
 YXgByHR0fN2d8/zStGfsmRtnPooA2+SywW7gohyQKtWFNJQDEnp9wWBjst5OesUOQl2/
 aH5g==
X-Gm-Message-State: AOJu0Yzsz+yV60dAgljQ27BTrkP46jclVo7briOp3tVdsaVxrO1QSM5g
 1VN9ejXQO+qpj+GK/yASkI1iDlIAng8ymuLuOv0=
X-Google-Smtp-Source: AGHT+IHIegzZusSw/QVxMnmdK4RQqrF/P5hSl3XzvCllp7MBXzSCKXrHSzpj61VGkqmr87Y/jmeyJg==
X-Received: by 2002:a17:902:dacc:b0:1cc:51b8:80f3 with SMTP id
 q12-20020a170902dacc00b001cc51b880f3mr21478418plx.16.1699326272513; 
 Mon, 06 Nov 2023 19:04:32 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/85] target/hppa: Pass d to do_log_cond
Date: Mon,  6 Nov 2023 19:03:14 -0800
Message-Id: <20231107030407.8979-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Hoist the resolution of d up one level above do_log_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 48 ++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 72971097bb..ac7f1f048c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -983,9 +983,11 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
  * how cases c={2,3} are treated.
  */
 
-static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
+static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
+                             TCGv_reg res)
 {
-    bool d = false;
+    TCGCond tc;
+    bool ext_uns;
 
     switch (cf) {
     case 0:  /* never */
@@ -1001,17 +1003,29 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
         return cond_make_t();
 
     case 2:  /* == */
-        return cond_make_0(TCG_COND_EQ, res);
+        tc = TCG_COND_EQ;
+        ext_uns = true;
+        break;
     case 3:  /* <> */
-        return cond_make_0(TCG_COND_NE, res);
+        tc = TCG_COND_NE;
+        ext_uns = true;
+        break;
     case 4:  /* < */
-        return cond_make_0(TCG_COND_LT, res);
+        tc = TCG_COND_LT;
+        ext_uns = false;
+        break;
     case 5:  /* >= */
-        return cond_make_0(TCG_COND_GE, res);
+        tc = TCG_COND_GE;
+        ext_uns = false;
+        break;
     case 6:  /* <= */
-        return cond_make_0(TCG_COND_LE, res);
+        tc = TCG_COND_LE;
+        ext_uns = false;
+        break;
     case 7:  /* > */
-        return cond_make_0(TCG_COND_GT, res);
+        tc = TCG_COND_GT;
+        ext_uns = false;
+        break;
 
     case 14: /* OD */
     case 15: /* EV */
@@ -1020,6 +1034,18 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
     default:
         g_assert_not_reached();
     }
+
+    if (cond_need_ext(ctx, d)) {
+        TCGv_reg tmp = tcg_temp_new();
+
+        if (ext_uns) {
+            tcg_gen_ext32u_reg(tmp, res);
+        } else {
+            tcg_gen_ext32s_reg(tmp, res);
+        }
+        return cond_make_0_tmp(tc, tmp);
+    }
+    return cond_make_0(tc, res);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
@@ -1027,6 +1053,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
 static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
 {
     unsigned c, f;
+    bool d = false;
 
     /* Convert the compressed condition codes to standard.
        0-2 are the same as logicals (nv,<,<=), while 3 is OD.
@@ -1037,7 +1064,7 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
     }
     f = (orig & 4) / 4;
 
-    return do_log_cond(ctx, c * 2 + f, res);
+    return do_log_cond(ctx, c * 2 + f, d, res);
 }
 
 /* Similar, but for unit conditions.  */
@@ -1381,6 +1408,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest = dest_gpr(ctx, rt);
+    bool d = false;
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1389,7 +1417,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (cf) {
-        ctx->null_cond = do_log_cond(ctx, cf, dest);
+        ctx->null_cond = do_log_cond(ctx, cf, d, dest);
     }
 }
 
-- 
2.34.1


