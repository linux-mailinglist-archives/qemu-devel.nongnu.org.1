Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3CD73B70F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoT-0006Pf-7F; Fri, 23 Jun 2023 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfn3-0003pa-Re
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:27 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmq-0003jm-JK
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:20 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f955def3a5so689444e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522869; x=1690114869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQhWpZw084Ja0HJjsgxPSzSU22UDw5r1FrOeDB0PeQQ=;
 b=GbbzEd+rGxZc3MA+oOcAL5QGFnsZYNSjdqKC+IO98AYrHiIviDCI9Aor99VSRmWfrd
 a0+HUhPmJd0p9Q2d8E+q7m0WDI3fLz4XBCIzkLlqbVplULPX2luzvBB8Bt1QOrEr3Rz0
 +LG7Rj4eneS1DRJ6p3TfeexkTal4eYi6hU88vuuMY/dbT0LUlrd339IUcXo9gCmb3CWg
 34YLcPW0y6rpGmwtPN/x0vcuVsxtMpTUXqnpDWCJKLQ3hCmSKLqn7i6D2orqXRP19c6N
 lX1i7WL3O/B9QiiCk3iv/dtN+d5AxrMsKLsarkiEjwA1rZG4cVe3wP7RsVcMn4+2NFfL
 TOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522869; x=1690114869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQhWpZw084Ja0HJjsgxPSzSU22UDw5r1FrOeDB0PeQQ=;
 b=ZaeD0RiNxZPLX8SL+KUuRZ+wDidtl39If2lUO0YpszEV0Pz+P1dQKdpgQL3WbxtTux
 zQ36o6fBmCh7Z75iy9oMz5YvPHMW5/z+Q2JNX4fR/U3lG9DM2mE3V2t++VwVK3mwI4wP
 z55y167ozOLULBNP238Io4TEbuLKmDgKMS57nq4JPDm2K+lLP+VDoLaWGBqMDav2yCnc
 9iK0oLw9nW7se7O5cBWddhdB4Vd6IU55Diz1TzbmFfTjKt7EGfBm7D9fa9HgL0GpYKMr
 dQuCA8h3+6gx6Fc1cDXZRL44uPK7fDVQpPxJBGzAI3XyVaznn9x+16OaBTfJRYyzQTCz
 bBeQ==
X-Gm-Message-State: AC+VfDx0o0y/lIRUFtnl1DJX+fCbxqkol7IYLdUXXJGo6BzgxFrcFrZu
 qNCAazF62iJh1UXjkmPgtrOdKw==
X-Google-Smtp-Source: ACHHUZ7x5+ns7tUJhf3GT/Z39b92DUvFQ+VPL00FWNGZDisEWRb2idYhSrA/EmtSEXMDfgEOQAWKQA==
X-Received: by 2002:a19:f201:0:b0:4f7:b640:fa40 with SMTP id
 q1-20020a19f201000000b004f7b640fa40mr11602940lfh.43.1687522869138; 
 Fri, 23 Jun 2023 05:21:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a6-20020adffac6000000b0030aefa3a957sm9442679wrs.28.2023.06.23.05.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D844C1FFCA;
 Fri, 23 Jun 2023 13:21:02 +0100 (BST)
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
Subject: [PATCH 19/26] plugins: fix memory leak while parsing options
Date: Fri, 23 Jun 2023 13:20:53 +0100
Message-Id: <20230623122100.1640995-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Message-Id: <20230519170454.2353945-3-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


