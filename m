Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9005821642
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU2y-0003Eu-Q7; Mon, 01 Jan 2024 20:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2w-0003EG-P3
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:22 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU2v-0006yh-9w
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:22 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bb53e20a43so7596303b6e.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160700; x=1704765500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3V4UcCieB3zB1M+n0kFdLlq+X9hWVNWezL6ktHMn9HU=;
 b=QOJ1/peMffkk8WtK+wkUiIdjqz7Ix6/gRwd2bpcT/+pTwGm4tuGhQXlni/F1ZmKxn/
 VmoqK4TMEt2hCQYfGVFlWNuginiWMM1FWd4AtYpC8RSSBx/rhcHreS3+weO3DepDTQ26
 nAJu53DLDbwhh2mzQcGQV90sU+ZDSBbjkf5kOKCTTD41ibaS10sgPsIPzr1edv8DB2Fp
 ppQR5w/uG15CiZWxf8+DxO0nw01Enec+x9mjU5A3wR1Cgp5V2+JQmJh464aKkVtquuEg
 JKxabwoa3dc3gwZv6S2ob3CShOCV9xteUIW3jXXZcX2jdB/tyS/J8GcAZmEHhU3muVQM
 DO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160700; x=1704765500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V4UcCieB3zB1M+n0kFdLlq+X9hWVNWezL6ktHMn9HU=;
 b=BSw7t6Kjt3XOMjrF54aDNzqxlGR0gK9Z6mU3MkubQbmCA+AGE6LFWXp9mn4jhHy/m6
 coQcPLYQ4tilw58sbeSZiTup6GKiE/5uHKJH0C28tuxbTXYb1CNEx2pJJlaSyJr1cAm0
 GeZi1FNUy429dZz31WGZdO7pCqz/v8RBCR62CDtz6WH0nTNrEgO5YX49ef5kO4vdUTlD
 x4vxOBr+AFh+Aw2z1TMMA4/oiiPPubxTNfbzV9pa3L0xIPmRU9MQ7qQMCXmxq8jj0Qyz
 2RDKn7qCVekS6nOXx5rtA78owJp3p++sr0QeL+RhXxCC6VbNHcTIVRbZWfGRTPA1CzYt
 o5RQ==
X-Gm-Message-State: AOJu0Yyper52RGbxBWo/Palq1AMlOhOYxDowx/2E92p69O5WAtVncBWU
 3v2Hwz2AasTQ2oB9/BwW21IUTfNRU8aG4xuy0M3NAPlzmd0=
X-Google-Smtp-Source: AGHT+IFRsv4pnJdcddbZEr/jtt+xsU3/JmVHdMKIKHgjzFQWkCp39oB54cLNwR82i/DvGzHG0FT6Wg==
X-Received: by 2002:a05:6808:171b:b0:3bb:e8c2:e29a with SMTP id
 bc27-20020a056808171b00b003bbe8c2e29amr6900189oib.101.1704160700071; 
 Mon, 01 Jan 2024 17:58:20 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/33] linux-user: Remove qemu_host_page_{size,
 mask} in probe_guest_base
Date: Tue,  2 Jan 2024 12:57:38 +1100
Message-Id: <20240102015808.132373-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

The host SHMLBA is by definition a multiple of the host page size.
Thus the remaining component of qemu_host_page_size is the
target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3c1e0fb64..4df565d64b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2892,7 +2892,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][0] = HI_COMMPAGE & -qemu_real_host_page_size();
         ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
@@ -3074,7 +3074,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                       abi_ulong guest_hiaddr)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
     if (reserved_va) {
-- 
2.34.1


