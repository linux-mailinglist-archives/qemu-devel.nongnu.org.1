Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DCB752BEB
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ek-0000S0-5Y; Thu, 13 Jul 2023 17:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eM-0000K3-FU
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eK-00018i-U3
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso11059565e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282895; x=1691874895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1koV3EZIffRqpF6kXzdOYGupm/qybouRR/ROCDFTB8=;
 b=dF0eVDXN1HFujTd60wEqCwxFXFel0kx9yNUNo5g23hWIK75gy7VusAx46n+tMJ38pH
 /N/+VOFcq71qiBjsdCdYYVixf0RLdn82vZxtnrV3FaHyXdewMhlsby80wBKurIo1XBYW
 CXcl3I02pdMHP6x9z4pAWen7MzRSNJxaTlo+qq3FvMWksq9prPAStLwgq2FjtD0oErNj
 50GB4W/bYTpsYHG/rBezlIw1QIsAiPnAvLfyEckgbXk0bibCEezR/IfGRaPWLoE5qIjz
 zSJOenUFM9zavspuhtcPlxRhZXw6Fcn26xfybYYU487ckl8ZDk2jiYa5sxKTGOFMlN4q
 E8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282895; x=1691874895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1koV3EZIffRqpF6kXzdOYGupm/qybouRR/ROCDFTB8=;
 b=L0ZooBqZBQ5n64MkOaf/MD+WZBDmbKFSFhTsxkHGHGINaIcNxbHwlWHMeJmF8u8HKx
 af+zAfdZNyyfpc+Sgrt3t398FzVsrXj6hWonGNs8UdiIZn17WsNdh67zxcPIo4etdJ7d
 oDK8o93gXV4drEbGsoT4G7pRZrfEEK3IOY2FwgGzIQ8LNpiujf/BZ+uwEM7q+uaIaAl3
 P1osChBjgDY2YPVT/iZ1eI3Ms6P5vbXXIGTW1lC31A6D/8AIAH683VPdmQ5ktzTkkDxp
 iY/5VNv1DUp3WzPJUTppkXK2cjLrAWh0VVeJr/npVKDq5xqn8aH1h4A2qEmFe24AU9uQ
 PMjw==
X-Gm-Message-State: ABy/qLah9RUaQTG7Y9HzguLirW9F+iwMORY9TYs4m3p/5Hj7HHNqOONW
 V2nlqoWsblLPzy+XhMha4eAViG0OypkWDY21E1G76Y0B
X-Google-Smtp-Source: APBJJlFgoh4ZxM21J+t/BGfYv/IoGQP2L35Y/teVxLhcz0dZL3mPwJyf2yvXfCL6nHtdqr7oYXsofQ==
X-Received: by 2002:a7b:cb10:0:b0:3fc:21:2c43 with SMTP id
 u16-20020a7bcb10000000b003fc00212c43mr2547618wmj.13.1689282895738; 
 Thu, 13 Jul 2023 14:14:55 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 14/18] target/arm: Use clmul_64
Date: Thu, 13 Jul 2023 22:14:31 +0100
Message-Id: <20230713211435.13505-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Use generic routine for 64-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index c81447e674..1a21aff4d9 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2003,28 +2003,14 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
  */
 void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
 {
-    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t i, opr_sz = simd_oprsz(desc);
     intptr_t hi = simd_data(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 8; i += 2) {
-        uint64_t nn = n[i + hi];
-        uint64_t mm = m[i + hi];
-        uint64_t rhi = 0;
-        uint64_t rlo = 0;
-
-        /* Bit 0 can only influence the low 64-bit result.  */
-        if (nn & 1) {
-            rlo = mm;
-        }
-
-        for (j = 1; j < 64; ++j) {
-            uint64_t mask = -((nn >> j) & 1);
-            rlo ^= (mm << j) & mask;
-            rhi ^= (mm >> (64 - j)) & mask;
-        }
-        d[i] = rlo;
-        d[i + 1] = rhi;
+        Int128 r = clmul_64(n[i + hi], m[i + hi]);
+        d[i] = int128_getlo(r);
+        d[i + 1] = int128_gethi(r);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


