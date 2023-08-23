Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68AB78615F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOp-0000mG-Il; Wed, 23 Aug 2023 16:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOc-0008WO-UR
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOa-0005Yj-M9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so41368195ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822242; x=1693427042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K5ktodiRtLGFrSNUtNIXw44/pXcMbwHgN1qIEY5z9Y=;
 b=V/8RcNXfhIyF5Jjq1ofvLGmUWkvBsTo73bw0p0R47PqzEtvAlvagsUggUzHKnVABWc
 bo5tL7Ake7Fg7mHqCxQxivwaoM9Y6o/MFTYAf4I57pOq8qaPHAfFPXB7NyyCN7UqchrT
 jRCwIFNXlkvpHf9IUmQs7mDqffJZQygy/iL7Vr/9YIPAMvu7XdbSv6dATYyRZUGf6MvO
 OZMMNwq6dgAeQc6T9pbUxcCjg4t8iPqziGWT5eOdiEgqsSgNJymvQBTqLnWPABTxxqrC
 jLV7xvl9iw5938hm3kjnksHsAuYiXkatzGHSVm1N/yrqXPkEwiXbuHVAHyuCvyzyjCTm
 ZFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822242; x=1693427042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3K5ktodiRtLGFrSNUtNIXw44/pXcMbwHgN1qIEY5z9Y=;
 b=jz/7xLReHSpGqD4GDQVEx0a1dJH76a96wuG4estxjOCAxZpZ/wKf75R1N480gcZEse
 VZCNwW/iY9Uj97k4+C3MeRm8mho/iEazpC+OzxN3Ri7Hj/1ZfS8q3vLDnXwD4Xiv+iKe
 AOHfuInGrCgUn7Vot4tOb7NOkXwBmRTMaG/O8e7g2PGJFGMcShmN7nA6gCXAKOs0qTEm
 cbuA62ndDJs71/Vy7m34bSH19xPQFJDgqZ9m0DfTrKHpfDJFq9u1y5TmIby5qhXAE6Oo
 a1Y86EA3WBLWEPJNskee07ItuDM2jQiaw5H11PEJB5YpsIwU+I0fXfZ1mErCoDvUlg2l
 P1hg==
X-Gm-Message-State: AOJu0Yy3T7ipTDsGwHZuuL3qgfD/VttRepg17QlBYGpbvepfZkVmVHQm
 Y2M3Qb4jjfpiVS2i5kaMI/BAgQ+R5wz+vHeRvmo=
X-Google-Smtp-Source: AGHT+IHqyPU3cghK2GjiqgugvqRQWt6eAEPRxHpzQd86GfZTRoklYY8vLBFeQ0gVQBLNpxHwsS3kXw==
X-Received: by 2002:a17:902:da89:b0:1bd:c956:2798 with SMTP id
 j9-20020a170902da8900b001bdc9562798mr13219091plx.46.1692822241873; 
 Wed, 23 Aug 2023 13:24:01 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:24:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 37/48] tcg/i386: Use shift in tcg_out_setcond
Date: Wed, 23 Aug 2023 13:23:15 -0700
Message-Id: <20230823202326.1353645-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

For LT/GE vs zero, shift down the sign bit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3f3c114efd..16e830051d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1578,6 +1578,21 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         }
         return;
 
+    case TCG_COND_GE:
+        inv = true;
+        /* fall through */
+    case TCG_COND_LT:
+        /* If arg2 is 0, extract the sign bit. */
+        if (const_arg2 && arg2 == 0) {
+            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, dest, arg1);
+            if (inv) {
+                tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, dest);
+            }
+            tcg_out_shifti(s, SHIFT_SHR + rexw, dest, rexw ? 63 : 31);
+            return;
+        }
+        break;
+
     default:
         break;
     }
-- 
2.34.1


