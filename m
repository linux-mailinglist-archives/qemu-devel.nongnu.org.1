Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A238770BA9
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2r2-0004mJ-UY; Fri, 04 Aug 2023 18:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qi-0004X7-Jm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qe-0001iT-Ah
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bbbbb77b38so17986585ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186438; x=1691791238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hdHwW/RvIed/+EnufWmWBI5tRDE8abmk2/NQyBO25E=;
 b=lPDpZoBFwd0pLT/ijWF4GExWIzzB5G6tlz9fOgyieetGdhbrzZJM220qT4NbH3+Obk
 zu/osbsoi6Bz7seTmP0dtq09gPESHJMVYZFPXscNFIL2GfvPNBukMXHmM8E9GOxt0+aT
 7ssJUP+57sy4DcMlws03DFg3Vv9mBMwE6cmCadLkiOeHdgkQr4Kh3KB3YLEX2gY5oGM+
 AVS6MFij5YQSlvHaHzGQVJrHydN/JHgDy4F3olTDbWA+1luxZ2hgY0JxMFTgl5blpcgg
 RolIm++nbjCnnfs9+tUeCCCF9gG/jL1TTJJCAsjsE3VUiZiFtvMu37nwa2FEjDORdYhO
 dKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186438; x=1691791238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hdHwW/RvIed/+EnufWmWBI5tRDE8abmk2/NQyBO25E=;
 b=Dkor0HK9iuSJDL59Qo5LPYcLgDzUE2/SWCJJoTzMXBExYzcVf6NyYTaa9R/CkR3C97
 4/ai2ETCzn20ryviCAw89Fgslu1B6SM4ajf3EhgJuBe7CT7mq0TX7+OH2MiQHmL6k29S
 dsudzcQpqoYiTrr1RgaidEQtDfnM6YgL4dvoQ0yaZqnJZE01Kco41yzhS5DyYDbDD6v5
 MXos9deFCsz/tLRUKlCLYR+JUkW1VWF2nNYeaHiNKyr0vE4NnX3WrtSBFF8urRGxcVZu
 d8m6HVrQxr1JpqXM2YWoyWm/hsE94CtHF2hLPkDuPOXDI0l1YQlmCQ3Q44loWzzZ9Yge
 JDmw==
X-Gm-Message-State: AOJu0YwtiezEaJLJs+N/MAghS3ys1zh9l8a+uZ7IwqU0Y8d8/ZD3vFIN
 tl6yvPu0u5VmSuk3oHhyOPtECMsRtVYFAjWcz/s=
X-Google-Smtp-Source: AGHT+IFOMrzsnhd5ExEMKYhqpqfxzD+C6ZJAO1zVWurWbodAgOeRpZJHDAneCI0njWyBGZZmecUs6g==
X-Received: by 2002:a17:903:1cc:b0:1b3:d4ed:8306 with SMTP id
 e12-20020a17090301cc00b001b3d4ed8306mr2507041plh.19.1691186438190; 
 Fri, 04 Aug 2023 15:00:38 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 05/24] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Fri,  4 Aug 2023 15:00:13 -0700
Message-Id: <20230804220032.295411-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Passing MAP_FIXED_NOREPLACE to host will fail for reserved_va because
the address space is reserved with mmap.  Replace it with MAP_FIXED
in that case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-2-akihiko.odaki@daynix.com>
[rth: Expand inline commentary.]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a5dfb56545..a11c630a7b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -603,11 +603,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
-        /* Validate that the chosen range is empty. */
-        if ((flags & MAP_FIXED_NOREPLACE)
-            && !page_check_range_empty(start, last)) {
-            errno = EEXIST;
-            goto fail;
+        if (flags & MAP_FIXED_NOREPLACE) {
+            /* Validate that the chosen range is empty. */
+            if (!page_check_range_empty(start, last)) {
+                errno = EEXIST;
+                goto fail;
+            }
+
+            /*
+             * With reserved_va, the entire address space is mmaped in the
+             * host to ensure it isn't accidentally used for something else.
+             * We have just checked that the guest address is not mapped
+             * within the guest, but need to replace the host reservation.
+             *
+             * Without reserved_va, despite the guest address check above,
+             * keep MAP_FIXED_NOREPLACE so that the guest does not overwrite
+             * any host address mappings.
+             */
+            if (reserved_va) {
+                flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+            }
         }
 
         /*
-- 
2.34.1


