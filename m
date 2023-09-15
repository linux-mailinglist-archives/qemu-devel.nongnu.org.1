Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C582C7A23C6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu6-0004Vj-Rv; Fri, 15 Sep 2023 12:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu4-0004VR-VH
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu3-0004wm-Cg
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso1722775b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796166; x=1695400966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+3/8IiHtNpBs5dwlAlcrSMhCtecqGkkP2HhC4y759E=;
 b=TrLqvRrkTYTzuerEopt6OwLgWG+K1+eZXhWlX7gLqT0ERI1lu9nCQOaj/YXeueIbg/
 Ndru3nJK8XqtfVgGmoB47DhwhkF6uHcet2JBGtYUhKdtIYBw8Xe7jktUCAFhFzyEEk8Y
 8zrzbw6Z0XLZ4hl57B80j+CrYOc/hd/tS5NAyj2roRG2vw+k/c59FwiDadY4pqARujgl
 VYzwET2qadZlj08pjLDrxZ+rrhF4sU75z3ZMlS9g6n/3BLLrxz9XsImGwuE6suNd1xWx
 eINCtF1qg6XW/8lx+swIAS1PMdZ+eLGl8G4DONrh6p8b+9MwzVKyi4VG0Lg1cDhkOtVm
 1xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796166; x=1695400966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+3/8IiHtNpBs5dwlAlcrSMhCtecqGkkP2HhC4y759E=;
 b=Ld3tWyey6gp/7jfLZ2cJpnPszToXdUtw3K811gjJiEJHbpo+L+9RclE4RbkfHagTp6
 Zjetx3+ICloxh7+nURrIH+h45zEOwqNYwiqp/gync8QvYjePltppANtQLeOfs3fhb+rr
 smrz5wBrMWK8EufhYs3cGRhBHJtin0V63c7nM4J20bEmKM34rM/BpTTtz7IYw960zMQj
 dnCKZRU+DUgx+TQINNLDXylm/wIupjUddtvjG+SPSEQInXO75NY/VdSJ3domrVqGp5tk
 JGArRnx/DRnWAI1vVSzakCW4uxCQc1LiXY8a801nyR5oqEcH9qTS1L2go7XW3y9FLwsP
 itqg==
X-Gm-Message-State: AOJu0YydBY5AlytmRIv3D3ZmbidpwhMv/3F7ywhL+nFPqqAxUIJ7eJy/
 DTFd2J4ZX7W0WI36Kll4O+ipLh2quEq1u1OyviA=
X-Google-Smtp-Source: AGHT+IG9a5LF1bnb7JgZGyu37DmTsoquDayqpwsPPcJLa+/QfHcqowgeBLyb8bczV4L7DjNxH4mtcQ==
X-Received: by 2002:a05:6a20:430d:b0:159:d061:58e9 with SMTP id
 h13-20020a056a20430d00b00159d06158e9mr7314745pzk.26.1694796165954; 
 Fri, 15 Sep 2023 09:42:45 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/19] target/i386: Use clmul_64
Date: Fri, 15 Sep 2023 09:42:27 -0700
Message-Id: <20230915164231.123580-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Use generic routine for 64-bit carry-less multiply.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index a0e425733f..33908c0691 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -20,6 +20,7 @@
 
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
+#include "crypto/clmul.h"
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -2122,41 +2123,18 @@ target_ulong helper_crc32(uint32_t crc1, target_ulong msg, uint32_t len)
 
 #endif
 
-#if SHIFT == 1
-static void clmulq(uint64_t *dest_l, uint64_t *dest_h,
-                          uint64_t a, uint64_t b)
-{
-    uint64_t al, ah, resh, resl;
-
-    ah = 0;
-    al = a;
-    resh = resl = 0;
-
-    while (b) {
-        if (b & 1) {
-            resl ^= al;
-            resh ^= ah;
-        }
-        ah = (ah << 1) | (al >> 63);
-        al <<= 1;
-        b >>= 1;
-    }
-
-    *dest_l = resl;
-    *dest_h = resh;
-}
-#endif
-
 void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                     uint32_t ctrl)
 {
-    uint64_t a, b;
-    int i;
+    int a_idx = (ctrl & 1) != 0;
+    int b_idx = (ctrl & 16) != 0;
 
-    for (i = 0; i < 1 << SHIFT; i += 2) {
-        a = v->Q(((ctrl & 1) != 0) + i);
-        b = s->Q(((ctrl & 16) != 0) + i);
-        clmulq(&d->Q(i), &d->Q(i + 1), a, b);
+    for (int i = 0; i < SHIFT; i++) {
+        uint64_t a = v->Q(2 * i + a_idx);
+        uint64_t b = s->Q(2 * i + b_idx);
+        Int128 *r = (Int128 *)&d->ZMM_X(i);
+
+        *r = clmul_64(a, b);
     }
 }
 
-- 
2.34.1


