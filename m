Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13F743CBF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4n-0007iy-Ro; Fri, 30 Jun 2023 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4l-0007hP-Qm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4k-0003RO-4F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso105346f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131332; x=1690723332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwXUao5fPiuRB2dzq6NZ4hhHKX7vwYCJevjTXUXfOjA=;
 b=itKu4EMVKahoT+E93KzdauxK55wwu4oLz0zFvoMNn5+ep63LvPey39LtQIxBikZf13
 xs4VooEnBkqKSW00hceAEbyiHlonw6HRZ+cD2BSoUm5iAl2tlYTuRul9dDSReGd65irD
 7fgbLiE+HQzA4dSJnPe1KYJgeQ2ymVbOXbVmPw30j4UtD78CdctsmYiVH0bbo1C9tHYk
 ggjq5PQrnTJuAi7S0ypeyMb1hltDSrju0LtAkLbnF8brljgONK5fo9rZvJQ8E+NBfntV
 4miijhkM7vPqHZkw5jY9I0upLe6Rewr6bV4cNvY//KDfaDVyDLj4igOfOK7tWuHmGlyP
 cq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131332; x=1690723332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NwXUao5fPiuRB2dzq6NZ4hhHKX7vwYCJevjTXUXfOjA=;
 b=Cwj2D0ajAvpuvTaL14Ms4JA5PKVzhyBft+w3CtTiEC3RUk5euCzkERnp0WxgLNsuwd
 VvYiN4xXsIyF365FKNslr97pHhUuAf4qkJ+iRhUSRwfC0rfE9hZyJysPUSJsg+aA1enW
 J54fEJ7m9c2cBFoA259Eg6TTPrpMzvOwgoZaecPwB+4Afbs6O9FQvdjd8MdlRsJLFtEJ
 39gECUH0AmHcXRFd0sPbdoVh3ORr0ysKJB+g1m05u0ZJNzppSgSYD9pwCyt26v0eDpky
 uzDz4Gx7tS/856/+f+ZICcwiUMbzw2qudlxZ6aBIYyWxqbfGqRAA8Jl7wId/ZoXaz/MX
 Dmow==
X-Gm-Message-State: ABy/qLZOsJWMKKB6zknmgcj2fTBdlXtjwAzFZxqoxvNprJXvW3kCMdXV
 O3pi1lMsm2zxJxjoh1RNJkrS9JPhwJcOR+Avg6qvpA==
X-Google-Smtp-Source: APBJJlFMvZa7FC34wSVbBU/I25zD0K5nq+sM/cJGG5vJaFfHQHG09gw0RqLIQsY1c/z4HOfc831gLw==
X-Received: by 2002:adf:f20d:0:b0:313:e80b:2273 with SMTP id
 p13-20020adff20d000000b00313e80b2273mr2005791wro.46.1688131332583; 
 Fri, 30 Jun 2023 06:22:12 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 15/24] bsd-user: Use page_find_range_empty for
 mmap_find_vma_reserved
Date: Fri, 30 Jun 2023 15:21:50 +0200
Message-Id: <20230630132159.376995-16-richard.henderson@linaro.org>
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

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 47 ++++++-----------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 07b5b8055e..0d06bd457d 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -222,50 +222,15 @@ unsigned long last_brk;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong alignment)
 {
-    abi_ulong addr;
-    abi_ulong end_addr;
-    int prot;
-    int looped = 0;
+    abi_ulong ret;
 
-    if (size > reserved_va) {
-        return (abi_ulong)-1;
+    ret = page_find_range_empty(start, reserved_va, size, align);
+    if (ret == -1 && start > TARGET_PAGE_SIZE) {
+        /* Restart at the beginning of the address space. */
+        ret = page_find_range_empty(TARGET_PAGE_SIZE, start - 1, size, align);
     }
 
-    size = HOST_PAGE_ALIGN(size) + alignment;
-    end_addr = start + size;
-    if (end_addr > reserved_va) {
-        end_addr = reserved_va + 1;
-    }
-    addr = end_addr - qemu_host_page_size;
-
-    while (1) {
-        if (addr > end_addr) {
-            if (looped) {
-                return (abi_ulong)-1;
-            }
-            end_addr = reserved_va + 1;
-            addr = end_addr - qemu_host_page_size;
-            looped = 1;
-            continue;
-        }
-        prot = page_get_flags(addr);
-        if (prot) {
-            end_addr = addr;
-        }
-        if (end_addr - addr >= size) {
-            break;
-        }
-        addr -= qemu_host_page_size;
-    }
-
-    if (start == mmap_next_start) {
-        mmap_next_start = addr;
-    }
-    /* addr is sufficiently low to align it up */
-    if (alignment != 0) {
-        addr = (addr + alignment) & ~(alignment - 1);
-    }
-    return addr;
+    return ret;
 }
 
 /*
-- 
2.34.1


