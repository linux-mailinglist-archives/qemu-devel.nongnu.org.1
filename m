Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB5781164
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31h-0008Da-Sr; Fri, 18 Aug 2023 13:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31g-0008DA-5D
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31d-00081J-Uw
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso8537985ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378760; x=1692983560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VhX8uKhISO1+aAbqkSU7fErwJnjxPvu/vXb9fW78xU=;
 b=RpA4C2lqWVg+lVV3ks5rrrQFu3awe1dUw9+puCeDBwn8RB7+TRrNbEfNiDbumDWknT
 T4J5Cd8O+S+gnLNj4SVl99fMNs2bhczfySoM0His4csqMRRYHkjHGgijk+EiOEqyz3jZ
 GaJ0I3knINgbSf0qhLR7OSuSvtPb5ohKmd9HjFIFqDvLvG3br3UHet0+81lCv5xq7Fvn
 YioDeCAE1/QpG3YzEzwC+6xmaidFNhyUq5Ea3geZFlErUU2J6B3C8fHNKTQzJrh/vNSv
 3p7CYx3fJPijM41kbuz+yTX/+M2b4O//GiKEn0NKWyEdHmt1w6s1krShyMNpXdbS9Szp
 mZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378760; x=1692983560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VhX8uKhISO1+aAbqkSU7fErwJnjxPvu/vXb9fW78xU=;
 b=PkRaNo6b3vTRglYwd8PSXqY2Y0MrjfRAFIQakBOzkGaxXNML532Zj1cKEk0ZdvSpuA
 x4PrXvMiSNdRKIUV2bvQV2CpMrgKvvwTFJBq3GGwQivnVS/GQlcgoy9On/WZ1MXUtKBD
 bxTVGxkHkRV2PryqjNzXfGfOO0gFlgEmlElSragu0RwtivoS6ZgaV14G222I618XqhB/
 +Zn/if/4oA+ndU78dPdfxDMv3SoDZ6VaiwdVx93aWhvMrb+6NKeZppfUkSKevKYpu8Uv
 10X5+d0yveFCjKFaOy50EMPurxxmSzizKIwvWyfW9dIazvp+RS/lnA9zRGqIvO9XewKI
 0KYw==
X-Gm-Message-State: AOJu0Yxw2A6/dxKDXUc0gq1481LDd+SQ/XZbmgs5pxxeTFhHGhFvgo/E
 ggdgGlYRvpBYYtGCuathPkMV2z44+zbnOIDLF1M=
X-Google-Smtp-Source: AGHT+IEjsiEiPzxJjtcP9nB8cMNnE8Bi/ah+BudQ5VXGvpr6vy/Czb0kth1Awyf7qqPqlL1oKy7h8w==
X-Received: by 2002:a17:902:8c98:b0:1b8:aef2:773e with SMTP id
 t24-20020a1709028c9800b001b8aef2773emr2848273plo.46.1692378760684; 
 Fri, 18 Aug 2023 10:12:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/33] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Date: Fri, 18 Aug 2023 10:12:03 -0700
Message-Id: <20230818171227.141728-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

We already have qemu_real_host_page_size() in a local variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fc23192a32..48a6ef0af9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -541,7 +541,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
              * the hosts real pagesize. Additional anonymous maps
              * will be created beyond EOF.
              */
-            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+            len = ROUND_UP(sb.st_size - offset, host_page_size);
         }
     }
 
-- 
2.34.1


