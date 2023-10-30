Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA257DBE06
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:35:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVDV-0003e2-Kp; Mon, 30 Oct 2023 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDT-0003dJ-07
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDR-0002hM-IL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/sRV6J8eLHpB7qWOrvwuQ/IwzVXUDAHsjZN95QdXXQ=;
 b=VkjYMt+B4d5aqIZL9caQ0ZZjBj+UcK4hQMd5YQhphm9IvQ2vA4FEiZMV5fQ2zsbgSEBR4S
 9mhc+apsIiSTa2ESDYTZQ/2UBotJdfTh/EiU0hj6xhlLWS6zcrTz//xKJmVN2u3mANS+sl
 hGKX2SsF6aMBOfUn3Uk0Xt6o/6+p6Kg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-N7fKDIjAP_SaRLSe_okv3w-1; Mon, 30 Oct 2023 12:34:00 -0400
X-MC-Unique: N7fKDIjAP_SaRLSe_okv3w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4197468d5caso11355231cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683639; x=1699288439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/sRV6J8eLHpB7qWOrvwuQ/IwzVXUDAHsjZN95QdXXQ=;
 b=w6ENlEaDEzXAQfhg4Za/FPF6ARwGn3GperMjevOp1rXNg3u7HGzPGG2aN0XOq7W8I1
 n3gnEM3GkH7N+Gqb81QtNvPw2KX3Sxr9a2IOkJ9oLiF7XANaSsqhJhhcOc8B/NUjKIKY
 NmwjQh8uCwhyMVPg7Z1of+nwxPQ5l4h+j9c9zs4An+xgnJIdbO3w1BncJZ6khsIP74qi
 oy0SiRMqrmFg3v0Ik0XhUzeunK57+sIv5ETqGJz1jCNt4pkKxlLO6mwSVCw+43FsPsf0
 lwFNYPpHgcROnQ06FVWBlsbQVqkh5KHWSo6eJ4aSbqkbN4bj4g0jczNGlaVZRZAzoBNU
 TG8g==
X-Gm-Message-State: AOJu0YzyiiWRT/d9g3qbyG2yqMPHLr32pk2JatgJFRTRjm++5IM8WSNp
 1McTHzhGGtzAeHLQ7zTxp4897HpXboNknLXWYL5Y0b+74pduv8WzLK+VTG0gPxxmdQw5gFS9DG8
 NQ2l+Fc9NxSAHu0vAziwrlNAtbU4BaiZ6ZYkNz+LctxfP4nUqfMeP/NTQ83MCs2WqPIcCzroG
X-Received: by 2002:ac8:5f11:0:b0:41c:d433:6c86 with SMTP id
 x17-20020ac85f11000000b0041cd4336c86mr11933745qta.4.1698683639143; 
 Mon, 30 Oct 2023 09:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUOfS9rdf4/DyVkTUOT7PJlZ8xvhIff0whlVDZ6LZHPUqdMQe47zmWSqnYWpVsJA73o6Dvjg==
X-Received: by 2002:ac8:5f11:0:b0:41c:d433:6c86 with SMTP id
 x17-20020ac85f11000000b0041cd4336c86mr11933721qta.4.1698683638846; 
 Mon, 30 Oct 2023 09:33:58 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ac84ccf000000b004198ae7f841sm3531111qtv.90.2023.10.30.09.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:33:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 4/5] migration: migration_stop_vm() helper
Date: Mon, 30 Oct 2023 12:33:45 -0400
Message-ID: <20231030163346.765724-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030163346.765724-1-peterx@redhat.com>
References: <20231030163346.765724-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Provide a helper for non-COLO use case of migration to stop a VM.  This
prepares for adding some downtime relevant tracepoints to migration, where
they may or may not apply to COLO.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  2 ++
 migration/migration.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index ae82004892..5944107ad5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -544,4 +544,6 @@ void migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
+int migration_stop_vm(RunState state);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 70d775942a..9013c1b500 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -149,6 +149,11 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
     return (a > b) - (a < b);
 }
 
+int migration_stop_vm(RunState state)
+{
+    return vm_stop_force_state(state);
+}
+
 void migration_object_init(void)
 {
     /* This can only be called once. */
@@ -2164,7 +2169,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
-    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
         goto fail;
     }
@@ -2366,7 +2371,7 @@ static int migration_completion_precopy(MigrationState *s,
     s->vm_old_state = runstate_get();
     global_state_store();
 
-    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     trace_migration_completion_vm_stop(ret);
     if (ret < 0) {
         goto out_unlock;
@@ -3217,7 +3222,7 @@ static void *bg_migration_thread(void *opaque)
 
     global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
-    if (vm_stop_force_state(RUN_STATE_PAUSED)) {
+    if (migration_stop_vm(RUN_STATE_PAUSED)) {
         goto fail;
     }
     /*
-- 
2.41.0


