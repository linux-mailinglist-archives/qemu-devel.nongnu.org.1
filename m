Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E291771368
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa9-0003fJ-FL; Sat, 05 Aug 2023 23:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa6-0003eA-V6
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa5-0007Xr-DG
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-26814e27a9eso1685285a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293044; x=1691897844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=jvuBu+oiUXsexECcMGF/DL7Brf2aPF5l5SKDbNubqQx1A+QuXsL9YqVlp8ZqA2btjg
 gjDgS1wn0zR5aldc9ZVe41bvut3dSMIXe7Y30RbA1qQ+Wy8aYvujYmyUDfqubSdouKLf
 /8W6et5Ln6QOLgyhIl3xQjm2vvVXnYiNepcu25Nr2++tBwW4Lk67skKCWzj/OKMpr3IU
 vALUNIKHrpaL7a1DCEa/Pb1/NSblNF50F0ZOdskKVYJA6R17wtyLj54+OC+WI9MS1oKx
 SqK3VdBLuA6NX+py1Fv5E42sUFEpDTVSXRRwuw2qXDBOL/4uCaf5pkWxyvUmaOxqXeLQ
 IOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293044; x=1691897844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=FLoEE9H+kdH80HFkLoAc+6Q4z21SrVhWQ7ioV1anRkd30ezA8k9Nxj7KqDgUo6x12N
 wzCPrrIvi+4IVEpQ3l8jpgFxvxrZKyV5vECC2KEkcaf5OEcJ1//b/k01nk0HkIrvZNwF
 rGCnGniQY1qBpdzanPrCqY3R7FvhqtHXSvXWp0tp+6v6pX1adHOtd5j8dTQaZk5MuOY5
 R9dAkPqLogxOYU21HSIKaFXJIfSHGSTpB54ecqfmKf3g+ZLEXo6FKUUD6mNyTewOuCil
 ilYc44kjU8EICZ8TizQ1KNPpJVqxmEa2EBpmAX0k/45ek0YXha0YrDbGc5tlWscQbbRp
 WJAQ==
X-Gm-Message-State: AOJu0YwuTUjBu7Ap5/1XxoLGub5kxIH1cNV1TU1S2z0Y+tu3efB3RQCu
 RMa7Lf5sxboYPqcCuHsYjeO3HqqC79okxfvL6iI=
X-Google-Smtp-Source: AGHT+IHoZZRsCRVfqMthXl9skZoxp+CFbRUeonxt2D5x/N2gvomcNo5sDJf9+JmGlUpA09gnRILPpg==
X-Received: by 2002:a17:90a:6c45:b0:263:fccf:8f6 with SMTP id
 x63-20020a17090a6c4500b00263fccf08f6mr4044567pjj.14.1691293043858; 
 Sat, 05 Aug 2023 20:37:23 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 09/24] linux-user: Do nothing if too small brk is specified
Date: Sat,  5 Aug 2023 20:37:00 -0700
Message-Id: <20230806033715.244648-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Linux 6.4.7 does nothing when a value smaller than the initial brk is
specified.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-6-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f64024273f..e1436a3962 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)
 
     /* brk pointers are always untagged */
 
-    /* return old brk value if brk_val unchanged or zero */
-    if (!brk_val || brk_val == target_brk) {
+    /* return old brk value if brk_val unchanged */
+    if (brk_val == target_brk) {
         return target_brk;
     }
 
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
-        brk_val = initial_target_brk;
+        return target_brk;
     }
 
     new_brk = TARGET_PAGE_ALIGN(brk_val);
-- 
2.34.1


