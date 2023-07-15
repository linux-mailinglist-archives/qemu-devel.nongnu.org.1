Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 091517548FF
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjn-00072z-NA; Sat, 15 Jul 2023 09:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfid-000499-TC
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiZ-0001Km-QG
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso3008516f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429229; x=1692021229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PG65sHHMcFZxBzSd8xJSgpPdsxuZoeu52o+OB1adTRg=;
 b=KsEzQ2CILNo2bUkSWMRMbIrnUJtdSLfnFKitW97iizEnnzxrHyVe0xaupU5K9GUrEI
 XsRXSDIwY9s9pmSbE7NuaPmxsTV3kIB1M0j5h49vWeI5fHBnovoL6HDXs3JXPS5LPWCF
 qXjtdfTIy0HxjVeVy5DT73z30AojyRYUK2mBtEAsJIhejhzXGrclLVczgoWM1MMlMEX4
 kLYjog0sBS9m7klgyi2XohQPm8dLY17qGRYBaEGmlYuR8zHnQZpGLIefJgG00WFk4qmR
 PamL9aRdtMkCzPTIP8EoaBneFbxkV5+oYcXqunEFsnZAyYcxUMdmXePRCElqrnAO3eFI
 ze2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429229; x=1692021229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PG65sHHMcFZxBzSd8xJSgpPdsxuZoeu52o+OB1adTRg=;
 b=d+4e0dMapynzNKrCVUyyLlrRhwXZ7O/Koyt3AxVS+xhudwtcgpBotLp5GKMWjqL8Jd
 h0+IIkzUvkUx0GS28DVjV21ybQxcWKm5P/AOIC3t91focGkGQYnv3IiWXNT2B0kpiKJD
 Q3OG0sN7uSCNstCLmJA0VU6NjesxO18DElZ+hFZWdbnKWWCD4ltGJUqnuMR4SY5LVu+y
 VtoFZc1c+O7nUe+WBfLE6J9npstA6QJkDA5oCwGwsyWLJ5nLBg/DhGmp99Wq8RjQ3MsF
 aRZmxESRR0QdoUiGHVLojsIGSfUSHXAH7YjXMgmJFQYa8zf21M5WBnPF82w8lzLguHpX
 W7Jg==
X-Gm-Message-State: ABy/qLYflgu7zfg4bGUEZxMaKb2Pn9HhNnxT6ZFb2V6tIt2hAm9ZYqZK
 YaVDsUcdBJZWwbLNJ5v1rnraMvLy7ZxZYMS4t9lRTw==
X-Google-Smtp-Source: APBJJlHJO520EMnjPldNz8csnCuchsbYXIeZ5M0qbj8hMDfzbQcaNHvi8G1529AdMuxUQFgef9lwvQ==
X-Received: by 2002:a5d:66c3:0:b0:313:ffdd:a707 with SMTP id
 k3-20020a5d66c3000000b00313ffdda707mr6758890wrw.35.1689429228812; 
 Sat, 15 Jul 2023 06:53:48 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/47] linux-user: Rename mmap_reserve to mmap_reserve_or_unmap
Date: Sat, 15 Jul 2023 14:53:08 +0100
Message-Id: <20230715135317.7219-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If !reserved_va, munmap instead and assert success.
Update all callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-22-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 6308787942..22c2869be8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -722,14 +722,14 @@ fail:
     return -1;
 }
 
-static void mmap_reserve(abi_ulong start, abi_ulong len)
+static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
     abi_ulong real_last;
     abi_ulong real_len;
     abi_ulong last;
     abi_ulong a;
-    void *host_start, *ptr;
+    void *host_start;
     int prot;
 
     last = start + len - 1;
@@ -776,9 +776,15 @@ static void mmap_reserve(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    ptr = mmap(host_start, real_len, PROT_NONE,
-               MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-    assert(ptr == host_start);
+    if (reserved_va) {
+        void *ptr = mmap(host_start, real_len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        assert(ptr == host_start);
+    } else {
+        int ret = munmap(host_start, real_len);
+        assert(ret == 0);
+    }
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
@@ -830,11 +836,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     ret = 0;
     /* unmap what we can */
     if (real_start < real_end) {
-        if (reserved_va) {
-            mmap_reserve(real_start, real_end - real_start);
-        } else {
-            ret = munmap(g2h_untagged(real_start), real_end - real_start);
-        }
+        mmap_reserve_or_unmap(real_start, real_end - real_start);
     }
 
     if (ret == 0) {
@@ -871,7 +873,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
              * If new and old addresses overlap then the above mremap will
              * already have failed with EINVAL.
              */
-            mmap_reserve(old_addr, old_size);
+            mmap_reserve_or_unmap(old_addr, old_size);
         }
     } else if (flags & MREMAP_MAYMOVE) {
         abi_ulong mmap_start;
@@ -886,7 +888,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                                flags | MREMAP_FIXED,
                                g2h_untagged(mmap_start));
             if (reserved_va) {
-                mmap_reserve(old_addr, old_size);
+                mmap_reserve_or_unmap(old_addr, old_size);
             }
         }
     } else {
@@ -912,7 +914,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve(old_addr + old_size, old_size - new_size);
+                    mmap_reserve_or_unmap(old_addr + old_size,
+                                          old_size - new_size);
                 }
             }
         } else {
-- 
2.34.1


