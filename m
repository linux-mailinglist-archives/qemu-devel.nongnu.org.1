Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF9740087
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:12:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGS-0000A9-Gx; Tue, 27 Jun 2023 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGP-0008MY-2H
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGJ-0005ov-Bq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-311394406d0so4324784f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882189; x=1690474189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o65EU6QKm/ZKlwjUjomTQSbG60nANx/Rf8AOn4I397k=;
 b=z6l8XgUa87qoqU3s8E0ZUwL2ww2TcPPQXh2Ve2wgoSSUUofGErpeL/3MO8E44tEEFP
 igSX1Fmq6gmcd/Dh3gbtvokTWKCL7XWawwl30EcKb+Zi3ljgkezdQhpHRG1faB+b256W
 74EqYB0rgHeI6miUFkPjIDBfE9dOocO1Tee+wz7B8rg8hv58beaX+hhmdfhiamjfohKw
 r39ammUp4GPH1qvmD5cA8uiukRznChW3J7x0inV2MBnTl7Yem4vPzoIzsIDWzEFJl/7J
 auWxj6ThhFbQ0aEFdei6NR00B1IpA4Wc5aYh0O5mZEjVeoD94MZiGHbluHwQoNrm10CF
 bxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882189; x=1690474189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o65EU6QKm/ZKlwjUjomTQSbG60nANx/Rf8AOn4I397k=;
 b=AS2M+4qqo+WjFqcGvZOzH/YcR4fM+oVvRXxqAVPb5LKFwFjkT6XxI7TTSKUghadwvV
 usPbpaMP75Hh7EJPvBmsNcrMggOLdyAvyp3gsSa86S1OBglgjvFj5Nizn4SuuH2szugj
 7qo/s9IMU1u6g08pN/O/dqVkV0VJbhsGG5jKWOqGucCBcCdFHwTV4SNg22lr9CUXSljT
 FJkjuDZ7xv/st6EoQVdaWMSfvnnv29hAFyhkGxFo7t8+ZS87w0NHUSsfQ106jyh4/+cB
 UsSmAWJrUXUHIiR62Ib0Qs9DZt9q60cI48kNjbOpmJjQNPzbjZfBIkF9sJSk8QXEGlHO
 l+WA==
X-Gm-Message-State: AC+VfDx5bvX7BHguIGURC01Fysy+2nnbxWayz6eQuHj0NXtv518zqB0/
 N3Wad0GCLGbsz8+FZs90ybpfdQ==
X-Google-Smtp-Source: ACHHUZ7Sv3XO+G+qXL8rkpzBFYBSKF5Wx6lJ4HmL7Pxu5ZjC6qSBFvCKrD0MA6yPnECk7ZxJ8Ad5vw==
X-Received: by 2002:a5d:4eca:0:b0:313:f548:25b9 with SMTP id
 s10-20020a5d4eca000000b00313f54825b9mr4251639wrv.40.1687882189591; 
 Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a7-20020adfe5c7000000b0030c6751a49dsm1371386wrn.115.2023.06.27.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBD271FFC4;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 08/36] tests/qtests: clean-up and fix leak in generic_fuzz
Date: Tue, 27 Jun 2023 17:09:15 +0100
Message-Id: <20230627160943.2956928-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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


