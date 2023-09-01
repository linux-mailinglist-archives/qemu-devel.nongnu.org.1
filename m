Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A288678F721
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp7-0006Xg-8j; Thu, 31 Aug 2023 22:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp5-0006Ww-Le
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp3-0001Q8-EE
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso1786144b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535024; x=1694139824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX0Wvey1e2J0VCCaIBZPR7REasOlAnSls/c5wuVfncQ=;
 b=KW+ZGb3tufrc/+PV17+VgExsYCcQKh5d6nmfb3amL6MKyYSKlOqndrXHsMm7K3lQ4j
 X8qc79dpPc36U0HHFkj9xvyRrA1CbWCzo2XovOgsb4q3+AyOn41ySSJIjoEeYFtnN9cy
 Psai99+kh2jRvdorZFerM8llchvplW/3K1d7X5Tk98Di+j1ypv58vxNpOI2aElE0v/+x
 alZu8es1PnRLiW47ngZlkvxWnukOn0j5aNQ1vYuHW2esN+FrW45beMZo69SGqwjByJRx
 oHRMUAkhN8foTr7N/aScr7FUgzw7we1oHZXw+5aZQCfrT4DFduq0ypiH6pJnBJdJOgYL
 DiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535024; x=1694139824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX0Wvey1e2J0VCCaIBZPR7REasOlAnSls/c5wuVfncQ=;
 b=HQ9YSz0aYoIpP/n7rrIZFyX68dXKZfrFNNvZWxZq8q88x3DPqzYTkCyrn0UCswmC0K
 I89DRoqTceDn8gOhInzlekkAyTsooP15SvB7O+fJHwWz24pZIAYPvejHFUMmuJ33gTd3
 w44AmYvJs8geCKYSbjhw6dC+i45Nnei0NJT1NvTDIZReRWYvl9eF6FWWIq8lq1VxyFsX
 ozF0bvSoanlfDCEIjmiAi0jgV7J2fVDN0g1sp4MIR7602M2IBtiWLaAMwV367pgLFa5d
 y17TNnw9lByMjORa2NN5r5OSpIom8W5emqXi06KntnH8hk5E/TO2Lys1+NWuL99UylbS
 4UYg==
X-Gm-Message-State: AOJu0YzBb15o/JwteZ6FaTjthOmX4sIsjAbNc6rczhP4s29fO390ymGR
 SQyv10YSqgfAzJOdyjZChJw7qrKMeXhaiVrqZqg=
X-Google-Smtp-Source: AGHT+IH4R4nsngdbLi41OHlYq9mgFXST44EAWvjA4AFLka3dF+kFymEamPhxMlUm4ePtFmBI/PBcKA==
X-Received: by 2002:a05:6a00:27ab:b0:68b:fc76:7dea with SMTP id
 bd43-20020a056a0027ab00b0068bfc767deamr1541860pfb.12.1693535024189; 
 Thu, 31 Aug 2023 19:23:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 14/33] softmmu/physmem: Remove HOST_PAGE_ALIGN
Date: Thu, 31 Aug 2023 19:23:12 -0700
Message-Id: <20230901022331.115247-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Align allocation sizes to the maximum of host and target page sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 6f963ea127..04d8423b68 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1662,7 +1662,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     assert(block);
 
-    newsize = HOST_PAGE_ALIGN(newsize);
+    newsize = TARGET_PAGE_ALIGN(newsize);
+    newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
     if (block->used_length == newsize) {
         /*
@@ -1897,7 +1898,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    size = HOST_PAGE_ALIGN(size);
+    size = TARGET_PAGE_ALIGN(size);
+    size = REAL_HOST_PAGE_ALIGN(size);
+
     file_size = get_file_size(fd);
     if (file_size > offset && file_size < (offset + size)) {
         error_setg(errp, "backing store size 0x%" PRIx64
@@ -1975,13 +1978,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
+    int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
-    size = HOST_PAGE_ALIGN(size);
-    max_size = HOST_PAGE_ALIGN(max_size);
+    align = qemu_real_host_page_size();
+    align = MAX(align, TARGET_PAGE_SIZE);
+    size = ROUND_UP(size, align);
+    max_size = ROUND_UP(max_size, align);
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->resized = resized;
-- 
2.34.1


