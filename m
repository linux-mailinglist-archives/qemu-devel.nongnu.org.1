Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E175ABB4
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 12:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMQdR-0005ty-1q; Thu, 20 Jul 2023 06:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMQdO-0005tb-FY
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qMQdL-0003G4-7d
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689847902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WqfkmSyWnDQU2/6c1pdN2UIfeioEsf6dih3XT6KfH80=;
 b=gglCK61U/d0CPz2sERYRGyx1icU3Tb6XAlNCX2vB90rzWTUZtn6+pguQaO2piRqrTkZFvN
 MNERM+f+Q7Yh1cuy+9lvwUvn4Flfdzfqv9LiSj+w02UkfDCJiGIOdeXYQ4IXzyGnGnTNm7
 mNcVmyUlU61NZDfNVMqRVaqb6vvEAdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-peeCB3hLPn-w-xpIUdtzqA-1; Thu, 20 Jul 2023 06:11:41 -0400
X-MC-Unique: peeCB3hLPn-w-xpIUdtzqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6A9C185A795;
 Thu, 20 Jul 2023 10:11:40 +0000 (UTC)
Received: from nuthatch.redhat.com (unknown [10.45.225.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42016492CAC;
 Thu, 20 Jul 2023 10:11:33 +0000 (UTC)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] hw/virtio: Add a protection against duplicate vu_scmi_stop
 calls
Date: Thu, 20 Jul 2023 12:10:37 +0200
Message-Id: <20230720101037.2161450-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
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

The QEMU CI fails in virtio-scmi test occasionally.  As reported by
Thomas Huth, this happens most likely when the system is loaded and it
fails with the following error:

  qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
  msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
  ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)

As discovered by Fabiano Rosas, the cause is a duplicate invocation of
msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:

  msix_unset_vector_notifiers
  virtio_pci_set_guest_notifiers
  vu_scmi_stop
  vu_scmi_disconnect
  ...
  qemu_chr_write_buffer

  msix_unset_vector_notifiers
  virtio_pci_set_guest_notifiers
  vu_scmi_stop
  vu_scmi_set_status
  ...
  qemu_cleanup

While vu_scmi_stop calls are protected by vhost_dev_is_started()
check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
use an extra protection, see f5b22d06fb (vhost: recheck dev state in
the vhost_migration_log routine) for the motivation.  Let's use the
same in vhost-user-scmi, which fixes the failure above.

Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
 hw/virtio/vhost-user-scmi.c         | 7 +++++++
 include/hw/virtio/vhost-user-scmi.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index d386fb2df9..918bb7dcf7 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -63,6 +63,7 @@ static int vu_scmi_start(VirtIODevice *vdev)
         error_report("Error starting vhost-user-scmi: %d", ret);
         goto err_guest_notifiers;
     }
+    scmi->started_vu = true;
 
     /*
      * guest_notifier_mask/pending not used yet, so just unmask
@@ -90,6 +91,12 @@ static void vu_scmi_stop(VirtIODevice *vdev)
     struct vhost_dev *vhost_dev = &scmi->vhost_dev;
     int ret;
 
+    /* vhost_dev_is_started() check in the callers is not fully reliable. */
+    if (!scmi->started_vu) {
+        return;
+    }
+    scmi->started_vu = false;
+
     if (!k->set_guest_notifiers) {
         return;
     }
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 6175a74ebd..c90db77dd5 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -25,6 +25,7 @@ struct VHostUserSCMI {
     VirtQueue *cmd_vq;
     VirtQueue *event_vq;
     bool connected;
+    bool started_vu;
 };
 
 #endif /* _QEMU_VHOST_USER_SCMI_H */
-- 
2.40.1


