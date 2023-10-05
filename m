Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A277B9AD4
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMI-00084W-9Z; Thu, 05 Oct 2023 00:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLe-0007c7-C2
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLb-0006yd-Qr
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40535597f01so4758955e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481544; x=1697086344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljhUm+yE397bxq9Bx01IEVCivdgyT/wBeqgB6zr/g7E=;
 b=rcg8gl8InsyBBBLqIOzePgEKP9Klwr5MMruySHdERPvfGOAVPgeIUIIik7jf3pm/ye
 hwk4jxqS31jEEUAsu33jjCQlMnhdMeBp1+IWOJOtY6HqvoCUyJAeIO+tB1sI1bQwEDQ1
 hYsr3iTprbWwIaq20F9TWJBY/tNeUT5UZlDAKp7yNSZsKFvWDyDxz0kIPNLqqSOR/PDh
 PLqmJKpqqhl49nCWwVu2dEDEp42NnybN+XyBX03hyy7Yyz05+iTPNKuyTuxcQ9I8mp8S
 HBxZhBfoz78lhxKSm3+GyYCoZw+cV7Gc9Xn9ROIqUN4kpyIVT5nqAjpQUEWbLDFwRZRQ
 ZEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481544; x=1697086344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljhUm+yE397bxq9Bx01IEVCivdgyT/wBeqgB6zr/g7E=;
 b=DJ2v/45yRzxR0usJBqvOm4La30z47/bMD4lnvOlX15dK9A5Juw7KNozp9T+LXxBT0i
 T9DV1Bb3Pss6ErS2+j5e+Keu5K3vtzCF+Ls6j+Ols0FGqBTuoa3GUpFw31oEsApXDCn0
 HD/9qLRmQufCGg5aFsnEyPkQAbh6nxxcUzDGsbm1teQTCu/+YB2f38OBL2PrktfhfRq1
 oOEMlp8xaetuLXfocG/7geOfk0g36RtvZGPDxeEqsj59TzsrHDk96dpKcqNErcSW9fQg
 Jal0btm7J2xywSlP0G9bYoYyRGVEiSdSQCYeVKeDyV+zjfdI3DCPtwipzEFQ3c//SOgo
 ytHA==
X-Gm-Message-State: AOJu0Yw+bRTsZvA1P9nXMo6+91QctQFYRL3cGfLqqjup/x+bRomYyyNb
 mNQxYUrw05m6+PperWBZH+5fwYuw2ILK++BQzp0=
X-Google-Smtp-Source: AGHT+IEFiUuYxF3KqQ/I3qRuuLQp9I3sRpAY9i35/tk1qcQv6QuCfUwZb7F/BYXGhrrPEr5z20lyXA==
X-Received: by 2002:a05:600c:255:b0:405:2d23:16d9 with SMTP id
 21-20020a05600c025500b004052d2316d9mr3994983wmj.21.1696481544211; 
 Wed, 04 Oct 2023 21:52:24 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c00d600b00405ee9dc69esm2868359wmm.18.2023.10.04.21.52.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:52:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 15/22] qapi: Inline and remove QERR_MIGRATION_ACTIVE
 definition
Date: Thu,  5 Oct 2023 06:50:32 +0200
Message-ID: <20231005045041.52649-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 migration/migration.c     | 2 +-
 migration/options.c       | 4 ++--
 migration/savevm.c        | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index d95c4b84b9..cc4dae1076 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_MIGRATION_ACTIVE \
-    "There's a migration process in progress"
-
 #define QERR_MISSING_PARAMETER \
     "Parameter '%s' is missing"
 
diff --git a/migration/migration.c b/migration/migration.c
index b7f6818a15..5703cc34ae 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1616,7 +1616,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     }
 
     if (migration_is_running(s->state)) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return false;
     }
 
diff --git a/migration/options.c b/migration/options.c
index 4f6c8e810c..7360a22252 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -618,7 +618,7 @@ bool migrate_cap_set(int cap, bool value, Error **errp)
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
     if (migration_is_running(s->state)) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return false;
     }
 
@@ -662,7 +662,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     bool new_caps[MIGRATION_CAPABILITY__MAX];
 
     if (migration_is_running(s->state) || migration_in_colo_state()) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 41c7f39ef5..c0e0585bc1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1634,7 +1634,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     MigrationStatus status;
 
     if (migration_is_running(ms->state)) {
-        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        error_setg(errp, "There's a migration process in progress");
         return -EINVAL;
     }
 
-- 
2.41.0


