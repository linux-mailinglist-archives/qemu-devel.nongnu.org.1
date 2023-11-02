Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA57DF1A5
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW75-00068C-G6; Thu, 02 Nov 2023 07:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW6p-0005Lr-I8
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW6h-0005sZ-QZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMrx1riEvb3RA7dYm5KBjiM+nQjdYZKB+bCCm3twBGk=;
 b=h7ycPwLKE2qjeYm8Fc2PjXyslnzGv5hnzXbziI6hopcj3tUX5ONNWNSv3kCVqOLwnbIHlC
 aNmMb2V/A0TKgPPJIS+RsP003QApyDZYkGXzNTfOQAeIzr5hiU1wQwtVsaZcEd7rwsXSER
 tmYo36qpyrhXduVQFauLfZPLaAIqpgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-Q5wD7dJpMHSSfclf_8MjNg-1; Thu,
 02 Nov 2023 07:43:22 -0400
X-MC-Unique: Q5wD7dJpMHSSfclf_8MjNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2CEF2808FC1;
 Thu,  2 Nov 2023 11:43:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB06B2026D4C;
 Thu,  2 Nov 2023 11:43:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 18/40] migration: migration_stop_vm() helper
Date: Thu,  2 Nov 2023 12:40:32 +0100
Message-ID: <20231102114054.44360-19-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Provide a helper for non-COLO use case of migration to stop a VM.  This
prepares for adding some downtime relevant tracepoints to migration, where
they may or may not apply to COLO.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231030163346.765724-5-peterx@redhat.com>
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
index 8aac0c753e..3e38294485 100644
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
@@ -2169,7 +2174,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
-    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
         goto fail;
     }
@@ -2371,7 +2376,7 @@ static int migration_completion_precopy(MigrationState *s,
     s->vm_old_state = runstate_get();
     global_state_store();
 
-    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     trace_migration_completion_vm_stop(ret);
     if (ret < 0) {
         goto out_unlock;
@@ -3222,7 +3227,7 @@ static void *bg_migration_thread(void *opaque)
 
     global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
-    if (vm_stop_force_state(RUN_STATE_PAUSED)) {
+    if (migration_stop_vm(RUN_STATE_PAUSED)) {
         goto fail;
     }
     /*
-- 
2.41.0


