Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABF783690
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 02:01:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYEp3-0003Fo-Em; Mon, 21 Aug 2023 20:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYEoz-0003FL-JJ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:00:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYEox-0001OC-91
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:00:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso30397015ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692662428; x=1693267228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ParGKBMKjDNjmq2ZNGJSw34r45qW/LZEEhCKYSIF9q8=;
 b=m11sPSturXA/KRcUZvvuB8LISBFXOQtnOBgUvu9ltnohWUyCahcq+xL/5sby+xZT+3
 aJhHyJkMUOjvTxwImfdiggWmZoVyXQA0gLA6vgxgRs3VWkj5pCCGE0VY5ijmPuzvxOxa
 zOlVxaOCbnSTMCkAWsyULMg++GDPppgbhqSzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692662428; x=1693267228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ParGKBMKjDNjmq2ZNGJSw34r45qW/LZEEhCKYSIF9q8=;
 b=ZhPCTQfhuo17ziqIphWK9QN4PYkE02c8HBbf0lbw84P7TpVcOAyrQMArHqZ4iO/wK5
 qeZrwLqojLJ7EONPoKKPZ+o4rGGrTfYtAREepdcAHunrhydbTgx88eN+FVC6MIy55qB6
 r/EU3X835hADnOH4ud8qLV3iJd30epNmijQ36ev915vHZko+TsCikl/44UX7gmICqZb/
 54tMkdg1EVRiKGX6XOCAmlSttIjoWvDy1DSvV8KnNBJnZ8N5xWwBi15l5L7osC1D4tYW
 wyNcvEVm5oR/AognugfyrJgBgrq6/s3OOBnr3qFuO1qwpRPjMnFARLe9EsRZ4PT3ofGE
 jWvg==
X-Gm-Message-State: AOJu0YyWU01vEtsSw94ySEIEIXbMzD4iOsF4jWj1QP0VA5JVI8xcl4lq
 Uh8lq6jMzjFwgoWEOHXPDKHe8iK/mj9ed6OQC1o=
X-Google-Smtp-Source: AGHT+IED3AqzZyhPqMwAWR0SuS2x2Hi+iEOk8CfHCx2AXD4i6oKccJ93BvuN3adsaMdrVtlRCQIgQA==
X-Received: by 2002:a17:902:da81:b0:1b8:7e53:704 with SMTP id
 j1-20020a170902da8100b001b87e530704mr11708555plx.27.1692662428302; 
 Mon, 21 Aug 2023 17:00:28 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:91e:34c5:6c84:1464])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902bd4a00b001bba669a7eesm7626277plx.52.2023.08.21.17.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 17:00:27 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v10 1/9] virtio: Add shared memory capability
Date: Mon, 21 Aug 2023 17:00:17 -0700
Message-Id: <20230822000025.501-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Tested-by: Alyssa Ross <hi@alyssa.is>
Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Huang Rui <ray.huang@amd.com>
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
2.42.0.rc1.204.g551eb34607-goog


