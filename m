Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805073EE2A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:01:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFJ-0002dp-8Y; Mon, 26 Jun 2023 17:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFE-0002aa-Uy
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFA-0004s9-Fs
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fa99742af9so13350205e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816771; x=1690408771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCVrBcA62K9RLf5e56Guknvwd44ZoDW7Y93GujqWZjQ=;
 b=y4cWEPo7e4u0mgr0SUohceoPO7QQiLIHO5sWxD8mrpnSuo98WJjvCJ0ZbIlSPjk14s
 L3rFJNirp+f0GaoMaJOU9OJdo1k20U77/V5xJw2LJRJ/uRr+pVLh6xoZwMAnE0ND6yWt
 l+aVsPIjFRikBRE0jM6GPH5nhnKreYZHUDZIspWNzCMVWipYdKH+H3R3wJdSq2UpbxqJ
 JYZcklhmSQ5G+wLy9FoStOvIjWr+CCe/kBRQvXtfQ2JxThj4L3QSdv8cFDDHD6JFPDcD
 tpde7PJRL1pqp/ZU1UXQFIz0GCQlhRLJTs8X7byCrFCGEh2ObcLf6fPIQZ6IPe/Fs5lM
 6pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816771; x=1690408771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCVrBcA62K9RLf5e56Guknvwd44ZoDW7Y93GujqWZjQ=;
 b=b66xnS9VewmpiOyxSojPD86lw5IVp3YfJ1WnukqJErZXpThnJ2M8UEZD3uzdx0bziZ
 qk4GHqiSEdH8fEU+z89fkiXGRVIeFKLx5vDFlHeI7PrCo/0QfDB9EFAULpbLz6nrj7hE
 y3aDdZwOgbB+t99oJlZCVuuYa6bj/82+YN2V/17DC3lyVzC7nBm5WklMqM0u+0Fk7/oz
 zHnvp3JWMKzXhtm8kC/N6BPIC/vU+Dkw8PVoSD6xTCwvx9eyEzIc08nugMmDkvfOqPUX
 MJz/90v1l6Tb8ALn444faKLt3TlQfAsVYi2j9F/ne20HkVama9TO7sbpAWk2NhYNSLiq
 NtDw==
X-Gm-Message-State: AC+VfDzqW1LJJNpGna35cKCbOZst1+2n4TCEeAoLkpaBQsWPe2D+3UmX
 2V/L3n63Fzgkns7InO8p5sct/w==
X-Google-Smtp-Source: ACHHUZ7U9v8V7yzcARQ2QzEcbSrCRvQC3r7hzO8JciyPynNOsOHF2nZ2JeuXX7oEBAQNaCS/FT7saQ==
X-Received: by 2002:a7b:c399:0:b0:3fa:9590:a365 with SMTP id
 s25-20020a7bc399000000b003fa9590a365mr2927101wmj.17.1687816771132; 
 Mon, 26 Jun 2023 14:59:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a7bc41a000000b003f080b2f9f4sm11751894wmi.27.2023.06.26.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B91EB1FFC3;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 08/26] tests/qtests: clean-up and fix leak in generic_fuzz
Date: Mon, 26 Jun 2023 22:59:08 +0100
Message-Id: <20230626215926.2522656-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


