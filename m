Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 655CF74C737
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZHJ-0003tU-UK; Sun, 09 Jul 2023 14:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZH7-0003pg-Iw
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:36:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZH4-00051j-BJ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:36:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so37270055e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927805; x=1691519805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXDNUHkoHKMJOTYkZxcm9eNGIwvNIgvNekBczYJkm1c=;
 b=POT/JoZrzkE6XvE3VWyv+BKAhZKWkHqbLjOAKAE/ZZ+pmGDcLSUgUevY47h8+fWOCT
 4YWh71Gps1pvOn8bEnzbGXPif1FtW79MkyyAq0wIzCUD+gFSwNgsHIZZKHTOngK7mA4g
 5xPjlJHOE2T5KVLyyb98R11yOnOTs7Yvbp0piYORFE1sw3qUvljXWl3l3IAstCGchzhI
 tNMwU5TEUkH/cSA7w71MJgg6eaWaApan25AAh6Z4F7UCLsNhBtE7LQJjCmtVm45Jvg4C
 qBR4b/vG+dHg7tTph6cV+zKJU935jJNz9MQ6RgsP/MnPSNfCyDDbNKCdfWAaZxkPbep+
 PUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927805; x=1691519805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXDNUHkoHKMJOTYkZxcm9eNGIwvNIgvNekBczYJkm1c=;
 b=G+grdaF63CLkeOKlxzRTlvMcWJruDFyKPkPnAaSMSiFhdKAoKwxvfzpuczJ1b49mGo
 Mrl82LhKlXTpWf7z8PjzNdq/aKYBv6EJST2NH/jT++0hfq9Fg6pzciNgUPM5JSaTY2oL
 6EaHzEsLoytaSPy96hGYE9IxtD6bZTIKmTJof6+qnBrLvKR3pM3RubfWppae9yEhIk2y
 uI5GoBKGLJneHRK6ja5M9GvCcvoghXGKJrmgSD6yrQl6hrbVcThiWnFYKNSuP1JL6r/7
 cDqeqY5V42hSriGIEcVativGV/G+xY8o4QGvoWIE/xKox6W8jbhq/hNrgBNWimxkeiAG
 NiAw==
X-Gm-Message-State: ABy/qLZPFQUlVu9iVayyqC9Z/PP6J1LDrH6RD8/fSH8wnLW9TI6EhoV4
 TxHCG++PUdflCBiE4UGEefLBEezG7xa3/ING+Xhm6Q==
X-Google-Smtp-Source: APBJJlHO1by/DZRK25J0uqaET1lpMdefjunmbNhQZvN/If/4mrjXHeIyOkmz3hC9K6bn/aiMJ2hBdQ==
X-Received: by 2002:a05:600c:286:b0:3fc:4e0:be97 with SMTP id
 6-20020a05600c028600b003fc04e0be97mr2790670wmk.6.1688927804950; 
 Sun, 09 Jul 2023 11:36:44 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 i6-20020a5d6306000000b00313de682eb3sm9735832wru.65.2023.07.09.11.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:36:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 43/45] linux-user: Simplify target_madvise
Date: Sun,  9 Jul 2023 19:29:32 +0100
Message-Id: <20230709182934.309468-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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


