Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D798738E26
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dk-0000Gj-9M; Wed, 21 Jun 2023 14:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Di-0000GD-3f
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:18 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dg-00072O-GV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51bde6a8c20so907138a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370775; x=1689962775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxKhbZzO27iRv90xsDO7HRmmIvaved/QI7IBjhZqhgU=;
 b=mDf1cev2a4coigy+eTpykUWVclHo++zC3AAf+lJ79m+I5X1pmEy4pzz9fGM7yiyhQo
 X8MZii/RClKo4lu5RMz/Ft7UZ/I6TQJRckpSPLWQnjQsO8jBz2ciQI6jX/NAe3cCLMXi
 74rXgyu76VWoQz9QzMHERK2l2wYM7BeCRbCY9VZ/mP0QMY0ReJp2ZiyOesalzPhRJhX6
 16Z9q3T9e4H2N/Q0yccYW5l8b85ZwLsTQ2qhKBMR6dxHiL205puwl4VgtHyTx0p5NkD1
 1sIiOKLXnHQKf7J6lVOjlhJN2cQH02qUSBQ5yL16ZNImTHEtDoLXEzW7fN4H02fhuA0z
 9bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370775; x=1689962775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxKhbZzO27iRv90xsDO7HRmmIvaved/QI7IBjhZqhgU=;
 b=Dh9CEUtB8c3/hxLYDl9zmL84B4DzkinreETo/UCeGSH3A+EFYyNiCiIBuxHFVxhIg1
 u3XLKWPQzY4k4AEVWEIjM41St79r0XLZLpqkbfObmBkRJr//vUJqrx3PPTDfBynJY8YJ
 9d8DBk4UPqtsAzen/yWmsdqDP/kfzxOQUkMxrndf9PDNBUh05UWDPxbrosTjwD6IPEsG
 hGDvW5iTVk3VboBlOFlSLv38bjlbswyV1mov/0uvLsuBFmL2CA06h5P6IHkDq8xjIbA2
 3lkvU1Bc88SsX/y4/65EjZ8a7oPwlSxtEoQadPgXLYenu0xFg/grj9HOURTxombshuEf
 46nA==
X-Gm-Message-State: AC+VfDwsD9K/ID6Kj2oAkvFpcG9bQfZmEpk1UJPAqYd/ZRySXj8Wr3Yw
 wDsV80o6KRMVzsWwmeTgvdDUnckQd0zfhLsAjAq8V4ON
X-Google-Smtp-Source: ACHHUZ4ryQOG5zKQumCOw3lYwDXvEA30re7GNWwdAtutwfkcFTtoO/VTci7lEKCdnlWTD27/dyRjXQ==
X-Received: by 2002:aa7:cb0c:0:b0:514:8fdd:fc41 with SMTP id
 s12-20020aa7cb0c000000b005148fddfc41mr10117425edt.15.1687370775206; 
 Wed, 21 Jun 2023 11:06:15 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 5/8] target/sparc: Use DYNAMIC_PC_LOOKUP for conditional
 branches
Date: Wed, 21 Jun 2023 20:06:04 +0200
Message-Id: <20230621180607.1516336-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

When resolving JUMP_PC, we know this is for a plain branch
with no other side effects.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d12f2ac423..bd3feed72e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -941,7 +941,7 @@ static void flush_cond(DisasContext *dc)
 {
     if (dc->npc == JUMP_PC) {
         gen_generic_branch(dc);
-        dc->npc = DYNAMIC_PC;
+        dc->npc = DYNAMIC_PC_LOOKUP;
     }
 }
 
@@ -951,7 +951,7 @@ static void save_npc(DisasContext *dc)
         switch (dc->npc) {
         case JUMP_PC:
             gen_generic_branch(dc);
-            dc->npc = DYNAMIC_PC;
+            dc->npc = DYNAMIC_PC_LOOKUP;
             break;
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
@@ -997,7 +997,7 @@ static void gen_mov_pc_npc(DisasContext *dc)
         case JUMP_PC:
             gen_generic_branch(dc);
             tcg_gen_mov_tl(cpu_pc, cpu_npc);
-            dc->pc = DYNAMIC_PC;
+            dc->pc = DYNAMIC_PC_LOOKUP;
             break;
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
-- 
2.34.1


