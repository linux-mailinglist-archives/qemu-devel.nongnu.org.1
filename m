Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F44781660
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAW7-0003kw-78; Fri, 18 Aug 2023 21:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAW5-0003kf-DD
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:12:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAW3-00017r-2E
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:12:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6887918ed20so1370548b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692407553; x=1693012353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ParGKBMKjDNjmq2ZNGJSw34r45qW/LZEEhCKYSIF9q8=;
 b=Xls7RuvAtAKwJAqG60ccPyHf+4ejqSDBQlsZT+Ow4xZGY9vmI6Hjy9v8SQo/cRunin
 pyaVhJaoJVNVN3gi5xUo4arT+3+LMKth81QimtlHODlDQ0kD9cnDs5cJOb0A7OjhTTw0
 iTY1VjwpcKbqx59651UyBVRbfSy/y3oVwSCaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692407553; x=1693012353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ParGKBMKjDNjmq2ZNGJSw34r45qW/LZEEhCKYSIF9q8=;
 b=fXklaj3RAfvw5e1bkCtE6vGpWTUrnu1/qfvfMJLaL2cAYiSR5GafOLZYFm8awwCkpN
 ctMND99lasGxFxaVeXFkWNl7LB54SkFnaVLw9wEXKGPet45YrJgKECya47a8wSqWnp9v
 l5V0x26JqGSaEE0wKB6IzCjVzECoyMxexlUpp4b8POFMifGScmH75oGUEIjbcjSkF7rM
 l2h+StwOc4ebnXEqSNetpOYUibLSGnFdU8JcTjfE7vERrTAltuDsmv/6K8DuaWIl9lyb
 fCjfCeRHGWasXS54Oz0Pl03Kj6CZuUBUktC3gpcqQcZRup0CcLu0BI6NO7+aNaHy5KMU
 S8Cw==
X-Gm-Message-State: AOJu0Yz6qhOsGmRLdMk7thNI7DdsGdiHPgW9HopFCMp062OcuHw8QW6j
 o9eTAGYFSnLtH//8FTfd+l7vWrPggEp9nUM3dt4=
X-Google-Smtp-Source: AGHT+IG+Oe5Q+P41Q3rjqtBENXqERE7x0MAYSuQOQuhHQaJ/CkMXCA3ZUmTNHPB5mls1YiKb7kSbvg==
X-Received: by 2002:a05:6a00:2d1e:b0:66c:9faa:bb12 with SMTP id
 fa30-20020a056a002d1e00b0066c9faabb12mr925734pfb.9.1692407552789; 
 Fri, 18 Aug 2023 18:12:32 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:92c9:8bef:2f4d:5ef5])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a056a00165a00b0068a077b21c2sm554810pfc.172.2023.08.18.18.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:12:32 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v9 1/9] virtio: Add shared memory capability
Date: Fri, 18 Aug 2023 18:12:21 -0700
Message-Id: <20230819011229.415-1-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42f.google.com
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


