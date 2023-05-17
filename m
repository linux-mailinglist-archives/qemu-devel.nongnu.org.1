Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6299707011
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDo-0007Eb-W1; Wed, 17 May 2023 13:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDi-00076J-ML
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDd-00043E-H6
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07U1cadvQKbzfwknVmjqtMv4mft3/FrIMkIP/Q4GVbo=;
 b=OsqZHbP6j1baL25V72UodafKsA14iSHxWD0s+tQB7to5xLOVcKFPMgMIwAkmJJ37jnK3T+
 uDxtsnrwILRmNU8LxpZ/DbbaG6JF/ckC/IHYeKoooDCMuLoB+hCs/J4IghrF+r4Ugm7L3Y
 pUNE3Ei+2ozh6TPABHSEKzuXNhADAjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-KVpDJ_fUMbWXl7RFM3v6tA-1; Wed, 17 May 2023 13:45:43 -0400
X-MC-Unique: KVpDJ_fUMbWXl7RFM3v6tA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f453ff4cdfso4725255e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345542; x=1686937542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07U1cadvQKbzfwknVmjqtMv4mft3/FrIMkIP/Q4GVbo=;
 b=eCBFsofXiNbxTvCDldW+0PXAjA1ivNmksmf6PZs1bv5pisKXQD+kSYFlkJJnEijtiC
 RHfPbms2SneHlWGytDYVBvPoKpKYfxr94Tqr1WhZ1/yNOCKfqnzmV1e6l28MgYXdq9bI
 EKXX9j7GnuVtUy7jcV1KE1qihu0FlBK7HYni8bQE5nQ7T19LcXSfYUigdKKvpY5lHCBU
 tRXKfmizTJC0d78K3aA2gK/o2ib565dJgPdnU6uleqc/Hdzbs0ilaRh0J5wUpBoVZw0/
 4YbWkuKJHtYt6Zm7a3GtxAhfR3RhKnIakBGA3XfmyX6WjQ/nwvzCSQBYjsZcCj9sMaId
 LnyQ==
X-Gm-Message-State: AC+VfDw+OFZ7d9ctKpm3Ubb/GQfF/ELb8Oxr5toGWFIB0C8omtWdgdgw
 ZLN0S1AUWIXp+h+cHeBWtp/qOX4QvToXUqflhkKYVRp9wOO94a4dmlt9hSG6FJ4DxNpLvL3fk0t
 kNH5ydWw+7tFsLlY/fxKUfLFxVfuyx59tUq4QkZNOmUIHOvCparMNSUxAsPIMFm+FKwqV5/uYEx
 o=
X-Received: by 2002:a7b:cc15:0:b0:3f4:16bc:bd1b with SMTP id
 f21-20020a7bcc15000000b003f416bcbd1bmr26302778wmh.39.1684345542033; 
 Wed, 17 May 2023 10:45:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zE7N0h4V8RuaLsugPrF4qqzvpFWGIMW5yvCWoNJL+zgYZ3wxYtuAeMg2dgQVOvcdsjQmY8Q==
X-Received: by 2002:a7b:cc15:0:b0:3f4:16bc:bd1b with SMTP id
 f21-20020a7bcc15000000b003f416bcbd1bmr26302761wmh.39.1684345541632; 
 Wed, 17 May 2023 10:45:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a05600c311100b003f4283f5c1bsm5178025wmo.2.2023.05.17.10.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: [PULL 11/68] kvm: Synchronize the backup bitmap in the last stage
Date: Wed, 17 May 2023 19:44:23 +0200
Message-Id: <20230517174520.887405-12-pbonzini@redhat.com>
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

In the last stage of live migration or memory slot removal, the
backup bitmap needs to be synchronized when it has been enabled.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20230509022122.20888-3-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 11 +++++++++++
 include/sysemu/kvm_int.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 870abad82681..c3aaabf304d7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1361,6 +1361,10 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                  */
                 if (kvm_state->kvm_dirty_ring_size) {
                     kvm_dirty_ring_reap_locked(kvm_state, NULL);
+                    if (kvm_state->kvm_dirty_ring_with_bitmap) {
+                        kvm_slot_sync_dirty_pages(mem);
+                        kvm_slot_get_dirty_log(kvm_state, mem);
+                    }
                 } else {
                     kvm_slot_get_dirty_log(kvm_state, mem);
                 }
@@ -1582,6 +1586,12 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
         mem = &kml->slots[i];
         if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_slot_sync_dirty_pages(mem);
+
+            if (s->kvm_dirty_ring_with_bitmap && last_stage &&
+                kvm_slot_get_dirty_log(s, mem)) {
+                kvm_slot_sync_dirty_pages(mem);
+            }
+
             /*
              * This is not needed by KVM_GET_DIRTY_LOG because the
              * ioctl will unconditionally overwrite the whole region.
@@ -3710,6 +3720,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
     /* KVM dirty ring is by default off */
     s->kvm_dirty_ring_size = 0;
+    s->kvm_dirty_ring_with_bitmap = false;
     s->notify_vmexit = NOTIFY_VMEXIT_OPTION_RUN;
     s->notify_window = 0;
     s->xen_version = 0;
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a641c974ea54..511b42bde5c4 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -115,6 +115,7 @@ struct KVMState
     } *as;
     uint64_t kvm_dirty_ring_bytes;  /* Size of the per-vcpu dirty ring */
     uint32_t kvm_dirty_ring_size;   /* Number of dirty GFNs per ring */
+    bool kvm_dirty_ring_with_bitmap;
     struct KVMDirtyRingReaper reaper;
     NotifyVmexitOption notify_vmexit;
     uint32_t notify_window;
-- 
2.40.1


