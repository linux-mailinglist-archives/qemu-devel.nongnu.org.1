Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF974B841
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGb-0004zr-IM; Fri, 07 Jul 2023 16:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGT-0004su-J9
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGR-0004v4-RS
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso25266485e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762473; x=1691354473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4tz1Qg7924YrzRDQ0nhW1mfYwrF0UAZkf+8N9yiaRs=;
 b=c7v1EOzd7+Jktv2/UHfyzhvSITchi4KvSbUT/d/T4CaKwpKlzEtLFTRsSyjqsEi/p/
 kBqjCas0O9w07N8813Z306F+FDLHjTnLw0bmGiJZz8cfCepRSUQXbCjpxAQCbYcM0NL3
 noBSBIhz3JjBSTkLHZOjHW2BGkKJGpicN1VLBeA/+sZ4zYRiZJULGhUcEBGuB6uVoZfX
 kEw2cR/dvaK/fIoS4z6ZdP68dCTMnOHHI5DHHKfsgZUz+I2b6kIKYeta9xssHm+mMHi7
 H6Rk2kWdN6kLh8XVNR5QjuzOQigeMH2yosUR42sngI7JGEBxAmpIHmZ+RvAFVxTe5ULv
 1Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762473; x=1691354473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4tz1Qg7924YrzRDQ0nhW1mfYwrF0UAZkf+8N9yiaRs=;
 b=ZxtObTJysdxQtT9Mq6Pnw1VIxNRLFfKBK6GNLDsVeR9atiaM1Q++AIwZgi4Z8OtJda
 TGk4xmz+Y/TtkeB291d0ZA0Pk6UWys4Akz8hfvI8d44UNZ9IEBOexeTa5+3/+LJ6WaOL
 WiZrd5Q4W+mZ6x6bpwgY8VFacTXywSzhRVM3VrkcInZJ2FYIHUoK2ykc1J0uZ0B9+PCV
 4Y4vOFaz8tAQ5cv6lhSE1H/9RJSnU4x6gf+C5mTx2pkNmjLHKHFWJnJPBIeHlnij072H
 ewwId5y5NeWxSOwaVqRBwbPaGLsRur2tiARIkPfJOu/1ZTQtp36gKyTgsiCZ+0Vw+jVb
 f7Qg==
X-Gm-Message-State: ABy/qLbzc7ib4jqoTVxBRgOdrtFl65nCr5oAy5YqyK6XCkrHsgGivsql
 m9nr4DxEEQM/QCMiJCXdB6wi8iC+tt3rsc33zs69sg==
X-Google-Smtp-Source: APBJJlEScjw+RI/d7eMEA3HhPILvqK5PJOPMcB5GMZKx5fFUnbyL0rnxnFvSCwI2y5enqfgV4k4YPA==
X-Received: by 2002:a7b:c4c6:0:b0:3f8:b6c:84aa with SMTP id
 g6-20020a7bc4c6000000b003f80b6c84aamr4477900wmk.24.1688762472947; 
 Fri, 07 Jul 2023 13:41:12 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 24/24] linux-user: Simplify target_madvise
Date: Fri,  7 Jul 2023 21:40:54 +0100
Message-Id: <20230707204054.8792-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
---
 linux-user/mmap.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a2bef1ebe6..48b83ca8bf 100644
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


