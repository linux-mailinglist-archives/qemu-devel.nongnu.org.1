Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC6743C9C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4o-0007jH-KG; Fri, 30 Jun 2023 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4m-0007i9-FF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4k-0003Ra-N4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31114b46d62so2093417f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131333; x=1690723333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsYj9hL3z8sJK1XITfZRh23Ewywzv/qozPGrxwSRr2s=;
 b=lC7T5t66amUHgCU5a+vmDTS+a5yMUBbarkPA4mt4ycVZCiADBN4EocdpToR0gYIeWS
 Q5Mm4tmUNf3KSVexWVt6Eol5vXAoM6PLMWSTxT12EWeWPIFynm5YSJkrHVxNW/q4P00l
 JNBrVR58ypJdLPBBR5BMLFV/eLQ7Edt4yUrphD3dO2v+KdcBKyIRTnRwDjXDCiy5BN0h
 EWdWBwL0JKkD3Tl7/DNoNTO44LyiqwSX4hO30O2WBL8fIov9bGixdbtKNNPZ31WbEANY
 SKkhZlnTakohQjaDzn/xTySkI//afyEo+CNv5Wr5HOCCp/KMwnkboc82Gg606Qal+G8e
 BzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131333; x=1690723333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsYj9hL3z8sJK1XITfZRh23Ewywzv/qozPGrxwSRr2s=;
 b=N3uQnXjcl/UM2JF1HqpuPQeR7/mXFWNbVSLWvePJy6hdGs/KQ55+b6q6LbguK5XHQF
 OsHgr0K0mSNWYJYUF9+jXhF7ooXwWX9jY6RFt+unnMGHJa0OVLO0iqnYVaamnB9zNO+E
 lC9VK3KPw+83E+JS4o9uCmc5I8g61wOSVKznj5AW757bZ2VYCA1cygwmD8v9y2gFSvFJ
 Z0E+J6EaFA1bE80S9hEO+i9uvwBJYhzk2og09jx5tgFMIWeJmcnzqt6R+AB1K5o/DMcU
 nuEmQ0aKTfyqOcV9Rdd2le1FTKPWbXGkBeiFFS++tw9msmBKX8WVh1buTOtcL951/nZ1
 inLQ==
X-Gm-Message-State: ABy/qLbW4XJUaesOec9RwAv2VbEyUsrlGw421u+mepmIhirbAA2OYnhy
 KvhdJvQuqczVGfL4SutnbHGADBcGinKvm1YC6OTskw==
X-Google-Smtp-Source: APBJJlGc5nCT9PnWVlarhT7DhG9e46ZqLLynn/aNdNJUCX4m5Nc5EwLyLTr/nken+/GpHp9JjHe0UQ==
X-Received: by 2002:a5d:5511:0:b0:313:f59c:95ec with SMTP id
 b17-20020a5d5511000000b00313f59c95ecmr2189079wrv.28.1688131333425; 
 Fri, 30 Jun 2023 06:22:13 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 16/24] linux-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Fri, 30 Jun 2023 15:21:51 +0200
Message-Id: <20230630132159.376995-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Use the interval tree to find empty space, rather than
probing each page in turn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 46 ++++++----------------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e332555dd2..6ecdf9e56d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -317,49 +317,15 @@ unsigned long last_brk;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong align)
 {
-    abi_ulong addr, end_addr, incr = qemu_host_page_size;
-    int prot;
-    bool looped = false;
+    target_ulong ret;
 
-    if (size > reserved_va) {
-        return (abi_ulong)-1;
+    ret = page_find_range_empty(start, reserved_va, size, align);
+    if (ret == -1 && start > mmap_min_addr) {
+        /* Restart at the beginning of the address space. */
+        ret = page_find_range_empty(mmap_min_addr, start - 1, size, align);
     }
 
-    /* Note that start and size have already been aligned by mmap_find_vma. */
-
-    end_addr = start + size;
-    if (start > reserved_va - size) {
-        /* Start at the top of the address space.  */
-        end_addr = ((reserved_va + 1 - size) & -align) + size;
-        looped = true;
-    }
-
-    /* Search downward from END_ADDR, checking to see if a page is in use.  */
-    addr = end_addr;
-    while (1) {
-        addr -= incr;
-        if (addr > end_addr) {
-            if (looped) {
-                /* Failure.  The entire address space has been searched.  */
-                return (abi_ulong)-1;
-            }
-            /* Re-start at the top of the address space.  */
-            addr = end_addr = ((reserved_va + 1 - size) & -align) + size;
-            looped = true;
-        } else {
-            prot = page_get_flags(addr);
-            if (prot) {
-                /* Page in use.  Restart below this page.  */
-                addr = end_addr = ((addr - size) & -align) + size;
-            } else if (addr && addr + size == end_addr) {
-                /* Success!  All pages between ADDR and END_ADDR are free.  */
-                if (start == mmap_next_start) {
-                    mmap_next_start = addr;
-                }
-                return addr;
-            }
-        }
-    }
+    return ret;
 }
 
 /*
-- 
2.34.1


