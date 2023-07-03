Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F8745DF8
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzk-0000Z2-MC; Mon, 03 Jul 2023 09:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzh-0000U5-2t
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJze-00081q-UJ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3143493728dso1563669f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392409; x=1690984409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5nvMYyOs/RyJESBlIkw+wk/56rg5wafIOTXXNkBqK4=;
 b=SiBLqXUsUkT17mP2LOwb9c/Io2TnE42YLGzLAImcJIhBZPNoqUdg09cJ7YiGPKvZGK
 raPWHj3rpnLkilKipOlvIy2Z18rP6Z3VZaNZVFwD7KZ9UBorNrVO+BY03pvImgvw3yFN
 hMumBlEA9dgj0CDTBXtlmlElQydKqklvMHOGX5gKNYwlFhrSOrfvQYzFIL6JvN69aBHi
 OLNv/c/RYrh5p1e9FBOtHzjz5jRaboi7oH8d9OX+6RoU58i/tx+D/i87xoFiKSmC9WZ/
 du6zx4ChaY7W3kwK6hMni+H6izt8R8CepGGY5WIxwfk9CEXf1dTI18grufjxGn/1Cfam
 XCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392409; x=1690984409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5nvMYyOs/RyJESBlIkw+wk/56rg5wafIOTXXNkBqK4=;
 b=e4HZlCmL0CLh+HZkYr5YVSvwu0SZ6VuTGA+zXcPY8MgMsSbEbA1XESNi+NccMo2Cp3
 VymSTVu5i1Fcxgug/ibnqwtiDVd/iTP7OCtjKRI8HOE2Sn6Opkrqan0jARF7itMbL18x
 DaVtJRSDUP3EuDkFzYP2qfBwEljKa0rt1ifuTRbcZT9n2O1jKU0pL3OxmFZ+alrWDZre
 msgXG1Ynj7SUIxnh92RayP05zXlRpuBg6506PMG2oYHnp5H+89fHZaNJVqEmu+BJ/xYl
 DkRB55PDIk1cU6UFbU+c8d5VmSUygCYkgusl6sDabPnkeIEKPnL/A7HNxTTVylP+hII3
 o4Xw==
X-Gm-Message-State: ABy/qLac/0OM8UVILVzOG0JhlMyXfWLgo+D8/fLLe7N0t82iY9JAdzQc
 UL0YphpqJRInzLMz3HN6K9h1/Z2AX1MOvPzAAAs=
X-Google-Smtp-Source: APBJJlEdWfCdVpDDocviV+6YdhihBQxWrjiKDnR9rDCNJRCeEvVoxaMkEl/g6aT/1fiAy7Lo6Qvymw==
X-Received: by 2002:adf:fbcf:0:b0:313:ec5d:95b5 with SMTP id
 d15-20020adffbcf000000b00313ec5d95b5mr7438787wrs.60.1688392409301; 
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 cw13-20020a056000090d00b003112f836d4esm25491334wrb.85.2023.07.03.06.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C44B1FFBF;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 20/38] plugins: fix memory leak while parsing options
Date: Mon,  3 Jul 2023 14:44:09 +0100
Message-Id: <20230703134427.1389440-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

It was hard to track down this leak as it was an internal allocation
by glib and the backtraces did not give much away. The autofree was
freeing the allocation with g_free() but not taking care of the
individual strings. They should have been freed with g_strfreev()
instead.

Searching the glib source code for the correct string free function
led to:

  G_DEFINE_AUTO_CLEANUP_FREE_FUNC(GStrv, g_strfreev, NULL)

and indeed if you read to the bottom of the documentation page you
will find:

  typedef gchar** GStrv;

  A typedef alias for gchar**. This is mostly useful when used together with g_auto().

So fix up all the g_autofree g_strsplit case that smugly thought they
had de-allocation covered.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-21-alex.bennee@linaro.org>

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 2e25184a7f..5036213f1b 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -772,7 +772,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
 
         if (g_strcmp0(tokens[0], "iblksize") == 0) {
             l1_iblksize = STRTOLL(tokens[1]);
diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index b4a855adaf..686ae0a537 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -148,7 +148,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                         int argc, char **argv)
 {
     for (int i = 0; i < argc; i++) {
-        g_autofree char **tokens = g_strsplit(argv[i], "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(argv[i], "=", 2);
         if (g_strcmp0(tokens[0], "filename") == 0) {
             file_name = g_strdup(tokens[1]);
         }
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index e255bd21fd..7129d526f8 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -227,7 +227,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "ifilter") == 0) {
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 062200a7a4..6b74d25fea 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -135,7 +135,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 {
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "inline") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_inline)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 0d12910af6..8316ae50c7 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -169,7 +169,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", -1);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", -1);
 
         if (g_strcmp0(tokens[0], "sortby") == 0) {
             if (g_strcmp0(tokens[1], "reads") == 0) {
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 4a5ec3d936..0ed01ea931 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -333,7 +333,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     for (i = 0; i < argc; i++) {
         char *p = argv[i];
-        g_autofree char **tokens = g_strsplit(p, "=", -1);
+        g_auto(GStrv) tokens = g_strsplit(p, "=", -1);
         if (g_strcmp0(tokens[0], "inline") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_inline)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", p);
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 691d4edb0c..739ac0c66b 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -263,7 +263,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
 
         if (g_strcmp0(tokens[0], "track") == 0) {
             if (g_strcmp0(tokens[1], "read") == 0) {
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index a41ffe83fa..e36f0b9562 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -323,7 +323,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     for (i = 0; i < argc; i++) {
         char *p = argv[i];
-        g_autofree char **tokens = g_strsplit(p, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(p, "=", 2);
 
         if (g_strcmp0(tokens[0], "verbose") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &verbose)) {
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index 7d470a1011..df50d1fd3b 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -104,7 +104,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "inline") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_inline)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 9bd6e44f73..5fd3017c2b 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -189,7 +189,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 {
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
         if (g_strcmp0(tokens[0], "inline") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_inline)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 4570f7d815..f3b9f696a0 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -83,7 +83,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
 
         if (g_strcmp0(tokens[0], "haddr") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_haddr)) {
diff --git a/tests/plugin/syscall.c b/tests/plugin/syscall.c
index 96040c578f..72e1a5bf90 100644
--- a/tests/plugin/syscall.c
+++ b/tests/plugin/syscall.c
@@ -121,7 +121,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
-        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
 
         if (g_strcmp0(tokens[0], "print") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_print)) {
-- 
2.39.2


