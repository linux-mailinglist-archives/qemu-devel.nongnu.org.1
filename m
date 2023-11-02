Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D30FD7DF18D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:45:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW7I-0007rL-60; Thu, 02 Nov 2023 07:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW7F-0007gF-IT
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW7B-00060R-JD
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LICwPjw/3kWeAVFaS7cZEa1An4PYJYAkFM1YB+oeIuc=;
 b=RsELw0PUFRM43QZhHOjr8Vx8sUfaTzARtLrP5aU3wH0rOvM1DtshnNspR0K3XkwHik+IFu
 EhTx3azqCJMzl1WtVeViVFVrLaIqzHvwSaHY70sFRN8c+qXLZhbW6i2jM4ETfSHCaWqUIP
 wpgXKTVoERJD+ycAYGMHf1K+JoFs3Pc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-gSXH1LkiNbWlL8vlM6sE6g-1; Thu, 02 Nov 2023 07:43:53 -0400
X-MC-Unique: gSXH1LkiNbWlL8vlM6sE6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD4C101A54C;
 Thu,  2 Nov 2023 11:43:52 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C212B2026D4C;
 Thu,  2 Nov 2023 11:43:44 +0000 (UTC)
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
 Fam Zheng <fam@euphon.net>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 22/40] cpr: relax blockdev migration blockers
Date: Thu,  2 Nov 2023 12:40:36 +0100
Message-ID: <20231102114054.44360-23-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Some blockdevs block migration because they do not support sharing across
hosts and/or do not support dirty bitmaps.  These prohibitions do not apply
if the old and new qemu processes do not run concurrently, and if new qemu
starts on the same host as old, which is the case for cpr.  Narrow the scope
of these blockers so they only apply to normal mode.  They will not block
cpr modes when they are added in subsequent patches.

No functional change until a new mode is added.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <1698263069-406971-4-git-send-email-steven.sistare@oracle.com>
---
 block/parallels.c | 2 +-
 block/qcow.c      | 2 +-
 block/vdi.c       | 2 +-
 block/vhdx.c      | 2 +-
 block/vmdk.c      | 2 +-
 block/vpc.c       | 2 +-
 block/vvfat.c     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 1d695ce7fb..6318dd02e7 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1369,7 +1369,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/qcow.c b/block/qcow.c
index fdd4c83948..eab68e387c 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -307,7 +307,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vdi.c b/block/vdi.c
index fd7e365383..c647d72895 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -498,7 +498,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail_free_bmap;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index e37f8c0926..a9d08742f9 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1096,7 +1096,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vhdx format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 1335d39e16..85864b8045 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1386,7 +1386,7 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     error_setg(&s->migration_blocker, "The vmdk format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vpc.c b/block/vpc.c
index c30cf8689a..aa1a48ae0e 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -452,7 +452,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     bdrv_graph_rdunlock_main_loop();
 
-    ret = migrate_add_blocker(&s->migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vvfat.c b/block/vvfat.c
index 266e036dcd..9d050ba3ae 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1268,7 +1268,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                    "The vvfat (rw) format used by node '%s' "
                    "does not support live migration",
                    bdrv_get_device_or_node_name(bs));
-        ret = migrate_add_blocker(&s->migration_blocker, errp);
+        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
         if (ret < 0) {
             goto fail;
         }
-- 
2.41.0


