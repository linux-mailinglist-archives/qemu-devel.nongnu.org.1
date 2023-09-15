Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E277A1C3C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh61p-0007Av-EB; Fri, 15 Sep 2023 06:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61E-0006ce-0d
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61A-0002ix-3M
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694773536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvdAjpHKLRM6KJVPEhQMXcGpxk7oDNyqqZc9xO9fsRI=;
 b=Wpwg0iIhFVAHA8HTDF+4xr6y0h0131a6lUspsv9XnsTVvJEjxddRIsQMQpHNlhiVXpsKjk
 qu4QgCMNvJjLFxS3k9/ncVx8+3rUW+HGlfhv7p5ZmKlohYtnvlShdrMhR84q/jiPFWUJtZ
 ZxQ0ZFtmx48MSpTqZxPZJpQw9PmLE+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-5D9QpLDnNlOS8Lu-m1P-Tw-1; Fri, 15 Sep 2023 06:25:35 -0400
X-MC-Unique: 5D9QpLDnNlOS8Lu-m1P-Tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B00E0185A79C
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:25:34 +0000 (UTC)
Received: from localhost (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A25B10F1BE7;
 Fri, 15 Sep 2023 10:25:34 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH v3 1/5] vhost-user.rst: Migrating back-end-internal state
Date: Fri, 15 Sep 2023 12:25:26 +0200
Message-ID: <20230915102531.55894-2-hreitz@redhat.com>
In-Reply-To: <20230915102531.55894-1-hreitz@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

For vhost-user devices, qemu can migrate the virtio state, but not the
back-end's internal state.  To do so, we need to be able to transfer
this internal state between front-end (qemu) and back-end.

At this point, this new feature is added for the purpose of virtio-fs
migration.  Because virtiofsd's internal state will not be too large, we
believe it is best to transfer it as a single binary blob after the
streaming phase.

These are the additions to the protocol:
- New vhost-user protocol feature VHOST_USER_PROTOCOL_F_DEVICE_STATE
- SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a file
  descriptor over which to transfer the state.
- CHECK_DEVICE_STATE: After the state has been transferred through the
  file descriptor, the front-end invokes this function to verify
  success.  There is no in-band way (through the file descriptor) to
  indicate failure, so we need to check explicitly.

Once the transfer FD has been established via SET_DEVICE_STATE_FD
(which includes establishing the direction of transfer and migration
phase), the sending side writes its data into it, and the reading side
reads it until it sees an EOF.  Then, the front-end will check for
success via CHECK_DEVICE_STATE, which on the destination side includes
checking for integrity (i.e. errors during deserialization).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 170 ++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..bb4dd0fd60 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -275,6 +275,31 @@ Inflight description
 
 :queue size: a 16-bit size of virtqueues
 
+Device state transfer parameters
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++--------------------+-----------------+
+| transfer direction | migration phase |
++--------------------+-----------------+
+
+:transfer direction: a 32-bit enum, describing the direction in which
+  the state is transferred:
+
+  - 0: Save: Transfer the state from the back-end to the front-end,
+    which happens on the source side of migration
+  - 1: Load: Transfer the state from the front-end to the back-end,
+    which happens on the destination side of migration
+
+:migration phase: a 32-bit enum, describing the state in which the VM
+  guest and devices are:
+
+  - 0: Stopped (in the period after the transfer of memory-mapped
+    regions before switch-over to the destination): The VM guest and all
+    of the vhost-user device's rings are stopped.
+
+  In the future, additional phases might be added e.g. to allow
+  iterative migration while the device is running.
+
 C structure
 -----------
 
@@ -334,6 +359,7 @@ in the ancillary data:
 * ``VHOST_USER_SET_VRING_ERR``
 * ``VHOST_USER_SET_BACKEND_REQ_FD`` (previous name ``VHOST_USER_SET_SLAVE_REQ_FD``)
 * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
+* ``VHOST_USER_SET_DEVICE_STATE_FD``
 
 If *front-end* is unable to send the full message or receives a wrong
 reply it will close the connection. An optional reconnection mechanism
@@ -492,6 +518,79 @@ it performs WAKE ioctl's on the userfaultfd to wake the stalled
 back-end.  The front-end indicates support for this via the
 ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` feature.
 
+.. _migrating_backend_state:
+
+Migrating back-end state
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+Migrating device state involves transferring the state from one
+back-end, called the source, to another back-end, called the
+destination.  After migration, the destination transparently resumes
+operation without requiring the driver to re-initialize the device at
+the VIRTIO level.  If the migration fails, then the source can
+transparently resume operation until another migration attempt is made.
+
+Generally, the front-end is connected to a virtual machine guest (which
+contains the driver), which has its own state to transfer between source
+and destination, and therefore will have an implementation-specific
+mechanism to do so.  The ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature
+provides functionality to have the front-end include the back-end's
+state in this transfer operation so the back-end does not need to
+implement its own mechanism, and so the virtual machine may have its
+complete state, including vhost-user devices' states, contained within a
+single stream of data.
+
+To do this, the back-end state is transferred from back-end to front-end
+on the source side, and vice versa on the destination side.  This
+transfer happens over a channel that is negotiated using the
+``VHOST_USER_SET_DEVICE_STATE_FD`` message.  This message has two
+parameters:
+
+* Direction of transfer: On the source, the data is saved, transferring
+  it from the back-end to the front-end.  On the destination, the data
+  is loaded, transferring it from the front-end to the back-end.
+
+* Migration phase: Currently, the only supported phase is the period
+  after the transfer of memory-mapped regions before switch-over to the
+  destination, when all of the device's rings are stopped.  In the
+  future, additional phases might be supported to allow iterative
+  migration while the device is running.
+
+The nature of the channel is implementation-defined, but it must
+generally behave like a pipe: The writing end will write all the data it
+has into it, signalling the end of data by closing its end.  The reading
+end must read all of this data (until encountering the end of file) and
+process it.
+
+* When saving, the writing end is the source back-end, and the reading
+  end is the source front-end.  After reading the state data from the
+  channel, the source front-end must transfer it to the destination
+  front-end through an implementation-defined mechanism.
+
+* When loading, the writing end is the destination front-end, and the
+  reading end is the destination back-end.  After reading the state data
+  from the channel, the destination back-end must deserialize its
+  internal state from that data and set itself up to allow the driver to
+  seamlessly resume operation on the VIRTIO level.
+
+Seamlessly resuming operation means that the migration must be
+transparent to the guest driver, which operates on the VIRTIO level.
+This driver will not perform any re-initialization steps, but continue
+to use the device as if no migration had occurred.  The vhost-user
+front-end, however, will re-initialize the vhost state on the
+destination, following the usual protocol for establishing a connection
+to a vhost-user back-end: This includes, for example, setting up memory
+mappings and kick and call FDs as necessary, negotiating protocol
+features, or setting the initial vring base indices (to the same value
+as on the source side, so that operation can resume).
+
+Both on the source and on the destination side, after the respective
+front-end has seen all data transferred (when the transfer FD has been
+closed), it sends the ``VHOST_USER_CHECK_DEVICE_STATE`` message to
+verify that data transfer was successful in the back-end, too.  The
+back-end responds once it knows whether the transfer and processing was
+successful or not.
+
 Memory access
 -------------
 
@@ -885,6 +984,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         18
 
 Front-end message types
 -----------------------
@@ -1440,6 +1540,76 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_SET_DEVICE_STATE_FD``
+  :id: 41
+  :equivalent ioctl: N/A
+  :request payload: device state transfer parameters
+  :reply payload: ``u64``
+
+  Front-end and back-end negotiate a channel over which to transfer the
+  back-end’s internal state during migration.  Either side (front-end or
+  back-end) may create the channel.  The nature of this channel is not
+  restricted or defined in this document, but whichever side creates it
+  must create a file descriptor that is provided to the respectively
+  other side, allowing access to the channel.  This FD must behave as
+  follows:
+
+  * For the writing end, it must allow writing the whole back-end state
+    sequentially.  Closing the file descriptor signals the end of
+    transfer.
+
+  * For the reading end, it must allow reading the whole back-end state
+    sequentially.  The end of file signals the end of the transfer.
+
+  For example, the channel may be a pipe, in which case the two ends of
+  the pipe fulfill these requirements respectively.
+
+  Initially, the front-end creates a channel along with such an FD.  It
+  passes the FD to the back-end as ancillary data of a
+  ``VHOST_USER_SET_DEVICE_STATE_FD`` message.  The back-end may create a
+  different transfer channel, passing the respective FD back to the
+  front-end as ancillary data of the reply.  If so, the front-end must
+  then discard its channel and use the one provided by the back-end.
+
+  Whether the back-end should decide to use its own channel is decided
+  based on efficiency: If the channel is a pipe, both ends will most
+  likely need to copy data into and out of it.  Any channel that allows
+  for more efficient processing on at least one end, e.g. through
+  zero-copy, is considered more efficient and thus preferred.  If the
+  back-end can provide such a channel, it should decide to use it.
+
+  The request payload contains parameters for the subsequent data
+  transfer, as described in the :ref:`Migrating back-end state
+  <migrating_backend_state>` section.
+
+  The value returned is both an indication for success, and whether a
+  file descriptor for a back-end-provided channel is returned: Bits 0–7
+  are 0 on success, and non-zero on error.  Bit 8 is the invalid FD
+  flag; this flag is set when there is no file descriptor returned.
+  When this flag is not set, the front-end must use the returned file
+  descriptor as its end of the transfer channel.  The back-end must not
+  both indicate an error and return a file descriptor.
+
+  Using this function requires prior negotiation of the
+  ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
+
+``VHOST_USER_CHECK_DEVICE_STATE``
+  :id: 42
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
+  ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
+
 
 Back-end message types
 ----------------------
-- 
2.41.0


