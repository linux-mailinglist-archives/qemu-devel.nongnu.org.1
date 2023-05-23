Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184170E1E7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V05-00018S-Oe; Tue, 23 May 2023 12:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V04-00014O-C7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V02-0001gD-Hg
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so380945e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859797; x=1687451797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vD4+39IhI5L7fmlbuqqsRg2B+vzAyPbhgTWPowgv4yc=;
 b=Ojz82F+JNrxoV+CzEb+nwtiSKvljJ//B4KwVou3r6rIzJs8je/ypEO6TCIopcIxDsv
 /H4q5I5qaYbgJksmbiT/hBh3xexKJYIBMDzRMNvlTSZ08Cd/AuFTw7CzBBNvnvZ0cfwH
 I4FGDgGXadNbxfOC1UDGyOLbCpLTBrz+8ZnNMW0ZMBZNe1SVTDJ+B16DbBzpNOzinyoO
 RQzn04fJqVYh/lzME5cTPriUVN31d/EkBQ6MqcfXdX2WB8AeszaTsrB+2xGHijqjMEKB
 mygyLPwbThLAhtxuvp7IbQcQOupiWQbLPZo4DYWqhq6nOOUKb5SIolgf5OX3gFCZaw7j
 waQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859797; x=1687451797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vD4+39IhI5L7fmlbuqqsRg2B+vzAyPbhgTWPowgv4yc=;
 b=hjJgZUOdWHgQBie+JumyNB7BkI43hW7pvsUnO+ZdZy338acSWawjFg1iCwkwp2NFnM
 2bsM5dfiMRu1+ikSfF70BR7i5KfMVRhnQ5atSGQj6g9Vd1FGc3I16Kh/aOe4yKqy0LQ2
 mmlPTpvspdWK20YD+EypC2VYFrndKOfesXWMNMw24RY0WAlZHra3JbFw244CkA5VH2Dw
 gcNqjjZ9IEwU4GbfHhRcq5R4t0gY+ibvJ4OticHD7XJ2x9C4MJcMFSnOENqlS95Ny7EW
 yJBZcDBoWsysv00jGW4DZ2nk5jVgBDkxcIxB3cTMuo05bn9EUMlpNPhkFX6sQjV1/fmL
 wyFA==
X-Gm-Message-State: AC+VfDyFZ938FJYIUAunkfafLYHTBFfzQGPuFX33RMYcnJUlVgB8Qvks
 FyjNNAsHk6Qlf6a+kOfOIvTnEl/KtJvfxKAzFfc=
X-Google-Smtp-Source: ACHHUZ6zGeIFdD1GDuGVJ91vXos4g0+mB2A7tyT2UZUjTei/PCpjxPdmgoLnPetJU1kXgbhXmTpCEQ==
X-Received: by 2002:a7b:cc15:0:b0:3f4:2452:966a with SMTP id
 f21-20020a7bcc15000000b003f42452966amr10252942wmh.27.1684859796704; 
 Tue, 23 May 2023 09:36:36 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 22-20020a05600c231600b003f421979398sm15300258wmo.26.2023.05.23.09.36.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 05/11] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in
 Kconfig
Date: Tue, 23 May 2023 18:35:54 +0200
Message-Id: <20230523163600.83391-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
selected by both symbols.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/Kconfig     | 6 ++++++
 hw/virtio/meson.build | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 89e9e426d8..de7a35429a 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -56,14 +56,20 @@ config VIRTIO_MEM
     depends on VIRTIO_MEM_SUPPORTED
     select MEM_DEVICE
 
+config VHOST_VSOCK_COMMON
+    bool
+    depends on VIRTIO
+
 config VHOST_VSOCK
     bool
     default y
+    select VHOST_VSOCK_COMMON
     depends on VIRTIO && VHOST_KERNEL
 
 config VHOST_USER_VSOCK
     bool
     default y
+    select VHOST_VSOCK_COMMON
     depends on VIRTIO && VHOST_USER
 
 config VHOST_USER_I2C
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index bdec78bfc6..54c90c24fb 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -23,8 +23,9 @@ specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-bal
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c', 'vhost-vsock-common.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c', 'vhost-vsock-common.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
-- 
2.38.1


