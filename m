Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B908E7B86B5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:37:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5kD-0003g4-Hr; Wed, 04 Oct 2023 13:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kA-0003fS-88
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5k2-000145-Kb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32320381a07so124465f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440776; x=1697045576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnezdLBVjvZnCdXX1V4kutiq/Z6kzmSrGXxXnwF1wNc=;
 b=sg+KkrzBZvXNnOdTztj47iSk9z4Dgm9B+9T1GXmei67Cv3nxjpkmI073fVUQthxCOG
 q0a9UEnV03XAayvjbuGrDOQOZ4cSDwo3HU0zE74/7Ppyv27ortP0eLBj21WbCaPid5Ew
 WclSn8SX0FyZ60NPExSsFenIfykTC7PB08lGGux/rR3X4ZMcmauxV4PBg5i7HmR1U+Ec
 Yksd/qShqkdx2H6S7VFq8sU3jNhLhVcDzWauddlD/Hr/uQJ4W0nCXAtie7qj2J3r+P+5
 K5L9ntTSvusLHZlE4NNMJJgvegp8ggedUnyYsqakeWcVB1UwYBIp5oqe3iuwYpq7DACG
 RK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440776; x=1697045576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnezdLBVjvZnCdXX1V4kutiq/Z6kzmSrGXxXnwF1wNc=;
 b=CN/eBiCPfEQ8atkJvaK9rHFTQEod6F/hbkcGg9RfOEb38oTBTur3uBJcqnv9RnjWNz
 bPmjt/QhxY/MnoaLJfaCFBJ9GtomkEeNl924W/xwG8AoZlPuU3I9s/jWkkvmgifCmjCc
 FY9zmULk6w2cSKpUaZ4GEkROj7WqNbNSykNohIaCi5WDnv4uODIRv9ULCpL4Rk4PQIVn
 RSSKzpZl6fncHG7IDwQgDWKzrFsnjKtJbuu/Lv6dcsLuN+7aM9JOkOgNveWzlDuJiUgn
 ihJH5anR5dCU3VskngIliXxMfnSXcDaqMVh+7j1M84dxQB26hs8arZZMaZ79sZEafITu
 LsLg==
X-Gm-Message-State: AOJu0YzQj48HchaN5zY59/t+1ylC61Mkq+pQ3XzI31lsxW+ZtZUsFN80
 c6WW0jeiWkiZqQ+sWknhUbyIkhlBIiGA3LSPn88=
X-Google-Smtp-Source: AGHT+IELE6UxM3C0QwmfbPNDdnY4wg5bsbXWLEOQlIG4VlLZUeENYkfg07iNRRwrOOZ+lB0vGSA0xw==
X-Received: by 2002:adf:f407:0:b0:323:2d1b:eaf6 with SMTP id
 g7-20020adff407000000b003232d1beaf6mr2866207wro.67.1696440775855; 
 Wed, 04 Oct 2023 10:32:55 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 da4-20020a056000196400b003279518f51dsm4540235wrb.2.2023.10.04.10.32.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 08/21] qapi: Inline QERR_INVALID_PARAMETER_TYPE definition
 (constant value)
Date: Wed,  4 Oct 2023 19:31:43 +0200
Message-ID: <20231004173158.42591-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
    expression errp;
    expression param;
    constant value;
    @@
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);

    @script:python strformat depends on match@
    value << match.value;
    fixedfmt; // new var
    @@
    fixedfmt = f'"Invalid parameter type for \'%s\', expected: {value[1:-1]}"'
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    expression match.errp;
    expression match.param;
    constant match.value;
    identifier strformat.fixedfmt;
    @@
    -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
    +    error_setg(errp, fixedfmt, param);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/qobject-input-visitor.c | 32 ++++++++++++++++----------------
 qapi/string-input-visitor.c  |  8 ++++----
 qom/object.c                 | 12 ++++++++----
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3e8aca6b15..f110a804b2 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -288,8 +288,8 @@ static bool qobject_input_start_struct(Visitor *v, const char *name, void **obj,
         return false;
     }
     if (qobject_type(qobj) != QTYPE_QDICT) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "object");
+        error_setg(errp, "Invalid parameter type for '%s', expected: object",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -326,8 +326,8 @@ static bool qobject_input_start_list(Visitor *v, const char *name,
         return false;
     }
     if (qobject_type(qobj) != QTYPE_QLIST) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "array");
+        error_setg(errp, "Invalid parameter type for '%s', expected: array",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -405,8 +405,8 @@ static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum || !qnum_get_try_int(qnum, obj)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "integer");
+        error_setg(errp, "Invalid parameter type for '%s', expected: integer",
+                   full_name(qiv, name));
         return false;
     }
     return true;
@@ -494,8 +494,8 @@ static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     }
     qbool = qobject_to(QBool, qobj);
     if (!qbool) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "boolean");
+        error_setg(errp, "Invalid parameter type for '%s', expected: boolean",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -534,8 +534,8 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
     }
     qstr = qobject_to(QString, qobj);
     if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+        error_setg(errp, "Invalid parameter type for '%s', expected: string",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -565,8 +565,8 @@ static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "number");
+        error_setg(errp, "Invalid parameter type for '%s', expected: number",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -587,8 +587,8 @@ static bool qobject_input_type_number_keyval(Visitor *v, const char *name,
 
     if (qemu_strtod_finite(str, NULL, &val)) {
         /* TODO report -ERANGE more nicely */
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "number");
+        error_setg(errp, "Invalid parameter type for '%s', expected: number",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -623,8 +623,8 @@ static bool qobject_input_type_null(Visitor *v, const char *name,
     }
 
     if (qobject_type(qobj) != QTYPE_QNULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "null");
+        error_setg(errp, "Invalid parameter type for '%s', expected: null",
+                   full_name(qiv, name));
         return false;
     }
     *obj = qnull();
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 197139c1c0..3f1b9e9b41 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -353,8 +353,8 @@ static bool parse_type_number(Visitor *v, const char *name, double *obj,
 
     assert(siv->lm == LM_NONE);
     if (qemu_strtod_finite(siv->string, NULL, &val)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "number");
+        error_setg(errp, "Invalid parameter type for '%s', expected: number",
+                   name ? name : "null");
         return false;
     }
 
@@ -371,8 +371,8 @@ static bool parse_type_null(Visitor *v, const char *name, QNull **obj,
     *obj = NULL;
 
     if (siv->string[0]) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "null");
+        error_setg(errp, "Invalid parameter type for '%s', expected: null",
+                   name ? name : "null");
         return false;
     }
 
diff --git a/qom/object.c b/qom/object.c
index e25f1e96db..890fa0a106 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1443,7 +1443,8 @@ char *object_property_get_str(Object *obj, const char *name,
     }
     qstring = qobject_to(QString, ret);
     if (!qstring) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "string");
+        error_setg(errp, "Invalid parameter type for '%s', expected: string",
+                   name);
         retval = NULL;
     } else {
         retval = g_strdup(qstring_get_str(qstring));
@@ -1504,7 +1505,8 @@ bool object_property_get_bool(Object *obj, const char *name,
     }
     qbool = qobject_to(QBool, ret);
     if (!qbool) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "boolean");
+        error_setg(errp, "Invalid parameter type for '%s', expected: boolean",
+                   name);
         retval = false;
     } else {
         retval = qbool_get_bool(qbool);
@@ -1537,7 +1539,8 @@ int64_t object_property_get_int(Object *obj, const char *name,
 
     qnum = qobject_to(QNum, ret);
     if (!qnum || !qnum_get_try_int(qnum, &retval)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "int");
+        error_setg(errp, "Invalid parameter type for '%s', expected: int",
+                   name);
         retval = -1;
     }
 
@@ -1606,7 +1609,8 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
     }
     qnum = qobject_to(QNum, ret);
     if (!qnum || !qnum_get_try_uint(qnum, &retval)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "uint");
+        error_setg(errp, "Invalid parameter type for '%s', expected: uint",
+                   name);
         retval = 0;
     }
 
-- 
2.41.0


