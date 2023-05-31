Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E695F7187DD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4P7B-0001C9-F5; Wed, 31 May 2023 12:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GXx3ZAQKCho5BMK6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--flwu.bounces.google.com>)
 id 1q4P78-0001BM-9l
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:55:58 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GXx3ZAQKCho5BMK6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--flwu.bounces.google.com>)
 id 1q4P75-0002hD-SJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:55:57 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-53f2128ab1bso3109325a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685552154; x=1688144154;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hRYLWzhdqiApyYA5TJlPzr8zZQfvw70K7aAt35D1jk0=;
 b=MbishWFgnoCHx1ckdl0CLoD5Wl7WND3ifGl1NMX4sR0SMJ/hP7VB923SbGDkSGxQfk
 +ydQI7fjV9GId6ZXT04mwWOax9nONms1QyWHFaCalM/erqnl0omK3Ez1IkQ2VFMCTvdZ
 mMnSmPbuAFoPySEkFZ9Pfz2Q7Y3RGBTvr1len2FveywSvX1znGg1ggX1j1PfVhhdzlTL
 8RF44JcVOxWrjiIyIIhaFJ2Z881tf+cML4NJ0HTd8jm0Hx+Cme6uK8REFkl5p4iK/Gs4
 +/qFfxWKZFhdb4stnsLqz8/PPyp/poO8x2PlxJlZzDsX7Xic2XWmMNkWxBpkknrjUIcX
 fOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685552154; x=1688144154;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hRYLWzhdqiApyYA5TJlPzr8zZQfvw70K7aAt35D1jk0=;
 b=LWMQHrtK4qHKvehXPpjvw5BUV7VpwzIxzTUrfz+WtHItT/eNo3VzdFtt/dslWDkgba
 7SnIbcyibBRaQ5mR9IFdD5hoFf/BGQ9w3Y7LggV0LzBess93NSfA+fDroBvGD7vuBKX1
 BgqNgB6T6l/ox2nU8KxL8Oj76nbMqiLm4J6FUo60P8AGzxSn337QpuNqcKxEG6+IDC1Y
 PK3VmJYmIRweX3AENKgweZhuyZGBK3Brh1p85j3k0GN0lVufY+22DrL5U4GE0PbYo8wT
 UX3rLt6wBu7HVHspVrzCVIJhC/Sd9k1wviX0LVFo+hr5leyTtUAytXylcEv49S/N0Nby
 rdyQ==
X-Gm-Message-State: AC+VfDwW1odXwlg0sheK9zSBFLyGqTQD/BIUfFgRYeeTUXvOR6k3RqJ0
 St3LlmgB2+lFpprR42p7N8l8wKqG
X-Google-Smtp-Source: ACHHUZ5IB9HtNRQTHTp6ljJfkjjK6/01xjDIhobJp1PYiRXWDhlQsjnchs5mp52Qs62dnGZvm8nrxHvD
X-Received: from flwu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2200])
 (user=flwu job=sendgmr) by 2002:a63:495f:0:b0:53f:7713:5e0e with
 SMTP id
 y31-20020a63495f000000b0053f77135e0emr1197520pgk.5.1685552153974; Wed, 31 May
 2023 09:55:53 -0700 (PDT)
Date: Wed, 31 May 2023 16:55:37 +0000
In-Reply-To: <20230531165537.3721999-1-flwu@google.com>
Mime-Version: 1.0
References: <20230531165537.3721999-1-flwu@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531165537.3721999-3-flwu@google.com>
Subject: [PATCH 2/2] tests/qtest: Add qtest for for ASPEED GPIO gpio-set
 property
From: Jingbo Wu <flwu@google.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3GXx3ZAQKCho5BMK6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--flwu.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Felix Wu <flwu@google.com>

 - Added qtests to test gpio-set property for ASPEED.
 - Added function to get uint in qdict.

Signed-off-by: Felix Wu <flwu@google.com>
---
 include/qapi/qmp/qdict.h       |   1 +
 qobject/qdict.c                |  13 ++++
 tests/qtest/aspeed_gpio-test.c | 105 ++++++++++++++++++++++++++++++---
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 82e90fc072..50046f4285 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -57,6 +57,7 @@ void qdict_put_str(QDict *qdict, const char *key, const char *value);
 
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
+uint64_t qdict_get_uint(const QDict *qdict, const char *key);
 bool qdict_get_bool(const QDict *qdict, const char *key);
 QList *qdict_get_qlist(const QDict *qdict, const char *key);
 QDict *qdict_get_qdict(const QDict *qdict, const char *key);
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..916467958d 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -209,6 +209,19 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
     return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
 }
 
+/**
+ * qdict_get_uint(): Get an unsigned integer mapped by 'key'
+ *
+ * This function assumes that 'key' exists and it stores a
+ * QNum representable as uint.
+ *
+ * Return unsigned integer mapped by 'key'.
+ */
+uint64_t qdict_get_uint(const QDict *qdict, const char *key)
+{
+    return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
+}
+
 /**
  * qdict_get_bool(): Get a bool mapped by 'key'
  *
diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index d38f51d719..38000c7868 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -27,28 +27,115 @@
 #include "qemu/timer.h"
 #include "qapi/qmp/qdict.h"
 #include "libqtest-single.h"
+#include "qemu/typedefs.h"
 
 #define AST2600_GPIO_BASE 0x1E780000
 
 #define GPIO_ABCD_DATA_VALUE 0x000
 #define GPIO_ABCD_DIRECTION  0x004
 
+static uint32_t qtest_qom_get_uint32(QTestState *s, const char *path,
+                                     const char *property)
+{
+    QDict *r;
+
+    uint32_t res;
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+    res = qdict_get_uint(r, "return");
+    qobject_unref(r);
+
+    return res;
+}
+
+static void qtest_qom_set_uint32(QTestState *s, const char *path,
+                                 const char *property, uint32_t value)
+{
+    QDict *r;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-set', 'arguments': "
+                     "{ 'path': %s, 'property': %s, 'value': %" PRIu32 " } }",
+                     path, property, value);
+    qobject_unref(r);
+}
+
+static const char *resp_get_error(QDict *r, const char* error_key)
+{
+    QDict *qdict;
+
+    g_assert(r);
+
+    qdict = qdict_get_qdict(r, "error");
+    if (qdict) {
+        return qdict_get_str(qdict, error_key);
+    }
+
+    return NULL;
+}
+
+static bool qtest_qom_check_error(QTestState *s, const char *path,
+                                  const char *property, const char *error_msg,
+                                  const char *error_msg_key)
+{
+    QDict *r;
+    bool b;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+    b = g_str_equal(resp_get_error(r, error_msg_key), error_msg);
+    qobject_unref(r);
+
+    return b;
+}
+
 static void test_set_colocated_pins(const void *data)
 {
     QTestState *s = (QTestState *)data;
-
+    const char path[] = "/machine/soc/gpio";
     /*
      * gpioV4-7 occupy bits within a single 32-bit value, so we want to make
      * sure that modifying one doesn't affect the other.
      */
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV4", true);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV5", false);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV6", true);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV7", false);
-    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV4"));
-    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV5"));
-    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV6"));
-    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV7"));
+    qtest_qom_set_bool(s, path, "gpioV4", true);
+    qtest_qom_set_bool(s, path, "gpioV5", false);
+    qtest_qom_set_bool(s, path, "gpioV6", true);
+    qtest_qom_set_bool(s, path, "gpioV7", false);
+    g_assert(qtest_qom_get_bool(s, path, "gpioV4"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioV5"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioV6"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioV7"));
+
+    /*
+     * Testing the gpio-set[%d] properties, using individual gpio boolean
+     * properties to do cross check.
+     * We use gpioR4-7 for test, Setting them to be 0b1010.
+     */
+    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0x0);
+    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0x0);
+    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0xa000);
+    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0xa000);
+
+    g_assert(!qtest_qom_get_bool(s, path, "gpioR4"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioR5"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioR6"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioR7"));
+
+    /*
+     * Testing the invalid indexing, the response info should contain following
+     * info:
+     * {key: "class", value: "GenericError"}
+     *
+     * For pins, it should follow "gpio%2[A-Z]%1d" or "gpio%3[18A-E]%1d" format.
+     */
+    const char error_msg[] = "GenericError";
+    const char error_msg_key [] = "class";
+
+    g_assert(qtest_qom_check_error(s, path, "gpioR+1", error_msg,
+                                   error_msg_key));
+    g_assert(qtest_qom_check_error(s, path, "gpio-set[99]", error_msg,
+                                   error_msg_key));
+    g_assert(qtest_qom_check_error(s, path, "gpio-set[-3]", error_msg,
+                                   error_msg_key));
 }
 
 static void test_set_input_pins(const void *data)
-- 
2.41.0.rc0.172.g3f132b7071-goog


