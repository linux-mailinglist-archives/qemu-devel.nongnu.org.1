Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 116737E3388
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPQ-0000oP-N0; Mon, 06 Nov 2023 22:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COb-0007Fv-2a
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000hm-QA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc5916d578so47481975ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326276; x=1699931076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4omnBr4R3fX8NCviq/DiarTTVj7DsLckzrEJ1GuQtfo=;
 b=HSq9djq6KEWDqi1ucg45h7QRBrEG06ZzMgMCQ4dqXM01kqovap/HboqYnGkzaWC0Dt
 LXXgcAg1fNsmcXg+s6fyhSt/ckAQC+xsHO6249yC9TYerX1alf1U6SG6uQn61VT06GWl
 XPzOSYpxxnYaCuVq3TEPLY2v9aBBo82UFcYSXHhNYmwhMA7AjbjgkxsOJjjtEWiQeh81
 kZp649me5pAGJ7Gv0GQ9QJ6J5d8ErewPDpsu+YKkwtBnVVn8DVZCqoP/0rz9wxtaoVgH
 lCmMnT4HiI6CLdMJ+qD++5QXwFEmFKHudFrqPSXqeq0N7Fcq8bWovS/m9HkEvveNOBdI
 SCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326276; x=1699931076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4omnBr4R3fX8NCviq/DiarTTVj7DsLckzrEJ1GuQtfo=;
 b=FdXKrqy0jfAezM6XM9nnPM+LqKGazvm0BEb5f0IEOWv93E9jky2AIBjVkhysF8XgRP
 Rid82bBGFzD/A9Hl1b8a0dketMnEk5OmSud7qnpMmGZT3SJlhzetby2WWBoTFjfilKxJ
 agJfDTuKpgRx5N0WRfHbsBxPXfN9k2vkTORE9Wfj0fgwZb7TQ3cCeJ/AMw/R0/09gPoU
 hiLUuggnJZcVDJdfFF27QtVsvnaCjQarkMP2rFa+BgRtmEv9iACT9bliT1Rsu1lznnZd
 vpVSuKHzHZJP9pN34y0tmt7EJ9x8+zNv9v6yIYRUugQ5M4SX0t0gW4at/BdHUulSPSvB
 tJ5Q==
X-Gm-Message-State: AOJu0YxVGMju+s+fpnIzVhDBiNxvBV+2yp+gyd+gOtQLzK/NxMSvWBgE
 BSydmcPYrNJwkfHAJoDP07AD3DhpyDecs4M5+lQ=
X-Google-Smtp-Source: AGHT+IGtXyd+BItt3rn6X/jpNqJUzY4qdsTf8HscMihTjZMzh+ljo42TRhMwCUFPCtFcfX8J/sx+fA==
X-Received: by 2002:a17:902:da82:b0:1cc:7077:c87c with SMTP id
 j2-20020a170902da8200b001cc7077c87cmr24072532plx.14.1699326276519; 
 Mon, 06 Nov 2023 19:04:36 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/85] target/hppa: Decode d for logical instructions
Date: Mon,  6 Nov 2023 19:03:20 -0800
Message-Id: <20231107030407.8979-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
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


