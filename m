Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C27A332D
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMU-0006GU-CR; Sat, 16 Sep 2023 18:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMT-0006GI-3n
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:57 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMR-00047B-F8
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:56 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-57756115f08so2730243a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901714; x=1695506514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiI1ikRhyVL/tIMhmlhNdYz3i3Qs9fvFLCF5rFWDT+s=;
 b=FzernO1c4bksmkGku0NKVtxaUl/YPvf4L0gDgXJoqykSCs2DvAKMK087JtQVYco1Nl
 h3GIEsvGu1DAMWW6mYAwCDazPfZZ4nQ8eXmFvJhfkpIFQNn7qBmjwmd19jWv2eMOZeRo
 V+Khm23QmdRwW6IKBAj/Kh7B6s38axtt1DrAhs4Tn97Pd4K/bSUXbmeMca+pN/4EeszD
 gB31I7d83gx5EbLJFe2vuiAL502QLSK0ssdZPOx9YEccCYus5L/ywWhqtOeGHJRencq2
 EhgMzLw1/NGg5dueMevP25WLtDTQhu2tMo4pDV8AH8u4JaoXl33FP+ZsoBKdxPVAqZX9
 9mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901714; x=1695506514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiI1ikRhyVL/tIMhmlhNdYz3i3Qs9fvFLCF5rFWDT+s=;
 b=eUMY+mDYJ2IUT/5X2QnzYUfHxRiGJ2902gtsFk2cjCH5lg0eEdKvC7dwGX+KCbUHEI
 hMTMVXe6URDmn/CHJbIummpJyFMz91eU3pk8MZX7YlbcpsLQf8phFyaHy3litKTjnO8z
 ZaD0J1z0FeTMVJ4m+AvXVi0E5nyg3/NigVKgrC4Vq3T4q+qI9wm4fEVLArMe1BCfsKW+
 qAfv/ycILnT0Gi49Fsr9jVHERYQQZm0UDnmKZCMFZ6pnswH2haP3/5Uw/3qbFL4Tnrfr
 cGfcUAtl38JQUDM92bBWoRSI/VyJ/7lupAK4KnzN+FV1AHHZTRvxO6OU8ackEnvJUUgW
 C6Zg==
X-Gm-Message-State: AOJu0Yzhq0uFCePcG+xrG/0b+6P8/gLFTNTjA3wB+wpnsgfcKhYKRhwQ
 QlMEQKDRBfXXhFWToq2k5OSLM90dC4TkpMixlbA=
X-Google-Smtp-Source: AGHT+IEN0hjjXF5zFmr6dOaXIdiT/CV26we8wvhscerrcOpm7HS6sMqJNXqYNd4JOjMNxrrRj/eaUg==
X-Received: by 2002:a17:903:244a:b0:1c3:dafa:b1e9 with SMTP id
 l10-20020a170903244a00b001c3dafab1e9mr6571508pls.10.1694901714058; 
 Sat, 16 Sep 2023 15:01:54 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 1/7] tcg: Add C_N2_I1
Date: Sat, 16 Sep 2023 15:01:45 -0700
Message-Id: <20230916220151.526140-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Constraint with two outputs, both in new registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 604fa9bf3e..fdbf79689a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -644,6 +644,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4),
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
+#define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1),
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
@@ -666,6 +667,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
 #undef C_O2_I3
@@ -685,6 +687,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
 
 #define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
+#define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
 
 #define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
 #define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
@@ -706,6 +709,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
 #undef C_O2_I3
@@ -725,6 +729,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2)
+#define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1)
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1)
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2)
-- 
2.34.1


