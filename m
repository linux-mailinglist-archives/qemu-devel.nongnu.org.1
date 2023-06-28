Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E97415F5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXX2-0003NG-Mb; Wed, 28 Jun 2023 11:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXW7-0002jV-Ri
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVx-0001ks-Lv
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fba66f3e1dso476205e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967726; x=1690559726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vy/sCNLymo0yaJK3nrNIdhMXm38eea/3gCI2jakcH7Q=;
 b=qfIRTslf6ZUAkvgnZ+lCnMI2uLKdb85c+ulLpgQR0smCMSIHwT+AdfkWyQBPuE7d3h
 78+WPhiQVifU6AYBW6G/YizWO/F3n6VSVkEsBPZcdmF+OrGFOZWIx1nP6rWtY/f2zo2y
 jhbXSO3KKtEMNtScoWL+G4pwI3nBsNZuRxZk3w6VZWQntkrXNIArPqeokRPmV9EdaE5n
 zu/jV3DRdPeHB3P6VXYTUMjUzSHMFpjIVATU437HVFmysC4bSbQnnIswChPSYJ5v/Yc+
 mu2Mytrat6xHzEZVm6FApZDFApBCccTmu4dlQNZbnWrzBfdK512oSGYoua/9mJaCEWEU
 jALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967726; x=1690559726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vy/sCNLymo0yaJK3nrNIdhMXm38eea/3gCI2jakcH7Q=;
 b=Nu0/MLpMUriOSaQrDzEkbclrU1bt7YPTadzi9Pog9t5gdORQjDVO79NslrvqwXpXtT
 oTpcHfXNbeDycqipwp7znuyJ07GqyNeASTnoz127tbOs2bNLxd9IWJDcmbjc6n2e+TUI
 cE5VoZPHYnPxzybQcG59UZtZ7FPUHnxVgAMXWHZd3+DPvq3LZ66l6XN6W2Cn9wgddWLb
 puCBxZU7qtox6QeqL1w6YXp8rwYcwu4roPyYlkhm2hXVGErm1BDU04u8UUhLn6e1au6n
 ZTgVuk1AThLarbuCOUxBo65uyxD2Hv+HJ5RUS+1agBUwwXJ60EKFgg6qb53oW8LRiUW7
 TpeQ==
X-Gm-Message-State: AC+VfDyUEApb7nA+IRi7yrSDI9PGvbuavWtcepLPKGIOiwO4DVJ5h0BA
 wuSPvc+XNL9V5pKW+mcR2E0OS7sI3sIZRAizrPw=
X-Google-Smtp-Source: ACHHUZ5YoM0JPHsRQ+kRAn+T00tsYXmUR6J3PCdyJ6YDdr/xncpUeYWM/uc3Co5xPmbCLHBULk1fqA==
X-Received: by 2002:a1c:7c0e:0:b0:3f9:b7cc:731 with SMTP id
 x14-20020a1c7c0e000000b003f9b7cc0731mr17598930wmc.15.1687967726479; 
 Wed, 28 Jun 2023 08:55:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a1ccc0b000000b003fa8158135esm14835605wmb.11.2023.06.28.08.55.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 22/30] hw/intc/arm_gic: Rename 'first_cpu' argument
Date: Wed, 28 Jun 2023 17:53:05 +0200
Message-Id: <20230628155313.71594-23-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
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

"hw/core/cpu.h" defines 'first_cpu' as QTAILQ_FIRST_RCU(&cpus).

arm_gic_common_reset_irq_state() calls its second argument
'first_cpu', producing a build failure when "hw/core/cpu.h"
is included:

  hw/intc/arm_gic_common.c:238:68: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
    static inline void arm_gic_common_reset_irq_state(GICState *s, int first_cpu,
                                                                       ^
  include/hw/core/cpu.h:451:26: note: expanded from macro 'first_cpu'
    #define first_cpu        QTAILQ_FIRST_RCU(&cpus)
                             ^

KISS, rename the function argument.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230405160454.97436-5-philmd@linaro.org>
---
 hw/intc/arm_gic_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 9702197856..7c28504ace 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -235,12 +235,12 @@ static void arm_gic_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static inline void arm_gic_common_reset_irq_state(GICState *s, int first_cpu,
+static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,
                                                   int resetprio)
 {
     int i, j;
 
-    for (i = first_cpu; i < first_cpu + s->num_cpu; i++) {
+    for (i = cidx; i < cidx + s->num_cpu; i++) {
         if (s->revision == REV_11MPCORE) {
             s->priority_mask[i] = 0xf0;
         } else {
-- 
2.38.1


