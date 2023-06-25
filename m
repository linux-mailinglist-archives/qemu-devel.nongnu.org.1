Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937173D483
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGe-0005X9-CO; Sun, 25 Jun 2023 17:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGc-0005WY-B5
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:30 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGa-0003RG-Kk
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-544c0d768b9so2285794a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728447; x=1690320447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpQLE595W5oqS4gd0K1Yg8xwY1BVVo0MaNKXsQUnaeY=;
 b=mKgk3wLrtCL2djrfdgTWO4ndKpe8Oow0BjJQdjTfltnQGd+B74R3f4y9H0jvS6dqu5
 kRMz0qqnJHTRzzpKa2hR5EeuNS3wCApL/xeij8kE57m+G5NuZJuO5aCzF7fhT9De+6gA
 DJvcKZtJEWixOtuvpc9T6PKzX9yl5MXeXIVeRE/9nUJnh1/imBD+o046JSYpC/5fG6Yo
 si8wf0klCsL7V4tgWmS4K0M4ErRkKBsLsKUSngIWdtWld54Nz+olxLjM8PjbUD6nIpV4
 PYTTtlof+59O4FWic5UxRSY+6Q5skIgMmvKQIjolR1eh4UEL22ZMiPz8wrLvG7hqfKFq
 WMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728447; x=1690320447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpQLE595W5oqS4gd0K1Yg8xwY1BVVo0MaNKXsQUnaeY=;
 b=PRIaOSU+mngPANb6NjAxFOH313AnLqLIk6UOwJdkw4q6UBPOCHRimUlYkRuaNgnIWS
 jOHLrDOxZk4/dLx+jOIIWkjrZBISsOUmw4udSzH9N9x42iCy1dxwO+JhOj8rUm/ecFzk
 x+nE5WN3PSUt6wp0O09WuV96MFAcrMnRNQyBJe7Kq/x4/jfNTdrDUYzASD1UUQY6QaNd
 jitXsnXjdAxRH7es1cNYHX+pxf4Z17o54FPmicDpMGMNbUoyROIRPlezuvXinDYQIXVO
 nc2JP2K3iTC4voEHVVhuEC0+VV95MbrOLS4hZQ8OFnrKOw3saRlhKTDcyZWlVrT2AHfj
 1hDQ==
X-Gm-Message-State: AC+VfDxjK0zy1VvR6PV+J3bHlEIpNH17fED1S7cMTtyru6KxZ1mEpN8b
 jh+A01umpky2N0ZHtvQwC0Xf/1RKho2PlGHy
X-Google-Smtp-Source: ACHHUZ4tupI9B4rV88jXPK11V4Mkp/r8fS66b8cVYFyQuZHHAvykl+61Gz7KQMXAWLDIf2Jqpk1gdg==
X-Received: by 2002:a17:902:7445:b0:1b3:dcf1:97 with SMTP id
 e5-20020a170902744500b001b3dcf10097mr6607388plt.25.1687728447262; 
 Sun, 25 Jun 2023 14:27:27 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:27 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: [RFC v3 04/10] linux-user: Implement envlist_appendenv
Date: Mon, 26 Jun 2023 05:27:01 +0800
Message-Id: <20230625212707.1078951-5-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pg1-x532.google.com
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
 util/envlist.c         | 61 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
diff --git a/util/envlist.c b/util/envlist.c
index db937c0427..635c9c4fab 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -201,6 +201,67 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
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
+        return (EINVAL);
+    }
+
+    /* find out first equals sign in given env */
+    eq_sign = strchr(env, '=');
+    if (eq_sign == NULL) {
+        return (EINVAL);
+    }
+
+    if (strchr(eq_sign + 1, '=') != NULL) {
+        return (EINVAL);
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


