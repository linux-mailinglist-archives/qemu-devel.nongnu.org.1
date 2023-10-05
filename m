Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8F7B9AC4
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGL5-0006I2-1H; Thu, 05 Oct 2023 00:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKz-0006CU-PG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:49 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKv-0005cx-IZ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso519049f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481503; x=1697086303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Q3iLFdosYlx+ShI5rJfNC7P4KhR6Nf8wUwiWyt6XeA=;
 b=H+A25NBo2FF5cwFv8OKP4DsgoB7kFOUO9kiwYXkMt/rQhOnuNDXBUz8cELE20XRIT8
 EEfees+PCBeObtoQmSuyZMfOctA9gVIgtwcy70A78Dmo4RHoE13oqULD+tnkWt7KO4zC
 yQAWYHkmCdYuzYVFLUggWHn6/mfBzu0JTrYeR4YxYmArUkF0UDCeUHyLJ15wuCjFBIn8
 zsMpZeBcw7usPuU12GywVXXkKsWRudLqFwSWLYWflY2Ys00el7yh0B3nrHdFNel1fraK
 yo51bRruFlIQRFgu3a6pttPpcR3vJTTNMOJS+TMLHOzYGllQVYmc0Ub7MuxAsWFyX1br
 4PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481503; x=1697086303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Q3iLFdosYlx+ShI5rJfNC7P4KhR6Nf8wUwiWyt6XeA=;
 b=LwxB4ZFhXrrvEhd/l2xkdor120AjvHYFsIdPU5LeMz4D0S1I3e+/PCpRT6V04uXeA+
 /WCU/HJSPIoYaIEcojl+iLNwhg7MDAvD89LJ6IiLUN6Ss095IVXawWbthKevov3JpPKx
 jfL5MH6ghZvCS5GLIjCVPbM3kGZSbNdQ9ZSG1ykA+Et4NjE6fUm/uArHzxlw8ZZLZBGq
 bZ4JXAKbQWAjbhqFmaE1A4s4FV856EyfPHW3kK2ROb8M06W9tEM/fmABdzm3oQK8IeO4
 y9Do98hEtCiKt54OoOUegU6t6Tg+nHzb12J/VTxvR5ZwqfYWDenh0mqjgbuVYVuH0jCq
 e6uQ==
X-Gm-Message-State: AOJu0YwfzuC9OixKy6t9kN+fFEzn/irnnI6cLlZZQVyKn1kn1k809BZV
 Wk9+3wFKZsp/BSN3MLidvdVvNu31cvyzozVsrKU=
X-Google-Smtp-Source: AGHT+IEeYwfWq54rtWN2bHHqICvZGjSgSrcV9THb28/I5uf9Cw7BrKU9ul8HZrRvIJGgMgNiv8XVvg==
X-Received: by 2002:a5d:6942:0:b0:31d:c9a1:c538 with SMTP id
 r2-20020a5d6942000000b0031dc9a1c538mr3547086wrw.35.1696481503012; 
 Wed, 04 Oct 2023 21:51:43 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 u17-20020adfed51000000b003197efd1e7bsm734982wro.114.2023.10.04.21.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:51:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 09/22] qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE
 definition
Date: Thu,  5 Oct 2023 06:50:26 +0200
Message-ID: <20231005045041.52649-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Manual changes (escaping the format in qapi/visit.py).
Remove the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 qom/object.c              | 3 ++-
 scripts/qapi/visit.py     | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 63ab775dc5..b723830eff 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_INVALID_PARAMETER_TYPE \
-    "Invalid parameter type for '%s', expected: %s"
-
 #define QERR_INVALID_PARAMETER_VALUE \
     "Parameter '%s' expects %s"
 
diff --git a/qom/object.c b/qom/object.c
index 890fa0a106..eea61a5068 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1855,7 +1855,8 @@ static Object *object_resolve_link(Object *obj, const char *name,
     } else if (!target) {
         target = object_resolve_path(path, &ambiguous);
         if (target || ambiguous) {
-            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, target_type);
+            error_setg(errp, "Invalid parameter type for '%s', expected: %s",
+                             name, target_type);
         } else {
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..4b4a442383 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -278,8 +278,8 @@ def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
         abort();
     default:
         assert(visit_is_input(v));
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "%(name)s");
+        error_setg(errp, "Invalid parameter type for '%%s', expected: %(name)s",
+                         name ? name : "null");
         /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
         g_free(*obj);
         *obj = NULL;
-- 
2.41.0


