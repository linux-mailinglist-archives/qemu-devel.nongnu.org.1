Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA887CEA81
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESp-000253-Jv; Wed, 18 Oct 2023 17:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESb-0001cj-Ar
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESY-0004U1-DD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so5750796b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665929; x=1698270729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTsHGEmbn21c10ys+IjqGnSmEEiyrrhk+QQul6l60rI=;
 b=nKnKRpkpSWxDkshiyJr7QXtzsFM1jq2Iz4ymY6lpSJ+omHKqlQQXr6Ifg9vT5VYuzM
 LZF1FU5jNlicH+Gv5iethsT9V8veDUW8U12WITfXrsa59o1fIQ8fq0dhHCWYLJX8cMu6
 du+bTTH6vhykQlqOg4PBgxhwKHS6Mm1hdjI1SZHagQX9LbtRtK6u1KsejK8FsYlpuELh
 0UbDs9Uu04YAWjqm+kV3bqX0ZYY26yUf+6bsTcTm53b4UTuEFjaMTTVsKfsavWwgRgzt
 6UAnVL+2J/ITdlAS3CVrGwnriQNO/atOGPt+R7B0nX/WYZeOYhMXCdHbyVr2tpcL+avB
 VX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665929; x=1698270729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTsHGEmbn21c10ys+IjqGnSmEEiyrrhk+QQul6l60rI=;
 b=Z2we735haMmFXwCgt0Zp5AhcUbP73mJsBe0IdvFIr5TWn0oH8FyVhph+DeeVJVe6E7
 E0BikIHZjOd/p1kZFt3c2dYv/JA88HsiFkMyufbCd7l73Rb83D8ZuCO+HxkPMhB7stbt
 xlIfd2z+ainRhxORNygm9HvlhHKf9XRatBouO76RjKjIUIY49ivk2Kzfko2Z1CUQoN6Y
 TvRHQCr2vWSI7yx1f5KN2fJjpa0jRm9EvDKrta2V4VJouZEQZls4Ox+2Q9m/Sw8qZuDO
 5Seo7mtypJXRgFBPjwh+EZQPkQZc4McfxRmooVwo5CoIcV1fV7GIc2vbTC3RzgeaTmix
 vDMQ==
X-Gm-Message-State: AOJu0YyGfc4OPOWCABUHtGOl8Pn4S32lDRgXRY0QbdyqsmBjTEFyo2vV
 J5TGM/Vg+bcnvnFeDYIExa1xERYGa6xAgKXDxNE=
X-Google-Smtp-Source: AGHT+IG8VJc+U5itxrLHYvJ0Z+v6jIbnbbHHbXX/1s77fHNc8Nrpa6NqUogvE1k793smam1mbllrhA==
X-Received: by 2002:a05:6a21:4881:b0:16b:79b3:2285 with SMTP id
 av1-20020a056a21488100b0016b79b32285mr391796pzc.56.1697665928827; 
 Wed, 18 Oct 2023 14:52:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 39/61] target/hppa: Implement LDD, LDCD, LDDA, STD, STDA
Date: Wed, 18 Oct 2023 14:51:13 -0700
Message-Id: <20231018215135.1561375-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/hppa/insns.decode | 15 +++++++++++----
 target/hppa/translate.c  |  4 ++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 48f09c9b06..33eec3f4c3 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -215,9 +215,14 @@ ld              000011 ..... ..... .. . 0 -- 00 size:2 ......   @ldstx
 st              000011 ..... ..... .. . 1 -- 10 size:2 ......   @stim5
 ldc             000011 ..... ..... .. . 1 -- 0111      ......   @ldim5 size=2
 ldc             000011 ..... ..... .. . 0 -- 0111      ......   @ldstx size=2
+ldc             000011 ..... ..... .. . 1 -- 0101      ......   @ldim5 size=3
+ldc             000011 ..... ..... .. . 0 -- 0101      ......   @ldstx size=3
 lda             000011 ..... ..... .. . 1 -- 0110      ......   @ldim5 size=2
 lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2
+lda             000011 ..... ..... .. . 1 -- 0100      ......   @ldim5 size=3
+lda             000011 ..... ..... .. . 0 -- 0100      ......   @ldstx size=3
 sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
+sta             000011 ..... ..... .. . 1 -- 1111      ......   @stim5 size=3
 stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
 
 @fldstwx        ...... b:5 x:5   sp:2 scale:1 ....... m:1 ..... \
@@ -244,6 +249,8 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
 # Offset Mem
 ####
 
+@ldstim11       ...... b:5 t:5 sp:2 ..............      \
+                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
 @ldstim14       ...... b:5 t:5 sp:2 ..............      \
                 &ldst disp=%lowsign_14 x=0 scale=0 m=0
 @ldstim14m      ...... b:5 t:5 sp:2 ..............      \
@@ -275,11 +282,11 @@ fstw            011110 b:5 ..... sp:2 ..............    \
 fstw            011111 b:5 ..... sp:2 ...........0..    \
                 &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
 
-fldd            010100 b:5 t:5   sp:2 .......... .. 1 . \
-                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
+ld              010100 ..... ..... .. ............0.    @ldstim11
+fldd            010100 ..... ..... .. ............1.    @ldstim11
 
-fstd            011100 b:5 t:5   sp:2 .......... .. 1 . \
-                &ldst disp=%assemble_11a m=%ma2_to_m x=0 scale=0 size=3
+st              011100 ..... ..... .. ............0.    @ldstim11
+fstd            011100 ..... ..... .. ............1.    @ldstim11
 
 ####
 # Floating-point Multiply Add
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7e723dcd24..308b8dd263 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2951,6 +2951,10 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     TCGv_reg zero, dest, ofs;
     TCGv_tl addr;
 
+    if (unlikely(TARGET_REGISTER_BITS == 32 && a->size > MO_32)) {
+        return gen_illegal(ctx);
+    }
+
     nullify_over(ctx);
 
     if (a->m) {
-- 
2.34.1


