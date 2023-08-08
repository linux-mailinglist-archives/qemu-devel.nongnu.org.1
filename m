Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B574D773779
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9b-0003vn-3J; Mon, 07 Aug 2023 23:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8x-0001ie-Ky
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:27 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8f-0000MR-HV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:23 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7658430eb5dso504655485a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464324; x=1692069124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kot5PEmuPDK/CyGN6ee3rwJzaEBsQpYk5OnUPUMG6UA=;
 b=H0N+6wB/55D91L4PTpoKFT2OnuU5j8OL6wf21rRD7/ElhRhjkxgLZeXS6+lGRXxs70
 8oTmNS7p4OFVSizMFjF8Zch052RgqR4b6vSHzDdA1rRSq05gLWQc/AFvj8uNqmTot5hf
 ypU2YGUn6kIO5jzndI5UjBZvZhE+XP0+6HMWwvobAwVpr59+F27G2uMS7+9PUGB8Df8y
 0s0z+f1ipIn3kV15qx9kOyylWkob8fy89sQBxFEwXCjPVT65k+1+JA8DzfkW6t4gNZqV
 wH4vkTc0i6G4YE+prbsf12FgN/MYTjyi89lql8gNDSGwLm2UwDBGrtVXlbVkUz/kw+0i
 OfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464324; x=1692069124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kot5PEmuPDK/CyGN6ee3rwJzaEBsQpYk5OnUPUMG6UA=;
 b=NomAPVvaCnSgkxJ4PbzMDcnLKfYYzTbeLU/glUuscTmrMI/xewR7R5Bofdda9F7dGq
 7eIR4cp0HxV8bwbk9dEeuvoj/WlRvpDvksoOnvpDqan7Yq5PSwpuZjjfXT2vaC4VFvww
 uX0ps3z/P4Xp+YTY0BhcRl2YECvOxQ8mPan1h73NDT3rQn6ItSRGcwyGbbD5CBq1Y0VO
 /JeZKzPSRdI/fVVzMLPGH0xAB79ZkHCcaPD82R1sBDYpec5WUmdkIXuIyvp7eZQ7TLBY
 nxQd1hRGvZVtVe46HkqA+luPn3Ncbw1C2q7+GwCGnIgzuTkJf9YR9CWh0QpvwiM2Uu1n
 zVXw==
X-Gm-Message-State: AOJu0YyqiB5JIFZiq1bc68uNqwzTa6d6durAC/fXfejENqKiSCoCVVu2
 +NLOryaae7g+Xv+ouGtmZ8DGG5wHT5A3h1dgVsg=
X-Google-Smtp-Source: AGHT+IEakiThj1Rb9ehn6LEa7qPCgMd7v3VGPLIPoRx93Mf+hd0c72kgo/rLsMik90T1uPTG/o6q5Q==
X-Received: by 2002:a05:620a:28d1:b0:76c:95a5:b86b with SMTP id
 l17-20020a05620a28d100b0076c95a5b86bmr18046091qkp.47.1691464324226; 
 Mon, 07 Aug 2023 20:12:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:12:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 22/24] tcg/i386: Clear dest first in tcg_out_setcond if
 possible
Date: Mon,  7 Aug 2023 20:11:41 -0700
Message-Id: <20230808031143.50925-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Using XOR first is both smaller and more efficient,
though cannot be applied if it clobbers an input.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index e06ac638b0..cca49fe63a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1529,6 +1529,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             int const_arg2)
 {
     bool inv = false;
+    bool cleared;
 
     switch (cond) {
     case TCG_COND_NE:
@@ -1578,9 +1579,23 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         break;
     }
 
+    /*
+     * If dest does not overlap the inputs, clearing it first is preferred.
+     * The XOR breaks any false dependency for the low-byte write to dest,
+     * and is also one byte smaller than MOVZBL.
+     */
+    cleared = false;
+    if (dest != arg1 && (const_arg2 || dest != arg2)) {
+        tgen_arithr(s, ARITH_XOR, dest, dest);
+        cleared = true;
+    }
+
     tcg_out_cmp(s, rexw, arg1, arg2, const_arg2, false);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
-    tcg_out_ext8u(s, dest, dest);
+
+    if (!cleared) {
+        tcg_out_ext8u(s, dest, dest);
+    }
 }
 
 #if TCG_TARGET_REG_BITS == 32
-- 
2.34.1


