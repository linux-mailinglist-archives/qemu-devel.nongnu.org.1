Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD37B86CF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5kx-00051y-Db; Wed, 04 Oct 2023 13:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kk-0004SQ-MX
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kh-0001E0-U6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3231df68584so112198f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440818; x=1697045618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2mqPUiLY+xgyp8WhkPgnmE5sxcUntO1BZj3t2/zBvU=;
 b=IOdeVNJNrLy/4yV01S75rnsSqYmcoPYXbNH+LCzNO1nFy0JNc4tBzwFPbrZYLNIewm
 6HzlzCEPOfk01Fg94K1HcFpfbMjmNeyG37ZpcWaEm1KsC7oxTpOozxdwnF/YArml2l42
 tntzBvt6eEe0MjoCf0vWnZWOG1q3Q+Vx3IqmccbcNse1uZyTuTDZ7VIFY3hhzdyWSccZ
 4dbat1ZDDfMl/BSRLX96jKPRdWO0e6b2e0gD01Pk0M5pCWBKBOl/txi5raEFcIXnq0Rc
 OSarMfJKYnVNrZ2mn4aGBymOUWpaJp70Ic9SHwUEr1+LnIp9+O3DUWv64RzqO0suJ9pt
 awSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440818; x=1697045618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2mqPUiLY+xgyp8WhkPgnmE5sxcUntO1BZj3t2/zBvU=;
 b=nYfxWaYqkSMnKohCaeuVOfnLeuGFkSX7sl8VBawJXRaSZbKAXmSFJgqXUkpoLYvdpa
 8mZ78TFipM8PEdAIjla7RodKusxFY9VnqdZw0G99uUTqn/cRkx4AH3zF4OGGydOZqt64
 KYEgpjz8//Umm3h7D4BFXKwj25q65cqxWlcSx/hg7K2L1etkBaQZAv68r4c6dLVaXRqB
 Gak3vdBb4+m+Xada+i2AkZIMfR3rWGHfr8Wtaurf07tFPcD3jzzWIX5/I4EzuU1pNR/8
 EIvuP263PzvGjR6fsTe8k6fBua69ZGHaaVZqwKVJyizFENMXB1Q/sT3m3Pwd8iQPFNlE
 S7xg==
X-Gm-Message-State: AOJu0YzzFAvxU2dZLNzrI8LNdSdG9Pad3krdiixIj6BHemHJr+sRR71i
 mNRB+UwdI9gv2UH7Yg6LUbU1iM932yH4DHDzOcY=
X-Google-Smtp-Source: AGHT+IG65jLeDptHqIznHYwtU279e92Hx1gp5+3joNpHjdMPWSM/ouFAr23LDsDFSYQkISif2xHnFQ==
X-Received: by 2002:a5d:440f:0:b0:320:a4e:6b83 with SMTP id
 z15-20020a5d440f000000b003200a4e6b83mr2742242wrq.31.1696440818441; 
 Wed, 04 Oct 2023 10:33:38 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 d14-20020adfe84e000000b0031c5b380291sm4459057wrn.110.2023.10.04.10.33.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 14/21] qapi: Inline and remove QERR_MIGRATION_ACTIVE definition
Date: Wed,  4 Oct 2023 19:31:49 +0200
Message-ID: <20231004173158.42591-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
index 3a2180b779..e363b4885f 100644
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


