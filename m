Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8B7E94C3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 03:27:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Mcs-0006V5-OM; Sun, 12 Nov 2023 21:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1r2Mcq-0006TL-LD
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 21:24:32 -0500
Received: from smtp-190e.mail.infomaniak.ch ([185.125.25.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1r2Mco-00088n-Lb
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 21:24:32 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4STCtM4fDdzMpvbm;
 Mon, 13 Nov 2023 02:24:27 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4STCtL2gRXzMpnPj; Mon, 13 Nov 2023 03:24:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
 s=20191114; t=1699842267;
 bh=ch9T7FXLfTJgFWbno30mYt9y51RERoKANoOanV/XFpA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=naLeBV79e37SdDz+D/dS7uyrmwvygGCWlJc+XJuRQzMv5XfDFnAdIMM6Uid+A4GTN
 RAhlLTNQ/RTX6yjhoengNgNRl5DnbJYrC4WmjoGlHXKyNa50wVn5zQJnJq4Mtvmw+J
 D2bNNNOJvWidC6klDm91oW1hugsA6v5+ManBoxf4=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Alexander Graf <graf@amazon.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>,
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
 =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zahra Tarkhani <ztarkhani@microsoft.com>,
 =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: [RFC PATCH v2 09/19] KVM: x86: Extend
 kvm_range_has_memory_attributes() with match_all
Date: Sun, 12 Nov 2023 21:23:16 -0500
Message-ID: <20231113022326.24388-10-mic@digikod.net>
In-Reply-To: <20231113022326.24388-1-mic@digikod.net>
References: <20231113022326.24388-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=185.125.25.14; envelope-from=mic@digikod.net;
 helo=smtp-190e.mail.infomaniak.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This enables to check if an attribute is tied to any memory page in a
range. This will be useful in a folling commit to check for
KVM_MEMORY_ATTRIBUTE_HEKI_IMMUTABLE.

Cc: Chao Peng <chao.p.peng@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
* New patch
---
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 27 ++++++++++++++++++---------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d7010e09440d..2024ff21d036 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7279,7 +7279,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
 
 	if (level == PG_LEVEL_2M)
-		return kvm_range_has_memory_attributes(kvm, start, end, attrs);
+		return kvm_range_has_memory_attributes(kvm, start, end, attrs, true);
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index de68390ab0f2..9ecb016a336f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2391,7 +2391,7 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
 }
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attrs);
+				     unsigned long attrs, bool match_all);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e2c178db17d5..67dbaaf40c1c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2435,11 +2435,11 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 /*
- * Returns true if _all_ gfns in the range [@start, @end) have attributes
- * matching the @attrs bitmask.
+ * According to @match_all, returns true if _all_ (respectively _any_) gfns in
+ * the range [@start, @end) have attributes matching the @attrs bitmask.
  */
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attrs)
+				     unsigned long attrs, bool match_all)
 {
 	XA_STATE(xas, &kvm->mem_attr_array, start);
 	unsigned long index;
@@ -2453,16 +2453,25 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		goto out;
 	}
 
-	has_attrs = true;
+	has_attrs = match_all;
 	for (index = start; index < end; index++) {
 		do {
 			entry = xas_next(&xas);
 		} while (xas_retry(&xas, entry));
 
-		if (xas.xa_index != index ||
-		    (xa_to_value(entry) & attrs) != attrs) {
-			has_attrs = false;
-			break;
+		if (match_all) {
+			if (xas.xa_index != index ||
+			    (xa_to_value(entry) & attrs) != attrs) {
+				has_attrs = false;
+				break;
+			}
+		} else {
+			index = xas.xa_index;
+			if (index < end &&
+			    (xa_to_value(entry) & attrs) == attrs) {
+				has_attrs = true;
+				break;
+			}
 		}
 	}
 
@@ -2578,7 +2587,7 @@ int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	lockdep_assert_held(&kvm->slots_arch_lock);
 
 	/* Nothing to do if the entire range as the desired attributes. */
-	if (kvm_range_has_memory_attributes(kvm, start, end, attributes))
+	if (kvm_range_has_memory_attributes(kvm, start, end, attributes, true))
 		return r;
 
 	/*
-- 
2.42.1


