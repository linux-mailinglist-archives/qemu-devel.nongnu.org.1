Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50BEAC781C
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 07:47:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6F-00032V-OW; Thu, 29 May 2025 01:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5x-00030c-H7
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5u-0003CJ-PM
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:25 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2349f096605so6816225ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497581; x=1749102381;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=awxH8im/pfEWosRDyhhjz6r63zsYHaX2/Wznr/3cAS0=;
 b=B+BFS4eRqEz4tXIOKD6j4WMZwz2kIaI5lZpg3oUZHI0sQc0nMTfRllN3+cmFD6hgOe
 JzfKpJzyJykC01tw52vVI2dCbs8cauGFhBAP2OuXViJqQWTuWhx9FbLGvjhKH6liMjw7
 p4ZLVzWWbvGhFuSZa0tshJtjLVMrcPDyLMdRGXww0eS837BW0PDbbewGlTushsjyT5BX
 thDfLAFaJa+ylF9shKqyrVsY1+8ChbSGlBmiY90OLxNofmq0jdkD42kdOCiOOTCwiZhb
 ph4tsq0PGaTS4dP2FJSDN34B28vB/ymhu0Ap9RVVjNOW7+5q3kSDDKGQbMglgcTacyJZ
 QJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497581; x=1749102381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awxH8im/pfEWosRDyhhjz6r63zsYHaX2/Wznr/3cAS0=;
 b=dZUbU34l8q1Rb+SjSsVWPaT29hkxOAGgCDvYPUL270fSjmfDWrSXMvn+NOj4jPhgSd
 gwIJX3+P9eqKRLQp6u8S4T4mfGbEgszTMlzJDLlD0UZXMAuOjOC3MlMcB6zBxqC4BmFb
 EV0tF6gtNan+H7ykOn/kX9+tnWSO2nLPse2/bNTKXHW591/fG7DWiCVcWwU+zCRDcS3m
 e/S+M8TZVPt5VCzhYaZR3YsgISTvXPZqzKENeoc4ZvbglFCYAcp1rUDcdi+gO8R29JMC
 mnJjapSiUgbHMOUVczNcfAQV4Wy5u6SxvHSXYV9rIM86gJT02lC8wJ41pPU4htYKqcGp
 Ymmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq3dJ6MlGnXYbk4WkfUDcxOKjW27BWBBW7q7OwvBLhoEAfUh3JQ2QDBbD+XCmP3sWRb18HRVCxYpsR@nongnu.org
X-Gm-Message-State: AOJu0YyXHQJkkMNyvSsQ6qLYqA5p2KgXqe00MV50LfhsC3kqGwAFXBFP
 7xZ2SH5LOVYZ/7HYkyUO2QdPd8qg+X2+gO8GNO3+Zi0C/p1JqUJYfoNZ9Dqm6k8Ph+M=
X-Gm-Gg: ASbGncvS2+Urf/K1LEJlo6HS+IZJyYWSuzozO+6XOQEcKabsC6Yh/UPmlnfOKOLFcQt
 HMU1tYuLDUKumm7YOYY/60a8PIVsJi/V1qhCetNVdfVZkIaov+AjBNGCR9lNgRoINHF2R7RXwTH
 7waRB8WFda27hh7n48wuPLA0F1t2BpbyM3TSRd0XZl1zBYEHRvzs16Xj/2Nhq+DJW8u4moIUO6I
 JeI6/2ywiam2rS59B72yGx97n6H7+Nrtcci3REAU58481jVWouYegk/l0E2fWGaMWGdTM/PA2Ro
 mUgQM7ORjlwVYinMQKWZE5s/WgS4EE3C2uj17G/Zno23iEIYhXQC
X-Google-Smtp-Source: AGHT+IH94dbSz+AzpWq7pM3Z8WnPNOLqseWVB1L+39u485bC+5JJe0Eq76WMXK6gaLby0FEbZm3lFg==
X-Received: by 2002:a17:902:c941:b0:234:db06:ac0 with SMTP id
 d9443c01a7336-234db060c39mr58367655ad.45.1748497581020; 
 Wed, 28 May 2025 22:46:21 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cf9100sm4998315ad.198.2025.05.28.22.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:56 +0900
Subject: [PATCH v5 07/13] migration: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-event-v5-7-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

pause_event can utilize qemu_event_reset() to discard events.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/migration.h |  2 +-
 migration/migration.c | 21 +++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84d8..21aa6a3c8fee 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -379,7 +379,7 @@ struct MigrationState {
     QemuSemaphore wait_unplug_sem;
 
     /* Migration is paused due to pause-before-switchover */
-    QemuSemaphore pause_sem;
+    QemuEvent pause_event;
 
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef91..4098870bce33 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1630,7 +1630,7 @@ void migration_cancel(void)
         }
         /* If the migration is paused, kick it out of the pause */
         if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
-            qemu_sem_post(&s->pause_sem);
+            qemu_event_set(&s->pause_event);
         }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
@@ -2342,7 +2342,7 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
                    MigrationStatus_str(s->state));
         return;
     }
-    qemu_sem_post(&s->pause_sem);
+    qemu_event_set(&s->pause_event);
 }
 
 int migration_rp_wait(MigrationState *s)
@@ -2911,21 +2911,18 @@ static bool migration_switchover_prepare(MigrationState *s)
         return true;
     }
 
-    /* Since leaving this state is not atomic with posting the semaphore
+    /*
+     * Since leaving this state is not atomic with setting the event
      * it's possible that someone could have issued multiple migrate_continue
-     * and the semaphore is incorrectly positive at this point;
-     * the docs say it's undefined to reinit a semaphore that's already
-     * init'd, so use timedwait to eat up any existing posts.
+     * and the event is incorrectly set at this point so reset it.
      */
-    while (qemu_sem_timedwait(&s->pause_sem, 1) == 0) {
-        /* This block intentionally left blank */
-    }
+    qemu_event_reset(&s->pause_event);
 
     /* Update [POSTCOPY_]ACTIVE to PRE_SWITCHOVER */
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_PRE_SWITCHOVER);
     bql_unlock();
 
-    qemu_sem_wait(&s->pause_sem);
+    qemu_event_wait(&s->pause_event);
 
     bql_lock();
     /*
@@ -4057,7 +4054,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
-    qemu_sem_destroy(&ms->pause_sem);
+    qemu_event_destroy(&ms->pause_event);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
@@ -4072,7 +4069,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-    qemu_sem_init(&ms->pause_sem, 0);
+    qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
     migrate_params_init(&ms->parameters);

-- 
2.49.0


