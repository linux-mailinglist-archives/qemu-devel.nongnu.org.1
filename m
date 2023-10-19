Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A766E7CFE4E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:41:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtV8d-0002Dk-9A; Thu, 19 Oct 2023 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtV8Y-00028W-A6; Thu, 19 Oct 2023 11:40:38 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtV8T-0001jL-Gx; Thu, 19 Oct 2023 11:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=yj3bQOsvlVS+cuxN5wPLkNEIrT6cixfjryf2/rFkYPo=; b=apmrUQjys+v5rup9nz+m2AM5cJ
 2Y2A05kFFcMK4lO0kAHJWQYvJuY7yW0Mbcd6xBkSdi7dZE8UYfHwT+MsBjpnPbxyw76XY0z6pWZIQ
 /Xbt2G1fOgOADjjv0bJg895NrBPYCnkgVjKTWWOXLkLH7it8HqWs9l/FFJgQ/mUgEiAcalOp8D8Wy
 qH7vnVOom93dI6oaB21y/lpt2E7eoveScrTU88jzuNmmhGwUA3Tinnyl0/mIZt9MdWKMLq3ME3d3a
 hd4UWY3+BnlXQGAEpOmqrAsqGKgxLgM6NjTY7kgwl4SAKcduwn8Pjydd4w/+pVV6+TRVb9aodRCJm
 9DCTuMag==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qtV8M-009yCk-2Y; Thu, 19 Oct 2023 15:40:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtV8L-000Pto-2c; Thu, 19 Oct 2023 16:40:25 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v2 03/24] hw/xen: select kernel mode for per-vCPU event
 channel upcall vector
Date: Thu, 19 Oct 2023 16:39:59 +0100
Message-Id: <20231019154020.99080-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019154020.99080-1-dwmw2@infradead.org>
References: <20231019154020.99080-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

A guest which has configured the per-vCPU upcall vector may set the
HVM_PARAM_CALLBACK_IRQ param to fairly much anything other than zero.

For example, Linux v6.0+ after commit b1c3497e604 ("x86/xen: Add support
for HVMOP_set_evtchn_upcall_vector") will just do this after setting the
vector:

       /* Trick toolstack to think we are enlightened. */
       if (!cpu)
               rc = xen_set_callback_via(1);

That's explicitly setting the delivery to GSI#1, but it's supposed to be
overridden by the per-vCPU vector setting. This mostly works in Qemu
*except* for the logic to enable the in-kernel handling of event channels,
which falsely determines that the kernel cannot accelerate GSI delivery
in this case.

Add a kvm_xen_has_vcpu_callback_vector() to report whether vCPU#0 has
the vector set, and use that in xen_evtchn_set_callback_param() to
enable the kernel acceleration features even when the param *appears*
to be set to target a GSI.

Preserve the Xen behaviour that when HVM_PARAM_CALLBACK_IRQ is set to
*zero* the event channel delivery is disabled completely. (Which is
what that bizarre guest behaviour is working round in the first place.)

Fixes: 91cce756179 ("hw/xen: Add xen_evtchn device for event channel emulation")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c  | 6 ++++++
 include/sysemu/kvm_xen.h  | 1 +
 target/i386/kvm/xen-emu.c | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index a731738411..3d6f4b4a0a 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -490,6 +490,12 @@ int xen_evtchn_set_callback_param(uint64_t param)
         break;
     }
 
+    /* If the guest has set a per-vCPU callback vector, prefer that. */
+    if (gsi && kvm_xen_has_vcpu_callback_vector()) {
+        in_kernel = kvm_xen_has_cap(EVTCHN_SEND);
+        gsi = 0;
+    }
+
     if (!ret) {
         /* If vector delivery was turned *off* then tell the kernel */
         if ((s->callback_param >> CALLBACK_VIA_TYPE_SHIFT) ==
diff --git a/include/sysemu/kvm_xen.h b/include/sysemu/kvm_xen.h
index 595abfbe40..961c702c4e 100644
--- a/include/sysemu/kvm_xen.h
+++ b/include/sysemu/kvm_xen.h
@@ -22,6 +22,7 @@
 int kvm_xen_soft_reset(void);
 uint32_t kvm_xen_get_caps(void);
 void *kvm_xen_get_vcpu_info_hva(uint32_t vcpu_id);
+bool kvm_xen_has_vcpu_callback_vector(void);
 void kvm_xen_inject_vcpu_callback_vector(uint32_t vcpu_id, int type);
 void kvm_xen_set_callback_asserted(void);
 int kvm_xen_set_vcpu_virq(uint32_t vcpu_id, uint16_t virq, uint16_t port);
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 619240398a..3ba636b09a 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -424,6 +424,13 @@ void kvm_xen_set_callback_asserted(void)
     }
 }
 
+bool kvm_xen_has_vcpu_callback_vector(void)
+{
+    CPUState *cs = qemu_get_cpu(0);
+
+    return cs && !!X86_CPU(cs)->env.xen_vcpu_callback_vector;
+}
+
 void kvm_xen_inject_vcpu_callback_vector(uint32_t vcpu_id, int type)
 {
     CPUState *cs = qemu_get_cpu(vcpu_id);
-- 
2.40.1


