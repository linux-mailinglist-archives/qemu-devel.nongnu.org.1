Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796BEAB26DC
	for <lists+qemu-devel@lfdr.de>; Sun, 11 May 2025 08:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzsG-0002Fb-Q3; Sun, 11 May 2025 02:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsE-0002FF-Kh
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsC-0003wY-Sw
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:18 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso4557488b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943755; x=1747548555;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sHD+2pGYZBM1saUJBRZKECLnePiyCMT+xoiE17eX2xk=;
 b=nC8vqENRA47aLmfDjRnXlnASzh3592o/dGJf2cHN13BdM59gNddeA2LGxTkwGl4RRP
 LQ4Igb9WQNFOJeBh9LCJMDIyWEQpuQE5dy5kMPUE8605Q2rW+8CH10l0j3z0rpEtDFds
 DHU2Nuzv2y3lWpvyvkI/XgllFh0Wu8DvXkp67YTAY+JDM4+vqiWXsq0A+gSvKmGQdQZ9
 wOBcpHJKxHCS1bP0R/Qxa/umjVV6N591hvcfatMqXLy58Soocc95XBlfFFaGRD79TfLo
 Hha2lIwwiyeHUQZGs0ArW4mpq1F2fg4t8mD3d0dzAl4WbKJ+tcDS5Va077gR+V/Pui6U
 JBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943755; x=1747548555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHD+2pGYZBM1saUJBRZKECLnePiyCMT+xoiE17eX2xk=;
 b=b/n6UF0m0fUG9AvUBWPNvNV4ecuShs1VLTlQnqXwKhdvIZyQ0XCXvAYAzlV2DaLOs7
 0nym1JZ4wTBUUSpgzQ1StuBcUDIFv1FDdGX6eUSxN02eqliL7pswu2uK2VycUVJBybFK
 V1lpp+rY7pm3UGfpcDgY4B7Hd2NJnixJg7mqmLwF65nFh1xJFJMCsRAQ7xrMMgqhLPiz
 LGiY+8p1Zok1zpTmPunnkUgrds0c8jUQtw64aLAUQjaMn6VtLp86hth/Yc4DF6EKR254
 NOLbtFXTgrqdq+IZxWIlT4wGI3tzXMOxWCATW2/5l5kgDdtZs63zkrhe2V+aeXW0dsm7
 6LpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/nGO+ziYhhNpHSpBScAyB2t2ZQwlk0a4UW5elnZ2w0rII5gV5nPw85jxHuU+CwGhauyxO1vWAj5PC@nongnu.org
X-Gm-Message-State: AOJu0Yz3gsNu/HFMBnGjor/iE6Can3N13Dq1j7FCnnsY15Qp8nd0UXk4
 U3+vOPSXyAwiViL93iCbgeGJ/bnS1hUidFsLZb7rt4awCHMvbNL7qSl9vgV9y08=
X-Gm-Gg: ASbGnctyHQ1HPCrSToaRy9OvPdewyIpKpe8QwgvuRM2nndOMisX2kPSJ08B0NxcvH8P
 xeMTWwgsYv4qe5DGZyCvriEpOzWw/Pr28vma3g6XIY+4jhELGX26Stuq8xgwBUC5F4iZbux1dzc
 4mUhvMnh9RFYVpY0SUxrct1ybyOzT8ll2WTAb33hKsjoKyECQOZBAAzWNsljVxwFQOXY5GC5fYE
 j/jTgRj+xpLeuAfhQuJG2qIRDzTIPBJJZB8IOtVROZf4Qqo51aXv0nt5dIOmrFqI9MY7ATnwJs6
 URf8RdwvMKwWeubKdjgAYPCmZn2ChHSYknmrSc5GrEEhA40Vn76W0Wc=
X-Google-Smtp-Source: AGHT+IHZZz4gZgd+2wrBtj9/WMk8CBB6cYGLc0h8iYz2WetG7IYGYAQBvKFpjrkBXPzWOx3dtU8PfQ==
X-Received: by 2002:a05:6a00:1915:b0:740:a52f:9652 with SMTP id
 d2e1a72fcca58-7423bbf0b49mr11717917b3a.6.1746943755562; 
 Sat, 10 May 2025 23:09:15 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b234ad4205dsm3634139a12.44.2025.05.10.23.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:24 +0900
Subject: [PATCH v3 07/10] migration: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-7-f7f69247d303@daynix.com>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
In-Reply-To: <20250511-event-v3-0-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

rp_pong_acks tells if it has ever received one pong. QemuEvent is
better suited for this usage because it represents a boolean rather
than integer and will not decrement with the wait operation.

pause_event can utilize qemu_event_reset() to discard events.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/migration.h |  6 +++---
 migration/migration.c | 29 +++++++++++++----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84d8..11dba5f4da77 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -342,11 +342,11 @@ struct MigrationState {
          */
         QemuSemaphore rp_sem;
         /*
-         * We post to this when we got one PONG from dest. So far it's an
+         * We set this when we got one PONG from dest. So far it's an
          * easy way to know the main channel has successfully established
          * on dest QEMU.
          */
-        QemuSemaphore rp_pong_acks;
+        QemuEvent rp_pong_acks;
     } rp_state;
 
     double mbps;
@@ -379,7 +379,7 @@ struct MigrationState {
     QemuSemaphore wait_unplug_sem;
 
     /* Migration is paused due to pause-before-switchover */
-    QemuSemaphore pause_sem;
+    QemuEvent pause_event;
 
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef91..053c23c58d82 100644
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
@@ -2550,7 +2550,7 @@ static void *source_return_path_thread(void *opaque)
         case MIG_RP_MSG_PONG:
             tmp32 = ldl_be_p(buf);
             trace_source_return_path_thread_pong(tmp32);
-            qemu_sem_post(&ms->rp_state.rp_pong_acks);
+            qemu_event_set(&ms->rp_state.rp_pong_acks);
             break;
 
         case MIG_RP_MSG_REQ_PAGES:
@@ -2693,7 +2693,7 @@ static inline void
 migration_wait_main_channel(MigrationState *ms)
 {
     /* Wait until one PONG message received */
-    qemu_sem_wait(&ms->rp_state.rp_pong_acks);
+    qemu_event_wait(&ms->rp_state.rp_pong_acks);
 }
 
 /*
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
@@ -4057,10 +4054,10 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
-    qemu_sem_destroy(&ms->pause_sem);
+    qemu_event_destroy(&ms->pause_event);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
-    qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
+    qemu_event_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
 }
@@ -4072,14 +4069,14 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-    qemu_sem_init(&ms->pause_sem, 0);
+    qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
     migrate_params_init(&ms->parameters);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
-    qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
+    qemu_event_init(&ms->rp_state.rp_pong_acks, false);
     qemu_sem_init(&ms->rate_limit_sem, 0);
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);

-- 
2.49.0


