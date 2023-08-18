Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C55781170
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31n-0008GG-MF; Fri, 18 Aug 2023 13:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31l-0008FN-LU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31j-00082k-GM
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so9352135ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378766; x=1692983566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=phk7XwZ3loE8OzD2nhx9Jjjs9VBjr33DTUu15m85L0s=;
 b=pzBQbICffpBTjLzFhtAIXe1forkYOxCZ8TuDl7etFvIYCDsiAkuXE2JbwUq0FI5Md5
 kP9f1H8wJ0DV2ZJd/95Yi4vsv1ctPbhV/pWhBZZmRPAgnKYUu0bf+tiprKPI6qcJJ4sA
 LDXHFibTAZHyW6eg7woYDcLSylriliVW9xeWnxYi4TSrvKXF5slKGuaQ6pTdIaSxred1
 svCWEmtYwOnwbfZvIx1L7TtIfhoJR6IxWwP7yXWlGJE5igeMMWjjMME7V1ohlklGjD1u
 JlxF67pVnxiSh/jGJ+uxqDPi9lGbiLuCZk3qRJuMwOkjP7kJWVWpuF3XrDsqlWteAEst
 zCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378766; x=1692983566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phk7XwZ3loE8OzD2nhx9Jjjs9VBjr33DTUu15m85L0s=;
 b=KDYKigRaI0u/2vajnxrPYzKHQnwFRut/NTmOfpBgMsXlQaGszvkQEPjMvfSlTrgkUe
 zFMD4E1KIn66a6MU06oWAuBL1cRapqTghpiX5YD7CZQuP8n8PzF3zPIbqIa6uf5jn3s6
 a+JRyiWJ7Yjn8zy3RcF1X0rLiiN3531e2h7IVSKOjbxiLfAMK5qjs12+Em7rBIaLxOEW
 1T59FrFjmSHtepRQ1M/wNZ9HjXrOnj36Mt+GFaYd8KP4KCARqVs3kTa3emJUJLn51oiR
 9yo8mYUNAApsNuLNecz5PkJ45JtZO4Ic9a8DQy/z0Rm9dzS76jVL4CbDvT7Oqh0jsMs2
 shbw==
X-Gm-Message-State: AOJu0YzJ1mzPaWTPUvWXW1qAKKD3FlGl0Ze2ikqF8hDH2sfO+mcaIsb+
 NVhl/B5JrVfmz/JY8mtJ5cp8EEmp6cwYfu+HCVA=
X-Google-Smtp-Source: AGHT+IF0fexJ4+uXoQJqlwOawNzTtmxeRGNeayKGyFuPP33eQFyUh1wCafMIvIqAym/+ICMVJMiOAg==
X-Received: by 2002:a17:903:1ce:b0:1b8:76fc:5bf6 with SMTP id
 e14-20020a17090301ce00b001b876fc5bf6mr4406214plh.43.1692378766311; 
 Fri, 18 Aug 2023 10:12:46 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/33] softmmu/physmem: Remove HOST_PAGE_ALIGN
Date: Fri, 18 Aug 2023 10:12:08 -0700
Message-Id: <20230818171227.141728-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index 6881b2d8f8..9eff0acb2f 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1663,7 +1663,8 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     assert(block);
 
-    newsize = HOST_PAGE_ALIGN(newsize);
+    newsize = TARGET_PAGE_ALIGN(newsize);
+    newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
     if (block->used_length == newsize) {
         /*
@@ -1898,7 +1899,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    size = HOST_PAGE_ALIGN(size);
+    size = TARGET_PAGE_ALIGN(size);
+    size = REAL_HOST_PAGE_ALIGN(size);
+
     file_size = get_file_size(fd);
     if (file_size > offset && file_size < (offset + size)) {
         error_setg(errp, "backing store size 0x%" PRIx64
@@ -1976,13 +1979,17 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
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


