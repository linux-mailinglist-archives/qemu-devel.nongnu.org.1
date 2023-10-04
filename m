Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076F7B8014
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1TK-0002Qu-76; Wed, 04 Oct 2023 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo1TH-0002Ou-SA
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo1TF-0003mw-8I
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQ8aGLKSDdJr2DxXlf7NmH/QfRIonMavGxc1ULxd56E=;
 b=HeHeO/mL+GBi8bazUoYkEZ9nTDNCkiwxJGjvHfEMo5DLKzBKgU2u7fboyGHVY88VYusWTg
 VfpHxDPLm9umiZqB2OvjBkBNltTswA4RdAV88Ty8N1su5XP2YFMLHpLmR7QioGg8sF9Ccc
 6NkBBdFM/7Ng6XiAHjYsFAV0AARnmLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-WoklyCWLNN6zLHZV7jq1Sw-1; Wed, 04 Oct 2023 08:59:16 -0400
X-MC-Unique: WoklyCWLNN6zLHZV7jq1Sw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C41D7185A78E;
 Wed,  4 Oct 2023 12:59:15 +0000 (UTC)
Received: from localhost (unknown [10.39.194.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 527914026FC;
 Wed,  4 Oct 2023 12:59:15 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: [PATCH v4 4/8] vhost-user.rst: Introduce suspended state
Date: Wed,  4 Oct 2023 14:59:00 +0200
Message-ID: <20231004125904.110781-5-hreitz@redhat.com>
In-Reply-To: <20231004125904.110781-1-hreitz@redhat.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

In vDPA, GET_VRING_BASE does not stop the queried vring, which is why
SUSPEND was introduced so that the returned index would be stable.  In
vhost-user, it does stop the vring, so under the same reasoning, it can
get away without SUSPEND.

Still, we do want to clarify that if the device is completely stopped,
i.e. all vrings are stopped, the back-end should cease to modify any
state relating to the guest.  Do this by calling it "suspended".

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/interop/vhost-user.rst | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 9f4940a036..d282155562 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -426,6 +426,19 @@ back-end must enable all rings immediately.
 While processing the rings (whether they are enabled or not), the back-end
 must support changing some configuration aspects on the fly.
 
+.. _suspended_device_state:
+
+Suspended device state
+^^^^^^^^^^^^^^^^^^^^^^
+
+While all vrings are stopped, the device is *suspended*.  In addition to
+not processing any vring (because they are stopped), the device must:
+
+* not write to any guest memory regions,
+* not send any notifications to the guest,
+* not send any messages to the front-end,
+* still process and reply to messages from the front-end.
+
 Multiple queue support
 ----------------------
 
@@ -513,7 +526,8 @@ ancillary data, it may be used to inform the front-end that the log has
 been modified.
 
 Once the source has finished migration, rings will be stopped by the
-source. No further update must be done before rings are restarted.
+source (:ref:`Suspended device state <suspended_device_state>`). No
+further update must be done before rings are restarted.
 
 In postcopy migration the back-end is started before all the memory has
 been received from the source host, and care must be taken to avoid
@@ -1101,6 +1115,10 @@ Front-end message types
   (*a vring descriptor index for split virtqueues* vs. *vring descriptor
   indices for packed virtqueues*).
 
+  When and as long as all of a device’s vrings are stopped, it is
+  *suspended*, see :ref:`Suspended device state
+  <suspended_device_state>`.
+
   The request payload’s *num* field is currently reserved and must be
   set to 0.
 
-- 
2.41.0


