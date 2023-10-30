Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 211F97DBF35
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWFG-0000UF-Nq; Mon, 30 Oct 2023 13:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxWFD-0000T8-Pj
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:40:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxWFB-0000Gk-Nq
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:40:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4084095722aso37078125e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698687603; x=1699292403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HofzvborK1LcpkVXYwmCC38RZdUw8ez62hByMjO3pQ4=;
 b=BDgxgwf/19Ta4XSeiUK77mdv5w2Q5NOAzrlPNt6hM2e7EjBQ1kvPI1iV9BkYDG1MCJ
 FO+tylecoiLzSm6aHzfxa8UyQ9dOb+NQOx6vRfOd2yiSV47Z4vzQ4Heu7oZU4d9YtH1n
 H9nN804m53YWv6y03SO7sAatkZZpRCC8NYX9S8eHobOFb8s2RBBiQ+7KjaP8HYt0O3DN
 h2weXTZnV3pYPzjUWLTF4PP8ZaPPfkBQBCr0dzENOq25OLnWTEowx6ZcKMWRR0nEIxWt
 +DGtzdC9zi750qu4doXSstec6qUWiO2PbxULkZCZ3SNcKZLZeN+QcT2J2cCeHVCZRr/c
 g62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698687603; x=1699292403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HofzvborK1LcpkVXYwmCC38RZdUw8ez62hByMjO3pQ4=;
 b=PbAuC+xC/WPH1son3rm49I5m+NB4zjK60Ojb6yn6u8gJsfAPd1yzN9Sbc/z15lP/eJ
 XhvMxD284nLFujMxvCnqW4f56DKPWzt/EK+Gt3xOhEYZ/LcC+WJRMmWm9kHXHTX4A+3w
 0e83j0jepG8QWRaVY3y2RfpsKAoJYQMVH3NEfJ2RT0hgTBJ5f/iiNAmBQu33Qg69RYc2
 0SLRXJulUCL+1cV/iHnaFA5STclLVIQ+uDOZTVGyIMNb+8Ys4zoaaeV46VaO2i3zrNwI
 vkG7CT2LemEJHW/nUS6/6wo/+ryk7IVthFu4M1yOLq8VbH2ygizNWwv3WhiFlpLWJ+Qm
 ouEQ==
X-Gm-Message-State: AOJu0YxNwknhPkxEvAUCGVY0Nc3SEVmcygD8YR88YfQmctYWZbTsFQl0
 kzBxl64FXXmTauydBWIf/5dhNw==
X-Google-Smtp-Source: AGHT+IHoF8f5jJOdWgk9WjZXKZmADI4a0BZq+BuNdp0IvCH7oKnYNhzOV4m8mUvyol6kviZjCuFlkA==
X-Received: by 2002:a05:6000:1ac7:b0:31f:fa61:961d with SMTP id
 i7-20020a0560001ac700b0031ffa61961dmr8282487wry.63.1698687603570; 
 Mon, 30 Oct 2023 10:40:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d5950000000b0032f7d1e2c7csm5912914wri.95.2023.10.30.10.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 10:40:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Enable FEAT_MOPS insns in user-mode emulation
Date: Mon, 30 Oct 2023 17:39:58 +0000
Message-Id: <20231030174000.3792225-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030174000.3792225-1-peter.maydell@linaro.org>
References: <20231030174000.3792225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In user-mode emulation, we need to set the SCTLR_EL1.MSCEn
bit to avoid all the FEAT_MOPS insns UNDEFing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index aa4e006f21a..cdb37ce5512 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -295,6 +295,8 @@ static void arm_cpu_reset_hold(Object *obj)
         env->cp15.sctlr_el[1] |= SCTLR_TSCXT;
         /* Disable access to Debug Communication Channel (DCC). */
         env->cp15.mdscr_el1 |= 1 << 12;
+        /* Enable FEAT_MOPS */
+        env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.34.1


