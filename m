Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF0770BA6
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rG-0004rQ-54; Fri, 04 Aug 2023 18:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2ql-0004aT-1R
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qg-0001nJ-JH
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so18082755ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186441; x=1691791241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8M/sECGKblXQECxwhiXY/mNUP2fHciHERdH2OiT8nA=;
 b=URbVDpZtOGNC5hpJterst+zcn+LmZ0H52ajLs5rR4C/g3FML0E36w5LGt9LS3t6zRr
 OwVQiiVwZgEp4fnP5fEYWsLpdUnOn9oqOjx1mLF91Y4DJpTPDMorngourzXdFBNw9TWC
 2v00IxMjimraHuEyAfbEz2RxmTwCwynMTfEgLXLsbw4pC4EOb1NQGbfaSgQOCMGtdlym
 aoecHlSiVxYUZHIfpBZkcF1XyhhLFgaDir+dmqJoStxIVHYK66TDvnB12i29GgVD1l2d
 1jxv29FpOEjolI3L4fux2md6rGCb4BgAF5un+EOYeyNI0mXLjRyHfi2PKn4OhCZl7KXo
 P2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186441; x=1691791241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8M/sECGKblXQECxwhiXY/mNUP2fHciHERdH2OiT8nA=;
 b=V5rMzB3AZNHxKvFhhZKskgFSnS75aMkqkZNBlINqNL1sm7tATUGyHM1C9WpgBAbA++
 OQ14hWI3AW+nsTMNxbACuekrGyRhJtnjQK3bZyhLySdg9QclRKAhAb2VzSfjp1uSapUt
 YmCJRl/LkINTAauMPOxTGAYn98nJWtlNu+5ppzy9sjdvi6H8kzilH9Myn5CXJVVXDcId
 CUQwLmvLAHc7PqFmN4rqJy8ckCI29MRBfF7sUXpGQHD74AFMonynriNMqOpRa7QNWe4s
 ETQAY8NCn05J87OjzKIHpepu7VQ6+wHVffd0FhDyuMRWrqnU5gJ9h+PT6gKrBlVdrUL+
 oE+w==
X-Gm-Message-State: AOJu0YwsEV7id3Yg/bA1DI+w2Wjx++qyDPbqdh3WQ8ZyyXUE5zaB6qqG
 25PcytcGybAGfgMYbn6X0Iwr1wNhLOxXP5y2HYI=
X-Google-Smtp-Source: AGHT+IG+KHBw+Kd5NUx4rZ/Y+snEUDfpH17SVvs+iCiI3iZeo+1Fwt48fD2BK8zOCqebdTNrzE7upA==
X-Received: by 2002:a17:902:ea91:b0:1b8:b442:aa97 with SMTP id
 x17-20020a170902ea9100b001b8b442aa97mr2824551plb.54.1691186440849; 
 Fri, 04 Aug 2023 15:00:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 08/24] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Fri,  4 Aug 2023 15:00:16 -0700
Message-Id: <20230804220032.295411-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-5-akihiko.odaki@daynix.com>
[rth: Pass -1 as fd for MAP_ANON]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..f64024273f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                                  -1, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk = brk_val;
         brk_page = new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
     }
 
 #if defined(TARGET_ALPHA)
-- 
2.34.1


