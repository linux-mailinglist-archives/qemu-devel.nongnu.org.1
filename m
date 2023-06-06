Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338D724C48
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bzF-0001Ty-Cx; Tue, 06 Jun 2023 15:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ToN_ZAsKCn0bdlfsmfzuohhpphmf.dpnrfnv-efwfmopohov.psh@flex--ackerleytng.bounces.google.com>)
 id 1q6bz9-0001TI-Au
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:51 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ToN_ZAsKCn0bdlfsmfzuohhpphmf.dpnrfnv-efwfmopohov.psh@flex--ackerleytng.bounces.google.com>)
 id 1q6bz7-0002Cl-Kf
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:51 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-bacfa4eefcbso13845349276.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078286; x=1688670286;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=o3QY+GjjNY/B/LKbvEsBmmion/NMqJeuEYcwlsx1w+c=;
 b=ga7yY2wFSjsTCtNYT2NMM1yjmokiEXDaCTuXNhL4QFIjeFOGWXP9m4xRNkNarZKOBt
 me9uyDk1llgo74NsZn/+85xOGgk1JymFHYuOx2vpupSEs8KBznt7C4GK7pW1At3io3MV
 omuLB1jzJaLc4Zg0yimBb4CzacnWix8fdVSxMBPt8YeYd8UktVq4LjjSoaTbCwhO+eXy
 EZa5FIg//RusZW7f2NgtTOFoqGNu6khof2qQQ8vk0r6gz2il2XRm/VN/dp/gxWzndj0K
 LOfFsFQnLTJrS+CT3R61MXxoPNTsaAUuUv0u7TZgtSvuJTPRds1QGGcjrMoDqzJSrIHy
 9Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078286; x=1688670286;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o3QY+GjjNY/B/LKbvEsBmmion/NMqJeuEYcwlsx1w+c=;
 b=R93d5g6f5iAKyqpF8Klp65t+rm0lmwjnPW0CsnwbcR3tBhwOsOk/0BZGbM0PzV7EYQ
 OYUZQzDti9eJvT728XdFGoVkTIWYF3Iu+ONN0nGk7CqpipH0qMuukITfnTI358BUY5gf
 n5sJI85pMj6IGY6pWTy5z/euXlck7cMFSZF5weE5VFHj9/PTGo2OuO6tqV9a5uF306KO
 iDhTSsgqtLcWIdraHYS2kvJuUTv5AozuXoIHAeCnj2NXZLfiqPMOShBU8wsu4sMrpu/x
 35iRzkaB/Ww6N8TAiCwi55+xd4ayb4LcMTtFsEeLMf8E/rey13GaG50hDSnfNjlH7Z8v
 SpyQ==
X-Gm-Message-State: AC+VfDzx+f8mfJ6wNviDLTL20W4mvTwFLJ1wd+Nhw63BZQ3JI3R9CPUj
 e/rtJ0c+3vVjzixx6Bjskvc15/tLBYivafR06g==
X-Google-Smtp-Source: ACHHUZ7zyWkKPX7nW+eqyXqGuqnjfZMxWtQ7sqNr3g3ix//f4WlCF2yUeIoJ+N8uNLRa6EBYQO+4YPcXyNwMiHRgqA==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:aea3:0:b0:bb3:9b99:f3f5 with SMTP
 id b35-20020a25aea3000000b00bb39b99f3f5mr1433391ybj.4.1686078286504; Tue, 06
 Jun 2023 12:04:46 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:04:03 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <5f0d27ce06c03761974264bd8a890614ea7ecb32.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 18/19] KVM: selftests: Support various types of backing
 sources for private memory
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
 envelope-from=3ToN_ZAsKCn0bdlfsmfzuohhpphmf.dpnrfnv-efwfmopohov.psh@flex--ackerleytng.bounces.google.com;
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

Adds support for various type of backing sources for private
memory (in the sense of confidential computing), similar to the
backing sources available for shared memory.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/include/test_util.h | 14 ++++
 tools/testing/selftests/kvm/lib/test_util.c   | 74 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6e9f215ce70..899ea15ca8a9 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -122,6 +122,16 @@ struct vm_mem_backing_src_alias {
 	uint32_t flag;
 };
 
+enum vm_pmem_backing_src_type {
+	VM_PMEM_SRC_GMEM,
+	VM_PMEM_SRC_HUGETLB,  /* Use kernel default page size for hugetlb pages */
+	VM_PMEM_SRC_HUGETLB_2MB,
+	VM_PMEM_SRC_HUGETLB_1GB,
+	NUM_PMEM_SRC_TYPES,
+};
+
+#define DEFAULT_VM_PMEM_SRC VM_PMEM_SRC_GMEM
+
 #define MIN_RUN_DELAY_NS	200000UL
 
 bool thp_configured(void);
@@ -132,6 +142,10 @@ size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
+void pmem_backing_src_help(const char *flag);
+enum vm_pmem_backing_src_type parse_pmem_backing_src_type(const char *type_name);
+const struct vm_mem_backing_src_alias *vm_pmem_backing_src_alias(uint32_t i);
+size_t get_pmem_backing_src_pagesz(uint32_t i);
 long get_run_delay(void);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index b772193f6c18..62efb7b8ba51 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -8,6 +8,7 @@
 #include <assert.h>
 #include <ctype.h>
 #include <limits.h>
+#include <linux/kvm.h>
 #include <stdlib.h>
 #include <time.h>
 #include <sys/stat.h>
@@ -287,6 +288,34 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 	return &aliases[i];
 }
 
+const struct vm_mem_backing_src_alias *vm_pmem_backing_src_alias(uint32_t i)
+{
+	static const struct vm_mem_backing_src_alias aliases[] = {
+		[VM_PMEM_SRC_GMEM] = {
+			.name = "pmem_gmem",
+			.flag = 0,
+		},
+		[VM_PMEM_SRC_HUGETLB] = {
+			.name = "pmem_hugetlb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB,
+		},
+		[VM_PMEM_SRC_HUGETLB_2MB] = {
+			.name = "pmem_hugetlb_2mb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB,
+		},
+		[VM_PMEM_SRC_HUGETLB_1GB] = {
+			.name = "pmem_hugetlb_1gb",
+			.flag = KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB,
+		},
+	};
+	_Static_assert(ARRAY_SIZE(aliases) == NUM_PMEM_SRC_TYPES,
+		       "Missing new backing private mem src types?");
+
+	TEST_ASSERT(i < NUM_PMEM_SRC_TYPES, "Private mem backing src type ID %d too big", i);
+
+	return &aliases[i];
+}
+
 #define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
 
 size_t get_backing_src_pagesz(uint32_t i)
@@ -307,6 +336,20 @@ size_t get_backing_src_pagesz(uint32_t i)
 	}
 }
 
+size_t get_pmem_backing_src_pagesz(uint32_t i)
+{
+	uint32_t flag = vm_pmem_backing_src_alias(i)->flag;
+
+	switch (i) {
+	case VM_PMEM_SRC_GMEM:
+		return getpagesize();
+	case VM_PMEM_SRC_HUGETLB:
+		return get_def_hugetlb_pagesz();
+	default:
+		return MAP_HUGE_PAGE_SIZE(flag);
+	}
+}
+
 bool is_backing_src_hugetlb(uint32_t i)
 {
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
@@ -343,6 +386,37 @@ enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
 	return -1;
 }
 
+static void print_available_pmem_backing_src_types(const char *prefix)
+{
+	int i;
+
+	printf("%sAvailable private mem backing src types:\n", prefix);
+
+	for (i = 0; i < NUM_PMEM_SRC_TYPES; i++)
+		printf("%s    %s\n", prefix, vm_pmem_backing_src_alias(i)->name);
+}
+
+void pmem_backing_src_help(const char *flag)
+{
+	printf(" %s: specify the type of memory that should be used to\n"
+	       "     back guest private memory. (default: %s)\n",
+	       flag, vm_pmem_backing_src_alias(DEFAULT_VM_MEM_SRC)->name);
+	print_available_pmem_backing_src_types("     ");
+}
+
+enum vm_pmem_backing_src_type parse_pmem_backing_src_type(const char *type_name)
+{
+	int i;
+
+	for (i = 0; i < NUM_SRC_TYPES; i++)
+		if (!strcmp(type_name, vm_pmem_backing_src_alias(i)->name))
+			return i;
+
+	print_available_pmem_backing_src_types("");
+	TEST_FAIL("Unknown private mem backing src type: %s", type_name);
+	return -1;
+}
+
 long get_run_delay(void)
 {
 	char path[64];
-- 
2.41.0.rc0.172.g3f132b7071-goog


