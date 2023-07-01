Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AF744775
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVs-0007Uf-6l; Sat, 01 Jul 2023 02:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVq-0007U0-Fz
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVo-0007Er-EY
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc77e769cso16615065e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194515; x=1690786515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fh8ll0z1/lWAw6IZ8VRZwP3jq46crriqiBekj/aaK3E=;
 b=mj4XliJDtCbPwsixJcrD1aSt+HPFMNM0RFuIozXeQY4jMjZvypXS7Pm6yP2CSTRNlA
 xC1ZgJjbpaRnrhV5AShZVKwx5V2aF3CNsjAXr+S9izLjDq0nSv0K3B0RbkJISA82qx75
 o9tPqpAsAaVID/MDw8u+Q75u6Zo433saZxDlU4wBHbKpmbEx5hFve2rAuhXNfwfvXuGQ
 xW24JxXDBT+soQY0cDVmWkMwhad9obEL6WnM6b9d7/vaIdpSg9j6IBtd1xTkevdLpfRs
 IcbRXHQpn2cKGEshgYrZ7iu3PU4oK4gaqD7cD/S0arRKVHIh79scW0i0QUe0/PeDX1Zy
 TXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194515; x=1690786515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fh8ll0z1/lWAw6IZ8VRZwP3jq46crriqiBekj/aaK3E=;
 b=hDbmPS0GEjGF641LXeWDnbmajxK7fQ0Gjg7WuKsAx4Y5KLjuYLwLboxtrmcWUS+mBm
 8VrrsrV21sL2k9Sd6hx8vHquNfSLmTD5GvGxxmYvl2FXTrHWN28TSEBK2AJ0Sw2XGm4j
 kJ71KmRP29fbIw17iQywTOCLmanD/5rwOSLKOSITR0y6bJa3KcTzQt6YRxrycasiVMaQ
 B7Uerbq2W+GDlIktqsdA6PkmCtAI4EOLp1en0aH+/jSjFG04HXiGTzaw7A6oEPCNMUhZ
 38q0+MjVUAWxe9aIatrtDyemftYaYKpfGcGiyjHVPqOsqNb7C4GzdsRPk0/S60HNCsvd
 iAzQ==
X-Gm-Message-State: AC+VfDybDUBYrH2AgljoYhUwEf5HBeavAlyuHvccfr7UlXmJ7G/fvYWR
 5s69l8EUG0vHkLG5XRbNx5mtcc5tx3b//Bcw1n4dOA==
X-Google-Smtp-Source: ACHHUZ7CkO76rEwP90+j1bWONfgKWRAr10ttJQPBZCiXeyTbRze3TdgAAmZnhyoh2OLuy1HNbc1hrA==
X-Received: by 2002:a1c:f702:0:b0:3fa:8866:14af with SMTP id
 v2-20020a1cf702000000b003fa886614afmr3822303wmh.14.1688194514617; 
 Fri, 30 Jun 2023 23:55:14 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 03/11] accel/tcg: Fix start page passed to
 tb_invalidate_phys_page_range__locked
Date: Sat,  1 Jul 2023 08:55:02 +0200
Message-Id: <20230701065510.514743-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Due to a copy-paste error in tb_invalidate_phys_range, the wrong
start address was passed to tb_invalidate_phys_page_range__locked.
Correct is to use the start of each page in turn.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: e506ad6a05 ("accel/tcg: Pass last not end to tb_invalidate_phys_range")
Message-Id: <20230629082522.606219-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3541419845..33ea1aadd1 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1182,15 +1182,17 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
     index_last = last >> TARGET_PAGE_BITS;
     for (index = start >> TARGET_PAGE_BITS; index <= index_last; index++) {
         PageDesc *pd = page_find(index);
-        tb_page_addr_t bound;
+        tb_page_addr_t page_start, page_last;
 
         if (pd == NULL) {
             continue;
         }
         assert_page_locked(pd);
-        bound = (index << TARGET_PAGE_BITS) | ~TARGET_PAGE_MASK;
-        bound = MIN(bound, last);
-        tb_invalidate_phys_page_range__locked(pages, pd, start, bound, 0);
+        page_start = index << TARGET_PAGE_BITS;
+        page_last = page_start | ~TARGET_PAGE_MASK;
+        page_last = MIN(page_last, last);
+        tb_invalidate_phys_page_range__locked(pages, pd,
+                                              page_start, page_last, 0);
     }
     page_collection_unlock(pages);
 }
-- 
2.34.1


