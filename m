Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DAC709D89
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03Xd-0002CU-0m; Fri, 19 May 2023 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XL-0002AU-Bx
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XG-0005UD-JQ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30796c0cbcaso3501932f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515897; x=1687107897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BK8vzqUrJMrBxmrdwxNxw8ipZXv8OO87/QXAs2j6w1U=;
 b=Hl5pDHGRZc5GBGHznaYo7jDDA+R9D1AMLJ7qaH24CFjMWSGv6yv0Y/tQrYlwzyNE2a
 FZqrqWZGpdUDvzuQSLx3rdDvRGOEZlZYKQ8kYExALC5eK0Pkbxfp1I4zzOUni3PnkHYT
 hEWLlPzbfUGRGslqWBPNvylOG27NN7/Nr48G7NjYrnJ4ZbnXRsSRTamGMfw65IalfW4L
 weV16U0lccYEnTRDMMWOvBYB7QF8XVrd1c6RmuLtLEZSEoEAuEt9nab7bp4/nf5Vtizw
 ht/ES3b6yldyOza7ay+Yd17unLkM2ZIt8ZzyrPatGpoYYE6EQMfgPuyQeQsWUbBmCmrO
 VX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515897; x=1687107897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BK8vzqUrJMrBxmrdwxNxw8ipZXv8OO87/QXAs2j6w1U=;
 b=U8/LFRxIogLAQdVSga2lyXJYgyna+viMi9nIEJhQki15ATz2495Opi0tLcy+5pUX/w
 05HqlB8tp4muREoDW3NRzORXkc3B7dkJaRfsOKmk3fIbXVRmeI3v6oZEn3ynKor3Gikb
 xTrlpS4Bg9n+AWAJ7BFgI8+bvWEZkUwEAerkhEMrxUhZ5aV890lUksl41NKuRYSNMHiw
 KQRKYqNlXtsegdjVOjewst8c7U0rITjutnomwpxWWOX/xPfhgWlshgox4U58d2EXKXaZ
 C5GF9UGmFOe5df8L3smRr9EhQ23VPNYcYdw/U+wDCaBfkChFZmcJUgeR14ypeBd5nhxF
 9nGw==
X-Gm-Message-State: AC+VfDxKT1JA1SG2MqxascqhNfZ2A1/k4ePJue9liJh/i8tELUgA4BF0
 SJQaeIOBcDXWAyVS8aPCocEnBA==
X-Google-Smtp-Source: ACHHUZ7LFLHVxkdrw0MVWFizH8zYe15AkKZboPW4rJdv6kaZ7wZIIjn42TqX/grY8TbbFV7bx1TOlg==
X-Received: by 2002:adf:e941:0:b0:2ef:eb54:4dc0 with SMTP id
 m1-20020adfe941000000b002efeb544dc0mr2296060wrn.51.1684515896590; 
 Fri, 19 May 2023 10:04:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a056000118e00b002f22c44e974sm5860820wrx.102.2023.05.19.10.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 10:04:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 082371FFBD;
 Fri, 19 May 2023 18:04:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 2/8] plugins: fix memory leak while parsing options
Date: Fri, 19 May 2023 18:04:48 +0100
Message-Id: <20230519170454.2353945-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519170454.2353945-1-alex.bennee@linaro.org>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/cache.c     | 2 +-
 contrib/plugins/drcov.c     | 2 +-
 contrib/plugins/execlog.c   | 2 +-
 contrib/plugins/hotblocks.c | 2 +-
 contrib/plugins/hotpages.c  | 2 +-
 contrib/plugins/howvec.c    | 2 +-
 contrib/plugins/hwprofile.c | 2 +-
 contrib/plugins/lockstep.c  | 2 +-
 tests/plugin/bb.c           | 2 +-
 tests/plugin/insn.c         | 2 +-
 tests/plugin/mem.c          | 2 +-
 tests/plugin/syscall.c      | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

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
index cd5ea5d4ae..e251a84d86 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -196,7 +196,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


