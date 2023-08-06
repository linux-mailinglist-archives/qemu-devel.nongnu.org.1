Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 599FF771370
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa6-0003e0-IR; Sat, 05 Aug 2023 23:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa4-0003ct-Ne
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa2-0007Wz-PE
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-564ef63a010so150994a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293041; x=1691897841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+al/bCM9dfQjUvbH6ERA5E1FapPNk6WKGGZIMvtMEA=;
 b=Z6EF2Sf0dU/8E+SPlQPBdWKP+TPG6VnwppJXQ3uUy8Bc2zcbW6CnsRa6482Z74/ZMp
 +UxmqedwJQbsNmWCeNoX9OQIjf4owyYQihCnTBMKsjrCae9bXRgOCjC+xc+50nL63sm+
 3kf0okqRV2C6Z7efjbLyYBTObkrXUeDkuVbjWbifVhtQDKo+Jpt3xHvv8R4eXhGfuEwp
 ho06D79uKXjgNL5eEcMFKG0MrusQriTzx8xzjzklfnWCzp/bJwLaG57tS/Ndfy8YkmyQ
 O7PVPzBUseqqyL8MWeoiJpVA2gwbAyXBGKiMGRv6e/QJdoKFIjo3BaGfih6qDl/x5hTZ
 N9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293041; x=1691897841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+al/bCM9dfQjUvbH6ERA5E1FapPNk6WKGGZIMvtMEA=;
 b=e7NAPZ94qRzMutIy5md1HTjHjMTOJi/usT/8fTeswQDFfOsUztDaCrEbTOri9MxP8Q
 ypOsl6EVkwm8lWeMZBLOCWbA1JKOycbXCvogQ8qgq57D7fJ5T7LMR8p8TkpNq+WKgkqv
 QrFrUP0JDcQ8xJfiPcTtgB06yepYoGGmH7bSUI+e/EZnVT8yMg4AMDWQJ60040Y+bj3T
 tzy7U/CM6+RIEApfa5afycGQWyva2LuXSiSaUPkPrD6ZUUSpZCN3N6LXqpDe0ohJK8Hp
 ZK+SyDRd48ob/wm35/J4ZTwy3oVuyHrNOjUHqBkeY3U5DS3f3ZcfZqq5vkDTmSBa3lnF
 zCqA==
X-Gm-Message-State: AOJu0Yz2TFi1A6iJj2d2uZquFJ+30IMsRwLNMciN/amYoEI3Z96qcFG3
 goL1JT7o5za4UDA8gEHOHKMFnjK7eFuV4EMFgKU=
X-Google-Smtp-Source: AGHT+IGgSqD1df9CIqMQdf3uai89JpKwhXap63RN40/JNlECHJXUvUm7lzPvm4QOIGn+Jm1HNlC3IA==
X-Received: by 2002:a17:90a:5512:b0:260:a8da:536c with SMTP id
 b18-20020a17090a551200b00260a8da536cmr4672093pji.23.1691293041161; 
 Sat, 05 Aug 2023 20:37:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 06/24] linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
Date: Sat,  5 Aug 2023 20:36:57 -0700
Message-Id: <20230806033715.244648-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


