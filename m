Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C357C8C1A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:11:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLg9-00012Z-CR; Fri, 13 Oct 2023 13:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg6-00011j-JC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg5-0005Wj-1a
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so438315b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217020; x=1697821820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BGO0/K3CdguLDzJsds4aGoMbgLTr4W7qQjeN+mh4IQ=;
 b=DA7EwFWvPTveAT8EjFkH4HFwsz15k7mWS8M+VkXfqNi0B+kgH8S0EXhmit33a1KM5D
 vKRH5lALYeiT7x+6gskgmz9TNR03kBETF4ULNyM3HcwNK37TL2GGA59xnjI2DaRuQPVi
 28aQuLRRq8DpKJYb8wuoJ74HZwx3p9HASzmpwK4SIEuTd2LRwsc5xdhacdkMgqHU4cw9
 H1Gx0CTOYOdI1lDn4gD27KcaqDNEelgNKgxNHL0MFvKgyoo2hOy1g5KjgOe4P7cUGX8R
 pWHR5PL2dK5cAI5KJJz5Fh7CTMpjBb8lZCc6XK/HkJ1XjD3byZisZLiUBoqTzby4NhVp
 7HeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217020; x=1697821820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BGO0/K3CdguLDzJsds4aGoMbgLTr4W7qQjeN+mh4IQ=;
 b=KKRkon8aEx23hHfOBVX4DdagjaT2QMF8CefVxGBZ7x5gyRZcF9Kxx1GEc3EY4N4N4u
 LkHtUsO23rLe7z50vrq029f6v/8sdwebrFFt6pFW6kJcHT5ZYxhBsYWPC/5RXlo18JO1
 0MMXSeZx+nAs++jio74A+xabrBQEQBL8pYADF9szUHu8fB/13uzbO9Pj2LB71AbLd62p
 wEpL4gnoAXZIIpdcECaiCAeD+oYNkM3UKcIOvPj3mpDKpIaMBJ6XpIdWLZj1eiRUPgZ3
 YPouF7snUg0XTx7vFqyMu8xYCxWX8Zh/Cq4gOyU/cisb2OKqIfO/2daLP42dycEET9LE
 EDjg==
X-Gm-Message-State: AOJu0YzY56A6GYrAQUoHK3xbe8n1VohF3erynAa/z/LdbG3sqLb7M994
 eKYSAVqbpYB0r3qMlhNgtyIpeif9/Pv3wlRNbi4=
X-Google-Smtp-Source: AGHT+IGVlXFVSfriWgX/PCNRaN3C6Tio+4Ho84HlHCoaIcZ/UeAEAdEeUyjg6LuxgnsNQyDXz0iv3g==
X-Received: by 2002:a05:6a00:9392:b0:6b8:69fa:a11 with SMTP id
 ka18-20020a056a00939200b006b869fa0a11mr252839pfb.12.1697217019756; 
 Fri, 13 Oct 2023 10:10:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 06/13] tcg/ppc: Use ADDPCIS for the constant pool
Date: Fri, 13 Oct 2023 10:10:05 -0700
Message-Id: <20231013171012.122980-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 226b5598ac..720f92ff33 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1081,6 +1081,12 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
+    if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP2, 0);
+        new_pool_label(s, arg, R_PPC_REL14, s->code_ptr, 0);
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TMP2, 0));
+        return;
+    }
 
     tmp = arg >> 31 >> 1;
     tcg_out_movi(s, TCG_TYPE_I32, ret, tmp);
@@ -1138,6 +1144,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_00) {
+        tcg_out_addpcis(s, TCG_REG_TMP1, 0);
+        rel = R_PPC_REL14;
+        add = 0;
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -1164,6 +1174,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, 0, 0));
         load_insn |= RA(TCG_REG_TB);
+    } else if (have_isa_3_00) {
+        tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
     } else {
         tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, 0, 0));
         tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, TCG_REG_TMP1, 0));
-- 
2.34.1


