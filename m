Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F0A724C3E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byi-0001Go-Np; Tue, 06 Jun 2023 15:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MoN_ZAsKCmE9BJDQKDXSMFFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--ackerleytng.bounces.google.com>)
 id 1q6byf-0001B3-AW
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:21 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MoN_ZAsKCmE9BJDQKDXSMFFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--ackerleytng.bounces.google.com>)
 id 1q6byd-0001y4-Qj
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:21 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-ba88ec544ddso10411091276.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078258; x=1688670258;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4awdlrIAeNpwHVWeIID1BUVh8RCTYusTWiK5XfdHg+o=;
 b=EM6Va8BzGwCED0zIh64Bnjix1yyjlAzWk5b48JtiXuhP31W1mbMccgQlZPFYy2Rc8v
 tMovnZrmg6i3waIkF808VpF/dEtWacRQ+yv83fbRyzUMvkWnAQduvEvPNXK1sSt1N2Cy
 PtYuLHfMT8qcUe5nsKygK7f4ppJDBYrYq77vKTy6tbx4tH0TKa3ANgH0owgHfn5b1Tx1
 OI+RAo/8et/7ti+hO4SSDEjjeJCABpVM+ohklHFBBqTgC2zed5wK6sgfxTCj5lcV8B7r
 QzmY/WCfEZ0p/5xV7lrrRx2FQaR4Eg7AC1b0TCHXbKQd5gKgaSLxDQ+6klKWy+rQ6YtV
 ePmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078258; x=1688670258;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4awdlrIAeNpwHVWeIID1BUVh8RCTYusTWiK5XfdHg+o=;
 b=TVvtHoXzbRQLKc0zegnnhSGnDRMaNa+HVTA5tcS+Z7miTgrY6H5+CGIqU6yAxMIXjI
 FI4BbuHRqKRmZsOvuUcFgTPglgN1MpuK4n6D3od15qkNmGln5VbUhE1BM3lr8p1w7Dd7
 z+qpyzM0H+oRTfO+XmrPmT7q77gQJtTtOC0C24B5R0RWdIsdSe5k1GD7tfZX2upfLgiI
 zU5cQD5eqi/gSoaprCWbzF2ApZ5TAWr0mdlauPk5xAaJ1md0GjQvdkd5g9yZgdlkN5ga
 94l4jKugeWxV+aX2wusuJnBP90lqCjh+GbdzjplTCLagMcM9noYEnD0xzwq60XuhQTcy
 ZrkQ==
X-Gm-Message-State: AC+VfDw0DJjgWzXGB+cUAjcVLk/SfYVNONkTl63zVUh75gYlaQd/qDpQ
 4kZrFiNgmfwiyiaJvMxmJ7l3x77UOr3+9V6kHg==
X-Google-Smtp-Source: ACHHUZ7qnoxO8i1wmNBAi7fatM+eI5rwKFB4S/AWZNBrdb9BhmqSWgFoaD3eNX27zoBKSk99WIOAutKPR4Hz0jbmxQ==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:10c8:b0:ba8:797c:9bc7 with
 SMTP id w8-20020a05690210c800b00ba8797c9bc7mr1725260ybu.11.1686078258501;
 Tue, 06 Jun 2023 12:04:18 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:48 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <0ae157ec9e196f353ecf9036dbffdc295c994817.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 03/19] mm: hugetlb: Expose remove_inode_hugepages
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
 envelope-from=3MoN_ZAsKCmE9BJDQKDXSMFFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--ackerleytng.bounces.google.com;
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

TODO may want to move this to hugetlb

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 3 +--
 include/linux/hugetlb.h | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3dab50d3ed88..4f25df31ae80 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -611,8 +611,7 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
  */
-static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
-				   loff_t lend)
+void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 023293ceec25..1483020b412b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -259,6 +259,8 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
 			       loff_t start, loff_t end);
 
+void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend);
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
@@ -470,6 +472,8 @@ static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 static inline void hugetlb_zero_partial_page(
 	struct hstate *h, struct address_space *mapping, loff_t start, loff_t end) {}
 
+static inline void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
-- 
2.41.0.rc0.172.g3f132b7071-goog


