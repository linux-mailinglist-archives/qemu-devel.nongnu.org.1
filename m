Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB678EE69
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:18:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhYP-0002YC-8L; Thu, 31 Aug 2023 09:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhYM-0002Oy-Du
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:17:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhYJ-0004Ff-Uu
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:17:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401b5516104so7248755e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693487858; x=1694092658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MdzPEcxzucIAuSdP8BdEgSNIDWAAi6SMHz+Cq8k3u5g=;
 b=a6acD0ZY2nCQCDSJvNLPLu3UZvD3bw88RnArk65MuLbPKKCAMkKHF4OR75aja2dehe
 wlchUHz6rCDacYDxrAYymlJc9qUzkLJalO7Dh6Aa0gNQQFH9NfPoiGgbXVUBaGz2DMFj
 PFj69LdU7r0aajHUuDCY0MLpHEDuu7WhhrMjs7bPd0980HX3gR0AboFZo8yiksC14OsS
 QPsx36Zu7WVCHjYgMVDNJRGXxyRZcZt6Wuwp2wJMHKn8kuNEGPdQ2ICgNNgrZK4s6tT+
 cI53+3SynpjfHfkVGiLjEB4e6pOBoeRpvdIYzkv2Lf02zJ5CUB8hRsxBQyvG7u4ZTHvj
 AHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693487858; x=1694092658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdzPEcxzucIAuSdP8BdEgSNIDWAAi6SMHz+Cq8k3u5g=;
 b=E1WrxRYXhpSCEu+DV9finW/XfWruSh4gLnowqB4enXIhyjWDvGFic8LolAJPk1RriI
 UlqOjy+XeH64CcBaRc7oTkX9w63trkj6Kop3amwU13Bdgzvejj9JY++g0lXYrf7uRcZK
 /kfLA11TFPSXFFCzsU4tJhvpXDuA4BvLoPwFG7oEr59tyMrkCwNBrYOCSwA0vdKccsqV
 ricNKqQy2vBZnIx5PiLlf0yoh736czZdt2l8Q6HF0D7C1yOqsPElvQGjJgigFlzNcAxi
 cDGNmRzVHZo0J5Ur/WV9t7XmYqVwoYB/PjS7uDkd+V7gzbFzpyfqFvYj0qHlcXASj2Uv
 pbew==
X-Gm-Message-State: AOJu0YwXPEEIa9/BQ8rvQIP63MTawdqJJaQaEwKEGFLSsadghG/l6csG
 Zy3U8WvHEpiXKq18MuJiRk9UZxsVGTSY2Zm2+w0=
X-Google-Smtp-Source: AGHT+IFK5zE4ue0WIDat5IwwtKxdowFm/vdwOQFHE43UQpzgYdCy9uuN+3jV7Xp9Crc2w5TiFXUllA==
X-Received: by 2002:a7b:cb9a:0:b0:401:5956:3cdd with SMTP id
 m26-20020a7bcb9a000000b0040159563cddmr4272237wmi.33.1693487857862; 
 Thu, 31 Aug 2023 06:17:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fc080acf68sm5129100wmf.34.2023.08.31.06.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:17:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/xtensa/mmu: Avoid maybe-uninitialized error in
 get_phys_page()
Date: Thu, 31 Aug 2023 15:17:35 +0200
Message-ID: <20230831131735.69288-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Fix when using GCC v11.4 (Ubuntu 11.4.0-1ubuntu1~22.04) with CFLAGS=-Og:

  target/xtensa/mmu_helper.c: In function ‘helper_pptlb’:
  target/xtensa/mmu_helper.c:986:35: error: ‘bg_segment’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
    986 |         return env->config->mpu_bg[bg_segment].attr | segment;
        |                                   ^
  target/xtensa/mmu_helper.c: In function ‘xtensa_get_physical_addr’:
  target/xtensa/mmu_helper.c:1011:35: error: ‘segment’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   1011 |         attr = env->config->mpu_bg[segment].attr;
        |                                   ^
  target/xtensa/mmu_helper.c:996:14: note: ‘segment’ was declared here
    996 |     unsigned segment;
        |              ^~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/mmu_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index fa66e8e867..93e3866217 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -980,9 +980,10 @@ uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
     } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
         return env->mpu_fg[segment].attr | segment | XTENSA_MPU_PROBE_V;
     } else {
-        xtensa_mpu_lookup(env->config->mpu_bg,
-                          env->config->n_mpu_bg_segments,
-                          v, &bg_segment);
+        nhits = xtensa_mpu_lookup(env->config->mpu_bg,
+                                  env->config->n_mpu_bg_segments,
+                                  v, &bg_segment);
+        assert(nhits > 0);
         return env->config->mpu_bg[bg_segment].attr | segment;
     }
 }
@@ -1005,9 +1006,10 @@ static int get_physical_addr_mpu(CPUXtensaState *env,
     } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
         attr = env->mpu_fg[segment].attr;
     } else {
-        xtensa_mpu_lookup(env->config->mpu_bg,
-                          env->config->n_mpu_bg_segments,
-                          vaddr, &segment);
+        nhits = xtensa_mpu_lookup(env->config->mpu_bg,
+                                  env->config->n_mpu_bg_segments,
+                                  vaddr, &segment);
+        assert(nhits > 0);
         attr = env->config->mpu_bg[segment].attr;
     }
 
-- 
2.41.0


