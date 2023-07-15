Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0307548EE
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjY-0005g9-2b; Sat, 15 Jul 2023 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfid-00049A-TC
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiZ-0001LE-Pq
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso3164980f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429229; x=1692021229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t83L6VQqehKor298fA996V/rrvqxT+XEe+3FbTWkw4k=;
 b=N/4R3GDos6flYUkfDXuuINj+MwWeqSLkmO5dPE6Qw/ip5eF2hKewx4fUpm0D+RT+FI
 El4+RwMrBc0aBICbCRZyF7VOkipYBfN1KcdYSWRJL6pX5DQjxlgrv+mYxvwoMAG5Pxpd
 zaVl3udtP82F/HdLFvgWCWPP1S/2laQ4X22wzLsIOOFA6AE+M6c3/gO5qAWQwEB1/GM/
 h/kWjKJWeqm2lHKXNT17rud7xFjPiJXMGV1aSVEsAWekmT8Moy+HdAFYSe9rmJ58L7U+
 86LGEmXBdDannawlg68H3OiYgVFpg/3Os9CKqDuIz+RjKqDgZKcOYT9OEAU3PB2UaQ+Q
 /Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429229; x=1692021229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t83L6VQqehKor298fA996V/rrvqxT+XEe+3FbTWkw4k=;
 b=KzLNTD7h6d9pnEzLyKPwHjNBAQUkoAHT7/g+jGquy6S7E2T8nK5ATFM4Zlpnws5dlu
 OQZ97LDgu3eXKtohzqo4w+CVqm7n3P2c3uRVwRhwO+u6PYquWIHj8bi8BBr9MNw/W+5i
 Bfgznxv7AeJepG9tvAtgSMzIVdWridrLDy4bAiWr2m1AJ2qEeH+AIPWgD2znq/bfhqjM
 YoZtFYzBehwahv0EfM2eD4bmaN3Lmb3nErwMUPKZx16SwmQCTqLRoEzyimkWqJVXnuX6
 Dp23RgluYn8Ta6No70SoJiRsZkqg2BMr8VT8oxy69n/xGERANanXEPJrZtMkR2uH1BzF
 aZ3Q==
X-Gm-Message-State: ABy/qLav4yV0Qmgv6y1ZzUMSeKl0f/agXGgYQVgfDOil6p4fWtMIkjzb
 0ASMTwW3JSn97llDXOK6cFxSZqqu7DLgSq5hWTX7UA==
X-Google-Smtp-Source: APBJJlFlBVdGFQ9CS9QCnSp9ZLiTk/ZdPS6Y2dKpx5abb35fM6flj0IAv/B3Jk+5YsIc8SVQXQegVw==
X-Received: by 2002:a5d:4844:0:b0:314:10d6:8910 with SMTP id
 n4-20020a5d4844000000b0031410d68910mr6581195wrs.63.1689429229392; 
 Sat, 15 Jul 2023 06:53:49 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/47] linux-user: Simplify target_munmap
Date: Sat, 15 Jul 2023 14:53:09 +0100
Message-Id: <20230715135317.7219-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20230707204054.8792-23-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 22c2869be8..c0946322fb 100644
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


