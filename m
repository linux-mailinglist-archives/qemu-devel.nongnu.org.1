Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744073837F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwo9-0006nP-8X; Wed, 21 Jun 2023 08:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnt-0006dy-8Y
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:19 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnn-0000IB-GB
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:12 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b475b54253so52926031fa.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349949; x=1689941949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTPy8thSqYZgAKDn29KvnLtMmsCZ90i/2T3uJj/CEGM=;
 b=iQf0GyV40LYkREx78g9bCoUUZiCecLFIulcYznbS668cpFFWWzLeX7b6Qmn/hF5Aux
 2bWrxhApiDDI61O1hV0m4jmqZGq9VpkBI99PHkKLLSfXpoYO21rS/E1s0KqVYxQcvVJr
 Y84ZPJ1DcSuHzJt+gA/rKBeqMvCQMOyntbqtjhvoQsg/YwftLjkusZ6lRtpddb00j1kO
 PeZ2otjBaSC9wNnqNidxDkCrDrPTwr1CubNA2h1zQ553mpqQTYMHvVDpBkNJdPoM3hdc
 D0hlsjNmzwCspkzG51I4UH7o/EsWA/lhTLb2mZ9pboeLJ/AJXgwDcuOyNgfb/mPW2FYh
 x+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349949; x=1689941949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTPy8thSqYZgAKDn29KvnLtMmsCZ90i/2T3uJj/CEGM=;
 b=jb7SZdU0CGusQT0gicXquuR86Mt+Jl4cYOlJFCMk4LlVzfdeqpdrkvPcohzrR7ygkn
 GD87RJYS8OEIEswZbXN037LX5AIg04eVcFIxDC+RXp+jL+yOTg5ZXM245GO0xDZnqhYu
 T+tbuPxXXlH9DrLuVN7Qf11Kuqtm0Aeodgvw8htxKWrW9oYCL4xIKTMNdnv3HSFwtmS3
 P/UVFhIqD5dlf/7gDlqvKma4IP5OlFl3pq0BJNq2Kc/snlPzjwKS6dGHpFiwkh7qyTY7
 YkDE7nYUHXXq5q3D7LRLkZvRvWVcRd90jtEZoU0FfKfDpgcuL4FtB5sedXz92vtUlA64
 4Ezw==
X-Gm-Message-State: AC+VfDyUWlzp2WuljJTb53ir/t6/+DjkXa9kKUxmY5t24DoA6QwFq7O4
 N857579YnmH5C6H1unn7ukK7M0Lpf88rs56usf6003nn
X-Google-Smtp-Source: ACHHUZ4Te0D6ty4YzRqM2FHOme6pZ0Na/POIxDpojy8wn9lBaKSH8o1tQ9HGcQh0IgoV2ANoK2RyHg==
X-Received: by 2002:a2e:80c9:0:b0:2b1:e6eb:1ba2 with SMTP id
 r9-20020a2e80c9000000b002b1e6eb1ba2mr10713542ljg.22.1687349949599; 
 Wed, 21 Jun 2023 05:19:09 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/9] exec/memattrs: Remove target_tlb_bit*
Date: Wed, 21 Jun 2023 14:18:58 +0200
Message-Id: <20230621121902.1392277-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These fields are no longer used since 937f224559.
Target specific extensions to the page tables should be done
with TARGET_PAGE_ENTRY_EXTRA.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memattrs.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 9fb98bc1ef..1bd7b6c5ca 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -47,16 +47,6 @@ typedef struct MemTxAttrs {
     unsigned int requester_id:16;
     /* Invert endianness for this page */
     unsigned int byte_swap:1;
-    /*
-     * The following are target-specific page-table bits.  These are not
-     * related to actual memory transactions at all.  However, this structure
-     * is part of the tlb_fill interface, cached in the cputlb structure,
-     * and has unused bits.  These fields will be read by target-specific
-     * helpers using env->iotlb[mmu_idx][tlb_index()].attrs.target_tlb_bitN.
-     */
-    unsigned int target_tlb_bit0 : 1;
-    unsigned int target_tlb_bit1 : 1;
-    unsigned int target_tlb_bit2 : 1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.34.1


