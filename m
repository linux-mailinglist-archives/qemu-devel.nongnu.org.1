Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E20787B86D3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5kr-0004R8-4d; Wed, 04 Oct 2023 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kW-0004IV-Fr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kU-0001B0-K8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso132062f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440805; x=1697045605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gyoso152fQUVv2VI4kNr2GZSI6iVV+4Nv9SPfhHf5XM=;
 b=oh5ch8a7v5j/mOBTUG5Z2BqImBb05AUpabdOLbcdLXthe9WjEV6CWqTeFPtKtIocza
 l3H9DXK1EO+YnEpC5jsPyrDL8+VZwYXEN/cnoj8l9iqnm8SxWUgmvKxVgKpAFf4TriTN
 z9EVbjQbY8/N+cfT9oobFoccLUqIORwDS+VOxX7MH6WctL/K13Vq8aX69EwQ4Di/975+
 unoOGh/DkJ1oI71ek3Kvm4emxBf3qN4P5tdTUnVlCRUitD7aX6YOJAGSTiWJytnEM+M6
 xDAgDOiF0uE0gTE++oIEkd9ajzM/tIC+if0bWRlz0Xf/jbfJMMoa8a/um44z6IjhSK2+
 Et3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440805; x=1697045605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyoso152fQUVv2VI4kNr2GZSI6iVV+4Nv9SPfhHf5XM=;
 b=rAp/e8L+3U7an+kL9CJyC312vTNlybYH2NaZrX+2kYUFSrnOg7+jjJSO/xIwSycgcg
 uNATd2OV35ZODGU1LaK0NcrZafnAfxm8pEvrMmqIxomVOv2TbES+JDAK1GttOfMycW16
 vqxkl3BTsE+QbNMyEkCxlfcALNJlPZt1tq/SZN3UMOrIrGcK2QANDnzdcHv7w9vA9s5Y
 28NpdnKdEokFzFZUjQfVvUCV/De2G8EW41xvdjLYIEMAfsDarqUNtXqfgGZsVnnCxGsQ
 ELzEUI7bomP8dX1bkwLqEYWer1mkfELXHX8sqBTosAG/5VIZl9WKHwHedyS6cKY/Orqj
 YPfA==
X-Gm-Message-State: AOJu0Yxxv5xXc/EM16zqN/xqdlC5r+g8DBm1XTjeMElvI+6QP/CnVfTo
 bkOKkzPg9r6EZVeqjF3LcRyJwK+kT71BSUy+GBs=
X-Google-Smtp-Source: AGHT+IH8SEZLt9lDipXSDPk3Fp901Wl5QO2HAst6ms5kqEDZbhv8mbn5cHDvW3XDldfFAh8fBEGzSg==
X-Received: by 2002:a5d:444b:0:b0:319:52da:8f0b with SMTP id
 x11-20020a5d444b000000b0031952da8f0bmr2690457wrr.17.1696440804870; 
 Wed, 04 Oct 2023 10:33:24 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 da4-20020a056000196400b003279518f51dsm4541053wrb.2.2023.10.04.10.33.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 12/21] qapi: Inline and remove QERR_INVALID_PARAMETER_VALUE
 definition
Date: Wed,  4 Oct 2023 19:31:47 +0200
Message-ID: <20231004173158.42591-13-philmd@linaro.org>
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

Manually modify the error_report() call in softmmu/tpm.c,
then use sed to mechanically transform the rest. Finally
remove the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


