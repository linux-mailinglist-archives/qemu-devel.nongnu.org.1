Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CB7D3EDA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRE-0005if-7l; Mon, 23 Oct 2023 14:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR3-0005bo-98
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR1-0008Fy-Hc
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso2742232b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084830; x=1698689630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gscgf9TaNURfjEVsbC8XIQGIbXkPOrKC3iA1FwA6PsE=;
 b=Um4GTz+kCDi3H0tlkAzuVnTq87askO17lX831qVy23K3DUonU4YnGTxDrb+L0Pe2gL
 HYkqVNWXHqCAeRgSjPLq+2pWx9Z2QK4yZaqgYnBYHTelZU8ujQwAPDft4/QLqvKcoubS
 6B/NYuRQd70JY8/uwQyJ85AaM7LPwUbdZ6uClUFUsXenIjIL1jaZDRHACXF1qEtj6AVd
 p2em5Dk6jGv4qFJFNkGZRCBMtMja3UL/JiQrLxFH8Z2VHLCa6/y8y/r2J7PBofF2Ct7X
 AlSXCJvI0WxgcyPQlkVrEAnUp1D0XIED1UdJSkJ+Bv5N5bXLO5sU+HhuUiX9/uvVE7IB
 aRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084830; x=1698689630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gscgf9TaNURfjEVsbC8XIQGIbXkPOrKC3iA1FwA6PsE=;
 b=JRTXwumfb6cQimjYqDmk6/qihh9vo/lUyV3Yf2USZO4Y87l+KkQ1qiJ7KC5Ck4u3uE
 GbRMwh7OQGSqS5OpX8vC412asao3VrFWiSNbFcAcUMhbHVoGbCIYzqjIQw6TET4+2zvw
 dxwndl3q8sKNzHrgBGk38jErEznNOpKFxH6hvfZ5r1fgDDhQUnR2heqzwSHyEMRiUsoM
 s4JB2Qj6j/Gj134atQGpwYgdu7M6DRX6ypT1mEmpJR8zQmk0aL/2Tj+TVJjq86K0zrs0
 CBBYMog+6Vhq6vMddlvT7SwdRpU2jYv/7Jfq2tK/UGNIpGeT5Lr9AgBTs2UMvg1wpkRS
 JyIA==
X-Gm-Message-State: AOJu0YxyCjBnVUbyEXsSeVEgX8vJjb/TtVWWTaHOUhaqRCSx4fzADj4N
 jRLvnDvetsbeQfrkmgxe6EXXj5z1Ytf3WGa23GA=
X-Google-Smtp-Source: AGHT+IEb2uk8dn/hWM7uMkAF42GOpUmouupkz1CnMdL2TNrYA+OQ9h7hSLRK/+B+6mwRgZwYTqrzVg==
X-Received: by 2002:a62:f245:0:b0:6bd:b4f1:49e8 with SMTP id
 y5-20020a62f245000000b006bdb4f149e8mr6922428pfl.2.1698084830348; 
 Mon, 23 Oct 2023 11:13:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 22/38] tcg/riscv: Do not reserve TCG_GUEST_BASE_REG for
 guest_base zero
Date: Mon, 23 Oct 2023 11:13:13 -0700
Message-Id: <20231023181329.171490-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Fixes: 92c041c59b ("tcg/riscv: Add the prologue generation and register the JIT")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d6dbcaf3cb..dc71f829d1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2076,8 +2076,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
 
 #if !defined(CONFIG_SOFTMMU)
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
-    tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    if (guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    }
 #endif
 
     /* Call generated code */
-- 
2.34.1


