Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F867B9ABD
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:52:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGKv-00067K-Jz; Thu, 05 Oct 2023 00:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKs-00066U-2s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGKb-0005Zt-5N
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:51:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40651a726acso4850815e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481483; x=1697086283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQJAMU/w6o8m8TBpb8PzaVjQ4Gp1ZRSyPEWXTvxRp/M=;
 b=gCE//ublxXWKxHmL7oM6TpQw4h7XLRzAqKeCyu+Y2CJZwe7kfCIKnZ51S10lhg9s3+
 /cnC6SNbEnU5hhcsy0d1bmEWZssgJZvMm/OInpuIPOa+xhJjjt2yhRmHeY/3YUXxfbTf
 yR1TQ6DRlE1ebFirlPj39jSvmE4FtPtDn4Ewh/8wmPcIIBrpgRmGPCttkZfViBDL5sYr
 J0HeljewFvHygE68Tm1MmmsGkFLTcoeXOadXOKDuFTyZrr5Jj0f/d9Wz5ZwBmdVibV5i
 wbjS08sWijIG61FhP035mAk0ewGWpkcN1cJxsdqVX3GodHxX9tcNs0de/HJqxZtQiqMI
 gIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481483; x=1697086283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQJAMU/w6o8m8TBpb8PzaVjQ4Gp1ZRSyPEWXTvxRp/M=;
 b=ms6x82ETAP/yB/+3HJY3MvNI6fCtVVgR9c34Kx8+04xlnQVnOugHu//753hik44RyQ
 0UVfOjRqceolHI+2UcfHaynUVIjXRcj41C0yWOs0URUmhvuGJySolOTgL8HTBq1VJKr+
 ppG1r2VygoZWruWD/pBLIiSQGkdUx8dEdFhCLdSfqfguVWFDS+o9tM6yBvq7YM8fk9+Q
 2ZwP9sAYtGpHOeQlgOWMp9NrEZeGGNbb+GX3S9yWD+FtDmn5fTmWXTDCNPpE7ZTZQbAz
 XU7NUxQ2bDQEGzubn48hYCT76zi/X0/R6FEhF64Jh3cssbkme2edr5Ixg2J9Webom2CJ
 AkgQ==
X-Gm-Message-State: AOJu0YweAT3Z0fCP9uPFZDGe6AqYdHv6mW0/BLOYTzVVQVa5WGzsGcEl
 PjA1axcTOt1SqMRKPo/CB5LwELmdkY0q/xrsx7Y=
X-Google-Smtp-Source: AGHT+IEeF41HA09h+ZYwQntMbGp3lSSvFL7a3fkEGJfVxM+mrtIus80uXIJQU3yQvwJpSEd+EqUnuQ==
X-Received: by 2002:adf:de11:0:b0:31f:f753:9938 with SMTP id
 b17-20020adfde11000000b0031ff7539938mr3660400wrm.58.1696481483506; 
 Wed, 04 Oct 2023 21:51:23 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b0031ff89af0e4sm739425wrt.99.2023.10.04.21.51.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 06/22] qapi: Inline and remove QERR_INVALID_PARAMETER
 definition
Date: Thu,  5 Oct 2023 06:50:23 +0200
Message-ID: <20231005045041.52649-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Mechanical transformation using:

  $ sed -i -e "s/QERR_INVALID_PARAMETER,/\"Invalid parameter '%s'\",/" \
    $(git grep -lw QERR_INVALID_PARAMETER)

then manually removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 monitor/hmp-cmds.c        | 2 +-
 qapi/opts-visitor.c       | 2 +-
 util/qemu-option.c        | 8 ++++----
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index e93211085a..63ab775dc5 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_INVALID_PARAMETER \
-    "Invalid parameter '%s'"
-
 #define QERR_INVALID_PARAMETER_TYPE \
     "Invalid parameter type for '%s', expected: %s"
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 6c559b48c8..9d6533643d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -138,7 +138,7 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdict)
     } else {
         Error *err = NULL;
 
-        error_setg(&err, QERR_INVALID_PARAMETER, op);
+        error_setg(&err, "Invalid parameter '%s'", op);
         hmp_handle_error(mon, err);
     }
 }
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 8f1efab8b9..3d1a28b419 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -184,7 +184,7 @@ opts_check_struct(Visitor *v, Error **errp)
         const QemuOpt *first;
 
         first = g_queue_peek_head(any);
-        error_setg(errp, QERR_INVALID_PARAMETER, first->name);
+        error_setg(errp, "Invalid parameter '%s'", first->name);
         return false;
     }
     return true;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index fb391a7904..201f7a87f3 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -498,7 +498,7 @@ static bool opt_validate(QemuOpt *opt, Error **errp)
 
     desc = find_desc_by_name(list->desc, opt->name);
     if (!desc && !opts_accepts_any(list)) {
-        error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
+        error_setg(errp, "Invalid parameter '%s'", opt->name);
         return false;
     }
 
@@ -531,7 +531,7 @@ bool qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
 
     desc = find_desc_by_name(list->desc, name);
     if (!desc && !opts_accepts_any(list)) {
-        error_setg(errp, QERR_INVALID_PARAMETER, name);
+        error_setg(errp, "Invalid parameter '%s'", name);
         return false;
     }
 
@@ -554,7 +554,7 @@ bool qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
 
     desc = find_desc_by_name(list->desc, name);
     if (!desc && !opts_accepts_any(list)) {
-        error_setg(errp, QERR_INVALID_PARAMETER, name);
+        error_setg(errp, "Invalid parameter '%s'", name);
         return false;
     }
 
@@ -1103,7 +1103,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
     QTAILQ_FOREACH(opt, &opts->head, next) {
         opt->desc = find_desc_by_name(desc, opt->name);
         if (!opt->desc) {
-            error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
+            error_setg(errp, "Invalid parameter '%s'", opt->name);
             return false;
         }
 
-- 
2.41.0


