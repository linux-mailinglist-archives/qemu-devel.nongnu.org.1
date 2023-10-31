Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFA7DD687
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyv-0004wY-9f; Tue, 31 Oct 2023 15:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtye-0004Z3-Mf
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxw-0006BZ-Ei
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMtdBDMBFz3E4IAe3SFqA+poQ231wBdbtS/nA0JzEs8=;
 b=Mp6UI1O5H4PUoHJd4TWUX2KLFwzcEsH/yl1ZdWb8G4xFSCZn8A10nqJCTRF+9aLKUVZRhd
 tNfY4uyF+egIyh3hUbsCWRJiKNzNpAwIiyai3boXOocBqsVqX52E6GyCTbSmDdl9tMnC8G
 LE6gKUWMt31e9cVncelbDxSqcEKS8E0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Le0Bo7SXOXu4m-BnzHHm_A-1; Tue, 31 Oct 2023 14:59:39 -0400
X-MC-Unique: Le0Bo7SXOXu4m-BnzHHm_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 612B9835293;
 Tue, 31 Oct 2023 18:59:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3A2F25C0;
 Tue, 31 Oct 2023 18:59:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/27] qapi/block-core: use JobType for BlockJobInfo's type
Date: Tue, 31 Oct 2023 19:59:14 +0100
Message-ID: <20231031185918.346940-24-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

In preparation to turn BlockJobInfo into a union with @type as the
discriminator. That requires it to be an enum. Even without that
requirement, it's nicer to have an enum instead of a str here.

No functional change is intended.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231031135431.393137-7-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json           | 2 +-
 block/monitor/block-hmp-cmds.c | 4 ++--
 blockjob.c                     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6369207be2..9d03210664 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1396,7 +1396,7 @@
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
-  'data': {'type': 'str', 'device': 'str', 'len': 'int',
+  'data': {'type': 'JobType', 'device': 'str', 'len': 'int',
            'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
            'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
            'status': 'JobStatus',
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7645c7e5fb..5b2c597e7a 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -846,7 +846,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
     }
 
     while (list) {
-        if (strcmp(list->value->type, "stream") == 0) {
+        if (list->value->type == JOB_TYPE_STREAM) {
             monitor_printf(mon, "Streaming device %s: Completed %" PRId64
                            " of %" PRId64 " bytes, speed limit %" PRId64
                            " bytes/s\n",
@@ -858,7 +858,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
                            " of %" PRId64 " bytes, speed limit %" PRId64
                            " bytes/s\n",
-                           list->value->type,
+                           JobType_str(list->value->type),
                            list->value->device,
                            list->value->offset,
                            list->value->len,
diff --git a/blockjob.c b/blockjob.c
index f0505ad232..5b4786a70f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -390,7 +390,7 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
                           &progress_total);
 
     info = g_new0(BlockJobInfo, 1);
-    info->type      = g_strdup(job_type_str(&job->job));
+    info->type      = job_type(&job->job);
     info->device    = g_strdup(job->job.id);
     info->busy      = job->job.busy;
     info->paused    = job->job.pause_count > 0;
-- 
2.41.0


