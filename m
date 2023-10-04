Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B517B86B9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5jz-0003X7-4a; Wed, 04 Oct 2023 13:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jw-0003U0-H6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jo-000111-GN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so613955e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440762; x=1697045562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQJAMU/w6o8m8TBpb8PzaVjQ4Gp1ZRSyPEWXTvxRp/M=;
 b=muLON2sbIUWVkzf7VUfniYMuJUy0UMiFICdEz//KXTbV3lOu/r3v+7kE/cjrdS1yRj
 MdIA/VZFjBuBOrKC5X2XRXrcXUvslOoJofGP/T4uYnpgcNlj3No42wr3Tx8YLXdzldQR
 ICtNBaCT6xTd8Ba4fBhEqakVPF3cet63VHloGN5PyJcXybW9x0GsoE+QmCqdUu5J2/1G
 kujKRErykpENDrZB7nrl0DNBU3AecvAPqC+bzg1w9ySofgEwuSx7QWTI0pjjZDd4y7m+
 1M6oJKW+l3QWPrXmwN5tcly374TroU45q6L4rGVNjw5T96EIpJk3+g5KSW6vaAaJrtKr
 DrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440762; x=1697045562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQJAMU/w6o8m8TBpb8PzaVjQ4Gp1ZRSyPEWXTvxRp/M=;
 b=Gd2rTPM0jhB4qFDiPMlxs+loo/nn3ukVVM8qjDqlIBO+7XLRbCV1aVlbYYhF0ZgUbS
 PS4ZicIQY1nO1/BSTX/vk4sAiHzWOYuF7D7u8krLoOThEkLRqcSKIy+g/W44Ti/9iQCK
 Y4VqaqM9J+iHR09Rj7kwShyGb8PkZCLXTdMvJ+FlVXR9QK/lzc9ylJK08jIU5/RxkDsJ
 LoKp1IaKlYP5mVt7nMa0rjYlo1bkCNtmhBu6Nwvkel0TD2WNjVtVpNJtwlVuJ1uZNHrO
 kyLY4KsxNMgEe7moJeGJFw+iKCcwb87WDHxTCiIG8a+6rddieUST0ApusxAutzi+iWd/
 02Cg==
X-Gm-Message-State: AOJu0YwJyOi2pZElC73886akujy/cv23nrX9bLTH9JNYhshZ/z8BIGES
 ukzO6SGIx/Ybts6LToYEcjN26KO0yByVUHeWl+E=
X-Google-Smtp-Source: AGHT+IGB9Z3liXGVxuWXqi7aWSNYTUCxZ/+mkliOlY8YbjDRfu7KYDpgo8lcmRBSh353ymlNKmVyDg==
X-Received: by 2002:a05:600c:c9:b0:406:3fda:962c with SMTP id
 u9-20020a05600c00c900b004063fda962cmr2753663wmm.31.1696440762533; 
 Wed, 04 Oct 2023 10:32:42 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 s21-20020a7bc395000000b004064cd71aa8sm2001402wmj.34.2023.10.04.10.32.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 06/21] qapi: Inline and remove QERR_INVALID_PARAMETER
 definition
Date: Wed,  4 Oct 2023 19:31:41 +0200
Message-ID: <20231004173158.42591-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


