Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D507B86AD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5ks-0004ho-Vb; Wed, 04 Oct 2023 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kV-0004Gb-Ag
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kO-0001AA-1b
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so369075e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440798; x=1697045598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PTJ/05sHPgcAUDGq2+BZ4afKq7cNyAKTrzR+aRyMME=;
 b=mvWjUJzcNPREtn226QaWJvZXizjmZYwgSqQ/TNs0fK6w8ixutMvMn1cFg3B92cK22K
 0iLPYwrlEK5YlmPUcARlYGfGj1aVfOg6rU5TiUYkYMUw9gBb3/ncZzaf1F5QmU0ciZVn
 G/v9t/FHf14wIHqbvDHYU8VpaSqFEAFt0nKxn/8plgQelJGD2johb7PJJTMavfDM2qR0
 PAM+0Vftfjv9KRjSXr4oIRZEnS2Hy4vkiggD2TE/0HRkewUAV6pETKYgY5zCyzTvZCb5
 /ZugiuUNkwz1WN+LU23cu9Gc5eSJ0FiN36WHk7Z8/gzoOXEYlpammn4vM1SzXg7n9hhM
 T38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440798; x=1697045598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PTJ/05sHPgcAUDGq2+BZ4afKq7cNyAKTrzR+aRyMME=;
 b=F4aJkKKPAiCm1+iDXk4+Om1ykW0GDhl4xKIXDiqZQdg6Fhyj/ws8CNlw/cEfMgTWS7
 jbevPFiSejB8YQw9fPy+woao1yBzU34OzINNjOv18nSnQHaMSBOxUifoMgkexw6gbw4a
 LBHRCnmMahth+J0V1sio26RpE0yC+y/y5F/SE2rawRJGgalFHxPvPaqdGg6tR2NHqg/b
 /cyet61jNLzBKOlbmv/bipowxFhIc+hdKKATeTe9YPX/AG8dtxhEUpBTt+WTeRgFHxbT
 pzlem801yZS6Hrnt1a8e5hvaIrFZBVR2G9qgnFoXkJCFpXzHq631PyXic5xbiBbmNz4q
 dR4g==
X-Gm-Message-State: AOJu0YzzOc2aY71FusOgKI7eFh/5h7zPMl4YE+e1gIA05bQ210E/go/k
 yG4MWHktpsQyBur2wBNw38m9CbmO6giO8v4TNJQ=
X-Google-Smtp-Source: AGHT+IE/j2If/Gbt/uu6G49MkbYtXRXJLnIk2q+N2YvjSnfYB1EQJdeMTX3lxGs4d/rNGGoaqB6pVQ==
X-Received: by 2002:a1c:6a0d:0:b0:3fc:1a6:7764 with SMTP id
 f13-20020a1c6a0d000000b003fc01a67764mr2834064wmc.16.1696440798375; 
 Wed, 04 Oct 2023 10:33:18 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1c6a14000000b00405959bbf4fsm2000368wmc.19.2023.10.04.10.33.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 11/21] qapi: Inline QERR_INVALID_PARAMETER_VALUE definition
 (constant param)
Date: Wed,  4 Oct 2023 19:31:46 +0200
Message-ID: <20231004173158.42591-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using the following
coccinelle semantic patch:

    @match@
    identifier errp;
    expression param; // not constant
    constant value;
    @@
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);

    @script:python strformat depends on match@
    param << match.param;
    value << match.value;
    fixedfmt; // new var
    @@
    fixedfmt = f"\"Parameter '%s' expects {value[1:-1]}\""
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    identifier match.errp;
    expression match.param;
    constant match.value;
    identifier strformat.fixedfmt;
    @@
    -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
    +    error_setg(errp, fixedfmt, param);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-properties-system.c |  5 +++--
 qapi/opts-visitor.c              |  3 +--
 qapi/qapi-util.c                 |  3 +--
 qapi/qobject-input-visitor.c     | 18 ++++++++----------
 qapi/string-input-visitor.c      | 18 ++++++++++--------
 util/qemu-option.c               |  7 ++++---
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 688340610e..7752c5fda5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -769,8 +769,9 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
             return;
         }
         if (value < -1 || value > 255) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                       name ? name : "null", "a value between -1 and 255");
+            error_setg(errp,
+                       "Parameter '%s' expects a value between -1 and 255",
+                       name ? name : "null");
             return;
         }
         *ptr = value;
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 3d1a28b419..0393704a73 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -515,8 +515,7 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
 
     err = qemu_strtosz(opt->str ? opt->str : "", NULL, obj);
     if (err < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
-                   "a size value");
+        error_setg(errp, "Parameter '%s' expects a size value", opt->name);
         return false;
     }
 
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 63596e11c5..82c3425566 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -101,8 +101,7 @@ bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **err
         return true;
     }
 
-    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
-               "'on' or 'off'");
+    error_setg(errp, "Parameter '%s' expects 'on' or 'off'", name);
     return false;
 }
 
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f110a804b2..f5fa6c1878 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -424,8 +424,8 @@ static bool qobject_input_type_int64_keyval(Visitor *v, const char *name,
 
     if (qemu_strtoi64(str, NULL, 0, obj) < 0) {
         /* TODO report -ERANGE more nicely */
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   full_name(qiv, name), "integer");
+        error_setg(errp, "Parameter '%s' expects integer",
+                   full_name(qiv, name));
         return false;
     }
     return true;
@@ -458,8 +458,7 @@ static bool qobject_input_type_uint64(Visitor *v, const char *name,
     }
 
 err:
-    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-               full_name(qiv, name), "uint64");
+    error_setg(errp, "Parameter '%s' expects uint64", full_name(qiv, name));
     return false;
 }
 
@@ -475,8 +474,8 @@ static bool qobject_input_type_uint64_keyval(Visitor *v, const char *name,
 
     if (qemu_strtou64(str, NULL, 0, obj) < 0) {
         /* TODO report -ERANGE more nicely */
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   full_name(qiv, name), "integer");
+        error_setg(errp, "Parameter '%s' expects integer",
+                   full_name(qiv, name));
         return false;
     }
     return true;
@@ -514,8 +513,8 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
     }
 
     if (!qapi_bool_parse(name, str, obj, NULL)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   full_name(qiv, name), "'on' or 'off'");
+        error_setg(errp, "Parameter '%s' expects 'on' or 'off'",
+                   full_name(qiv, name));
         return false;
     }
     return true;
@@ -643,8 +642,7 @@ static bool qobject_input_type_size_keyval(Visitor *v, const char *name,
 
     if (qemu_strtosz(str, NULL, obj) < 0) {
         /* TODO report -ERANGE more nicely */
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   full_name(qiv, name), "size");
+        error_setg(errp, "Parameter '%s' expects size", full_name(qiv, name));
         return false;
     }
     return true;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 3f1b9e9b41..6ea6a0c676 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -189,16 +189,17 @@ static bool parse_type_int64(Visitor *v, const char *name, int64_t *obj,
     case LM_NONE:
         /* just parse a simple int64, bail out if not completely consumed */
         if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                       name ? name : "null", "int64");
+            error_setg(errp, "Parameter '%s' expects int64",
+                       name ? name : "null");
             return false;
         }
         *obj = val;
         return true;
     case LM_UNPARSED:
         if (try_parse_int64_list_entry(siv, obj)) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
-                       "list of int64 values or ranges");
+            error_setg(errp,
+                       "Parameter '%s' expects list of int64 values or ranges",
+                       name ? name : "null");
             return false;
         }
         assert(siv->lm == LM_INT64_RANGE);
@@ -279,16 +280,17 @@ static bool parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
     case LM_NONE:
         /* just parse a simple uint64, bail out if not completely consumed */
         if (qemu_strtou64(siv->string, NULL, 0, &val)) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
-                       "uint64");
+            error_setg(errp, "Parameter '%s' expects uint64",
+                       name ? name : "null");
             return false;
         }
         *obj = val;
         return true;
     case LM_UNPARSED:
         if (try_parse_uint64_list_entry(siv, obj)) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
-                       "list of uint64 values or ranges");
+            error_setg(errp,
+                       "Parameter '%s' expects list of uint64 values or ranges",
+                       name ? name : "null");
             return false;
         }
         assert(siv->lm == LM_UINT64_RANGE);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 62dd80a5ae..9440224e5b 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -101,7 +101,7 @@ static bool parse_option_number(const char *name, const char *value,
         return false;
     }
     if (err) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a number");
+        error_setg(errp, "Parameter '%s' expects a number", name);
         return false;
     }
     *ret = number;
@@ -142,8 +142,9 @@ bool parse_option_size(const char *name, const char *value,
         return false;
     }
     if (err) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
-                   "a non-negative number below 2^64");
+        error_setg(errp,
+                   "Parameter '%s' expects a non-negative number below 2^64",
+                   name);
         error_append_hint(errp, "Optional suffix k, M, G, T, P or E means"
                           " kilo-, mega-, giga-, tera-, peta-\n"
                           "and exabytes, respectively.\n");
-- 
2.41.0


