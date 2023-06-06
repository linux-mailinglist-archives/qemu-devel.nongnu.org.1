Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D560724C4F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byj-0001Hi-2N; Tue, 06 Jun 2023 15:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MIN_ZAsKCl879HBOIBVQKDDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--ackerleytng.bounces.google.com>)
 id 1q6byg-0001Ds-3v
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:22 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MIN_ZAsKCl879HBOIBVQKDDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--ackerleytng.bounces.google.com>)
 id 1q6byd-0001xM-DX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:21 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-bb3855c34deso1972054276.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078257; x=1688670257;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+hBYwj+hDVdRsN8/1AwobMe3CTJKx3rv/kAyLXc58so=;
 b=H7E3FiMFKx8wp9Dwc4KoRhYITqBdXBFbeuSdYVU7Xl2quiLV1TI/RBj6a84p3NhH+A
 6Ot5kD4xdeERpXhx7UwpPyWytx0ckODJexzs4v23BK+jBmvA/ejV4+lVF1eJPpgHviEu
 uumCUBgaOBD3ECdp59KweUCJLiBB+HqC6NZrMNuSqXw8B1oiojQQln/v/JBqZ3dwGu23
 pfO6fIO6tANLPLyeFwUcf8Qi72Eo5MQO/Xul1ZcTopSBQKuO94fsqUr8V4qbQI+x7jBp
 uRAq7xDxsM2mm1v+/TKXiQUaFoQhkNFaDB59XiYo7wFgeMK27ohvJb62IAQGNTsPTIVZ
 PvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078257; x=1688670257;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hBYwj+hDVdRsN8/1AwobMe3CTJKx3rv/kAyLXc58so=;
 b=GAY9/jc8N6nWQFB8VN6TlGt7DtEnSII7hdZlCld8v+ATLsqFTr4Mw6phpCnWRHtdAN
 lJIVIN00N49EGB1wXl/ByVSlNybkiHhaj4B6T6IlGrnaQch78/Qsv1TMNX5eDimsL16v
 DJ4cTqqUWxI8OGAVImZppI5wvNdjwndIEthKCAR5NI070etKpr1tiglJf4j93E6fQh0d
 rGWs5uAc+8KPmMUbmyaDGePjApUWVCssCVOeyLijvE9y6OoPtVmL7ill9oj0Mx11a6rj
 V3nfPnRq5H8UIEgFIOQsoglpqAOHZl2C9Ty3f9S91Ksu/TpwCTE4o8n6Er0/PR+1oNI4
 yeKg==
X-Gm-Message-State: AC+VfDw2cyqdBsq9jcFK9ircM3UtHQ/fBBskVTjKxoczsHR7iQmjIBpF
 XbDelnA4Gd/Gz8gDHR2QUDboMSwejAWmHsF4iQ==
X-Google-Smtp-Source: ACHHUZ68tuaeB7ur+Gj0U5ZR5IxxzkEh+TRxbplImu5DoiCt68fH6drAzpWUcd9Di+kjyJGUd+Eua/GN38BmucMMtA==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1882:b0:ba8:337a:d8a3 with
 SMTP id cj2-20020a056902188200b00ba8337ad8a3mr1661367ybb.11.1686078256773;
 Tue, 06 Jun 2023 12:04:16 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:47 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <97c312c8c0b56218454d546a540a3ea2e2a825e2.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 02/19] mm: hugetlb: Move and expose
 hugetlbfs_zero_partial_page
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
 envelope-from=3MIN_ZAsKCl879HBOIBVQKDDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--ackerleytng.bounces.google.com;
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

Zeroing of pages is generalizable to hugetlb and is not specific to
hugetlbfs.

Rename hugetlbfs_zero_partial_page => hugetlb_zero_partial_page, move
it to mm/hugetlb.c and expose it in linux/hugetlb.h.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 27 ++-------------------------
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 406d7366cf3e..3dab50d3ed88 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -688,29 +688,6 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
 
-static void hugetlbfs_zero_partial_page(struct hstate *h,
-					struct address_space *mapping,
-					loff_t start,
-					loff_t end)
-{
-	pgoff_t idx = start >> huge_page_shift(h);
-	struct folio *folio;
-
-	folio = filemap_lock_folio(mapping, idx);
-	if (!folio)
-		return;
-
-	start = start & ~huge_page_mask(h);
-	end = end & ~huge_page_mask(h);
-	if (!end)
-		end = huge_page_size(h);
-
-	folio_zero_segment(folio, (size_t)start, (size_t)end);
-
-	folio_unlock(folio);
-	folio_put(folio);
-}
-
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
@@ -737,7 +714,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* If range starts before first full page, zero partial page. */
 	if (offset < hole_start)
-		hugetlbfs_zero_partial_page(h, mapping,
+		hugetlb_zero_partial_page(h, mapping,
 				offset, min(offset + len, hole_start));
 
 	/* Unmap users of full pages in the hole. */
@@ -750,7 +727,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	/* If range extends beyond last full page, zero partial page. */
 	if ((offset + len) > hole_end && (offset + len) > hole_start)
-		hugetlbfs_zero_partial_page(h, mapping,
+		hugetlb_zero_partial_page(h, mapping,
 				hole_end, offset + len);
 
 	i_mmap_unlock_write(mapping);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 37c2edf7beea..023293ceec25 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -256,6 +256,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
+void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
+			       loff_t start, loff_t end);
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
@@ -464,6 +467,9 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_zero_partial_page(
+	struct hstate *h, struct address_space *mapping, loff_t start, loff_t end) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 07abcb6eb203..9c9262833b4f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7407,6 +7407,28 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
 }
 
+void hugetlb_zero_partial_page(struct hstate *h,
+			       struct address_space *mapping,
+			       loff_t start, loff_t end)
+{
+	pgoff_t idx = start >> huge_page_shift(h);
+	struct folio *folio;
+
+	folio = filemap_lock_folio(mapping, idx);
+	if (!folio)
+		return;
+
+	start = start & ~huge_page_mask(h);
+	end = end & ~huge_page_mask(h);
+	if (!end)
+		end = huge_page_size(h);
+
+	folio_zero_segment(folio, (size_t)start, (size_t)end);
+
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog


