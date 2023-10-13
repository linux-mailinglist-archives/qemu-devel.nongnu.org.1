Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C03667C801B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD60-0001fI-5J; Fri, 13 Oct 2023 04:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5m-0000Tb-6n
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5i-0007ku-ST
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406618d080eso19294845e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184012; x=1697788812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+DLIUIwbuIwxFUYvGciS4FmM5g0x3oWw8iQPsxxRuY=;
 b=s3aVUPCpoFx5w+SFX1nZQqsARPcOEIuqkP6sJdWRSF0X/RHC8jRJYPzsKrP476HosS
 1qgXywmnDHiTHGVH49qt9NwSwgyhVw/i5afGvo9OkfEumo5fJMRMlDu/G3mDqoDreBaB
 syN/nE6URNVYbEtXkudMzEafVctmAIcfHWpYFDsgYD3hMB7w8txBbzfBFXzQYcQzLm+q
 OeuKNq8aMrNIKCT7nsW35HAOH0wpXA1TnE4bvlRawldYmzze8smrBdPNLYKJjIuq6VdV
 8j5Gz/ENQaxAK52Sy9dUCqeHFRcujevmGb97ZBkxcdM3Cp2hZSVK4EXOkCMKF8Lr92Ez
 Oazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184012; x=1697788812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+DLIUIwbuIwxFUYvGciS4FmM5g0x3oWw8iQPsxxRuY=;
 b=JrgfCeom+TU5PZVS8VEXt7C5VcGX0kyTuIHrdQtACzlh0wVSUSyApEtzIcrhXJ+JT/
 tHsLoYETMAcIx0ARhdL1B0DEWfzMWYv/l4OvrX6NYQnbaaqHSOFu+9OhkFFHflnMGmiI
 3V2BWScN1UleBv5zTa7175W5T+oyzm0XtJGVCEzO9dSCrlF4K1VO9B6tYrTqS/iE6f3G
 Ujd1uvZMjzE9az4vVAuGxbPhOobm+2YapqCOBd57gxt5SATNWtCmS3eTJo2/99Id+qaj
 ujGgR2qiuqsrOUlL6U9Ntx8+07P2LsbVGwB9wAesOTJSzH5LUVrfyAGJxG+7h2fcdKiw
 TybA==
X-Gm-Message-State: AOJu0YzuLrb+zkqD6CaHAmL13cZF+t1Eh6ykegQCX+sFNxArJGnBtIkT
 x5hwXGQTsfvP8LnPW90KtA854QIdfOfuSHh9b/M=
X-Google-Smtp-Source: AGHT+IEGWOqgp/zwxBKxU85Dz6+3Qnz/HbGz48NR4UR/XFZ/No0arL1HkhtrIB8Ku9TenWQqH1Sk/Q==
X-Received: by 2002:a1c:721a:0:b0:405:1baf:cedf with SMTP id
 n26-20020a1c721a000000b004051bafcedfmr23274599wmc.24.1697184012232; 
 Fri, 13 Oct 2023 01:00:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:11 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH v2 75/78] migration: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:42 +0300
Message-Id: <0576767d85b1b990a65f7b9cc922a50d9855ea57.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..fdad37efbb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2772,38 +2772,38 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 static void migration_iteration_finish(MigrationState *s)
 {
     /* If we enabled cpu throttling for auto-converge, turn it off. */
     cpu_throttle_stop();
 
     qemu_mutex_lock_iothread();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
         migration_calculate_complete(s);
         runstate_set(RUN_STATE_POSTMIGRATE);
         break;
     case MIGRATION_STATUS_COLO:
         assert(migrate_colo());
         migrate_start_colo_process(s);
         s->vm_old_state = RUN_STATE_RUNNING;
-        /* Fallthrough */
+        fallthrough;
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
         if (s->vm_old_state == RUN_STATE_RUNNING) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
             }
         } else {
             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
                 runstate_set(s->vm_old_state);
             }
         }
         break;
 
     default:
         /* Should not reach here, but if so, forgive the VM. */
         error_report("%s: Unknown ending state %d", __func__, s->state);
         break;
     }
     migrate_fd_cleanup_schedule(s);
     qemu_mutex_unlock_iothread();
 }
-- 
2.39.2


