Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8CC711349
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQJ-0008Pc-Tw; Thu, 25 May 2023 14:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQG-0008Nu-CJ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQE-0005t8-JO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso66029b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038245; x=1687630245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hePU+jHoG6kbWcw7O0XVS7iVuAJda7LKF/UytOuYzmY=;
 b=BsstyhHCniZz6TbuzNW+mM8wqS/4qEPzQb0vi2uIV8dNbc2mfdHC0KSuq3HhjA6B3o
 MwXWDZEmxPLwyzlaid4YUMRhWy+1AOOJ0y0Sgz0GxSWe4c4YWaQRgcTQX5f9xWsrn7pv
 QRFBPu5mU/oG3I/nbhh2L//KVAWOtmwkHsAvnA994s53lOUHFhXB4ykjhBU89GrmC15i
 m3O9d1QqlsroxckXbFAw6Yz6Deu9boHJ6pF1zhTM68pPeZl16cByC9HBQdLLqalY+/UA
 uocv3c7T3UJg4HVyGMnjMzLJlkzk9Mu+YG+fvtHTDBjI3zO8WsitIWU1OcVk6U0Coqnv
 nC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038245; x=1687630245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hePU+jHoG6kbWcw7O0XVS7iVuAJda7LKF/UytOuYzmY=;
 b=S/LC+TQDsYO008ynfnLVDBpRYW3TDBuAhO5GrNo1ikasX6EXg7EhKPkOVC20Qx8OnJ
 ZvepcAqN3VIFB+aO+K8xaVVYq8HyI64mf8+rDOJyIOSkeua2RevcW3XPA7O9PWUZE9Un
 hj3O5zLa2YQ0oyw63kUqZ/8ohoVr37K82V+C+TDrf4Hhm6ZWvzOhnLY6oOHpDNsAsynL
 vRGE9Wm+6P5iSawNUVEq0nTQ5iXhRBUbPMp9n8SEImThFvw/w9Vi5zgbW1DqFQI5PXqW
 GqR8A4kiH000i1qklxM+QiFi2Jn+u52goTtZSufLmeHJxV3UG6+EH5c/yGMNgN4yjnh4
 uw4Q==
X-Gm-Message-State: AC+VfDyypr1TemgWzSBlP4xEPnIomE9N9XEPJmX8Dj6E77ktIZnqnhlR
 9fOfnytCiJbA++oXy0rM++hT06tLPBI98pvjer4=
X-Google-Smtp-Source: ACHHUZ4b/i8fM6BxdrVYIifcto4tEVemUKGs22gAOM/RLoXcbFln2u+Uxc7iCrWRcnPumlbUMt7jbA==
X-Received: by 2002:a05:6a20:a12a:b0:104:b7b4:e044 with SMTP id
 q42-20020a056a20a12a00b00104b7b4e044mr22471041pzk.48.1685038245320; 
 Thu, 25 May 2023 11:10:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/23] tcg/mips: Try tb-relative addresses in tcg_out_movi
Date: Thu, 25 May 2023 11:10:22 -0700
Message-Id: <20230525181036.1559435-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

These addresses are often loaded by the qemu_ld/st slow path,
for loading the retaddr value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 068deab8c9..9fab424ecc 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -568,6 +568,8 @@ static void tcg_out_movi_pool(TCGContext *s, TCGReg ret,
 static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
                              tcg_target_long arg, TCGReg tbreg)
 {
+    tcg_target_long tmp;
+
     if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
     }
@@ -578,6 +580,17 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
     assert(TCG_TARGET_REG_BITS == 64);
 
+    /* Load addresses within 2GB of TB with 1 or 3 insns. */
+    tmp = tcg_tbrel_diff(s, (void *)arg);
+    if (tmp == (int16_t)tmp) {
+        tcg_out_opc_imm(s, OPC_DADDIU, ret, tbreg, tmp);
+        return;
+    }
+    if (tcg_out_movi_two(s, ret, tmp)) {
+        tcg_out_opc_reg(s, OPC_DADDU, ret, ret, tbreg);
+        return;
+    }
+
     /* Otherwise, put 64-bit constants into the constant pool. */
     tcg_out_movi_pool(s, ret, arg, tbreg);
 }
-- 
2.34.1


