Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E2D7B9AC8
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMP-0000is-LJ; Thu, 05 Oct 2023 00:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLx-00080J-JF
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLq-0007Np-Lc
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405497850dbso5030755e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481557; x=1697086357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMzoYshmIKgiyI46JZRTSl2tAoK4bhnefguZfodjbZQ=;
 b=VbBLU7FeVN2pcvXqgOlP3zxhcTirOKZVho47eQzeIhhhlUZGhUYMAnborGH/plFbwK
 YSDwOVv5SGHtGCJO7rQjowyEHb7HPC3gJ21qyIZBZWYfyEZjIa2YfAkD5GKOoF60su9c
 nCjWbUduUSgPHufAU6fIvYjPcQjKqhupMmnUvg665bL0heNP4sr6f4beNbJvbjfs6tFa
 MPd4QYOMaXaxqziDJOP9MRjyrBIQeRXnmHsP9g6oB9phWrGxNTBv0urRm0hyfLn3x2Nk
 rFuBAJ4nZq+P6jJEOrvlrMNUvVRaKvy3h+uKpB3ceRUu9jHdUXnyDp78vWS0ACED1qqV
 G0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481557; x=1697086357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMzoYshmIKgiyI46JZRTSl2tAoK4bhnefguZfodjbZQ=;
 b=rGaP1KFjkMP9lslfHL13uWsNnhYiirx18NHDoPGwVJk84VVfN+iulXVVlsdVTTPE1Y
 uvEJXgmgg+w/I07Exf3oxk8uC5i9mEP2K5Ua0w64MwaXL4D/6ZdGcjOfHjVEm5A2Ug0a
 0TfWu7bnb2TWtQYcnpSQmW6HdAs40ajZDSbNGHT01ZblV6JOE1nsD9JIaK/lZ+almKjw
 omu4PTdDeBupkSExpGgDcsTK4l7FO2qodRIDXydzA4GiNgOV9qWHtdoac+x5YNadNEqb
 jYE0ty+7J8G9Ks6xcC8QrwG58AyjB5sWtRb89MUHW8REvEqIBgiKUdfR0Ehtvb2XqCap
 clTg==
X-Gm-Message-State: AOJu0YyWFldrAW5XFSiw9ssH4V0MiDfOqn7uy6xZdV5rSaqaA/bb7XQy
 2mhIFZIzMgoh9KCmO3DwwM/iues4KfmDTaov7zg=
X-Google-Smtp-Source: AGHT+IGR/aTdIGThtGDWK1tgDKdnlHea/FPcRUy9IwOCqdifoFXpPEjvwz7UyemSc6YGuCVoo4R1WQ==
X-Received: by 2002:a05:600c:ad0:b0:405:375d:b860 with SMTP id
 c16-20020a05600c0ad000b00405375db860mr4082300wmr.21.1696481557727; 
 Wed, 04 Oct 2023 21:52:37 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 y6-20020a1c4b06000000b00405588aa40asm617496wma.24.2023.10.04.21.52.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 17/22] qapi: Inline and remove QERR_MISSING_PARAMETER
 definition
Date: Thu,  5 Oct 2023 06:50:34 +0200
Message-ID: <20231005045041.52649-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Mechanical transformation using sed, manually
removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h    | 3 ---
 qapi/opts-visitor.c          | 2 +-
 qapi/qapi-forward-visitor.c  | 2 +-
 qapi/qobject-input-visitor.c | 2 +-
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index cc4dae1076..b0f48f22fe 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_MISSING_PARAMETER \
-    "Parameter '%s' is missing"
-
 #define QERR_PROPERTY_VALUE_BAD \
     "Property '%s.%s' doesn't take value '%s'"
 
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 844db583f4..bf0d8acbd6 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -218,7 +218,7 @@ lookup_distinct(const OptsVisitor *ov, const char *name, Error **errp)
 
     list = g_hash_table_lookup(ov->unprocessed_opts, name);
     if (!list) {
-        error_setg(errp, QERR_MISSING_PARAMETER, name);
+        error_setg(errp, "Parameter '%s' is missing", name);
     }
     return list;
 }
diff --git a/qapi/qapi-forward-visitor.c b/qapi/qapi-forward-visitor.c
index e36d9bc9ba..3fb2c954aa 100644
--- a/qapi/qapi-forward-visitor.c
+++ b/qapi/qapi-forward-visitor.c
@@ -49,7 +49,7 @@ static bool forward_field_translate_name(ForwardFieldVisitor *v, const char **na
         *name = v->to;
         return true;
     }
-    error_setg(errp, QERR_MISSING_PARAMETER, *name);
+    error_setg(errp, "Parameter '%s' is missing", *name);
     return false;
 }
 
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f5fa6c1878..17e9f3b638 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -168,7 +168,7 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
     QObject *obj = qobject_input_try_get_object(qiv, name, consume);
 
     if (!obj) {
-        error_setg(errp, QERR_MISSING_PARAMETER, full_name(qiv, name));
+        error_setg(errp, "Parameter '%s' is missing", full_name(qiv, name));
     }
     return obj;
 }
-- 
2.41.0


