Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA6781550
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j6-00056D-Es; Fri, 18 Aug 2023 18:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j4-000541-6q
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7j2-0004Qj-1l
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so9084335ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396826; x=1693001626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwTSAJniEJxZbT4fbmyP3S6oSlLWMsUHRkmcSVO+gJc=;
 b=CVW+YEyg0xu5RbEdDyDI475yAXlegsUQ0MFCshQk3/7IctOBsA8MJyRzS33DXsICGQ
 BSzNWADUh0msgor+7R74LXSR2DhuK/OvrOJ9XTXeHT+d/psccyeserzfen2Fy1vsnLdy
 +cjCQh703dFZRVZpAPA8LHynJsy9zYAb7BxDPRxOwRIJE/8BFKWCyqRLs+q0l8vo5sCB
 ZWQVkPGDpyYnzFpxGj2D2nhGVJLpHGm5/C/b/Z4PRQEpkyF+oH/tEsrd4yxzFZe8aisI
 16bgwmui2Acdpg9/tZtOuCx09qADQSXdF46XyxKTWP9UqTgkUX+bO1wxFMxhQq6QgBnY
 MVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396826; x=1693001626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwTSAJniEJxZbT4fbmyP3S6oSlLWMsUHRkmcSVO+gJc=;
 b=T1CEm8w7FiRSTl5ajs9uK41OheNMAnE447A5DYdVlZSWTwKYOGomnAHd2C8xgXxMch
 8402Vh9YkiZTXLpO0jlhlM3ZDRFx6k/VHX8r8L83M/dm+IbS3YhRgq9lFhYGM8cWPHt7
 NhUl6ixnFDCpxEbqRQCgEZxesvZSSPW95YM7Ah/2SNuplSej3QffRfHFBZK8k/DxEwTu
 /D6M8RB6Th/ofFFWnF1Fo9zeK35HSVYJ9tkkDX8Txztx1rG1yFqsbETf4OpI3EluEg6v
 3tZbxYrBr86PxHT2HGg4vJWe4K/53awREMSGkgTPqwqUuuOeHLYzYlx0+X6y5XUu6Ied
 v9yw==
X-Gm-Message-State: AOJu0YzemUkWJLCimKq8NXgkEA8lMNmrMHk99YMIUF4zjgVjq0h4vT+S
 rUZK2xNwwj96r87bOjnrv0TufDrxrkN2DpmO0YI=
X-Google-Smtp-Source: AGHT+IHt0s3+zodG7J3zXuqSgCBEg8SeJDWcJmfGkcpZl/85cSv3NslHSQa1895ujtJiy2nDsoIXSw==
X-Received: by 2002:a17:902:d214:b0:1bc:667b:63c6 with SMTP id
 t20-20020a170902d21400b001bc667b63c6mr320348ply.41.1692396826720; 
 Fri, 18 Aug 2023 15:13:46 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 21/23] tcg/i386: Clear dest first in tcg_out_setcond if
 possible
Date: Fri, 18 Aug 2023 15:13:25 -0700
Message-Id: <20230818221327.150194-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


