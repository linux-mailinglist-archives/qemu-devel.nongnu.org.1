Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B67E770BB3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rI-0004sN-3V; Fri, 04 Aug 2023 18:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qi-0004X6-Jm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:46 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qe-0001jY-H1
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso22024045ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186439; x=1691791239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+al/bCM9dfQjUvbH6ERA5E1FapPNk6WKGGZIMvtMEA=;
 b=SOpKkvzldfmAt3LnNY3pfZO+WMTeO8e35+ej3p06mQfrHlQ5wgzGN+uKL64OgKuJLB
 N0LesIdg/hZQWeELVFtnk1zoL+r3mcDvPHmX/I3kcTKUgAcpBRLcW92iQlskhCQ2Quzb
 33QQB9/Uw5O9qVt7MsK8CxRFfvKXQ/zEGQO8h4/fwxMhutYNjUk4PLNCxDtk0DPHJypL
 U8rzxYWHbELk/S0y76dnNjllwxbuLhiDQdmjq7RIliuLwHx24U0+ZpkPi76flJ8315gD
 ukBEoIhZXsxV87u2lcrieB5onUouLdGLGEdMByJhz7dYpJbvivSsOZfECmliQwji0/9Z
 IKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186439; x=1691791239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+al/bCM9dfQjUvbH6ERA5E1FapPNk6WKGGZIMvtMEA=;
 b=NQB1Q3r6EF53dzGw0JoQRoN2x4EjGH5wMjFwg/+mxbLkzHGA8S8vda8EkKhbIQq9xl
 E1kVCHKuLQ0GsWvnK1FT+p2A7AgGL5wKEfyvx3wVanp/xsKKEfYgZR4KD52ExVZAJFjX
 LuGQaJ1lDEDLv+1ekkL0AnEqT3f2aISynyDnw/9+mg0T6aJcv2zG7eaJlBldhchBSxKH
 a9voBhEoiW4CUGMdV/HugQexlALPHfH7xsD6cjL3FrN+0YWhVTnLt4+VK9OYne/69v9g
 t9ktMjTvcLUKEhoIaNjxwwYwrGJWsVVqMjUek43C8BfwpAW/a7qih66n8CPnzBMsBYvW
 fYtA==
X-Gm-Message-State: AOJu0Yx8RRDt/bKbq4ABspxItS7nkOC1XltlEMZ1iXDHj3RXPMy3xPqa
 SRijtkWo9kI6P8Q0OuvgH+T1sS2m+rOupLysO+o=
X-Google-Smtp-Source: AGHT+IEkYR4b+kE+t357l5OPKONFVHWmg+G3qpEMeO8t0BSWTrFkleWAheC7I9V2T4VP2+Ifhhrd4Q==
X-Received: by 2002:a17:903:188:b0:1bb:3498:9caa with SMTP id
 z8-20020a170903018800b001bb34989caamr3765589plg.58.1691186439141; 
 Fri, 04 Aug 2023 15:00:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 06/24] linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
Date: Fri,  4 Aug 2023 15:00:14 -0700
Message-Id: <20230804220032.295411-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


