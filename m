Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9647CFB4D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCn-0003Y2-9j; Thu, 19 Oct 2023 09:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBx-000246-DM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBt-0001F1-6k
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso5191148f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722549; x=1698327349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ZO8XemeV6MKZJes6/JMerENEJvAmmFZYOx50CoERRE=;
 b=l9IWPIs6XvPiDF938nzefTqci2yWJcHuj8ZlLqFXVID0Uhh9M3ufj17+E7/Iwzd+cq
 wiWZ7OwKHFhj7So6if4gtxiKTS1TDzWnORMt7G6Xm3hULrTa8MDhNzASw5prC+woKmr/
 vQqXrSoOf6oNn4auETZcS9JAQt7d/bijzlygkY/CBgU0MiS1xhaIFC8JPDwZYt5cnBM7
 +18pihWOSMugRlSjl1Wu3CsjceTGGwNnaHjvCNgXVnGO1sM29jWbyadPdv0iX77s5bSf
 5epPQPLOFU6pwtQFXFI8SJUKLoQR64PLsZBQ/WWP6+WnE6+kSlrbG2HVMth51vjxKdJ+
 W1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722549; x=1698327349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZO8XemeV6MKZJes6/JMerENEJvAmmFZYOx50CoERRE=;
 b=fLV3nUoimuR0nN16F1Qntv8/92Ij2ZVtGM+R3KVYAQfs6LUAHNs1R8kGvt1iaGP3HL
 gsP0oVAiOIt5LdxgLl4QVi7Ue7UWW8vrkVT1H+02RAEWPfmnVNugvS2y6A2LQTyp5EQX
 pvOwBvSj5HZ4d1PmDTuJY0hDGKaL1XKXJHfBEjasbb6wVIM96gfNMATcPE04I12NDxTF
 442GEierE/a81QTOLSWaZs/EHvoAu+B5soYZV12MiA2AvOlyrIiCcuWYX+JZoZmaH0Dn
 QMoATqGaOvtWBlopUo8Bfi0DG83oJsye+SP1iJPDVzhADugPHzK256owf04y1DgAhXrS
 DQIg==
X-Gm-Message-State: AOJu0Yypum+/Ua0EqcDyu6o2fI01/WsShUuPASRXy87Z7mDxWLp7jeOA
 w0DLla4saEuonqip42Wm2+FobbljDO7H+WrHB2E=
X-Google-Smtp-Source: AGHT+IEGVG4LUYSc77H6OlgR5goEfizL4O1IJNEGr3ZVegPvpi+jgDnFQtuQ3BtuqkyiXFunp0QNcQ==
X-Received: by 2002:a05:6000:b92:b0:309:1532:8287 with SMTP id
 dl18-20020a0560000b9200b0030915328287mr1507404wrb.19.1697722549524; 
 Thu, 19 Oct 2023 06:35:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] hw/timer/npcm7xx_timer: Prevent timer from counting down
 past zero
Date: Thu, 19 Oct 2023 14:35:36 +0100
Message-Id: <20231019133537.2114929-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Chris Rauer <crauer@google.com>

The counter register is only 24-bits and counts down.  If the timer is
running but the qtimer to reset it hasn't fired off yet, there is a chance
the regster read can return an invalid result.

Signed-off-by: Chris Rauer <crauer@google.com>
Message-id: 20230922181411.2697135-1-crauer@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/npcm7xx_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 32f5e021f85..a8bd93aeb2c 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -138,6 +138,9 @@ static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTimer *t, uint32_t count)
 /* Convert a time interval in nanoseconds to a timer cycle count. */
 static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
 {
+    if (ns < 0) {
+        return 0;
+    }
     return clock_ns_to_ticks(t->ctrl->clock, ns) /
         npcm7xx_tcsr_prescaler(t->tcsr);
 }
-- 
2.34.1


