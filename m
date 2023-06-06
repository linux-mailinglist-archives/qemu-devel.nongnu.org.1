Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D59723707
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Pgh-0004tn-Iy; Tue, 06 Jun 2023 01:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgf-0004t4-E1
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgd-0004CL-V9
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWkaS2fs4a5HyuCggdt4oCmY3Kp+kn9vkKcqb1+h0ZY=;
 b=bf6ZE9EZ9DnMR2cP6LkYQRBMOYFVxsHeuOdL2X80G2eR6OshLe6mOTMgi2EVLh2zzlVzIr
 yuQZ3qFwsMZsUkFxbJ/NCOA4nkEYCgQJkUiPPa5PSssUdfS1PZIwkka8SoSf/vM2C4hHXw
 FNnDBck51CpMqn3fRwNiGi7YBHV4NE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-7gNBOiPIN7i6010DdeG0nQ-1; Tue, 06 Jun 2023 01:56:49 -0400
X-MC-Unique: 7gNBOiPIN7i6010DdeG0nQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E2C85A5AA;
 Tue,  6 Jun 2023 05:56:49 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5302166B25;
 Tue,  6 Jun 2023 05:56:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 16/18] linux-user/elfload: Expose get_elf_hwcap() on s390x
Date: Tue,  6 Jun 2023 07:56:19 +0200
Message-Id: <20230606055621.523175-17-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

It is required for implementing /proc/cpuinfo emulation.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230605113950.1169228-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/loader.h  | 4 ++++
 linux-user/elfload.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index f375ee0679..ad6ca9dbe3 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -56,4 +56,8 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 
 extern unsigned long guest_stack_size;
 
+#ifdef TARGET_S390X
+uint32_t get_elf_hwcap(void);
+#endif
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 418ad92598..49ec9ccc94 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1583,7 +1583,7 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define GET_FEATURE(_feat, _hwcap) \
     do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
 
-static uint32_t get_elf_hwcap(void)
+uint32_t get_elf_hwcap(void)
 {
     /*
      * Let's assume we always have esan3 and zarch.
-- 
2.31.1


