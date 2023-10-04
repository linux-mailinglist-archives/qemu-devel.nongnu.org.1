Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D57B7B68
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxsj-0005Ec-FP; Wed, 04 Oct 2023 05:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqx-0002z5-F3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqv-0007aH-BS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3247d69ed2cso1867397f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410451; x=1697015251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbNDV7C/l3f6+3FtPFIUAzaNEP0L5fC09/CQh4JGMdY=;
 b=KmUYzWzVlWoT2IkCwKYxQ/TfyzrH9M8eX2m/Bxjq9DUVIoLLTc32nGhK1DND/War2V
 p0g2kNMMFAIpOoMLHY05EbGw7Itm+s1WnJ7z5CpAM9dr3HvzvmJRFrTklvN85nkaMs8B
 ZmNhA2s3Yf+iZowiHJb8JMnSLojYPjYq87XQspA9gc4OQx4MweuxdvYCT3cqKDTCC3Oj
 mAef9wIKo+xAg0rabbIQwUF2hcC5ZmHkBowButkE5gsfpV/PxRkRO2W6duQh+uAmwNn9
 pY1m6mBt74xX3Ru2OTaySgfmQiTkguksfVA7ry/cIbn3fW3IR/a5AL2seIjZW6PJzgL0
 rodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410451; x=1697015251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbNDV7C/l3f6+3FtPFIUAzaNEP0L5fC09/CQh4JGMdY=;
 b=jHIB5oGNTL+DnfobGO52MmNQSllfM5QdULrM7muMZXBZKKcSPmzaXXPpwQeAEMOBmm
 2zMtMpphZnJHlqESGplBe2ANVuPoPnrUNjHxM+o9pZbezc0HftK1S651Tf9NoZek/Ph9
 v/mzwIaarQdQ0Bbq/uSLZF1m5w09yZ0wge2JrUtomUD4a30opQxFNGC2P01S+SNxB1zS
 oXFA3DYTAcLdnoTU11xotghXf9m4I2Q7j3ViQja/R/4igOKnaoz0ychkAUDLzyMhA22m
 zwVA91b3ALFiXVmhg1svVpoZh8KXLewYKZS6MWUsD2XPQ8cSdqGFkE10+BzOqQlGe8iq
 afSA==
X-Gm-Message-State: AOJu0YwXUch/+eSTQm5HckqV3+U2XXB3uU3CtbHwIbPpokjHjrj2R1k3
 ozOoB3aWy8w0vi30t7S+KAdtrLArwl0jh32xGNA=
X-Google-Smtp-Source: AGHT+IGMjbarVfHu2j+Ay1kT4LSYiXLyVf22au3zEMPoyH/ziLo/AwxU//6YKv002MoHjUysVQYkZg==
X-Received: by 2002:adf:e48b:0:b0:319:7bec:4f31 with SMTP id
 i11-20020adfe48b000000b003197bec4f31mr1627029wrm.10.1696410451647; 
 Wed, 04 Oct 2023 02:07:31 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d4290000000b00325b29a6441sm3494427wrq.82.2023.10.04.02.07.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:07:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/13] hw/virtio/meson: Rename softmmu_virtio_ss ->
 system_virtio_ss
Date: Wed,  4 Oct 2023 11:06:25 +0200
Message-ID: <20231004090629.37473-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

See commit de6cd7599b ("meson: Replace softmmu_ss -> system_ss")
for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/meson.build | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 13e7c6c272..aad506fe52 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,18 +1,18 @@
-softmmu_virtio_ss = ss.source_set()
-softmmu_virtio_ss.add(files('virtio-bus.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
+system_virtio_ss = ss.source_set()
+system_virtio_ss.add(files('virtio-bus.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
 specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
 
 if have_vhost
-  softmmu_virtio_ss.add(files('vhost.c'))
+  system_virtio_ss.add(files('vhost.c'))
   specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     specific_virtio_ss.add(files('vhost-user.c'))
@@ -21,7 +21,7 @@ if have_vhost
     specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
   endif
 else
-  softmmu_virtio_ss.add(files('vhost-stub.c'))
+  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
@@ -67,7 +67,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
-system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
-- 
2.41.0


