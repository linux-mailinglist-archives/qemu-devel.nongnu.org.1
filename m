Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1F576720C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPQLY-0007UM-Gv; Fri, 28 Jul 2023 12:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qPQLV-0007SD-F9
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:29:41 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qPQLT-0007gD-S6
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:29:41 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-785cbc5bfd2so92115239f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1690561778; x=1691166578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sHvFvgWaKoBsMB0EX+juv/wbA79eq/aNJemQawAvSgc=;
 b=WX49/z4oeK173vRH3rebN0Lm7rO8FgfJKYGHFsfg7n7o9SoOE2Dr1r4/GdiQgWkUTu
 pnrl4xp7fU95pG/DDleTP8B/RFGXm70O/SLLfGGN0q+vm4VAPEY0AdX1903+1ba4gfqZ
 KZGxia8NJAY3uzUVCixs9MYp9ALrbPbosQA6ujwrYhJOEttXJL2WqN3qJ5rl1tL3pExY
 p7ZU/B6tKiK+MWpn/GRofADOR8VWVywRWceAWkvwjMqKs6+gh4KK/dRPto0/8pEyz8rm
 oIDDbBW2CwAt6FY6eQvyGKAFQqpGDJRb8dqH1BGGFu54GNH/+wsFd1Ne3r/Fm5tVhA8n
 ojBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690561778; x=1691166578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHvFvgWaKoBsMB0EX+juv/wbA79eq/aNJemQawAvSgc=;
 b=FKyf1MERsnHzOJpdKD6+u3XxqickGB7/D4K8+iKdXlbqtZJKhoYNowjzWZwM+SNk2b
 XzwCqzsLM9gCSPHCVDe37Pr6nnB9P8hSIJvoJk0fTvAtPplAfrC7sxKpWj/al1MRsjxP
 x5KNWZbsrjrbXBm1lekYMp1L1Uw+4ChmcgZE/PlY1OyjV2dMQr5P8oeE3hbC1y4eFo/C
 QC5taMsa7iDHYIWZsmHNFHUfxRgtJsU9tVuzZPC77eNVvHmrxDXA1NdMevo6Bl96Ji5S
 H3ScRHChA9U1PWESyUm9XSKYqMhv91M3Zy5RTuL8g39karzz7Jj/odetyOmU3p4BvP0x
 yFNA==
X-Gm-Message-State: ABy/qLY3++hPOpVq8Ni8EF6cAkdMOg1SXiiyvfEq+c/CeQoLmT1SFoAd
 gRHnkrsygsl0PYttGU/fJ2Owpl6eLisuyKadmwl2Iw==
X-Google-Smtp-Source: APBJJlHEhRJUWWGte6TAd79VU5gc9+XLPhi3b0EtuVVF21R6UL0LuiPGBqLLotAD/xI9F8V+0JalkA==
X-Received: by 2002:a6b:db01:0:b0:780:c787:637d with SMTP id
 t1-20020a6bdb01000000b00780c787637dmr34884ioc.17.1690561777860; 
 Fri, 28 Jul 2023 09:29:37 -0700 (PDT)
Received: from dune.bsdimp.com.bsdimp.com
 (50-253-99-174-static.hfc.comcastbusiness.net. [50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a0566380f9000b0041a9022c3dasm1152875jal.118.2023.07.28.09.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 09:29:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, kevans@freebsd.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2] bsd-user: Specify host page alignment if none specified
Date: Fri, 28 Jul 2023 10:29:27 -0600
Message-Id: <20230728162927.5009-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We're hitting an assert when we pass in alignment == 0 since that's not
a power of two. so pass in the ideal page size.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 74ed00b9fe3..b62a69bd075 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -260,7 +260,8 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
 
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size,
-            (alignment != 0 ? 1 << alignment : 0));
+            (alignment != 0 ? 1 << alignment :
+             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
     }
 
     addr = start;
-- 
2.40.0


