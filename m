Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2D7A23CF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu4-0004Um-AJ; Fri, 15 Sep 2023 12:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu0-0004TU-M3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBty-0004v1-UJ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fbb10dea4so1940248b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796162; x=1695400962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZrc3DuTynbE6ZobmlduknjscYzm5QXC9S5Fbkh1+j8=;
 b=dtxMgAGuXal5R1KvPFIk35pt80vYUhOzF/P7w1dB/KsbfD2v0PZZ6UfVNA1TB5BlR0
 odmBokJNaF/6Cf1Nl0tpfQtj9eo9mSKdCLmYcvHH7YfqYTz87h1bMCG/blvSea16rMXh
 6acP4cNcBeibPyPfbmegSKyEzFkqqvdDa0uHN5UtgLhCJkEwouEJS7mU9+vzZmSV6gII
 QiqWIeoASTAev9vmakUtFwyyLRZepUcaOTu2kJwomUOeFOY+LMsxe0EX8c7Dm9D4oZcE
 o9YqtCKMgcMrems9pFumfv2eWUmHLaDdkRaTN7eUhJAvRL2naE/X4TOgyiKJ+fHDpqMH
 +nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796162; x=1695400962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZrc3DuTynbE6ZobmlduknjscYzm5QXC9S5Fbkh1+j8=;
 b=pd09KhZF7/xIPh2cVpKHm9yT1hUOhKTbrPsh1XF0Fb58VoyPbyAhYUlZwBGE3k6Fyz
 lBCH/+crL5uVLHqO+gdy1qFgseDYGQ2IgALkRAs94aJIVQ+c5cmjxBVvLsrn8+bE9cBF
 MCHx3u3fsOfsCLFd1XRrcfykvp1yqZKjAzUTccHYT2ZcQHMJgm/qUKfcNNltT9MIVZIT
 QeddR+vo3VrOKXZjisMP1jSr+7GL4VPUQ7OVp0o5n5zZaE13ezLaFe3IebLvAyZRetFF
 bWgiWW0MnW+UlVj7KB/CRjxOnwNIr3JFNCNzdhFIFNUwL8ofmC7l0BfPDyJiJLHs5hyA
 98LQ==
X-Gm-Message-State: AOJu0Yz2/KRXnYXqesKLxweH3IslocDO7dGMWJ8EivB9RtcD1l9TFdIP
 krNqE+hQqtuIulQzrBw3841sX4yx8Xrknd8WmnY=
X-Google-Smtp-Source: AGHT+IGuYu1IqGm41lJzD5WIO5M0KQ/sZbnOJBUWcDznBIkyrKYUexgGn8Bp4PenbsWPPYSfYp/Hgg==
X-Received: by 2002:a05:6a20:5489:b0:14d:9938:735f with SMTP id
 i9-20020a056a20548900b0014d9938735fmr2726889pzk.17.1694796161776; 
 Fri, 15 Sep 2023 09:42:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/19] target/arm: Use clmul_32* routines
Date: Fri, 15 Sep 2023 09:42:22 -0700
Message-Id: <20230915164231.123580-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Use generic routines for 32-bit carry-less multiply.
Remove our local version of pmull_d.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5def86b573..ffb4b44ce4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2055,18 +2055,6 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
-static uint64_t pmull_d(uint64_t op1, uint64_t op2)
-{
-    uint64_t result = 0;
-    int i;
-
-    for (i = 0; i < 32; ++i) {
-        uint64_t mask = -((op1 >> i) & 1);
-        result ^= (op2 << i) & mask;
-    }
-    return result;
-}
-
 void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t sel = H4(simd_data(desc));
@@ -2075,7 +2063,7 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     uint64_t *d = vd;
 
     for (i = 0; i < opr_sz / 8; ++i) {
-        d[i] = pmull_d(n[2 * i + sel], m[2 * i + sel]);
+        d[i] = clmul_32(n[2 * i + sel], m[2 * i + sel]);
     }
 }
 #endif
-- 
2.34.1


