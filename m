Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94E771375
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa4-0003ca-Vd; Sat, 05 Aug 2023 23:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa3-0003cN-AR
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa1-0007We-Mz
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:23 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53482b44007so1893071a12.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293040; x=1691897840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hdHwW/RvIed/+EnufWmWBI5tRDE8abmk2/NQyBO25E=;
 b=x2y0mcylR08z82S81nt+uxpnFQEPS/6RZCpX5qz+p2kNgHElMGgrDYZFD/i5JXFuy4
 Yurd0qW1jwJzlsjbIZZx/JpCMUymPwfwB2XavBsltw8THKtc0oFHba14H3eFWUi6Vi3w
 egouuTi5AF3GLi6gKXeDixw68UP+dDSNYZxi5NBEsGzyvSYs1nITcLWZMJt6I1zQVOBd
 A8WH9zqFj4a60LfcW0IveaibSTTx95/k0yxtxDdfNMnxnOaV6E8SZWdMP9mcDsQaTo2S
 P2Yf2I3riKz2ES2X4lFGi4VAqRVW8sOtT63shgSufHAFJX9ygPgIF82U9vuLwJb5S2Qx
 eaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293040; x=1691897840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hdHwW/RvIed/+EnufWmWBI5tRDE8abmk2/NQyBO25E=;
 b=jpuGRn2xqEtUotbmZQSY8ScaIBmP6+J427BFpV5TbsuMofPSP3dBPmndhg7/OQYbzX
 J2983yF3o2dVrfp4CNw4SkacdL8vvOfdqQzCTH2jRbb3nc6mNXIQFwirguv2CbY478i1
 5zv3yzoVpwalM/gogiXNr26xqgXnqiLW2r8ciV6oFNjU7JtPcFg8CLwgAcTwWTggPg5Y
 4M93ArlDvUyaeeNXStXYTqUK3k9DlIPP6Mq4gt/p2tp21c9d4YAA0y0TqZjXBESNTq5h
 pK/Qs1aHxs16kescFssqcZr1HDYhMN9Xo2XSzK6VPCB0CtDMdCxot2Myn840k0oZmjOs
 1JCw==
X-Gm-Message-State: AOJu0YzkoDPWysbOjl3rIdgOO5Rd89/2/sqCyLM/JxBKZNh+o164g1TZ
 0cogZRaGfY2eqX2ePe1j1h010CQ3OMns2k0kcBQ=
X-Google-Smtp-Source: AGHT+IFHZQl8FkcYnKeEi99+hAQmf0Nloxcn9NJWWpSxclAPftPyqjprn4k7+Onxr+yUvp8XrHgXEg==
X-Received: by 2002:a17:90a:1c09:b0:269:5821:5808 with SMTP id
 s9-20020a17090a1c0900b0026958215808mr18801pjs.32.1691293040326; 
 Sat, 05 Aug 2023 20:37:20 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 05/24] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Sat,  5 Aug 2023 20:36:56 -0700
Message-Id: <20230806033715.244648-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Passing MAP_FIXED_NOREPLACE to host will fail for reserved_va because
the address space is reserved with mmap.  Replace it with MAP_FIXED
in that case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-2-akihiko.odaki@daynix.com>
[rth: Expand inline commentary.]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a5dfb56545..a11c630a7b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -603,11 +603,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
-        /* Validate that the chosen range is empty. */
-        if ((flags & MAP_FIXED_NOREPLACE)
-            && !page_check_range_empty(start, last)) {
-            errno = EEXIST;
-            goto fail;
+        if (flags & MAP_FIXED_NOREPLACE) {
+            /* Validate that the chosen range is empty. */
+            if (!page_check_range_empty(start, last)) {
+                errno = EEXIST;
+                goto fail;
+            }
+
+            /*
+             * With reserved_va, the entire address space is mmaped in the
+             * host to ensure it isn't accidentally used for something else.
+             * We have just checked that the guest address is not mapped
+             * within the guest, but need to replace the host reservation.
+             *
+             * Without reserved_va, despite the guest address check above,
+             * keep MAP_FIXED_NOREPLACE so that the guest does not overwrite
+             * any host address mappings.
+             */
+            if (reserved_va) {
+                flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+            }
         }
 
         /*
-- 
2.34.1


