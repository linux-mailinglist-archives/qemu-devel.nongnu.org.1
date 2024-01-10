Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BC282A42A
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhL9-0006Js-1I; Wed, 10 Jan 2024 17:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKM-0005CK-Df
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:43 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKK-0002xy-0t
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:37 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so3834664276.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926734; x=1705531534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsZxMo/6G0y0rb+He/biAv9zUFttsowRzurXqIiQz9A=;
 b=vQ+JaNl2RX6wyQm1u0IhanRh6R2n6t3DSV1N+3IK65zZVt5UKmLrjiBDO+7O2srNxe
 6fshd4wFe6hsHU+348QWaUsV/9onijEOU1EdozwGW61y/P6JAltwYytSrTR7eEK4b28W
 Cu2/ZAiXcIcTB+Q3iYcmCafj++bQCG57y6ZYC2E54iZ4A9Uj6uVEW+6PEpXcx/clH2/9
 2mOd5nKa8OtsR6yHwTlGgrLQvSYkpHiZ/bdv1lCughJX8bj9TsQVQ6vAuEyCkFXc82e6
 BmpatWqBcukry4nDcJbcUbFMzbRQv0h8IZ2yrYFMkrRFGefmwt8TcnatXmY8QAUmsYwq
 k+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926734; x=1705531534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsZxMo/6G0y0rb+He/biAv9zUFttsowRzurXqIiQz9A=;
 b=Y0hxBMpv4TxEWRmxxkaLWx8jqVLZMAGP2mQ7WTxRnk4AqlvdVorvWkC+IRFBh8XpB8
 NEeymgFIljiqw+qyovpuQKm/DD6Wg3IKuhKAkyw0Imjh1Ig6eV6/qYxw9VTtu2KFO0LX
 Rfh3Q5Bxps8xpTt6HCCzRqLKhpwFEP3u+KXip5IXM1tFZXgfQisT64faO7etXXInRcfu
 xsPqbtxDHTeheO6P1pcivYbXiXlwpTN0pKkhzRfdgGbQlpd3C5KpAu5n+EQu7SoB9iDR
 /aBwOgKwrAatq2J3O20i6JJnIYO9KMb0d69FyTuqUG3+hYoxYQAnyyIitVo1cZFQDvUc
 c6vg==
X-Gm-Message-State: AOJu0YyxsH4CCsANOKYhROteQ1BQ9Uf2jGAvJyMq+jPLHNNCBpCUoI5b
 wuQfqRgIfbcMAm5UnL4oIz6pZBHj3XCa/tHN3eUX8aWLaftmtLkc
X-Google-Smtp-Source: AGHT+IFgmDx0rjLjdDJEA47a3KgqUj85sMkg6nUuP0fvuiPp34aIHKDnp5Lk5haX3gA2j0aGfGQKaA==
X-Received: by 2002:a25:9701:0:b0:db7:dacf:59ce with SMTP id
 d1-20020a259701000000b00db7dacf59cemr345588ybo.66.1704926733978; 
 Wed, 10 Jan 2024 14:45:33 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 13/38] target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
Date: Thu, 11 Jan 2024 09:43:43 +1100
Message-Id: <20240110224408.10444-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb29.google.com
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
 target/sparc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..b96633dde1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -506,6 +506,7 @@ static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv zero = tcg_constant_tl(0);
+    TCGv one = tcg_constant_tl(1);
     TCGv t_src1 = tcg_temp_new();
     TCGv t_src2 = tcg_temp_new();
     TCGv t0 = tcg_temp_new();
@@ -517,8 +518,7 @@ static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
      * if (!(env->y & 1))
      *   src2 = 0;
      */
-    tcg_gen_andi_tl(t0, cpu_y, 0x1);
-    tcg_gen_movcond_tl(TCG_COND_EQ, t_src2, t0, zero, zero, t_src2);
+    tcg_gen_movcond_tl(TCG_COND_TSTEQ, t_src2, cpu_y, one, zero, t_src2);
 
     /*
      * b2 = src1 & 1;
-- 
2.34.1


