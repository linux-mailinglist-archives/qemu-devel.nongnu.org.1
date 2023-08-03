Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B176DDAE
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWa-0000eC-4a; Wed, 02 Aug 2023 21:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWX-0000dZ-DZ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:09 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWV-0000jb-DE
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:09 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso222173a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027586; x=1691632386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eOGiWVqZ8Y4POmSjtXETDABSVmvc7JlojTPUk6j1vw=;
 b=iOvJMZoWdwCGfePsK/gD0VKxJ+aJG3D0f0wBWW7Np+urrLTYrNdVjBPbHdxR3SpHSM
 uc9of+mgcJTnDmQ6XARMwP1rwfQQptvgEvNUvFzG6O1MHx7b/bYW+ppy8b2hBJYveiJX
 sC+F6RNFaR2rI306vX4aO89mIzZaauRRpRoZ7YJgkRTB8z/OrpeiaDoENbVi4ggN1ihb
 WHPgDgwfvCz5h9fgL5V2t8kOVA2YZipyDElVCrZ68UawhE9WJJGMoY7lEHlTxtQhKvpy
 +H6MI5RazYQyPLX1mOoFZSbZhQrwiq4AK4XHSQuDQGwHjhskj9z2PnHt1QFKwiastTpm
 CEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027586; x=1691632386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eOGiWVqZ8Y4POmSjtXETDABSVmvc7JlojTPUk6j1vw=;
 b=DMm6zn6t4r/ONnBvCwsyOeDnhgV7ZIvZRujApuyLWj1BRobathK0U6mbjEJuI0t9cJ
 vGsefxibNKalwVdFtz/d9OEwx+TVg0XgOIe/3tTy83021csCkKoxxqZj8qR5btoaZHJw
 oCyaLzWr80nSUCQC3CWbtnArqWEwIbNO/8eqUsftM5JZs8usVppqMgJn5CAuTtV/BhgR
 /wMmoN+F4/w7Dhf+bqgv4FtTqY5+ahHXr+qJ7GnPPNE2k8pHxKCtrQLEHHrIvAXhN2oe
 1wiebkV60zvx0S5i/Il0QjrY8k9SBvTm9GsGYAlZ7cFTh0diz2T2ElUz9yQC6wiqo0nU
 QQcg==
X-Gm-Message-State: ABy/qLY/mZbt4ToEaLw4Rexs8gVCMxxOrZTzy3brW+fGue91kmNBQ6Xn
 MPnCbeT5luqA+8aPX44J8lxzD9BFtDyxWjfpcj8=
X-Google-Smtp-Source: APBJJlE6UdGmwlRXt6kXZDSgbn9liXJ9DmM8xyL3X5G5StkI4k8Ix2DZ7D0bofv5EOKci4M6Sj0mYA==
X-Received: by 2002:a17:90a:bb81:b0:268:5f1a:ede1 with SMTP id
 v1-20020a17090abb8100b002685f1aede1mr14640604pjr.36.1691027585864; 
 Wed, 02 Aug 2023 18:53:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 02/14] linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
Date: Wed,  2 Aug 2023 18:52:50 -0700
Message-Id: <20230803015302.407219-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

The man page states:
> Note that older kernels which do not recognize the MAP_FIXED_NOREPLACE
> flag will typically (upon detecting a collision with a preexisting
> mapping) fall back to a “non-MAP_FIXED” type of behavior: they will
> return an address that is different from the requested address.
> Therefore, backward-compatible software should check the returned
> address against the requested address.
https://man7.org/linux/man-pages/man2/mmap.2.html

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-3-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a11c630a7b..90b3ef2140 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -263,7 +263,11 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
         void *p = mmap(host_start, qemu_host_page_size,
                        target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
+        if (p != host_start) {
+            if (p != MAP_FAILED) {
+                munmap(p, qemu_host_page_size);
+                errno = EEXIST;
+            }
             return false;
         }
         prot_old = prot;
@@ -687,17 +691,25 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
         /* map the middle (easier) */
         if (real_start < real_last) {
-            void *p;
+            void *p, *want_p;
             off_t offset1;
+            size_t len1;
 
             if (flags & MAP_ANONYMOUS) {
                 offset1 = 0;
             } else {
                 offset1 = offset + real_start - start;
             }
-            p = mmap(g2h_untagged(real_start), real_last - real_start + 1,
-                     target_to_host_prot(target_prot), flags, fd, offset1);
-            if (p == MAP_FAILED) {
+            len1 = real_last - real_start + 1;
+            want_p = g2h_untagged(real_start);
+
+            p = mmap(want_p, len1, target_to_host_prot(target_prot),
+                     flags, fd, offset1);
+            if (p != want_p) {
+                if (p != MAP_FAILED) {
+                    munmap(p, len1);
+                    errno = EEXIST;
+                }
                 goto fail;
             }
             passthrough_start = real_start;
-- 
2.34.1


