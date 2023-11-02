Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC747DEA6B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMax-0006Jk-RC; Wed, 01 Nov 2023 21:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMas-0006FA-M4
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:33:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaq-0001uN-79
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:33:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso3387135ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888834; x=1699493634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4omnBr4R3fX8NCviq/DiarTTVj7DsLckzrEJ1GuQtfo=;
 b=fYaPXWqnP6+CnNjMhKjFTuh9lXN+XL5QicoXN3kjRIXvj5fdkC0TY2xFucqEY9NS15
 /xkrrEN8DY5PFDUAxRUouwdZDCpD/+qepSZ+4mNGersDLZ/PLLV5mN+R1nWO5Ki1ljZR
 +P2DNYaFpjPsC7SlXlCzyTMbuq1a2Pnks0I0o5b3sW4ag6s+IfHKmmXDO4UjZP2ha1QO
 2704B17DiLegMCGCD3FFE7XL29E2xWxt79VxWq+kg4BSBygfYarzXRPQHrRi/9BwX52B
 pUl27g7jV4CVG8PwdfENnUYrpaXdhDUDGEzL8DqhMq6EDjP4mDPuDHTjzekm82OYEzFf
 bF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888834; x=1699493634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4omnBr4R3fX8NCviq/DiarTTVj7DsLckzrEJ1GuQtfo=;
 b=m4atGMFZ7bZAqOITFN4XtX+BJtTWRyVt3RVRYrDa9/X5y5evkXADI6JVOQj24f7qdt
 Ebgww7Mclr/Sfn4K4LRWG79mzJW1ATa66+PyUmPfCuRVHOPa9o3Ct6W/9+QYx6PUMeUP
 NCYGkkOiYT/xMBbssU0BxzN6cNNTijdjdLJ9yBtRJlvkRbdcu3MfsiX+BwapBSg3LCcd
 97gts31WNAWADwKt0acqFlHNSJAzntxxX4E+LuCC8TlSsF9ntcy0lSgDDk1BTaAvj6LJ
 mn3LsTkDqGDrXw3+1CmwyhyShYaeFTpce+7HLuXQmlBLJRex93b2XAheYbH3/5baWMnh
 kXfQ==
X-Gm-Message-State: AOJu0Yy1wvPvQcgU5jRNWEoxAl/fQCBDJzcBaMb19LkwDrqwWPaurFBE
 ollr6gEHezl/3mVOcP944Tk8HY6ZnmDc9aKEbVw=
X-Google-Smtp-Source: AGHT+IE2SODdFY+G0+FWpFP/6S5CGAo53J9OKr5NVdJojlvgO0wy7d2WE1kaOJTB0xqa+TXWyZ0WRg==
X-Received: by 2002:a17:903:2594:b0:1c6:117b:7086 with SMTP id
 jb20-20020a170903259400b001c6117b7086mr15205713plb.5.1698888834030; 
 Wed, 01 Nov 2023 18:33:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 40/88] target/hppa: Decode d for logical instructions
Date: Wed,  1 Nov 2023 18:29:28 -0700
Message-Id: <20231102013016.369010-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/hppa/insns.decode | 10 ++++++----
 target/hppa/translate.c  | 15 +++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index aebe03ccfd..26ca9f1063 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -61,6 +61,7 @@
 
 &rr_cf          t r cf
 &rrr_cf         t r1 r2 cf
+&rrr_cf_d       t r1 r2 cf d
 &rrr_cf_sh      t r1 r2 cf sh
 &rri_cf         t r i cf
 
@@ -73,6 +74,7 @@
 
 @rr_cf          ...... r:5 ..... cf:4 ....... t:5       &rr_cf
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
+@rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
 @rrr_cf_sh      ...... r2:5 r1:5 cf:4 .... sh:2 . t:5   &rrr_cf_sh
 @rrr_cf_sh0     ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf_sh sh=0
 @rri_cf         ...... r:5  t:5  cf:4 . ...........     &rri_cf i=%lowsign_11
@@ -150,10 +152,10 @@ lci             000001 ----- ----- -- 01001100 0 t:5
 # Arith/Log
 ####
 
-andcm           000010 ..... ..... .... 000000 - .....  @rrr_cf
-and             000010 ..... ..... .... 001000 - .....  @rrr_cf
-or              000010 ..... ..... .... 001001 - .....  @rrr_cf
-xor             000010 ..... ..... .... 001010 0 .....  @rrr_cf
+andcm           000010 ..... ..... .... 000000 . .....  @rrr_cf_d
+and             000010 ..... ..... .... 001000 . .....  @rrr_cf_d
+or              000010 ..... ..... .... 001001 . .....  @rrr_cf_d
+xor             000010 ..... ..... .... 001010 . .....  @rrr_cf_d
 uxor            000010 ..... ..... .... 001110 0 .....  @rrr_cf
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
 cmpclr          000010 ..... ..... .... 100010 0 .....  @rrr_cf
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 187d47f4c3..227d59b263 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1405,11 +1405,10 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 }
 
 static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
-                   TCGv_reg in2, unsigned cf,
+                   TCGv_reg in2, unsigned cf, bool d,
                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest = dest_gpr(ctx, rt);
-    bool d = false;
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1422,7 +1421,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 }
 
-static bool do_log_reg(DisasContext *ctx, arg_rrr_cf *a,
+static bool do_log_reg(DisasContext *ctx, arg_rrr_cf_d *a,
                        void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1432,7 +1431,7 @@ static bool do_log_reg(DisasContext *ctx, arg_rrr_cf *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_log(ctx, a->t, tcg_r1, tcg_r2, a->cf, fn);
+    do_log(ctx, a->t, tcg_r1, tcg_r2, a->cf, a->d, fn);
     return nullify_end(ctx);
 }
 
@@ -2693,17 +2692,17 @@ static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf *a)
     return do_sub_reg(ctx, a, true, true, false);
 }
 
-static bool trans_andcm(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_andcm(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_log_reg(ctx, a, tcg_gen_andc_reg);
 }
 
-static bool trans_and(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_and(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_log_reg(ctx, a, tcg_gen_and_reg);
 }
 
-static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     if (a->cf == 0) {
         unsigned r2 = a->r2;
@@ -2755,7 +2754,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
     return do_log_reg(ctx, a, tcg_gen_or_reg);
 }
 
-static bool trans_xor(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_xor(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_log_reg(ctx, a, tcg_gen_xor_reg);
 }
-- 
2.34.1


