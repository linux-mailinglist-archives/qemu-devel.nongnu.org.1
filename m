Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E091772B42
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EW-0007JI-Ic; Mon, 07 Aug 2023 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EN-00076H-El
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EL-0002i8-Sj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso42277755ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426236; x=1692031036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDhuT++xsqj01ETEWaKWE9ZYg7Hhe6sUk2NPXqCd0Zs=;
 b=n5zy/PhrTWy23L1oOIUnWS3oJprsmY065QGpA6tsdpW52JiRhhFYVFMZjyjUGt3qYY
 dvT4rvHyGK4zf7n5CLupovHy4sXDiLhepcpla6/cG5NsClwbHT1bYgzQGjSK4gedw8a4
 ueYvOG2XpIEZmehlu47t7pDkwiLeaJxLhGMnrY9fKN1C3K/UsDsBnWhVITz0oJeMZhrM
 uSX8RGODefpcG73TowuV83wnZ7t5y9qLriWuiPnR58Njg1VwJmTEfNbHN5cDMx1cP8OS
 mDY07idypRUIqK6ogu2OtRbhEq5H3Lu1L5PuvMO1nzf4Ls/PI0ixsbuIzCJVpA+oaOAI
 XHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426236; x=1692031036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDhuT++xsqj01ETEWaKWE9ZYg7Hhe6sUk2NPXqCd0Zs=;
 b=bBFsjioUinWt5MUPQdaDX3tzBJd1xA+zzq7Nv7aCexPrC+P6L1tbmZ2faNLCHAVwXb
 Nr5tAauPTY7W+2oDtLqQs5t4Hv/TYCc45l8GEUNnDOJofI6ZZ+83CXhd/bvhkOvJEFLL
 rbFz9JqxkCBlKqlqSeu3vRTmp4Uwj6oc7wODHy1BteQ1fM1o3wzj6kGccTAetd4tmoiR
 oFwt4rqAehpEDr26k2uVBMlLxQLALoC21oGLVlu2aVBStE+XWJWx+b/tBeumCZ1M70+B
 oBbd7hjeKHAEZfC3/RmtnHzCBVj6ZJDG8QxEDdWVEov2GjIbyehO5CWM1vJyEtJSdhAI
 w30A==
X-Gm-Message-State: AOJu0YyNiaEoeL5QC9ST2YpmaOO1OswXr2QB65p6O+2gQU7IBd6iaMak
 0hq7OfCpUVuL3HWdk0ubWWWq/5pbFA8w6nE5XKU=
X-Google-Smtp-Source: AGHT+IE8oOogRSkCK3NkJEnZlvw5H/UH4+A+pk/QD11PDJ03AeOOc6usZboIVur0jDVWUD3flYWoqQ==
X-Received: by 2002:a17:902:6bc9:b0:1bb:ed01:2d03 with SMTP id
 m9-20020a1709026bc900b001bbed012d03mr9511445plt.50.1691426236511; 
 Mon, 07 Aug 2023 09:37:16 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 11/14] linux-user: Remove duplicate CPU_LOG_PAGE
 from probe_guest_base
Date: Mon,  7 Aug 2023 09:37:02 -0700
Message-Id: <20230807163705.9848-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f497286abe..400af4a4c0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2562,9 +2562,6 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
     if (test != addr) {
         pgb_fail_in_use(image_name);
     }
-    qemu_log_mask(CPU_LOG_PAGE,
-                  "%s: base @ %p for %" PRIu64 " bytes\n",
-                  __func__, addr, (uint64_t)guest_hiaddr - guest_loaddr + 1);
 }
 
 /**
@@ -2607,9 +2604,6 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
             if (mmap_start != MAP_FAILED) {
                 munmap(mmap_start, guest_size);
                 if (mmap_start == (void *) align_start) {
-                    qemu_log_mask(CPU_LOG_PAGE,
-                                  "%s: base @ %p for %" PRIdPTR" bytes\n",
-                                  __func__, mmap_start + offset, guest_size);
                     return (uintptr_t) mmap_start + offset;
                 }
             }
@@ -2691,13 +2685,6 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
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
 
@@ -2749,9 +2736,6 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
     }
 
     guest_base = addr;
-
-    qemu_log_mask(CPU_LOG_PAGE, "%s: base @ %"PRIxPTR" for %" PRIuPTR" bytes\n",
-                  __func__, addr, hiaddr - loaddr);
 }
 
 static void pgb_dynamic(const char *image_name, long align)
@@ -2809,9 +2793,6 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
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


