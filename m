Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C71740069
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBE6-0000Lt-H8; Tue, 27 Jun 2023 12:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDk-0000Bx-Tp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDe-00058Z-OI
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fba8e2a9ecso6761415e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882025; x=1690474025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o65EU6QKm/ZKlwjUjomTQSbG60nANx/Rf8AOn4I397k=;
 b=CbHtyoZ7l3CHg14wHQLLaJZkrslTC02xBDp/hppUHY8ORu4Gja0LUY7GpaSsrL0hAn
 29JQ0SOPm84Vfrw93rkQ1aj7JBYMf9zAOFYg08LPgHdwR8NzsDTVXXiJlR1YXIuwlVvd
 b8zUZipq6wP7T9/iSAkbOUe3oc/raZ9SZ9xnDcw/w75oDb0m+NpF4mC/+uRpn5aXHduO
 rt9i1tbMP7sdAA0tf/UZvEsoL0w2/CjkgAoaxfVPAT067p9tWPVt2UvumBM6/0CYpvlw
 ux6U9yaQA6uQxbZZevMSuMcBddtH5vC/S2r24xhfrPi0Rm+p1PMk8KYuxhrZfQpE7p5N
 kWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882025; x=1690474025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o65EU6QKm/ZKlwjUjomTQSbG60nANx/Rf8AOn4I397k=;
 b=jFTBMYplCjpUe978U/SNtaoQahMuIgOR+7GqqoB6IYAzxdivd9EMxbFf5DitYcLleg
 iOX56jivxzmGPL1S5snlfy/JLgYEC7HcRNK0tOQE8Dc6jsXNK/keIXWYvC6s2A63T4aQ
 5SqQcKCk/AXH2cUuNbhCENH3hTaaTrPkzTBEvShw86rgyiCLUcEY9F8dlCfNEgnlCmGi
 K8PjA99mnkaVjKBG0him0MuSiTADi3zPgDCCCNsbNW/r9T/3Buoelp45jf6PojJOlWoN
 bVl5+GGFjANc17khziS8esksUW4lO5OtA++WLG/d55Zg3JLVc5B1p6xlEcNj6VXNmmFf
 rReg==
X-Gm-Message-State: AC+VfDwPvvVSyqL9d7ab0Y9q2cJGszzwI14p7juQP8jPDREfSlTt3dWQ
 MCiDwfuNtYHVkhR0Zn1yBH+2KQ==
X-Google-Smtp-Source: ACHHUZ4M4UZfzxb+z9EUmc5M/uYSUqQFMVr/G7Q3Ws5rSis3DrVhHtShoJcLCL0u8A5sxPmPzcpm7Q==
X-Received: by 2002:a7b:c414:0:b0:3fa:7cb1:ff7a with SMTP id
 k20-20020a7bc414000000b003fa7cb1ff7amr9887231wmi.13.1687882024928; 
 Tue, 27 Jun 2023 09:07:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003faef96ee78sm5045149wmm.33.2023.06.27.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A265F1FFC3;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 08/36] tests/qtests: clean-up and fix leak in generic_fuzz
Date: Tue, 27 Jun 2023 17:06:32 +0100
Message-Id: <20230627160700.2955547-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

An update to the clang tooling detects more issues with the code
including a memory leak from the g_string_new() allocation. Clean up
the code to avoid the allocation and use ARRAY_SIZE while we are at
it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/fuzz/generic_fuzz.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index c525d22951..d0a59f7475 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -954,17 +954,10 @@ static void register_generic_fuzz_targets(void)
             .crossover = generic_fuzz_crossover
     });
 
-    GString *name;
-    const generic_fuzz_config *config;
-
-    for (int i = 0;
-         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
-         i++) {
+    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
         config = predefined_configs + i;
-        name = g_string_new("generic-fuzz");
-        g_string_append_printf(name, "-%s", config->name);
         fuzz_add_target(&(FuzzTarget){
-                .name = name->str,
+                .name = g_strconcat("generic-fuzz-", config->name, NULL),
                 .description = "Predefined generic-fuzz config.",
                 .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
                 .pre_fuzz = generic_pre_fuzz,
-- 
2.39.2


