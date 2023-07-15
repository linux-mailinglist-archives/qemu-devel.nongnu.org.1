Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7C754915
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfm3-0001aj-AG; Sat, 15 Jul 2023 09:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflX-00013r-Ax
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflV-0003TE-RU
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142970df44so2816286f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429412; x=1692021412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vXDNUHkoHKMJOTYkZxcm9eNGIwvNIgvNekBczYJkm1c=;
 b=Kdbenx9rp9VTw4UAtVag07OENdIbBrGtxM74t2QdmZdaD01IPFtbiJ3AwsoNmWIJNJ
 vwB2OTOwxpCPPR3oXul96NOG248wt7TQaseKm5XtMs0XvbXkb5vlkP37TKydr2sEXctP
 fql3NP5DxlyccmSnslCOx0/ZwF02aJKlO6xi7a1tyVPbX0qGyuUcqxTftiTdypjsOjMx
 1SrKwQLQx2+JCqkLBohJUeLczSb0lc1OzIMHW6jtgJQ8xxjCD/wJEIOzpJbM950wnJZl
 W42F3N04k0J3zJ6H/Il1IofyFkF+Mke6lFp8Zd9/k1M7xR2FC2MTG8QLxzdJK+rbwWlj
 kPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429412; x=1692021412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXDNUHkoHKMJOTYkZxcm9eNGIwvNIgvNekBczYJkm1c=;
 b=le6Y8KDD6VVrRGjjqhMM9EUKOs3tPkCF/2AdU+0+CYm5biGFhXJfmf+AGAfQBedkVP
 tpGQPNVAV/iOqL9Ne3q/EAi9ot4GdEDCjwdOjjza4yk7fc1WmgLYU054LrrA2DapiWNe
 pJlInC+lozCgZ54zt3+0Gg+ukKYekT1IG3ws4cdXM74ZBy0rKC1qhLwq6I7CMypHnUVI
 eZuAHvt3/aZyBIsOeo4xKKpBJDKQkKmfplCnzp7C+FsWU07+s1sxkqg9R/kvkZIVlkME
 nqWyPSzNLXbz1m1btQh6Qi8/S50M1yCie4CBt1voB46xsYEFSi1PreHqxVGPur0QVrUR
 Iwcg==
X-Gm-Message-State: ABy/qLYZuRaLb4+WRCQ0T6u1UxwqPsTYZQW1R7wwhueRDGbRaPbI17nd
 hgpLR7ENQ8Ry2V1g0RSkTNWSDMS/T7B9bZrpZnPycg==
X-Google-Smtp-Source: APBJJlEZ2DsvqdTwWpqp132AR2wkvwoPT9GEcqDW8epL1JTZCtEFiIHJH2788Vbu7Zd0D+ZB/V+XPA==
X-Received: by 2002:a5d:424a:0:b0:30e:3f54:f8c9 with SMTP id
 s10-20020a5d424a000000b0030e3f54f8c9mr6059908wrr.10.1689429412591; 
 Sat, 15 Jul 2023 06:56:52 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b0030fa3567541sm13866651wrx.48.2023.07.15.06.56.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:56:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/47] linux-user: Simplify target_madvise
Date: Sat, 15 Jul 2023 14:53:13 +0100
Message-Id: <20230715135317.7219-44-richard.henderson@linaro.org>
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

The trivial length 0 check can be moved up, simplifying some
of the other cases.  The end < start test is handled by
guest_range_valid_untagged.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-27-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 49cfa873e0..44b53bd446 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -900,28 +900,17 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
 
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
 {
-    abi_ulong len, end;
+    abi_ulong len;
     int ret = 0;
 
     if (start & ~TARGET_PAGE_MASK) {
         return -TARGET_EINVAL;
     }
-    len = TARGET_PAGE_ALIGN(len_in);
-
-    if (len_in && !len) {
-        return -TARGET_EINVAL;
-    }
-
-    end = start + len;
-    if (end < start) {
-        return -TARGET_EINVAL;
-    }
-
-    if (end == start) {
+    if (len_in == 0) {
         return 0;
     }
-
-    if (!guest_range_valid_untagged(start, len)) {
+    len = TARGET_PAGE_ALIGN(len_in);
+    if (len == 0 || !guest_range_valid_untagged(start, len)) {
         return -TARGET_EINVAL;
     }
 
-- 
2.34.1


