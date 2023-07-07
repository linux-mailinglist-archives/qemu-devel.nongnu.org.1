Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D974B83D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGc-0004zW-6t; Fri, 07 Jul 2023 16:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGS-0004r8-2Q
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:17 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGP-0004uK-Si
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so3843884e87.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762472; x=1691354472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3pB3AzQ33HXE3XP6riFkr6cxMvSqstuDeeeDRipPQQ=;
 b=SWom5NruSHwBYfIZXY4JlRIa5yxfyLXmkW7YSt54qa/GuoEyDxm631i4lGmsY/UwcJ
 a02Zm/B0IUzTk1MnHtPIISPzrh1m6qLjPQf2sX/7DHtFSBKtGLChRLn65lB26oNuyuuy
 2t95Ki7+kyG9sXoYcMKYZwdTwkz98olBNJuDPHGHdBchvHsj5RtFEBZxMx/0X6NbZnsn
 p/2zEg8fHzR8uiKu8S/4Taw+tz4A80CfmXigOrKmD0CJ1YN1ZmC9Kma+oacAFS3Rlmfn
 roodu7HFwAqcHnLZ64j6rG5BYetynn67OottrcnUKLx7ULbB5uYo8teuXuFr85Zb4HdM
 +1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762472; x=1691354472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3pB3AzQ33HXE3XP6riFkr6cxMvSqstuDeeeDRipPQQ=;
 b=glBIEQxL60g5vQkqZ8WJcREfDnfhF+NsH8B2kTwOTQQ4+BWy+33WjUkL/MlFOT4PTe
 /7WZabCsljUos++iUqtrsukTxQRRd7hJMNxXaN8kLffEIlskjJFzX8/aEzvsaDtyzXxe
 maaCqcw5lMR3QwbOk+x7Amts+c1Xx66pA+8Z7dIum+tYrQe2LZ6e11VklC1a8QAuvECe
 ElaGqGc/Yqh0QKkwiqqobAKtdWS4bpZPn4Oy841jaxWcMngA6rb6j9L7MiH3pG7uGbYR
 BBajW6Nzi6GzcL5/kwszoBD50dF2r1jS8Bi4rbA9gQyiA+az5hqSE4xGTohhzSY/1bHL
 c4aA==
X-Gm-Message-State: ABy/qLZJqXUTNA1V8EPFa6qDvIt7zWWCqN+1uwWmyNmAHpcDVfC5g8XY
 tvlb0Rsn2hViCaKmntGhVeUJcuNS3WyQH11SDMx7+w==
X-Google-Smtp-Source: APBJJlGEAHeh8JEyu8xMoSRm7gbts2kmSIYDvKgFUyE5rO/wU9eKHl6skEsegdHZD3ryqUvGqzHI3w==
X-Received: by 2002:a05:6512:3292:b0:4f7:55e4:4665 with SMTP id
 p18-20020a056512329200b004f755e44665mr4198859lfe.56.1688762472227; 
 Fri, 07 Jul 2023 13:41:12 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 23/24] linux-user: Remove can_passthrough_madvise
Date: Fri,  7 Jul 2023 21:40:53 +0100
Message-Id: <20230707204054.8792-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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
---
 linux-user/mmap.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e6463ecd8d..a2bef1ebe6 100644
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


