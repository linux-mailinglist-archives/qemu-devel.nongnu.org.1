Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B715F74AFE5
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHji9-0004fN-7T; Fri, 07 Jul 2023 07:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji5-0004N7-Nc; Fri, 07 Jul 2023 07:33:13 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHji2-0006qC-Iz; Fri, 07 Jul 2023 07:33:13 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b06da65bdbso1656575fac.1; 
 Fri, 07 Jul 2023 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729582; x=1691321582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKJ3O0O2Vv4yXcQhqJAnFubhCWRrq84OrzaoroTx/MQ=;
 b=BzaWz1b3Gb3XtnwngBQhUClHBC3P5cE0BPLZgTKuL7CjS1M6Uf2zwvR/s+d81FmnDu
 wSluz7pPoRk0xI6ctDvE/qnI7s1DrT9r6lsDym0qSybdbXkd/fjynWwZ7mksgLLxVbVu
 OU7LS7qpd+EzrAo/dH6CPj2JyS4BjynykEB03tUSAtMamJhULpdS8eHkPlAntLBztVX5
 uHyupemGH7zzfb0dyYEy4EK2u5iLB3Q240V9LNPuUhWaJ8TlvGQxeLn2PEyMBvfyO7y2
 rPGxqtWNydBwe7/D2K2aNzqGCN8XYB3UxPPyZzeetwnQiQRHh1bHDLdEqfQd06WsyFLU
 NYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729582; x=1691321582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKJ3O0O2Vv4yXcQhqJAnFubhCWRrq84OrzaoroTx/MQ=;
 b=BMssSj2/zs8HbfCAFbQEfJvvG0c16afxY0NjU39tmBuM097tKk7uHFJkLXaHaJ5D7E
 xjljOt24RFuKkrS+ts2zlW7E6gTYtmTbqsxj2KUuYlN/tUKc+gmLWy2vTv2Z1dULw0cc
 ivoiIdf5hX34THAbzQ+LmffAFx4YzUxSxE/mltdiL4+9vXNiNwQuDtLm2CjC5CeCGD9a
 HeD+aOWYT2oa/s2C/wQJPtc7dM/6t1+FM4ZRlmEJ+/iIbusw3ba/5I7/L/wKaAfPtUS9
 vGeejAGNGwK8aygIQBIxzYBZZ5VOOuzUmxqjgIMuZ/a0X3ohJDOECQJ4Ju7N9EJeFdfP
 mjJA==
X-Gm-Message-State: ABy/qLY4m/YM1DKnDQuO5WHtrdyX2Zmu7gSp4BvU2+nHoshGS/1PseD/
 DQdwyXFDWXmR0C5iLcWm9hpdWkAGi8E=
X-Google-Smtp-Source: APBJJlFc/GflzoylRo3pV/COQB1A0aVAWenEANou04e7oud+fe6MV9QPZ4zRe3Xd5Hn4NH2l0NhSkg==
X-Received: by 2002:a05:6870:1fc9:b0:1ad:e92:62e1 with SMTP id
 gp9-20020a0568701fc900b001ad0e9262e1mr5480322oac.54.1688729582170; 
 Fri, 07 Jul 2023 04:33:02 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:01 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/60] ppc440: Rename local variable in dcr_read_pcie()
Date: Fri,  7 Jul 2023 08:30:47 -0300
Message-ID: <20230707113108.7145-40-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Rename local variable storing state struct in dcr_read_pcie() for
brevity and consistency with other functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <7b6f0033ada74075fc094b1397deb406e1a05741.1688586835.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_uc.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 22c74839ae..5724db2702 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -828,78 +828,78 @@ enum {
 
 static uint32_t dcr_read_pcie(void *opaque, int dcrn)
 {
-    PPC460EXPCIEState *state = opaque;
+    PPC460EXPCIEState *s = opaque;
     uint32_t ret = 0;
 
-    switch (dcrn - state->dcrn_base) {
+    switch (dcrn - s->dcrn_base) {
     case PEGPL_CFGBAH:
-        ret = state->cfg_base >> 32;
+        ret = s->cfg_base >> 32;
         break;
     case PEGPL_CFGBAL:
-        ret = state->cfg_base;
+        ret = s->cfg_base;
         break;
     case PEGPL_CFGMSK:
-        ret = state->cfg_mask;
+        ret = s->cfg_mask;
         break;
     case PEGPL_MSGBAH:
-        ret = state->msg_base >> 32;
+        ret = s->msg_base >> 32;
         break;
     case PEGPL_MSGBAL:
-        ret = state->msg_base;
+        ret = s->msg_base;
         break;
     case PEGPL_MSGMSK:
-        ret = state->msg_mask;
+        ret = s->msg_mask;
         break;
     case PEGPL_OMR1BAH:
-        ret = state->omr1_base >> 32;
+        ret = s->omr1_base >> 32;
         break;
     case PEGPL_OMR1BAL:
-        ret = state->omr1_base;
+        ret = s->omr1_base;
         break;
     case PEGPL_OMR1MSKH:
-        ret = state->omr1_mask >> 32;
+        ret = s->omr1_mask >> 32;
         break;
     case PEGPL_OMR1MSKL:
-        ret = state->omr1_mask;
+        ret = s->omr1_mask;
         break;
     case PEGPL_OMR2BAH:
-        ret = state->omr2_base >> 32;
+        ret = s->omr2_base >> 32;
         break;
     case PEGPL_OMR2BAL:
-        ret = state->omr2_base;
+        ret = s->omr2_base;
         break;
     case PEGPL_OMR2MSKH:
-        ret = state->omr2_mask >> 32;
+        ret = s->omr2_mask >> 32;
         break;
     case PEGPL_OMR2MSKL:
-        ret = state->omr3_mask;
+        ret = s->omr3_mask;
         break;
     case PEGPL_OMR3BAH:
-        ret = state->omr3_base >> 32;
+        ret = s->omr3_base >> 32;
         break;
     case PEGPL_OMR3BAL:
-        ret = state->omr3_base;
+        ret = s->omr3_base;
         break;
     case PEGPL_OMR3MSKH:
-        ret = state->omr3_mask >> 32;
+        ret = s->omr3_mask >> 32;
         break;
     case PEGPL_OMR3MSKL:
-        ret = state->omr3_mask;
+        ret = s->omr3_mask;
         break;
     case PEGPL_REGBAH:
-        ret = state->reg_base >> 32;
+        ret = s->reg_base >> 32;
         break;
     case PEGPL_REGBAL:
-        ret = state->reg_base;
+        ret = s->reg_base;
         break;
     case PEGPL_REGMSK:
-        ret = state->reg_mask;
+        ret = s->reg_mask;
         break;
     case PEGPL_SPECIAL:
-        ret = state->special;
+        ret = s->special;
         break;
     case PEGPL_CFG:
-        ret = state->cfg;
+        ret = s->cfg;
         break;
     }
 
-- 
2.41.0


