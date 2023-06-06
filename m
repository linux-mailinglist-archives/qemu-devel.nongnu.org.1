Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94946724C58
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:06:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byn-0001Kx-Of; Tue, 06 Jun 2023 15:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NoN_ZAsKCmUDFNHUOHbWQJJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--ackerleytng.bounces.google.com>)
 id 1q6byl-0001JP-79
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:27 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NoN_ZAsKCmUDFNHUOHbWQJJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--ackerleytng.bounces.google.com>)
 id 1q6byj-00020f-HZ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:26 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-543a4a54469so952227a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078262; x=1688670262;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TbnAfmaUEaUTjNKT8epdT4a2IjxXaCNnR/Vzf4sBC5I=;
 b=HeyHfG//kNLUaGcFQWwTewKEgcn4vPYn8juDXqEsqn0adr4vG649KYKYHbBgxoXbAB
 ahAsJnvxbrxRZIn8HaOziynSothNYKlQfcTu3jAM4uhoNpX3LWBrkvui47Zp8M9CRSxM
 Hv3v6i8Oi9BrSmd48ktue72BHNGZsJ2uSICRouR0ffp2LrDCVbnCBmA+g2SulzB0hGNV
 h/9GOrxYxtycjJuMZs46LGZ0YhTsDAihpMdCj9p8GQJvBLZp7PdD2PUuqFKV1kr3TMS1
 NWDPMg3o3REsZ5x50h8pQh4zEK7vomJrpG+mCaUeJtrTs1RdwqH+EB5u26LqsONPQnLR
 jEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078262; x=1688670262;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TbnAfmaUEaUTjNKT8epdT4a2IjxXaCNnR/Vzf4sBC5I=;
 b=bGEtOxC8JkTZPdneYkBF3PJkKMvsd0CRyZMICilQaZcdOvjoBu8RKNDLW6WKNDA/ah
 Pjm3qs6iErAqg5+kmXcONWkBFQbhZ/NVI7z+sBZsvz2SDFypusaYQNt6bPNuTq2yCS4x
 nefJNSA6jRDwsk3gMa5ckME11fBd7Tre57seVyZL/jzPkJR6SWpOunzbpm+eh3oIstea
 Cs9ptLIppWva0wzJXggssd6Fw13mlZFtC5s1Q0qhuKi18PQ4IGmJ/yPQRlHbXq1fR2Sk
 p0zaAk5XK4iNe9iF75aqfB5utd5rw6D8hsttj1O/WT+qA+2V6HnsendYGJ/Sfk3DBuen
 xjSA==
X-Gm-Message-State: AC+VfDwhvfIwVInE37oXtlZu+cMuzvmUlDKy3P9+P9taGqn1AD49E4qK
 zPFU/sHqD8luZVTimWy8hB8NyQxoqIN5YdGVnw==
X-Google-Smtp-Source: ACHHUZ7WRmD6VfCo02eYhPrQlyc6XnpZbLw7oQUgpoj7hXhb698PIwiX79ZF4kn3hNLKX22XHrTVhzRB5PnobIvmJA==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:fe05:0:b0:513:9753:46d2 with SMTP
 id p5-20020a63fe05000000b00513975346d2mr634687pgh.2.1686078262212; Tue, 06
 Jun 2023 12:04:22 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:50 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <7827774c13e975d3d1dedc4a4684cb92eac8b548.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 05/19] mm: hugetlb: Allow alloc_hugetlb_folio() to be
 parametrized by subpool and hstate
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3NoN_ZAsKCmUDFNHUOHbWQJJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--ackerleytng.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

subpool_inode() and hstate_inode() are hugetlbfs-specific.

By allowing subpool and hstate to be specified, hugetlb is further
modularized from hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2457d7a21974..14df89d1642c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -747,6 +747,9 @@ struct huge_bootmem_page {
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
+struct folio *alloc_hugetlb_folio_from_subpool(
+	struct hugepage_subpool *spool, struct hstate *h,
+	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9da419b930df..99ab4bbdb2ce 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3008,11 +3008,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
-struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-				    unsigned long addr, int avoid_reserve)
+struct folio *alloc_hugetlb_folio_from_subpool(
+	struct hugepage_subpool *spool, struct hstate *h,
+	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve)
 {
-	struct hugepage_subpool *spool = subpool_vma(vma);
-	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
@@ -3139,6 +3138,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return ERR_PTR(-ENOSPC);
 }
 
+struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
+				    unsigned long addr, int avoid_reserve)
+{
+	struct hugepage_subpool *spool = subpool_vma(vma);
+	struct hstate *h = hstate_vma(vma);
+
+	return alloc_hugetlb_folio_from_subpool(spool, h, vma, addr, avoid_reserve);
+}
+
 int alloc_bootmem_huge_page(struct hstate *h, int nid)
 	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
-- 
2.41.0.rc0.172.g3f132b7071-goog


