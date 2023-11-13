Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 096267E94AD
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 03:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Md0-0006WP-Pk; Sun, 12 Nov 2023 21:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1r2Mcy-0006W1-TH
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 21:24:40 -0500
Received: from smtp-190a.mail.infomaniak.ch ([2001:1600:4:17::190a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1r2Mcj-00088J-JE
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 21:24:40 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4STCtJ0ZdVzMpvZk;
 Mon, 13 Nov 2023 02:24:24 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4STCtG6J2GzMpnPd; Mon, 13 Nov 2023 03:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
 s=20191114; t=1699842263;
 bh=oVoPkAWjPfqZGemyyPZ53MkaSuuZZCG0BkbPtJbgAiE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vrln9/b46q/IyvbLiM7gr/pjSy6nNAlaXyCcWrkwCHL76184CKYv4PInqVYTmM3XU
 usQOOb2erA5xMR73/PzeYEi/AVI+wGVine2Q4AcSnr9lSM8X4meSz+MPB7uM5eZm7x
 SS5OjADjVFHRajKr3cVBhD/5XC7T3gtprqTK5mks=
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
Subject: [RFC PATCH v2 08/19] KVM: x86: Extend kvm_vm_set_mem_attributes()
 with a mask
Date: Sun, 12 Nov 2023 21:23:15 -0500
Message-ID: <20231113022326.24388-9-mic@digikod.net>
In-Reply-To: <20231113022326.24388-1-mic@digikod.net>
References: <20231113022326.24388-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=2001:1600:4:17::190a;
 envelope-from=mic@digikod.net; helo=smtp-190a.mail.infomaniak.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Enable to only update a subset of attributes.

This is needed to be able to use the XArray for different use cases and
make sure they don't interfere (see a following commit).

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
 virt/kvm/kvm_main.c      | 27 +++++++++++++++++++--------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4d378d308762..d7010e09440d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7283,7 +7283,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
-		    attrs != kvm_get_memory_attributes(kvm, gfn))
+		    !(attrs & kvm_get_memory_attributes(kvm, gfn)))
 			return false;
 	}
 	return true;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 85b8648fd892..de68390ab0f2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2397,7 +2397,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-			      unsigned long attributes);
+			      unsigned long attributes, unsigned long mask);
 
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0096ccfbb609..e2c178db17d5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2436,7 +2436,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 /*
  * Returns true if _all_ gfns in the range [@start, @end) have attributes
- * matching @attrs.
+ * matching the @attrs bitmask.
  */
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long attrs)
@@ -2459,7 +2459,8 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 			entry = xas_next(&xas);
 		} while (xas_retry(&xas, entry));
 
-		if (xas.xa_index != index || xa_to_value(entry) != attrs) {
+		if (xas.xa_index != index ||
+		    (xa_to_value(entry) & attrs) != attrs) {
 			has_attrs = false;
 			break;
 		}
@@ -2553,7 +2554,7 @@ static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
 
 /* Set @attributes for the gfn range [@start, @end). */
 int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attributes)
+			      unsigned long attributes, unsigned long mask)
 {
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
@@ -2572,11 +2573,8 @@ int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		.may_block = true,
 	};
 	unsigned long i;
-	void *entry;
 	int r = 0;
 
-	entry = attributes ? xa_mk_value(attributes) : NULL;
-
 	lockdep_assert_held(&kvm->slots_arch_lock);
 
 	/* Nothing to do if the entire range as the desired attributes. */
@@ -2596,6 +2594,16 @@ int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
+		unsigned long value = 0;
+		void *entry;
+
+		entry = xa_load(&kvm->mem_attr_array, i);
+		if (xa_is_value(entry))
+			value = xa_to_value(entry) & ~mask;
+
+		value |= attributes & mask;
+		entry = value ? xa_mk_value(value) : NULL;
+
 		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
@@ -2609,12 +2617,14 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 					   struct kvm_memory_attributes *attrs)
 {
 	int r;
+	unsigned long attrs_mask;
 	gfn_t start, end;
 
 	/* flags is currently not used. */
 	if (attrs->flags)
 		return -EINVAL;
-	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
+	attrs_mask = kvm_supported_mem_attributes(kvm);
+	if (attrs->attributes & ~attrs_mask)
 		return -EINVAL;
 	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
 		return -EINVAL;
@@ -2632,7 +2642,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 	BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
 
 	mutex_lock(&kvm->slots_arch_lock);
-	r = kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
+	r = kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes,
+				      attrs_mask);
 	mutex_unlock(&kvm->slots_arch_lock);
 	return r;
 }
-- 
2.42.1


