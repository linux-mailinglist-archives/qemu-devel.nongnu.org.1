Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8D7B8016
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1TI-0002Py-TJ; Wed, 04 Oct 2023 08:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo1TG-0002KU-33
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo1TD-0003me-8G
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXjHczww1Fcy+41Czk6ROan7GaHG+yPpiPMzOAvIP14=;
 b=Z2o34Atk67YKXnyzTqXl5kWQG4HgvTcETP5yEvnj6DMo9C+bJyZ1+NhYwa8/QX2AU1z3mB
 l3Lnq4j2JAwmWSNR0c8z66JKR+oM8I42WUQzQKNrkGA3KKTfDsx7gXOo8oTBAIwUbj/pJC
 lA00b33+CqKpN3Y8XhyOelg3n7C7cw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-LpREXDyxOLSOhNYEyXagxg-1; Wed, 04 Oct 2023 08:59:09 -0400
X-MC-Unique: LpREXDyxOLSOhNYEyXagxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 907561875045;
 Wed,  4 Oct 2023 12:59:09 +0000 (UTC)
Received: from localhost (unknown [10.39.194.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B7E2026D4B;
 Wed,  4 Oct 2023 12:59:08 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: [PATCH v4 1/8] vhost-user.rst: Deprecate [GS]ET_STATUS
Date: Wed,  4 Oct 2023 14:58:57 +0200
Message-ID: <20231004125904.110781-2-hreitz@redhat.com>
In-Reply-To: <20231004125904.110781-1-hreitz@redhat.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
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

There is no clearly defined purpose for the virtio status byte in
vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
protocol extension, it is possible for SET_FEATURES to return errors
(SET_PROTOCOL_FEATURES may be called before SET_FEATURES).

As for implementations, SET_STATUS is not widely implemented.  dpdk does
implement it, but only uses it to signal feature negotiation failure.
While it does log reset requests (SET_STATUS 0) as such, it effectively
ignores them, in contrast to RESET_OWNER (which is deprecated, and today
means the same thing as RESET_DEVICE).

While qemu superficially has support for [GS]ET_STATUS, it does not
forward the guest-set status byte, but instead just makes it up
internally, and actually completely ignores what the back-end returns,
only using it as the template for a subsequent SET_STATUS to add single
bits to it.  Notably, after setting FEATURES_OK, it never reads it back
to see whether the flag is still set, which is the only way in which
dpdk uses the status byte.

As-is, no front-end or back-end can rely on the other side handling this
field in a useful manner, and it also provides no practical use over
other mechanisms the vhost-user protocol has, which are more clearly
defined.  Deprecate it.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..2f68e67a1a 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1424,21 +1424,35 @@ Front-end message types
   :request payload: ``u64``
   :reply payload: N/A
 
-  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
-  successfully negotiated, this message is submitted by the front-end to
-  notify the back-end with updated device status as defined in the Virtio
+.. admonition:: Deprecated
+
+  This is no longer used. Used to be sent by the front-end to notify the
+  back-end with updated device status as defined in the Virtio
   specification.
 
+  However, its purpose in vhost-user was never well-defined; for
+  example, how or if it would replace VHOST_USER_RESET_DEVICE, or how it
+  integrates with the feature negotiation phase.  Therefore,
+  implementations in practice were less than strict in how the status
+  value was handled, which means there was actually no protocol between
+  front-end and back-end on the use of the status value.
+
+  For resetting, use VHOST_USER_RESET_DEVICE instead.  For feature
+  negotiation with acknowledgment from the device, use
+  VHOST_USER_SET_FEATURES with the :ref:`REPLY_ACK <reply_ack>` feature
+  instead.
+
 ``VHOST_USER_GET_STATUS``
   :id: 40
   :equivalent ioctl: VHOST_VDPA_GET_STATUS
   :request payload: N/A
   :reply payload: ``u64``
 
-  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
-  successfully negotiated, this message is submitted by the front-end to
-  query the back-end for its device status as defined in the Virtio
-  specification.
+.. admonition:: Deprecated
+
+  This is no longer used. Used to be sent by the front-end to query the
+  back-end for its device status as defined in the Virtio specification.
+  Deprecated together with VHOST_USER_SET_STATUS.
 
 
 Back-end message types
-- 
2.41.0


