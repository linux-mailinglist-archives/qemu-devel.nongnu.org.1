Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E0750747
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXqM-0003Fi-Tz; Wed, 12 Jul 2023 07:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXqL-0003F6-2E
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJXqJ-0002zv-Da
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689160630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnrLkRMOkuC7p3z2QlwIhHUferjPvBkeXqWRW4xF8o8=;
 b=YVcA2p6PYHMjK/iwtk+EN6WP8yl/nntJtQRxKr9BWYVd6881LIn+0v0AvlDjA/6o2Or2qP
 itqMly5fdrbLYzMguZiageHLVlkdKPACVzaWhUXWm07acSE/1mpocH1/WlC/uY2jFGixRW
 1TcsMGngJOsr2SVe1Tc8qp0gnHBLem0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-dyzPPG8CMueRyfZ-4iqo7Q-1; Wed, 12 Jul 2023 07:17:07 -0400
X-MC-Unique: dyzPPG8CMueRyfZ-4iqo7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA721800CAC
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 11:17:06 +0000 (UTC)
Received: from localhost (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49CCBC1ED97;
 Wed, 12 Jul 2023 11:17:06 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 1/4] vhost-user.rst: Migrating back-end-internal state
Date: Wed, 12 Jul 2023 13:16:59 +0200
Message-ID: <20230712111703.28031-2-hreitz@redhat.com>
In-Reply-To: <20230712111703.28031-1-hreitz@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

For vhost-user devices, qemu can migrate the virtio state, but not the
back-end's internal state.  To do so, we need to be able to transfer
this internal state between front-end (qemu) and back-end.

At this point, this new feature is added for the purpose of virtio-fs
migration.  Because virtiofsd's internal state will not be too large, we
believe it is best to transfer it as a single binary blob after the
streaming phase.

These are the additions to the protocol:
- New vhost-user protocol feature VHOST_USER_PROTOCOL_F_MIGRATORY_STATE
- SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a pipe
  over which to transfer the state.
- CHECK_DEVICE_STATE: After the state has been transferred through the
  pipe, the front-end invokes this function to verify success.  There is
  no in-band way (through the pipe) to indicate failure, so we need to
  check explicitly.

Once the transfer pipe has been established via SET_DEVICE_STATE_FD
(which includes establishing the direction of transfer and migration
phase), the sending side writes its data into the pipe, and the reading
side reads it until it sees an EOF.  Then, the front-end will check for
success via CHECK_DEVICE_STATE, which on the destination side includes
checking for integrity (i.e. errors during deserialization).

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 87 +++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ac6be34c4c..c98dfeca25 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -334,6 +334,7 @@ in the ancillary data:
 * ``VHOST_USER_SET_VRING_ERR``
 * ``VHOST_USER_SET_BACKEND_REQ_FD`` (previous name ``VHOST_USER_SET_SLAVE_REQ_FD``)
 * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
+* ``VHOST_USER_SET_DEVICE_STATE_FD``
 
 If *front-end* is unable to send the full message or receives a wrong
 reply it will close the connection. An optional reconnection mechanism
@@ -497,6 +498,44 @@ it performs WAKE ioctl's on the userfaultfd to wake the stalled
 back-end.  The front-end indicates support for this via the
 ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` feature.
 
+.. _migrating_backend_state:
+
+Migrating back-end state
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+If the back-end has internal state that is to be sent from source to
+destination, the front-end may be able to store and transfer it via an
+internal migration stream.  Support for this is negotiated with the
+``VHOST_USER_PROTOCOL_F_MIGRATORY_STATE`` feature.
+
+First, a channel over which the state is transferred is established on
+the source side using the ``VHOST_USER_SET_DEVICE_STATE_FD`` message.
+This message has two parameters:
+
+* Direction of transfer: On the source, the data is saved, transferring
+  it from the back-end to the front-end.  On the destination, the data
+  is loaded, transferring it from the front-end to the back-end.
+
+* Migration phase: Currently, only the period after memory transfer
+  before switch-over is supported, in which the device is suspended and
+  all of its rings are stopped.
+
+Then, the writing end will write all the data it has, signalling the end
+of data by closing its end of the pipe.  The reading end must read all
+of this data and process it:
+
+* If saving, the front-end will transfer this data to the destination,
+  where it is loaded into the destination back-end.
+
+* If loading, the back-end must deserialize its internal state from the
+  transferred data and be set up to resume operation.
+
+After the front-end has seen all data transferred (saving: seen an EOF
+on the pipe; loading: closed its end of the pipe), it sends the
+``VHOST_USER_CHECK_DEVICE_STATE`` message to verify that data transfer
+was successful in the back-end, too.  The back-end responds once it
+knows whether the tranfer and processing was successful or not.
+
 Memory access
 -------------
 
@@ -891,6 +930,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
   #define VHOST_USER_PROTOCOL_F_SUSPEND              18
+  #define VHOST_USER_PROTOCOL_F_MIGRATORY_STATE      19
 
 Front-end message types
 -----------------------
@@ -1471,6 +1511,53 @@ Front-end message types
   before.  The back-end must again begin processing rings that are not
   stopped, and it may resume background operations.
 
+``VHOST_USER_SET_DEVICE_STATE_FD``
+  :id: 43
+  :equivalent ioctl: N/A
+  :request payload: device state transfer parameters
+  :reply payload: ``u64``
+
+  The front-end negotiates a pipe over which to transfer the back-end’s
+  internal state during migration.  For this purpose, this message is
+  accompanied by a file descriptor that is to be the back-end’s end of
+  the pipe.  If the back-end can provide a more efficient pipe (i.e.
+  because it internally already has a pipe into/from which to
+  put/receive state), it can ignore this and reply with a different file
+  descriptor to serve as the front-end’s end.
+
+  The request payload contains parameters for the subsequent data
+  transfer, as described in the :ref:`Migrating back-end state
+  <migrating_backend_state>` section.  That section also explains the
+  data transfer itself.
+
+  The value returned is both an indication for success, and whether a
+  new pipe file descriptor is returned: Bits 0–7 are 0 on success, and
+  non-zero on error.  Bit 8 is the invalid FD flag; this flag is set
+  when there is no file descriptor returned.  When this flag is not set,
+  the front-end must use the returned file descriptor as its end of the
+  pipe.  The back-end must not both indicate an error and return a file
+  descriptor.
+
+  Using this function requires prior negotiation of the
+  ``VHOST_USER_PROTOCOL_F_MIGRATORY_STATE`` feature.
+
+``VHOST_USER_CHECK_DEVICE_STATE``
+  :id: 44
+  :equivalent ioctl: N/A
+  :request payload: N/A
+  :reply payload: ``u64``
+
+  After transferring the back-end’s internal state during migration (see
+  the :ref:`Migrating back-end state <migrating_backend_state>`
+  section), check whether the back-end was able to successfully fully
+  process the state.
+
+  The value returned indicates success or error; 0 is success, any
+  non-zero value is an error.
+
+  Using this function requires prior negotiation of the
+  ``VHOST_USER_PROTOCOL_F_MIGRATORY_STATE`` feature.
+
 
 Back-end message types
 ----------------------
-- 
2.41.0


