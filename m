Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5374F418
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFfO-0000cq-12; Tue, 11 Jul 2023 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfL-0000cb-UK
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfK-0001h6-BN
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689090757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyoQ/2+6R/ip2NcA77dLWUg2JHvuG7jjdTygBaSGwm4=;
 b=WD44CszwUPT6dZsjGEB8LXxNOUO+yVC45eHRSuQfgLBZt3lbhGJ+eHhmkpEGPkpjgpGqVN
 vehzeGLvnEH8HPKjN9lvQtMGKkUxBHuglVA2la1NcQITMsPY5BPjbn2+FINcUf8lKSN6C5
 naLZPICxREi8DzS7tICwFsuy1skfZs0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-D6zZoyUDNSKRNtrEQlljew-1; Tue, 11 Jul 2023 11:52:35 -0400
X-MC-Unique: D6zZoyUDNSKRNtrEQlljew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 207A53814950
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 15:52:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC450C09A09;
 Tue, 11 Jul 2023 15:52:34 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH 1/6] vhost-user.rst: Add suspend/resume
Date: Tue, 11 Jul 2023 17:52:23 +0200
Message-ID: <20230711155230.64277-2-hreitz@redhat.com>
In-Reply-To: <20230711155230.64277-1-hreitz@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
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

When stopping the VM, qemu wants all devices to fully cease any
operation, too.  Currently, we can only have vhost-user back-ends stop
processing vrings, but not background operations.  Add the SUSPEND and
RESUME commands from vDPA, which allow the front-end (qemu) to tell
back-ends to cease all operations, including those running in the
background.

qemu's current work-around for this is to reset the back-end instead of
suspending it, which will not work for back-ends that have internal
state that must be preserved across e.g. stop/cont.

Note that the given specification requires the back-end to delay
processing kicks (i.e. starting vrings) until the device is resumed,
instead of requiring the front-end not to send kicks while suspended.
qemu starts devices (and would just resume them) only when the VM is in
a running state, so it would be difficult to have qemu delay kicks until
the device is resumed, which is why this patch specifies handling of
kicks as it does.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..ac6be34c4c 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -381,6 +381,10 @@ readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK``
 or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated,
 and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
 
+While the back-end is suspended (via ``VHOST_USER_SUSPEND``), it must
+never process rings, and thus also delay handling kicks until the
+back-end is resumed again.
+
 Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
 
 If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
@@ -479,8 +483,9 @@ supplied by ``VhostUserLog``.
 ancillary data, it may be used to inform the front-end that the log has
 been modified.
 
-Once the source has finished migration, rings will be stopped by the
-source. No further update must be done before rings are restarted.
+Once the source has finished migration, the device will be suspended and
+its rings will be stopped by the source. No further update must be done
+before the device and its rings are resumed.
 
 In postcopy migration the back-end is started before all the memory has
 been received from the source host, and care must be taken to avoid
@@ -885,6 +890,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_SUSPEND              18
 
 Front-end message types
 -----------------------
@@ -1440,6 +1446,31 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_SUSPEND``
+  :id: 41
+  :equivalent ioctl: VHOST_VDPA_SUSPEND
+  :request payload: N/A
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  have the back-end cease all operations except for handling vhost-user
+  requests.  The back-end must stop processing all virt queues, and it
+  must not perform any background operations.  It may not resume until a
+  subsequent ``VHOST_USER_RESUME`` call.
+
+``VHOST_USER_RESUME``
+  :id: 42
+  :equivalent ioctl: VHOST_VDPA_RESUME
+  :request payload: N/A
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  allow the back-end to resume operations after having been suspended
+  before.  The back-end must again begin processing rings that are not
+  stopped, and it may resume background operations.
+
 
 Back-end message types
 ----------------------
-- 
2.41.0


