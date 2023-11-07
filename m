Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F068C7E339E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:10:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRT-0004Cd-4F; Mon, 06 Nov 2023 22:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRP-000486-HW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:47 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRN-0001NA-BC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:47 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso4470914b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326464; x=1699931264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zniar5iOVmkHT6sPS3/xZSKtl5AO6s48Oy/l+P1MmPo=;
 b=ZTwNJ6Ocgz6gZXSx/r/K9e+nar2iFgw6SLDJdLbMkcnrnvhPgEmnpAz1PqYj1Lubls
 iU4hbTJgVPioHZjU6lfNRGdtyaEnH+N6ZxK3lrs/DyCHusHUXwBmAarRbYf1bmo9cLnl
 eUbo7UAjbMlNTFfzDA1WtSmESpAaO4eoDghhnfWJ381ZVgNa+mTORJaU6Om/iogOhw21
 AbnIgGMbeT2J5BgSMZZXcKAeHP8sD2KE58uTQAiT5q/Brn3PcKN2HtP7Dby7Uig8hby1
 204RBohVmkyfTshYBuVBbd4HeOLKuzOwkCK4LXccc6FTrKzWtjry8Pgt4Wz7y7v6M3XC
 LBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326464; x=1699931264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zniar5iOVmkHT6sPS3/xZSKtl5AO6s48Oy/l+P1MmPo=;
 b=sJATDSRgynQdtDDastr/TDAEfi/7Tkch2KxQJu/j5xvboRjcl/8Djio6WOXobRGr8l
 W/J2rJFnJohWWlIrq965JJ4m5s5ZqzZqMGv3WDSRZ0pIQrbbLUtp8/mpoyDFuX8DU4Tl
 Wh60Bs8GFgUR/aQzp/oZTSDGNoNEnKdLDLySHLTdEloM1pecUvTi9nsGlMJH5potTXuO
 3bWaiAJnWQtM8QZXgSZ7+PHQ5dFr04A2xSrbJ+uSpf4O5S7OWJv971Zx8JcSVLECvtS+
 Wdw0de/CMZqCaf6Kz43nMjEQcL1PuQwgG3QchaaoQlOtIwLeQA7Nwl5WBrh61sbjxZeH
 z1jA==
X-Gm-Message-State: AOJu0YyzCg9SvxH4vLmHdHFpXqLSMEBIpGHfe/WD4RqQuifJokEEwFC2
 CmjKZAFRXPLgv6w87piQ+2wrsznuiCNUcao9ICg=
X-Google-Smtp-Source: AGHT+IH65VwE8b67XE146o8nLOpM4Rsv0bLrgyHW1z0Gths+xFjsX82uqqlIre++vJoIyMSNUwefaA==
X-Received: by 2002:a05:6a21:4986:b0:182:1c26:e023 with SMTP id
 ax6-20020a056a21498600b001821c26e023mr9480840pzc.60.1699326463768; 
 Mon, 06 Nov 2023 19:07:43 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/85] target/hppa: Implement LDD, LDCD, LDDA, STD, STDA
Date: Mon,  6 Nov 2023 19:03:29 -0800
Message-Id: <20231107030407.8979-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index 1b4fa401ba..4562f865f4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2972,6 +2972,10 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
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


