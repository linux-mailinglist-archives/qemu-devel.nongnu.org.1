Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40282ACE0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssf-0001Yz-Rw; Thu, 11 Jan 2024 06:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssC-0001Nz-IS
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssA-0004Sa-TJ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:20 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cd7e429429so17883681fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971117; x=1705575917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n1Q0rBlTI4KTEcEVYGkY0PBLOWaSrPIhGDZkzdWHU84=;
 b=lGTuMJfgedwizsAFf6wAW82Yt2d1uEa/UIBcP47QGKDH2esH1CwvE2zJ8o90tav3gL
 HpP0/v8Q5m3pnOHGw9aiSrAq9hR5DOCzBrUfSX9FeHrM278fwV+bMnKyn7RZTG4cHkrT
 Bs2UZpFNBEiMm/yHTMuG0map5xjwx9i1znQjpZ+mkA0VD6LH6VRnHMRtPh9OcZGtWN62
 fT5VrnJgEF/16ioXOy2C2CmA9Sso6MMtBTHAoARJOICvWiC5xlWlvYT4FTYW+ipwlIi0
 Qtm2VP1eWwN4/sOB/Pocb8nH8YOtLcR0rl4u33qT+NUtEa7rQLaJyEvyoi8Lfq7G/ZuX
 9uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971117; x=1705575917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1Q0rBlTI4KTEcEVYGkY0PBLOWaSrPIhGDZkzdWHU84=;
 b=uCAiiyrzqF1oViQVFFlkXEd0GMExcIq8+gNQMkphf7BWqwtPkq+4q8l3ON/kyylJ56
 7mLsLHIy2ehigDwwH13LcqjmmWVt5yQ7ZSo+TMRk3BtAskh5i0xB68nUOZ/tWGLi/tk4
 Sh+cu85Ewwe4qSu1h9zkoJFJhE8evAYbFBznvweI9rHBu5jhdcLppbbhrV8Ja/LxXeyW
 ZikhEP7la+sEC04oQGc+m+msALbsOrVZkKllzmE5OelE1mFrPU/x/71ZoBSCDiT/egST
 CpkMoT8tlVBPxMtcpb57WQvA7xkh3tIOkjSVFPCRyYNZx+kQMrlXXoYXqO4tcW/cBf8T
 aKxg==
X-Gm-Message-State: AOJu0Yz2uwwWqiNwaAZuo8ptsqsx1rpLULeJ7/knuqZWkZFK4sN49BnQ
 b3jduhC97F2JKKfWgaa9Juf+Lv9AE2wkshgQg+4T+IWjoCA=
X-Google-Smtp-Source: AGHT+IGaSk503QUAVyOioAqDSIHXTGcB56JV7T6CjrHCkwoiiTZ2cKnSg4Cddt3leb0a3v/lHDAw3A==
X-Received: by 2002:a2e:7a01:0:b0:2cc:2025:5bd5 with SMTP id
 v1-20020a2e7a01000000b002cc20255bd5mr290988ljc.51.1704971117059; 
 Thu, 11 Jan 2024 03:05:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] target/arm: Don't honour PSTATE.PAN when HCR_EL2.{NV,
 NV1} == {1, 1}
Date: Thu, 11 Jan 2024 11:04:48 +0000
Message-Id: <20240111110505.1563291-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

For FEAT_NV, when HCR_EL2.{NV,NV1} is {1,1} PAN is always disabled
even when the PSTATE.PAN bit is set. Implement this by having
arm_pan_enabled() return false in this situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1db2effb1c0..24751e05b24 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -266,6 +266,9 @@ void init_cpreg_list(ARMCPU *cpu)
 static bool arm_pan_enabled(CPUARMState *env)
 {
     if (is_a64(env)) {
+        if ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1)) {
+            return false;
+        }
         return env->pstate & PSTATE_PAN;
     } else {
         return env->uncached_cpsr & CPSR_PAN;
-- 
2.34.1


