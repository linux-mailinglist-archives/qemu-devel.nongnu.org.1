Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE282163B
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3i-0003f2-N8; Mon, 01 Jan 2024 20:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3V-0003ZL-4m
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:57 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3T-00073z-Jl
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:56 -0500
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7baa8097064so369441439f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160734; x=1704765534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ON4YI1y2oDMx99Q4aY169Mgist3E8ZTpYrSmG7+E5s0=;
 b=Tb4xDMgsQUE+5uE/iEygMpjqTaA1PBZBNfE73lM0RsI2oJjm1uO4S2vnAuyAwjkFFS
 H5DLnNpeWD8n7Ln43ABMuAeBgv4M9T0jH1MJL4NyZrdKU30la3CHHC6fExh4GkubCR9T
 a3zTtY65pNhsnZt2DKotiHv/qIGQ1qx3izQu7UzQ0rPCho8QjSsnNNFS90nNr2FHZkTT
 PIij2kTppHK6s1OJnz2ShhOPaSzwVYApuJWMRwks9+Zt/vad+jBq+Ify6+q3vWqdjBHf
 m41L4mTlfrc+J5Dg350JfuoaAGQb/QsiBp6NjLDhHRGJwbKRd2WwXGiEvVAnNAWHhWId
 cKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160734; x=1704765534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ON4YI1y2oDMx99Q4aY169Mgist3E8ZTpYrSmG7+E5s0=;
 b=WvCKrCQEKxwBFKzahdEKHqZS+0JVOXnkAUAFLpaFJlGEovurhd5MAl891LxBhzEi5p
 cGLDT0fS0wph1cu+TKqYHoLp9V2CwKTt5DaQnuECCt/xJ9bmU4Ot09GS3zvStKFN1k/p
 jmBIQV/1lhtrKFuwuccygxgDehshFqVbCR89EkX0PTofsHbnOhzjs93z8+DP9c2dLN6W
 YCzMQTPNAw6qsyl5rICHyvtQV0l6lrAUm5pe8qT5kYB+eE8llZKpjZGY2u9Prxfm7Bqe
 ByixvmZzOayrdpiDSUm0DXVtpylRuVDgUduvBhC57vnIzJRlDFNHZTVDFgR/yM9Cnwam
 HXyA==
X-Gm-Message-State: AOJu0YyoJg9p0G+4BrTN30DG1hFEiJBDrPDzY1vju4uoOSRN0Yy6fmIR
 0jMISMASMRYIpQnVMR4rCeM7+TOymlfSUXrBzde/LuZGDjg=
X-Google-Smtp-Source: AGHT+IG3sens6DQ6corqPLeMTLMbBHMKNCCpEDzSGH+CUPGDNTlc1ALD9WvMeSVc22K6tfYTTdG8bA==
X-Received: by 2002:a05:6e02:17c6:b0:360:16c7:2d6a with SMTP id
 z6-20020a056e0217c600b0036016c72d6amr12526230ilu.48.1704160734489; 
 Mon, 01 Jan 2024 17:58:54 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/33] linux-user: Do early mmap placement only for
 reserved_va
Date: Tue,  2 Jan 2024 12:57:55 +1100
Message-Id: <20240102015808.132373-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd34.google.com
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

For reserved_va, place all non-fixed maps then proceed
as for MAP_FIXED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc983bedbd..42eb3eb2b4 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -540,17 +540,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     host_offset = offset & -host_page_size;
 
     /*
-     * If the user is asking for the kernel to find a location, do that
-     * before we truncate the length for mapping files below.
+     * For reserved_va, we are in full control of the allocation.
+     * Find a suitible hole and convert to MAP_FIXED.
      */
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
+        start = mmap_find_vma(real_start, host_len,
+                              MAX(host_page_size, TARGET_PAGE_SIZE));
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             return -1;
         }
+        start += offset - host_offset;
+        flags |= MAP_FIXED;
     }
 
     /*
-- 
2.34.1


