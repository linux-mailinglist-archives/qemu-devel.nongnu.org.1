Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCEE7B3B1B
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 22:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmJs2-0007aR-JX; Fri, 29 Sep 2023 16:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJs0-0007ZC-Dk
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJrx-0004Im-F8
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-692ada71d79so10572179b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696018426; x=1696623226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLrky0Wzql+31hWr7YqeUz9asOXoxt2QiJxurTegr48=;
 b=EPGBpWs8GtXhX1nD3r6XNwCZYhVJWcmPnlY/4d5Yv4Kax9KG5gtd5h1gZg5K/l9hpw
 jAsBzdnJN0sijklCwQSJ7a73LrSQO1gcbdWeTM5+lYnCRliiLQ2LrrEjhZr3T/oMnr7P
 YFgyNXlUW9GcQc2ouoQLjU9T0lmfRoyzNWxl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696018426; x=1696623226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLrky0Wzql+31hWr7YqeUz9asOXoxt2QiJxurTegr48=;
 b=i0jxNq4LaARWDGzZzRQSCT2ZjPmRcbH3XVnkVYyMvmtOtn3vQ1q11D4HaiYESSTf3H
 D6UivPPYR4mdB99QXOsiZ9DBrTtjdbGyo/pfZLWVZUIKa2a9JmKWYYwKDWeVwX6lW35A
 W4KqvhyLnzFNRrLqGYWOEclzwaJmnGH3X4VumdF9kPCRgnPksCtP5ZyCKzNqMK+jCCxM
 RQaGBWgEZf9r4AxQNHEOy6n7683Anl6akQvd/+kB27PP9zifJGXQaRF4HnczlXesI5jx
 A19ZZGyGJjZBI1qa7G0Zhoo2DYKMoojk8atsNx+tUrDvJBM/E9Oravva+nVqjFpwmsKB
 Rpog==
X-Gm-Message-State: AOJu0Yy3buc/6Y9lz45okhUnBDq2AYk1YTvvSUJJdJ8Zybk7e77cBk9e
 0ce/g7N7a8g5wWCNbcDVKbDcMDUyibSF5HWTkRs=
X-Google-Smtp-Source: AGHT+IG0n+tH2InT5BccFKE3dmsnV1yHUwC9iOhc993LTK2QRojdhSOq65KR+gjlwFXlOSIi9Q+Riw==
X-Received: by 2002:a05:6a00:190d:b0:68e:2ef2:3379 with SMTP id
 y13-20020a056a00190d00b0068e2ef23379mr5186043pfi.15.1696018426307; 
 Fri, 29 Sep 2023 13:13:46 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:18fe:3fb1:d86b:1e68])
 by smtp.gmail.com with ESMTPSA id
 t12-20020aa7938c000000b00686236718d8sm15267033pfe.41.2023.09.29.13.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 13:13:45 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v14 1/9] virtio: Add shared memory capability
Date: Fri, 29 Sep 2023 13:13:33 -0700
Message-Id: <20230929201341.332-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230929201341.332-1-gurchetansingh@chromium.org>
References: <20230929201341.332-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x436.google.com
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


