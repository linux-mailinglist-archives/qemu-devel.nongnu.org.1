Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C547736C37
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaio-0001VL-PL; Tue, 20 Jun 2023 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBail-0001SE-7a
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:31 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaii-0001rv-DS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:30 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so6214041e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265063; x=1689857063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Qb+YfsmMaXVy5lDjjPTSWHTsaQ7mtmCSzuA5ibkhpA=;
 b=UQEMplP2p5KYirkiyM45ntIhCFg9BYgsG7M/9fnEjfvPbmm/0Ae2Gh/r51ZGHcfjRE
 1fQ/1MPHGNjvBFYKf3JzTMp9injt+XB4xpIY7iHHhckPg5owRpmWSkRDKSQ80jty58SP
 Ja/ElIXB5naHmQxYBT8tYwW4EjZLTvLkAkv67PGj4w6rvKkL/GSIESt99cSKtKkqwiWQ
 sw4+GEITGGu8n6XVxMOEcT3cglrYnr0smZpYdogkXOKW6kZ4ni4oZmMPAjg5jFOrSt/y
 HMcvfDNLb7dwao+nmvg7KVSadotj32wl6Z2tda7zUWWozsyTKepEcNJZEd+uYsMeWFs1
 moHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265063; x=1689857063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Qb+YfsmMaXVy5lDjjPTSWHTsaQ7mtmCSzuA5ibkhpA=;
 b=VimGz7PJ6xg0rbfbxti4P0B3yTtz5DWlYjLquDawatjj+Gr4oqqNwO48neU6iXvDcz
 IRjt/LgUhLCRrXvKld5naGQ4tHKxlMNqzlIko3CR5Y/54eOeeQzezaZ+jQXVBL8sDhgW
 WBG16wdoU5h+yS5jT9fjRldmPL+AGNyk2GYanckZouD8W6pOqL8mtzMYlA+y6YgrK84/
 JKJ0INCjRBXZnh2xF9/NDMNa1WSTNNp7GV2ul/KqDjpbRH09LGwamKJDth8J3bVouvG8
 PCMGM8iYby2iO3WwxsQcy8I0ILlnOK/JBcxK35VW2PzlEIGtooHR9TJfbbD6CiYaRbfz
 xfzg==
X-Gm-Message-State: AC+VfDwoaUns0ZkX0rnnbmujupNhHoeomBPKY5z0xDX0NpFTuOCpvoV6
 Q7kXMT694RY3SZcjC3tIKFrWr22WQyePR3dgWhzuRmgm
X-Google-Smtp-Source: ACHHUZ5hWauwmt/FYDeDvnLzkZiNpbCYYGOIYck4XlTwKQR9WK2Ekq7C9uCuQwTb+PuvmQq+J9vEVw==
X-Received: by 2002:a19:ab1a:0:b0:4f7:d2af:3ed1 with SMTP id
 u26-20020a19ab1a000000b004f7d2af3ed1mr8113975lfe.42.1687265063522; 
 Tue, 20 Jun 2023 05:44:23 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 03/20] target/arm: SCR_EL3.NS may be RES1
Date: Tue, 20 Jun 2023 14:44:01 +0200
Message-Id: <20230620124418.805717-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

With RME, SEL2 must also be present to support secure state.
The NS bit is RES1 if SEL2 is not present.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d2f0d9226e..9132d4de6a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1855,6 +1855,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         }
         if (cpu_isar_feature(aa64_sel2, cpu)) {
             valid_mask |= SCR_EEL2;
+        } else if (cpu_isar_feature(aa64_rme, cpu)) {
+            /* With RME and without SEL2, NS is RES1 (R_GSWWH, I_DJJQJ). */
+            value |= SCR_NS;
         }
         if (cpu_isar_feature(aa64_mte, cpu)) {
             valid_mask |= SCR_ATA;
-- 
2.34.1


