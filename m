Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAB87E341E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPV-0001Rg-80; Mon, 06 Nov 2023 22:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COd-0007VA-7V
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000hO-6z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so39075725ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326274; x=1699931074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w81PJS53UwmAAbSwfGTJnD1xAO9wqXFrjFhUaqgumJk=;
 b=fuphqHYnwRakjIHAY1wBDCAr29DJinQ74olhOS9V3qJ0+XI1t2hyJDbeeg6uyx+LNM
 Z3onHu6Bon0NfZorQgWnOaek6i/+uQzlbxnKin7mUoFIioEivxUS4BFO2djm2pTAADSr
 Q7mpZvZzx0ISy29wMKfRiOfsNHtQnpOh6UJRXKAO+airInOzbO7RwkcL+FhBDrDytNUA
 oOSjEIw92tr0rhIMiAa7z1S8mvqW8lzZeRokIWRRhPxG+hqnjW1R25Oa6gVsdEYBAbnw
 XFpBALoYXZQhk4kKiKj0aw5oNttpYupGf7LM3ii3XYeJosbMYg2C3kRQQcBWd9Vo1D0q
 b5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326274; x=1699931074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w81PJS53UwmAAbSwfGTJnD1xAO9wqXFrjFhUaqgumJk=;
 b=bmUtJ4wyPvnwIzUUNB0HUbvuvKyaYm87YABjO6Manb7oEerMypxRYrmA0Vvb49Eqfv
 DYGaqgUyf1wKu+FZCWdqjTBSwnjk4b1gwzeHp6VKM1hy0wQ0cOfZP7OG01+zBxG0hkyM
 JgzArx7lLPLWOJDGyUedR+Hvt7m187Gu6mCZ8u7XiRWk71+/pP+RWP2Tuwt3SzETMJHh
 RYxPms9bLj2rdcjKmjmYW/F66uU/sDXaaSvm+ibWXMttCuu2QEZNzxU92aLHVCHEZnxw
 v7iaI4daD2fRgkRPUs3Fpj8rF49yNRRIdCffk2wKebk9v7ZtdpLgpRToStHAcl18Lpqn
 Slxw==
X-Gm-Message-State: AOJu0YxvrZ5AjoI4yS7xA3ol0pcngwP2iAPDN/Gag08fqYFbM7gQbmNg
 vz1zpGNohQK6mBg69mvPnmVJNCX0r6XJYqkFZvo=
X-Google-Smtp-Source: AGHT+IHEuuikAAfa+i2gPhUPnlcxn1UcmDDUQcb8DTHtwM859I+rzdyesflDhMppifbZMRMBXtcbFg==
X-Received: by 2002:a17:902:fb4c:b0:1cc:501b:1d13 with SMTP id
 lf12-20020a170902fb4c00b001cc501b1d13mr17632066plb.40.1699326273823; 
 Mon, 06 Nov 2023 19:04:33 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/85] target/hppa: Pass d to do_unit_cond
Date: Mon,  6 Nov 2023 19:03:16 -0800
Message-Id: <20231107030407.8979-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


