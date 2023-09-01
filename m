Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C864678F712
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp5-0006Vn-8Y; Thu, 31 Aug 2023 22:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp3-0006Ut-DM
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:45 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp0-0001PL-E9
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:45 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5657a28f920so1127208a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535021; x=1694139821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zm6LGbzRYY77HgezAnXq5Cmr5DPYLmRbQvieaAAbplU=;
 b=vFtmh3Ayk5pYrrixU+DuIu2Sij3d+4WQmsDPJrLJVEigf4qh6NqnL3IXkmb98efJbp
 PKIeqORbgfHt8WdhjX5qhEBY4gAPqQIuCLVV/V5MUrXfEPhbp+QV3i8hQ623T8icjWr4
 ZpizZwlLbdSls702Anq7FQKGKzj6WnpiChVOXKJI4Ji3XdSi3m10Gr6nzOYq5/uHprq8
 hyFTaetuNuB0sGa5O4S15mv3gznOulqRI7RvhaGtir/xHIvP524e0CZvT4jJSdLaavie
 jBzkWKCRzRMOfAAoHrwmU8fqMIAm66pUQxtDLA4jv9uEd4b0Cu0W/vngwh4zHJLqB8DT
 F20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535021; x=1694139821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zm6LGbzRYY77HgezAnXq5Cmr5DPYLmRbQvieaAAbplU=;
 b=ZHO94/gSWdMRfkN0fT/myIm97nPFNW+Pl+hu1xVbNNmrO0BxnDM9nc/HqDFlJECk1l
 KnRSdbnAeqS91BwJlsSnGgn3+Quy3lcAopN7HlwoKW3v4ZgcwoG4CoT2Os+IZ8tlf2hZ
 ZTW3hZ1rz8iLEvj2TpICnbeNKyjrNTSPffTxtUtWOWi0nDjnrPhZAv81QC1wNAn2XEfI
 KbgxBBlwVogUti3lupkK5P5lM3Dxutdp5RNWz7pZFnClAMvZjt8i34BktNJGd5DJx7Zs
 8yfNA0lGzkwbcmxqUkdarTY08JL48OOSn6YBzgAkxJXpqH4bMyszgGgJJHA7mvp8O1xL
 om1Q==
X-Gm-Message-State: AOJu0YyBUmh+Bmd+XB4ZveixBaIFCV6SKurKRiemYovIg01TXmbEsH+5
 +bTTdFk6eJZbs/RqZl1M9wB4H9U2XE75bl/HLxo=
X-Google-Smtp-Source: AGHT+IGG+Pig2ODe/ASGgMrvfI+BW6MV8dg7uy6erSqjR8SCMXBMftombdzVhktzeY3C2zfFdAs36A==
X-Received: by 2002:a05:6a20:7f97:b0:140:a25:1c1d with SMTP id
 d23-20020a056a207f9700b001400a251c1dmr1979700pzj.51.1693535020905; 
 Thu, 31 Aug 2023 19:23:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 10/33] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Date: Thu, 31 Aug 2023 19:23:08 -0700
Message-Id: <20230901022331.115247-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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


