Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C97724C3C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byf-0001AN-0A; Tue, 06 Jun 2023 15:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LoN_ZAsKCl057F9MG9TOIBBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--ackerleytng.bounces.google.com>)
 id 1q6byd-00012v-AN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:19 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LoN_ZAsKCl057F9MG9TOIBBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--ackerleytng.bounces.google.com>)
 id 1q6byb-0001wP-NU
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:19 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-ba83a9779f3so9814229276.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078255; x=1688670255;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=W42CnlEhHXSQD8oU0aesgTIb+2nDDRqlSHCZLxoyAZw=;
 b=SI6wxzD3jNLZvjIR3ui3oLLkrgjrOnUdyqmkDtNB4LvaXzaOxSopYwQDXGSPUwGt0b
 d1EHBVyiG4hUUHi15P58bSdZq1hiIfxHNvpvia7Cxzf6d0mYTmKP/FDWWkzVCNVJSia8
 WKQpt+ZebghqzxY/2xXY0xK+V+7VuTACGmy8UzpKH/NOajrF02Jvbazs2Qt1cP/5GZi3
 Pxw8kkdCQkLaRblrUwFR5NCQzIvEfWgJISfEM1oMrdysWZB/g9FTr60M+vCWXu+AmqCG
 W3rBiG3Eit8E92Xwv+sO+1jySrdLIuEFp3Em5lURfr02pKqbadaZwr4BvewtCxcGcLfE
 Bs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078255; x=1688670255;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W42CnlEhHXSQD8oU0aesgTIb+2nDDRqlSHCZLxoyAZw=;
 b=ZmmJN60niolT3YuC/vkgoqd00FQkVVTt8JWEVNP5+H81GyVQAb+Uj57IttzjL7o0Nb
 2ReXxdg67F2VwMMTiRAZkZ2DuDEoD2dFontQFJXWpw05YAf6gZqoB+lDxkw5Qwyv2Cy6
 Z94r0Ne37hMsv1VLjEpCbk9lfCqllm6R4XyOi3U1c8aWCwxswTsUu9vTHyTO28pZ4nBY
 MTWnHThM7UGqYogQLBXarMCJ9duUlXxFs1j9h+kWECqbYXYCAvOCijAdHiSVhU0Xm0/7
 6oEBK82B7FnTpWdKb2v8uy+FBnifsOIEJdZ6uI6qUiIt11JWcUb0dZjdnvwFWmSewExO
 8mcg==
X-Gm-Message-State: AC+VfDyT60ZRXKGqRPlcndy5gvs6WfcxO6XKUJsVIbhpJKmf/fUqrsJM
 MPILJcqagxRYg/AHkd8Mvjb3F9lcRqxvujIcxA==
X-Google-Smtp-Source: ACHHUZ535voW+NPlWmi/k960ILK6GzLJuoo4o0Ye5mrBBjql7Wgmyk28/ve76hKFr5oQ8deqfVoTqFa20GrqC6sA9g==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:2ce:0:b0:bb3:ac6a:6d61 with SMTP
 id 197-20020a2502ce000000b00bb3ac6a6d61mr1216938ybc.3.1686078254851; Tue, 06
 Jun 2023 12:04:14 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:46 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <b3924b31a274477b623d156b456ebc8891756e10.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 01/19] mm: hugetlb: Expose get_hstate_idx()
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
 envelope-from=3LoN_ZAsKCl057F9MG9TOIBBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--ackerleytng.bounces.google.com;
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

Expose get_hstate_idx() so it can be used from KVM's guest_mem code

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    |  9 ---------
 include/linux/hugetlb.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9062da6da567..406d7366cf3e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1560,15 +1560,6 @@ static int can_do_hugetlb_shm(void)
 	return capable(CAP_IPC_LOCK) || in_group_p(shm_group);
 }
 
-static int get_hstate_idx(int page_size_log)
-{
-	struct hstate *h = hstate_sizelog(page_size_log);
-
-	if (!h)
-		return -1;
-	return hstate_index(h);
-}
-
 /*
  * Note that size should be aligned to proper hugepage size in caller side,
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7c977d234aba..37c2edf7beea 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -876,6 +876,15 @@ static inline int hstate_index(struct hstate *h)
 	return h - hstates;
 }
 
+static inline int get_hstate_idx(int page_size_log)
+{
+	struct hstate *h = hstate_sizelog(page_size_log);
+
+	if (!h)
+		return -1;
+	return hstate_index(h);
+}
+
 extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
@@ -1142,6 +1151,11 @@ static inline int hstate_index(struct hstate *h)
 	return 0;
 }
 
+static inline int get_hstate_idx(int page_size_log)
+{
+	return 0;
+}
+
 static inline int dissolve_free_huge_page(struct page *page)
 {
 	return 0;
-- 
2.41.0.rc0.172.g3f132b7071-goog


