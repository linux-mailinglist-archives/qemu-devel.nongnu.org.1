Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1978617F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOi-0000JZ-MP; Wed, 23 Aug 2023 16:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008Sm-Ql
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOX-0005Y8-Ga
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso170186b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822240; x=1693427040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xk1+CqOJWdeIJliIlUjmMI38qlOB1/l73hqKwcbuPU=;
 b=FGsldhpldi5c+MmYENtFBEeKgglocEIXXd3mfsgrDSlezn99WSuFxwrd+pYype+rhC
 qsnRwzI8Gc8xKkMm07LWmlHQHml1JMSusnUJOsiiMeAJEq27B3uz1FuDcKZlWiVHbePk
 f1wME7UehBvyBacLZWXqvLZhCK0Q5AE8dIbG5jrOwS5Q35vjqr6IkY8Z1VOBWxXE29MQ
 VxyV0ppiBZ0o3IKFjjWE2KIbumZhkeWbryqXNOJTNxB7SuGl4A4RmNtkQg6RVRs5cLR1
 7JPAFpdryIB2fmMbw5qyptqRWE8EzlmjAle6a8vPFj7AwT4uvedSriBxq/Y8JDYgcHPv
 ppBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822240; x=1693427040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xk1+CqOJWdeIJliIlUjmMI38qlOB1/l73hqKwcbuPU=;
 b=T88cJh173wiA0dJs0H7YET9RGjIZtuiA0HXu4i+UXMoxkd/iB5VQHDlGO4TwwQ2Uk6
 23hqny16D+vSeMjNjnMfOtyNqqDu45ROUWeBVgFwi1AcWvJGOM/M+2nQwV7KPSDp7rak
 SVQMtKJLJCGmmi/FwjqXg3r5APVvVIX+7VdQDUnc3vSxOepO6Cj9SyYkSUTZ9C2SILEq
 R9G7BiNR3WNNIthLWtmymiGi7J6iRW66WSHE+AwMOS3gfHl1PpSxfwbI19RpmNWjBO9E
 ZRuvNpMJimcp+fggxKntL3qidWmyHf3dvTDjtLbvMhIkx12pBQCVthdSOKFcafScHLGI
 fxcA==
X-Gm-Message-State: AOJu0YyXAjch1LSfxt2yXy84fiKZeHo6aOIWeBNnBZI6xfYFLwYpMk+O
 JoiIhdUgOoRpXaoke0w2kVnWFNWlgac65V7Yph0=
X-Google-Smtp-Source: AGHT+IESF6wfuKvMlVqVlXFRT49MUbdXMT91tpr5P4FHUwZcewZmY0tJLkge6aSNer/DPp4DMkUzUQ==
X-Received: by 2002:a05:6a20:969a:b0:147:d309:be7b with SMTP id
 hp26-20020a056a20969a00b00147d309be7bmr9855861pzc.62.1692822240060; 
 Wed, 23 Aug 2023 13:24:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 35/48] tcg/i386: Use CMP+SBB in tcg_out_setcond
Date: Wed, 23 Aug 2023 13:23:13 -0700
Message-Id: <20230823202326.1353645-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Use the carry bit to optimize some forms of setcond.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 1542afd94d..4d7b745a52 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1531,6 +1531,56 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
                             int const_arg2)
 {
+    bool inv = false;
+
+    switch (cond) {
+    case TCG_COND_NE:
+        inv = true;
+        /* fall through */
+    case TCG_COND_EQ:
+        /* If arg2 is 0, convert to LTU/GEU vs 1. */
+        if (const_arg2 && arg2 == 0) {
+            arg2 = 1;
+            goto do_ltu;
+        }
+        break;
+
+    case TCG_COND_LEU:
+        inv = true;
+        /* fall through */
+    case TCG_COND_GTU:
+        /* If arg2 is a register, swap for LTU/GEU. */
+        if (!const_arg2) {
+            TCGReg t = arg1;
+            arg1 = arg2;
+            arg2 = t;
+            goto do_ltu;
+        }
+        break;
+
+    case TCG_COND_GEU:
+        inv = true;
+        /* fall through */
+    case TCG_COND_LTU:
+    do_ltu:
+        /*
+         * Relying on the carry bit, use SBB to produce -1 if LTU, 0 if GEU.
+         * We can then use NEG or INC to produce the desired result.
+         * This is always smaller than the SETCC expansion.
+         */
+        tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+        tgen_arithr(s, ARITH_SBB, dest, dest);              /* T:-1 F:0 */
+        if (inv) {
+            tgen_arithi(s, ARITH_ADD, dest, 1, 0);          /* T:0  F:1 */
+        } else {
+            tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, dest);  /* T:1  F:0 */
+        }
+        return;
+
+    default:
+        break;
+    }
+
     tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
-- 
2.34.1


