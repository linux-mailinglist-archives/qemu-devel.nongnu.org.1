Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F17CBD9D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUt-0008HH-30; Tue, 17 Oct 2023 04:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUh-0007wG-Qq
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUg-0005Ys-4H
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGm8SjjZFgxmrkyySAQKEc6A9zhHvDAV0afmL0FCjDQ=;
 b=Xit3mGH8okSpGfVidfEnQvneUpR+YECmSJcKnV7NRs8lf6nLfAicVOl3CncwS+h7Qfr2iH
 wQgTMDzcPFiLDZJqqYVgihspiR3yyY/OVwua7MvX9uObmRaq9VCvFdHoM6ddZVzVoWPc7p
 Oyj/bFiTSADTchZB+1oJyXAgWJwSoJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-Lq5ynXs8NS-5S26PTSrFMw-1; Tue, 17 Oct 2023 04:32:00 -0400
X-MC-Unique: Lq5ynXs8NS-5S26PTSrFMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A522D862F50;
 Tue, 17 Oct 2023 08:31:57 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1730A1C060AE;
 Tue, 17 Oct 2023 08:31:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 37/38] migration/multifd: Unify multifd_send_thread error paths
Date: Tue, 17 Oct 2023 10:30:02 +0200
Message-ID: <20231017083003.15951-38-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

The preferred usage of the Error type is to always set both the return
code and the error when a failure happens. As all code called from the
send thread follows this pattern, we'll always have the return code
and the error set at the same time.

Aside from the convention, in this piece of code this must be the
case, otherwise the if (ret != 0) would be exiting the thread without
calling multifd_send_terminate_threads() which is incorrect.

Unify both paths to make it clear that both are taken when there's an
error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231012134343.23757-3-farosas@suse.de>
---
 migration/multifd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 8e9a5ee394..c92955de41 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -753,19 +753,13 @@ static void *multifd_send_thread(void *opaque)
     }
 
 out:
-    if (local_err) {
+    if (ret) {
+        assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
-        error_free(local_err);
-    }
-
-    /*
-     * Error happen, I will exit, but I can't just leave, tell
-     * who pay attention to me.
-     */
-    if (ret != 0) {
         qemu_sem_post(&p->sem_sync);
         qemu_sem_post(&multifd_send_state->channels_ready);
+        error_free(local_err);
     }
 
     qemu_mutex_lock(&p->mutex);
-- 
2.41.0


