Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC27EA1F1
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:35:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ao6-0001Z1-J0; Mon, 13 Nov 2023 12:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anx-0001Uk-Om
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:59 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ank-0000vD-6l
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ce3084c2d1so4944425ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896763; x=1700501563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7D/Is0q9/XY5O6mimvb47xPlpmUh6SE4PEHCKmELxsQ=;
 b=VgeO/N55tsfH8DFvgnrGeOxd4tzYnPbIN3PGgHJAeVvhsVEkb3cWnuTLxTTEf+HHoi
 mtZIhU5efwC4u999QComw/YozG5lcrzr0W7d58wiLBy8tLE9AOhEf9s1vM9442AF8O3I
 VcE4INkUNizTx+eRDxw8JCki9EyZT2b5mGoe1X0fUT/1yb2L73mPgkxpDJsl5svwcTto
 LQHGvTUE0BX7WzxpMKlzKK1MSiu4ruFcCGpO0xhrcAGnFPKHzYnBIBd8d2QuZFIonusF
 GVj01aKTQe7xzAQmyBXaI8opm3CFB8PnKP7X1t24qdhcLi9Z0fpZD1mrpkN/blFqbzXt
 gwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896763; x=1700501563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7D/Is0q9/XY5O6mimvb47xPlpmUh6SE4PEHCKmELxsQ=;
 b=c2Zc7wjA891pom+1la/hnfqfbcbKmCzO3hxFqEmf3Z522bUjMJi5+cx26KwQUoo5wv
 ldJezHEacfroMfWUrOXC0IoDEdZrH4Hwz7YPJI7pJDuw6VN/ayf84aOwvo6FCPkAjaXt
 MrBg0qAxK7ZAMcCDm5Z0wbQWo3j8AjDCOqAG9dBVOWqjcMNvhBMbvsSYM3V0A3MFbgrr
 baKv5vC4OnfU1M7vP9cxCucP6wA4iUzgHK4zPhKDKvPE1AjEd97bJNx2556BbL/uB6xO
 j3D/ho5JjFvfXU7MMbJA8C1rYFjgnU0RrB0poUbC6UObX2rhA7/M+dlKEyalVZ2V52+f
 Wc/A==
X-Gm-Message-State: AOJu0YznwmSjCrjVOA0O+kJgnBoWvQHafIGZkI/r0sezFxCnDrnFFHYQ
 s4az4iW45XcBdrbj0Tus8P7wvACCYTym+sy86Kw=
X-Google-Smtp-Source: AGHT+IH6e0O1W7GK9cIo9lcBGXVl3Erkb26fGddK+PjzwJVonHjjTtGcgMCkcdaRGybPs/XTyD6tyw==
X-Received: by 2002:a17:903:244a:b0:1b9:de75:d5bb with SMTP id
 l10-20020a170903244a00b001b9de75d5bbmr310494pls.7.1699896762924; 
 Mon, 13 Nov 2023 09:32:42 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/12] target/hppa: Fix possible overflow in TLB size
 calculation
Date: Mon, 13 Nov 2023 09:32:30 -0800
Message-Id: <20231113173237.48233-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Coverty found that the shift of TARGET_PAGE_SIZE (32-bit type) might
overflow.  Fix it by casting TARGET_PAGE_SIZE to a 64-bit type before
doing the shift (CID 1523902 and CID 1523908).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <ZU6F/H8CZr3q4pP/@p100>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 858ce6ec7f..a13f200359 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -450,7 +450,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     int mask_shift;
 
     mask_shift = 2 * (r1 & 0xf);
-    va_size = TARGET_PAGE_SIZE << mask_shift;
+    va_size = (uint64_t)TARGET_PAGE_SIZE << mask_shift;
     va_b &= -va_size;
     va_e = va_b + va_size - 1;
 
@@ -505,7 +505,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
      */
     end = start & 0xf;
     start &= TARGET_PAGE_MASK;
-    end = TARGET_PAGE_SIZE << (2 * end);
+    end = (vaddr)TARGET_PAGE_SIZE << (2 * end);
     end = start + end - 1;
 
     hppa_flush_tlb_range(env, start, end);
-- 
2.34.1


