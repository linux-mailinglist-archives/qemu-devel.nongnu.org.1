Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B48D7B7E9A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0ap-0001bo-8o; Wed, 04 Oct 2023 08:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Z3-0000Bc-3r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yz-00013c-Sc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3248aa5cf4eso2042319f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420871; x=1697025671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSsZst+VBCRAXvBcctI1DdSiyNeof1zy8WHkK6DbNv0=;
 b=W0kQUSP1RninGVGh1C8T+Fwdvu2rCnhH+0hNPfhUmPibqFtxidGxr/Jeph40GIvMyt
 g9pXYI3VpIA0k9ST6Y/jj8bg2LTqO7zldlZib+LvhAZ0aco+gxdgxnzmSmqLmBjXp1PJ
 5+agjujZaO3xFPsoii+aDwxcxCyjQecvG2TDJwcgB/jkuze7+/c0QpDNWa2nY0MTveP4
 0FQL/pisxGYC2wYMoRs8QzX5BGTEeavyydyAR/CrvsMrXDOUF9p3JSud7mfKB7pg1n8H
 U2hc0UZnRgVx/ebK1pR5dpLdhe/0w+Y2ApHrVmpqxB7vm1HyzS/gAKCu3LlPHcK6ZMJ+
 Ydlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420871; x=1697025671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSsZst+VBCRAXvBcctI1DdSiyNeof1zy8WHkK6DbNv0=;
 b=HYn9/N3lCE3JeM38F8YB9AH/ImeJHfCzl1zgmFruGzaM0+aTOv2qaSFTj0jcHGRPwG
 AS87OCv0hiMR8J3NiPVUzlJLsOOiYxbgJxE/3gUlMHb4vHJy28eMJG4UEZ4afmoPF7lP
 E5/51+m7cEsQxelzlY+3iw6wl2gmsBUvtBGs0XMIMEqBNHnnxsoSVkRz1noIYl94vo8+
 8t0jbEMs+lZ9TYBCBkSYG3tDoEWmL5wX57SWcqzKelAyqCaOpmMK5Sd4hStOPmnHRrAA
 31XmZnJ2cThJ0+gZJFfu2uuwU/JtmkZRgyIUioJ5AJNef0TZMlXxSOH8aWfgFT0EoemX
 P67g==
X-Gm-Message-State: AOJu0YyLFL+tcGP+SCDCVQOwidpTOjWbqP+EOQRE8/hvzhQ4c1vLMNtZ
 m03VGc42aVxtGFxA9Mv82pGWBO/YIz5hmwNKKQc=
X-Google-Smtp-Source: AGHT+IFHnxfX0hdWAcNtmdBKTKDUyXwbxoBSvzl69Kgnya+2rYyG3gXbTthq1ZYiYEo8Yr1N+CbJug==
X-Received: by 2002:a5d:6091:0:b0:317:5747:b955 with SMTP id
 w17-20020a5d6091000000b003175747b955mr1630470wrt.17.1696420870820; 
 Wed, 04 Oct 2023 05:01:10 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 g9-20020a5d46c9000000b0031ae8d86af4sm3862502wrs.103.2023.10.04.05.01.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 08/16] qom/object_interfaces: Clean up global variable
 shadowing
Date: Wed,  4 Oct 2023 14:00:11 +0200
Message-ID: <20231004120019.93101-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix:

  qom/object_interfaces.c:262:53: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
                                                      ^
  qom/object_interfaces.c:298:46: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  bool user_creatable_add_from_str(const char *optarg, Error **errp)
                                               ^
  qom/object_interfaces.c:313:49: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void user_creatable_process_cmdline(const char *optarg)
                                                  ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object_interfaces.h | 16 ++++++++--------
 qom/object_interfaces.c         | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 81541e2080..02b11a7ef0 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -99,7 +99,7 @@ void user_creatable_add_qapi(ObjectOptions *options, Error **errp);
 
 /**
  * user_creatable_parse_str:
- * @optarg: the object definition string as passed on the command line
+ * @str: the object definition string as passed on the command line
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Parses the option for the user creatable object with a keyval parser and
@@ -110,14 +110,14 @@ void user_creatable_add_qapi(ObjectOptions *options, Error **errp);
  * Returns: ObjectOptions on success, NULL when an error occurred (*errp is set
  * then) or help was printed (*errp is not set).
  */
-ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp);
+ObjectOptions *user_creatable_parse_str(const char *str, Error **errp);
 
 /**
  * user_creatable_add_from_str:
- * @optarg: the object definition string as passed on the command line
+ * @str: the object definition string as passed on the command line
  * @errp: if an error occurs, a pointer to an area to store the error
  *
- * Create an instance of the user creatable object by parsing optarg
+ * Create an instance of the user creatable object by parsing @str
  * with a keyval parser and implicit key 'qom-type', converting the
  * result to ObjectOptions and calling into qmp_object_add().
  *
@@ -126,13 +126,13 @@ ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp);
  * Returns: true when an object was successfully created, false when an error
  * occurred (*errp is set then) or help was printed (*errp is not set).
  */
-bool user_creatable_add_from_str(const char *optarg, Error **errp);
+bool user_creatable_add_from_str(const char *str, Error **errp);
 
 /**
  * user_creatable_process_cmdline:
- * @optarg: the object definition string as passed on the command line
+ * @cmdline: the object definition string as passed on the command line
  *
- * Create an instance of the user creatable object by parsing optarg
+ * Create an instance of the user creatable object by parsing @cmdline
  * with a keyval parser and implicit key 'qom-type', converting the
  * result to ObjectOptions and calling into qmp_object_add().
  *
@@ -141,7 +141,7 @@ bool user_creatable_add_from_str(const char *optarg, Error **errp);
  * This function is only meant to be called during command line parsing.
  * It exits the process on failure or after printing help.
  */
-void user_creatable_process_cmdline(const char *optarg);
+void user_creatable_process_cmdline(const char *cmdline);
 
 /**
  * user_creatable_print_help:
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7d31589b04..e0833c8bfe 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -259,7 +259,7 @@ static void user_creatable_print_help_from_qdict(QDict *args)
     }
 }
 
-ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
+ObjectOptions *user_creatable_parse_str(const char *str, Error **errp)
 {
     ERRP_GUARD();
     QObject *obj;
@@ -267,14 +267,14 @@ ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
     Visitor *v;
     ObjectOptions *options;
 
-    if (optarg[0] == '{') {
-        obj = qobject_from_json(optarg, errp);
+    if (str[0] == '{') {
+        obj = qobject_from_json(str, errp);
         if (!obj) {
             return NULL;
         }
         v = qobject_input_visitor_new(obj);
     } else {
-        QDict *args = keyval_parse(optarg, "qom-type", &help, errp);
+        QDict *args = keyval_parse(str, "qom-type", &help, errp);
         if (*errp) {
             return NULL;
         }
@@ -295,12 +295,12 @@ ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
     return options;
 }
 
-bool user_creatable_add_from_str(const char *optarg, Error **errp)
+bool user_creatable_add_from_str(const char *str, Error **errp)
 {
     ERRP_GUARD();
     ObjectOptions *options;
 
-    options = user_creatable_parse_str(optarg, errp);
+    options = user_creatable_parse_str(str, errp);
     if (!options) {
         return false;
     }
@@ -310,9 +310,9 @@ bool user_creatable_add_from_str(const char *optarg, Error **errp)
     return !*errp;
 }
 
-void user_creatable_process_cmdline(const char *optarg)
+void user_creatable_process_cmdline(const char *cmdline)
 {
-    if (!user_creatable_add_from_str(optarg, &error_fatal)) {
+    if (!user_creatable_add_from_str(cmdline, &error_fatal)) {
         /* Help was printed */
         exit(EXIT_SUCCESS);
     }
-- 
2.41.0


