Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1977B9ACA
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMH-0007zu-IJ; Thu, 05 Oct 2023 00:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLd-0007c1-0c
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:30 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLN-0006cc-CG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:28 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so549912f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481531; x=1697086331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ce+npZH/Sy2YDK63SGGk3kjcbFRbVjeH5n2iFjnqdA8=;
 b=UwYDa3iMuu6rPik84qhZ03gtOzrEb6KezCgtOHSHugZde8/m6LfrVHi4J5brSq8s1+
 cRg7VSjr/+zdwGoyx5uo8SfFroQyH8LcxSt9q6ZBw4S4u2war3FSiKPQNU+/isAIUK4s
 YJmYioQYDIsi++j6A2bxkVlAzkQDKKkpqpmgTrsUaM0wio3VksN9XAaZfxmF3YphgBqd
 ANJE9vUy4+uqxj87h9NHAGM+oozkGGnsudjNQ8WgtEz4GMxECt6mW382+1r4TFwKHRsI
 htIbOgUsSDHOlLKGp3EZ3JchV5WgtSKkOwOb2yJc1ZS+oJgNv0NOQxoP2LhcgSHsCXAF
 b8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481531; x=1697086331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ce+npZH/Sy2YDK63SGGk3kjcbFRbVjeH5n2iFjnqdA8=;
 b=cpi6H3eFahWjLfVlMfvtdN5rTv/bvQePjro4dVRIEJsD2ELcyv2uz3OiefhI9zsYSd
 LLhJ3gqxBnW/afsoJYlLtUDY8bsW15a4/dGMgLE/p0fK/bXmo7Qgtumw8zD2jHVllxOI
 ZWN5U5Gf1yCBzphp1GFNr24+CGdDoVxzlD9wLxMw+yZKV/L2QPbB8KBVh9E9Y19dfQLG
 OpAiMX6BI8vq/p5+qabSwd8pS4UuERrfCxmmRxY6Uvn0b4FYVBoqHEP72BmmRCke3TTc
 ewBJfBMTM4HRdbL7ToP7WHMbOvzEYmXG4HA4K6bCVuMqptNndgi6frIGMDLGDSfjFKPW
 ZD7w==
X-Gm-Message-State: AOJu0YwFytCh0vLV15eHDZWAXfbV5JsyTjsGou9LuJfjgbF3BxRPK/QC
 uT0uAlNH0XbQj+9+8ev4M37jXBf7JDktoT2Dyj8=
X-Google-Smtp-Source: AGHT+IHQTh5No1UNhttCZVVXM4ZIYyjCICDR6Jk1TYsV0h4M56Hhnecst+JkSiB26MUXPQThQWtvXQ==
X-Received: by 2002:adf:fdc7:0:b0:31f:f982:5395 with SMTP id
 i7-20020adffdc7000000b0031ff9825395mr3820274wrs.35.1696481530920; 
 Wed, 04 Oct 2023 21:52:10 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 x10-20020a5d54ca000000b003200c918c81sm738225wrv.112.2023.10.04.21.52.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:52:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 13/22] qapi: Inline and remove QERR_INVALID_PARAMETER_VALUE
 definition
Date: Thu,  5 Oct 2023 06:50:30 +0200
Message-ID: <20231005045041.52649-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Manually modify the error_report() call in softmmu/tpm.c,
then use sed to mechanically transform the rest. Finally
remove the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 qapi/opts-visitor.c       | 4 ++--
 qapi/qapi-visit-core.c    | 4 ++--
 softmmu/tpm.c             | 3 +--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index b723830eff..ac727d1c2d 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_INVALID_PARAMETER_VALUE \
-    "Parameter '%s' expects %s"
-
 #define QERR_IO_ERROR \
     "An IO error has occurred"
 
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 0393704a73..844db583f4 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -441,7 +441,7 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
             }
         }
     }
-    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
+    error_setg(errp, "Parameter '%s' expects %s", opt->name,
                (ov->list_mode == LM_NONE) ? "an int64 value" :
                                             "an int64 value or range");
     return false;
@@ -494,7 +494,7 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
             }
         }
     }
-    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
+    error_setg(errp, "Parameter '%s' expects %s", opt->name,
                (ov->list_mode == LM_NONE) ? "a uint64 value" :
                                             "a uint64 value or range");
     return false;
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 6c13510a2b..01793d6e74 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -194,7 +194,7 @@ static bool visit_type_uintN(Visitor *v, uint64_t *obj, const char *name,
     }
     if (value > max) {
         assert(v->type == VISITOR_INPUT);
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+        error_setg(errp, "Parameter '%s' expects %s",
                    name ? name : "null", type);
         return false;
     }
@@ -262,7 +262,7 @@ static bool visit_type_intN(Visitor *v, int64_t *obj, const char *name,
     }
     if (value < min || value > max) {
         assert(v->type == VISITOR_INPUT);
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+        error_setg(errp, "Parameter '%s' expects %s",
                    name ? name : "null", type);
         return false;
     }
diff --git a/softmmu/tpm.c b/softmmu/tpm.c
index 578563f05a..8437c4efc3 100644
--- a/softmmu/tpm.c
+++ b/softmmu/tpm.c
@@ -120,8 +120,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
     be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
     if (be == NULL) {
-        error_report(QERR_INVALID_PARAMETER_VALUE,
-                     "type", "a TPM backend type");
+        error_report("Parameter 'type' expects a TPM backend type");
         tpm_display_backend_drivers();
         return 1;
     }
-- 
2.41.0


