Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FCC706FF0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDq-0007Ia-S9; Wed, 17 May 2023 13:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDl-0007Ad-RG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDh-000441-Ru
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWI/FfXhzmsdFzS5ZamSzT7nRGEgUVsEby4QhBkFkpg=;
 b=M0ERZkYV8WO2ZqX2b3Y2GRO675RRlYLFs1rLsKu0UMyRW5lhRYEQJXDxFpD1PM14Cn/+cg
 dHbQYZnadJi6bhgDtt7evFjLE7kltS5ljkdeh+dbIdmXRmnSzfasjFSr/SmKkKkDwZrheG
 ugY4ll8XIQ8q5tkIJOS1MvAawpROHzk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-h1Ai2MZ9NGqoHMoJcgFxzQ-1; Wed, 17 May 2023 13:45:46 -0400
X-MC-Unique: h1Ai2MZ9NGqoHMoJcgFxzQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30635d18e55so432089f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345545; x=1686937545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWI/FfXhzmsdFzS5ZamSzT7nRGEgUVsEby4QhBkFkpg=;
 b=kScJ6ga/5j2vtUl79jUyt5qsTUbsZ3JdNPJiGs/WwyEd8qB2isBEOX1EAqkMgdRinK
 M05O+iZ/PLJPeuwN/ta2SdQ9S71do3meYjKwilN3kVb9D1gOlfI0TEgah9U17Juyp6Q5
 YIvNmno7dd/OyI7YFsdnH9zQ/HV1zPv0U8GpGEIhaiGkksw6bwFEQlSaap/BOimFBWcM
 5t6yfE9LsbewBA9j2ieb3mv8+lshJu1hAsvLhAkq9I6DP0pMhXZh2SdoqqCkiSFycKKQ
 oBgZoYhKDcfCNVfNHL4f3sdJgVOVmuQhneXyXMEFn02+DZDlr6f8dnMZ/Q2hPEHSWeRn
 iyhQ==
X-Gm-Message-State: AC+VfDzCtVxZ8d0pS0SLjNfMMN9aC7Jf4PDgeOe1cJIcwwDqxuH7/lw4
 fezYLmcfVHnmxcf5k4namy4bWAmrnUgxpW3i6pIsnnZZA03HGp66VrFN+cIoALgwelCRVCip+sD
 njGLYarIV0yw1OJQPGL89uMk2kSf4dG7dR/M5TQcFh4fnljCC3wkfl3HRSvqEYJz0JtivEXIbYp
 g=
X-Received: by 2002:a5d:63c3:0:b0:306:321c:995b with SMTP id
 c3-20020a5d63c3000000b00306321c995bmr1389523wrw.41.1684345545246; 
 Wed, 17 May 2023 10:45:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HzeSCoNPoEzd1Fu6GWtuKruxwlD01zD2hTxhFOyYGHqvz1O2MMF/mSN1tPqi9K2IdPcqOfw==
X-Received: by 2002:a5d:63c3:0:b0:306:321c:995b with SMTP id
 c3-20020a5d63c3000000b00306321c995bmr1389507wrw.41.1684345544879; 
 Wed, 17 May 2023 10:45:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a1c7203000000b003f4285629casm2863819wmc.42.2023.05.17.10.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 13/68] kvm: Enable dirty ring for arm64
Date: Wed, 17 May 2023 19:44:25 +0200
Message-Id: <20230517174520.887405-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Gavin Shan <gshan@redhat.com>

arm64 has different capability from x86 to enable the dirty ring, which
is KVM_CAP_DIRTY_LOG_RING_ACQ_REL. Besides, arm64 also needs the backup
bitmap extension (KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP) when 'kvm-arm-gicv3'
or 'arm-its-kvm' device is enabled. Here the extension is always enabled
and the unnecessary overhead to do the last stage of dirty log synchronization
when those two devices aren't used is introduced, but the overhead should
be very small and acceptable. The benefit is cover future cases where those
two devices are used without modifying the code.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20230509022122.20888-5-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d0de9d0a8f8..7679f397aec0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1466,6 +1466,7 @@ static int kvm_dirty_ring_init(KVMState *s)
 {
     uint32_t ring_size = s->kvm_dirty_ring_size;
     uint64_t ring_bytes = ring_size * sizeof(struct kvm_dirty_gfn);
+    unsigned int capability = KVM_CAP_DIRTY_LOG_RING;
     int ret;
 
     s->kvm_dirty_ring_size = 0;
@@ -1480,7 +1481,12 @@ static int kvm_dirty_ring_init(KVMState *s)
      * Read the max supported pages. Fall back to dirty logging mode
      * if the dirty ring isn't supported.
      */
-    ret = kvm_vm_check_extension(s, KVM_CAP_DIRTY_LOG_RING);
+    ret = kvm_vm_check_extension(s, capability);
+    if (ret <= 0) {
+        capability = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
+        ret = kvm_vm_check_extension(s, capability);
+    }
+
     if (ret <= 0) {
         warn_report("KVM dirty ring not available, using bitmap method");
         return 0;
@@ -1493,13 +1499,26 @@ static int kvm_dirty_ring_init(KVMState *s)
         return -EINVAL;
     }
 
-    ret = kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0, ring_bytes);
+    ret = kvm_vm_enable_cap(s, capability, 0, ring_bytes);
     if (ret) {
         error_report("Enabling of KVM dirty ring failed: %s. "
                      "Suggested minimum value is 1024.", strerror(-ret));
         return -EIO;
     }
 
+    /* Enable the backup bitmap if it is supported */
+    ret = kvm_vm_check_extension(s, KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP);
+    if (ret > 0) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP, 0);
+        if (ret) {
+            error_report("Enabling of KVM dirty ring's backup bitmap failed: "
+                         "%s. ", strerror(-ret));
+            return -EIO;
+        }
+
+        s->kvm_dirty_ring_with_bitmap = true;
+    }
+
     s->kvm_dirty_ring_size = ring_size;
     s->kvm_dirty_ring_bytes = ring_bytes;
 
-- 
2.40.1


