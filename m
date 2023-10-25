Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3A7D62E1
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIf-0000JP-Qg; Wed, 25 Oct 2023 03:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIe-0000IS-86
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIb-0004iR-AT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so35212195ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218848; x=1698823648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+t3wVy/FdNCvxU+M502QkXc3hNFmFswkh6xHioaLL8=;
 b=bHde3aHTOCa3haLP/BOAgb6EcO0WAnStlYunKJJiUUnF8H0fpsPfRpqpErC4XjV4vb
 NHVOE7sunCR4KNOeryaQ0lcNBQ8uaR6ZkTNyVRdm9yoFb8n2MnbdC5m/K+dldcju19wF
 Oy041UDiPNJxoF/1t0+CRBaag1slEBoxXLmg6M+YEYPEAveXnciCTDRykQlojm5UBIEP
 1Omkq+Xw7TPxZWjU3nrhtukmbVR+BhVpY1XxGaTj+BJbECmn9gfoiMvgyKrNDPaDrB3c
 RkRO9aHtiG1R+aRjss67RDAhLQ4rBeeh/OH2vlADLt3t/VWvSaZiVLS7rPeIs6VpMuSl
 7EdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218848; x=1698823648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+t3wVy/FdNCvxU+M502QkXc3hNFmFswkh6xHioaLL8=;
 b=mzXnh3CRpWj1YmZoNynn17AI/sRe9xBtMqTmEhe1hS49x5ry6/2lEiO4w9Y242InKG
 AFWRl3MqwfaVLE/gWIS2buaCd1ta5s9jMlhlNICapoFEZZEI6psFdxbbRl0sZmx37dvm
 yK+kyAW2GOZffA9Uf7ch1alKt/Zdf0u3zAnxBBtDESDX4kgHtVJMpfje5FvE6I8shfqv
 XfrLY+PP+gIn/Mt+vG9VPurys+sdFE7muz5SH/DKAVK5zQXGqb9fWcXkVqsPo2e+9Jeg
 j/NW7ne3I7Vib+L/oVkFCfUJxLQcRXU7q/JMULXuHquwZQG0s747fbYmHMRK59UpDP+5
 kWew==
X-Gm-Message-State: AOJu0YwRQ7NMAR4UcxnqUsqov5ALuldv6/wSQQq74fQ9gwagtgKFK0ih
 tnXwYehJ3Qa3RzJswfAMkswaKq06r7yz01ZbfFY=
X-Google-Smtp-Source: AGHT+IEQ6P8rY9/p2GKKqnWIaGtFCQe2GjGt6bslZaNQ9ZroHbrbGsEa82Q7FY0mbxaJArLDHNZSYA==
X-Received: by 2002:a17:902:ea0f:b0:1c8:9bc6:2a09 with SMTP id
 s15-20020a170902ea0f00b001c89bc62a09mr14134842plg.15.1698218848144; 
 Wed, 25 Oct 2023 00:27:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 20/29] tcg/sparc64: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:58 -0700
Message-Id: <20231025072707.833943-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e958e3c242..feeb318c39 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -606,9 +606,11 @@ static void tcg_out_div32(TCGContext *s, TCGReg rd, TCGReg rs1,
                    uns ? ARITH_UDIV : ARITH_SDIV);
 }
 
-static const uint8_t tcg_cond_to_bcond[] = {
+static const uint8_t tcg_cond_to_bcond[16] = {
     [TCG_COND_EQ] = COND_E,
     [TCG_COND_NE] = COND_NE,
+    [TCG_COND_TSTEQ] = COND_E,
+    [TCG_COND_TSTNE] = COND_NE,
     [TCG_COND_LT] = COND_L,
     [TCG_COND_GE] = COND_GE,
     [TCG_COND_LE] = COND_LE,
@@ -648,7 +650,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
 static void tcg_out_cmp(TCGContext *s, TCGCond cond,
                         TCGReg c1, int32_t c2, int c2const)
 {
-    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
+    tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const,
+                   is_tst_cond(cond) ? ARITH_ANDCC : ARITH_SUBCC);
 }
 
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -743,6 +746,15 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         cond = (cond == TCG_COND_EQ ? TCG_COND_GEU : TCG_COND_LTU);
 	break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Transform to inequality vs zero.  */
+        tcg_out_arithc(s, TCG_REG_T1, c1, c2, c2const, ARITH_AND);
+        c1 = TCG_REG_G0;
+        c2 = TCG_REG_T1, c2const = 0;
+        cond = (cond == TCG_COND_TSTEQ ? TCG_COND_GEU : TCG_COND_LTU);
+	break;
+
     case TCG_COND_GTU:
     case TCG_COND_LEU:
         /* If we don't need to load a constant into a register, we can
-- 
2.34.1


