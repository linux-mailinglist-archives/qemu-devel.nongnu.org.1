Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67CE7750C5
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYfP-00073G-HJ; Tue, 08 Aug 2023 22:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfN-00072b-Ji
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:17 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfK-00015E-4w
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so6230411b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691547072; x=1692151872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKHAKOsEYzDLZcWmqiaSywpW269TqPN1TbRX4nUZGOA=;
 b=WAECbuAOprG4EifuBdFRyi1YONBZlPpRSTYBvxhk0sSKVIJQr3pasQQ8fW4hZRoQIL
 JLh69SQcVfAQeXhj9iTwys/AWSooETdhPpiupGqfWHojwOZvGGtQbmTOwbm+isk1VVs8
 7J1XOwua6egfnSBk3vU32kbn8ekjL21yp3uBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691547072; x=1692151872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKHAKOsEYzDLZcWmqiaSywpW269TqPN1TbRX4nUZGOA=;
 b=KKxA4qD7WgWEQmKbdj5o3OkHl/Lwsk/PeirPOrtvP4wr/tuGdnFbho9Lj6a21WXwDz
 XTyTp3WgULoBqzCYzN5i24EK5f86AdTLgC1nftfWlBSd+qOmO5vIDVzXgKzJ3vELFKOt
 1zKei9Sz+Rgm/FaNdqdaSjFq0P4kri4mwwdiInqf2p7gvKgDV8WOwgI2MidbRBws4oYb
 hTK4cd4sCBw/YB50HFY8YQ3vevixXRuAekzqEsYGGxBVDy1MCZWpSig1XUc1rpykCbZc
 K/omeacT9K3rqJQ6HPV3ytzhSxyS4g1BvK+Ccvf5vidrPd1ZVLxpQIUQAEkJnBY25CRh
 BMBA==
X-Gm-Message-State: AOJu0Yx5Ve3DJSUy2nNr4e9o2rcwgv06OG/k2FbXK3aAC8PzIsY1upLB
 frvBVMqYEJ3s8kSU/sLROoDGuxZhrny8CmnKpackJw==
X-Google-Smtp-Source: AGHT+IFICWrse8BBhPlgIoYp5SeDxn32Dljocl29fRVkHhrfyUkmuigcL5Mv0UJ3RCNsNgYWzdnumg==
X-Received: by 2002:a05:6a20:12c3:b0:130:11e4:d693 with SMTP id
 v3-20020a056a2012c300b0013011e4d693mr1602902pzg.53.1691547072627; 
 Tue, 08 Aug 2023 19:11:12 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a5a2:f074:e7af:41fe])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b00687494a59bfsm8681887pfo.61.2023.08.08.19.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 19:11:12 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com
Subject: [PATCH v4 1/9] virtio: Add shared memory capability
Date: Tue,  8 Aug 2023 19:11:00 -0700
Message-Id: <20230809021108.674-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230809021108.674-1-gurchetansingh@chromium.org>
References: <20230809021108.674-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42d.google.com
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
2.41.0.640.ga95def55d0-goog


