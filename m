Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EFB7E6D3C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16oj-0004ZK-N6; Thu, 09 Nov 2023 10:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16oX-0004Us-2a
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:19:31 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16oU-0000jJ-6E
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:19:24 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507b9408c61so1250951e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699543159; x=1700147959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LDbBoisi0P3yvHqkaXk81VfJ8YBxJI8aP3fBZsVq+Oc=;
 b=XMr7fqrBqN5C67tptiFDr0l71IHtuH97fM4rt0RDjZibx87trCeujXiUkqy9DgLKSY
 wXlD+BS9jqImFED0DPGisXhtOqT7kJ0yQ5IdaWgDKfiCZGFvoWfDMBW28dGqe8s/eozP
 U4DHpuWyrVKiYG9XzqWT03a5YN3D9kmOa2VNkv9bz3XCOR1sju/uIX0SBzAMPxDwcEfq
 TdUOMefWb2XkXM0TJ/3A3dKSWlUQu4jiqt+iRzE3ZZ3Zt4GRnqi5phGRkWzMqJf3Zrz/
 U17mhORm3f1StoiHP1B4xmH/5/mMfEZAY97P5at8y79iIN6ew0iEW2h0EYU8riByl13Z
 4DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543159; x=1700147959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LDbBoisi0P3yvHqkaXk81VfJ8YBxJI8aP3fBZsVq+Oc=;
 b=k5uWrZCORDwR9tq/7lufmWa92xQA38eNkZIQOuLzBGVB+3EhSVWQSdtCbZiY65rUE8
 7K1N/cfWX41Blf5e8i6Q2D278ZS8+CsxDbmlb2h6rvNNZf9PbHgV9Qdse5AYCsFEKXQU
 4O3N+M8x0YAXjyGgX/II1PCg19ww64qKjVo1h8RbLotRTmwldcXsxUZBS93OaeiAWn3I
 swvB5lkJxvcB93gcAacGBuPcqF92vjceb7e+RXJ9NA7LO2O7YbrQKEV5jWwG07cVDntN
 JzWDxubnHXkEDjCnWxClx0AKtXxqjzDL+giWkzQWe/E0RO6w93bNUUZ3FLPuUVs4bDVl
 C15w==
X-Gm-Message-State: AOJu0YzIrd9OX8pkYE+WHsRf49NODgg9isGmWJ4CGBvIj3gP2rD+DogO
 pEcWp/RzlSaEkjxPzG9njdIQ/Q==
X-Google-Smtp-Source: AGHT+IF/3fa0u1+Wc4/lFdhu8kxv36uCAYgKKgFmTbhG4ZWBQLDAkJ1RLhrouIxHa5O4xvg6L0DdhQ==
X-Received: by 2002:a05:6512:25b:b0:500:b7ed:105a with SMTP id
 b27-20020a056512025b00b00500b7ed105amr1731050lfo.29.1699543158695; 
 Thu, 09 Nov 2023 07:19:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a5d58f2000000b0032f983f7306sm7575083wrd.78.2023.11.09.07.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 07:19:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: HVC at EL3 should go to EL3, not EL2
Date: Thu,  9 Nov 2023 15:19:17 +0000
Message-Id: <20231109151917.1925107-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

AArch64 permits code at EL3 to use the HVC instruction; however the
exception we take should go to EL3, not down to EL2 (see the pseudocode
AArch64.CallHypervisor()). Fix the target EL.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 41484d8ae54..a2e49c39f9f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2351,6 +2351,8 @@ static bool trans_SVC(DisasContext *s, arg_i *a)
 
 static bool trans_HVC(DisasContext *s, arg_i *a)
 {
+    int target_el = s->current_el == 3 ? 3 : 2;
+
     if (s->current_el == 0) {
         unallocated_encoding(s);
         return true;
@@ -2363,7 +2365,7 @@ static bool trans_HVC(DisasContext *s, arg_i *a)
     gen_helper_pre_hvc(tcg_env);
     /* Architecture requires ss advance before we do the actual work */
     gen_ss_advance(s);
-    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), 2);
+    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), target_el);
     return true;
 }
 
-- 
2.34.1


