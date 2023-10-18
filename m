Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2CF7CEC20
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:34:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG13-00046l-Kt; Wed, 18 Oct 2023 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0s-0003lt-RW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:42 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0q-0000Ia-Ti
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:42 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a67ebc2cb3so25267739f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671899; x=1698276699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZQXmTezubKvZiknkUGl30NcUMWQlr0tOKsu9AI7N20=;
 b=UhBV2fP1i+sf410LUy7MV1QCAkxH0dUu5tc5OXyfssKTcB/JDs7KAcuECptazKt9sc
 SoxUyKh6R2buAjA8gdpQkqswEf2T8kHbmzD7/y5KOZxfouy245m/w6StsALM6O8T9lUb
 VU0Db382NgXvi6kRFLyPzKqZZUejah0d63qOWrB8+JpW1CvRjmiyQsJCoAKisB38BRZ1
 Qw9RhQ1+1RKSDuZh9XpbEAahPJSnCFTnps56s6SKwrJBRnicsGIBWv6iqggL2JYZVNZo
 n3BmQRVvvrjJfSb9u6QWR/rt6gmQTy7xMijmFj94ke/DxhgETUUvPdrWOfitcvowMTsE
 r3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671899; x=1698276699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZQXmTezubKvZiknkUGl30NcUMWQlr0tOKsu9AI7N20=;
 b=oa/maBS1fNyVPdNUQGlbHvl9zUguwASecHEzBplv0O15fgt60dy6CRb+Kt1GZ5Q+5r
 N5Mk+Tcc0wrwdYxIU+SPEqUtwvMdBM5eFTyBZkFrAy1spuqKGlttX2mCc1PDGAnlVDZV
 ItSOsOwx+lfOqMElm2y8av1P5wNsDg/ACoHYaa2gCHfCm0EfiRC8NbmioBHBR6x2qDrg
 gyu4vhlNfuSnjmShPAhQX1UFS9p1caNfsFCGWA9T3e50IHfCm5lKL0ecJ+wRX+sRPwQJ
 lFyQTAUT4FSHBArumUkwfTQ19A8GAFEUFMqPsMIjt1T8pVY4pVIzaXl/S7W1hxOfaTKu
 Zqug==
X-Gm-Message-State: AOJu0YzRTAqaQS71dzjKMSHdk2Yzs93qXkYQ1I5S2kxqJehSsC2wWb5B
 eMBfhxDfQDRvOmq6tMf1WMB6EyQ8g/f6zsVLzz0=
X-Google-Smtp-Source: AGHT+IG0cvDfSc31AsKD9KH3tqSINpuriv8QFpiwDjClajVqOPjn59WWu7C7ypCmw58YTZAxyyvmeg==
X-Received: by 2002:a05:6e02:2168:b0:357:7b04:721 with SMTP id
 s8-20020a056e02216800b003577b040721mr948604ilv.32.1697671899501; 
 Wed, 18 Oct 2023 16:31:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@suse.de>
Subject: [PULL 05/14] linux-user: Propagate failure in mmap_reserve_or_unmap
 back to target_munmap
Date: Wed, 18 Oct 2023 16:31:25 -0700
Message-Id: <20231018233134.1594292-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2e.google.com
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

Do not assert success, but return any failure received.
Additionally, fix the method of earlier error return in target_munmap.

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8ccaab7859..7b44b9ff49 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -778,7 +778,7 @@ fail:
     return -1;
 }
 
-static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
+static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     abi_ulong real_start;
     abi_ulong real_last;
@@ -807,7 +807,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
             prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            return;
+            return 0;
         }
     } else {
         for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
@@ -825,7 +825,7 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
         }
 
         if (real_last < real_start) {
-            return;
+            return 0;
         }
     }
 
@@ -836,32 +836,36 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
         void *ptr = mmap(host_start, real_len, PROT_NONE,
                          MAP_FIXED | MAP_ANONYMOUS
                          | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-        assert(ptr == host_start);
-    } else {
-        int ret = munmap(host_start, real_len);
-        assert(ret == 0);
+        return ptr == host_start ? 0 : -1;
     }
+    return munmap(host_start, real_len);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
 {
+    int ret;
+
     trace_target_munmap(start, len);
 
     if (start & ~TARGET_PAGE_MASK) {
-        return -TARGET_EINVAL;
+        errno = EINVAL;
+        return -1;
     }
     len = TARGET_PAGE_ALIGN(len);
     if (len == 0 || !guest_range_valid_untagged(start, len)) {
-        return -TARGET_EINVAL;
+        errno = EINVAL;
+        return -1;
     }
 
     mmap_lock();
-    mmap_reserve_or_unmap(start, len);
-    page_set_flags(start, start + len - 1, 0);
-    shm_region_rm_complete(start, start + len - 1);
+    ret = mmap_reserve_or_unmap(start, len);
+    if (likely(ret == 0)) {
+        page_set_flags(start, start + len - 1, 0);
+        shm_region_rm_complete(start, start + len - 1);
+    }
     mmap_unlock();
 
-    return 0;
+    return ret;
 }
 
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-- 
2.34.1


