Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D90782003
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpHV-0004xE-WB; Sun, 20 Aug 2023 16:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHU-0004wp-0n
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:16 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHR-0007kS-Pp
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:15 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a8506f5b73so827941b6e.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692564252; x=1693169052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5ksMQj35m+yCeIWGrGNigy7JAnPo0mf1QEQxYD2q74=;
 b=SuyWFW9ej64lgYdJXhALlEdw5t87+LOrwCfZdIZu1IDlBJKfdCEb8LgNBMCy0cPYQg
 PpoUHuA0uB2V38JnFEcfSq0n59r54GyfswghCJvK3HjBXUT+UWbNxJkH5u+Sb2a24d7z
 l8i27ohh10xMH8wByxELPIpM5f0Q5hQ7uUTB/14w7Yp4sf/yhjHkn+diJk+2uNMk914I
 8ZQm4+CDRUtJkS98+WUof4y3jpoIs2Gb9cDp7RZSt3vVEJeAI/ga5SVJxr4Lvmq2VZFg
 wxSWWz30M6GvLL6YiUFOeMrwNWRA2I1GvU72OeqJdYgyUuiM6sjIHQ0iVluJS+pJm+MC
 42Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692564252; x=1693169052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5ksMQj35m+yCeIWGrGNigy7JAnPo0mf1QEQxYD2q74=;
 b=c4phwQfm+IDhaaHfhu0TRNd7x+kdGci19afUuthHjNi2a4E42TDGsDwp1k6oxGMUBk
 sAaWdw+8qXdKQj7/nXK8SBXKfpJGmDmRMxiQ4P+GVaDrPvNSpnuYDlLrjlkWg2tqFYtY
 SEQYbLd+4sekGp6NzJvFY7BVX6vpwKR1IappysilBp9b9B1Gk599XI7E8wIXtOgIcwn+
 DaO8kY2OnQozD0zR5AO+jgvo2nEf+eFE8G1HMPEAsYfvZyxgRSoJrRZ5K33uK3tR4sMK
 D77A88uo87/ngnQ+h7xP9abUFKC9033gARLJaoQ+DEK5QqpD6i6xChv9RJUPpKHct9LE
 Y9Vw==
X-Gm-Message-State: AOJu0YzP8GWSV+mwLpr9h0LIzTAJcUK2dxchIX4D7WRQHEfYPyLFVDjg
 BohpK7gljuho3hlalFJsWQltzA9koOwu5Eg7Dkk=
X-Google-Smtp-Source: AGHT+IGMvV4RrChC5dshFWC0BnoI36kI0r3Jh9iO2QTPC5x4nXIGPTutaImQi7prA0SQRvh+E53KOg==
X-Received: by 2002:a05:6808:2391:b0:3a4:35bb:edae with SMTP id
 bp17-20020a056808239100b003a435bbedaemr7899256oib.29.1692564252746; 
 Sun, 20 Aug 2023 13:44:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa78c07000000b0064fde7ae1ffsm1430149pfd.38.2023.08.20.13.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 13:44:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	imp@bsdimp.com,
	kariem.taha2.7@gmail.com
Subject: [PATCH 3/4] linux-user: Fix shmdt
Date: Sun, 20 Aug 2023 13:44:07 -0700
Message-Id: <20230820204408.327348-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820204408.327348-1-richard.henderson@linaro.org>
References: <20230820204408.327348-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

If the shm region is not mapped at shmaddr, EINVAL.
Do not unmap the region until the syscall succeeds.
Use mmap_reserve_or_unmap to preserve reserved_va semantics.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f45b2d307c..44116c014b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1102,14 +1102,25 @@ abi_long target_shmdt(abi_ulong shmaddr)
     /* shmdt pointers are always untagged */
 
     WITH_MMAP_LOCK_GUARD() {
-        for (int i = 0; i < N_SHM_REGIONS; ++i) {
+        int i;
+
+        for (i = 0; i < N_SHM_REGIONS; ++i) {
             if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
-                shm_regions[i].in_use = false;
-                page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
                 break;
             }
         }
+        if (i == N_SHM_REGIONS) {
+            return -TARGET_EINVAL;
+        }
+
         rv = get_errno(shmdt(g2h_untagged(shmaddr)));
+        if (rv == 0) {
+            abi_ulong size = shm_regions[i].size;
+
+            shm_regions[i].in_use = false;
+            page_set_flags(shmaddr, shmaddr + size - 1, 0);
+            mmap_reserve_or_unmap(shmaddr, size);
+        }
     }
     return rv;
 }
-- 
2.34.1


