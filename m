Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F749E038D
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Dec 2024 14:33:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Uc-0001VS-4x; Mon, 02 Dec 2024 08:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Go-0002gR-B9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:27 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GX-0003JE-VH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:21 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so38314145e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145270; x=1733750070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNFUiJahMuoZ73+h4VdLlQSeFpgNJO8VlBUcPmwjIjg=;
 b=D6PkyBbDwLWkImPBRDx8kWKYND6zON3vONTdDm3wp6Nt+Ej6d9jLLBlQE2DeuEX8W0
 rWC9eEpeMmsheuJSL43NwytnUHoTJnZp+7AEtfBF3UnDVkg68otdA1uH/z+p+perh48U
 vGNevc6hVHBMpmsJiNva9lg9zF2uK9pfofM+uYshHCGd+o2Ccp7pnwl8xbXIhjBBFc6o
 hMu7VDY0iRMCbTlMnp1x5WqlshPGiH4ijncLjHdjPUSQDiojyutrrooCeSN57ukD9Vta
 htXrj+PS8Bd4/UU17rjuuT0BOhV3xzE+tzg1OjyDTAaGZlUqg9r+uHob4gxbQW7ORRKb
 sLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145270; x=1733750070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNFUiJahMuoZ73+h4VdLlQSeFpgNJO8VlBUcPmwjIjg=;
 b=speeLHRUkHBvFOy2pOVpk3nuqqPw7QObJvJeDFKEuhVLxqi2GNpJf8LuL6WjIi4/UJ
 I72GAzkLmOZMsyPF9TYRoMWOGAJHLKdbP7mvqkOWZzpmwkANz0dEBPq1aRoWrxGO6sGS
 wUOk+1qTLnM+/mU4UZtdJ57haFqFn8qcwEVrFZb32nck+URTxf7F7hgvgEHsKiQ5N8yL
 feEZIOKcbPB9lSveHXlDa9xCM+sK5kTEHEKNODN6f4sEyrmYLIEe2lgWX1hnL+b6tgKj
 D30hKpB+Sq19DVErQhbnZD8b5wgiUtBfAJUz3ctw6V+OkStln2cYR7Je/Y31v6FE1Isl
 sQgA==
X-Gm-Message-State: AOJu0YzcW6gfY6I46dq8RabxyL19KcIm3SqFmN09vJeR5bMXyvM70lnf
 Jfrjjj8cXXo0ibE/olFxgVeHeLOU09kOFZ4n8tKmCMOp3AYzUS2DI309vxjSrqOC9GibcIQZXm1
 A
X-Gm-Gg: ASbGncuMCuxFC7YTxzzzX6doXHa12Y2mYfa4iC5uprIoLeGMuQNh+zp1D7g3pC9Efo+
 WdJpkRVRdJTVg/xouZyCq+fAsOIUlFndxxrtZMGde2FRYDM1ISapFDUx4JbiwScpkWVOrlhhYU6
 wvDfu3JTKlp+eCE3QDwd9F29rbrlyW9xNX5KOLH2HTipubVqzE9yDAPUx5TsOviCs2Sfp3upMei
 R9TNcADuEf+CrdKbv70JOQJ9lA2CPzNbdz77Mseu+tsevxH4DpNlfg=
X-Google-Smtp-Source: AGHT+IG+zglFH9P/OX2WF0mcI3v1zFBJH7Yyk//lwFwNB2aXYaOsIJ+XlGXo6dHgb1+xUJgb5Soqtw==
X-Received: by 2002:a05:600c:314a:b0:434:9de2:b101 with SMTP id
 5b1f17b1804b1-434a9dbae1amr203940025e9.2.1733145270515; 
 Mon, 02 Dec 2024 05:14:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 23/54] target/xtensa: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:16 +0000
Message-Id: <20241202131347.498124-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set the Float3NaNPropRule explicitly for xtensa, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/fpu_helper.c     | 2 ++
 fpu/softfloat-specialize.c.inc | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index f2d212d05df..4b1b021d824 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -62,6 +62,8 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
     set_use_first_nan(use_first, &env->fp_status);
     set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
                              &env->fp_status);
+    set_float_3nan_prop_rule(use_first ? float_3nan_prop_abc : float_3nan_prop_cba,
+                             &env->fp_status);
 }
 
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 28db409d22c..67428dab98a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -505,15 +505,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_XTENSA)
-        if (status->use_first_nan) {
-            rule = float_3nan_prop_abc;
-        } else {
-            rule = float_3nan_prop_cba;
-        }
-#else
         rule = float_3nan_prop_abc;
-#endif
     }
 
     assert(rule != float_3nan_prop_none);
-- 
2.34.1


