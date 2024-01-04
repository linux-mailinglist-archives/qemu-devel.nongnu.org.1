Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0589D823B86
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:37:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFRL-00050m-5A; Wed, 03 Jan 2024 23:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFRA-0004nr-7z
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFR8-0006l3-If
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQqNPtY1Kadk2AaZ4HNHSmHk4bJZRjD+6n3RMnyFLo4=;
 b=IieF+bCqS7aOFGc1Lsz+Vvhes/79JOlkNCu/NoK9nc1N5kr3u9smloF3axsHbcof97czxM
 r5DFl+10OhtY3ezdMyT2S07/C7nP7cVMdapVhfQ9kdX98We1MqBVp2X4bkjqEX/jRTCH5v
 hftEOcWB3ytd/k8+4ZoUF8207RIvKpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-7BCZJPXuMZeI1I8n5UOzOA-1; Wed, 03 Jan 2024 23:34:24 -0500
X-MC-Unique: 7BCZJPXuMZeI1I8n5UOzOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E88A8101A555;
 Thu,  4 Jan 2024 04:34:22 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48DE6C159B0;
 Thu,  4 Jan 2024 04:34:17 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/26] migration/multifd: Remove unnecessary usage of local
 Error
Date: Thu,  4 Jan 2024 12:32:10 +0800
Message-ID: <20240104043213.431566-26-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

According to Error API, usage of ERRP_GUARD() or a local Error instead
of errp is needed if errp is passed to void functions, where it is later
dereferenced to see if an error occurred.

There are several places in multifd.c that use local Error although it
is not needed. Change these places to use errp directly.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20231231093016.14204-12-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9ac24866ad..9f353aecfa 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -951,12 +951,10 @@ int multifd_save_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
         int ret;
 
-        ret = multifd_send_state->ops->send_setup(p, &local_err);
+        ret = multifd_send_state->ops->send_setup(p, errp);
         if (ret) {
-            error_propagate(errp, local_err);
             return ret;
         }
     }
@@ -1195,12 +1193,10 @@ int multifd_load_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
-        Error *local_err = NULL;
         int ret;
 
-        ret = multifd_recv_state->ops->recv_setup(p, &local_err);
+        ret = multifd_recv_state->ops->recv_setup(p, errp);
         if (ret) {
-            error_propagate(errp, local_err);
             return ret;
         }
     }
-- 
2.41.0


