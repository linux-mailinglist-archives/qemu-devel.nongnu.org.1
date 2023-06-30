Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD8743CC6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4u-0007nb-WF; Fri, 30 Jun 2023 09:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4t-0007mw-7m
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4r-0003Tg-LS
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc0981756so15777065e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131340; x=1690723340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4tz1Qg7924YrzRDQ0nhW1mfYwrF0UAZkf+8N9yiaRs=;
 b=aPWJJYTDVb+bOYKUampNV2/ZoJuhbiy0/+zrnbUuZVeVLBBWiI08WYiIu/vXpFXxV9
 TLe8S/z0bXnZMA3vcRfu9vblijiTkezFSYQPfkpJlL1duThX15SzXGygnF4YXB2ZZVXO
 kTRfX2cQo9NhqCnrYqCRDCMtnF+V+4epJhgfwZTX++uFcqXVz6XRse5zF9Te67iY9YTR
 rug90C9Oh2O1/S7GI7ADv7+AMLRXtNZUJAxWsBgfJm8hIKjwyDPz6QDQexFlSRjRbBZY
 nOQX3d4ks7fJtJUAtxBMVIRO07FbScfwhp2ZL6rkRal++NOwFDMCF632F1A06xNSZz8Q
 +RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131340; x=1690723340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4tz1Qg7924YrzRDQ0nhW1mfYwrF0UAZkf+8N9yiaRs=;
 b=JhvYzbVD+JnFKwWspmHwfrMMrqnOJvcS5MdOjHrmSohUWIziF3KvZCteKRTq+2WWl/
 +tpDLUG2exoEOPY0PvKIQhNbKGZ7zaTKWYw0BIlq8ccIKGcMRs7aBqF2i69NOvyp8Boj
 0xnzKqvcCZX3GxanlpmCznf9mS6z4+HyeUxTHtMqN3SnlUI7LP8TMpRQxOcxFywQskvf
 NJBauK0VPFq2r1NCigNIQhj1CT5oub5WTu7c/rhSlnv5DLHgUp/719LshJr2L9vKxdlM
 sWYAGrFhUvX8I5cDKaH2u6aYi4R/dlbjMC6/DQILfjV0GGueRnK1rEKOCwt8Qc6uFquw
 4fzA==
X-Gm-Message-State: ABy/qLaTvTk0K7f5Q1WCgekKhvc/xZweaZ3qsSClSbkeRotBe8sGV9qg
 utEuSZNufJZLg6cioatPUY70uOQbWB8XaP8CydBN3w==
X-Google-Smtp-Source: APBJJlGdgin/EOO9orcN1AVCGi8n2MWJJjeH10nj70/9S1C4ywS0BGdzekVqzPBj+PZaYC9em7Wxcg==
X-Received: by 2002:adf:f14a:0:b0:314:96f:bb81 with SMTP id
 y10-20020adff14a000000b00314096fbb81mr2040446wro.22.1688131339825; 
 Fri, 30 Jun 2023 06:22:19 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 24/24] linux-user: Simplify target_madvise
Date: Fri, 30 Jun 2023 15:21:59 +0200
Message-Id: <20230630132159.376995-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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


