Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF2724C6D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byv-0001NQ-PD; Tue, 06 Jun 2023 15:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3P4N_ZAsKCm4MOWQdXQkfZSSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--ackerleytng.bounces.google.com>)
 id 1q6bys-0001MK-D8
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:34 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3P4N_ZAsKCm4MOWQdXQkfZSSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--ackerleytng.bounces.google.com>)
 id 1q6byq-00024R-TX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:34 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-bacfa4ef059so10375518276.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078271; x=1688670271;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=QP9zRN1PPC9/vVggheoZtkj7ew+Av1V49kv617fnYR8=;
 b=FI4N69NL3RScUYfhkbRLrL4c1EfS/desGI2Shr1/96TXRRDn4geHvyU1N7eGgqKJyG
 GWBPzDYB1BfYFhv6zCt0EhdFu5tldM3yzA5NvQB4/zCb+hcK/bM/QuqRiIfDvi5+hI04
 SbvBvKqQxgCQVjt+cTCPYL6N1+wfniCAiJKkEW+sWbUf69X9qSMHub3UvTd9MQDzXMi4
 1B4c0zvORWB8HqA5+0cdcj+spglhu6jaXUuf69LPtiQvLZve3RcWtPEQxixl3Ypwmw86
 K8LGygCgyEMNtUVq9AiwfPbvahkLarTMGurJs3foOYOqn4CdQy93rRAZp4edz17ORY67
 OYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078271; x=1688670271;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QP9zRN1PPC9/vVggheoZtkj7ew+Av1V49kv617fnYR8=;
 b=Max4jZuP+HtsAuc22Gca54WdLz6XtNTEucV1K9Ub6mwOgbo9eitfJzVTXd+PYH2StZ
 kmcmSpklwnr5bG+mRF+8RVMwXKJx3z9niQcHJF9wbFOXiJoU5nFobRh+nJpx+7iWb4vW
 1a0g0Qyjcteag2tvyHj2RcvekraHwPt5buVy68RCBDwckUbvAFtS9OR6l0r3td4fUgpN
 sdP1q1TO4TvKGGFUhWv9QYDnmmyPCPkYnbJhdnSF6RLjD+PomRQKS2+DKhAd+pxRFjud
 vwTkvEbGW06mg0C/hpVjVsRA/NJRedfCXHUOAukHL21eXQH+x7gPEspqYbUtTyvkrfhj
 s9RQ==
X-Gm-Message-State: AC+VfDz9GhCOB1Rjy7tLl4hrp9Pm0lNkTCVbLxLIn23Azial56MY+kFl
 TJxbEWfpU6hOQFCN57BEU0RIQvkpi6kHX0mwCQ==
X-Google-Smtp-Source: ACHHUZ76bqpjC35XKXFBahxA9u7+2eFkt14S7ZQHJlZjw7W0ReYy7o2ytYkzhnc/yAz55ZaZBmAlcbBYdbpzzQGaSA==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:105:0:b0:bab:a276:caac with SMTP
 id 5-20020a250105000000b00baba276caacmr1716574ybb.3.1686078271536; Tue, 06
 Jun 2023 12:04:31 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:55 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <382ee70df7b65c365a1eab1223f84aecc0c5be10.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 10/19] mm: hugetlb: Parametrize
 alloc_hugetlb_folio_from_subpool() by resv_map
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3P4N_ZAsKCm4MOWQdXQkfZSSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--ackerleytng.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Parametrize alloc_hugetlb_folio_from_subpool() by resv_map to remove
the use of vma_resv_map() and decouple hugetlb with hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5fe9643826d7..d564802ace4b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -767,7 +767,7 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct folio *alloc_hugetlb_folio_from_subpool(
-	struct hugepage_subpool *spool, struct hstate *h,
+	struct hugepage_subpool *spool, struct hstate *h, struct resv_map *resv,
 	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 540634aec181..aebdd8c63439 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3003,7 +3003,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 }
 
 struct folio *alloc_hugetlb_folio_from_subpool(
-	struct hugepage_subpool *spool, struct hstate *h,
+	struct hugepage_subpool *spool, struct hstate *h, struct resv_map *resv,
 	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve)
 {
 	struct folio *folio;
@@ -3013,7 +3013,6 @@ struct folio *alloc_hugetlb_folio_from_subpool(
 	struct hugetlb_cgroup *h_cg = NULL;
 	bool deferred_reserve;
 
-	struct resv_map *resv = vma_resv_map(vma);
 	pgoff_t resv_index = vma_hugecache_offset(h, vma, addr);
 	bool may_share = vma->vm_flags & VM_MAYSHARE;
 
@@ -3141,8 +3140,9 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
+	struct resv_map *resv = vma_resv_map(vma);
 
-	return alloc_hugetlb_folio_from_subpool(spool, h, vma, addr, avoid_reserve);
+	return alloc_hugetlb_folio_from_subpool(spool, h, resv, vma, addr, avoid_reserve);
 }
 
 int alloc_bootmem_huge_page(struct hstate *h, int nid)
-- 
2.41.0.rc0.172.g3f132b7071-goog


