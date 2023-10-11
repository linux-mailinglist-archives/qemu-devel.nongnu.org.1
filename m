Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA87C56A2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:21:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqa4s-00020Y-Fz; Wed, 11 Oct 2023 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qqa4q-00020P-T2
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qqa4p-0001qV-Aq
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5fWOLug7VeTAVZeefrtEofB5vl5fYqqQK0ztW88WoA=;
 b=E3ix+TiPzh2HNsNsORRo0JLZl6ceJch9JHsNTH+LFT6bWs40mRGNg8qzdlg3sqoDINRGpY
 FcGCjhZclMz+D47wbyQw8aYdsJc0yKRSlb+vDKVB8k2Gxy2QM8W5dhFgah4FiaurgIVbsS
 +KsnpKMIkf5Aw3O0fPcCgzDKHm4bSLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-4iwILGv5PqSHgIRmSYwQpg-1; Wed, 11 Oct 2023 10:20:34 -0400
X-MC-Unique: 4iwILGv5PqSHgIRmSYwQpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 179D58022EA;
 Wed, 11 Oct 2023 14:20:34 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ACA71005B8E;
 Wed, 11 Oct 2023 14:20:33 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/3] qga: Fix memory leak when output stream is unused
Date: Wed, 11 Oct 2023 17:20:29 +0300
Message-ID: <20231011142030.112018-3-kkostiuk@redhat.com>
In-Reply-To: <20231011142030.112018-1-kkostiuk@redhat.com>
References: <20231011142030.112018-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Daniel Xu <dxu@dxuuu.xyz>

If capture-output is requested but one of the channels goes unused (eg.
we attempt to capture stderr but the command never writes to stderr), we
can leak memory.

guest_exec_output_watch() is (from what I understand) unconditionally
called for both streams if output capture is requested. The first call
will always pass the `p->size == p->length` check b/c both values are
0. Then GUEST_EXEC_IO_SIZE bytes will be allocated for the stream.

But when we reap the exited process there's a `gei->err.length > 0`
check to actually free the buffer. Which does not get run if the command
doesn't write to the stream.

Fix by making free() unconditional.

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 09c683e263..ce172edd2d 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -206,15 +206,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 #endif
         if (gei->out.length > 0) {
             ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
-            g_free(gei->out.data);
             ges->has_out_truncated = gei->out.truncated;
         }
+        g_free(gei->out.data);
 
         if (gei->err.length > 0) {
             ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
-            g_free(gei->err.data);
             ges->has_err_truncated = gei->err.truncated;
         }
+        g_free(gei->err.data);
 
         QTAILQ_REMOVE(&guest_exec_state.processes, gei, next);
         g_free(gei);
-- 
2.42.0


