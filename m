Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A565F829895
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNWZT-0002TK-9u; Wed, 10 Jan 2024 06:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNWZO-0002Sm-Am
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNWZK-0007DO-7X
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704885378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FatmM11H2ghu0TlvUuzLuqYcUQeSbN+gLazcNYg7brQ=;
 b=OxzZICzDSruRhURE2dX/We5VR8Fu5Zq3H5loCJDBmez4GK66piu7x0xIukgNuHY88y27t+
 FtoWv3hfCqwmYAHDYZXKFRbh5A6biiCFE2gf7fNPK6p+Au3yuXe9VkIh4L1m1b8kScHdNc
 +82qtbIEraFPuul0vvuQbXC7yjM0wC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-JhJ1LvPyNZOUn9QBEoFA0w-1; Wed, 10 Jan 2024 06:16:17 -0500
X-MC-Unique: JhJ1LvPyNZOUn9QBEoFA0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE522101A52A
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:16:16 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 355B651E3;
 Wed, 10 Jan 2024 11:16:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] io: add trace event when cancelling TLS handshake
Date: Wed, 10 Jan 2024 11:16:15 +0000
Message-ID: <20240110111615.28004-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-tls.c | 1 +
 io/trace-events  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 58fe1aceee..1d9c9c72bf 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -381,6 +381,7 @@ static int qio_channel_tls_close(QIOChannel *ioc,
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
 
     if (tioc->hs_ioc_tag) {
+        trace_qio_channel_tls_handshake_cancel(ioc);
         g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
     }
 
diff --git a/io/trace-events b/io/trace-events
index 3cc5cf1efd..d4c0f84a9a 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -43,6 +43,7 @@ qio_channel_tls_handshake_start(void *ioc) "TLS handshake start ioc=%p"
 qio_channel_tls_handshake_pending(void *ioc, int status) "TLS handshake pending ioc=%p status=%d"
 qio_channel_tls_handshake_fail(void *ioc) "TLS handshake fail ioc=%p"
 qio_channel_tls_handshake_complete(void *ioc) "TLS handshake complete ioc=%p"
+qio_channel_tls_handshake_cancel(void *ioc) "TLS handshake cancel ioc=%p"
 qio_channel_tls_credentials_allow(void *ioc) "TLS credentials allow ioc=%p"
 qio_channel_tls_credentials_deny(void *ioc) "TLS credentials deny ioc=%p"
 
-- 
2.43.0


