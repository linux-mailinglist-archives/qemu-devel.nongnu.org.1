Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C54277D788C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnIX-0002KA-1r; Wed, 25 Oct 2023 19:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIG-00026l-FS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIE-0005Jl-Rr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6A20MjFucaAoQ3NyQil4EGu/6+7+QedBIOkFjA6UQcY=;
 b=J79jsGqL1m3TxZLsdNSKGdDHY/Tshft/bwnZcAz50Nhw0+Cc0JvyPHBM9RfzzcLX6FSnxB
 UHjIa+Tc4wvlx3DKJjY7Vue4bNcuTifQ1i6AYWZaaZph9Px5NAAbiMJizN5H3CIW3+jGAY
 RInohN0D2Y7+y5T9/wLwQDMbpfmMd10=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-mw9De3oXMrSvxxvLuJfScg-1; Wed, 25 Oct 2023 19:27:51 -0400
X-MC-Unique: mw9De3oXMrSvxxvLuJfScg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d4aa946ceso4176296d6.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276470; x=1698881270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6A20MjFucaAoQ3NyQil4EGu/6+7+QedBIOkFjA6UQcY=;
 b=NaW6zESvZcbgy57rDeCdtk1IJ3Laxfi3pFR7hLQUrXrWoX6j8EErJ/2ABWIOrzeqGC
 C1p4m92tbYE7Va0TiNwjxSlpf9hfFVVttZN/M4hliH+kU9DE0M9vgOMLT3viJq9dUz0j
 CTzLJKT9Hb8Bg8x+zfVUBCh04eBBk9a09F1jJt3PsLGOFieSB1GhFKtJT3fdLk7Zwliu
 JduK350DprbLJx67D4DLSv4sDFfA4ThtRFP8v/kg8WO9fojmpd8X6mzi+gTqAXxY94wa
 1krEnRmPSsS+wBBwlJC0jZ9DdKr3y31EJkAvrvSFv0tHZNtUdT/zY4CCeQXIfbOI0+3O
 5O1g==
X-Gm-Message-State: AOJu0YxAOE8dJUXmBxWxYBFYRl6vuPPG+Z1F/odPz1hN4q3f0y8FS5Ol
 2MH9DgRTDvxdlv27zceHXTfbzFdDDAH3NkACMD3/kkBJ6Q+0QvzUj5k1R39to9+fkHHzGePPnU3
 HnvQO2K069tLfv0GcaMj1zvm7Kprl9L8Pu3bl/fckO2ejWEOJniQVJaQ8MVpZsAnouCU+4ma5en
 4=
X-Received: by 2002:a0c:e907:0:b0:656:48e3:7afe with SMTP id
 a7-20020a0ce907000000b0065648e37afemr1577519qvo.17.1698276470564; 
 Wed, 25 Oct 2023 16:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI9a29SEt22eM7TG7vivuGCGpyPP4roDWDsJyFrGiPeOydrBtpZ1NSZK+LYKjWsrqaqIpOBA==
X-Received: by 2002:a0c:e907:0:b0:656:48e3:7afe with SMTP id
 a7-20020a0ce907000000b0065648e37afemr1577507qvo.17.1698276470277; 
 Wed, 25 Oct 2023 16:27:50 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 oo17-20020a05620a531100b0076f19b9e96fsm4555852qkn.107.2023.10.25.16.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 16/24] kvm: unify listeners for PIO address space
Date: Thu, 26 Oct 2023 01:27:09 +0200
Message-ID: <20231025232718.89428-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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


