Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74C7E3381
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COO-0006cy-AQ; Mon, 06 Nov 2023 22:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO6-0006Ml-Jr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO3-0000eO-6r
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so42291265ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326258; x=1699931058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XeA0a/Gb8/dUQrnhDd66G5WVnhzf9jbEb4csjTyLblA=;
 b=cnXub7n30amULc0PYLhtnKN0cPL6PqpwT1+kbo3V3fOE3jPwKxjFgcIsZUJ8UVXgTQ
 TruuvL58agiTC+w1+fRzX6NHT3XcwMoggXZDBIbU4K+g0KmsSGISlCNZGfP5NMblOldQ
 xJYJ+dixld75Qwws7F14eFud0j2p2ygVR/+WcIF2ueSWZsod5KdFfqBaqWOsb3JR7xgi
 mLeBLYETAayOTuoS06KNjnIHDDmDRxxbGgS83F94XSllQT9/n+1tSzRhppF+0OJp1Lss
 oJPOdLMQb6PItHZXgXJ1vsOmmQGkESDe68vA19oJYZZ1+Ti4mwFGzxl/RXCKk4iDUMQj
 o6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326258; x=1699931058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeA0a/Gb8/dUQrnhDd66G5WVnhzf9jbEb4csjTyLblA=;
 b=QO81IO4BVNa/Jrlwo3vbfazYqHffwL9bVzE3pWyrQwj4cw2Qf9zpEUUvofH8hDbRsm
 SQk9a0T3ytXvcfEPTNGPohZOTHeJL+Yf3/5J9nnO5bT+cPpkNv4R1jhHKj+knnr8ZqK+
 qfKHS65cnQlyJlVLZZItbWOHp8MiyFm8pplEpGlaUQLLDofhKC775t8MlL+muoC73v+0
 1NoQrxDhsH3r8xl/RiDn0cIHJmecAwKOA99wgxZvMdGpamumQs8PDTS3dhD+JmNMLJcp
 V2HgfKBqBVbFpjZnZuA9TvuH0eUbshZdQASOYOtmCq2Rsev+t39xCTA7Z3klcqUGBrYL
 zGzw==
X-Gm-Message-State: AOJu0Yz3HoXQjwdHr1MKr6uUDQL61joT62suPRzIwWmWn3/VurkvmUG9
 pZew7AT6Qg/820oPRgywWsouSc5NcAo/WdL0AQI=
X-Google-Smtp-Source: AGHT+IHj4SYnkGeRdZwYsoa+w9K08w1+mMT4BHUm1g+drn0rHDNI72+CqlXxgTPLDbesKCkc/CE4UA==
X-Received: by 2002:a17:902:b783:b0:1c9:b207:d40b with SMTP id
 e3-20020a170902b78300b001c9b207d40bmr26141667pls.38.1699326257771; 
 Mon, 06 Nov 2023 19:04:17 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/85] target/hppa: Truncate rotate count in trans_shrpw_sar
Date: Mon,  6 Nov 2023 19:02:54 -0800
Message-Id: <20231107030407.8979-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

When forcing rotate by i32, the shift count must be as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 20e44ed528..d6ccce020a 100644
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


