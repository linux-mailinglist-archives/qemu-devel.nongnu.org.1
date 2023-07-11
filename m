Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C2D74E488
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Yg-00035q-Od; Mon, 10 Jul 2023 22:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Ye-000352-U0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:56:56 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yd-0005Od-Bq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:56:56 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3942c6584f0so3690828b6e.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044213; x=1691636213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW6NVEolDAxSU/Kpub9499MjuEQqXpgbqePIxcarQ8Y=;
 b=C7iOjufoUABE/OZFBBbefscfKBLY9TDWzFWmPb4L4rGUSNNPK9m7AandrsZpj7vZAt
 K7jN1w+lA/dYQApV3ZNIt2JH+Q5x5k6sPZIktNIW1KknmoXRBsIU58v0DhDuPHQ35d4I
 qnXPfzDOG32+sAtYLlZ0LCZq0kVwy1i9FORGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044213; x=1691636213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nW6NVEolDAxSU/Kpub9499MjuEQqXpgbqePIxcarQ8Y=;
 b=JD6ZhojkPzMHwNaRuImpuD47T/NjHRn9pRwV+o5M8w4z/lhtVlU+TZU9krIyVSSQe1
 gTK4bu+hASOkMOy1rymbGpgZjXg3X10ejdWhFO4TPDRDp4AlgtrKJ/ruYUMahL2m1syv
 FP4y6wGj3iQXtc9FrueBMY+4+JFQUbefG4mP1M8jNHxfRa2w4pSPXremvQQrdqAdGmw8
 UU8JsxvnagIwI6iDQkW/KW/8A7G3k0zrjNi1v72mpvXzBGiP3t+nBArZcERi1vMYi+wP
 PlljM7drWDmqs9/JubKJ1rmDKqB0mMns322dkSyXbWd2wI2ZJDfUZ2X1Kw83y6Hia4bx
 ehZA==
X-Gm-Message-State: ABy/qLYX5DgDHPejYaJ8Ea1khvI5qANKwf+May4HSuXa75kYW4q0nK7U
 Gsiep6t0M/727GG868B4FskFzRUWIcdJ5Ai4PTA=
X-Google-Smtp-Source: APBJJlHZLB2QEsVTFzxlWPftJhhG9iCptwwa56ooogJSp4rgigZrV9eay76Rxfd6MFHEHm9/zVfCMw==
X-Received: by 2002:a54:418e:0:b0:3a3:940d:1fba with SMTP id
 14-20020a54418e000000b003a3940d1fbamr12317537oiy.33.1689044213501; 
 Mon, 10 Jul 2023 19:56:53 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:56:53 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 1/9] virtio: Add shared memory capability
Date: Mon, 10 Jul 2023 19:56:41 -0700
Message-Id: <20230711025649.708-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define a new capability type 'VIRTIO_PCI_CAP_SHARED_MEMORY_CFG' to allow
defining shared memory regions with sizes and offsets of 2^32 and more.
Multiple instances of the capability are allowed and distinguished
by a device-specific 'id'.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-pci.c         | 18 ++++++++++++++++++
 include/hw/virtio/virtio-pci.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index edbc0daa18..da8c9ea12d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1435,6 +1435,24 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
     return offset;
 }
 
+int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
+                           uint8_t bar, uint64_t offset, uint64_t length,
+                           uint8_t id)
+{
+    struct virtio_pci_cap64 cap = {
+        .cap.cap_len = sizeof cap,
+        .cap.cfg_type = VIRTIO_PCI_CAP_SHARED_MEMORY_CFG,
+    };
+
+    cap.cap.bar = bar;
+    cap.cap.length = cpu_to_le32(length);
+    cap.length_hi = cpu_to_le32(length >> 32);
+    cap.cap.offset = cpu_to_le32(offset);
+    cap.offset_hi = cpu_to_le32(offset >> 32);
+    cap.cap.id = id;
+    return virtio_pci_add_mem_cap(proxy, &cap.cap);
+}
+
 static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index ab2051b64b..5a3f182f99 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -264,4 +264,8 @@ unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues);
 void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev, VirtQueue *vq,
                                               int n, bool assign,
                                               bool with_irqfd);
+
+int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy, uint8_t bar, uint64_t offset,
+                           uint64_t length, uint8_t id);
+
 #endif
-- 
2.41.0.255.g8b1d071c50-goog


