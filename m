Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2278E28A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTz0-0006Vm-Rv; Wed, 30 Aug 2023 18:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbTyz-0006VQ-14
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbTyw-0001MW-V5
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693435694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rje/ITqNXJ/6Ru0HFlJBMqtFHqIeokN2njMddGzffg8=;
 b=iHyCvB6lYy3qShBE5yXSKWEMfUOsc7wPBO2kDB4b6bEuWQHtnbBpjaSsB9Ik4UEcJ8vsDb
 tdpLBQsYTnsCjyPoMA1IoG0fFiLD+2P+B3f7K9rgRi+HW+N44ReAfVI+Vogs0xkCgWIFC+
 bJD3Whf0ujuOc0rDOzXmb7sK1E0XED8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-hUaB-R_FNhOQe0WW5OK_jA-1; Wed, 30 Aug 2023 18:48:10 -0400
X-MC-Unique: hUaB-R_FNhOQe0WW5OK_jA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 484071C06927;
 Wed, 30 Aug 2023 22:48:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF9F4112131E;
 Wed, 30 Aug 2023 22:48:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 kwolf@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 3/4] io: check there are no qio_channel_yield() coroutines
 during ->finalize()
Date: Wed, 30 Aug 2023 18:48:01 -0400
Message-ID: <20230830224802.493686-4-stefanha@redhat.com>
In-Reply-To: <20230830224802.493686-1-stefanha@redhat.com>
References: <20230830224802.493686-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

Callers must clean up their coroutines before calling
object_unref(OBJECT(ioc)) to prevent an fd handler leak. Add an
assertion to check this.

This patch is preparation for the fd handler changes that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 io/channel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io/channel.c b/io/channel.c
index 72f0066af5..c415f3fc88 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -653,6 +653,10 @@ static void qio_channel_finalize(Object *obj)
 {
     QIOChannel *ioc = QIO_CHANNEL(obj);
 
+    /* Must not have coroutines in qio_channel_yield() */
+    assert(!ioc->read_coroutine);
+    assert(!ioc->write_coroutine);
+
     g_free(ioc->name);
 
 #ifdef _WIN32
-- 
2.41.0


