Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D9C821648
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU34-0003GO-35; Mon, 01 Jan 2024 20:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU32-0003Fj-N4
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:28 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU31-0006zz-9g
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:28 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-203fed05a31so7078298fac.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160705; x=1704765505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=doJtWyMStqOAlo7bZL0mf6PIzbVYMD2KRSmUqFYZbbM=;
 b=iliY3WQORQojL66bodB69O5hvrV+cAO2r9GuP4k77jVbyDV+zU+LBkfaFtzHo8Eb6o
 nTJb3t8kx3+UzJmCXDYv9nElccOaaKojTFvfgvgicZGLP5GftFB7SWmspzZZFR3G8sbP
 EzOgYRdBCxRPvTRe63Mh324Me3SDiBSfIwbtNqCFuFtHCfH1Hceh0ISOoPPyon31y0+C
 wI6S5C0oGMNIIiZbV5wjH2s2KrjYzm4sWIlSLNM+ny/9XssmquWp9d0BQJDb0/rEpaKb
 PlZbrsLHYQ1nAr+bD5eFfjcnDlOQcIbjhrQ92EFOg7K8m6wDULdnkkL2yOduZYAWj66U
 W+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160705; x=1704765505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doJtWyMStqOAlo7bZL0mf6PIzbVYMD2KRSmUqFYZbbM=;
 b=N6zzk2d9laBlkO7CnuyV4gDpCmcIDJSTlNBIK0piLyUEez0rOz8RlsIMANXcbx8NHo
 0YYW6Wsh0Jwro5E7rf0M0fCAMEVghsoKplSFsrzR8FX29rSfo38vheYSInI13p0nsNNy
 uk+28eKacVOl703LShIRNACWqNYgGdoNh4gPQSN0h+XrYPj0q5+lJnyN3ZPV3YDp5MJ1
 6kuEThe1IqnnaSPD0O6Yzi30ysM3j0X3fzyWt1CIbgIpnwNDOKb7KEMuIfBSe1RNvxyD
 Be7Xl3sU96IB2YOy0rpOXVdShv5xYVVtf5jhHm8fkV78Wsx0GY0BTExt8lFkldFmbcZN
 DJiA==
X-Gm-Message-State: AOJu0YzTsCwSbHsHBuX9w+Tt9e5mzYktEbYo2L6St6ePdQzcUKpx424T
 CtOSLFdziMwn0gn+rvc6ZRosw1J0pPL25ABcTWiImzgEmA0=
X-Google-Smtp-Source: AGHT+IHCCh9Re7FIx9x17Wv2DnDG6ExxZLinFRQKjPxkht/v3c4eFg1Yr015/3PaAW3FuXFBHe1eZw==
X-Received: by 2002:a05:6870:e38d:b0:204:2bc4:87c9 with SMTP id
 x13-20020a056870e38d00b002042bc487c9mr18563179oad.86.1704160705491; 
 Mon, 01 Jan 2024 17:58:25 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/33] linux-user/nios2: Remove qemu_host_page_size from
 init_guest_commpage
Date: Tue,  2 Jan 2024 12:57:41 +1100
Message-Id: <20240102015808.132373-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Use qemu_real_host_page_size.
If !reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 96d8d4f84c..4fcc490ce6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1531,10 +1531,14 @@ static bool init_guest_commpage(void)
                  0x3a, 0x68, 0x3b, 0x00,  /* trap 0 */
     };
 
-    void *want = g2h_untagged(LO_COMMPAGE & -qemu_host_page_size);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    int host_page_size = qemu_real_host_page_size();
+    void *want, *addr;
 
+    want = g2h_untagged(LO_COMMPAGE & -host_page_size);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
         exit(EXIT_FAILURE);
@@ -1543,9 +1547,9 @@ static bool init_guest_commpage(void)
         return false;
     }
 
-    memcpy(addr, kuser_page, sizeof(kuser_page));
+    memcpy(g2h_untagged(LO_COMMPAGE), kuser_page, sizeof(kuser_page));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
-- 
2.34.1


