Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648DC736AB6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZEQ-00072h-HW; Tue, 20 Jun 2023 07:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZE6-0006fJ-7s
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:46 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZE3-0004Qy-9b
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:45 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-987a977f62aso369013066b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259312; x=1689851312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+os3nHQ/ZmARewYX8s5fRYkcgS0NtfZNFjYHPGkpaM4=;
 b=zfwlUnoT+9JYRJvMcXFhJoA7pLYnBP6H3iplCQEVsslkAUnW+LsRlFYN/x7yYDqRuc
 ruU/2SksY61jTarLwbbvFWlAkPuSSpBjsqq4937hH07bWqpahgahlUUFWAaatvk2KTBt
 EkSkShmKZqHVsn5j55bv0hG5UOirLvq1cwzIuN4enGmx7mCE1fwTXgmQ3kGCEfYlai9z
 vll1pdSqOZC55Y0rxJh5UJCt9PIP7Se6qWA9Pp4ztzSRn0eThRL4YZ0aYvLjbVgLR+pe
 9vtRkAQvrukhnUcAP7gkdju53yqLevZmMbbAloDcm2cIUI9ICTR+kH+CWtLHdur39Uz8
 dZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259312; x=1689851312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+os3nHQ/ZmARewYX8s5fRYkcgS0NtfZNFjYHPGkpaM4=;
 b=hkF7+0cmYYxGbn08GDF5ulYBmgdmRycKItGhoCnqKshoscE0mey+bkaM6OHrIZ1pBG
 MdASZOHdp8kiAPF+RukwJhRDTipNMbfaoEmykksN87T5bYiKXEsJJYnuaPlcgwRDS5yh
 5VeY+ijDFGp3phR0hnTSojy3gueXAtAXG6+2KsRR3f36eHfbJDljKqNxrlblTcuiTugg
 88dswH1KrCxlgo5XKN3QpGwWBnstSKgiMbU/1fN9xoi14BbnHALgBH5LiRwma+Fr3vQH
 0e+xGc7fy+w3EpQFy2Icbjvpvk0Ro9KDM4qw2wpRSzVJijsTUiw6LspH977P+Rd7wm52
 OEWA==
X-Gm-Message-State: AC+VfDxszlOzbanM0F2yRypyo9Q/e+Uje2hxhMGieiV39qbq3coi1wyk
 uI5LIk1TW0qj7gYjA6IP5Z/ForUiWSQ9TBvXu+D1qM7Z
X-Google-Smtp-Source: ACHHUZ4sALdWkSlM03Xa03zvulAe+q2XIwYIwtn9N1x4ChMqOXm4qh7qQZcZ3oRx/myHi9Jjj3ONVQ==
X-Received: by 2002:a17:907:7b96:b0:982:3e2a:91a8 with SMTP id
 ne22-20020a1709077b9600b009823e2a91a8mr11045159ejc.72.1687259311971; 
 Tue, 20 Jun 2023 04:08:31 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 23/37] target/i386: Use aesenc_SB_SR_MC_AK
Date: Tue, 20 Jun 2023 13:07:44 +0200
Message-Id: <20230620110758.787479-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

This implements the AESENC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 893913ebf8..93a4e0cf16 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2188,16 +2188,12 @@ void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0 ; i < 2 << SHIFT ; i++) {
-        int j = i & 3;
-        d->L(i) = rk.L(i) ^ bswap32(AES_Te0[st.B(AES_shifts[4 * j + 0])] ^
-                                    AES_Te1[st.B(AES_shifts[4 * j + 1])] ^
-                                    AES_Te2[st.B(AES_shifts[4 * j + 2])] ^
-                                    AES_Te3[st.B(AES_shifts[4 * j + 3])]);
+        aesenc_SB_SR_MC_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


