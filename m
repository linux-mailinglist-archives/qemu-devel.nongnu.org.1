Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554B823B7B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFQq-0004IA-9W; Wed, 03 Jan 2024 23:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQm-0004Gh-Rv
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQl-0006jG-AL
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5aZuxJnrToxZ5DpnWuVDhfmW883sU+rGu7ymv+9ot6E=;
 b=eUG590kqFlILiStxN0yEK0a7TMqfhM3ACS7JzU8oIM7ZplROWyTAJrlj5HmhX89mHEXc3O
 jz/6StCcR4qX4ZHXXD+XDLlthMJN4O3CJjovTYAiDM/WnEgANpPNZlgXH3g7lGwvcROh/k
 BHwB1Q1wvVQ02w/EqfL9Rt232dorZjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-UIa82VnpMSeDndPZ5jshaw-1; Wed, 03 Jan 2024 23:34:03 -0500
X-MC-Unique: UIa82VnpMSeDndPZ5jshaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EAA0848C03;
 Thu,  4 Jan 2024 04:34:03 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24B79C15968;
 Thu,  4 Jan 2024 04:33:58 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 21/26] migration/multifd: Fix leaking of Error in TLS error flow
Date: Thu,  4 Jan 2024 12:32:06 +0800
Message-ID: <20240104043213.431566-22-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

If there is an error in multifd TLS handshake task,
multifd_tls_outgoing_handshake() retrieves the error with
qio_task_propagate_error() but never frees it.

Fix it by freeing the obtained Error.

In addition, the error is not reported at all, so report it with
migrate_set_error().

Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20231231093016.14204-8-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 55d5fd55f8..9ac24866ad 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -787,6 +787,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
 
+    migrate_set_error(migrate_get_current(), err);
     /*
      * Error happen, mark multifd_send_thread status as 'quit' although it
      * is not created, and then tell who pay attention to me.
@@ -794,6 +795,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     p->quit = true;
     qemu_sem_post(&multifd_send_state->channels_ready);
     qemu_sem_post(&p->sem_sync);
+    error_free(err);
 }
 
 static void *multifd_tls_handshake_thread(void *opaque)
-- 
2.41.0


