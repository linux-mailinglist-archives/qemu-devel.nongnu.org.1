Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775927CE2F4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9YM-0000we-3V; Wed, 18 Oct 2023 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YI-0000wB-Qt
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YH-0007Ni-3Z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+b8spVZmCeWJIopjPtBaEljKehMV+lwxnBnfvcJB1w4=;
 b=RMCfCHuNX20CW0c399enFw3Zpc1fIwnITA7Cx017VrzBgeyAeNCuGs6BSu9g9qQPvlVwc/
 xxm1i2vmmRtPZZCRyAb9HCPbZUq2vZUBur05u8g3+s1XqSBOHi8bloCOs5Fw6Uzicp6J4Y
 CH/rIGQSd9mrMuR7kKEOubH7B+Lzx2I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-NMBjjvBZPLiu4v80khBILg-1; Wed, 18 Oct 2023 12:37:42 -0400
X-MC-Unique: NMBjjvBZPLiu4v80khBILg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53db360296eso5544391a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647060; x=1698251860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+b8spVZmCeWJIopjPtBaEljKehMV+lwxnBnfvcJB1w4=;
 b=G5t2yL/efE7jOgC2PuBM6SLJCiiVTkx8V0eNUIhiFNKyzyVWBtL68zpH2kywPjI31Y
 VG4oo4nIMN0uv67bZLmQcyRBJPIB2UFn7NqZ3r8ryeeQEnYXuZtrW40JLwX3jmAA7/ix
 dLpy64RzbEIBR0obNeY95NqTZFlSbYtqcacB75lWRlWfxJj6l0Ne0mRkPWZlSrfgUZhl
 Yf3eTfx9e3zyuVBwzVofhFmdK04q+18bukqXJzwGv+1Sp+BynGhbPjoAmXUs+00mjumQ
 Ovfw0mv0XBPKeftn0izyElJiKjJVKal/CvvUSNlpsiVYG562EcTohULr3MovpPGsXiLG
 Eljw==
X-Gm-Message-State: AOJu0Yzoq1iJBtDlLo/uR0BC/NYQSEbN/M/NaygyT5Q1alur846F/u2i
 9Tb06RJXLc3nlkOtTyhhoB/GCBFAQgCqMHTFKjmn6lRl5OTWFRZ92VJ3FxRPir4K3AtWj8RdTQC
 peOWkhJTJN6RYwp7ZPBwUt0qZlXFHdBymA7SO8fSIySK461v/iU79U2d9XNHKkgLl5C1fWOcGkr
 A=
X-Received: by 2002:a05:6402:2712:b0:53f:72a7:5ae with SMTP id
 y18-20020a056402271200b0053f72a705aemr1090887edd.12.1697647060681; 
 Wed, 18 Oct 2023 09:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeOwt6LpscAh14wC4ySX7g1Oy8ihY7TC6wlm3NH8E4IwkLjEEJ06UFEdoWuQ1cjdFh2K+OrA==
X-Received: by 2002:a05:6402:2712:b0:53f:72a7:5ae with SMTP id
 y18-20020a056402271200b0053f72a705aemr1090878edd.12.1697647060298; 
 Wed, 18 Oct 2023 09:37:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 u27-20020a50a41b000000b0053dd798e38asm3108190edb.69.2023.10.18.09.37.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/17] kvm: assume that many ioeventfds can be created
Date: Wed, 18 Oct 2023 18:37:17 +0200
Message-ID: <20231018163728.363879-7-pbonzini@redhat.com>
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

NR_IOBUS_DEVS was increased to 200 in Linux 2.6.34.  By Linux 3.5 it had
increased to 1000 and later ioeventfds were changed to not count against
the limit.  But the earlier limit of 200 would already be enough for
kvm_check_many_ioeventfds() to be true, so remove the check.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      | 47 ----------------------------------------
 accel/stubs/kvm-stub.c   |  5 -----
 hw/virtio/virtio-pci.c   |  4 ----
 include/sysemu/kvm.h     |  1 -
 include/sysemu/kvm_int.h |  1 -
 5 files changed, 58 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 50717a0d634..05be687be1b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1253,43 +1253,6 @@ static int kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint16_t val,
 }
 
 
-static int kvm_check_many_ioeventfds(void)
-{
-    /* Userspace can use ioeventfd for io notification.  This requires a host
-     * that supports eventfd(2) and an I/O thread; since eventfd does not
-     * support SIGIO it cannot interrupt the vcpu.
-     *
-     * Older kernels have a 6 device limit on the KVM io bus.  Find out so we
-     * can avoid creating too many ioeventfds.
-     */
-#if defined(CONFIG_EVENTFD)
-    int ioeventfds[7];
-    int i, ret = 0;
-    for (i = 0; i < ARRAY_SIZE(ioeventfds); i++) {
-        ioeventfds[i] = eventfd(0, EFD_CLOEXEC);
-        if (ioeventfds[i] < 0) {
-            break;
-        }
-        ret = kvm_set_ioeventfd_pio(ioeventfds[i], 0, i, true, 2, true);
-        if (ret < 0) {
-            close(ioeventfds[i]);
-            break;
-        }
-    }
-
-    /* Decide whether many devices are supported or not */
-    ret = i == ARRAY_SIZE(ioeventfds);
-
-    while (i-- > 0) {
-        kvm_set_ioeventfd_pio(ioeventfds[i], 0, i, false, 2, true);
-        close(ioeventfds[i]);
-    }
-    return ret;
-#else
-    return 0;
-#endif
-}
-
 static const KVMCapabilityInfo *
 kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
 {
@@ -2648,8 +2611,6 @@ static int kvm_init(MachineState *ms)
     memory_listener_register(&kvm_coalesced_pio_listener,
                              &address_space_io);
 
-    s->many_ioeventfds = kvm_check_many_ioeventfds();
-
     s->sync_mmu = !!kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
     if (!s->sync_mmu) {
         ret = ram_block_discard_disable(true);
@@ -3218,14 +3179,6 @@ int kvm_max_nested_state_length(void)
     return kvm_state->max_nested_state_len;
 }
 
-int kvm_has_many_ioeventfds(void)
-{
-    if (!kvm_enabled()) {
-        return 0;
-    }
-    return kvm_state->many_ioeventfds;
-}
-
 int kvm_has_gsi_routing(void)
 {
 #ifdef KVM_CAP_IRQ_ROUTING
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 19d58f2778f..b2d8885853f 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -40,11 +40,6 @@ bool kvm_has_sync_mmu(void)
     return false;
 }
 
-int kvm_has_many_ioeventfds(void)
-{
-    return 0;
-}
-
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
     return 1;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index abebd0075a6..a851c67bdd3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2096,10 +2096,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
 
-    if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
-        proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
-    }
-
     /* fd-based ioevents can't be synchronized in record/replay */
     if (replay_mode != REPLAY_MODE_NONE) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index aa299396fba..15c427f6e09 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -213,7 +213,6 @@ int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
 int kvm_max_nested_state_length(void);
-int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 
 /**
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 817238b9582..840b905a2e9 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -84,7 +84,6 @@ struct KVMState
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
     int max_nested_state_len;
-    int many_ioeventfds;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-- 
2.41.0


