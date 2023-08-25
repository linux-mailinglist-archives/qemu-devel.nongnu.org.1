Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD877884DB
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTxu-00077J-OE; Fri, 25 Aug 2023 06:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxs-000776-PD
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxq-0004ku-9Z
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a3082c771so592480b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692958969; x=1693563769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnMgbb3eHMu2WVFHDfLveza5RGGaFqQpAry19Wrh14U=;
 b=e9htfI59SrsvUUiHG6PMRf1mGsP8on3W8g5mYDKEAjksF+oEzRZQBhlQ1aE2vZ86Rz
 mYNW0dFu/Wm+5W6iF4tc4nqoKeBVylRqkKu6LLY1lQGFMfd7LXmb6u97oDWt07coV+nE
 wrCe0Gu1h0DmRzITbis0yG2/S1Qkn6G6LFNVIwjBtaNnzMVkYj1GxEGrGOdYkALTpuN5
 QvpC6fQ08nQwS+7BGeDsXtJ7VvIthlCtCxBh4i/4HoMZlIzcNbHXZoPhPd3jgIQRPuS1
 YzSGfehqLvcvlATt7N9987fCExq1ylCqiyZaSJJOOeAXxuvpLkMcxcymlMSzjkAWX7Gx
 MFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692958969; x=1693563769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnMgbb3eHMu2WVFHDfLveza5RGGaFqQpAry19Wrh14U=;
 b=TUhsrDk0Yg6klIlYM3d4EFXscPutRBG0jWZhAYKg7RzXNnQvSNDpnFs0bnHU/+sHGo
 vbQARPflHvE/RF2xrTgktxAWuoEESa369gXWyv10+wvkNaGAQ4exaGU8qpNJbKMWEOPk
 cWXdXjWu8A3izXxNhMDtjTDC2FszT3DTHWda6MqB21Gex2BmBcZLk7qWaT6A+4jtFPQh
 7hloKbJteKcMKj1DyiAADq1OW5opi64tlu22dD8Jw672x/bKjVi7YtG3Y+SWqImxqOoP
 GR84xNlVeOmIyYa/S6vppgTDlWdBXKaoCFJiyDW1s+FYcCwbRqdVMK3UFDWq7LGdqxtR
 p1UQ==
X-Gm-Message-State: AOJu0Yy+f/lFV2OilzNY89aIuDDr4+0kpyHfJLdoD8StX/UMwaHlTpVs
 goP6uWKBwKPIo6uorx8vL5mlYXpOt6Hdeg==
X-Google-Smtp-Source: AGHT+IEBVblPXsON54LrLMyRtcVJsWNFf0/x3C/dZJfTnqAwZCBv8g3t/A6EICBJ/s7oPQImk73GgA==
X-Received: by 2002:a05:6a00:301e:b0:68a:593a:333f with SMTP id
 ay30-20020a056a00301e00b0068a593a333fmr20528413pfb.13.1692958968922; 
 Fri, 25 Aug 2023 03:22:48 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa781c5000000b0068a077847c7sm1220954pfn.135.2023.08.25.03.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:22:48 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v5 03/10] linux-user: Implement envlist_appendenv and add tests
 for envlist
Date: Fri, 25 Aug 2023 18:20:01 +0800
Message-Id: <20230825102009.1754699-4-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
References: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 include/qemu/envlist.h    | 13 ++++++
 tests/unit/meson.build    |  1 +
 tests/unit/test-envlist.c | 94 +++++++++++++++++++++++++++++++++++++++
 util/envlist.c            | 67 +++++++++++++++++++++++-----
 4 files changed, 165 insertions(+), 10 deletions(-)
 create mode 100644 tests/unit/test-envlist.c

diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
index 6006dfae44..dc0fe4e644 100644
--- a/include/qemu/envlist.h
+++ b/include/qemu/envlist.h
@@ -1,12 +1,25 @@
 #ifndef ENVLIST_H
 #define ENVLIST_H
 
+#include "qemu/queue.h"
+
+struct envlist_entry {
+    char *ev_var;            /* actual env value */
+    QLIST_ENTRY(envlist_entry) ev_link;
+};
+
+struct envlist {
+    QLIST_HEAD(, envlist_entry) el_entries; /* actual entries */
+    size_t el_count;                        /* number of entries */
+};
+
 typedef struct envlist envlist_t;
 
 envlist_t *envlist_create(void);
 void envlist_free(envlist_t *);
 int envlist_setenv(envlist_t *, const char *);
 int envlist_unsetenv(envlist_t *, const char *);
+int envlist_appendenv(envlist_t *, const char *, const char *);
 int envlist_parse_set(envlist_t *, const char *);
 int envlist_parse_unset(envlist_t *, const char *);
 char **envlist_to_environ(const envlist_t *, size_t *);
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 93977cc32d..9b25b45271 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -50,6 +50,7 @@ tests = {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-xs-node': [qom],
+  'test-envlist': [],
 }
 
 if have_system or have_tools
diff --git a/tests/unit/test-envlist.c b/tests/unit/test-envlist.c
new file mode 100644
index 0000000000..d583c6ee33
--- /dev/null
+++ b/tests/unit/test-envlist.c
@@ -0,0 +1,94 @@
+/*
+ * testenvlist unit-tests.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/envlist.h"
+
+static void envlist_create_free_test(void)
+{
+    envlist_t *testenvlist;
+
+    testenvlist = envlist_create();
+    g_assert(testenvlist != NULL);
+    g_assert(testenvlist->el_count == 0);
+
+    envlist_free(testenvlist);
+}
+
+static void envlist_set_unset_test(void)
+{
+    envlist_t *testenvlist;
+    const char *env = "TEST=123";
+    struct envlist_entry *entry;
+
+    testenvlist = envlist_create();
+    g_assert(envlist_setenv(testenvlist, env) == 0);
+    g_assert(testenvlist->el_count == 1);
+    entry = testenvlist->el_entries.lh_first;
+    g_assert_cmpstr(entry->ev_var, ==, "TEST=123");
+    g_assert(envlist_unsetenv(testenvlist, "TEST") == 0);
+    g_assert(testenvlist->el_count == 0);
+
+    envlist_free(testenvlist);
+}
+
+static void envlist_length_test(void)
+{
+    envlist_t *testenvlist;
+    const char *env = "TEST1=123,TEST2=456";
+
+    testenvlist = envlist_create();
+    g_assert(envlist_parse_set(testenvlist, env) == 0);
+    g_assert(testenvlist->el_count == 2);
+    g_assert(envlist_parse_unset(testenvlist, "TEST1,TEST2") == 0);
+    g_assert(testenvlist->el_count == 0);
+
+    envlist_free(testenvlist);
+}
+
+static void envlist_appendenv_test(void)
+{
+    envlist_t *testenvlist;
+    const char *env = "TEST=123";
+    struct envlist_entry *entry;
+
+    testenvlist = envlist_create();
+    g_assert(envlist_setenv(testenvlist, env) == 0);
+    g_assert(envlist_appendenv(testenvlist, "TEST=456", ";") == 0);
+    entry = testenvlist->el_entries.lh_first;
+    g_assert_cmpstr(entry->ev_var, ==, "TEST=123;456");
+
+    envlist_free(testenvlist);
+}
+
+static void envlist_to_environ_test(void)
+{
+    envlist_t *testenvlist;
+    const char *env = "TEST1=123,TEST2=456";
+    size_t count;
+    char **environ;
+
+    testenvlist = envlist_create();
+    g_assert(envlist_parse_set(testenvlist, env) == 0);
+    g_assert(testenvlist->el_count == 2);
+    environ = envlist_to_environ(testenvlist, &count);
+    g_assert(count == 2);
+    g_assert_cmpstr(environ[1], ==, "TEST1=123");
+    g_assert_cmpstr(environ[0], ==, "TEST2=456");
+
+    envlist_free(testenvlist);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/envlist/create_free", envlist_create_free_test);
+    g_test_add_func("/envlist/set_unset", envlist_set_unset_test);
+    g_test_add_func("/envlist/length", envlist_length_test);
+    g_test_add_func("/envlist/appendenv", envlist_appendenv_test);
+    g_test_add_func("/envlist/to_environ", envlist_to_environ_test);
+
+    return g_test_run();
+}
diff --git a/util/envlist.c b/util/envlist.c
index db937c0427..2dfead4a0f 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -2,16 +2,6 @@
 #include "qemu/queue.h"
 #include "qemu/envlist.h"
 
-struct envlist_entry {
-    const char *ev_var;            /* actual env value */
-    QLIST_ENTRY(envlist_entry) ev_link;
-};
-
-struct envlist {
-    QLIST_HEAD(, envlist_entry) el_entries; /* actual entries */
-    size_t el_count;                        /* number of entries */
-};
-
 static int envlist_parse(envlist_t *envlist,
     const char *env, int (*)(envlist_t *, const char *));
 
@@ -201,6 +191,63 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
     return (0);
 }
 
+/*
+ * Appends environment value to envlist. If the environment
+ * variable already exists, the new value is appended to the
+ * existing one.
+ *
+ * Returns 0 in success, errno otherwise.
+ */
+int
+envlist_appendenv(envlist_t *envlist, const char *env, const char *separator)
+{
+    struct envlist_entry *entry = NULL;
+    const char *eq_sign;
+    size_t envname_len;
+
+    if ((envlist == NULL) || (env == NULL) || (separator == NULL)) {
+        return -EINVAL;
+    }
+
+    /* find out first equals sign in given env */
+    eq_sign = strchr(env, '=');
+    if (eq_sign == NULL) {
+        return -EINVAL;
+    }
+
+    if (strchr(eq_sign + 1, '=') != NULL) {
+        return -EINVAL;
+    }
+
+    envname_len = eq_sign - env + 1;
+
+    /*
+     * If there already exists variable with given name,
+     * we append the new value to the existing one.
+     */
+    for (entry = envlist->el_entries.lh_first; entry != NULL;
+        entry = entry->ev_link.le_next) {
+        if (strncmp(entry->ev_var, env, envname_len) == 0) {
+            break;
+        }
+    }
+
+    if (entry != NULL) {
+        GString *new_val = g_string_new(entry->ev_var);
+        g_string_append(new_val, separator);
+        g_string_append(new_val, eq_sign + 1);
+        g_free(entry->ev_var);
+        entry->ev_var = g_string_free(new_val, false);
+    } else {
+        envlist->el_count++;
+        entry = g_malloc(sizeof(*entry));
+        entry->ev_var = g_strdup(env);
+        QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
+    }
+
+    return 0;
+}
+
 /*
  * Returns given envlist as array of strings (in same form that
  * global variable environ is).  Caller must free returned memory
-- 
2.34.1


