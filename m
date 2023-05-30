Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFF7161CA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNY-0007Kc-2X; Tue, 30 May 2023 09:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zN0-0005ig-8J
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0001S1-PY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso47105055e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453191; x=1688045191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ng68ymVqBP06hFfEqSskwZ53MESSCqTSZAtBsG/ccVw=;
 b=JoWxSQD3gvC/skjMWBgoWxati09seeXs2nj8SwY+Ub6dNVRNd0dhGipNskUKE/OigD
 2/mWTEzuJnwpZSCo6sb53s2SqlNc+1FYl6vG5qKwlj2YtlW8RhMnW8sxKT3t5hSCqk9h
 1WYoUebcnREX7+Zz0fWF4ESKTfawj1hmZ+Waat9BT6/XJ2+ewHcWfeWXeRlWEhyhU+Oe
 ubRYbKmuHYfI2/RLmiCLc6x21FTBG4OHhStBxpsimorNc2rrTnWmReaOtZ7R/y5s5bYu
 If4OP6mmzm/NNjKYuPYoJa8Op5sxt3b116whe84MreJtkMz+qp4Io+9gQKOxyRxAEgOy
 xkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453191; x=1688045191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ng68ymVqBP06hFfEqSskwZ53MESSCqTSZAtBsG/ccVw=;
 b=aNz93hdoo6A0/TBxBuLRPcC5jUEA9NgFKTdWsfWvdVuULf4csW/GN8y33kK+P3JTr+
 wxsigBsyBvd7sOpie0gFrF+cYA/zYr5aslUq+bhdcjCdT0JXgbpY6zE35x0gQfY4ooed
 9V6AhmelrOyTiKYYJTXERc2oJD6VpeO9SqfvsLW1aa7Dd1HOU41clfnw5oSHoEHC0F7R
 in0ZL5Mz/kGm4qHCw/vE742QaBX7CUs20ADGpo0mYY5092qb3xbU3V/VKoVXXreDSi7B
 +QrFHP2Uh3wE2+1DiEIYZR3zzx/CE9WqKSbWiZ5CX9YUdGuevTkP3NUI3kIHCKL+lXUa
 rDTA==
X-Gm-Message-State: AC+VfDxBFbkz3Ha6LSv1IB2PgaO623H2c7sVQcw8xgrKvC+9iXHtRVtd
 0vBC+CKP/zNGA1s29DCXDTFdzsEaciGpZJILlO0=
X-Google-Smtp-Source: ACHHUZ5RnUM9rSC46PZ7kDjO8j9cBFUao+qrufYHqjfMioIt6pm0H+33WlGKhydeKzRizW6VMtFrOg==
X-Received: by 2002:a7b:c442:0:b0:3f6:4c4:d0ce with SMTP id
 l2-20020a7bc442000000b003f604c4d0cemr1736731wmi.8.1685453191212; 
 Tue, 30 May 2023 06:26:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] docs: sbsa: correct graphics card name
Date: Tue, 30 May 2023 14:26:20 +0100
Message-Id: <20230530132620.1583658-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

We moved from VGA to Bochs to have PCIe card.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sbsa.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index b499d7e9272..016776aed82 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -27,6 +27,6 @@ The sbsa-ref board supports:
   - System bus EHCI controller
   - CDROM and hard disc on AHCI bus
   - E1000E ethernet card on PCIe bus
-  - VGA display adaptor on PCIe bus
+  - Bochs display adapter on PCIe bus
   - A generic SBSA watchdog device
 
-- 
2.34.1


