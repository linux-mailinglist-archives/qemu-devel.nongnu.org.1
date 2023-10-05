Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE607B9A0D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 04:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoEL2-0004cR-3e; Wed, 04 Oct 2023 22:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoEKz-0004bz-SL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 22:43:41 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoEKu-0006vF-Rr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 22:43:41 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso351242a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 19:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696473814; x=1697078614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLrky0Wzql+31hWr7YqeUz9asOXoxt2QiJxurTegr48=;
 b=m8wLqPMV/TeISwv4HB9kxXL0OK+ZmVDJfznBT8BGQrmXnKE3YrhyHY5jdavDf3LCBO
 kR6ZshnC324SZBg0bqMbUMAG1aECARGDtEZ/Nw/+LIjMn7Cyrv07PSijU4pp6Z00E8vk
 5kFNUCvmipRrUztj9PRUvyNb59XLk3ZwE5Hoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696473814; x=1697078614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLrky0Wzql+31hWr7YqeUz9asOXoxt2QiJxurTegr48=;
 b=rR6bNyo+3lfjzq/kO6o4TTVbAK0YZBAAZ7Eu1EozoV3L9pwmEK9vBMlI5BIUfntvso
 2AaR08Jr2qR1SshN5yHh9ua+LBQqh6eUnVKK8JmrfJ4QIRtK6iGAHMZpjzpOHL9foDKM
 yYsH9IiYekzYT8Zhxa3s8D9L6zPJXlLl5rB3GO+GjF4jDtwBEPkMwUSxp1xTtp/86juC
 hnktI4gAQdi8WvgRPx7uWWhJvrTEDOH4C7RY/awd9r3HCd1Ou86uCOQbPQk+hjksIbwq
 Y/7fCF53ES49I+HpZDsgrBcn3uFT+ZtY0f0Koc82kR9QVkwTjnLCs7gaCmOnkMwofEie
 OExw==
X-Gm-Message-State: AOJu0YxSeuShDQtTUJwcwM8fRh8SGrJzWsgoxrzCqwDG5dpAF3BUAgar
 nUAaYb13ZFRZm9AKH8DcitKvWLYy+yHERLj7lMg=
X-Google-Smtp-Source: AGHT+IFJO8K5Q/jYaijvyEuRT1DJNcssvF5aAQkEarMSYY8raueSX4chRTWn5VfpeMGcOI1zaaBGiw==
X-Received: by 2002:a05:6a21:18c:b0:13e:7d3:61d1 with SMTP id
 le12-20020a056a21018c00b0013e07d361d1mr5180092pzb.12.1696473814286; 
 Wed, 04 Oct 2023 19:43:34 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:95d7:bc26:d70d:81bd])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902ce8800b001c76fcccee8sm295209plg.156.2023.10.04.19.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 19:43:33 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v16 1/9] virtio: Add shared memory capability
Date: Wed,  4 Oct 2023 19:43:22 -0700
Message-Id: <20231005024330.836-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231005024330.836-1-gurchetansingh@chromium.org>
References: <20231005024330.836-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x52b.google.com
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
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Huang Rui <ray.huang@amd.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
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
2.42.0.582.g8ccd20d70d-goog


