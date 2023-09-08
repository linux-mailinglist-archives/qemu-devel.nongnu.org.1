Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE820798042
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 03:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeQPz-0008Qo-Cz; Thu, 07 Sep 2023 21:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPx-0008QZ-9v
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeQPu-0007sr-A7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 21:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694136973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h81esWg0ORmCPFztf/1p+Z2W1LI8v1JzfQWGinC7MR4=;
 b=AJG5bApGGzrZSpL41qxiWpbHGVu8qY/b6YGYCyPkvtJhcrdA9UV1NCEwkQeYXEGSkY36JC
 WohFy6Fkxm1/LJvyNzZmGIfbcrIE0jQ3PDhPiFqB/RFMfo0O3RjCV4XnGcQNOp4NDhMe3C
 /npUGZpuoEgQs2jGbXk28HfiQri/br0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-kjh7oR6TOLmmqaCVcsTuQg-1; Thu, 07 Sep 2023 21:36:11 -0400
X-MC-Unique: kjh7oR6TOLmmqaCVcsTuQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9485F1C07834
 for <qemu-devel@nongnu.org>; Fri,  8 Sep 2023 01:36:11 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A24740C2070;
 Fri,  8 Sep 2023 01:36:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/13] io: check there are no qio_channel_yield() coroutines
 during ->finalize()
Date: Thu,  7 Sep 2023 20:35:40 -0500
Message-ID: <20230908013535.990731-19-eblake@redhat.com>
In-Reply-To: <20230908013535.990731-15-eblake@redhat.com>
References: <20230908013535.990731-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Callers must clean up their coroutines before calling
object_unref(OBJECT(ioc)) to prevent an fd handler leak. Add an
assertion to check this.

This patch is preparation for the fd handler changes that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230830224802.493686-4-stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/channel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io/channel.c b/io/channel.c
index 72f0066af55..c415f3fc885 100644
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


