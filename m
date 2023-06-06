Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7D724C61
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bz7-0001SN-4X; Tue, 06 Jun 2023 15:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SoN_ZAsKCnkXZhboibvqkddlldib.Zljnbjr-absbiklkdkr.lod@flex--ackerleytng.bounces.google.com>)
 id 1q6bz3-0001R0-Lo
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:45 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SoN_ZAsKCnkXZhboibvqkddlldib.Zljnbjr-absbiklkdkr.lod@flex--ackerleytng.bounces.google.com>)
 id 1q6bz1-0002B3-JN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:45 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-bb39316a68eso1899791276.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078282; x=1688670282;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBX6a15Tnsz/uKq26LcenmelaNrPaeGwC3t0ZYHlu0o=;
 b=SiIGZBUhZs629JysZEAyyBg7ttu9GLTQayTGdSZGve4dLO6zhBZcJhFcd1G73mhuek
 LHQGWYqLVU6XGceDTMr/+ObLmxrXdmeyPE4htH53qamVc0jx3GxeXvlfVB9JCraAIS1o
 KEzaHjtn2Qo3RoZRS3XAY/vwbMPt0gdnui/cnheq8vpMkjsxIO1Je1R+Or+Zif0wezPw
 uUYILrxrg8kwyk8/xo82WMddoKWumnm5vCXiz84rf/1WA32vat2RPpMWIr80UC3bv5gu
 +n3kSoBT8FJFvccnZi21mVuxGSb5VrWJMuxYUlyl2Etedh0yvhauw6W7NlVmyqj5TDoC
 ZVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078282; x=1688670282;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBX6a15Tnsz/uKq26LcenmelaNrPaeGwC3t0ZYHlu0o=;
 b=aPA2/5/R15t5LFG/BzSV7JiBEKl+4Rx9Hd6pDHzt78iTu0iY+uZBC6/pxgHLRttF0K
 Ayx0NrbouVcVA93LzLUMGoNTV7GybUOtEPeI7sieBay+UBCzk/yM3vudK7neJG/TFpWV
 u1blJTEQV9VSg+fXZCII/rBkZCnok6QRQFvfdiu8QuNiN3pCD3qttugVMUzMQ7Ws7hcb
 LSgDTh8NVXsaAU5yxZWYsI/IeRJmhSC5aKfi6Om0NLFVIRuKBJaLhpNPZKg9V45cWAb4
 KXHQQbknVq5kyyc5Yp5mY1CTcwUpl1O/iNm2s1oxSjDUosR1K8qWp4AonKsVD9Z+Ztin
 XDPg==
X-Gm-Message-State: AC+VfDzcwRmTciX0ZKADQbwo3oqR/Eu6LoSKYapP/ag4/bU6cDcfZYII
 XzUIaO079pg8yo5g/qw4n0vsTD3rHrigyPxoMQ==
X-Google-Smtp-Source: ACHHUZ5Cpne/EIdT1I7Li9OeDmgR0RpPGqTGa8YIhJkObOQifrmAjwQv0QQeKIDO8N9Vq8SkzWw7xg09f24itua+cw==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:2446:0:b0:b9a:703d:e650 with SMTP
 id k67-20020a252446000000b00b9a703de650mr1068675ybk.7.1686078282407; Tue, 06
 Jun 2023 12:04:42 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:04:01 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <18e518695854cc7243866d7b1be2fbbb3aa87c71.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 16/19] KVM: guest_mem: hugetlb: allocate and truncate from
 hugetlb
From: Ackerley Tng <ackerleytng@google.com>
To: akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org,
 willy@infradead.org
Cc: brauner@kernel.org, chao.p.peng@linux.intel.com, coltonlewis@google.com, 
 david@redhat.com, dhildenb@redhat.com, dmatlack@google.com, 
 erdemaktas@google.com, hughd@google.com, isaku.yamahata@gmail.com, 
 jarkko@kernel.org, jmattson@google.com, joro@8bytes.org, 
 jthoughton@google.com, jun.nakajima@intel.com, 
 kirill.shutemov@linux.intel.com, liam.merwick@oracle.com, 
 mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com, 
 qperret@google.com, rientjes@google.com, rppt@kernel.org, 
 steven.price@arm.com, tabba@google.com, vannapurve@google.com, vbabka@suse.cz, 
 vipinsh@google.com, vkuznets@redhat.com, wei.w.wang@intel.com, 
 yu.c.zhang@linux.intel.com, kvm@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, 
 x86@kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3SoN_ZAsKCnkXZhboibvqkddlldib.Zljnbjr-absbiklkdkr.lod@flex--ackerleytng.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Introduce kvm_gmem_hugetlb_get_folio(), then update
kvm_gmem_allocate() and kvm_gmem_truncate() to use hugetlb functions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_mem.c | 215 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 188 insertions(+), 27 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index b533143e2878..6271621f6b73 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -43,6 +43,95 @@ static loff_t kvm_gmem_get_size(struct file *file)
 	return i_size_read(file_inode(file));
 }
 
+static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(
+	struct file *file, pgoff_t hindex)
+{
+	int err;
+	struct folio *folio;
+	struct kvm_gmem *gmem;
+	struct hstate *h;
+	struct resv_map *resv_map;
+	unsigned long offset;
+	struct vm_area_struct pseudo_vma;
+
+	gmem = file->private_data;
+	h = gmem->hugetlb.h;
+	resv_map = gmem->hugetlb.resv_map;
+	offset = hindex << huge_page_shift(h);
+
+	vma_init(&pseudo_vma, NULL);
+	vm_flags_init(&pseudo_vma, VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
+	/* vma infrastructure is dependent on vm_file being set */
+	pseudo_vma.vm_file = file;
+
+	/* TODO setup NUMA policy. Meanwhile, fallback to get_task_policy(). */
+	pseudo_vma.vm_policy = NULL;
+	folio = alloc_hugetlb_folio_from_subpool(
+		gmem->hugetlb.spool, h, resv_map, &pseudo_vma, offset, 0);
+	/* Remember to take and drop refcount from vm_policy */
+	if (IS_ERR(folio))
+		return folio;
+
+	/*
+	 * FIXME: Skip clearing pages when trusted firmware will do it when
+	 * assigning memory to the guest.
+	 */
+	clear_huge_page(&folio->page, offset, pages_per_huge_page(h));
+	__folio_mark_uptodate(folio);
+	err = hugetlb_filemap_add_folio(file->f_mapping, h, folio, hindex);
+	if (unlikely(err)) {
+		restore_reserve_on_error(resv_map, hindex, true, folio);
+		folio_put(folio);
+		folio = ERR_PTR(err);
+	}
+
+	return folio;
+}
+
+/**
+ * Gets a hugetlb folio, from @file, at @index (in terms of PAGE_SIZE) within
+ * the file.
+ *
+ * The returned folio will be in @file's page cache, and locked.
+ */
+static struct folio *kvm_gmem_hugetlb_get_folio(struct file *file, pgoff_t index)
+{
+	struct folio *folio;
+	u32 hash;
+	/* hindex is in terms of huge_page_size(h) and not PAGE_SIZE */
+	pgoff_t hindex;
+	struct kvm_gmem *gmem;
+	struct hstate *h;
+	struct address_space *mapping;
+
+	gmem = file->private_data;
+	h = gmem->hugetlb.h;
+	hindex = index >> huge_page_order(h);
+
+	mapping = file->f_mapping;
+	hash = hugetlb_fault_mutex_hash(mapping, hindex);
+	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
+	rcu_read_lock();
+	folio = filemap_lock_folio(mapping, hindex);
+	rcu_read_unlock();
+	if (folio)
+		goto folio_valid;
+
+	folio = kvm_gmem_hugetlb_alloc_and_cache_folio(file, hindex);
+	/*
+	 * TODO Perhaps the interface of kvm_gmem_get_folio should change to better
+	 * report errors
+	 */
+	if (IS_ERR(folio))
+		folio = NULL;
+
+folio_valid:
+	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+
+	return folio;
+}
+
 static struct folio *kvm_gmem_get_huge_folio(struct file *file, pgoff_t index)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -74,36 +163,56 @@ static struct folio *kvm_gmem_get_huge_folio(struct file *file, pgoff_t index)
 #endif
 }
 
+/**
+ * Gets a folio, from @file, at @index (in terms of PAGE_SIZE) within the file.
+ *
+ * The returned folio will be in @file's page cache and locked.
+ */
 static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)
 {
 	struct folio *folio;
+	struct kvm_gmem *gmem = file->private_data;
 
-	folio = kvm_gmem_get_huge_folio(file, index);
-	if (!folio) {
-		folio = filemap_grab_folio(file->f_mapping, index);
+	if (gmem->flags & KVM_GUEST_MEMFD_HUGETLB) {
+		folio = kvm_gmem_hugetlb_get_folio(file, index);
+
+		/* hugetlb gmem does not fall back to non-hugetlb pages */
 		if (!folio)
 			return NULL;
-	}
 
-	/*
-	 * TODO: Confirm this won't zero in-use pages, and skip clearing pages
-	 * when trusted firmware will do it when assigning memory to the guest.
-	 */
-	if (!folio_test_uptodate(folio)) {
-		unsigned long nr_pages = folio_nr_pages(folio);
-		unsigned long i;
+		/*
+		 * Don't need to clear pages because
+		 * kvm_gmem_hugetlb_alloc_and_cache_folio() already clears pages
+		 * when allocating
+		 */
+	} else {
+		folio = kvm_gmem_get_huge_folio(file, index);
+		if (!folio) {
+			folio = filemap_grab_folio(file->f_mapping, index);
+			if (!folio)
+				return NULL;
+		}
 
-		for (i = 0; i < nr_pages; i++)
-			clear_highpage(folio_page(folio, i));
-	}
+		/*
+		 * TODO: Confirm this won't zero in-use pages, and skip clearing pages
+		 * when trusted firmware will do it when assigning memory to the guest.
+		 */
+		if (!folio_test_uptodate(folio)) {
+			unsigned long nr_pages = folio_nr_pages(folio);
+			unsigned long i;
 
-	/*
-	 * filemap_grab_folio() uses FGP_ACCESSED, which already called
-	 * folio_mark_accessed(), so we clear it.
-	 * TODO: Should we instead be clearing this when truncating?
-	 * TODO: maybe don't use FGP_ACCESSED at all and call __filemap_get_folio directly.
-	 */
-	folio_clear_referenced(folio);
+			for (i = 0; i < nr_pages; i++)
+				clear_highpage(folio_page(folio, i));
+		}
+
+		/*
+		 * filemap_grab_folio() uses FGP_ACCESSED, which already called
+		 * folio_mark_accessed(), so we clear it.
+		 * TODO: Should we instead be clearing this when truncating?
+		 * TODO: maybe don't use FGP_ACCESSED at all and call __filemap_get_folio directly.
+		 */
+		folio_clear_referenced(folio);
+	}
 
 	/*
 	 * Indicate that this folio matches the backing store (in this case, has
@@ -156,6 +265,44 @@ static void kvm_gmem_invalidate_end(struct kvm *kvm, struct kvm_gmem *gmem,
 	KVM_MMU_UNLOCK(kvm);
 }
 
+static void kvm_gmem_hugetlb_truncate_range(struct inode *inode,
+					    loff_t offset, loff_t len)
+{
+	loff_t hsize;
+	loff_t full_hpage_start;
+	loff_t full_hpage_end;
+	struct kvm_gmem *gmem;
+	struct hstate *h;
+	struct address_space *mapping;
+
+	mapping = inode->i_mapping;
+	gmem = mapping->private_data;
+	h = gmem->hugetlb.h;
+	hsize = huge_page_size(h);
+	full_hpage_start = round_up(offset, hsize);
+	full_hpage_end = round_down(offset + len, hsize);
+
+	/* If range starts before first full page, zero partial page. */
+	if (offset < full_hpage_start) {
+		hugetlb_zero_partial_page(
+			h, mapping, offset, min(offset + len, full_hpage_start));
+	}
+
+	/* Remove full pages from the file. */
+	if (full_hpage_end > full_hpage_start) {
+		remove_mapping_hugepages(mapping, h, gmem->hugetlb.spool,
+					 gmem->hugetlb.resv_map, inode,
+					 full_hpage_start, full_hpage_end);
+	}
+
+
+	/* If range extends beyond last full page, zero partial page. */
+	if ((offset + len) > full_hpage_end && (offset + len) > full_hpage_start) {
+		hugetlb_zero_partial_page(
+			h, mapping, full_hpage_end, offset + len);
+	}
+}
+
 static long kvm_gmem_punch_hole(struct file *file, loff_t offset, loff_t len)
 {
 	struct kvm_gmem *gmem = file->private_data;
@@ -171,7 +318,10 @@ static long kvm_gmem_punch_hole(struct file *file, loff_t offset, loff_t len)
 
 	kvm_gmem_invalidate_begin(kvm, gmem, start, end);
 
-	truncate_inode_pages_range(file->f_mapping, offset, offset + len - 1);
+	if (gmem->flags & KVM_GUEST_MEMFD_HUGETLB)
+		kvm_gmem_hugetlb_truncate_range(file_inode(file), offset, len);
+	else
+		truncate_inode_pages_range(file->f_mapping, offset, offset + len - 1);
 
 	kvm_gmem_invalidate_end(kvm, gmem, start, end);
 
@@ -183,6 +333,7 @@ static long kvm_gmem_punch_hole(struct file *file, loff_t offset, loff_t len)
 static long kvm_gmem_allocate(struct file *file, loff_t offset, loff_t len)
 {
 	struct address_space *mapping = file->f_mapping;
+	struct kvm_gmem *gmem = file->private_data;
 	pgoff_t start, index, end;
 	int r;
 
@@ -192,9 +343,14 @@ static long kvm_gmem_allocate(struct file *file, loff_t offset, loff_t len)
 
 	filemap_invalidate_lock_shared(mapping);
 
-	start = offset >> PAGE_SHIFT;
-	/* Align so that at least 1 page is allocated */
-	end = ALIGN(offset + len, PAGE_SIZE) >> PAGE_SHIFT;
+	if (gmem->flags & KVM_GUEST_MEMFD_HUGETLB) {
+		start = offset >> huge_page_shift(gmem->hugetlb.h);
+		end = ALIGN(offset + len, huge_page_size(gmem->hugetlb.h)) >> PAGE_SHIFT;
+	} else {
+		start = offset >> PAGE_SHIFT;
+		/* Align so that at least 1 page is allocated */
+		end = ALIGN(offset + len, PAGE_SIZE) >> PAGE_SHIFT;
+	}
 
 	r = 0;
 	for (index = start; index < end; ) {
@@ -211,7 +367,7 @@ static long kvm_gmem_allocate(struct file *file, loff_t offset, loff_t len)
 			break;
 		}
 
-		index = folio_next_index(folio);
+		index += folio_nr_pages(folio);
 
 		folio_unlock(folio);
 		folio_put(folio);
@@ -625,7 +781,12 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		return -ENOMEM;
 	}
 
-	page = folio_file_page(folio, index);
+	/*
+	 * folio_file_page() always returns the head page for hugetlb
+	 * folios. Reimplement to get the page within this folio, even for
+	 * hugetlb pages.
+	 */
+	page = folio_page(folio, index & (folio_nr_pages(folio) - 1));
 
 	*pfn = page_to_pfn(page);
 	*order = thp_order(compound_head(page));
-- 
2.41.0.rc0.172.g3f132b7071-goog


