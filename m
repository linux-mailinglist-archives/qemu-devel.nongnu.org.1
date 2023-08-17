Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCF77EF03
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:24:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWSfh-0006CJ-12; Wed, 16 Aug 2023 22:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWSfd-0006Bl-VK
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:23:34 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWSfb-0006on-ON
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:23:33 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-564af0ac494so4509033a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692239010; x=1692843810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ParGKBMKjDNjmq2ZNGJSw34r45qW/LZEEhCKYSIF9q8=;
 b=QPsNbnHaHhkoXgIPfT6XHlLwsP2XVX+PSMMMkRbsdj9M9ztMCWae4a7TRJRWF2c+Dz
 hQuk79hZA4zNR5qknbk30gJ+flJXQzmgAULRROSSUbDoDZIrmm/c6pCNutnuYC1pieSR
 Jj2YjJyT/MRvUHjtYmynuKvpNijBii6Ml/le8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692239010; x=1692843810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ParGKBMKjDNjmq2ZNGJSw34r45qW/LZEEhCKYSIF9q8=;
 b=IPXgWTX7jfjqGoDkVwIf3N1P9+FgFFb2W6VJAvE8p/D875Q0QCeZijJuAhmDoHDDgZ
 JXgS3FVeo4ZaFSeFGx1iQRcb6A07dfVRuuHbX9CCMvlsFwR5HttjYLs9Z1aRz+TRkFm/
 fX8FDTxVstiBKyBZw/ha3Ae+kU9UxGCNJenZcPW2E59qtc3jLVnUohNa0IJ3EFG7gIwF
 CrdcZCb8V7xbaqB608sPy2ZBIFN1ARZ9JoUkqsenx+N94J0cfPvIB1/qOo3scR3w3/Vq
 N0IcT2REkabzdbwwSk4X2kC+MmPgWurTrmgqQZNPAuj6g6VNKgm/k2a7gvYm+2Q4KFlr
 ejhw==
X-Gm-Message-State: AOJu0YxPLQ142vchyaw3qnsDsgscYt3CFPbIGzvGFfnR6o/oZ5EZR25I
 bZvguDomtjJWkXdhgnYOArT6U2/oYBzeqvzkBhk=
X-Google-Smtp-Source: AGHT+IH8H+ZZbCdJpCO8ahHINdctEJsKiuRWyp4Ddwft41zD1gBx0XjAbhBoTJFT0Fv1acFHodmtaw==
X-Received: by 2002:a17:90b:1a88:b0:263:ebab:a152 with SMTP id
 ng8-20020a17090b1a8800b00263ebaba152mr2881355pjb.19.1692239010050; 
 Wed, 16 Aug 2023 19:23:30 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:b7f8:4544:6dd7:85d])
 by smtp.gmail.com with ESMTPSA id
 hg14-20020a17090b300e00b00267eead2f16sm401085pjb.36.2023.08.16.19.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 19:23:29 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v7 1/9] virtio: Add shared memory capability
Date: Wed, 16 Aug 2023 19:23:14 -0700
Message-Id: <20230817022322.466-2-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230817022322.466-1-gurchetansingh@google.com>
References: <20230817022322.466-1-gurchetansingh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x529.google.com
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


