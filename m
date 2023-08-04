Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1793876F721
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsz-0002jk-4P; Thu, 03 Aug 2023 21:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsZ-0002cc-PO
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsX-000570-Fd
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so1164024b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113520; x=1691718320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eOGiWVqZ8Y4POmSjtXETDABSVmvc7JlojTPUk6j1vw=;
 b=kvL3PYYCNqPm2kdtbooz9RzzOkPGr5fnNUK05uskyW30BoIPIRc0KjNoY/I/l6vIsZ
 +8z7v/QcuomaO3/jGb8LiKkhXwId6j5GmHVZjIEPpktD6Jx8YB9xZ2d+bNj5PfSNysw5
 25LeZeBdPRnjIsmTTFbH+VjPknyB+u33dxS51ORqY7AxzXxHAOlo3V5dm5PI7w9KB499
 9702KVBD7hTvjrCqDp8he3ienJXCMJ9x7GNgsibtsNXsk6RH1FhEE669o/4LBbXFVMPZ
 y6hG6UMd6wkgrWJVdkMRfy66h6aNE+Wbgw/L3z3G/RNR8HfUNa3X76eoVmtBTs2jJL9k
 k8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113520; x=1691718320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eOGiWVqZ8Y4POmSjtXETDABSVmvc7JlojTPUk6j1vw=;
 b=QTbSapqu89jF/mr2DtE9+0uWK2y11gNlaADLw4UpnYs06gM9fIoGD7NObJpMbEi/68
 MFsmWkdhWSt4IZHw3io2QL7YSKMj86BVChsOxFCin/Z+5f+yHugmih8KuDwKm+jfrTeS
 E0Vy9AjyhDunsL/6ZqnIOaQudJqbtBDOtX0J34VSq+0aY2BnC+qzur4AkVCY81VBkDo7
 aqRr47Vfznlp/cJqkvMUWOgallg+KVO/RHC85/6eGwNp7osFautUay2qDg0XViqQk5MT
 BnREJu3+0KNz9n4k+xy6t+jGo07LejkBHyL/CYTuU9C+m8wA0TpXmxDRsB3mTPcLqM1K
 l46A==
X-Gm-Message-State: AOJu0YzfwDDqTDMPtidj1iiG7bHJ6UHo9QAHdGx7NErFUtQMwkHy2euv
 azY93Pt5hrNkRU8O8+DQfRrWGeCsX8RwKx5lEmw=
X-Google-Smtp-Source: AGHT+IExQzT0L0jL+SQfu2V9MZCJz9pWZHMdLVcBsHVucllxQVBfHSNDBFwVMUalrEOJXYnDG2zlgA==
X-Received: by 2002:a05:6a21:4889:b0:137:9622:17d0 with SMTP id
 av9-20020a056a21488900b00137962217d0mr231190pzc.58.1691113520189; 
 Thu, 03 Aug 2023 18:45:20 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 02/17] linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
Date: Thu,  3 Aug 2023 18:45:02 -0700
Message-Id: <20230804014517.6361-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


