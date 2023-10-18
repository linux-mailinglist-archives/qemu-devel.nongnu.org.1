Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB33F7CEAEC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESn-0001zy-G7; Wed, 18 Oct 2023 17:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESQ-00019q-BD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESO-0004Rf-53
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:01 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso5473239a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665919; x=1698270719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7IvWHKNslLXyxg2gDsUoAZIYZRNssROan/QZtA5zx8=;
 b=C5MnWHZoTGAv0Z3nTmEM8dpenBbjFupjo4DxWkzPdQar78cyjTymNq8VglYO23Dkfu
 sTnfQIEE6oWz+nawwK+NSxTpJ8xwWNXh+YCfD/nId+VVwNnG8FiZGg35JfwTBWXlNoco
 yMVl853X8qiU6ykwCpnBysL5g9zBTWNQufWwsND+VZpQhAGgIC/nhWoG5+EQh1TrquWj
 IJd/7HqekQ/mteeHxpqxwkTP9AgTJBIFS/4IL3EOse20Z7eFVHR+6TPGhaAKdhFTVnGs
 PR+DQdqqdggWoWXlBIWccSRwJYFKbXIum71949tFF99k4M0+rF6aWhN2toxCwf4MAz9h
 QHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665919; x=1698270719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7IvWHKNslLXyxg2gDsUoAZIYZRNssROan/QZtA5zx8=;
 b=WO4TrnPht+d7KRi64U17dZ2qMbuSS//+/dWQkBvgkzy93uKmFNOcHHzgGXxM33wEYa
 L9B/MEEqYpQVsXvzGRRD8o5u/XN/IYJCOkoRwbez7O46mWt13Olt5om9OEPcSy7n9COw
 GHqwmkzRKmBq+n/EBa8H52oLdXC0N7eWyWVwTuWjgtrqS8P+BFePRcwvjoiJDNM2QpP3
 l5aPATzaUABfOaxbaEqxjRqBivraY+942tib4kGTLx9W8k0IvOfGtw8x9KdK/ZnXtkFr
 NalTc4cyK5ZgaZx8xYYzVBrE3dYPmhTopEhP3acWri9GaXpkSRjB3JUakcVbvmTA4pTv
 I+2A==
X-Gm-Message-State: AOJu0YzDckaNj1eoIPYTUq/fQzc63+xfcC99ZRbS2B5yVp97GyieR3K3
 DzhQMSSbin268cU8zABU8nYaCUEMEV1GZduqO1o=
X-Google-Smtp-Source: AGHT+IH3qtik9S79chgKlomdD8n790b7kf8E/DYGA19itm2Yjfbp1pfn8ZzI3uxz4j+4AMNb7clmqA==
X-Received: by 2002:a05:6a20:42a0:b0:16b:c9f2:b632 with SMTP id
 o32-20020a056a2042a000b0016bc9f2b632mr456356pzj.62.1697665918873; 
 Wed, 18 Oct 2023 14:51:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 26/61] target/hppa: Pass d to do_unit_cond
Date: Wed, 18 Oct 2023 14:51:00 -0700
Message-Id: <20231018215135.1561375-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
index 1a51ac4869..8bea28f0fd 100644
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


