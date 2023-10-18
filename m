Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0D7CEA59
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:55:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESc-0001cz-Af; Wed, 18 Oct 2023 17:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESE-00015C-I1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:50 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESB-0004OU-6b
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:49 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35749078a59so29497765ab.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665906; x=1698270706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6DEfOhGSAuzHVOiFy6ZRmh1nqeZSzZi7HDKv5g8+j0=;
 b=mAX1CG8eaS2c6s2OMWAjQWUkDDyiAPnzno2nxLyv2r/k9uVfJ/X9/pSs9L4NUlp6To
 +NPHljC0cb/DrPKRqMYzjJSR7HYjLZGF61H5eJTgwUOb0xiygJfk7G9sTV+9QDjkdAQU
 zCOcc7d835IIWCcP8wmzgTcm1QnpFdEIx4F+BCXz1J+mDc6hzDP5Wyju9TKdORB6BMhe
 dvKBRoSOyCQsL4bbcKm9DzHdb4nO6yxnigDcnHfz/mldNqo/rofm9d8SUrHdYBjOFTil
 ekiAIP/Yizl6NXbYBpF/+e06yAdefinB1676CLoXfLYct6zMGK21f5yq6EfnShpTIiwK
 PQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665906; x=1698270706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6DEfOhGSAuzHVOiFy6ZRmh1nqeZSzZi7HDKv5g8+j0=;
 b=guZi7vEECwSVvQlJBqbHKIyKkXD1vZ0WxOZ45upMOtWywgr3zTMxXhiOhk0iuqiKHM
 rMNexcMLsdwlxjmf5LNMgRha8Mdj5Zhe97Egix5R3dg4IW1Omq4IyLAmTn5vmi1rw7Tf
 i7BvjXcY/M/IymrSRBXLGCdITbhbo1Ai7+btTfGp0kI74nnpfgjeeGdwEvHVvfhgmsUi
 Xys5m9iA5/zYJR73yE9/mo1s4dKCudPRhTo6uT6GNb16D4k6y5MXrKdsfY4Oxd2HK4/O
 yrhHwmLwVgXLsOP4JISe56kDRtfPD937E4R33DllfB+R6ruCjS1AUK+N7sc1DzFzB88S
 PELw==
X-Gm-Message-State: AOJu0YyIbn3wSs9ROW6tq7ScKYg7V5JEBrludFcxmckj3IO8tJXKoxWE
 KTWezIIUoiwKUCXNT0XN+/NEdiwVUFoqq6y6gP4=
X-Google-Smtp-Source: AGHT+IF9c4+NsvBZhHxRGkjfJ8Wu2w/FNsbrkV2oI1v/n/t3sAGHgaKxLt6T+/LpVxbiKpC4x3b4UA==
X-Received: by 2002:a05:6e02:b4b:b0:357:627a:52 with SMTP id
 f11-20020a056e020b4b00b00357627a0052mr761487ilu.28.1697665905976; 
 Wed, 18 Oct 2023 14:51:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 11/61] target/hppa: Fix extrw and depw with sar for hppa64
Date: Wed, 18 Oct 2023 14:50:45 -0700
Message-Id: <20231018215135.1561375-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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

These are 32-bit operations regardless of processor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 119422870c..f86ea9b9ca 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3230,7 +3230,9 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_xori_reg(tmp, cpu_sar, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(tmp, cpu_sar, 31);
+    tcg_gen_xori_reg(tmp, tmp, 31);
+
     if (a->se) {
         tcg_gen_sar_reg(dest, src, tmp);
         tcg_gen_sextract_reg(dest, dest, 0, len);
@@ -3355,7 +3357,8 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     tmp = tcg_temp_new();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
-    tcg_gen_xori_reg(shift, cpu_sar, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(shift, cpu_sar, 31);
+    tcg_gen_xori_reg(shift, shift, 31);
 
     mask = tcg_temp_new();
     tcg_gen_movi_reg(mask, msb + (msb - 1));
-- 
2.34.1


