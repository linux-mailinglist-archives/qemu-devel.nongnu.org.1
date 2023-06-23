Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289DF73BA8C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 16:46:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCi1t-0000Db-0B; Fri, 23 Jun 2023 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCi1b-0000Ak-Uu
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:44:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCi1M-00049O-Cp
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 10:44:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so977786f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687531452; x=1690123452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vEoZ1jB1oL976vNVyEoQyhbzqpIzJpu70/dSSiTM/2s=;
 b=nOyuHlK4A1QuWiv+3u12xPWRpsX97F/A3bTLIQncvYIyf5U4oD60dN9cGNiF/x/pHl
 m9QwCtkVFvOXmgNfTRXGxhIG+lWeiah/0D1XduReV8yg4IIIpeR6jyVua+/XysBDA/kR
 AIlOU2PzdohboNpIfnmZOFCaZjs8fRJDFpkg9ofxsK638voLNTzYgf9XMrg5XTbS9sRY
 HHlMSFC8VZ/P/5L7Lq0ld3o/bWoDgY1N+H3mHNPkSK9WX8ekeM+YW3v7hvf3/v1kSCBu
 5/ZYh1BMAqC49Jvfn1KWjXjemGlIpOpUTkpWrAI/j8ycrSw1C6Pd8a0iqVYq2dTrg/KB
 SFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687531452; x=1690123452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEoZ1jB1oL976vNVyEoQyhbzqpIzJpu70/dSSiTM/2s=;
 b=g6siwGnL0Vloattdc0t61lEzEcDR9UxFv8AG7dHvK3oBclyqy7QedENzqCbVH3J4tc
 QIe+/kDTROKoqJ0iUxiPCuKr1MWCPaFjIa2Q3tu57tztI0eAg45f1Vp5BIQxuCj3K1uK
 e3adcVS69mCRE4TZsJut5dZcxMm/YzMDy2HVgosZPdudCgtRoHpeelHBSjvCK9xXYrwO
 RUQfEXzQl/mTl7R3IWNjIYWH/E6onPLgRlaX5+pPkuTYIvkfCBDWCOHC6ZkQhXKhOBF1
 QRjTLDrjoQzBjO+rLgfpnH6hqJ034ikKyIqWo/MMZ9Kgv32KvppKturoWWj8qX7bboND
 XsjA==
X-Gm-Message-State: AC+VfDxcipNrSb/w5Ib4nRcAa/MLHaMlCeUHjyghjWLc5NT9H8+WQ+Ga
 0OpxH8OZpIQsqFCqu6IptJygUKJl6UCPVNTuwAU=
X-Google-Smtp-Source: ACHHUZ5dYqhfWWmk9kQLLGehyMTCkXmg/RD61bjMi0ATv3aCQfvQ+jGqgAJe2PYm46VTPEQNID7bxQ==
X-Received: by 2002:a5d:65c9:0:b0:311:1120:f2a1 with SMTP id
 e9-20020a5d65c9000000b003111120f2a1mr23919110wrw.46.1687531451891; 
 Fri, 23 Jun 2023 07:44:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a1c7409000000b003f8d0308604sm2631707wmc.9.2023.06.23.07.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 07:44:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Remove pointless NULL check in clock_adjtime
 handling
Date: Fri, 23 Jun 2023 15:44:10 +0100
Message-Id: <20230623144410.1837261-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

In the code for TARGET_NR_clock_adjtime, we set the pointer phtx to
the address of the local variable htx.  This means it can never be
NULL, but later in the code we check it for NULL anyway.  Coverity
complains about this (CID 1507683) because the NULL check comes after
a call to clock_adjtime() that assumes it is non-NULL.

Since phtx is always &htx, and is used only in three places, it's not
really necessary.  Remove it, bringing the code structure in to line
with that for TARGET_NR_clock_adjtime64, which already uses a simple
'&htx' when it wants a pointer to 'htx'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f2cb101d83c..7b2f9f7340e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10935,16 +10935,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
-            struct timex htx, *phtx = &htx;
+            struct timex htx;
 
-            if (target_to_host_timex(phtx, arg2) != 0) {
+            if (target_to_host_timex(&htx, arg2) != 0) {
                 return -TARGET_EFAULT;
             }
-            ret = get_errno(clock_adjtime(arg1, phtx));
-            if (!is_error(ret) && phtx) {
-                if (host_to_target_timex(arg2, phtx) != 0) {
-                    return -TARGET_EFAULT;
-                }
+            ret = get_errno(clock_adjtime(arg1, &htx));
+            if (!is_error(ret) && host_to_target_timex(arg2, &htx)) {
+                return -TARGET_EFAULT;
             }
         }
         return ret;
-- 
2.34.1


