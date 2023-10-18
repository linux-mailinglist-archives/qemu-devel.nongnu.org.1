Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D27CEA4C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESB-0000sv-Io; Wed, 18 Oct 2023 17:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESA-0000rt-Cu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES7-0004Nm-Sq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:44 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c4e30a3604so4809466a34.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665903; x=1698270703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcidF9Jk1N+Ej8dbQUUvFmfE2V7LiGtPgLbzAI4Qab4=;
 b=JTOUyhC/XUy7Gr2RsMUbu28dzfSfUr+dCgUrTh8sJyk76u5B48M0m8Z6xelUUjLrC+
 DC6bCjJlw1gIR+K3FS4lLWhPrmFsBfw+TTz102t83RFIVpm0/3ki5c4wcly9gsEdo9eY
 SqPY8t+LIzPX2Ag2v4X1blivRdZ52oKoDmRDA4AWVSbO3P8ulKk6DdyE8xXBAcd4iKUs
 yzyiRtYcja7UsiJwns1UNA2tnxZ4rfAxNQ120iwqG5sqLyTfmNz8YRsI8UeX+D2DOmj5
 nt70QsyGq8hlE1DkKVpDVfyb+C1N+paqMrblYD9+9kGO2xd616EIOV+HRBgXyEKmRsjN
 ElqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665903; x=1698270703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcidF9Jk1N+Ej8dbQUUvFmfE2V7LiGtPgLbzAI4Qab4=;
 b=fWPCZ0giKHrpqMuQqVrUoAUL9Sl16nkOM4JF6/eZLP3dqBbPtlzx8mAC57FFwPRvm8
 nq4Dz8wRBghq0B/KP3RX18S5Gout1ebOeWelZLfBH8UUZzCqzXqyPsk0oFm/ShltKNBs
 RzbPxpAq8lGGr5fejSUjNXlPm0lb+ghSDwIWgpakk6PBOxOonJX9ZdISAOcbP15jaRuT
 SLvTIXQSyP4zU9izMD/FHSFnBJ2vkbqwv0AYW5rRJrErUWE4C2phZxbxslmSIAa3rGCB
 j22IvZuervzdxOhIouU+cgzWsjnxydeDlrdbB2NO5al+Gz09BCH7QJWmca/Hqq08US0R
 6LkA==
X-Gm-Message-State: AOJu0Yz6yciU/CF/ZJk0nCKuduehhI0S7TdK2vp7es3f6qzDmsmM0oDk
 fzyXdiapmumiP+ZkF+5lr1BipoZeeAHosRivPLc=
X-Google-Smtp-Source: AGHT+IHq8gq5WNv79G0npEBQO80O/8sCgsrm6J8tqgfPizeAssLpEMOdCtvHI3xxuhvwqOFlHLNBCw==
X-Received: by 2002:a05:6830:2641:b0:6c4:aa6a:c4e7 with SMTP id
 f1-20020a056830264100b006c4aa6ac4e7mr513901otu.10.1697665902723; 
 Wed, 18 Oct 2023 14:51:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 07/61] target/hppa: Truncate rotate count in trans_shrpw_sar
Date: Wed, 18 Oct 2023 14:50:41 -0700
Message-Id: <20231018215135.1561375-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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


