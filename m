Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCE724C3D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bz9-0001Sx-Fy; Tue, 06 Jun 2023 15:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3TIN_ZAsKCnsZbjdqkdxsmffnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--ackerleytng.bounces.google.com>)
 id 1q6bz6-0001S3-Cm
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:48 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3TIN_ZAsKCnsZbjdqkdxsmffnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--ackerleytng.bounces.google.com>)
 id 1q6bz3-0001vd-Qj
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:04:48 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-ba8337ade1cso10279202276.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1686078284; x=1688670284;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xVPr1dIpnxklN0GMh0WV40gxjr+XB/duCXqFm/4Eedk=;
 b=OpWI8RPhFgIw5MoV+RS2cmQpFpGPXsQqq6sU1K61/owOmBB1Ql0+w7FJ3nZldnf8p9
 +qYBb0NtRqwQu8dWDMwOUTG0ATZVJvom27ARS7xgWW5TfboiScGSMfZ8N45qzVKLAY2H
 4CU726nNQYrYfpWC/qzLp0r9J8us1SCC2lEqZrYJr9OdHyFq/TUwds9iZNdlTcobAHRr
 ZZALUwW7mEujbc7yxykj2/g4xPWE/5QaSH6KTAlpAQ02/2PJYX27kEua6tRoLiCjwPDV
 pyCH4FFtF/i8mbhld01B2RuTsSf6teTynYWziBlTcigs4W2oRa0ZqtYf/T+WFi+IMehY
 DIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078284; x=1688670284;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xVPr1dIpnxklN0GMh0WV40gxjr+XB/duCXqFm/4Eedk=;
 b=cGQYkNGPfAvgOezWmSPTT3cosUhp8S5cm6tpMmyvfyL5K0fBgyApJR+vdyTle0FWlh
 HBqod58WntLLAPDltuDjegZFVW16A8lViNTjQK4oqxsagPEzsLdHtCOnCpJUqhAObYlZ
 RO2n+hutiwHXqoaclFRB4AxIzlxHZQ91W6YbmdcYYjrZeFpqdysEiuojs6k+2jwobFUc
 2Pq1FRBCjrZOb/0Q0IdGhLwlVT0HkmcmxKlPpmfP+TgG2DQkGtbWwjKI/Z4CqQYtxFC8
 52uEQOjcCjMGCAtBwTUI612bAvxGkgI5QW16pH+QbKE9dQVStWRg2ovvhv8zy+vo0K/n
 X+/A==
X-Gm-Message-State: AC+VfDwPXYHT0CXUn3AE7JoxkixfPgrC1dX5OZqaEnsHBOgPwESQ6zqA
 b4AXlRy+OM/mw6N9AnNutpypZtv1EK5fsTeP/A==
X-Google-Smtp-Source: ACHHUZ6iw5MaJvx6Biay/guXDPe54wqyOEjmtoFNQ8eDgpYM8NsdWofxvbuGdqaNO+FVNrUBL1ysZvJNR4qrxfEOBQ==
X-Received: from ackerleytng-ctop.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:72d:b0:ba1:d0:7f7c with SMTP
 id l13-20020a056902072d00b00ba100d07f7cmr1128681ybt.2.1686078284464; Tue, 06
 Jun 2023 12:04:44 -0700 (PDT)
Date: Tue,  6 Jun 2023 19:04:02 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <2b26bcc8b10f8a11e6405d4cea5f1235e82e83c9.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 17/19] KVM: selftests: Add basic selftests for
 hugetlbfs-backed guest_mem
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
 envelope-from=3TIN_ZAsKCnsZbjdqkdxsmffnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--ackerleytng.bounces.google.com;
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

Add tests for 2MB and 1GB page sizes.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 059b33cdecec..6e24631119c6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -90,20 +90,14 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
 }
 
-
-int main(int argc, char *argv[])
+void test_guest_mem(struct kvm_vm *vm, uint32_t flags, size_t page_size)
 {
-	size_t page_size;
-	size_t total_size;
 	int fd;
-	struct kvm_vm *vm;
+	size_t total_size;
 
-	page_size = getpagesize();
 	total_size = page_size * 4;
 
-	vm = vm_create_barebones();
-
-	fd = vm_create_guest_memfd(vm, total_size, 0);
+	fd = vm_create_guest_memfd(vm, total_size, flags);
 
 	test_file_read_write(fd);
 	test_mmap(fd, page_size);
@@ -112,3 +106,24 @@ int main(int argc, char *argv[])
 
 	close(fd);
 }
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm = vm_create_barebones();
+
+	printf("Test guest mem 4K\n");
+	test_guest_mem(vm, 0, getpagesize());
+	printf("        PASSED\n");
+
+	printf("Test guest mem hugetlb 2M\n");
+	test_guest_mem(
+		vm, KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB, 2UL << 20);
+	printf("        PASSED\n");
+
+	printf("Test guest mem hugetlb 1G\n");
+	test_guest_mem(
+		vm, KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB, 1UL << 30);
+	printf("        PASSED\n");
+
+	return 0;
+}
-- 
2.41.0.rc0.172.g3f132b7071-goog


