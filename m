Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4F70700F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDq-0007GP-Du; Wed, 17 May 2023 13:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDl-0007Ac-RD
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDh-00043e-JS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMzrIIUF3Z35KfZhCoLyC7JIwz17iRzsNwnLIod0RBw=;
 b=aXMkclhxod42DEI+MuLBiYoFM5UbsqegF77XHPY30H4KPZwLIEdkYrAYnb8INNV+WY800J
 tGWCKMSAVbP3+cpO7HYnZyB9YTcZBl7E+I8dwNJnYBteX2heBjVdFuCZ1ePksX2KaOarpr
 yrBgh96vzuNuelYl3hLRF3om4tyfv5E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-prQ43NXkO2uvc-zUNOoM7g-1; Wed, 17 May 2023 13:45:45 -0400
X-MC-Unique: prQ43NXkO2uvc-zUNOoM7g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30889491b4aso188242f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345543; x=1686937543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMzrIIUF3Z35KfZhCoLyC7JIwz17iRzsNwnLIod0RBw=;
 b=EngO9LkGpZQRxigMUWTHEkzNy38bsZv+kpRtLZ0Ejets20wVDraMF4++6pZ3cnjGDG
 MIea5djClTnRGlowI3I3fPk1Uw1uFyr8ZGWOwVhxRD94TJJ0KGyfPwEDGylwdpu+N84N
 p8qa5Q5M1AAl1jfCkcHbLGAMcXOh48HhHuUnxdO8kQ8dx46UCBTvn2U4hq8RPTUFLQLt
 aybgVFAwR9MjbbRkLjRxmUrxKXvSObeZjg0jdeRAEXUb5D3ZZjl1yR0T5EB/WbcuUaeI
 dZIppZThS3MgJhYJhzt3LnEoZrYqg+5AC6EEciPzXEIA1avapF2Ss4OgRdMw0T+RNeJi
 0n6w==
X-Gm-Message-State: AC+VfDwmATonyzCvj2gUXDogDyXSWrdRabG353gvMYnr7zv+rpp/ojDf
 Yxtwn7Y9+str7uxxuqnBSa78uRFkgCka8IMRF4KE09fLL4gnuu7wh9MVR/CBGp/3OPrkvzML3HE
 PuYp737wFBzIpmgtFhYEWF66iMV2qPvBtQbbLe/RG5y5fPVAUC5T7Om//Pbmh8MetIBFUHZU3ib
 I=
X-Received: by 2002:adf:fc52:0:b0:2fc:3596:7392 with SMTP id
 e18-20020adffc52000000b002fc35967392mr1091589wrs.24.1684345543670; 
 Wed, 17 May 2023 10:45:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sJePfDAAezHaiFoFAvMw7V53hF6MTRDTPcUxIMpXWpHcumGZJrqaLoT5lUWcmDURGPHDH9Q==
X-Received: by 2002:adf:fc52:0:b0:2fc:3596:7392 with SMTP id
 e18-20020adffc52000000b002fc35967392mr1091571wrs.24.1684345543294; 
 Wed, 17 May 2023 10:45:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j11-20020adff54b000000b003062c609115sm3469172wrp.21.2023.05.17.10.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: [PULL 12/68] kvm: Add helper kvm_dirty_ring_init()
Date: Wed, 17 May 2023 19:44:24 +0200
Message-Id: <20230517174520.887405-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

Due to multiple capabilities associated with the dirty ring for different
architectures: KVM_CAP_DIRTY_{LOG_RING, LOG_RING_ACQ_REL} for x86 and
arm64 separately. There will be more to be done in order to support the
dirty ring for arm64.

Lets add helper kvm_dirty_ring_init() to enable the dirty ring. With this,
the code looks a bit clean.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20230509022122.20888-4-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 76 ++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c3aaabf304d7..5d0de9d0a8f8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1462,6 +1462,50 @@ static int kvm_dirty_ring_reaper_init(KVMState *s)
     return 0;
 }
 
+static int kvm_dirty_ring_init(KVMState *s)
+{
+    uint32_t ring_size = s->kvm_dirty_ring_size;
+    uint64_t ring_bytes = ring_size * sizeof(struct kvm_dirty_gfn);
+    int ret;
+
+    s->kvm_dirty_ring_size = 0;
+    s->kvm_dirty_ring_bytes = 0;
+
+    /* Bail if the dirty ring size isn't specified */
+    if (!ring_size) {
+        return 0;
+    }
+
+    /*
+     * Read the max supported pages. Fall back to dirty logging mode
+     * if the dirty ring isn't supported.
+     */
+    ret = kvm_vm_check_extension(s, KVM_CAP_DIRTY_LOG_RING);
+    if (ret <= 0) {
+        warn_report("KVM dirty ring not available, using bitmap method");
+        return 0;
+    }
+
+    if (ring_bytes > ret) {
+        error_report("KVM dirty ring size %" PRIu32 " too big "
+                     "(maximum is %ld).  Please use a smaller value.",
+                     ring_size, (long)ret / sizeof(struct kvm_dirty_gfn));
+        return -EINVAL;
+    }
+
+    ret = kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0, ring_bytes);
+    if (ret) {
+        error_report("Enabling of KVM dirty ring failed: %s. "
+                     "Suggested minimum value is 1024.", strerror(-ret));
+        return -EIO;
+    }
+
+    s->kvm_dirty_ring_size = ring_size;
+    s->kvm_dirty_ring_bytes = ring_bytes;
+
+    return 0;
+}
+
 static void kvm_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
@@ -2531,35 +2575,9 @@ static int kvm_init(MachineState *ms)
      * Enable KVM dirty ring if supported, otherwise fall back to
      * dirty logging mode
      */
-    if (s->kvm_dirty_ring_size > 0) {
-        uint64_t ring_bytes;
-
-        ring_bytes = s->kvm_dirty_ring_size * sizeof(struct kvm_dirty_gfn);
-
-        /* Read the max supported pages */
-        ret = kvm_vm_check_extension(s, KVM_CAP_DIRTY_LOG_RING);
-        if (ret > 0) {
-            if (ring_bytes > ret) {
-                error_report("KVM dirty ring size %" PRIu32 " too big "
-                             "(maximum is %ld).  Please use a smaller value.",
-                             s->kvm_dirty_ring_size,
-                             (long)ret / sizeof(struct kvm_dirty_gfn));
-                ret = -EINVAL;
-                goto err;
-            }
-
-            ret = kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0, ring_bytes);
-            if (ret) {
-                error_report("Enabling of KVM dirty ring failed: %s. "
-                             "Suggested minimum value is 1024.", strerror(-ret));
-                goto err;
-            }
-
-            s->kvm_dirty_ring_bytes = ring_bytes;
-         } else {
-             warn_report("KVM dirty ring not available, using bitmap method");
-             s->kvm_dirty_ring_size = 0;
-        }
+    ret = kvm_dirty_ring_init(s);
+    if (ret < 0) {
+        goto err;
     }
 
     /*
-- 
2.40.1


