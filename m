Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEF7415F8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXX0-0003KO-Tp; Wed, 28 Jun 2023 11:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWi-0002ua-S9
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWa-0001tS-37
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so3508870f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967766; x=1690559766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhB4/DcowpYYE5gsxFOT4g8oIU66RVavaCJXPih/ML0=;
 b=M8EfAULj8UTYR+lPaB+0DvnZ5RTOmhZjBhTuXrId8kCH6NzcXY20/ciL6qmSIEyVHT
 n48C8iuqGBdVTOAsr9RXC1EnwcilV5e4LGx4/nPofozXUsY+QBu0Ob5/fofbhpszqS6q
 RPn9FsEEMe6Bpuwb8OkN9lKu93uuniMMgD7eLNfDa38DxBIIiw/I4k1vj+bdOPsy63VJ
 rdqKYpdCfZWJ586kz98xqXvrGF9rStKrJYdbmwnds7k7DGv6jiyOi7Ypy/b74Ld/Bo/b
 bu4XarZq9xpG1EpX+pqvFBNFW5MVzvePGkfDyPYDbS8RCsOpJNFp3z8q6fyWEHjvvy9k
 zHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967766; x=1690559766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhB4/DcowpYYE5gsxFOT4g8oIU66RVavaCJXPih/ML0=;
 b=gFvb66OEg47VcbYZbpx1pNJpMp0+rN7cuKaKZjPm3xumi8pupJ4QzZlE5OIwq9C6wa
 xiK0bzLzeHUOq2ZmwIwmxG4hDQXmmKPMBZ3X+Juu+cZsl+vytUcgbAKAfij2z0C+3FSC
 2wCN8zjqC1x2UOlcewR3CDiUt4GF/OVam5u1JwMxALSDnE3ULiMEI3oSXTqFVxJvCSel
 noSFe4bzEQl7zc74XS6Tv+/YDLuQ8sp2SVmOHezCR2DduDBQOj2Nyh91zTbejc+rgwCT
 DAT56BqxKeh9HXLuz5AYXUdVuIJe3RXNpgo5W7bmtZDwF4iURBwmEwX1BD1OB6dU2eSA
 82QQ==
X-Gm-Message-State: AC+VfDx/I6d4BAbuokHVRoJVXLcPXHyQwCUf/NwqgQY4cRysB9xHOmU8
 N0Wjcfw0pwA9fUaEjlwnfdSd1OO4mF1+SjpXj4c=
X-Google-Smtp-Source: ACHHUZ7EkFer2d6c5sBTxtB9qRPBf0WZeG9wv/D/ybHLfhtjTwPdBgxm41hirBUhcwjyPP39JMTMtg==
X-Received: by 2002:adf:f350:0:b0:313:e267:8dc with SMTP id
 e16-20020adff350000000b00313e26708dcmr11911917wrp.27.1687967765843; 
 Wed, 28 Jun 2023 08:56:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a5d6986000000b003047dc162f7sm13611880wru.67.2023.06.28.08.56.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:56:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/30] exec/memory: Add symbol for memory listener priority for
 device backend
Date: Wed, 28 Jun 2023 17:53:12 +0200
Message-Id: <20230628155313.71594-30-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add MEMORY_LISTENER_PRIORITY_DEV_BACKEND for the symbolic value
for memory listener to replace the hard-coded value 10 for the
device backend.

No functional change intended.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <8314d91688030d7004e96958f12e2c83fb889245.1687279702.git.isaku.yamahata@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h             | 1 +
 accel/kvm/kvm-all.c               | 2 +-
 hw/remote/proxy-memory-listener.c | 2 +-
 hw/virtio/vhost.c                 | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6d95d59175..4d789461a2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -812,6 +812,7 @@ struct IOMMUMemoryRegion {
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
+#define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
 
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 964f61feee..9d0837a39c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1802,7 +1802,7 @@ static MemoryListener kvm_io_listener = {
     .name = "kvm-io",
     .eventfd_add = kvm_io_ioeventfd_add,
     .eventfd_del = kvm_io_ioeventfd_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND,
 };
 
 int kvm_set_irq(KVMState *s, int irq, int level)
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index 18d96a1d04..a926f61ebe 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -217,7 +217,7 @@ void proxy_memory_listener_configure(ProxyMemoryListener *proxy_listener,
     proxy_listener->listener.commit = proxy_memory_listener_commit;
     proxy_listener->listener.region_add = proxy_memory_listener_region_addnop;
     proxy_listener->listener.region_nop = proxy_memory_listener_region_addnop;
-    proxy_listener->listener.priority = 10;
+    proxy_listener->listener.priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND;
     proxy_listener->listener.name = "proxy";
 
     memory_listener_register(&proxy_listener->listener,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d116c2d6a1..82394331bf 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1444,7 +1444,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .log_sync = vhost_log_sync,
         .log_global_start = vhost_log_global_start,
         .log_global_stop = vhost_log_global_stop,
-        .priority = 10
+        .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND
     };
 
     hdev->iommu_listener = (MemoryListener) {
-- 
2.38.1


