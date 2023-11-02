Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 690057DEA5A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:46:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYo-00066L-Cg; Wed, 01 Nov 2023 21:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXt-0005nu-EL
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:31:18 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXr-0001ed-DR
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:53 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6ce322b62aeso212108a34.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888650; x=1699493450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w81PJS53UwmAAbSwfGTJnD1xAO9wqXFrjFhUaqgumJk=;
 b=hDd/8s9vXaGaZ5Sv0AmNCx3wz5/Bg7TMqS9E6OHwn581buQBYFZsbCWWtycmIxBSP3
 7TR48+qNNrw9vB+UuxFIF4mrHBr3E0NJLxNFeB0NvWdqPmzOf8sfxAKAFcErzGqSYPn8
 uvDecz4eYddD8pAeVWLKjD5OGiOvt6DoGPupPY9UNIgTfTSGWTdBIzxgRjNrCtNpMITJ
 67/atjgVnD3lFcUIm40SFZ/FGc0XnJhGdSoYqRuRoFjl9FBHIi8ieKzwwJT0KJNYtg3y
 rHw/UVBq+Narjey13SdBUhAJi0r5sBiI0wtqJsxHhKkzhq2dGSlSA6O1etcoiOpw1aJe
 RCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888650; x=1699493450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w81PJS53UwmAAbSwfGTJnD1xAO9wqXFrjFhUaqgumJk=;
 b=LGNaPNLRsZTD+DiBKRaNXkLJRhv+TugIbM5cQtX1KtYwjIC5VXRM+1+7D6HF1vTQ4M
 JCbU0TMYiyRS6c4reZBn4lb/HtYTzEw39mdoKiXvwjGbZgTZpBTOacA0D1wKtDrwqwhB
 w6jkN4MSA16E6VgXT3LiFUz7fJfrJKuUezRpFQ0a84SpwsPM7aOWdrZaKBzGS1/+4/2w
 vcYFU0yIjndEnlGgjwPKrsJZTwiAdmP4gcIqwCy3Hvi0rR0zMZ1IO+xlTbb/7Uvf70EQ
 vMIFYCqTwGgj2ri1UK6lAZ1Ia/GWxhcOCHUwLXROOYcRDw5R0IZ451ebHezFpe7rU/h+
 XL+A==
X-Gm-Message-State: AOJu0Yzpc4wleZtmQ1t5u2ZARct9s/98x/PLzc73bI1v1aNUm1CpsUoF
 f+zaXF5ajOTDGOm4AyvxeNu/DAMgE7UijXN23Q8=
X-Google-Smtp-Source: AGHT+IE+1wlsGF2PRA5gmuGcuz24BjyWhk7JOZc/kSf2sFzRGSwsPNRlnT/45Duh1ybAcR0j/Yek8g==
X-Received: by 2002:a05:6830:1d83:b0:6d3:1dc1:6ecc with SMTP id
 y3-20020a0568301d8300b006d31dc16eccmr3146138oti.19.1698888650315; 
 Wed, 01 Nov 2023 18:30:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 36/88] target/hppa: Pass d to do_unit_cond
Date: Wed,  1 Nov 2023 18:29:24 -0700
Message-Id: <20231102013016.369010-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Hoist the resolution of d up one level above do_unit_cond.
All computations are logical, and are simplified by using a mask of the
correct width, after which the result may be compared with zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index eb4605a9c7..41f4e06841 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1069,11 +1069,12 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
 
 /* Similar, but for unit conditions.  */
 
-static DisasCond do_unit_cond(unsigned cf, TCGv_reg res,
+static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_reg res,
                               TCGv_reg in1, TCGv_reg in2)
 {
     DisasCond cond;
     TCGv_reg tmp, cb = NULL;
+    target_ureg d_repl = d ? 0x0000000100000001ull : 1;
 
     if (cf & 8) {
         /* Since we want to test lots of carry-out bits all at once, do not
@@ -1100,32 +1101,32 @@ static DisasCond do_unit_cond(unsigned cf, TCGv_reg res,
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
          */
         tmp = tcg_temp_new();
-        tcg_gen_subi_reg(tmp, res, 0x01010101u);
+        tcg_gen_subi_reg(tmp, res, d_repl * 0x01010101u);
         tcg_gen_andc_reg(tmp, tmp, res);
-        tcg_gen_andi_reg(tmp, tmp, 0x80808080u);
+        tcg_gen_andi_reg(tmp, tmp, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, tmp);
         break;
 
     case 3: /* SHZ / NHZ */
         tmp = tcg_temp_new();
-        tcg_gen_subi_reg(tmp, res, 0x00010001u);
+        tcg_gen_subi_reg(tmp, res, d_repl * 0x00010001u);
         tcg_gen_andc_reg(tmp, tmp, res);
-        tcg_gen_andi_reg(tmp, tmp, 0x80008000u);
+        tcg_gen_andi_reg(tmp, tmp, d_repl * 0x80008000u);
         cond = cond_make_0(TCG_COND_NE, tmp);
         break;
 
     case 4: /* SDC / NDC */
-        tcg_gen_andi_reg(cb, cb, 0x88888888u);
+        tcg_gen_andi_reg(cb, cb, d_repl * 0x88888888u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
     case 6: /* SBC / NBC */
-        tcg_gen_andi_reg(cb, cb, 0x80808080u);
+        tcg_gen_andi_reg(cb, cb, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
     case 7: /* SHC / NHC */
-        tcg_gen_andi_reg(cb, cb, 0x80008000u);
+        tcg_gen_andi_reg(cb, cb, d_repl * 0x80008000u);
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
@@ -1441,6 +1442,7 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 {
     TCGv_reg dest;
     DisasCond cond;
+    bool d = false;
 
     if (cf == 0) {
         dest = dest_gpr(ctx, rt);
@@ -1451,7 +1453,7 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
         dest = tcg_temp_new();
         fn(dest, in1, in2);
 
-        cond = do_unit_cond(cf, dest, in1, in2);
+        cond = do_unit_cond(cf, d, dest, in1, in2);
 
         if (is_tc) {
             TCGv_reg tmp = tcg_temp_new();
-- 
2.34.1


