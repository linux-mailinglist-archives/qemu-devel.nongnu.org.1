Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CFC07047
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 17:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJuS-0008Gl-7h; Fri, 24 Oct 2025 11:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuH-0008FG-Ve
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuG-0003O8-EE
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761320443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JQXhF8o3AXpEzb21LKwdmGdvdb2hFy8yKFZ6fAIr70=;
 b=blRxVl2tEDoJTSQftTFqOp7oVgHoONIh0i4t9TquwEwqe27hgrRNCfKuVmWkD282Mmv0o/
 Lb4oOP1O1xC/cyRP5a464B7srH4Xin7K+dvW5ep1QafjPYEL5EYMv9OMcediwIu+61exBm
 FqduEonW9R+PoU0U/p9Xgx0I/I1E7r4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-NACc-t7gN4ir9ttV2Xhbjw-1; Fri,
 24 Oct 2025 11:40:41 -0400
X-MC-Unique: NACc-t7gN4ir9ttV2Xhbjw-1
X-Mimecast-MFC-AGG-ID: NACc-t7gN4ir9ttV2Xhbjw_1761320440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5767C18009C0; Fri, 24 Oct 2025 15:40:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F12C19540EB; Fri, 24 Oct 2025 15:40:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 05/13] io: move websock resource release to close method
Date: Fri, 24 Oct 2025 16:40:16 +0100
Message-ID: <20251024154024.227978-6-berrange@redhat.com>
In-Reply-To: <20251024154024.227978-1-berrange@redhat.com>
References: <20251024154024.227978-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QIOChannelWebsock object releases all its resources in the
finalize callback. This is later than desired, as callers expect
to be able to call qio_channel_close() to fully close a channel
and release resources related to I/O.

The logic in the finalize method is at most a failsafe to handle
cases where a consumer forgets to call qio_channel_close.

This adds equivalent logic to the close method to release the
resources, using g_clear_handle_id/g_clear_pointer to be robust
against repeated invocations. The finalize method is tweaked
so that the GSource is removed before releasing the underlying
channel.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 0a8c5c4712..a50a160e18 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -922,13 +922,13 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
-    object_unref(OBJECT(ioc->master));
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
     }
     if (ioc->io_err) {
         error_free(ioc->io_err);
     }
+    object_unref(OBJECT(ioc->master));
 }
 
 
@@ -1218,6 +1218,15 @@ static int qio_channel_websock_close(QIOChannel *ioc,
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
 
     trace_qio_channel_websock_close(ioc);
+    buffer_free(&wioc->encinput);
+    buffer_free(&wioc->encoutput);
+    buffer_free(&wioc->rawinput);
+    if (wioc->io_tag) {
+        g_clear_handle_id(&wioc->io_tag, g_source_remove);
+    }
+    if (wioc->io_err) {
+        g_clear_pointer(&wioc->io_err, error_free);
+    }
     return qio_channel_close(wioc->master, errp);
 }
 
-- 
2.50.1


