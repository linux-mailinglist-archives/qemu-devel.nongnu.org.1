Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1072E436
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 15:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q94Al-0006q1-KY; Tue, 13 Jun 2023 09:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94Ak-0006oh-8j
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:34:58 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q94Ag-00026K-Qs
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 09:34:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9786fc23505so810094666b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686663293; x=1689255293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Tb5v+lWJ9rEaZ4+W83mDQQpTQklHgjD+Pw7euu9oDg=;
 b=JBigAMzyWSWYE5PtdiDjqzMLzI0cRipqVI40HGyZ4/YkbvjM88Yd1SHnEIoKYOVb3T
 tSUdtey/yVoM7GwjISgn7Lxbp7KcuU2lClpJOQ5KaupQstA7l2tHmS9W2hcCC1ZvzaGj
 2xV13Zi+fgV0J0Wrbtqz0qjjWauma6y2z8+BX1FCO+eKj3oW8tzuNTFavmAvTDumsvdD
 EaHFDvMQIlLg1flwo0aHw5jy1s92+jGrjjesjYpxlyQvTOoWVXTMKArYPhX+x8p3FzuE
 CWC+/e1OPxpdAN6oNYtHo/0o5G8bRmk761HUreAEL8lNhZvXFS2/6tAFeKsBiAl8N3f7
 5XVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686663293; x=1689255293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Tb5v+lWJ9rEaZ4+W83mDQQpTQklHgjD+Pw7euu9oDg=;
 b=IZ53rWX1LlHf9hXn23oPIAlKIwiLQMIYxN6tBp4jbC6c7kCdZ3wECXU69GQ20Kkemr
 2WI83Ff+Y1wLYHOyPIWzZYoWKVHqJ/zIQ11IEMKZqIfvA6VOpD8ioD1VzZcqIWRFpio5
 MTZPQ3qi0prM4DMyEx9OBO4RwOwe7Cdgsk9KgBRjwcElNeH8/6CH3yVCILgCv6jXs1yM
 /ZzzeLEniwghbqwZxDewC6/DEEETNGIOgH9T7DVARTOU8AXYynVEm1aLQFSDM7PDjKpo
 hJ7L2dVET3UT0pxDwDtRhTkQH8zZzZLB+YPHoVQd41bow7iuryte4f3YsTsELWqLmvJg
 5bsw==
X-Gm-Message-State: AC+VfDxyotmTiBe8wc3LiUdI5aN9xBAypSzsoJYSuKl+cwtdWUO6Jrh7
 eKQP8f/Dctxw9adKcp372ggw0xBzwje9Z7NKzgQ=
X-Google-Smtp-Source: ACHHUZ4EeHHEOsSREHY6rgBowYEvL3h2RFrxzB7NOi3lPovaJZCtMdDRDh+veyJUIzq3MIl+1tygRg==
X-Received: by 2002:a17:907:78c:b0:96a:ee54:9f20 with SMTP id
 xd12-20020a170907078c00b0096aee549f20mr11508239ejb.37.1686663292728; 
 Tue, 13 Jun 2023 06:34:52 -0700 (PDT)
Received: from localhost.localdomain ([213.235.133.109])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a1709066d5500b00978897577c6sm6624320ejt.44.2023.06.13.06.34.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 06:34:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/9] target/i386: Simplify i386_tr_init_disas_context()
Date: Tue, 13 Jun 2023 15:33:39 +0200
Message-Id: <20230613133347.82210-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613133347.82210-1-philmd@linaro.org>
References: <20230613133347.82210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Since cpu_mmu_index() is well-defined for user-only,
we can remove the surrounding #ifdef'ry entirely.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/translate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cf14311a6..08c4cab73f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6914,10 +6914,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cc_op_dirty = false;
     dc->popl_esp_hack = 0;
     /* select memory access functions */
-    dc->mem_index = 0;
-#ifdef CONFIG_SOFTMMU
     dc->mem_index = cpu_mmu_index(env, false);
-#endif
     dc->cpuid_features = env->features[FEAT_1_EDX];
     dc->cpuid_ext_features = env->features[FEAT_1_ECX];
     dc->cpuid_ext2_features = env->features[FEAT_8000_0001_EDX];
-- 
2.38.1


