Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744E77377F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9c-0004Am-A6; Mon, 07 Aug 2023 23:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8x-0001hx-60
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:24 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8e-0000Lo-KO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:22 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-76ca7b4782cso383667585a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464323; x=1692069123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/f7JkVfHL643EJ3O1Eknq2OobIgOuuERSYG+cUCRBXY=;
 b=zT39XaoSIsCwy7Br/dzbVOcpNCldA727Se8aj5hLn2cHupnsC+0aP4Kh+zTxl+PSh3
 CzRls10GtbavVA3//+qAceVIaFrb5rceXtACZhcNYuaNINbnO9F9wHHv1xThYnU+h0W/
 YTFxUnfVXjP48aBWuyj1H02Wyi6KdOe1Lmji2wWPjRWl699GdYUXLBQpFEiXHjjQZ+AH
 VJojxaa+VpVCRV+V6XCNQYPiO0jZZGNSJtctqMW5PodLIqCSZ4zGetc2SlUsRYm0ebc+
 s18QbCZ6vJIBxiZ47R8o74ZMzRiNUfSH7qp1c9oOcc/2gA7KpCnmPwEopVY8LqZDVHvC
 t+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464323; x=1692069123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/f7JkVfHL643EJ3O1Eknq2OobIgOuuERSYG+cUCRBXY=;
 b=Cawzz2iXZc8+MogtXUiAXN+N9qh7H+Ehk/avUq/yisoKc1XT9xi61d4M0jtEm6tur6
 i9EszErtm9miefHTOe+BcHW7RDvvtuBpZShk6XAal/wVvXoyo6qxIKy6/kDrCx0KfAGG
 2+qEpLC2HKseJHwPX327KmK+HKYsTNcptAvVUO4udMmSMITmma/TNvepQj8KtxbgRtpT
 oThvrwubS/t1PyxU56pkLJviGSA8qGtruhUU8NTbSRvbiDjtBRLaf2sXP+OHIlX9v25N
 VF+KU7AJkre/FPp37OsESsyRLFHR+yRf9VAvr8WHnbmPDjdgFnbmeA9KZNj5vI8JXTdK
 HaLw==
X-Gm-Message-State: AOJu0YwO8xwVpDTmqIlgF9M2EurMJTXJ3vFQdlEUVTqBUNHpSqoT6PUx
 +loEdPLN7fl3u0R+HX4ZZt+vAhrimy8fCtbhHmI=
X-Google-Smtp-Source: AGHT+IEd8gkruVqwS1OPyOB9qlMAru4MLT/lkjZl3aBrDV6Yb8/gYKx7Mxe+EeBTGsdrYYNwmUHjpw==
X-Received: by 2002:a05:620a:3953:b0:76c:ce1c:930c with SMTP id
 qs19-20020a05620a395300b0076cce1c930cmr12474381qkn.53.1691464323349; 
 Mon, 07 Aug 2023 20:12:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:12:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 21/24] tcg/i386: Use CMP+SBB in tcg_out_setcond
Date: Mon,  7 Aug 2023 20:11:40 -0700
Message-Id: <20230808031143.50925-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
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

Use the carry bit to optimize some forms of setcond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 56549ff2a0..e06ac638b0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1528,6 +1528,56 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
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
+        tcg_out_cmp(s, rexw, arg1, arg2, const_arg2, true);
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
     tcg_out_cmp(s, rexw, arg1, arg2, const_arg2, false);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
-- 
2.34.1


