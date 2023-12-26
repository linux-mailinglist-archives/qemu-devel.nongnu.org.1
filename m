Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEBA81E662
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:27:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3fa-00016o-Dx; Tue, 26 Dec 2023 04:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fY-00016N-5E
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fW-0008FE-P2
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2xfTTZNpltmefGE+HE4JL4JH7Ql9blgDHyAGxKzSyU=;
 b=UxS1oD2qYTZhD6xftG+NsLUBV3y2INPtYSFdUaGZdDrfXrEVuhf15C9dxyahZP+D/qEujb
 E7nspn36MiFhmsm86vrBU/J7Sos1E/WAzOuQHTZzHXCAoDvG/qf+/MjPDYldI8CDj4dJAj
 HAAAKS8X/4DHLDYfRweB/UpKI+eflFA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-yaHVmNVZNpGq2-cK-TSRSg-1; Tue, 26 Dec 2023 04:24:08 -0500
X-MC-Unique: yaHVmNVZNpGq2-cK-TSRSg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3367b16449bso2796275f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582646; x=1704187446;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2xfTTZNpltmefGE+HE4JL4JH7Ql9blgDHyAGxKzSyU=;
 b=uocL8OOs9Fjl2E17oWYbeHXvH2nZUrpzCk5MAvZjNNqAV3J9GX/2qMtgx5/7DPk+i7
 cxKwsFTjvvzMNgmPvAojSgVT0cLKxwvYAVLx+5LwYj3lXFq56gut5RbofFm0g9SJ8tjB
 nX3JqvKE3A2r/Os7rP9wrofEOcde8OQqk1Dl3j7VF0HNJ2EiXCbHN+ctiB1BXT5uvZqE
 9Rr1oQdIYlNkvxf5GoqFSIA5abgLquKHZLoGqIkwz1ibaTbyKVfMSnzBW3OpD7F0WDpd
 7WRd8JP4glXTVk5UGX63AjNYB9Um8lHEHYypgnHrqh60MELH2e8Ro3G+uLINpBbdervE
 c5KQ==
X-Gm-Message-State: AOJu0YyVSxdnYhSBQ7/pmh/cFSRYPTjivz1HI5W680wTcG8fmUjQ03q+
 ANt+9ReDEUQRgB5t48kWGx3VA2gS0dYz/JT2sV1eb/VZhk5f/ia4PUuIhhfoGZ0eN7oCR1qR8f+
 MdT1bY0gHnXoFIwy/vLmUtVooKtgl0rylMAskVwccVK3pTRqHvmSLaDmHeiT5cZqarcGSRxwq5S
 Oh
X-Received: by 2002:a5d:6992:0:b0:336:de69:c215 with SMTP id
 g18-20020a5d6992000000b00336de69c215mr362505wru.102.1703582646365; 
 Tue, 26 Dec 2023 01:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp1ft5Yw1fA2QKmka4/VngXYvJ5urOywK68YYFwPaOVnPcAjOtEXSduFeJmFIMd6KFlcXQJg==
X-Received: by 2002:a5d:6992:0:b0:336:de69:c215 with SMTP id
 g18-20020a5d6992000000b00336de69c215mr362496wru.102.1703582646089; 
 Tue, 26 Dec 2023 01:24:06 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 q17-20020adfcd91000000b003362d0eefd3sm12096408wrj.20.2023.12.26.01.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:03 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/21] virtio: rng: Check notifier helpers for
 VIRTIO_CONFIG_IRQ_IDX
Message-ID: <df72f01104ae9a68f356ae412776b209f04d27cc.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Since the driver doesn't support interrupts, we must return early when
index is set to VIRTIO_CONFIG_IRQ_IDX.  Basically the same thing Viresh
did for "91208dd297f2 virtio: i2c: Check notifier helpers for
VIRTIO_CONFIG_IRQ_IDX".

Fixes: 544f0278afca ("virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Message-Id: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-rng.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index efc54cd3fb..24ac1a22c8 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -129,6 +129,14 @@ static void vu_rng_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
 {
     VHostUserRNG *rng = VHOST_USER_RNG(vdev);
 
+    /*
+     * We don't support interrupts, return early if index is set to
+     * VIRTIO_CONFIG_IRQ_IDX.
+     */
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return;
+    }
+
     vhost_virtqueue_mask(&rng->vhost_dev, vdev, idx, mask);
 }
 
@@ -136,6 +144,14 @@ static bool vu_rng_guest_notifier_pending(VirtIODevice *vdev, int idx)
 {
     VHostUserRNG *rng = VHOST_USER_RNG(vdev);
 
+    /*
+     * We don't support interrupts, return early if index is set to
+     * VIRTIO_CONFIG_IRQ_IDX.
+     */
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return false;
+    }
+
     return vhost_virtqueue_pending(&rng->vhost_dev, idx);
 }
 
-- 
MST


