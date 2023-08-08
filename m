Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD766774C85
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:10:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx3-0007jl-8U; Tue, 08 Aug 2023 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx0-0007ie-VV
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwz-0005xL-8X
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bb7b8390e8so39599765ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528948; x=1692133748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DA7hmKIihrFnBJ2BJ8RPoXnfnYlRYqVeJaGCMsToUv4=;
 b=lRkrmR244c2OP8DOAY8VONJyqtTvR+JaD4rpMJFCLV8I8PaxMJ33J8TutC+GPJ3/Jb
 JHw4pgUg1FAV7NV9hmMQBxO4FE/3XgTes0pXrhqWqsxdXFTS3n6kgHLTFKsXvIKO9pVA
 pqCDDwEhtkVXCjXRyjXgPbBElXvOIbPUcAevFrfxTx1djhMU0Oiax3zjf2jDNcx85UZl
 ZrvDPMNxKHGR0yt4lLaiPlMtMUIpm2o40X8J/BlgwlIn6EUCM1XSPgb1tvZjPsSZsCjT
 lCobBAZ6+ZPzSUruy0zfq2gJXLj6PrYCSl83gsSuz95KmMEc5l5AdeDefQcFFNQcgqkh
 ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528948; x=1692133748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA7hmKIihrFnBJ2BJ8RPoXnfnYlRYqVeJaGCMsToUv4=;
 b=JJyj0Y9sfhdpO+3BeRQCXAEolanYgt/RNRABDyyaEotIpLiwXYvKYdmuXG+z+MSedH
 jQ5S4GfBLJev9dL8ongpuGy5TOCC6lBystGO8rlh7Va1s3bRelD7iJvhiAWvncYvlCPr
 Si9RIlvA9b0NxdvPoUQ85zmVqXrg7eAPvaTU0G/zMUVvbkf3c3Xus6LIoHeLmcpsZYCE
 uzEDAznppdLrrzfkIWh561L9xzoFFq9SHGVuIuZvxjXwTFIVWvWCJsqAreJ3ruruuffn
 YkcIuzwfvR8uAO9Mz2E/K43e2vN/ACjlazA+Qvfgu0uapupX/RmKs+3uoEQEU64zX8Tr
 B2xw==
X-Gm-Message-State: AOJu0YxYNiedZ9Qm20KgGgq/GnywODDddUDJMO2y5AVToGImoxwz+IgB
 EPwdqcg9FcSIOErqxVqc7Th2L0I8cRnEORre97M=
X-Google-Smtp-Source: AGHT+IH540EyhUttyBbtFvPI7kqJGBYqo4xiTRhkqpzZzY8B8dTGNoywkRtjfUY/IXmJDf2Uhh9pjw==
X-Received: by 2002:a17:902:6b49:b0:1b9:f7dc:b4f6 with SMTP id
 g9-20020a1709026b4900b001b9f7dcb4f6mr760277plt.44.1691528947949; 
 Tue, 08 Aug 2023 14:09:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/14] linux-user: Remove duplicate CPU_LOG_PAGE from
 probe_guest_base
Date: Tue,  8 Aug 2023 14:08:53 -0700
Message-Id: <20230808210856.95568-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The proper logging for probe_guest_base is in the main function.
There is no need to duplicate that in the subroutines.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fb137345f6..c14139a5fc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2560,9 +2560,6 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
     if (test != addr) {
         pgb_fail_in_use(image_name);
     }
-    qemu_log_mask(CPU_LOG_PAGE,
-                  "%s: base @ %p for %" PRIu64 " bytes\n",
-                  __func__, addr, (uint64_t)guest_hiaddr - guest_loaddr + 1);
 }
 
 /**
@@ -2605,9 +2602,6 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
             if (mmap_start != MAP_FAILED) {
                 munmap(mmap_start, guest_size);
                 if (mmap_start == (void *) align_start) {
-                    qemu_log_mask(CPU_LOG_PAGE,
-                                  "%s: base @ %p for %" PRIdPTR" bytes\n",
-                                  __func__, mmap_start + offset, guest_size);
                     return (uintptr_t) mmap_start + offset;
                 }
             }
@@ -2689,13 +2683,6 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
         }
     }
     free_self_maps(maps);
-
-    if (ret != -1) {
-        qemu_log_mask(CPU_LOG_PAGE, "%s: base @ %" PRIxPTR
-                      " for %" PRIuPTR " bytes\n",
-                      __func__, ret, guest_size);
-    }
-
     return ret;
 }
 
@@ -2747,9 +2734,6 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
     }
 
     guest_base = addr;
-
-    qemu_log_mask(CPU_LOG_PAGE, "%s: base @ %"PRIxPTR" for %" PRIuPTR" bytes\n",
-                  __func__, addr, hiaddr - loaddr);
 }
 
 static void pgb_dynamic(const char *image_name, long align)
@@ -2807,9 +2791,6 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
                      reserved_va + 1, test, strerror(errno));
         exit(EXIT_FAILURE);
     }
-
-    qemu_log_mask(CPU_LOG_PAGE, "%s: base @ %p for %lu bytes\n",
-                  __func__, addr, reserved_va + 1);
 }
 
 void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
-- 
2.34.1


