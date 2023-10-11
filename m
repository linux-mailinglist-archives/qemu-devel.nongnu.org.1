Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900A7C4F32
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRl-00048b-On; Wed, 11 Oct 2023 05:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRj-00041V-Qe
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRi-0005BD-8b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIUeWXTEhaqP6qFgub9ZayYYOv+BTlasMHu24WcxA5Y=;
 b=Ljw3UTp/Vubl8z3OFTykesuuAs32N8fNr9ItHv1FdOp7ggGzr9s1aVp7l4MjcEbPYKo/3I
 TWGKgApKy/6NCKNBxcYJQ/EJG2qQgt6NYbthpvqFN7F9xq/xLOznTNfgM+jDloEXoi1aCb
 oND+xYT7ManMoJeze07stNgqf2EJMaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-RyPXs9MaMManhzjFUdWTiQ-1; Wed, 11 Oct 2023 05:23:58 -0400
X-MC-Unique: RyPXs9MaMManhzjFUdWTiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DF2858280;
 Wed, 11 Oct 2023 09:23:58 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63BC01C060AE;
 Wed, 11 Oct 2023 09:23:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 55/65] migration/rdma: Don't report received completion events
 as error
Date: Wed, 11 Oct 2023 11:21:53 +0200
Message-ID: <20231011092203.1266-56-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

When qemu_rdma_wait_comp_channel() receives an event from the
completion channel, it reports an error "receive cm event while wait
comp channel,cm event is T", where T is the numeric event type.
However, the function fails only when T is a disconnect or device
removal.  Events other than these two are not actually an error, and
reporting them as an error is wrong.  If we need to report them to the
user, we should use something else, and what to use depends on why we
need to report them to the user.

For now, report this error only when the function actually fails.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-49-armbru@redhat.com>
---
 migration/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6a8ff8fa96..b5bb47108e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1582,11 +1582,11 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                         return -1;
                     }
 
-                    error_report("receive cm event while wait comp channel,"
-                                 "cm event is %d", cm_event->event);
                     if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
                         cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
                         rdma_ack_cm_event(cm_event);
+                        error_report("receive cm event while wait comp channel,"
+                                     "cm event is %d", cm_event->event);
                         return -1;
                     }
                     rdma_ack_cm_event(cm_event);
-- 
2.41.0


