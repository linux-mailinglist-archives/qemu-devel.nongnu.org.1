Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA1A3E07A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 17:23:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JW-0007Xo-IU; Thu, 20 Feb 2025 11:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JS-0007Gw-ID
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JQ-0008Gv-P3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:10 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a823036so11319565e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068527; x=1740673327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dshLc6Qy+PdOEv7Qd55JPDsQWfVhJcU8v+fR8N/n2Os=;
 b=l/aytEkbowxQn0SYUqUQhDVdsnWRXofxlyjros7zmqY4olWAxbQ4RDDlZn4HnzS8tZ
 M6H9awbMFWYXFLtYmUptOtTUK6UYBjTktrlFwh6b1BwplHPVYz/Dom8suEHZdDtVG2zQ
 dESmz9PpJPfH5YCCB40ebetNLcyfy8BlknSbcqZ7mu+FPTbRBIPSeE/RAw1LGLbngyLE
 du/RA3buY87Or87Ik0jFdoUxhrcPGqu3Rwb2AfJeDt2tWw166mxWL35BAwYf3bOPPPz2
 yzd8oQNyLg5aAls8YzSrdhNMvfAEKQYLVsjeY7IElU83eO6rjptiuaGMn1V6nMUws2U3
 znjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068527; x=1740673327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dshLc6Qy+PdOEv7Qd55JPDsQWfVhJcU8v+fR8N/n2Os=;
 b=FSb9XWJG5gAx3sQgEbP0kt4vjKuQme7pWux9PcGYNZNn8Ngeksb1LRDSMZ4aprHc2d
 rFhK7n4q72u8S7lmmtKzmr24lgjt+Y7Hxth9SgaqdrdaPaDIRevzJlC3Z6Bht4NLBwJP
 JlDnVi7QleGEd8baptzYJ0+dheok4sgjtZgrmV4T536Po5Myl4MTNUsJiL4RemeIFuhq
 ot2b7+XqFprYLeo0JjyqSkWZlnHyOfONeQTo4HcrwnI8/HDZZN2o8n6tfbdxoItxGpEH
 xNC1XA4zvNE/80HioxQ88EGS8q+rhvy2ObXetOGYiPLppJkvhGqhYXslNN2DPEdHf7eD
 BteQ==
X-Gm-Message-State: AOJu0Yw2rskuowGPQGQyBJJiXRmarfolWrNLnZ9qk47joEFQ6C6v5gcH
 yTizDJVXX8Wf47dcuj3eV8y3drAes6xU/sWy+Pb5ZT1lLHIxviDfE3O9wYP21e4oSizUL6KZBAj
 C
X-Gm-Gg: ASbGncuAibJnJJHSsXBuycUYwkby74AgGXYT/aCLg+Emk2BSn9ko/Dboew6amU/2E4d
 BEfPZM2YrsWJugqFnDNL+bWAcARUKGqPbb+c9zpyMXcxnZi3jPxfNlZ4K2SvrDQcn4hnE+fi5Tf
 FQ6FK5L6QGtCchU0er8OUJp9f9Z6DQP4PlMI/NUVbCYfTNGRkBu/HscukgyhVbFiTEZHkLU6VhY
 4vPRvpQV+78HLvuAddh5LkbY9dop6qenLEkrCj4q1RmMg8/Z9Lr2Tpseguc+si4DbX32X3SGpVj
 ieVCx5to3gBdqtDFQqJmbA==
X-Google-Smtp-Source: AGHT+IH4I1wrHdWYgwMR3iRKVYlCFIAS/f7/b+ZKKo1vigKXaq4h8+DFyhWiynTUYOgV81a1X6yyxQ==
X-Received: by 2002:a05:6000:1844:b0:38f:6697:af91 with SMTP id
 ffacd0b85a97d-38f6697b0f4mr3062866f8f.39.1740068527340; 
 Thu, 20 Feb 2025 08:22:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] hw/misc: Rename npcm7xx_clk to npcm_clk
Date: Thu, 20 Feb 2025 16:21:15 +0000
Message-ID: <20250220162123.626941-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Hao Wu <wuhaotsh@google.com>

NPCM7XX and NPCM8XX have a different set of CLK registers. This
commit changes the name of the clk files to be used by both
NPCM7XX and NPCM8XX CLK modules.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-11-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm7xx.h                      | 2 +-
 include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} | 6 +++---
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 2 +-
 hw/misc/meson.build                           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} (98%)
 rename hw/misc/{npcm7xx_clk.c => npcm_clk.c} (99%)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 2e708471ece..e80fd91f204 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -23,7 +23,7 @@
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
-#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm_clk.h"
 #include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
diff --git a/include/hw/misc/npcm7xx_clk.h b/include/hw/misc/npcm_clk.h
similarity index 98%
rename from include/hw/misc/npcm7xx_clk.h
rename to include/hw/misc/npcm_clk.h
index 5ed4a4672b3..0aef81e10c8 100644
--- a/include/hw/misc/npcm7xx_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -13,8 +13,8 @@
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
  */
-#ifndef NPCM7XX_CLK_H
-#define NPCM7XX_CLK_H
+#ifndef NPCM_CLK_H
+#define NPCM_CLK_H
 
 #include "exec/memory.h"
 #include "hw/clock.h"
@@ -177,4 +177,4 @@ struct NPCM7xxCLKState {
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxCLKState, NPCM7XX_CLK)
 
-#endif /* NPCM7XX_CLK_H */
+#endif /* NPCM_CLK_H */
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm_clk.c
similarity index 99%
rename from hw/misc/npcm7xx_clk.c
rename to hw/misc/npcm_clk.c
index 46f907b61c2..2bcb731099e 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/misc/npcm7xx_clk.h"
+#include "hw/misc/npcm_clk.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 554eb8df5bc..edd36a334d7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -69,7 +69,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
-  'npcm7xx_clk.c',
+  'npcm_clk.c',
   'npcm_gcr.c',
   'npcm7xx_mft.c',
   'npcm7xx_pwm.c',
-- 
2.43.0


