Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C074B82C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGc-000516-KQ; Fri, 07 Jul 2023 16:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGP-0004qI-Oe
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGN-0004qX-Sh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso25738385e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762470; x=1691354470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSslPOCtrCKSd7/qnt5s8BU5QI6BNVbM4GALvEx3wRA=;
 b=Dh+xFwKlUvBRt4/Q+YLBkxEuTJnw2WmaPoAOr9RVl3xweMDf0YZErCpnq19FJ2/Z2c
 lXfq69IG8FcRqQpEjuXVl8RK8zKmQNjeJUeFP3Irfg3Hf633eeWaSe20wFZHOlExvxfd
 DN6PG24bcdtokPSHZl0fNGomfWCQuvHo8fNoARgKRWp/G3k8xU+wkAgdABQ3aYCAko4l
 HIS9COBxXShLrSMlUCEMQjtoCiNHpG4qI9tPyHhCyJ0PC8U7FpcTMF1dN5kquWApoGSl
 9BBT8gDRxepEFAm6KLK/WZHGZMktpmyqWtHMb2t9qQjZYjPQA++Ckgx7qjnIWt4D3MiZ
 7bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762470; x=1691354470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSslPOCtrCKSd7/qnt5s8BU5QI6BNVbM4GALvEx3wRA=;
 b=KjTlAtWGUJghyIfeNVVleJ95B5IO0cxtNFRwHKKQc1udtKkfHw2vim3WWoWMngREtO
 KU4DwPfeEBpbo2fQYxe8yT01X3Ab4iu5UzqSpTgDHa6vZhn97Tw3VxMAcHgtTTe2oxOm
 rzELBNhHIcPyZBf2A55SQJMgcB1Lrt7NKVdATmxfvVDO48mFX7XuNaViirbCcBkYlXOo
 Fe4HgtoTNd2YX2lS6aNAeLHjr+zK9C4eb6+fofVLBxRvLIGfkQVEUirubrptF+L8+ing
 Ui1y700Qcxw+U7AyJffmQeq86Zdg98ix9tgp11cOEzjiqkNWTFOxyOHIbrAzQ7yCiT4E
 IGhA==
X-Gm-Message-State: ABy/qLZ4y5KFcKiOtaUvX2tsJjxsc0F0eg7LzZY6Ha4JFQ/IrY+6VuFP
 iFpHRZ9OlzIiPrNylSdgJ4yQkQrb1bnpdvH75/3QIg==
X-Google-Smtp-Source: APBJJlGXxtI3dI3cd4TXHZ6fULj2dTKc3pnvp+ni2MyatpGooxU3ok79imBLJPsHDI1K6S1pBG5Mpg==
X-Received: by 2002:a7b:c3d7:0:b0:3fb:a6ee:4cec with SMTP id
 t23-20020a7bc3d7000000b003fba6ee4cecmr4499609wmj.33.1688762470660; 
 Fri, 07 Jul 2023 13:41:10 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 20/24] linux-user: Simplify target_munmap
Date: Fri,  7 Jul 2023 21:40:50 +0100
Message-Id: <20230707204054.8792-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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


