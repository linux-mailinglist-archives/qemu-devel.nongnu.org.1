Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B985173B71F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfo2-0004mU-HI; Fri, 23 Jun 2023 08:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmu-0003o5-My
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmo-0003hz-AA
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f9c0abc8b1so7225165e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522865; x=1690114865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCVrBcA62K9RLf5e56Guknvwd44ZoDW7Y93GujqWZjQ=;
 b=KTpc5rQI22c/y3NRcMlIiXKjNRvshvRgkP98Q9XeXBcJHV6bMrlnYYr01sqnTptoTQ
 uk0cCTx19AZNsn6u8GuEX+Rs1BrJdpenN6md2sq2TxV8vH28uiG6KEbbztbITEeu5F+b
 Yg6Cor0xOvVCbqcZrlKECvgnDRgjDVX9iy/pgpwYuj5eAqlPYluAJDRVA7SeLO2fUfpD
 ZT9sUaXqfOC04wK/Z1AvYzoMcevifTe9/tRpGKPVZ4ciNH0uBoJY7ptPymYhv44ua7rW
 WhnFLSC/Z6cDqC+FATKO8uV5JAPwgwVUBLAIBNtZqDLFuoqpUI5X+Qtr2wTIoEHBz079
 gXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522865; x=1690114865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCVrBcA62K9RLf5e56Guknvwd44ZoDW7Y93GujqWZjQ=;
 b=eFHL0ZP9u7z64Ik3aVPXA8BM7X6fVKgaM3fpIL+9T8TGsStCevUG6ulTVhYCIQv4FU
 IJOEsM0EhWJgKTl8N4tI6uiMTGQkjdwDIuuYN1+ZYtjZpQT/ASrljS6TxJa7rf0kO3T5
 0IYUnnNaN1FZsU57tiUtWeSOLfTxiPwrXHOmYJVjhUxiPCSo+y3xT54XOz6OKFTKlH7m
 KT/UmdyxSfNDjT+ztscYpATggwlwtc97k4t1jKAsCPP8ffaYciLeJyFzP70itZLFCVBM
 x2wk50Tq+kWaF/mI9igR+91Rn8EmmR3XVVisFv+snmEpj1Wp6JlT9QFYnjGVKocEinjS
 mJxA==
X-Gm-Message-State: AC+VfDwo4+0vLIo3hVvAc50Dhw5GkohnKp6z852p62n3qPFCBbdXcq81
 06n9A+f7tOLtjOTU0SQTfAqGYw==
X-Google-Smtp-Source: ACHHUZ53PgwrXYgH07/qFtAYyF8MzX6Dge992f79a3j0nkLaqgV7TU6Ul1slkETWRzQDyL6mrxY7QA==
X-Received: by 2002:a7b:c7cb:0:b0:3f9:b1e7:8a41 with SMTP id
 z11-20020a7bc7cb000000b003f9b1e78a41mr12023755wmk.35.1687522865709; 
 Fri, 23 Jun 2023 05:21:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a7bc019000000b003f819faff24sm2195346wmb.40.2023.06.23.05.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B3A71FFBB;
 Fri, 23 Jun 2023 13:21:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/26] tests/qtests: clean-up and fix leak in generic_fuzz
Date: Fri, 23 Jun 2023 13:20:43 +0100
Message-Id: <20230623122100.1640995-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
the code with g_autoptr and use ARRAY_SIZE while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/fuzz/generic_fuzz.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index c525d22951..a4841181cc 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
             .crossover = generic_fuzz_crossover
     });
 
-    GString *name;
+    g_autoptr(GString) name = g_string_new("");
     const generic_fuzz_config *config;
 
-    for (int i = 0;
-         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
-         i++) {
+    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
         config = predefined_configs + i;
-        name = g_string_new("generic-fuzz");
-        g_string_append_printf(name, "-%s", config->name);
+        g_string_printf(name, "generic-fuzz-%s", config->name);
         fuzz_add_target(&(FuzzTarget){
-                .name = name->str,
+                .name = g_strdup(name->str),
                 .description = "Predefined generic-fuzz config.",
                 .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
                 .pre_fuzz = generic_pre_fuzz,
-- 
2.39.2


