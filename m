Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601292E91C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 15:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtet-00013w-Op; Thu, 11 Jul 2024 09:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sRteZ-00010h-Hk
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sRteU-00042k-Ai
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720703760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEk4OtE25Fd9lpp+USlXkkamxB+IU5h870RrJfWV3sw=;
 b=V3xdk1qUyZnbHFRMiLELJ49N7xHinRXEdqv2HqfQ/POazoPUrviT33ji2oGrIgwpk/7XvE
 q1E1kAatuleKediCL2GuMns7OAGAxy8Q2rwKAwkvnrfrgkxJtDxUpMPK7fcLhQwIJmXB77
 KDjxP/evrD6LCRRYEZSWXTL8ltRTr+A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-xHTOZs5XPm6aIEKV5FvQTw-1; Thu,
 11 Jul 2024 09:14:40 -0400
X-MC-Unique: xHTOZs5XPm6aIEKV5FvQTw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47AD31958B0C; Thu, 11 Jul 2024 13:14:38 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.85])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB6111955E9F; Thu, 11 Jul 2024 13:14:31 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 0/2] Postcopy migration and vhost-user errors
Date: Thu, 11 Jul 2024 18:44:22 +0530
Message-ID: <20240711131424.181615-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Hello,

* virsh(1) offers multiple options to initiate Postcopy migration:

    1) virsh migrate --postcopy --postcopy-after-precopy
    2) virsh migrate --postcopy + virsh migrate-postcopy
    3) virsh migrate --postcopy --timeout <N> --timeout-postcopy

When Postcopy migration is invoked via method (2) or (3) above,
the guest on the destination host seems to hang or get stuck sometimes.

* During Postcopy migration, multiple threads are spawned on the destination
host to start the guest and setup devices. One such thread starts vhost
device via vhost_dev_start() function and another called fault_thread handles
page faults in user space using kernel's userfaultfd(2) system.

When fault_thread exits upon completion of Postcopy migration, it sends a
'postcopy_end' message to the vhost-user device. But sometimes 'postcopy_end'
message is sent while vhost device is being setup via vhost_dev_start().

     Thread-1                                  Thread-2

vhost_dev_start                        postcopy_ram_incoming_cleanup
 vhost_device_iotlb_miss                postcopy_notify
  vhost_backend_update_device_iotlb      vhost_user_postcopy_notifier
   vhost_user_send_device_iotlb_msg       vhost_user_postcopy_end
    process_message_reply                  process_message_reply
     vhost_user_read                        vhost_user_read
      vhost_user_read_header                 vhost_user_read_header
       "Fail to update device iotlb"          "Failed to receive reply to postcopy_end"

This creates confusion when vhost device receives 'postcopy_end' message while
it is still trying to update IOTLB entries.

This seems to leave the guest in a stranded/hung state because fault_thread
has exited saying Postcopy migration has ended, but vhost-device is probably
still expecting updates. QEMU logs following errors on the destination host
===
...
qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
qemu-kvm: vhost_user_postcopy_end: 700871,700900: Failed to receive reply to postcopy_end
qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x8 instead of 0x5.
qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x16 instead of 0x5.
qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
qemu-kvm: vhost_user_read_header: 700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
qemu-kvm: vhost_device_iotlb_miss: 700871,700871: Fail to update device iotlb
===

* Couple of patches here help to fix/handle these errors.

Thank you.
---
Prasad Pandit (2):
  vhost-user: add a write-read lock
  vhost: fail device start if iotlb update fails

 hw/virtio/vhost-user.c         | 423 +++++++++++++++++++--------------
 hw/virtio/vhost.c              |   6 +-
 include/hw/virtio/vhost-user.h |   3 +
 3 files changed, 259 insertions(+), 173 deletions(-)

--
2.45.2


