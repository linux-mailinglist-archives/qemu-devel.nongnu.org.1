Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3807E1E9A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:40:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzx1o-0001Qm-Pe; Mon, 06 Nov 2023 05:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+aa7b7dce24b49c47a83c+7379+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qzx1h-0001QW-Sl; Mon, 06 Nov 2023 05:40:13 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+aa7b7dce24b49c47a83c+7379+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qzx1d-0007hU-So; Mon, 06 Nov 2023 05:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=bUIwWhSmxxhL6AS/9ZXbE9mq6OB7mrxWvKvI7fmMtUk=; b=PKghrx40QFAYvqzmoIilm9wA2v
 pxZ4oYhwBBymCgCvc2Usep0OkshnQ9Rwj2ML4rAPFff0nwvxNOOgCpLIhKFfZopoZz6V8n3pnLQ5d
 CMv725X/ZTTpYldzx15AzhXXWx2ND9Dt4ek5Uy9Vt1nPHDw6LewWuAuFU+bLiEYuYfK8bfOxlxsN2
 SFAeRgy0QbzGk+nFD7rctc7gjWEhxy/Z7fYhfXO/rBWJ/ZlNLlGf4sCrEboyJupti1CBCOlqROAdf
 M3mlUGHG2Yl8MCbvml+3PT7xKfd/AMvTSKDHLPPs2e8R537YDpdqMY5HwnN8efhApCB97O/WgTONw
 tmskLnaA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qzx1R-00ARzu-0T; Mon, 06 Nov 2023 10:39:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1qzx1P-000qG1-2r; Mon, 06 Nov 2023 10:39:55 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org
Subject: [PULL 2/7] i386/xen: fix per-vCPU upcall vector for Xen emulation
Date: Mon,  6 Nov 2023 10:39:50 +0000
Message-ID: <20231106103955.200867-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106103955.200867-1-dwmw2@infradead.org>
References: <20231106103955.200867-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+aa7b7dce24b49c47a83c+7379+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

The per-vCPU upcall vector support had three problems. Firstly it was
using the wrong hypercall argument and would always return -EFAULT when
the guest tried to set it up. Secondly it was using the wrong ioctl() to
pass the vector to the kernel and thus the *kernel* would always return
-EINVAL. Finally, even when delivering the event directly from userspace
with an MSI, it put the destination CPU ID into the wrong bits of the
MSI address.

Linux doesn't (yet) use this mode so it went without decent testing
for a while.

Cc: qemu-stable@nongnu.org
Fixes: 105b47fdf2d0 ("i386/xen: implement HVMOP_set_evtchn_upcall_vector")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 target/i386/kvm/xen-emu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 0055441b2e..7c504d9fa4 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -306,7 +306,7 @@ static int kvm_xen_set_vcpu_callback_vector(CPUState *cs)
 
     trace_kvm_xen_set_vcpu_callback(cs->cpu_index, vector);
 
-    return kvm_vcpu_ioctl(cs, KVM_XEN_HVM_SET_ATTR, &xva);
+    return kvm_vcpu_ioctl(cs, KVM_XEN_VCPU_SET_ATTR, &xva);
 }
 
 static void do_set_vcpu_callback_vector(CPUState *cs, run_on_cpu_data data)
@@ -440,7 +440,8 @@ void kvm_xen_inject_vcpu_callback_vector(uint32_t vcpu_id, int type)
          * deliver it as an MSI.
          */
         MSIMessage msg = {
-            .address = APIC_DEFAULT_ADDRESS | X86_CPU(cs)->apic_id,
+            .address = APIC_DEFAULT_ADDRESS |
+                       (X86_CPU(cs)->apic_id << MSI_ADDR_DEST_ID_SHIFT),
             .data = vector | (1UL << MSI_DATA_LEVEL_SHIFT),
         };
         kvm_irqchip_send_msi(kvm_state, msg);
@@ -849,8 +850,7 @@ static bool kvm_xen_hcall_hvm_op(struct kvm_xen_exit *exit, X86CPU *cpu,
     int ret = -ENOSYS;
     switch (cmd) {
     case HVMOP_set_evtchn_upcall_vector:
-        ret = kvm_xen_hcall_evtchn_upcall_vector(exit, cpu,
-                                                 exit->u.hcall.params[0]);
+        ret = kvm_xen_hcall_evtchn_upcall_vector(exit, cpu, arg);
         break;
 
     case HVMOP_pagetable_dying:
-- 
2.41.0


