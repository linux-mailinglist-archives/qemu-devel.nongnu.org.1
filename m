Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF3B724C59
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:06:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byy-0001OK-GE; Tue, 06 Jun 2023 15:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3QYN_ZAsKCnAOQYSfZSmhbUUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--ackerleytng.bounces.google.com>)
 id 1q6byx-0001Nq-3q
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:39 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3QYN_ZAsKCnAOQYSfZSmhbUUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--ackerleytng.bounces.google.com>)
 id 1q6byu-00025j-EK
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:38 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-5439aafb633so2784933a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078273; x=1688670273;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DUcXaEC48I4Bm1WwWPPkFcaYKFbZrdo62sI7Vn9jtKM=;
 b=EsMzcu7MCofZV1M6N8qLTVGfCobRb2m9UBd1k4rqImHaaV90eE+7yVgqGJTlHLVTGg
 WYLYzf9nuh7wT2wl0ong7Pm+JdEwy0XrWnw7A67dAqqNLmKKthrxFKAZNZCPEmg+Gm9l
 1/jfZjJbtssIps71Hn10bsoNM3+P1vWpJqtgmuCPP7gyVh3snIw/tKY/Poj3vjuiFMIm
 hWDohY5CuxRIZJ1XCd6YRMkjU3OFa1a+IZrlt5R6w1j+nUqvdL8ryozxcFEC3Inu+RpX
 MrblT0sw+GiuzKbFJnN8KErIkyQh7K372xpyIXAqppgkeoG3kQADStwWWL0FGczDjczb
 yaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078273; x=1688670273;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUcXaEC48I4Bm1WwWPPkFcaYKFbZrdo62sI7Vn9jtKM=;
 b=YlxVJ4j36sB6spzIiq2dVksCPNsAmhyfcUFbgpS0lFqs1+KNAkREeooiDRHHD2OjXD
 p4GYVPT1tLnowOKqMDWUM4MSuIGhpgQ/SKSuGT/rbtJ0vWfY2WGSWF2gCF15Mwse9OW4
 DcWiQn+f2NvVfM7nZ3W7pNoP4QbQsC0w4h9+/FJDUYediUClTHjKGxSfa/14s//b+YrH
 rStyGMNexzuhcoi0sUuhbr24O2FSgjyMhk9NrEhYpBfJ56s8IcKiRu9vmA/AafHxn2pG
 wr5ZbcOUaDYfCti9JCq6OzF8C7cCVFZ3vmtkcpIM68lnFTXrWF+GpZkkg0JRzIg0C0jm
 56oA==
X-Gm-Message-State: AC+VfDxGFnJ8aKt4axOYGFYlC0Npv13RkubymmGoDBWi1u8OJfDo1CkQ
 Yy3IGgcwt/Tp/TMqHYwGDjvFkQ9rXxke1ueUqQ==
X-Google-Smtp-Source: ACHHUZ4v54k8mWqyJRdVfnADxQ7LxuS0BkTdcogjdbP6mmP0fUtChdx6VWMt3kG2rI14jmGLU8WGRs/GoPhwfnEqcg==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a65:5c8b:0:b0:53f:b396:6f32 with SMTP
 id a11-20020a655c8b000000b0053fb3966f32mr628734pgt.3.1686078273321; Tue, 06
 Jun 2023 12:04:33 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:56 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <1d0337d32f40b781f9b7509cb40448b81bde6b00.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 11/19] mm: hugetlb: Parametrize hugetlb functions by
 resv_map
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3QYN_ZAsKCnAOQYSfZSmhbUUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--ackerleytng.bounces.google.com;
 helo=mail-pg1-x549.google.com
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

Parametrize remove_mapping_hugepages() and hugetlb_unreserve_pages()
by resv_map to remove the use of inode_resv_map() and decouple hugetlb
with hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 16 ++++++++++------
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            |  4 ++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 53f6a421499d..a7791b1390a6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -560,8 +560,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
  */
 static bool remove_mapping_single_folio(
 	struct address_space *mapping, struct folio *folio, pgoff_t index,
-	struct hstate *h, struct hugepage_subpool *spool, struct inode *inode,
-	bool truncate_op)
+	struct hstate *h, struct hugepage_subpool *spool, struct resv_map *resv_map,
+	struct inode *inode, bool truncate_op)
 {
 	bool ret = false;
 
@@ -586,7 +586,8 @@ static bool remove_mapping_single_folio(
 	hugetlb_delete_from_page_cache(folio);
 	ret = true;
 	if (!truncate_op) {
-		if (unlikely(hugetlb_unreserve_pages(h, spool, inode, index, index + 1, 1)))
+		if (unlikely(hugetlb_unreserve_pages(h, spool, resv_map,
+						     inode, index, index + 1, 1)))
 			hugetlb_fix_reserve_counts(h, spool);
 	}
 
@@ -623,6 +624,7 @@ static bool remove_mapping_single_folio(
  */
 void remove_mapping_hugepages(struct address_space *mapping,
 			      struct hstate *h, struct hugepage_subpool *spool,
+			      struct resv_map *resv_map,
 			      struct inode *inode, loff_t lstart, loff_t lend)
 {
 	const pgoff_t start = lstart >> huge_page_shift(h);
@@ -647,7 +649,7 @@ void remove_mapping_hugepages(struct address_space *mapping,
 			 * Remove folio that was part of folio_batch.
 			 */
 			if (remove_mapping_single_folio(mapping, folio, index,
-							h, spool, inode, truncate_op))
+							h, spool, resv_map, inode, truncate_op))
 				freed++;
 
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -657,7 +659,8 @@ void remove_mapping_hugepages(struct address_space *mapping,
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(h, spool, inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(h, spool, resv_map, inode,
+					      start, LONG_MAX, freed);
 }
 
 void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
@@ -665,8 +668,9 @@ void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
 	struct address_space *mapping = &inode->i_data;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
+	struct resv_map *resv_map = inode_resv_map(inode);
 
-	return remove_mapping_hugepages(mapping, h, spool, inode, lstart, lend);
+	return remove_mapping_hugepages(mapping, h, spool, resv_map, inode, lstart, lend);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d564802ace4b..af04588a5afe 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -172,7 +172,8 @@ bool hugetlb_reserve_pages(struct hstate *h, struct hugepage_subpool *spool,
 			   struct vm_area_struct *vma,
 			   vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct hstate *h, struct hugepage_subpool *spool,
-			     struct inode *inode, long start, long end, long freed);
+			     struct resv_map *resv_map, struct inode *inode,
+			     long start, long end, long freed);
 bool isolate_hugetlb(struct folio *folio, struct list_head *list);
 int get_hwpoison_hugetlb_folio(struct folio *folio, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
@@ -263,6 +264,7 @@ void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
 
 void remove_mapping_hugepages(struct address_space *mapping,
 			      struct hstate *h, struct hugepage_subpool *spool,
+			      struct resv_map *resv_map,
 			      struct inode *inode, loff_t lstart, loff_t lend);
 void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend);
 
@@ -479,7 +481,7 @@ static inline void hugetlb_zero_partial_page(
 
 static inline void remove_mapping_hugepages(
 	struct address_space *mapping, struct hstate *h, struct hugepage_subpool *spool,
-	struct inode *inode, loff_t lstart, loff_t lend) {}
+	struct resv_map *resv_map, struct inode *inode, loff_t lstart, loff_t lend) {}
 static inline void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend) {}
 
 #endif /* !CONFIG_HUGETLB_PAGE */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aebdd8c63439..a1cbda457aa7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6954,9 +6954,9 @@ bool hugetlb_reserve_pages(struct hstate *h, struct hugepage_subpool *spool,
  * Returns 0 on success.
  */
 long hugetlb_unreserve_pages(struct hstate *h, struct hugepage_subpool *spool,
-			     struct inode *inode, long start, long end, long freed)
+			     struct resv_map *resv_map, struct inode *inode,
+			     long start, long end, long freed)
 {
-	struct resv_map *resv_map = inode_resv_map(inode);
 	long chg = 0;
 	long gbl_reserve;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog


