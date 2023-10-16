Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7567CAA13
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNs8-0001N9-Dh; Mon, 16 Oct 2023 09:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsNs5-0001Mn-QK
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsNs4-0003Jk-6r
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697463777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F2NRDtnlS27s6qPB8NEudILgbl4Ag/jfADhYolTR8s=;
 b=ItyZxzsP34N+I6/hrsS2B2uIsYUXJbxRbc064yJVRDqPj4hOvz5uVFEw5C+3oES+V/Uj0m
 i48n5EsMXl3ZQy4XeTP0KaNzzfvXXtVQqIhuB//JGf6j0bz2QsHxAhB1apqYOw6BA1+aU7
 luVE63PjCaIJWpgiLvDu4hRR3QNhXQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-zwe7-iuuNceyVetPM6t9lg-1; Mon, 16 Oct 2023 09:42:51 -0400
X-MC-Unique: zwe7-iuuNceyVetPM6t9lg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1072182D3CE;
 Mon, 16 Oct 2023 13:42:50 +0000 (UTC)
Received: from localhost (unknown [10.39.192.211])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13F362022780;
 Mon, 16 Oct 2023 13:42:49 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: [PATCH v5 2/7] vhost-user.rst: Clarify enabling/disabling vrings
Date: Mon, 16 Oct 2023 15:42:38 +0200
Message-ID: <20231016134243.68248-3-hreitz@redhat.com>
In-Reply-To: <20231016134243.68248-1-hreitz@redhat.com>
References: <20231016134243.68248-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

Currently, the vhost-user documentation says that rings are to be
initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
negotiated.  However, by the time of feature negotiation, all rings have
already been initialized, so it is not entirely clear what this means.

At least the vhost-user-backend Rust crate's implementation interpreted
it to mean that whenever this feature is negotiated, all rings are to
put into a disabled state, which means that every SET_FEATURES call
would disable all rings, effectively halting the device.  This is
problematic because the VHOST_F_LOG_ALL feature is also set or cleared
this way, which happens during migration.  Doing so should not halt the
device.

Other implementations have interpreted this to mean that the device is
to be initialized with all rings disabled, and a subsequent SET_FEATURES
call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
them.  Here, SET_FEATURES will never disable any ring.

This interpretation does not suffer the problem of unintentionally
halting the device whenever features are set or cleared, so it seems
better and more reasonable.

We can clarify this in the documentation by making it explicit that the
enabled/disabled state is tracked even while the vring is stopped.
Every vring is initialized in a disabled state, and SET_FEATURES without
VHOST_USER_F_PROTOCOL_FEATURES simply becomes one way to enable all
vrings.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 9202b167dd..e5a04c04ed 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -411,31 +411,33 @@ negotiation.
 Ring states
 -----------
 
-Rings can be in one of three states:
+Rings have two independent states: started/stopped, and enabled/disabled.
 
-* stopped: the back-end must not process the ring at all.
+* While a ring is stopped, the back-end must not process the ring at
+  all, regardless of whether it is enabled or disabled.  The
+  enabled/disabled state should still be tracked, though, so it can come
+  into effect once the ring is started.
 
-* started but disabled: the back-end must process the ring without
+* started and disabled: The back-end must process the ring without
   causing any side effects.  For example, for a networking device,
   in the disabled state the back-end must not supply any new RX packets,
   but must process and discard any TX packets.
 
-* started and enabled.
+* started and enabled: The back-end must process the ring normally, i.e.
+  process all requests and execute them.
 
-Each ring is initialized in a stopped state.  The back-end must start
-ring upon receiving a kick (that is, detecting that file descriptor is
-readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK``
-or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated,
-and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
+Each ring is initialized in a stopped and disabled state.  The back-end
+must start a ring upon receiving a kick (that is, detecting that file
+descriptor is readable) on the descriptor specified by
+``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
+``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
+``VHOST_USER_GET_VRING_BASE``.
 
 Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
 
-If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
-ring starts directly in the enabled state.
-
-If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
-initialized in a disabled state and is enabled by
-``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
+In addition, upon receiving a ``VHOST_USER_SET_FEATURES`` message from
+the front-end without ``VHOST_USER_F_PROTOCOL_FEATURES`` set, the
+back-end must enable all rings immediately.
 
 While processing the rings (whether they are enabled or not), the back-end
 must support changing some configuration aspects on the fly.
-- 
2.41.0


