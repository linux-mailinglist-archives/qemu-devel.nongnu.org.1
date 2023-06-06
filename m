Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BB724C71
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byr-0001Lh-F3; Tue, 06 Jun 2023 15:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3O4N_ZAsKCmoIKSMZTMgbVOOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--ackerleytng.bounces.google.com>)
 id 1q6byp-0001LQ-Ch
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:31 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3O4N_ZAsKCmoIKSMZTMgbVOOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--ackerleytng.bounces.google.com>)
 id 1q6byn-00023a-GR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:31 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-65a971d7337so1772956b3a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078267; x=1688670267;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=q0LlAXxza1jA09p0tGZBn0yslODgyOL+oHXEFWpIcjw=;
 b=oNCwvb9aRpGDjzemliRPAV2RbEjUkgcqMTcFw35zrX9Wk6VNZIJTDcZ8+sohLR6ypL
 FaZ8YypjTtdq4RVqmfVtwq8W8DKoRJdnwKkTjuJm/fygYago9102lZaBqLBb3VLlSbNA
 8+GKs0dCEhmYGJeMyAKWj2FCcFo2qfmKEi+Bfw7yT1VoVQRRdAWcJACFBwEDVx5EFgYY
 ssLEqzao5SUtD6qqnRzkJD0PmTNAv31SFuhQy7OBTGaI6F+cg3TLNZhoEHYY01Vr6fPj
 YBc8jpY1SOo3QPJvqg80DDEnv97O24LbqrhfCC1OmOHsPqRNG8fKpuVSD4Hro3kbXfW6
 x8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078267; x=1688670267;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q0LlAXxza1jA09p0tGZBn0yslODgyOL+oHXEFWpIcjw=;
 b=bN2lbtbSkygZtFRoeHOz+PKMkJqZVYlicNy5ml0AnExZ5NmEh8Dy5DQUkPj8yyuo5k
 cto99IcIMS3bHNSFNyf0XcH7tH1dVu1CknPlzY+Hn+nK95EuZ8VD/lCVxkeG5+YHIXY7
 l1AEDvIIYjeX7dTDIwYyD7qsE5W3l13w2rj6LSZtT99JiyxaS9yQWmmzBpIStR7iZIUa
 37lDaf/OI00L8U+1PYbeOBaWYRyprlfjU+KiSfqjeQO2xbtgVko3Md1axSZfnhDJOl9N
 p6juc4nHcQLQauby3dvaMQyAjA95YxMc4lq1mW/Dh6wUY/XP7Z7PF9qtO8txvkJ4raXH
 9oLw==
X-Gm-Message-State: AC+VfDzxDMarmpFbfVsDn8mgM3fP1yXvwKFUiOjyHcftx+1iVpHDHSnS
 OePDwQ1YixMEaAdgw4Y0SWNXcyL58pLCa00m4A==
X-Google-Smtp-Source: ACHHUZ6/geo43pUv13kPM8dbgitYn16Pb8nr3LytYQllA2bz6ABBAmVaVTp99t2le/ojeTQ9xVl065tEgGqpA1Ormw==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:188d:b0:64f:cdb0:64a8 with
 SMTP id x13-20020a056a00188d00b0064fcdb064a8mr1304775pfh.3.1686078267446;
 Tue, 06 Jun 2023 12:04:27 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:53 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <cfe974a0ca8182f40a3437e0799f82b38542a667.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 08/19] mm: hugetlb: Refactor restore_reserve_on_error
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3O4N_ZAsKCmoIKSMZTMgbVOOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--ackerleytng.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

Refactor restore_reserve_on_error to allow resv_map to be passed
in. vma_resv_map() assumes the use of hugetlbfs in the way it
retrieves the resv_map from the vma and inode.

Introduce restore_reserve_on_error_vma() which retains original
functionality to simplify refactoring for now.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 37 +++++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc49b6252e4..44e6ee9a856d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -868,7 +868,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		__folio_mark_uptodate(folio);
 		error = hugetlb_add_to_page_cache(folio, mapping, index);
 		if (unlikely(error)) {
-			restore_reserve_on_error(h, &pseudo_vma, addr, folio);
+			restore_reserve_on_error_vma(h, &pseudo_vma, addr, folio);
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7d49048c5a2a..02a2766d89a4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -760,8 +760,10 @@ int hugetlb_filemap_add_folio(struct address_space *mapping, struct hstate *h,
 			      struct folio *folio, pgoff_t idx);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
-void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-				unsigned long address, struct folio *folio);
+void restore_reserve_on_error(struct resv_map *resv, pgoff_t resv_index,
+			      bool may_share, struct folio *folio);
+void restore_reserve_on_error_vma(struct hstate *h, struct vm_area_struct *vma,
+				  unsigned long address, struct folio *folio);
 
 /* arch callback */
 int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d943f83d15a9..4675f9efeba4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2805,15 +2805,10 @@ static long resv_map_del_reservation(struct resv_map *resv, pgoff_t resv_index,
  *
  * In case 2, simply undo reserve map modifications done by alloc_hugetlb_folio.
  */
-void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
-			unsigned long address, struct folio *folio)
+void restore_reserve_on_error(struct resv_map *resv, pgoff_t resv_index,
+			      bool may_share, struct folio *folio)
 {
-	long rc;
-	struct resv_map *resv = vma_resv_map(vma);
-	pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
-	bool may_share = vma->vm_flags & VM_MAYSHARE;
-
-	rc = resv_map_needs_reservation(resv, resv_index, may_share);
+	long rc = resv_map_needs_reservation(resv, resv_index, may_share);
 
 	if (folio_test_hugetlb_restore_reserve(folio)) {
 		if (unlikely(rc < 0))
@@ -2865,7 +2860,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * For shared mappings, no entry in the map indicates
 			 * no reservation.  We are done.
 			 */
-			if (!(vma->vm_flags & VM_MAYSHARE))
+			if (!may_share)
 				/*
 				 * For private mappings, no entry indicates
 				 * a reservation is present.  Since we can
@@ -2883,6 +2878,16 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 	}
 }
 
+void restore_reserve_on_error_vma(struct hstate *h, struct vm_area_struct *vma,
+				  unsigned long address, struct folio *folio)
+{
+	struct resv_map *resv = vma_resv_map(vma);
+	pgoff_t resv_index = vma_hugecache_offset(h, vma, address);
+	bool may_share = vma->vm_flags & VM_MAYSHARE;
+
+	restore_reserve_on_error(resv, resv_index, may_share, folio);
+}
+
 /*
  * alloc_and_dissolve_hugetlb_folio - Allocate a new folio and dissolve
  * the old one
@@ -5109,8 +5114,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
-					restore_reserve_on_error(h, dst_vma, addr,
-								new_folio);
+					restore_reserve_on_error_vma(h, dst_vma, addr,
+								     new_folio);
 					folio_put(new_folio);
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
@@ -5642,7 +5647,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * unshare)
 	 */
 	if (new_folio != page_folio(old_page))
-		restore_reserve_on_error(h, vma, haddr, new_folio);
+		restore_reserve_on_error_vma(h, vma, haddr, new_folio);
 	folio_put(new_folio);
 out_release_old:
 	put_page(old_page);
@@ -5860,7 +5865,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 * to the page cache. So it's safe to call
 				 * restore_reserve_on_error() here.
 				 */
-				restore_reserve_on_error(h, vma, haddr, folio);
+				restore_reserve_on_error_vma(h, vma, haddr, folio);
 				folio_put(folio);
 				goto out;
 			}
@@ -5965,7 +5970,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spin_unlock(ptl);
 backout_unlocked:
 	if (new_folio && !new_pagecache_folio)
-		restore_reserve_on_error(h, vma, haddr, folio);
+		restore_reserve_on_error_vma(h, vma, haddr, folio);
 
 	folio_unlock(folio);
 	folio_put(folio);
@@ -6232,7 +6237,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* Free the allocated folio which may have
 			 * consumed a reservation.
 			 */
-			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
+			restore_reserve_on_error_vma(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 
 			/* Allocate a temporary folio to hold the copied
@@ -6361,7 +6366,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		folio_unlock(folio);
 out_release_nounlock:
 	if (!folio_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, folio);
+		restore_reserve_on_error_vma(h, dst_vma, dst_addr, folio);
 	folio_put(folio);
 	goto out;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog


