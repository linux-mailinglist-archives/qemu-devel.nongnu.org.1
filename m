Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A276F722
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsy-0002jQ-DR; Thu, 03 Aug 2023 21:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsc-0002cp-Ch
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsZ-000596-OF
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:25 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686e0213c0bso1190384b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113522; x=1691718322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=hezjGjvIUwn7VHvPnCOepORUiXejBF9owFMLMPDqZjEmKd+mZlZvDkYFVnBRdqzirF
 C1KRCpqdpxAxQQZ55NFTDMtPAbIShopqEUbcwzqZO8qfR5tHtH3hwvSzZioXG8z2cRBS
 BUjFKelcz05tuJI3VmR5nTOfzrIp1845yJgZKCwo8bZEBz20rHpXPgB4ucVjulqlzZBz
 PpTUOATIcsLpF3LfBpJMKtws8m7UIKeo6hyHGanEzJOglUZqw+DoYgc7gan4PU8jEeMf
 hkAVoFNwWcl3q1OK87RI9DbVP3nrum2RoLmIzkN58Q/aZ6NhC4rIcBqZZAN8UFGWnqFM
 PmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113522; x=1691718322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=c9ItJdfNX+/IdnndqINKN9Kn5Bug34xGq9x5wf2e6dqlRbjfnX8cBnu3QYCsaxWTO8
 mCv+ECDiaBwhDveFBa2GLMbU0fgTeZTpsfC+NSg2+8E3QYhwsRg/PCfEtENupY3XDXhn
 cc50n0nWn2tT+29xpsktRfhQcBydfFCPrg3YVWv15DkdGQGBhzsgGhurwKNOrLMBXT2G
 cYMQt7gtdXo+N+rqikUqxd9IycRjjS18Y3eAQXI71/saFCc2me1ek6tLBZXZ1c6d0gTL
 UTKdCy3MPdDujTSQ0NWbj148NFW2kdw3Z8i1BGQOx9pCYL0Sx+FX/OirT+YAoDtWQjKb
 +zbA==
X-Gm-Message-State: AOJu0YwMXqKPy8NFfwPWep+yL2AtfUR3T9wkuv2kRnPrr3m/Br1t1KRj
 UgRg1TvEyqY4lAqU1dLzs0CFTMjzhGL28bcYXzo=
X-Google-Smtp-Source: AGHT+IGJbcriEjoL1bR2skOli8n4Mxt9Zjq+hxP0uMDDMKeW0qG1Zu7bBX+jS5pAqVz6JeVxh5usGQ==
X-Received: by 2002:a05:6a00:2301:b0:686:efda:76a2 with SMTP id
 h1-20020a056a00230100b00686efda76a2mr356858pfh.29.1691113522489; 
 Thu, 03 Aug 2023 18:45:22 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 05/17] linux-user: Do nothing if too small brk is specified
Date: Thu,  3 Aug 2023 18:45:05 -0700
Message-Id: <20230804014517.6361-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Linux 6.4.7 does nothing when a value smaller than the initial brk is
specified.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-6-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f64024273f..e1436a3962 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)
 
     /* brk pointers are always untagged */
 
-    /* return old brk value if brk_val unchanged or zero */
-    if (!brk_val || brk_val == target_brk) {
+    /* return old brk value if brk_val unchanged */
+    if (brk_val == target_brk) {
         return target_brk;
     }
 
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
-        brk_val = initial_target_brk;
+        return target_brk;
     }
 
     new_brk = TARGET_PAGE_ALIGN(brk_val);
-- 
2.34.1


