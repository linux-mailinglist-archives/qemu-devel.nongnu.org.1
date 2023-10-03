Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202F7B72AB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmGp-0008Eu-TD; Tue, 03 Oct 2023 16:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGa-00082K-5o
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:16 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGQ-0004ZA-En
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:15 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-578b4997decso973057a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696365904; x=1696970704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLrky0Wzql+31hWr7YqeUz9asOXoxt2QiJxurTegr48=;
 b=lhhGtMagVFiAU9y1WBueR9p9VJrN11i50ZBLHLFvQ8EjNHXEjHsml7gInL3iVKiNpp
 h/aet4b82epnpHLiedPWpt1OhZ9orC/dz/h6ARyqAIGZLuS7Phrhr6/kGq109orLTwKi
 Mdopkrc2E2qy0XW+1i0nqjp7hdfRZzyUhe3oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365904; x=1696970704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLrky0Wzql+31hWr7YqeUz9asOXoxt2QiJxurTegr48=;
 b=QzBt8W/nuVCvjiPSXqSIx1wYRVRdHF4JXuMsgp1/yMHYLbyo1tFuP3PeV2IBBt4ItP
 FYyAYCoekDQL+8BpTO2BU27tw0HJm0Z4g90kgcYgiplBkR0veQGvRzvUPUHezVhNoi/3
 k3hx98ZpoU7aKgwFAYMGFgEFYugzqPHfZtxz46zbBj8h1wr1sPow41srNsu/PdPYAbqs
 d1ecFFJrV09q6Z68yuMCTN1vsI2GgwepXAkAfyEwORvtfUA2NU9c/50XUHdD4wj+8lf9
 qEqUrvlZK8PZG72HrM4xBtZAYP++x83iTmUxUK8jV1NGWCvcJDftVwFoob27G9ZFc+NY
 c7Aw==
X-Gm-Message-State: AOJu0Ywc/bovDKO1jXe9KTEGONrBxDsZqP37axdLjaF4KPrbBe0Dhnmx
 CvCtJOBNp+ar631maEP8zLo4a9jbWjx7Ec58igM=
X-Google-Smtp-Source: AGHT+IE2Cw0G/guDyZ3ARusYUniZcAC243iIe+ZqOX+1dvugsrNeL9BnS/y7jkoLLykT4mEcPkXj3Q==
X-Received: by 2002:a17:90b:3905:b0:273:f138:29cc with SMTP id
 ob5-20020a17090b390500b00273f13829ccmr381765pjb.35.1696365904589; 
 Tue, 03 Oct 2023 13:45:04 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9076:49ec:5f9a:e5ec])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a17090aec1400b002777b8fc74bsm3739pjy.21.2023.10.03.13.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:45:04 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v15 1/9] virtio: Add shared memory capability
Date: Tue,  3 Oct 2023 13:44:52 -0700
Message-Id: <20231003204500.518-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231003204500.518-1-gurchetansingh@chromium.org>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x52c.google.com
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


