Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D04374C74E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEG-0005TN-O8; Sun, 09 Jul 2023 14:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZEA-0004eg-Sd
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE8-0004K5-KE
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307d20548adso3709569f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927623; x=1691519623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRHsYp/A8D0Uk3Tfg/o0B0POYY0J/63KdYiHo0geXzY=;
 b=mMoCMklIrOEVeo9gSyyjnpyAee6Tn3Zwd9lMS9f0NVqSbhQDLo1leNcYaVy7ES37TE
 nPFQBH4wuDkHZYxvdqd0SBNj6p0UdH3PMc9yZpnK5iLY+pRnzOYxlqXrJwyrBgiPjmmE
 u+f/CxM4aqDoL/CpjNbiBgP/R20At12TaKz6etgSGb5XaHwWU3bSx/oJJWH29NmElfvU
 nfp9j/J1E1PZXS5kzjl8cYiRg8xh1bRwqUmTxllDd3h3DxukZSIO0i6auuhvtPw3FYso
 QVB110MhdNSafXl9Q8/ghLixOfjO6MGimStFCZwGxiqihZvZiaBfLFCLpg20GK+vBZb3
 UQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927623; x=1691519623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRHsYp/A8D0Uk3Tfg/o0B0POYY0J/63KdYiHo0geXzY=;
 b=l8E5NL4S/vnxF98Bg0sEURmqp/gSd5QHfm4WaZ+qYLQ3M+OWlq4fFAKV5RJy4mS6Nd
 gz5kevU8/TJyO4xjXDExad5DZ2QbnlAW1B+GDT8zrOGK38fSwDg1Mfu7XIlMMgm3YdGr
 89L5Sp8LvfUXbvwiBjorJV3O0wIPsJGilsUtwso5otX7ZozP6qX8nNTD0z9Upvibnd0+
 UDxm2HjjyqP2xF6xLLGllFEK2Y7IM8Tt+xiCVAOSHS2gVhmP1QFTVZ3Yp5tKn8IEe/hl
 D8GYcbb9MwJ0yQu24hQuq/FH9nvoNiCPX/A2j7DRa8UMK1OBv3vN3Ap3baRKayJYzsjC
 ryfg==
X-Gm-Message-State: ABy/qLaQ9aFKxlJhvivmnEBAZiArkeKnLZYjTTJt7nXe/B2XqLH+pS76
 OrD6/QHm/4lFW7Sy4PSFpES+0cik5BCi5Q3SEkyvhg==
X-Google-Smtp-Source: APBJJlGI1jtHHVZUiQz6y7gGUa+jJbJF5vwV9BQ+X79uZBkbdgAAejW+Tk4QVXHzOs07hYU1PrXTeg==
X-Received: by 2002:a5d:5109:0:b0:314:dc0:73f1 with SMTP id
 s9-20020a5d5109000000b003140dc073f1mr8442169wrt.38.1688927623387; 
 Sun, 09 Jul 2023 11:33:43 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 42/45] linux-user: Remove can_passthrough_madvise
Date: Sun,  9 Jul 2023 19:29:31 +0100
Message-Id: <20230709182934.309468-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

Use page_check_range instead, which uses the interval tree
instead of checking each page individually.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-26-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c0946322fb..49cfa873e0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -898,23 +898,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     return new_addr;
 }
 
-static bool can_passthrough_madvise(abi_ulong start, abi_ulong end)
-{
-    ulong addr;
-
-    if ((start | end) & ~qemu_host_page_mask) {
-        return false;
-    }
-
-    for (addr = start; addr < end; addr += TARGET_PAGE_SIZE) {
-        if (!(page_get_flags(addr) & PAGE_PASSTHROUGH)) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
 {
     abi_ulong len, end;
@@ -964,9 +947,8 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      *
      * A straight passthrough for those may not be safe because qemu sometimes
      * turns private file-backed mappings into anonymous mappings.
-     * can_passthrough_madvise() helps to check if a passthrough is possible by
-     * comparing mappings that are known to have the same semantics in the host
-     * and the guest. In this case passthrough is safe.
+     * If all guest pages have PAGE_PASSTHROUGH set, mappings have the
+     * same semantics for the host as for the guest.
      *
      * We pass through MADV_WIPEONFORK and MADV_KEEPONFORK if possible and
      * return failure if not.
@@ -984,7 +966,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
         ret = -EINVAL;
         /* fall through */
     case MADV_DONTNEED:
-        if (can_passthrough_madvise(start, end)) {
+        if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
             ret = get_errno(madvise(g2h_untagged(start), len, advice));
             if ((advice == MADV_DONTNEED) && (ret == 0)) {
                 page_reset_target_data(start, start + len - 1);
-- 
2.34.1


