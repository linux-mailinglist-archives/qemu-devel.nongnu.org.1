Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E67DC035
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 20:04:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxXYU-0004M1-31; Mon, 30 Oct 2023 15:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxXYQ-0004L8-H7
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 15:04:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxXYL-0007b2-Jl
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 15:04:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so4852339b3a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698692636; x=1699297436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYXGyY3c6l0fZmqh6nppMUC0FBeMhdGwui5xW/qk4O8=;
 b=UPdAQ+m2wfjVoEeZYAwx9K0GZNmKIJeKK83NfYg6D4QP+4g/Ane+uvkFEwMGRSw6Lr
 ebzQuHyv5+LUbA0Lq2nJA4VGCxd3spFovJHfaEblcxFNUrsoN8qJZB2CDwuQLgXRWoAg
 8kztnFNdXQNwm6Fh2Uu01ihATvxmPFEiqr2FofdvqXwJtOWAd5qvhKH+xiWGMTQEowKE
 Q6vPc0JDHPYBksMtAocMilqvr1mWYeiQeLa+3CrIEW7dqlH/sGRD1OyUmWxJjbzKNd4K
 Xy2KYrIyDahOBO7y1Wj51V0ql62UN7UaEnOY39335s+wziXBEyJCV9m86HzCg+LOQkWF
 ILNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698692636; x=1699297436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYXGyY3c6l0fZmqh6nppMUC0FBeMhdGwui5xW/qk4O8=;
 b=hJrrbv29b0njYTEaTilZXPIizHEClbUNcqwLaiOHYK0rDScc/yWCv1QmUvlforoSoo
 CobRXKiWsTeyEImTsDzr6hwo8q/DVAh1wUHN/EsOAIxWu7R3rmHYnPPEJ4gRJgrrJQga
 xX2x3knl+qO0JcKSGUpgFhhK2HInxtqVkrj41LkG4r9u4qGvaJeLJ3zf8ElPJR0amAPz
 gLlfu+ijfR6eILMRWQyz99hqfY2NyNuIGBy3K+lzIOP4aKhpJrkszE/ch4AGJafb2IG/
 2A/D8ZTmCsftC0ya8Wo5u9lKWL6oVWzFbUvhg1DlcBccgiOJ6/ADnzkF1vQAS8RXi7vv
 ZOGg==
X-Gm-Message-State: AOJu0YyRKuZ99qt1T1KbH1pMkg4tH0+GzQTLF2PoUmpxaLP2RlvTKi2G
 XUXJu1YboOO8T7clQRITt+yC1F9kD8S527F3iHk=
X-Google-Smtp-Source: AGHT+IFTYGG9kytI+vV1b1wlTkcqdF/I75j4PD03Tx/S8smDuUpVDu2EMjVNpb1PHmunYeqhn4ZtAg==
X-Received: by 2002:a05:6a21:998a:b0:15e:ab6:6e24 with SMTP id
 ve10-20020a056a21998a00b0015e0ab66e24mr14728980pzb.27.1698692635896; 
 Mon, 30 Oct 2023 12:03:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 du15-20020a056a002b4f00b00690c7552098sm6211477pfb.44.2023.10.30.12.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 12:03:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix SVE STR increment
Date: Mon, 30 Oct 2023 12:03:54 -0700
Message-Id: <20231030190354.94671-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The previous change missed updating one of the increments.

Cc: qemu-stable@nongnu.org
Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7b39962f20..fc4220114d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4294,7 +4294,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         t0 = tcg_temp_new_i64();
         t1 = tcg_temp_new_i64();
         t16 = tcg_temp_new_i128();
-        for (i = 0; i < len_align; i += 8) {
+        for (i = 0; i < len_align; i += 16) {
             tcg_gen_ld_i64(t0, base, vofs + i);
             tcg_gen_ld_i64(t1, base, vofs + i + 8);
             tcg_gen_concat_i64_i128(t16, t0, t1);
-- 
2.34.1


