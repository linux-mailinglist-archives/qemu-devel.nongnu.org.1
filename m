Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B314474B3F8
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDu-00017W-E9; Fri, 07 Jul 2023 11:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDm-000162-K7
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:18:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDk-00018v-W0
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:18:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3142860734aso2815524f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743086; x=1691335086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eSUqNv4lq/ydOH00bjXM5Xy7kEmqRO8+nhmVd9FBts=;
 b=orj9IBgscswhsa3RkhpS9syWpj9B1QZx8mQTZOhHr6FGxaf9dENanLNQ01JTg+IxXv
 N2jgXT9oIdnCxFYIj9IK7g+inN7o4FX8NC+S1tpxa2O0FmIhzbeBNdQ+jvEHhLec80Q9
 HSNBPWz9a6VQOa2QqI5H1TF790iwup5d8P1uDPj4KJ56dpdnO0bhpTyyHabrmdHZoj7N
 TfLVZgsDnMTnmSsmlTdnOKRwylLa3wA5sfdjh0qTxBgyLLzYBD5bPkb8sz4QqrI4IJ8g
 52s4PegUY4gkGuF/XiIu7z9Sx8harj72K0UhLuNlk1QXLpqbFpf6eug6Mj/H53QyegIQ
 s1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743086; x=1691335086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3eSUqNv4lq/ydOH00bjXM5Xy7kEmqRO8+nhmVd9FBts=;
 b=X+27ydg/AuFjCQNV3Bd9Fsfotlc2lPIKucy8wkKq3zdA0qsclGLcseh6A6ezWclTpl
 Z+dmhhFFetulBe3JWQdDCXoJ1wI3lcFYrbW8ZCnRN5UfHBcY5lacP3eOFvRHkZ4Limfl
 f+jvNaq3mviual0quB9H0g0aN8tE4lPShodDQUeQ0Tk5rlgiXygdMa7k5AF1Q8sm9z01
 ZRkXRbpUDlF3/Dqw/SnMyup0DhdA6aI46F6FecWQ2J4+SVDR9vhfyoSY+BBWSIlIz1JI
 TjewU0U4X1rJXTLCBTdKHIQspzQHFQl4JX79Asg9cq3RUgBuq1B/7ATP2/ymwnwjPm08
 6yWQ==
X-Gm-Message-State: ABy/qLaXxbECNJQ3zVe4MHmCwxV36hrqlB5XbitqVdipefazTwC6COzE
 5qQxe/evkMJupzYpV+gv4HmVRb2BLzTzcI1GzZg=
X-Google-Smtp-Source: APBJJlHOXQl+pNXppt6SkzuXnsbnrm0ndWT0c3/d7wiN3I5/LmH1A6nzmqTpFgnX8m4a2KmFAKXYXQ==
X-Received: by 2002:a5d:4703:0:b0:314:3e96:bd7e with SMTP id
 y3-20020a5d4703000000b003143e96bd7emr8404254wrq.4.1688743086679; 
 Fri, 07 Jul 2023 08:18:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm2807368wmj.0.2023.07.07.08.18.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:18:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/6] hw/virtio/meson: Rename softmmu_virtio_ss[] ->
 system_virtio_ss[]
Date: Fri,  7 Jul 2023 17:17:19 +0200
Message-Id: <20230707151719.70613-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230707151719.70613-1-philmd@linaro.org>
References: <20230707151719.70613-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Similarly to commit de6cd7599b ("meson: Replace softmmu_ss
-> system_ss"), rename the virtio source set common to all
system emulation as 'system_virtio_ss[]'. This is clearer
because softmmu can be used for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/meson.build | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 900864c1be..7a36eabb39 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,28 +1,28 @@
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
   endif
   if have_vhost_vdpa
-    softmmu_virtio_ss.add(files('vhost-vdpa.c'))
+    system_virtio_ss.add(files('vhost-vdpa.c'))
     specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
-  softmmu_virtio_ss.add(files('vhost-stub.c'))
+  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
@@ -65,7 +65,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
-system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
-- 
2.38.1


