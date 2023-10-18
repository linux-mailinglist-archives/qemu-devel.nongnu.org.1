Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A37CE2FC
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yd-00019u-PK; Wed, 18 Oct 2023 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YP-0000y6-Px
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YN-0007OY-Tl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DXaOVU8n5+rY3kXTuZs/bw/xWaJBo8aerCJ6gbHW0o=;
 b=ARtg98/ZByKAnBA7VvPS3xF/LKmHmrU0NLN0zwXJRjvFPK46Z6JwGRtbtvZmoK581S1/4G
 qC2RF3CiF7t67UvwPWi1jEXknD6j1WIfFR0SnPh1GMPCWcgmst6dmBhZZ43yXBIWdMGaAk
 pNczuEsqUmHX7i7XqSLZtkaK3yilGn0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-JPWNjAXRNvWwDA3DzetKig-1; Wed, 18 Oct 2023 12:37:49 -0400
X-MC-Unique: JPWNjAXRNvWwDA3DzetKig-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9bd86510329so513464966b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647068; x=1698251868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DXaOVU8n5+rY3kXTuZs/bw/xWaJBo8aerCJ6gbHW0o=;
 b=p/yGGEOEkMi94Rxb04xm5u3ItB0z69SbpPSau7XBwLLhzMmv8bI53JNva0J4WTyB/2
 F+5EdX7XtvpyzvFf4XEXT+aYJphkTqc35yob7NeesVaylZC5n9/YE+pbB6r6l7YQUd93
 yMUX1HboLeNeJq+FAe6EN7cBZd1JKEzlPHdsnf5d8jocSFgKG+QrSt92qphJgoIflzyL
 HKrpQXlrUJqEN+PePFMycaZdGp53HkHUawjfrjJxj7966+yPkEkAZUAaKG9atdN+THbU
 XPgnJ3SPqdyLPCsL4hoTOZxLi5OhOKKzJBNOv7PAJHfN9o/Q5s2bWZysbVdgu9FrN/Qf
 dR9A==
X-Gm-Message-State: AOJu0YzDOv89C4S7niBIIqGtqBuz+hhSDARQPetHK0oNyB5E/jvDA5CR
 YVIyklCyi6dm65x5zhDc4zmpb7PuOUwau8x/Ls8HTAl0kEgWQTKbO9IGY5yRMfAF55GnLg39wtr
 AmMURPgw1kaCb+KDvN+i7/B6piA9PPaB9VTAoq/1xnohie0mWaHq5XnjCIWnBX7JnNzgtHGSPa8
 E=
X-Received: by 2002:a05:6402:1e91:b0:53f:6ee5:2cea with SMTP id
 f17-20020a0564021e9100b0053f6ee52ceamr1524623edf.17.1697647068113; 
 Wed, 18 Oct 2023 09:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Er/dZiguoGJamqvqe0Vgr9zQ0V1LEctiEvvcs757WW6KQmFCyLcWQa5uL4zGarZ7mtxHXw==
X-Received: by 2002:a05:6402:1e91:b0:53f:6ee5:2cea with SMTP id
 f17-20020a0564021e9100b0053f6ee52ceamr1524610edf.17.1697647067874; 
 Wed, 18 Oct 2023 09:37:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a508dca000000b005340d9d042bsm3000959edh.40.2023.10.18.09.37.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/17] kvm: unify listeners for PIO address space
Date: Wed, 18 Oct 2023 18:37:19 +0200
Message-ID: <20231018163728.363879-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since we now assume that ioeventfds are present, kvm_io_listener is always
registered.  Merge it with kvm_coalesced_pio_listener in a single
listener.  Since PIO space does not have KVM memslots attached to it,
the priority is irrelevant.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120051da649..b59a48da924 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1105,13 +1105,6 @@ static void kvm_coalesce_pio_del(MemoryListener *listener,
      }
 }
 
-static MemoryListener kvm_coalesced_pio_listener = {
-    .name = "kvm-coalesced-pio",
-    .coalesced_io_add = kvm_coalesce_pio_add,
-    .coalesced_io_del = kvm_coalesce_pio_del,
-    .priority = MEMORY_LISTENER_PRIORITY_MIN,
-};
-
 int kvm_check_extension(KVMState *s, unsigned int extension)
 {
     int ret;
@@ -1768,6 +1761,8 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 
 static MemoryListener kvm_io_listener = {
     .name = "kvm-io",
+    .coalesced_io_add = kvm_coalesce_pio_add,
+    .coalesced_io_del = kvm_coalesce_pio_del,
     .eventfd_add = kvm_io_ioeventfd_add,
     .eventfd_del = kvm_io_ioeventfd_del,
     .priority = MEMORY_LISTENER_PRIORITY_DEV_BACKEND,
@@ -2598,8 +2593,6 @@ static int kvm_init(MachineState *ms)
                                  &address_space_memory, 0, "kvm-memory");
     memory_listener_register(&kvm_io_listener,
                              &address_space_io);
-    memory_listener_register(&kvm_coalesced_pio_listener,
-                             &address_space_io);
 
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
     if (!s->sync_mmu) {
-- 
2.41.0


