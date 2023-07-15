Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4747548EC
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjU-0004oW-V3; Sat, 15 Jul 2023 09:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfib-00048s-R0
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiX-0001KV-JP
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3158a5e64b6so2838277f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429226; x=1692021226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5+vFU351RDeVAwRNg/WDopVOnzTmK+ZtjZmF1Bh7abU=;
 b=gl8UCtlyjZ+44cSU46EvsZ6D3W6fUiGFIVosIPmVY/yq5QzH+2yS8TzW9HJHyQhhX5
 ctlh4pp4E9CrrLkMEOLYlop9lsHZAnxryhpCPMrClNS5W4xhM2+ChL6a3mxtOF48mTx8
 HlwPsnmYNwy7rfbKwx8mbKXO+JsX3LDSIOP+3uKUhYabJKw7GtdMCUb4+Ry8N2reRgJg
 abA5Ss+WF8Hn334/cwEX/a2QIn2iY7K09eCn90X2Et8ZC96shSdkODyiv+3AXCbrmkCY
 EcjQ+5QkUJvht470p0uHXG5KRRhvkyF+LHYouag0xGI+6K8iYcWSEVqLRC3L7b/M/4SK
 a+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429226; x=1692021226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+vFU351RDeVAwRNg/WDopVOnzTmK+ZtjZmF1Bh7abU=;
 b=GynDokG/71TfYCp0VmTg0G1KsWmZATXA8D+FtR3Bhd7qoQUaQkW1KjcsRcYCSDniNU
 kG97H7PoC59Yx84Zq7ua9pHtNofgoWs6uUbhr8qdfNSPO/LBsiZd2WHk27zWxSxBVr5P
 kz7S4tYpqOjfu4RrIE6ue2mrA+VqCwwz6lBc7DrG5aV8iyFh8lFGNnSSzBbzLfXTIbQK
 XnY4Fr7gKiMwkVqLyNjN7g+y+gYqIUZPU/ydXDoKnnrcuwOXlBlni7NrhmhhvNQX0b3t
 L/K+69yE3dS5XC3lws66lb+TaIr+AxoM+d6WW/R/9mpyUyUU+tCPgMGXLnkFkh9Exq18
 Py/w==
X-Gm-Message-State: ABy/qLZGPUMoQcP6iSFhcnf6Avhhhlt5ggXfLko4atPWUO48iOGAFhao
 owxm7v3BOji7WZkLzqCgrJJXcR9QUECko7gj0/fkEQ==
X-Google-Smtp-Source: APBJJlHNxc4ln2nstts4VI3tWYxsa05SYU+4h9W/BAwW+ltLppYPwe4OTdFE4g1nnBZ1RnYXYnWKig==
X-Received: by 2002:a5d:698a:0:b0:314:35e2:e28d with SMTP id
 g10-20020a5d698a000000b0031435e2e28dmr5522907wru.13.1689429226689; 
 Sat, 15 Jul 2023 06:53:46 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/47] linux-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Sat, 15 Jul 2023 14:53:05 +0100
Message-Id: <20230715135317.7219-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
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

Use the interval tree to find empty space, rather than
probing each page in turn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-19-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 52 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 46 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c4b2515271..738b9b797d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -318,55 +318,15 @@ unsigned long last_brk;
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
-    /*
-     * Start at the top of the address space, ignoring the last page.
-     * If reserved_va == UINT32_MAX, then end_addr wraps to 0,
-     * throwing the rest of the calculations off.
-     * TODO: rewrite using last_addr instead.
-     * TODO: use the interval tree instead of probing every page.
-     */
-    if (start > reserved_va - size) {
-        end_addr = ((reserved_va - size) & -align) + size;
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
-            /* Re-start at the top of the address space (see above). */
-            addr = end_addr = ((reserved_va - size) & -align) + size;
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


