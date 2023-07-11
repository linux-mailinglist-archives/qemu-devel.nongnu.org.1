Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B074F41D
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFfn-0000kn-Dy; Tue, 11 Jul 2023 11:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfl-0000ix-Hh
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfk-0001kF-4N
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689090783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFCSSgRaAIPZO+XMfGJU2kcNt0glc0z3zOUfu/gEpeI=;
 b=gnT5jkM0hRfM+SSgShCIdSQMoXTghEgqZM3YyPUPii2j4FdSCZPwxP+UGwhtXVp3mIyaB2
 HwKdCFxsjJ/SznXbFn7CWUl1PXTWxM5l4SDiF+gIPm+O6HX6HCPrj2hGUZnravrvxuNGie
 dk+tb2m2WjCRuq3P+p3UCF1I0nb1+CU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-YBBEmGLCO3-KZJxRMbuXcA-1; Tue, 11 Jul 2023 11:52:59 -0400
X-MC-Unique: YBBEmGLCO3-KZJxRMbuXcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF5658FBA20
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 15:52:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8534640C6CD1;
 Tue, 11 Jul 2023 13:27:44 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH 6/6] vhost-user: Have reset_status fall back to reset
Date: Tue, 11 Jul 2023 17:52:28 +0200
Message-ID: <20230711155230.64277-7-hreitz@redhat.com>
In-Reply-To: <20230711155230.64277-1-hreitz@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The only user of vhost_user_reset_status() is vhost_dev_stop(), which
only uses it as a fall-back to stop the back-end if it does not support
SUSPEND.  However, vhost-user's implementation is a no-op unless the
back-end supports SET_STATUS.

vhost-vdpa's implementation instead just calls
vhost_vdpa_reset_device(), implying that it's OK to fully reset the
device if SET_STATUS is not supported.

To be fair, vhost_vdpa_reset_device() does nothing but to set the status
to zero.  However, that may well be because vhost-vdpa has no method
besides this to reset a device.  In contrast, vhost-user has
RESET_DEVICE and a RESET_OWNER, which can be used instead.

While it is not entirely clear from documentation or git logs, from
discussions and the order of vhost-user protocol features, it appears to
me as if RESET_OWNER originally had no real meaning for vhost-user, and
was thus used to signal a device reset to the back-end.  Then,
RESET_DEVICE was introduced, to have a well-defined dedicated reset
command.  Finally, vhost-user received full STATUS support, including
SET_STATUS, so setting the device status to 0 is now the preferred way
of resetting a device.  Still, RESET_DEVICE and RESET_OWNER should
remain valid as fall-backs.

Therefore, have vhost_user_reset_status() fall back to
vhost_user_reset_device() if the back-end has no STATUS support.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4507de5a92..53a881ec2a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct vhost_dev *dev)
     if (virtio_has_feature(dev->protocol_features,
                            VHOST_USER_PROTOCOL_F_STATUS)) {
         vhost_user_set_status(dev, 0);
+    } else {
+        vhost_user_reset_device(dev);
     }
 }
 
-- 
2.41.0


