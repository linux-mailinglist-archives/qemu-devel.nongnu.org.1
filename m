Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B217B7A77
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUy-0005ag-8B; Wed, 04 Oct 2023 04:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUv-0005LN-Cu
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUm-0001pT-Dr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=la8UZdq+luErBKOWMyMuUmr0GbVO6D5tVGqSGmhuo0M=;
 b=M4yVkJJhW/5fduJRSKlxjl2laatzyGA4n+GmPzIOqYx6E2YySL6rmekVkwlFmvAOp1km3L
 l+IyzYXoA3nbwJSmO/VGG3Zq0pwTDjZyoYIIETe9CapGzhpPZx+7eCeolf5mgkMYLpQ2Ou
 lLyFT5SHUn8qFrvOwAw2V049BFU5iy4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-z2nTjUIpNr6XudC-vbGH2w-1; Wed, 04 Oct 2023 04:44:38 -0400
X-MC-Unique: z2nTjUIpNr6XudC-vbGH2w-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50433961a36so1728719e87.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409076; x=1697013876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=la8UZdq+luErBKOWMyMuUmr0GbVO6D5tVGqSGmhuo0M=;
 b=i9t9+MbXH3V0qw2YBXsN+X0PHNzdksYDgEmLy0dXvCPIjx9JYFZG6GLDIdOVWJTna5
 bxDj7G0MxV5nycn76mEjZ7TgMi+6WtqQ6abW5tOP9dYVIRxlZ4DM0fs8YCqkz4q3/XxP
 pNOO9EkRWhEMXW2RxtsvnZIrJGWg/DbrgEoogGFI/gaF1fNblNd82Wqn2xR0+QhtliZ8
 jKMhSaAKlOxc0scMPUdUYefPcTrSQV0VtYzLCDe47ZAsfvXMj6i35WiOAVfNBOga6Fzn
 4rQ53K18Np4JNGuliRECrjXzKwTyZ+kUxJM7UhEdyZALcRHSjdkBwlWTZoesW7ScP+7W
 5oDg==
X-Gm-Message-State: AOJu0YyfmvO4Qnv9gPGG1N78GdwS7w0Xig9x4cd33IaeW5PYHvOcyi//
 QEX/D5plnP+n5xbF1/jxqCtr5/Q2agzX6b0gzEVSOraCjISg9byjwgpkZDDJZtVxUEcgrb6+h6a
 wZXpV0d//KI9NigUe2wSTpL4CkWyDrJBt6DLL1JSVMNdEiN26WeJozobyrzeXlg0UeLCJ
X-Received: by 2002:a19:5044:0:b0:503:26bc:9ed2 with SMTP id
 z4-20020a195044000000b0050326bc9ed2mr1189513lfj.39.1696409076127; 
 Wed, 04 Oct 2023 01:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5imMDJau4UNv75tl1KEiiBfsYjoJlFweLGSodMIsa1eoHzXitmpEeJDorhISgO/IKOJ4ihg==
X-Received: by 2002:a19:5044:0:b0:503:26bc:9ed2 with SMTP id
 z4-20020a195044000000b0050326bc9ed2mr1189492lfj.39.1696409075799; 
 Wed, 04 Oct 2023 01:44:35 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c15-20020a7bc84f000000b00405323d47fdsm936110wml.21.2023.10.04.01.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/63] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_sync"
Message-ID: <ad1720af0d7abbb0a74a4b776acedaa21156dbf5.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Laszlo Ersek <lersek@redhat.com>

At this point, only "vhost_user_write_sync" calls "enforce_reply"; embed
the latter into the former.

This is purely refactoring -- no observable change.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20230830134055.106812-5-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-user.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 06d6df3a98..b2213f024c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1281,24 +1281,6 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
     return 0;
 }
 
-static int enforce_reply(struct vhost_dev *dev,
-                         const VhostUserMsg *msg)
-{
-    uint64_t dummy;
-
-    if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-        return process_message_reply(dev, msg);
-    }
-
-   /*
-    * We need to wait for a reply but the backend does not
-    * support replies for the command we just sent.
-    * Send VHOST_USER_GET_FEATURES which makes all backends
-    * send a reply.
-    */
-    return vhost_user_get_features(dev, &dummy);
-}
-
 /* Note: "msg->hdr.flags" may be modified. */
 static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
                                  bool wait_for_reply)
@@ -1319,7 +1301,19 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
     }
 
     if (wait_for_reply) {
-        return enforce_reply(dev, msg);
+        uint64_t dummy;
+
+        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+            return process_message_reply(dev, msg);
+        }
+
+       /*
+        * We need to wait for a reply but the backend does not
+        * support replies for the command we just sent.
+        * Send VHOST_USER_GET_FEATURES which makes all backends
+        * send a reply.
+        */
+        return vhost_user_get_features(dev, &dummy);
     }
 
     return 0;
-- 
MST


