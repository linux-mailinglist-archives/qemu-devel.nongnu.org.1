Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C473EE6B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuMr-0004hs-PI; Mon, 26 Jun 2023 18:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLP-0003BV-0g
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLK-00071y-CZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f9b4a71623so36859415e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817152; x=1690409152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11KGvl02MUnRlabivlCyzSFcj3NOwo4O5qJ7ZZfB8KY=;
 b=FNFfLS0Kh7bJQR06kiismpZVGHURNbbKbVUNbAVOprZzBxgE9aKFC9DosLTEzYmOWB
 bicOATZGoNwacClLJGj82aadnzjfEWr+uJV/0a29+8nQp1LtIowVO0+uTJ3WELPFlzXI
 /CDhbZUkLW2eFUp5q6o2a1WQYEUDfjxk9EkDXR7CFA8TE9Fa1WJrMJB40Bj4t+AhSBBf
 1OuMd3Ed1nx1RPth3HWqrh1Ghcz6fyE25BhWmCJJGNCj3e5ext+DW1riizIl2PpZcBzU
 bE4qvCWsJcPRY31vFyEdKxSZgbT5i4dGp/RVnjGF76wiSpNE0myZkUY6+B4ua6k1EJ+E
 nQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817152; x=1690409152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11KGvl02MUnRlabivlCyzSFcj3NOwo4O5qJ7ZZfB8KY=;
 b=jWcV/NNQRCDSyPPzMDqtlOiNVX5B6nA5flJrjIX13BdTMYfTlbuZE0Z84wBN77MLa5
 UpYuU/laBwYtOtdmP0EO0ysEAmyRQ13ModaUuaVM42+I9xq5W31UDyr9iXeSGya/jU6h
 8zNIFDlbY8dD1cWh3yA+cmRCq5bJ8xwQZW9ShnmgJTTd5oVzSG5F4hvz6Qv5rR2GzuAp
 q3b2jW8QbulQw+jFiK7XGaVSymDGCYzqdThIdsJQfpoiiXK9vGWFxqO0tgLgDUKFzn5e
 UdYJ4sPJv1+083Tv1jD6Uw865CWUXzBIubJst7SfkM5gHOSjgaI+ynZh5N4+I+EApfS6
 +5eg==
X-Gm-Message-State: AC+VfDwYuBpiRp89pZLQJJuBcg6XtG1g10rm3HIJU6I/QqcFDpZxpNwh
 ud3a0u3DmqWE941pwd91a1XkuA==
X-Google-Smtp-Source: ACHHUZ7IFHIvC14LKq8pUAdS3IG3rm8wrynv17LCE6yT/RaPXfQMHWAP7T7ZHOWRDtrjR0tlWlMFxg==
X-Received: by 2002:a1c:721a:0:b0:3f9:c19:dfbd with SMTP id
 n26-20020a1c721a000000b003f90c19dfbdmr16130029wmc.0.1687817151817; 
 Mon, 26 Jun 2023 15:05:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fa78d1055esm8799597wmd.21.2023.06.26.15.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 20A0B1FFCA;
 Mon, 26 Jun 2023 22:59:29 +0100 (BST)
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
Subject: [PATCH v2 18/26] plugins: fix memory leak while parsing options
Date: Mon, 26 Jun 2023 22:59:18 +0100
Message-Id: <20230626215926.2522656-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230623122100.1640995-20-alex.bennee@linaro.org>
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


