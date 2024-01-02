Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA864821644
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3D-0003Ik-Nw; Mon, 01 Jan 2024 20:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3B-0003I2-Rp
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:37 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3A-00070m-9v
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:37 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso7046983a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160714; x=1704765514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m5E6L9ef0SVPlAxhBuGX4coZacolJ6Ms5EPcHyzN0k4=;
 b=v8RG6yId8v8SBxspgXrUD3q43RL/Ekkcs9gQdYpa0lXhej13t+tZ6rU/mRgh9AURgn
 CvEBEfSpsJGlJvVoiFDfc45rLKJHRovxguVDLJxk8+2Kz2zKIZhGlH2/Bix+ZIF/DVTl
 YaN4lU5HEp5XpAZysJqYab65BmeWMq3Ctmbjia6cep0Tqndbvg0hvkmsrbLJ+Ww5E1Ln
 nPphpBPrggTUezLPwdbrnLtZFZPWeSf+SRrz68QFrFAV95DgVh7EuX69YNE6W91bhJqG
 znw9iiPovJRR7AofpO9s6ESZO2tCETvO0EgEbJfObz6s2AYbA9dFgBkv+RWwguI4pt+U
 0LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160714; x=1704765514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5E6L9ef0SVPlAxhBuGX4coZacolJ6Ms5EPcHyzN0k4=;
 b=YjwRkTMhcYpMZZj476D+KUV2O6OZ8nRyW7HGa19FrQWilaAslgSGr+PtwReJL6vtrQ
 5qmkVY1GZtOTORnQ1SXtVeGdBbev5w6g7aPYZQEisDf/bdh0ObcKg9dfjRMjKpkqcCrM
 6IYSWn5KLCjDnfMnQTdudE3C3J1XkSfCIxFEI1AEFgBaIiPVtDQh770u/IFTx8wCHV18
 HtyLTEp5Gy6MFJdWTfmbIs0uzPLxUx1B6mqPpv/wOtqUD5JhOH3MACiFD7qb4VrcJDMl
 t72ntleJosBjqtePkayJ4ElZpSRndEc93dcMvG1r7qIiIQ97mkvotj0jrJbcg8n8gecS
 c0Sg==
X-Gm-Message-State: AOJu0YwQZTocKHmpfvk33Zr34gx+dIHmu0WN1T6weDHl7YMho1hnWW2v
 +NqN2lUQn0+HZQeJrYWbHmgM0q69Kfn+AhZ8yh1w9ajKrlM=
X-Google-Smtp-Source: AGHT+IFmvA8OXDGhE0dFIy//tPSPj21k84hy0717YKqkNzuuG91np4dAZlCYCAsS541px+D402uFyg==
X-Received: by 2002:a05:6a20:9149:b0:197:d2d:1c0f with SMTP id
 x9-20020a056a20914900b001970d2d1c0fmr3019289pzc.87.1704160714045; 
 Mon, 01 Jan 2024 17:58:34 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/33] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Date: Tue,  2 Jan 2024 12:57:45 +1100
Message-Id: <20240102015808.132373-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

This removes a hidden use of qemu_host_page_size, using instead
the existing host_page_size local within each function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 53e5486cc8..d11f758d07 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -191,7 +191,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 
     last = start + len - 1;
     host_start = start & -host_page_size;
-    host_last = HOST_PAGE_ALIGN(last) - 1;
+    host_last = ROUND_UP(last, host_page_size) - 1;
     nranges = 0;
 
     mmap_lock();
@@ -389,8 +389,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
         start &= -host_page_size;
     }
     start = ROUND_UP(start, align);
-
-    size = HOST_PAGE_ALIGN(size);
+    size = ROUND_UP(size, host_page_size);
 
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size, align);
@@ -550,7 +549,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      */
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = HOST_PAGE_ALIGN(host_len);
+        host_len = ROUND_UP(host_len, host_page_size);
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
@@ -595,7 +594,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         void *p;
 
         host_len = len + offset - host_offset;
-        host_len = HOST_PAGE_ALIGN(host_len);
+        host_len = ROUND_UP(host_len, host_page_size);
         host_prot = target_to_host_prot(target_prot);
 
         /* Note: we prefer to control the mapping address. */
@@ -625,7 +624,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
         last = start + len - 1;
-        real_last = HOST_PAGE_ALIGN(last) - 1;
+        real_last = ROUND_UP(last, host_page_size) - 1;
 
         /*
          * Test if requested memory area fits target address space
@@ -794,7 +793,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 
     last = start + len - 1;
     real_start = start & -host_page_size;
-    real_last = HOST_PAGE_ALIGN(last) - 1;
+    real_last = ROUND_UP(last, host_page_size) - 1;
 
     /*
      * If guest pages remain on the first or last host pages,
-- 
2.34.1


