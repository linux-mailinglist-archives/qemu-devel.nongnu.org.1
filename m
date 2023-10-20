Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C27D1738
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM5-0007yx-MW; Fri, 20 Oct 2023 16:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLq-0007ou-Rh
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLp-0008HI-3G
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so1107497b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834648; x=1698439448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vblR9i+m14sVOY03KrOJimUiWRKcg8IN+vUxURUwc5s=;
 b=UyHlBw9sukJKn0PECtYQKmJsZxbzA7CSJ2Xj1W47PUJZY52FFuvSV9AAdUqf8/vW4F
 ksYoMLgI2L2GlL53TVR+egfCurCbLxFX2Xs24DZTmGymyn5msdyCZjW53QKU0HdnYu60
 fORxE25na+fNywPhnt389G2Mgd3e34+oinAp585SxzUSdXnvnZixRYJM0CvDClTSOewo
 A3wKJ/EzxLc58BfCx1PlCJFYMKsTI07T9AdVsLuuz2WUfQwYvlwiyl7HwuJPo5vh/aWY
 7Jj9Fax/dSLLR09pZz0tmK/BTf24htv3s+UhckKVAUONee6A9gE1dFVhzfPwMqizDovv
 6xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834648; x=1698439448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vblR9i+m14sVOY03KrOJimUiWRKcg8IN+vUxURUwc5s=;
 b=d0TYmR+ex1BT5zzhzZsci3gGyqBG5JUneYTkTLoG7t7MKQq7SJlsxFsY3OQLuDacHd
 wCEtlLo0jVjr0Ww4CxKtjYshXOgHIF7EtjQajeZJ/x1s3BfYewwbRZ6eW+wEtboVRmLJ
 cC+7Mq2z0o4D+vxgg3Q+Rq2PeTDN6KtNLmrRdZA7Ijju9gA2SEpDLAUIQSl6pVKBLDJe
 g3oelhEofrnAzW77TFT9V0tQMtkEyBxn2uzNjtsVhZ+8lG4stydkcFnO1o/iw1evFC6q
 qhJGxO4ouikz2EcFFxGRDtxRSRjW0y/+bIdG3tOjiXZr79hxFsiQ10ug/rWDeCPu08Gd
 6y5w==
X-Gm-Message-State: AOJu0YyYS3wGB8bZKZhr3nE4CnBMKJtu2gnex0HWhVQVhnhxYaandOVu
 e49iIfUSM0gQx7bQfQDVm3k+SjnqhR9o6GAw2Go=
X-Google-Smtp-Source: AGHT+IGppTgobgIqzA/NtSJWJhr+ufWaXcWberFsakpk9Ri3ifVSYWHfpSCQ9tODMf4MdB1UAC5lzQ==
X-Received: by 2002:a05:6a00:2395:b0:6bd:9588:bd67 with SMTP id
 f21-20020a056a00239500b006bd9588bd67mr3114578pfc.24.1697834647868; 
 Fri, 20 Oct 2023 13:44:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 39/65] target/hppa: Implement LDD, LDCD, LDDA, STD, STDA
Date: Fri, 20 Oct 2023 13:43:05 -0700
Message-Id: <20231020204331.139847-40-richard.henderson@linaro.org>
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
index 21f2819d12..da1dd7d74a 100644
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


