Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E70C130C8
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Oct 2025 07:02:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcmO-0002Aq-FY; Tue, 28 Oct 2025 02:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcmM-000288-Nl
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:01:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcmK-0005df-F6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:01:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47114a40161so62402065e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631314; x=1762236114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7MgKZFYNv4e6Tb/k+QoGSCvRTnlJxwa/GyB/qCuFpQ=;
 b=KV1EYiJp1g9f/6YPKnBAy7C4Fkts5Lqt8lrD+nR3SQoYcbWkFYO8QvYxGLbDq2aZJF
 vq+XQmZ4VJTZr88aK6TYv+fwqssFiMy2NHL7PGMTFN8HRkuRC2TCSGa7cuChkY8bQFY/
 E+nX/vlHPqVEDMdtGKK4rMrtm/UFkXTpQeAA3KLqFCzd79IRjUHou2s9JvK5EQ5NY1QM
 JCXPBn8zkqlBHV4TJPtquqTTUBPt+ndWtIxfxI13X1muY/YPkthyDtUtjMcZnwPJC0z7
 wEyXOuLxTs+TPpBP273hWUa5MleVT5B5ydREER+ie6C2fyp2BxAdIM3WKWJhU3ZxTN0I
 Px5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631314; x=1762236114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7MgKZFYNv4e6Tb/k+QoGSCvRTnlJxwa/GyB/qCuFpQ=;
 b=KJNaICLKYnSLTZSEie//Hhm9Qsa32VZY2Z2WivYEGF7/6KelbX73TZdl2PowJIKcnT
 I7dYUgWYgCwCsrwkrZinBYcilwWyQS3inOBk4QGuV4urUcGkteP5SA9182KTeWmLe50m
 oDQSbkT8ajGlkM49zLdQGD4Yr1ZuG86FxO2FIjP7s5a+ILUlkwRe3lgu0tT5rrk5rVFM
 QxtvPrq8g6RdkgyRhOOYFZvyRmQO1sfr28Q/HFvFL2dC/kuNX0qDI4L7iYCUGgUw+iWa
 60M0IZw2VkLtoyMBzcDsKLEKvHEinnWQ77p4Ey3AjCKANPe1ZXZqCkZaqBETsdEIQbIO
 0Xwg==
X-Gm-Message-State: AOJu0YxsUckrixBA2N+H5sgNazNSDF9+ooorb1m5pFgM/Lg4MReHgTZe
 9DQnFfpR41SbyWdDlMvXOhPW9jclX7LIjL3AP9jwsNobTBKUayi2AdRnrWUCZnjp9B0we1yS2o3
 GPoIDA2M=
X-Gm-Gg: ASbGncucouXZfmIA2DgfEY7Qu+34YBI90LMXkXi2V/C7ug4Dnmb+J4QGIMjlVm6lOsr
 Z4Bzo1G0tBjf1+AB3pCLnXwJVQW4bWSIWg2n4s+MEgppEEhtveTTswt4/aih5/fn1NA2hJlgq+H
 FBeHwszfyTD5JnZVI4vdsSQL3pEupiPJyDpPLpQUIT0Uf0aFSAwl0jC4dQ9hTK36uoYCcn//h3A
 VFs098ft2RgIsAKs6ArNAlr6TIkhE0olmw253IBSChg4mQygxxEkKAMPEcaS4ATpmbw2E5MFzTv
 uaGuy1vMF7M5GCFoJc6/A58dx9o9oiVzqMCsjwRSetjKnNRtNpHOfIZ0UJCM9T06UZRgp9F+iv5
 CLiK0a6kXSUhtGTM/ZrPp5dzUP0Ptn9ju9DU1fxBi4P2dEif6Ap9fDvmVbCHpjf3f2QRso0xe5m
 zHZkEImZGzW9RSdvNCOWHidjlyzMIJoeBuHuMwAn0rHYugSYgyS+pSyIk=
X-Google-Smtp-Source: AGHT+IFgn08EvjBhheTuphmBUBpmrDoN47Vrk7ZdoVRxwDSRdNnxJ2r5Qt+0rxuKwcfzFW45IKleQw==
X-Received: by 2002:a05:600c:3d98:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-47717dfc5ebmr15621175e9.15.1761631314171; 
 Mon, 27 Oct 2025 23:01:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4cc596sm179237715e9.15.2025.10.27.23.01.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:01:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 27/59] target/arm: Re-use arm_is_psci_call() in HVF
Date: Tue, 28 Oct 2025 06:42:03 +0100
Message-ID: <20251028054238.14949-28-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Re-use arm_is_psci_call() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 26bafee259e..a3bb71e63b9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1934,7 +1934,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -1947,7 +1947,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_SMC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.51.0


