Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D7781160
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31j-0008EZ-Dh; Fri, 18 Aug 2023 13:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31i-0008EB-3V
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31f-00081X-TF
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so8738905ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378762; x=1692983562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zm6LGbzRYY77HgezAnXq5Cmr5DPYLmRbQvieaAAbplU=;
 b=h8miP2KVjiASi/7WufWnevxrGkCfGySgUm2aRmkUQjL4Ulw/8lN1OEt0ESpD25Ui8H
 TuIOtlN70v3+sTMzyu6UhC0avpKzMK93Eip6mRh6QouX0vpNomyc4i6B5+aARk2UudmC
 mn6/lk2s7bpNb4P7wZ2uLDWHvFClI/rjL+pdz2iVgyfhxB+ExXzdHZyWIMnOEvwzJYjz
 rzGE5MvnEYpDz+/I9herQurC9Gbu84nbYGgnuAfoqCTe2IuGLiNgTtg8dF3IqygDnxnP
 kiqlfy2B6SYFQj3v0xYiFFh3Lbf++BFZNIaSbIwWbsYrjAAboneBgFEhsdj9eGrQQoDf
 HFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378762; x=1692983562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zm6LGbzRYY77HgezAnXq5Cmr5DPYLmRbQvieaAAbplU=;
 b=BjNnAeGnDufDnMBVF4Mo/V+c+mahN0CpbJTmXSa2VvTCO0PF86w1+5avWyO/bHzJox
 XHrcr+1e2hRwrRSelyR9AzFrQPYW3kW+x6SFZhwKKcJv7oVKZHuBbEaNYDjJ2HsJsuWo
 LU+6b0MD46K8cdoQdZuH+nA/Eeb+YOmq4mSUGF5SMKewnqy4ZTuESprHMFmWJK/aW9VE
 Kr8VCbh1qv8mgbVbAKrQ35R0K6sAR3Ntjoab1zsFYcOhbcSvBQGCNnhVzJvnHwyH+4d4
 KaXpKTpGYmzStLyfwrkjYnFmTjeOWIbr+7vnWdJkd/Z3xMTZAvn2Byc9i1Foz8Q1j82C
 GCuw==
X-Gm-Message-State: AOJu0Yzgvxv5XWIoW9ss5zM0elvlW7SPq1VMlDzN3Ka5jFYvEZlmQRSr
 o7GqGt7dythGC9Rw5op59AZhZXvdOHfGIoLdQYA=
X-Google-Smtp-Source: AGHT+IFOjtUxYZ71Es18mBbC1mE6rnYf+4KgENswBOvYMooWh2S3laC+yhmn+LbBT4jLhWEu0DRshg==
X-Received: by 2002:a17:903:1248:b0:1bb:fffd:63d8 with SMTP id
 u8-20020a170903124800b001bbfffd63d8mr3283905plh.36.1692378762590; 
 Fri, 18 Aug 2023 10:12:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/33] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Date: Fri, 18 Aug 2023 10:12:04 -0700
Message-Id: <20230818171227.141728-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This removes a hidden use of qemu_host_page_size, using instead
the existing host_page_size local within each function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 48a6ef0af9..35f270ec2e 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -147,7 +147,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 
     last = start + len - 1;
     host_start = start & -host_page_size;
-    host_last = HOST_PAGE_ALIGN(last) - 1;
+    host_last = ROUND_UP(last, host_page_size) - 1;
     nranges = 0;
 
     mmap_lock();
@@ -345,8 +345,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
         start &= -host_page_size;
     }
     start = ROUND_UP(start, align);
-
-    size = HOST_PAGE_ALIGN(size);
+    size = ROUND_UP(size, host_page_size);
 
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size, align);
@@ -506,7 +505,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      */
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = HOST_PAGE_ALIGN(host_len);
+        host_len = ROUND_UP(host_len, host_page_size);
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
@@ -551,7 +550,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         void *p;
 
         host_len = len + offset - host_offset;
-        host_len = HOST_PAGE_ALIGN(host_len);
+        host_len = ROUND_UP(host_len, host_page_size);
         host_prot = target_to_host_prot(target_prot);
 
         /* Note: we prefer to control the mapping address. */
@@ -581,7 +580,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
         last = start + len - 1;
-        real_last = HOST_PAGE_ALIGN(last) - 1;
+        real_last = ROUND_UP(last, host_page_size) - 1;
 
         /*
          * Test if requested memory area fits target address space
@@ -749,7 +748,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 
     last = start + len - 1;
     real_start = start & -host_page_size;
-    real_last = HOST_PAGE_ALIGN(last) - 1;
+    real_last = ROUND_UP(last, host_page_size) - 1;
 
     /*
      * If guest pages remain on the first or last host pages,
-- 
2.34.1


