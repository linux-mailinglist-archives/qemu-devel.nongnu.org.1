Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2327441E7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIU5-0008Lu-92; Fri, 30 Jun 2023 14:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITx-0008IL-RZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITt-0006yz-Py
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-314172bb818so2391820f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148268; x=1690740268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSu5pHfoFzXcN2jMDhRn3eR0vnuKsKx/O0/7tf0yFTM=;
 b=gmI1tCM/SzFKZXXDBrrViPmwB5IpkzBVuzKvF58c4h2JL+/MLQgDzcg6aOke7RgKBp
 d3uq1KhwOEQOqI7POh0IkwWoMgYE3/B6W6d8aeR24Te3Cv27dZInOiYLRv6gEvs4ebHP
 K5dYahrofUra5LlAuxQnVRwUKu5kXvfAm1l6ESW5kZkg67vedbnOl8wx4ne3sF7jvjma
 LsITkM1Zu4R3kU5NtaTYtn0L/6b3pNGvCBucGs/BPTztscdwkVOjyl5zV2BcGOt5ZChq
 DwPEQxndmKBxSj+9UWfybCEwGa/A/Kgs/plQpoj0vIp0A9D6IbPGdnP97fB1eELVE+F0
 /keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148268; x=1690740268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSu5pHfoFzXcN2jMDhRn3eR0vnuKsKx/O0/7tf0yFTM=;
 b=gepRnD6GR0ZTJh+NFTPlJesS5WHfSTVtJz4sdJoghzr1Zk3w7cZcEMX3R2U9QPJCx0
 u/wemRrCtHuGecOmvIwbLfdhbY5/NMtttJyKTRQvN8fsZTa9djALb6fWWTTB7yCo/Cza
 H4gGNWCkVCO6YpS82cFNSlGqXSIaG/U3xXQKLbFdvSUdUbSAuVSoH6x6PxVkijyNSiK4
 LngxHd0BAZ1TkrVyMkwUFcAIobTpVyL3xBqtROjTFigfJMfx5RMxkiP88/QGZ+iQDPbh
 ZS9KCL2Ic7ZvFt6swUBariXiwRm/CsXJU+JFn6ONES3VyXugybzIBJzEtJfcR8QktJmA
 Fz0A==
X-Gm-Message-State: ABy/qLZGW96PqPrgGn1OeGobOBOcIjNJDbXT+a9e6kNUT/q1ov5Pp4Om
 bqJtCMUcinaKjRBnOvjvwN9t8Q==
X-Google-Smtp-Source: APBJJlFEiQ2GhyJp4ngtLw/UuqS80oIh8bx/G9gEqElvr2UQXdeLEYhgII1mzTp2y2PDqx6ibjs37Q==
X-Received: by 2002:a5d:61d2:0:b0:313:e8bf:a6e with SMTP id
 q18-20020a5d61d2000000b00313e8bf0a6emr2851150wrv.21.1688148267856; 
 Fri, 30 Jun 2023 11:04:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a5d45c7000000b003141a3c4353sm4227394wrs.30.2023.06.30.11.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD5481FFBB;
 Fri, 30 Jun 2023 19:04:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 08/38] tests/qtests: clean-up and fix leak in generic_fuzz
Date: Fri, 30 Jun 2023 19:03:53 +0100
Message-Id: <20230630180423.558337-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
v3
  - use g_strconcat instead
---
 tests/qtest/fuzz/generic_fuzz.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

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


