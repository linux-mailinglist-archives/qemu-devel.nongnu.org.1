Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D49278E0C9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:36:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbRtr-0002p2-Pt; Wed, 30 Aug 2023 16:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbRtp-0002oJ-7B
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:34:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbRtm-0000fQ-Nb
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:34:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso67037b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693427685; x=1694032485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WWoJcjMrli/UBoxVP+bc1AqaQlcf1mCsWLbenvoycVs=;
 b=NnBz6OPFKkfXv8Qgzbdblc7xsXWTtIw61aWPf4FqZ+S4YpJMN20z/r1UU/66+kJsNP
 bXEVyPKTDtps0UjqpyAbvbUFyj7afne+Oyz45SOk9v6CS106FuptmiN8o34upaw7/ffb
 YvbALtGZYKs1gJTZrc22KcGqX7qfSI+ZlCmuvt26Z+1LdUfKaXnPlG0leo+2PWmyx/aK
 FpoeUsslN1D0Y1ZyB0TD7Qmf60C0q4qvBLO/vX0keAEBU59C/NVeypzuEjj/Wlq8XOUA
 H32vow5+fKemYDwj9uOJcgO38XldIMlBrjd4up4NxnS1NWUCDbj5nxmuZm2c5OdPAhC0
 slGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693427685; x=1694032485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WWoJcjMrli/UBoxVP+bc1AqaQlcf1mCsWLbenvoycVs=;
 b=bPgToWn86UGtMTLxH1aWGRPBfcSqMVPEhM9qxauE6WNt4xAEfbz1K91yx9B7hHHifU
 kAQJzUxAexVWBlil/Vn5gJaKUfAJFTKSTiKmhLZTiqsdDRWqHguKdVt44Z0WrK0ciMER
 zE0O7eO9M8MjP6rrWKXkOzOD+btim88/68zIhJBofGCsaFHZ5YIe+is+6e3Lnd9N4ZPv
 y04RC8nSfp6mDS8z1ZNwvnqe6oQZRbUZQQictF5Hs1PsAbgKR8Nx/1eOK9ethBtRuVE2
 2RnThC+hXEJohuu1tXgHzm3u7RILPXia7KSaVGtek+537iEImk6/KdGAjSLKxSU0y6l6
 Qu3Q==
X-Gm-Message-State: AOJu0YxdHCBcQy2Om0xpLOWbYfiui+2dIDyaVHdNros/IH+Dt9TuPhBE
 WzkHv1FvAaiUS6s863hYF1bCeLiVHvkb97iatxY=
X-Google-Smtp-Source: AGHT+IFdIGr+PXWkX3Se43ug3jQZYqoJ1qLH5G552/NyanWfYFJ1ZFpO6vrt7BSQ0KPT8RoacMck9g==
X-Received: by 2002:a05:6a00:b45:b0:68a:4b8c:4e91 with SMTP id
 p5-20020a056a000b4500b0068a4b8c4e91mr3619789pfo.19.1693427684930; 
 Wed, 30 Aug 2023 13:34:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 y17-20020aa78051000000b00688c733fe92sm10387544pfm.215.2023.08.30.13.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 13:34:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH] linux-user: Fixes for zero_bss
Date: Wed, 30 Aug 2023 13:34:43 -0700
Message-Id: <20230830203443.1126914-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The previous change, 2d385be6152, assumed !PAGE_VALID meant that
the page would be unmapped by the elf image.  However, since we
reserved the entire image space via mmap, PAGE_VALID will always
be set.  Instead, assume PROT_NONE for the same condition.

Furthermore, assume bss is only ever present for writable segments,
and that there is no page overlap between PT_LOAD segments.
Instead of an assert, return false to indicate failure.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a5b28fa3e7..7bc7bcec19 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2308,21 +2308,40 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
 {
     abi_ulong align_bss;
 
+    /* We only expect writable bss; the code segment shouldn't need this. */
+    if (!(prot & PROT_WRITE)) {
+        return false;
+    }
+
     align_bss = TARGET_PAGE_ALIGN(start_bss);
     end_bss = TARGET_PAGE_ALIGN(end_bss);
 
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
 
-        if (!(flags & PAGE_VALID)) {
-            /* Map the start of the bss. */
+        if (!(flags & PAGE_BITS)) {
+            /*
+             * The whole address space of the executable was reserved
+             * at the start, therefore all pages will be VALID.
+             * But assuming there are no PROT_NONE PT_LOAD segments,
+             * a PROT_NONE page means no data all bss, and we can
+             * simply extend the new anon mapping back to the start
+             * of the page of bss.
+             */
             align_bss -= TARGET_PAGE_SIZE;
-        } else if (flags & PAGE_WRITE) {
-            /* The page is already mapped writable. */
-            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         } else {
-            /* Read-only zeros? */
-            g_assert_not_reached();
+            /*
+             * The start of the bss shares a page with something.
+             * The only thing that we expect is the data section,
+             * which would already be marked writable.
+             * Overlapping the RX code segment seems malformed.
+             */
+            if (!(flags & PAGE_WRITE)) {
+                return false;
+            }
+
+            /* The page is already mapped and writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         }
     }
 
-- 
2.34.1


