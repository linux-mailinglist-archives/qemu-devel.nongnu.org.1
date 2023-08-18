Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3B781555
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j7-00056n-MH; Fri, 18 Aug 2023 18:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j4-00054P-Ld
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j2-0004Qx-Gt
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc83a96067so10729575ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396827; x=1693001627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K5ktodiRtLGFrSNUtNIXw44/pXcMbwHgN1qIEY5z9Y=;
 b=qz5JJ35pdr3ZFLsIvU3amBM9WJE3WlO6G5cJuroqw7A+vXX8JvpYpIACoDQZUVUkZO
 b7DSwEy9c3gzYl/sWdyaTsbdbwDorVpNLOVG4jAwVx2oJvlG8cIwk/p0b7Ymkf1HEpyK
 G+5qWgJxSIA4uDc2xrcZp5TcTmtK/ZS99kqWw77K2qJGmpD4uEstvtvyliW97fFImLAv
 MoU5vS5TXk33AlocfBQ1G6VuzeEZ7yY3D64iUAb9nMJ/0xAtxo9Xl+nuXhlalOPibmCf
 7wCFQ7wdP5oQCdvVJIr8EF1DWYudAKQpDPdnevpqHF/oQCwWgAlsghsdtp8taN2FtDiZ
 IV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396827; x=1693001627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3K5ktodiRtLGFrSNUtNIXw44/pXcMbwHgN1qIEY5z9Y=;
 b=DUOjZq9avupKY/k+JXrDYhsn6NVB7lx4sXoFuRPiMvibeS+USJFcBpV4B5NDisRg2y
 5RI99uz58ZsV6GdbOeqyTGnMo4VgNQe7VQ4bUUjW/t+yUGS37Zf0u44DxH3v4WegpI5Q
 ms7oKm0jWmHBgBPLP658qR6PaFPOsHO0ClD9fXdKN7ObkQeXUv3z7vpLuEWVbimZ+UVY
 liOiQMI9c5sbV2bU2lNTUyl7UXLKc3HahX+YidW9wipUJXxXJVhvKMEJAuoplDcgVabi
 PkDDvxtZRpvlWhcKY1R87N074y1OEWBZvUACfEFtkPs6yqQ49koHwmE5sZLlkrbESHag
 zqww==
X-Gm-Message-State: AOJu0YwoGP5mwsaTxnCnMWRNxfN14MR6qaF70GVNabjFxsmR+avlx4xU
 ZjPIc7vPzuqXCmw3TQ5LXwbBR0hYHn/x8dXuxNk=
X-Google-Smtp-Source: AGHT+IExvurXokNOxw9rZfERiV9IbZJNpjsJeH+/xMSGmsm3rhcTbBHGYAclY+veb+1n5m76CDMZSA==
X-Received: by 2002:a17:903:120d:b0:1bb:c971:ef92 with SMTP id
 l13-20020a170903120d00b001bbc971ef92mr513491plh.59.1692396827365; 
 Fri, 18 Aug 2023 15:13:47 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 22/23] tcg/i386: Use shift in tcg_out_setcond
Date: Fri, 18 Aug 2023 15:13:26 -0700
Message-Id: <20230818221327.150194-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


