Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC97D1759
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:47:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM3-0007yO-KY; Fri, 20 Oct 2023 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLk-0007lI-3X
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0008Dn-ID
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so1225089b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834636; x=1698439436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2Fl5YhgRkzSF9REjLtMOkcrzmKFDkU8I1AFTwJdP2A=;
 b=vcvQZwCJ2UXqZUx/rEdiLvl5rQtfm+5CEraMApVzNpOE3Y4ZGaxu2ucRPjlA3BaZT6
 V3VJphOYcNisLP39aeFW/XPDuDSFOmkdNOMdo/lKODdRnnmckX4dTttKXA2C/7cBYood
 7gX6Do23JLw5ctE8XExQDIk38MGuU5WaQpiuM1hYVXoU4iErtArEGs0KXZmKq9CyvYJM
 +VoEg4skgOcxTZyCxAhUGDY/pRFisqGVzbeKFtwKU00vRxQZ4EgxyeXv1zbpdo2nH7EE
 zARWqw2LeeKMl1IipgpEJyhUvFaG7FT/kQicVELEHtDmWfNOUkE5viPVzb83AgAScsUO
 +2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834636; x=1698439436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2Fl5YhgRkzSF9REjLtMOkcrzmKFDkU8I1AFTwJdP2A=;
 b=nkzLefBNn8jzaAqwMXfRluMHPTSxB3I/Z/trRvALiH0jYQuJDXYrwswQJFLBmK7t91
 QdfVd2H4IkU38VGN/E32vYPMQo8ajduyTFuTsuMwCBRPc/NeBBpeHHVfSPsB+W6/5dfC
 S+g9JEQvppJ8zDvhubz42PdfkUM+QXZ/pjHFFljQ9jjIMfSYZdjWTtc7hPzYRktaYZJt
 /fqUmWUjMCn+PFefWi+HJqOFT83Sn9CwBWf62olrJIR6PcfOY0xF/4Cpu/ruxflWLWoe
 GfSCatWMvQMILwYGisXS7eAiomwHEC4MTh3VYu98chV40W+Kf/GDn+LmWo2YMHl8gxYs
 uecA==
X-Gm-Message-State: AOJu0Yzamdm0JV4d/TS8FeXrfjrgPWhlrIo1Ny19UOnVp0Jw5CsA6yHa
 869J4KD/KBqQtxqhaQYA+Diy/n6T97n0HE4/ooE=
X-Google-Smtp-Source: AGHT+IEC5+ZzB0uxsX6Kxlyl107/8O0nB+GJqaSJlzXO5LbLM+79l7jG4tOgh2Ro6MUDcDKDYnSy+Q==
X-Received: by 2002:a05:6a00:10c4:b0:6b5:608d:64f6 with SMTP id
 d4-20020a056a0010c400b006b5608d64f6mr3132724pfu.20.1697834636206; 
 Fri, 20 Oct 2023 13:43:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 26/65] target/hppa: Pass d to do_unit_cond
Date: Fri, 20 Oct 2023 13:42:52 -0700
Message-Id: <20231020204331.139847-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Hoist the resolution of d up one level above do_unit_cond.
All computations are logical, and are simplified by using a mask of the
correct width, after which the result may be compared with zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9995749237..be1763cb45 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1056,11 +1056,12 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
 
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
@@ -1087,32 +1088,32 @@ static DisasCond do_unit_cond(unsigned cf, TCGv_reg res,
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
 
@@ -1428,6 +1429,7 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 {
     TCGv_reg dest;
     DisasCond cond;
+    bool d = false;
 
     if (cf == 0) {
         dest = dest_gpr(ctx, rt);
@@ -1438,7 +1440,7 @@ static void do_unit(DisasContext *ctx, unsigned rt, TCGv_reg in1,
         dest = tcg_temp_new();
         fn(dest, in1, in2);
 
-        cond = do_unit_cond(cf, dest, in1, in2);
+        cond = do_unit_cond(cf, d, dest, in1, in2);
 
         if (is_tc) {
             TCGv_reg tmp = tcg_temp_new();
-- 
2.34.1


