Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DD7787C06
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZJwj-0007CB-U2; Thu, 24 Aug 2023 19:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwe-0007AG-4k
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwb-00059V-Hl
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-689f9576babso381572b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692920451; x=1693525251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1k2OlKBoi2jxrejb99RRYFuYwQeQxWMM+aWJUFmQQWo=;
 b=mP8o3K6KeurqcHuBHm+0x4NUNtDnSjjcoSxFR030RrD3GoUis7OXPPWUNgnXqkJPYQ
 VYxNluP4rqkEOmKdVX2/EA2MwDT7yWgEtSSg16E+HtD8YbBCJIr1EuX6D0OgTMV/m4SB
 w/xSPbq2yLPltUfKsGD8++qwUCn9tC1kFKTGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692920451; x=1693525251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1k2OlKBoi2jxrejb99RRYFuYwQeQxWMM+aWJUFmQQWo=;
 b=UzwJibTZRqvnIPmyDkJmvVD9L8Yk3s9eVjO8k9NPOYzN5RcPg4b+lmRCiXg9W/ySsP
 J09ACr84gHR3BYSaQfDJOFqJjRsWXQiHypF6Zu5ywjKmQbIgEPt2hPwGpJ49+VmGdKim
 bTDgwwpsZafeFubHVAvqw5+ATnQk3Ezp0p8gCVEihvE4qqIfoNVK4dRC2sJgUqvW0vg7
 WwwEGwxUWI7SQh/oOtIHGMdyFhGqse746+Iiub3iYRTOr21GrvcIGRGHWW4+FgKsjsew
 yIZiPmvynneH8gkLlf1elWhgtQn10rek9Uve4G1yd8i1Rz9wmnWP1INSM/iO5kNIz52B
 MStQ==
X-Gm-Message-State: AOJu0Yx5Guh2M0B5Hkz1hn18HXVQdy2CFqQuNlAEe6EzEE7t6FlzjNuZ
 NEpYqbMitANINeBJzbqgx6/I0sH5ynUfzz9I4SI=
X-Google-Smtp-Source: AGHT+IFve3DqPFt0SBUWJtMP41Wg3i0aJoDL4jlmBOAW7ClsCdbUBO39cAyqomtk2Vc3A6KAv0x5xQ==
X-Received: by 2002:a05:6a20:8e01:b0:13e:b7e9:1a71 with SMTP id
 y1-20020a056a208e0100b0013eb7e91a71mr18178596pzj.14.1692920450984; 
 Thu, 24 Aug 2023 16:40:50 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:1fa0:9cd:3c53:231b])
 by smtp.gmail.com with ESMTPSA id
 fe8-20020a056a002f0800b0066a31111cc5sm274798pfb.152.2023.08.24.16.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 16:40:50 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v12 1/9] virtio: Add shared memory capability
Date: Thu, 24 Aug 2023 16:40:38 -0700
Message-Id: <20230824234046.499-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230824234046.499-1-gurchetansingh@chromium.org>
References: <20230824234046.499-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42b.google.com
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
2.42.0.rc2.253.gd59a3bf2b4-goog


