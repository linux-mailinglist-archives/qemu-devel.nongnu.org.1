Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44486724C60
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6byz-0001OX-4F; Tue, 06 Jun 2023 15:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Q4N_ZAsKCnIQSaUhbUojdWWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--ackerleytng.bounces.google.com>)
 id 1q6byx-0001Np-3e
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:39 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Q4N_ZAsKCnIQSaUhbUojdWWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--ackerleytng.bounces.google.com>)
 id 1q6byv-00026U-8E
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:38 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-653a1cfb819so1498403b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078275; x=1688670275;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=gCnAmjEfrZv4hWergm9cCKqGSfxeJstUIVXgvQlsrbM=;
 b=0RfjN0vYiusk5ioCQS1nAlCQ9SwNbpNkrAGoCc3DzbyiTfogeskfW/k35AUHJjbjvh
 qcmNficgsPHY7IzjLRZ7Fx7yHknnSVBialc9Lm2HDy+G56wJLuQdJfrCE1L/whTYztSX
 0nMD1VG7QI0IeJ7NlJ0RqSFpSkllQWKP+8SH5M4Tworj/X9kHQ6JcXzt+NcdmrYuQcSD
 ftcLroNPDkUfGiCVt5bzuOWxk/1vZL8CVOd3YhjEG4x4yYR8uQvEHMIVWqF9xF36YlZ+
 oP2GU9HlO/y1x/wbpPSXD25KiOaXofjmCzoeXIdkiuAzfcG5mWunKS1qCnW27bnXJIzu
 pIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078275; x=1688670275;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCnAmjEfrZv4hWergm9cCKqGSfxeJstUIVXgvQlsrbM=;
 b=bTVHY0wNV1XxM1ojr/4heQ1QAg9fQK9ALK4onz9cKOXl/sP0S1ugmHeN6CqyCSuWsI
 YkFD9fjHjXOZWObx6SDjFjDpr0V3Dx6JM2OUgeobw/+HeOKf8j3EtiU4CtrCeUDZm3ZM
 r4H1rNrFkUXQ2WVMQW6lEnG+tjnfc1arH32HAqJ2P92BfCf84Yw9M0Pf7n5IfV3/dWb/
 EcO+HA6a1XBPNk9t0M/FmCwdGRVhRnqB5y62hwQ3atE7t1VtWp82yWxdDlZ6LzsC6+vq
 4LIru7n3CtpBtdwWnN0J+sNNZY/Hq+oVmyh6G2NznqFMyKcvvGuDHJQP/dJ7o3pRobng
 gtsg==
X-Gm-Message-State: AC+VfDxEp699CGL16hLQuccAP79fKyqHarctrXVTI9PAQZRntOI5ALQ5
 BxVOo4QL2GkdvW7AOAg5wUPx41NNur5u4uDLdA==
X-Google-Smtp-Source: ACHHUZ7oX0XJdw6EGaS/GrZQZU2JbZA6pR7i2na5qTVNAmby/QbfNP6VXG9VMvls4TqYrSTNJjMknJRBHdMlJ61Amg==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:148d:b0:63b:234e:d641 with
 SMTP id v13-20020a056a00148d00b0063b234ed641mr1369654pfu.4.1686078275306;
 Tue, 06 Jun 2023 12:04:35 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:03:57 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <0c1144b9c5cd620cd0acf7ee033fef8d311b97ba.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 12/19] mm: truncate: Expose preparation steps for
 truncate_inode_pages_final
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
 envelope-from=3Q4N_ZAsKCnIQSaUhbUojdWWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--ackerleytng.bounces.google.com;
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

This will allow preparation steps to be shared

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h |  1 +
 mm/truncate.c      | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..7a8f6b810de0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3053,6 +3053,7 @@ extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
+extern void truncate_inode_pages_final_prepare(struct address_space *mapping);
 extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
diff --git a/mm/truncate.c b/mm/truncate.c
index 7b4ea4c4a46b..4a7ae87e03b5 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -449,16 +449,7 @@ void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
 }
 EXPORT_SYMBOL(truncate_inode_pages);
 
-/**
- * truncate_inode_pages_final - truncate *all* pages before inode dies
- * @mapping: mapping to truncate
- *
- * Called under (and serialized by) inode->i_rwsem.
- *
- * Filesystems have to use this in the .evict_inode path to inform the
- * VM that this is the final truncate and the inode is going away.
- */
-void truncate_inode_pages_final(struct address_space *mapping)
+void truncate_inode_pages_final_prepare(struct address_space *mapping)
 {
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
@@ -479,7 +470,20 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		xa_lock_irq(&mapping->i_pages);
 		xa_unlock_irq(&mapping->i_pages);
 	}
+}
 
+/**
+ * truncate_inode_pages_final - truncate *all* pages before inode dies
+ * @mapping: mapping to truncate
+ *
+ * Called under (and serialized by) inode->i_rwsem.
+ *
+ * Filesystems have to use this in the .evict_inode path to inform the
+ * VM that this is the final truncate and the inode is going away.
+ */
+void truncate_inode_pages_final(struct address_space *mapping)
+{
+	truncate_inode_pages_final_prepare(mapping);
 	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
-- 
2.41.0.rc0.172.g3f132b7071-goog


