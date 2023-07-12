Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD17502AA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 11:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJVyD-0007pc-LE; Wed, 12 Jul 2023 05:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJVyB-0007o7-U7
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 05:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJVyA-0003aO-Cb
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 05:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689153427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w/kBTzdJ4GcIyvsYK2oLo+LlPMQF1Cd3QatUllqac0o=;
 b=J9aXVueY2VHadyuDd2myJYCKiqyq0S7eSxwCg2A+dR9oVgQVI44FnYrxGj8x7oZGjgyeT2
 lhxVxp3DY12ZpjnKOvFssrsHR1+lrRDK4mOpFan7loewNVfyUQGgq8V+GsfFoeIISIQ1BA
 dAeK0672uUbiQAV0TBgPR0EBnEzlKlY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-_uDaMlx5OLeHGTU0F8UntQ-1; Wed, 12 Jul 2023 05:17:06 -0400
X-MC-Unique: _uDaMlx5OLeHGTU0F8UntQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1395380391A
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:17:05 +0000 (UTC)
Received: from localhost (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71BF140C2063;
 Wed, 12 Jul 2023 09:17:05 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH] vhost-user.rst: Clarify enabling/disabling vrings
Date: Wed, 12 Jul 2023 11:17:04 +0200
Message-ID: <20230712091704.15589-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently, the vhost-user documentation says that rings are to be
initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
negotiated.  However, by the time of feature negotiation, all rings have
already been initialized, so it is not entirely clear what this means.

At least the vhost-user-backend Rust crate's implementation interpreted
it to mean that whenever this feature is negotiated, all rings are to be
put into a disabled state, which means that every SET_FEATURES call
would disable all rings, effectively halting the device.  This is
problematic because the VHOST_F_LOG_ALL feature is also set or cleared
this way, which happens during migration.  Doing so should not halt the
device.

Other implementations have interpreted this to mean that the device is
to be initialized with all rings disabled, and a subsequent SET_FEATURES
call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
them.  Here, SET_FEATURES will never disable any ring.

This other interpretation does not suffer the problem of unintentionally
halting the device whenever features are set or cleared, so it seems
better and more reasonable.

We should clarify this in the documentation.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..ca0e899765 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -383,12 +383,23 @@ and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
 
 Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
 
-If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
-ring starts directly in the enabled state.
-
-If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
-initialized in a disabled state and is enabled by
-``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
+Between initialization and the first ``VHOST_USER_SET_FEATURES`` call, it
+is implementation-defined whether each ring is enabled or disabled.
+
+If ``VHOST_USER_SET_FEATURES`` does not negotiate
+``VHOST_USER_F_PROTOCOL_FEATURES``, each ring, when started, will be
+enabled immediately.
+
+If ``VHOST_USER_SET_FEATURES`` does negotiate
+``VHOST_USER_F_PROTOCOL_FEATURES``, each ring will remain in the disabled
+state until ``VHOST_USER_SET_VRING_ENABLE`` enables it with parameter 1.
+
+Back-end implementations that support ``VHOST_USER_F_PROTOCOL_FEATURES``
+should implement this by initializing each ring in a disabled state, and
+enabling them when ``VHOST_USER_SET_FEATURES`` is used without
+negotiating ``VHOST_USER_F_PROTOCOL_FEATURES``.  Other than that, rings
+should only be enabled and disabled through
+``VHOST_USER_SET_VRING_ENABLE``.
 
 While processing the rings (whether they are enabled or not), the back-end
 must support changing some configuration aspects on the fly.
-- 
2.41.0


