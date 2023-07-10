Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A856B74E1DA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwP-0002gl-FF; Mon, 10 Jul 2023 19:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwM-0002W1-TX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwJ-0004b7-HR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aPiUq53zYt0kY/8LueF30ebx/Uzyl1lsl0vCB8gSxM=;
 b=LSQLJjku7VmvSrifoSWry2+ggQSIceHmlEGgdThNG0VeV72fX0zCUvdrjgAkwu/K8A1Wep
 sMnl+XwL8ZISXPa2RDiWXPjwxYjLlyxVdgcm+4CnmWQVxgZ4kJ7pSzvsXHqtZmO0BZt6Uo
 Xgsr4InQuuJXp4AuPyZRvU+Zz8La5rk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-nkfSFsBBPBW9bu2aNwGY9Q-1; Mon, 10 Jul 2023 19:04:59 -0400
X-MC-Unique: nkfSFsBBPBW9bu2aNwGY9Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf34184eso31734845e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030298; x=1691622298;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8aPiUq53zYt0kY/8LueF30ebx/Uzyl1lsl0vCB8gSxM=;
 b=d+i77AyXPZw+it7Red+UqlrbPtSJJd7BxwNYEqvNuPixBtjbPDDvI3ExakXpBSHjlE
 NVS1G36IUfh/umeVa/pIq1hfQEAtuX1x+xxViaKtJfIKNTD1XwJ20cZ3zK+YAlTQ/jjq
 Be2iIpywYPXhON/DMaydxdWJaBTxt9OqqDlqcgidFQF/6qiy6wkH3e09kOKD81gDcuJz
 KAxDfhHDmSgc4ym5y7J+PTcd7GExCPQIShzx2hMgsYBI/rgweYokPHYGlfToJwF9p+3m
 DOz68CPVk+RNLs2UfWjXb2nzq0ACwmQDUA1kMmqpAxb5Sv2tOj9LDoTdjQHoM5SNY5Hk
 y5vA==
X-Gm-Message-State: ABy/qLZeXWRHbNVWePsfRziSjxVff/4YUpId309zlrlwNMfHFt+cH3gT
 qHqcr0plWyri5y3TPci9yZAua9X777O//hpD+sbFp65Ej0UMT8oglDPbmaybXsn0fgpA70W1ZrC
 qFLjSrOGq/ZO5FUXdYnQogNUjC7VkuNOVKuSGt216tI9c0V2gryNgQuueaeK5A87HvYwB
X-Received: by 2002:a1c:6a0c:0:b0:3f7:e3dd:8a47 with SMTP id
 f12-20020a1c6a0c000000b003f7e3dd8a47mr12334816wmc.11.1689030298060; 
 Mon, 10 Jul 2023 16:04:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVvGOuEqODhMN1Tl9/PR0I5Eat3/XSZwrW4j8sbEckGFeMDhP2sMi0n24BPdIioJEuA459Rw==
X-Received: by 2002:a1c:6a0c:0:b0:3f7:e3dd:8a47 with SMTP id
 f12-20020a1c6a0c000000b003f7e3dd8a47mr12334790wmc.11.1689030297762; 
 Mon, 10 Jul 2023 16:04:57 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 s21-20020a7bc395000000b003fbc89af035sm946671wmj.17.2023.07.10.16.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:57 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com
Subject: [PULL 52/66] hw/virtio: fix typo in VIRTIO_CONFIG_IRQ_IDX comments
Message-ID: <7e8094f0dfd04d4772b65dc92dd087dc86783dc4.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Alex Bennée <alex.bennee@linaro.org>

Fixes: 544f0278af (virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-4-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/vhost-user-gpu.c    | 4 ++--
 hw/net/virtio-net.c            | 4 ++--
 hw/virtio/vhost-user-fs.c      | 4 ++--
 hw/virtio/vhost-user-gpio.c    | 2 +-
 hw/virtio/vhost-vsock-common.c | 4 ++--
 hw/virtio/virtio-crypto.c      | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 543ea92721..e8ee03094e 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -521,7 +521,7 @@ vhost_user_gpu_guest_notifier_pending(VirtIODevice *vdev, int idx)
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
@@ -538,7 +538,7 @@ vhost_user_gpu_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d51067123b..7102ec4817 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3362,7 +3362,7 @@ static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
     }
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return false
      */
 
@@ -3394,7 +3394,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
     }
     /*
      *Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 83fc20e49e..49d699ffc2 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -161,7 +161,7 @@ static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
@@ -177,7 +177,7 @@ static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d6927b610a..3b013f2d0f 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -194,7 +194,7 @@ static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 321262f6b3..12ea87d7a7 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -129,7 +129,7 @@ static void vhost_vsock_common_guest_notifier_mask(VirtIODevice *vdev, int idx,
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
@@ -146,7 +146,7 @@ static bool vhost_vsock_common_guest_notifier_pending(VirtIODevice *vdev,
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index a6d7e1e8ec..44faf5a522 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1210,7 +1210,7 @@ static void virtio_crypto_guest_notifier_mask(VirtIODevice *vdev, int idx,
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
@@ -1229,7 +1229,7 @@ static bool virtio_crypto_guest_notifier_pending(VirtIODevice *vdev, int idx)
 
     /*
      * Add the check for configure interrupt, Use VIRTIO_CONFIG_IRQ_IDX -1
-     * as the Marco of configure interrupt's IDX, If this driver does not
+     * as the macro of configure interrupt's IDX, If this driver does not
      * support, the function will return
      */
 
-- 
MST


