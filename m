Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B357DD67F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:04:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyv-00050b-DK; Tue, 31 Oct 2023 15:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyY-0004QH-RR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxs-0006AS-Jd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMOrLm9lwPmnSkJIuRKxa+fXZZNa/ChNIVjMW9jlZnY=;
 b=J9XlZ1r/03VInI7Rqw3RHmDzA5gYmc6P5dHzWgY0bpOBQrIKNq3ne0Khma+V7H0VDDz8q8
 LuIzNZA3EJg0AHyXUxqZjXHmTFUmBZJmCkWC+Igdu1dlcS658Hq+whEDWzDSjswQDjtlDd
 PpviZ2XtyGa0GeBSMWYBtSwdapYW6lY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-me_Uoo76OC-eOOm2jvmByg-1; Tue, 31 Oct 2023 14:59:42 -0400
X-MC-Unique: me_Uoo76OC-eOOm2jvmByg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0026D185A792;
 Tue, 31 Oct 2023 18:59:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 642F825C0;
 Tue, 31 Oct 2023 18:59:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 25/27] blockjob: query driver-specific info via a new 'query'
 driver method
Date: Tue, 31 Oct 2023 19:59:16 +0100
Message-ID: <20231031185918.346940-26-kwolf@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231031135431.393137-9-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h | 5 +++++
 blockjob.c                   | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index a4656d4cb5..18ee6f7bf0 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -74,6 +74,11 @@ struct BlockJobDriver {
      * Note that this can already be called before the job coroutine is running.
      */
     void (*change)(BlockJob *job, BlockJobChangeOptions *opts, Error **errp);
+
+    /*
+     * Query information specific to this kind of block job.
+     */
+    void (*query)(BlockJob *job, BlockJobInfo *info);
 };
 
 /*
diff --git a/blockjob.c b/blockjob.c
index 5b4786a70f..5b24de356d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -378,6 +378,7 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
 {
     BlockJobInfo *info;
     uint64_t progress_current, progress_total;
+    const BlockJobDriver *drv = block_job_driver(job);
 
     GLOBAL_STATE_CODE();
 
@@ -407,6 +408,11 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
                         g_strdup(error_get_pretty(job->job.err)) :
                         g_strdup(strerror(-job->job.ret));
     }
+    if (drv->query) {
+        job_unlock();
+        drv->query(job, info);
+        job_lock();
+    }
     return info;
 }
 
-- 
2.41.0


