Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F97D176D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLt-0007pM-BV; Fri, 20 Oct 2023 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLQ-0007iX-K5
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLO-00089d-CS
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:43 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so1210179b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834621; x=1698439421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcidF9Jk1N+Ej8dbQUUvFmfE2V7LiGtPgLbzAI4Qab4=;
 b=KmYY5kSuhKvWvreARar5znrPZwqqrCquIekLLmI9/Lr/ARU9EPyZZuUTlfnUBXh2gm
 YJ9SP/gQiaG4EHIEDoPO/n1kGn726U6CKF3RNuVHlLapOUHAfTBux1hl1r2m3gjwGcMp
 +bFuCVkvywD1lot+ohOrexCG8svDxt69Wcz75SO84g8Kj/Ds1Ek0GdTMW3JY8RvuFSIr
 EDXRtWVixTCGAnIgL4DW6vylvRPSFyedk0lRGQ4tbjCVkFU2Qli9+HhvmEt4gxuSkNxW
 Rcm1ODiHQXNV+uMURY2phNRfLKgW8bTaHfqyEaI6z9Qyr/D7IKWIdNAQXU/I9tdYuTA0
 D1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834621; x=1698439421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcidF9Jk1N+Ej8dbQUUvFmfE2V7LiGtPgLbzAI4Qab4=;
 b=r6BsAe4z5OyxBrgxMyhIwKXQsp//Ig7I0DuUSdSBaHvmNTBY2mTBxekoEQTuXDFjur
 MJtfE8KwPkXIMiLFNn4/wKdbHUMzqOUhIvOXpbev2DEktS3aoaEzLz1i90+GCfIRGoZZ
 aCHXond4IqYwM1ddU2/0AaYHIHU2lTYG7D0PdK43XlI0j/8LYMzlZXWLu+AB63dnWdEw
 2wG3EyUPF2pMI/deuCzG/pa4LmcKqAxuTZpV9Y7Tsu0ctL7BAtOgBxsT979X+uI3yzuy
 9i/kji9PO4XR8W/TsIn6ZgFd8KFTb1C90z2ueymGtKm/z70NFzodWbl5L5tx/iRYIgYi
 xvfA==
X-Gm-Message-State: AOJu0YzUBgMYqS0bdu1+2+h7y6CRu5sQYIANAIWJXwpM5HXHaNbSokY0
 Q5/+AYRhCVJ5bIV7Vdj42yz9K6Pd0Ye2OA/1XnI=
X-Google-Smtp-Source: AGHT+IG2VzdtieHwUPaLTUo80MnvMR35uXisXNK0sntO+EJ50z1PhX17kCIjz4B6zyGqlGQFlE3qUw==
X-Received: by 2002:a05:6a00:10c4:b0:6b5:608d:64f6 with SMTP id
 d4-20020a056a0010c400b006b5608d64f6mr3132210pfu.20.1697834620857; 
 Fri, 20 Oct 2023 13:43:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 08/65] target/hppa: Truncate rotate count in trans_shrpw_sar
Date: Fri, 20 Oct 2023 13:42:34 -0700
Message-Id: <20231020204331.139847-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

When forcing rotate by i32, the shift count must be as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ff559ed21d..e6ab113a1c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3105,8 +3105,11 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
         tcg_gen_shr_reg(dest, dest, cpu_sar);
     } else if (a->r1 == a->r2) {
         TCGv_i32 t32 = tcg_temp_new_i32();
+        TCGv_i32 s32 = tcg_temp_new_i32();
+
         tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, a->r2));
-        tcg_gen_rotr_i32(t32, t32, cpu_sar);
+        tcg_gen_trunc_reg_i32(s32, cpu_sar);
+        tcg_gen_rotr_i32(t32, t32, s32);
         tcg_gen_extu_i32_reg(dest, t32);
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
-- 
2.34.1


