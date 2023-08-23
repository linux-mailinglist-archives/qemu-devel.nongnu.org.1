Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4D78615D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOq-0000oS-7d; Wed, 23 Aug 2023 16:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOc-0008TR-KH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOY-0005Yb-Na
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso25220755ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822241; x=1693427041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwTSAJniEJxZbT4fbmyP3S6oSlLWMsUHRkmcSVO+gJc=;
 b=CTgLdT3LVLYStCyduEeT75Q/bCHmjp80TJzhuG303Z6EaPIV3D7BixXpvp2T+pbpfh
 yPs7PdrpGiO/xHbwwNzHf+EgZ4GAGKkKq8lru+PnCuFpGJSVUN596lsWvGlYe1t8dzju
 RjbF3JGHwoU+GiOCjefy3xytgghZa+qvPYOHqLN7SrzjK/svcA0msOavIxW2KjA7V/2q
 1YM9ExapQyWf3/0cOaxPypibgWbTbZ+UzsA3BAwduemUffWKG0YBFOu6HSWbap75Rf+Z
 Tph2OShEM8Y1R5MJxabIOLdcpxgnwojDk87kpF7FrUm0x9KNEC06QEzXTcgm1tslUlkS
 jL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822241; x=1693427041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwTSAJniEJxZbT4fbmyP3S6oSlLWMsUHRkmcSVO+gJc=;
 b=NFXzL/nBxvqr6iQsW/nMbW03kHeSTOduVKHfz6oVuBDdUm/wqh4PVNbAsfmdFlFn4n
 4gJ6seqfQm0fvfo+svefAedOmx60P1pu1mXZ0r/LKzMPPtY5T3wUiNyNxrzjQ06RlllP
 IBy+AxEccMjAOno09ZceschlFzrSaPQdNgZvUEi5G+p4xXCRLv5jyQhyiolaxxkZhZ8m
 YLJwcoIjQykl9VVIVTtwVzI8m/5bA89ieq8idgHxV7ozghvJyy2c2fCgy0kkFi3SDhTQ
 NWAzf+gW2HMH2Q4ldFYppA0PimZsffnfafIvp3QZioemHDM3we1YamOL3hbhdvqnErJi
 Q5yA==
X-Gm-Message-State: AOJu0YytfnJnhMrMPCFu2pR2MWmIAzKFUEYlkO9TFQQrbb8/Gag5zC5Q
 WsiK3HjAvsRdDb/06Y/Lb+TF0LzglnUGPdXRGgQ=
X-Google-Smtp-Source: AGHT+IH5XhktPmypwrgK+iaH/LlNaLd5T+pnmOnl+a3FENvfblNRwDpu/1sTbgW66VRxJyAUe5OzcA==
X-Received: by 2002:a17:902:b617:b0:1be:f76e:7664 with SMTP id
 b23-20020a170902b61700b001bef76e7664mr10151383pls.29.1692822240853; 
 Wed, 23 Aug 2023 13:24:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:24:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 36/48] tcg/i386: Clear dest first in tcg_out_setcond if possible
Date: Wed, 23 Aug 2023 13:23:14 -0700
Message-Id: <20230823202326.1353645-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Using XOR first is both smaller and more efficient,
though cannot be applied if it clobbers an input.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 4d7b745a52..3f3c114efd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1532,6 +1532,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             int const_arg2)
 {
     bool inv = false;
+    bool cleared;
 
     switch (cond) {
     case TCG_COND_NE:
@@ -1581,9 +1582,23 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
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
     tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
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


