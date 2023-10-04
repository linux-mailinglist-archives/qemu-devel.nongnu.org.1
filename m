Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FED17B86C3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5lA-0005Fh-5X; Wed, 04 Oct 2023 13:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kw-00053c-UD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kv-0001Gp-3s
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so94724f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440831; x=1697045631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMzoYshmIKgiyI46JZRTSl2tAoK4bhnefguZfodjbZQ=;
 b=SPzsInjlowfDayG/a8nkQuspKf6w14l0qIKS7blCzN1gGAXtU23Sh/2et7Cn3Bt1fr
 4c9bj5uXVYIN4xG3UbSN0+YTznXSoCfCEX6sGDDHGgHXKnv6k2CcObZNEnlY05u7iB0x
 pj4j45Bt/BltLAKsJ885Pix+3M4e5/jLFmhT+uvfzz2+SXpTThENqGNp0inKPZqstl7p
 QiV+airD+6AT2xZVusRhG0//rG4+YMbbkmOfuwf7oKAGG04Ju7cxQ6cFRlCDHmYCbu6a
 X64u897h+LiJr8ywe3yOwB/2Zj6egGo+67Y2+H5l1AoFDHzXssft/jZTGxkjYp0vJ79I
 z/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440831; x=1697045631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMzoYshmIKgiyI46JZRTSl2tAoK4bhnefguZfodjbZQ=;
 b=I6BVTk2fSATZnn0eNxi9gVjRcHTJuVXLHTaNxSih2Oyif/5pv13hC9SbCOZ1e/BUhg
 s+qeGss+rCmjbEs/gCE93tPvQu8otrsap4vPjS/cKJDD/4yLt2j6/6yk/jR+EJJ5hfS2
 4AUq56gmHTfeB68yQnkK2Kf/B6sYFZIQsRBTOaZq7OlvYCKLtcFB33g1EG6a28tErf1S
 ffBcUns8NUij4uU9zOIxRe715XYBsQvwn5o/Rh3yUBDdmOHcfiuhYAxtgyCPTVxGpDq5
 IbRUkpGjfAu4Jk8cNybVOvc54l8yXA5c3Q/S73VadsrFznBVx00FWr+sklupt/9FSxYr
 1ueg==
X-Gm-Message-State: AOJu0YzHjlGf9UhsRzfCHUsGSIJagMZNftY2G9LLsfqlOhygJ0RzjlAE
 2SrR99dG4wI2B2erRulM7Ueu8IzztygkU3ZO10I=
X-Google-Smtp-Source: AGHT+IFJJpzTqkzOF039EX+CWtVdV0BjqrGr/qWew7l0FrUMdg2ttar1aWp6F3Fwm7b2+vLI2m8qiQ==
X-Received: by 2002:adf:ecc3:0:b0:319:7c0f:d920 with SMTP id
 s3-20020adfecc3000000b003197c0fd920mr2875094wro.57.1696440831513; 
 Wed, 04 Oct 2023 10:33:51 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 v22-20020a1cf716000000b003fefcbe7fa8sm2013488wmh.28.2023.10.04.10.33.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 16/21] qapi: Inline and remove QERR_MISSING_PARAMETER
 definition
Date: Wed,  4 Oct 2023 19:31:51 +0200
Message-ID: <20231004173158.42591-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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


