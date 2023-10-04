Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE387B86AB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5kP-0003tr-Mp; Wed, 04 Oct 2023 13:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kM-0003p5-Kr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5k9-00015u-3A
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406650da82bso350285e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440782; x=1697045582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Q3iLFdosYlx+ShI5rJfNC7P4KhR6Nf8wUwiWyt6XeA=;
 b=mrkIyXsd96vun4GqJrNv+VAFXfyTkJQXWTMWmlMYS8IXp26iwyqCA8qMQkqPLKI8+7
 YWe2QH2TUowUsDtBaXIK5ZQ0kyRsU69E7WwToDf4jSia/0Bakii026UIWreLplhk/Smw
 gKCRT8/nluL+C85bOqvO+1kPIaVRBdbDHIknCa8fDqLpbYBURw65aaY0PkiWGu/PA2vE
 dTN3ZqSF7scxpnoPnUwMRky67qz7vxYNKBqNjk4UbnOBB/k1pTFcMVmxMqfoxh/ib8to
 Aear/9zYCHdBT/XCyIVnIcf2P77GhJEQUe2YTQjllIErO0owXGzr602OHPObpRan73uo
 NUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440782; x=1697045582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Q3iLFdosYlx+ShI5rJfNC7P4KhR6Nf8wUwiWyt6XeA=;
 b=ObCUYEVjBsdynwis+KS6yn6K686tAvakv6hA07jY5zUSdDwGVUcjZrVu2x+NS+RZJm
 4FEvSv2FvN122ZHi4D2HsM6YWfXZLi9Yh/On/zmdOxrHBS5R1O48nbsQBVePcL1WCUSr
 gWbGR8/dCpPy3LlVk7fQ/cD9cmgUaLc39Eu69etfsyk9UgezCx7Rzrt+BWqiTxoHC2R2
 0A5ONNpM6mbjW/A1DQL6qCPtMQhbXlmEoMjQ/fMNq8GYQoXp1Ke3TnLDSOMINaG2AXfV
 o+IOEXbpUR6s8AI0J4AJl/sJpD4ELcmM0E6x3NNBTNV6LfLvYHxqqMjqCaTCu9RKF2uP
 RgMA==
X-Gm-Message-State: AOJu0YzW1zpT63sz9vLIs7GZ2SdBm2QJ4wov6J/shHW6d6LxlEZ9y4h6
 Z5QWm9S9ol4Sd2c7wVf4drYfle3S4jGUawepvyA=
X-Google-Smtp-Source: AGHT+IGvZDNwGACwFiZQ/XjfJF+hOV32cWd+gJhvaNKHCq3cykMs47gMHslp071MMtVKDqnVN7u7LQ==
X-Received: by 2002:adf:fec4:0:b0:31f:f9fb:d5bd with SMTP id
 q4-20020adffec4000000b0031ff9fbd5bdmr3006135wrs.68.1696440782655; 
 Wed, 04 Oct 2023 10:33:02 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b00406447b798bsm2019756wmj.37.2023.10.04.10.33.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 09/21] qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE
 definition
Date: Wed,  4 Oct 2023 19:31:44 +0200
Message-ID: <20231004173158.42591-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


