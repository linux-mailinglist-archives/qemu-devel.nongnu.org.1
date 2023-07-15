Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C553754913
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfm9-0001tb-Cv; Sat, 15 Jul 2023 09:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflX-00013Y-0J
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflV-0003T7-Ck
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3159d75606dso2883846f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429412; x=1692021412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZRHsYp/A8D0Uk3Tfg/o0B0POYY0J/63KdYiHo0geXzY=;
 b=pte+MOtVN42ENbTAwjy/o/ISczktsK61lv990xKkvP8IQfOWMuPIHkUanVVmBeVwms
 xzH1v0wDwHRfv0H3oUF/apw6KkvdbPlq4g1sYs3mmg4dtOu8Bfe00fsst2yYDBrUWU18
 gwKAUqKHAC2UCRfJgS2cYLOXLIWVoaj33Ea42d2mQIFGZQcl+SagZafh7qfAzeIMAAUd
 31tdMFfWNnaw/p1xwqDcoAB0Hx2nTG63uVbfxiWhFpE/Ptux2q6DqARU/tUryK1W+2pV
 7X5HhGO5GGWDB8sVwnhiq1o5r7wCfxHQdTltYRCEVVryOfmMo8zf9f+gLPsP3ez1PyzT
 rJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429412; x=1692021412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRHsYp/A8D0Uk3Tfg/o0B0POYY0J/63KdYiHo0geXzY=;
 b=KikzR9R3zgQ/E5aigE+rjOPFj1qlJjGwIyaQMOlwHvXkBvlysoP/vcQEb+NssPvaSU
 CTyui6ZZVZbwP/G9NjUNrcqgTu5cVTcJE7/aAT1JHYXWO68Us0qR33KzuJ0ns8h+kMV5
 zzGwWSY0rS/jaqebOQgiQNkffP0+X+d9RXWAMj1C2oCnt8OMAyw1Th4LT3zoLRcQnP0S
 VXMwS4ybFPQkNRfSHab8YbQPTlOJ6QHS3bNUlAVssver/+WBu3zxCPOsXbxhvrpXwRZW
 0/uFHK3y/ugqcm8IxdnzMvMxrOw/iLeKlZtliibunsIiL2n+/FfNRWxyxaoxOg09y24W
 xzeQ==
X-Gm-Message-State: ABy/qLa1BA0JINbt1PmU7eRvW2hv6dQLGUDAIX0idjqLXNHh1iGo23Yr
 APXcIgPQnf0eU0snJmN1KHf06IA+3veI71kka50FVA==
X-Google-Smtp-Source: APBJJlEp9c/8MuR9FAlZlfkr1sFCIGMgyynXRCOKzepFwx0EiDZX1W6UIWsh4eF2zLG6G7pTe/rY7A==
X-Received: by 2002:adf:e111:0:b0:316:f25c:d0b3 with SMTP id
 t17-20020adfe111000000b00316f25cd0b3mr2600437wrz.22.1689429411936; 
 Sat, 15 Jul 2023 06:56:51 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b0030fa3567541sm13866651wrx.48.2023.07.15.06.56.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:56:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/47] linux-user: Remove can_passthrough_madvise
Date: Sat, 15 Jul 2023 14:53:12 +0100
Message-Id: <20230715135317.7219-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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


