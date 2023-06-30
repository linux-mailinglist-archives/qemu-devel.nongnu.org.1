Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112E743CB0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:25:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4s-0007ls-2f; Fri, 30 Jun 2023 09:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4p-0007ka-OR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4o-0003Se-2X
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3141140f51bso2198784f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131336; x=1690723336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSslPOCtrCKSd7/qnt5s8BU5QI6BNVbM4GALvEx3wRA=;
 b=sLqByRzW1MisrQ/5C+YhPStmF2R9/1DcNQTCTWqFjOSUR0xFI8rCF0bhS16piN0yF0
 rZVWcl2TE7bxtr1tzxtG8ubEeBkecB8dRSKgrCya6o+dccTIugRtMwo8AT1FmkS4Birk
 RwCj2pzvm5ZaGVL/cT4GsAAU58dmvQ3UhfdIkpQbH7OJ4oGJMWXDjco4N/bTgTE000VG
 4fW4AcKyMJ0kMSQ1+nZsx0DRcOwQCpyNhjbGDR6DqSjjA9be6y35n9xEv4+JYOsEVyg8
 gEEQmOMRJDcM/KQR8Hlrq8yoBT/qesSKhd9jqevnyPRh0wnqlgmsBOEpi8FHgvbcifnM
 IxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131336; x=1690723336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSslPOCtrCKSd7/qnt5s8BU5QI6BNVbM4GALvEx3wRA=;
 b=UCwduGd1P1hSmhah+hFdBOtwbJtU9JjWI61JXKIqeo4V2lM9Fq5u4csm+Thwe4wGs7
 Y2zO5nsz63Uh7uECWVYA6pbGPfLE9drDDNNj5R0teH7HoCruunjW4mllnaFBf0il5E9s
 gLTw1wRGKxVAzgYdjGYbJb9okBcrgMojk9nNYzMenvhDfxgb/am95FlGnJKI0JqQtNYw
 CTD5yaGSYoG5jlbINYFvWWbZG7xPe3lK5i3kHpTo4E4VIPhtzPBfpUXQGYD9pqar/6cC
 am8mY5W0KA8QrY1upz23iKHZkSBB+T288mWPtR8M0MkkvD4KdD7MbCpQP4i3go1MMYFp
 DIfg==
X-Gm-Message-State: ABy/qLZ+oUhsKt07B2e05jWrLmsJ/Yik1L4fICCgPGZ2Bmq6gh2xRYVB
 BPzNa2VOmnsrUuKlQqa5DRK6oBe0tlZV8jMLCbX1OA==
X-Google-Smtp-Source: APBJJlHBgcAFRj126Dncg8tDTZHoBttFCikKdhepUOwqjfHD6c+yMYX+ftDn7tVD37+YWBNTEGXv+Q==
X-Received: by 2002:adf:d0c9:0:b0:30f:c1f5:e91e with SMTP id
 z9-20020adfd0c9000000b0030fc1f5e91emr2270169wrh.27.1688131336579; 
 Fri, 30 Jun 2023 06:22:16 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 20/24] linux-user: Simplify target_munmap
Date: Fri, 30 Jun 2023 15:21:55 +0200
Message-Id: <20230630132159.376995-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

All of the guest to host page adjustment is handled by
mmap_reserve_or_unmap; there is no need to duplicate that.
There are no failure modes for munmap after alignment and
guest address range have been validated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8c90a690dd..e6463ecd8d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -789,9 +789,6 @@ static void mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 
 int target_munmap(abi_ulong start, abi_ulong len)
 {
-    abi_ulong end, real_start, real_end, addr;
-    int prot, ret;
-
     trace_target_munmap(start, len);
 
     if (start & ~TARGET_PAGE_MASK) {
@@ -803,47 +800,11 @@ int target_munmap(abi_ulong start, abi_ulong len)
     }
 
     mmap_lock();
-    end = start + len;
-    real_start = start & qemu_host_page_mask;
-    real_end = HOST_PAGE_ALIGN(end);
-
-    if (start > real_start) {
-        /* handle host page containing start */
-        prot = 0;
-        for (addr = real_start; addr < start; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
-        }
-        if (real_end == real_start + qemu_host_page_size) {
-            for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-                prot |= page_get_flags(addr);
-            }
-            end = real_end;
-        }
-        if (prot != 0) {
-            real_start += qemu_host_page_size;
-        }
-    }
-    if (end < real_end) {
-        prot = 0;
-        for (addr = end; addr < real_end; addr += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(addr);
-        }
-        if (prot != 0) {
-            real_end -= qemu_host_page_size;
-        }
-    }
-
-    ret = 0;
-    /* unmap what we can */
-    if (real_start < real_end) {
-        mmap_reserve_or_unmap(real_start, real_end - real_start);
-    }
-
-    if (ret == 0) {
-        page_set_flags(start, start + len - 1, 0);
-    }
+    mmap_reserve_or_unmap(start, len);
+    page_set_flags(start, start + len - 1, 0);
     mmap_unlock();
-    return ret;
+
+    return 0;
 }
 
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-- 
2.34.1


