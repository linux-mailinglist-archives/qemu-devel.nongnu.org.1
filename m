Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C5745DB6
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrD-0007hg-NO; Mon, 03 Jul 2023 09:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr4-0007TQ-DZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0005gy-JZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-313e714342cso5193010f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391872; x=1690983872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmUCRBf4Xho+2SbSl2R5MUiyr5uXTfWzrS4YFCHSA4g=;
 b=sQsWG4JnxwwUgg3bfswr/m3hSFosv/XrraHXPWPTT40Lym1JdU56dvqpj9DUg5lwr1
 qJflW2BG0u/diWZGGTzRvnNF7yhH+XOZZi9fb9Z/l7J6XrBXuB3PZF5/w7Ecz6FhaJv0
 21xef3tynnpo76voOhV0/2exPPfbawi8yH3mP6OJ4rovTjQnBWK3RsG1mxUW29dpjH6P
 mngxaja0dQTO0iMV09xtwX8n4P0dJDy8iBTtrCmQBjxi9oyL+F7FaTlWrUrTnpF10ws0
 vHv1pydgqrr/hqNrOVIJcsjKZvLKFv/JSnWNwaJp05AyrqSDBzclxWtlpo9SGOMlltdt
 boYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391872; x=1690983872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmUCRBf4Xho+2SbSl2R5MUiyr5uXTfWzrS4YFCHSA4g=;
 b=YJ5H2uEe2HsJpuR87alFtNVnivSjRnu7yxRPu9PCZANnW87OZ7mNDbdbY0Aq41XzKe
 ITBzY0WsE0e909YoIcC87HwJa5ZtSO3lWdy82wP9CZT1oKiujIW7k67Sc+pdTurJUb5T
 8pGYnSahuRVoK2AUzMQxgDbR6pZ66YYWqXqZFeT05xlfcYiAEySDS2SZDPDD4Ww6jmwN
 HvT42HD/FT/W1O0DmyhIFvbeVOOkmTKfvIxUKNjUA1whsWr8X+Z1zhWlSS6fXLUpaR76
 ex/JmeaqpdIJ/FB4G8dd7CC7AZBSMueptexFmUY35HK3ENzVcamjIdwtfEVYfmRIlc7P
 cYgg==
X-Gm-Message-State: ABy/qLZx8LJTQETK0Oj7U5vSlDxuStcOhNk/FwCOzjD0Jeub5ZCQxtMQ
 9NINEQ+5Qgql6fPL2WHKBI64Pg==
X-Google-Smtp-Source: APBJJlGUqsC3UU9tPfvlan2VLd3btE5qSBWOosBiObtY78zyGTmeD/Y18QRkE+vuQvW2nvJy6JBI/w==
X-Received: by 2002:adf:f84a:0:b0:313:e553:b858 with SMTP id
 d10-20020adff84a000000b00313e553b858mr8226389wrq.33.1688391871864; 
 Mon, 03 Jul 2023 06:44:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a1ced03000000b003fbcdba1a63sm7448104wmh.12.2023.07.03.06.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A441B1FFBB;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 08/38] tests/qtests: clean-up and fix leak in generic_fuzz
Date: Mon,  3 Jul 2023 14:43:57 +0100
Message-Id: <20230703134427.1389440-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

An update to the clang tooling detects more issues with the code
including a memory leak from the g_string_new() allocation. Clean up
the code to avoid the allocation and use ARRAY_SIZE while we are at
it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-9-alex.bennee@linaro.org>

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index c525d22951..11256abf6c 100644
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
-        config = predefined_configs + i;
-        name = g_string_new("generic-fuzz");
-        g_string_append_printf(name, "-%s", config->name);
+    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
+        const generic_fuzz_config *config = predefined_configs + i;
         fuzz_add_target(&(FuzzTarget){
-                .name = name->str,
+                .name = g_strconcat("generic-fuzz-", config->name, NULL),
                 .description = "Predefined generic-fuzz config.",
                 .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
                 .pre_fuzz = generic_pre_fuzz,
-- 
2.39.2


