Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440272669D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wTo-0001KK-Nb; Wed, 07 Jun 2023 12:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTj-0001Dr-F5
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:49 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTg-0001pJ-Tb
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:46 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-ba8cd61ee2dso1195274276.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686157063; x=1688749063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruOmHOKIvXadvE8jXrAJUnNa6lotn9rQ25E1Fic8ZjU=;
 b=a1i6bcHBBf1iIA37q/wV0LZZwmsX6IL7V42P+z22zyO+6Pbbk+4lmrooSpSlrLIZCA
 mwNLsvU7t1d8VzMEz+04Tpm8SyXsCddrOoxcF/8Z09KDNJQFDe9D2QoRRR38GZMzD2T4
 CRp7FSQwemcJV/QMdh0vQhFHj+XWHj7Y1LBSVyvuhJxGa08CgZ4FZl8M+u5TGuNDt2s1
 9khY0mShtYpH1OjwdPlrzWzs3kUXxQARRqTtCTUwhCm9qQXzg7kw0V7FIRduLUQwof6o
 eM3tGIWl3KUp1fZyEXBjTtTuS1CrZJiczakFGwURAqFgy7cEZLEGWys3C33bhNNs0Qjb
 iWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157063; x=1688749063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruOmHOKIvXadvE8jXrAJUnNa6lotn9rQ25E1Fic8ZjU=;
 b=YZYQpY31FhHPtk4EtqAJpgKQnVWfRxj0r0hZxaQfCZhg3tMm4cyyk5tpYc7GDzA1vq
 MEclizM+Fpnn1yPcMc5SCKsI9/LEW9YFj21FJUJbfhrXk8GluDtif3m/yOH9xOZelF0n
 sR3XKZxOgTfK7Dhqzc6V9meYMSsdxyZHHAjKIn2Ke4IY7pP0mAeMmI//rkYolOuzTt4d
 8HTKzhO4cBkNbymgj4opgxeQ5LRIQdTBv++90BEeSyIv1lVY70Cyd1kIkJ5mL6ur4cqb
 xPCWtMefL04Vi0HLSDxJCGDBzfW8vDPqk2gM8YYzdDFewXLz3SurxX9rinz9SnGweZvB
 hVlA==
X-Gm-Message-State: AC+VfDwfvTOlRQrO+xrgSVH23DGvqPhjpJW9xSOAFNhBOSpuWOCZgZkM
 ePeJYZdXE4eA0pVGs5Y2JaFzsTOx8SmE0ZmJx+g=
X-Google-Smtp-Source: ACHHUZ7Mh4Si2nhbjlq9k0Z/+l+JZW0lmWKMdldsfKNH9j1sjxjMr0mtgTGrd4mtBUG0OknNmPJhbA==
X-Received: by 2002:a17:90b:8d7:b0:256:7866:8c06 with SMTP id
 ds23-20020a17090b08d700b0025678668c06mr17008900pjb.19.1686156573350; 
 Wed, 07 Jun 2023 09:49:33 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:32 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [RFC v2 6/6] linux-user: Add '-native-bypass' option
Date: Thu,  8 Jun 2023 00:47:50 +0800
Message-Id: <20230607164750.829586-7-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 include/qemu/envlist.h |  1 +
 linux-user/main.c      | 23 +++++++++++++++++
 util/envlist.c         | 56 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
index 6006dfae44..865eb18e17 100644
--- a/include/qemu/envlist.h
+++ b/include/qemu/envlist.h
@@ -7,6 +7,7 @@ envlist_t *envlist_create(void);
 void envlist_free(envlist_t *);
 int envlist_setenv(envlist_t *, const char *);
 int envlist_unsetenv(envlist_t *, const char *);
+int envlist_appendenv(envlist_t *, const char *, const char *);
 int envlist_parse_set(envlist_t *, const char *);
 int envlist_parse_unset(envlist_t *, const char *);
 char **envlist_to_environ(const envlist_t *, size_t *);
diff --git a/linux-user/main.c b/linux-user/main.c
index 5e6b2e1714..313c116b3b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -125,6 +125,8 @@ static void usage(int exitcode);
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
 
+static const char *native_lib;
+
 #if !defined(TARGET_DEFAULT_STACK_SIZE)
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
    we allocate a bigger stack. Need a better solution, for example
@@ -293,6 +295,13 @@ static void handle_arg_set_env(const char *arg)
     free(r);
 }
 
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+static void handle_arg_native_bypass(const char *arg)
+{
+    native_lib = arg;
+}
+#endif
+
 static void handle_arg_unset_env(const char *arg)
 {
     char *r, *p, *token;
@@ -522,6 +531,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+    {"native-bypass", "QEMU_NATIVE_BYPASS", true, handle_arg_native_bypass,
+     "",           "native bypass for library calls in user mode only."},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -826,6 +839,16 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+    /* Set the library for native bypass  */
+    if (native_lib != NULL) {
+        char *token = malloc(strlen(native_lib) + 12);
+        strcpy(token, "LD_PRELOAD=");
+        strcat(token, native_lib);
+         if (envlist_appendenv(envlist, token, ":") != 0) {
+            usage(EXIT_FAILURE);
+        }
+    }
+
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
diff --git a/util/envlist.c b/util/envlist.c
index db937c0427..713d52497e 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -201,6 +201,62 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
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
+    if ((envlist == NULL) || (env == NULL)) {
+        return (EINVAL);
+    }
+
+    /* find out first equals sign in given env */
+    eq_sign = strchr(env, '=');
+    if (eq_sign == NULL) {
+        return (EINVAL);
+    }
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
+        char *new_env_value = NULL;
+        size_t new_env_len = strlen(entry->ev_var) + strlen(eq_sign)
+            + strlen(separator) + 1;
+        new_env_value = g_malloc(new_env_len);
+        strcpy(new_env_value, entry->ev_var);
+        strcat(new_env_value, separator);
+        strcat(new_env_value, eq_sign + 1);
+        g_free((char *)entry->ev_var);
+        entry->ev_var = new_env_value;
+    } else {
+        envlist->el_count++;
+        entry = g_malloc(sizeof(*entry));
+        entry->ev_var = g_strdup(env);
+        QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
+    }
+
+    return (0);
+}
+
 /*
  * Returns given envlist as array of strings (in same form that
  * global variable environ is).  Caller must free returned memory
-- 
2.34.1


