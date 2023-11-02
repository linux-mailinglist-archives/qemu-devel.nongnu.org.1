Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463A7DF8E7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfJ-0003Wa-GL; Thu, 02 Nov 2023 13:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeg-0003GP-1L
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeb-0002lu-Pg
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so13849115e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946728; x=1699551528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nbey4SZJJmXe8K8MAAeguqkbXwo5FmAHlW76eEXbodE=;
 b=yqWPCkG8gRWiPSEa5W7styRvbGW2SqaJTDw8l2D+bsQSIR/qYp+4X1zhnGx+VZ5xYj
 3nDJvhWS5uZMBWK8YEatqaS46cZcJKhaG3JEx8f4pXqyhtzXYjbCnFUY6LN403BcpQ2t
 unkEveSdD1h6h9CAg4LcYWT8Vkb3nMMmbzov5XF8rrETZOQFjGNROmKTZWZ0MOXaHV5z
 P5jSd/gXq+zwTdI9PyN85MRMvkTonRMSwmNx6D8rDiWNcMl8bsPpXGP0foQWLLYCiWBY
 llni3ifp7eZpYwQRgTl4X4yXjeKYut/ZDUQL1BOwG/U9bvvfuwzK0gP48zmkk06Vm++W
 cpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946728; x=1699551528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbey4SZJJmXe8K8MAAeguqkbXwo5FmAHlW76eEXbodE=;
 b=ugsjNJd2T5XxU/M5Ks1URmQtf1vMlC8ZOXDJxFKyRoaS1hwSjlu0yPAWZZOPAqHOXP
 3pADi/s31cn0mALkYDQ1KpO8aMDRLOsHFfNbS5bEPfCwYD/RVkG4HVx+F9Qgdb/F1Pa9
 SHxlyeK3N/gRwmtZjKFCec8n0augfoEMJnhwfiWUtaPAjVLQcsb6G5eksXMjDIDPUlWp
 pTzsmUUm/NrI+43AX4N0Mfmu2n9vheC96VYxkJ+PQx/AkWN0d7XFx/Vr1yi3x8uHZfpu
 vxexPbRuH8Y4VbdwLAclMuZ9CkEcJ2x4mV/tHDO3a+WTFimebhNMayeZFCFKoem4Fdiw
 hvTw==
X-Gm-Message-State: AOJu0Yw8SbjNggt6t2wzQ12rbhRCyuWoUts5Rbx70lTV/s7VLTlYrt3E
 dB9AeRGED4JOntOilehI0OPAQWzxKT3AmA36yfs=
X-Google-Smtp-Source: AGHT+IFGDp3MY1wZQC139ixCudBr9Jnh+LihNxQPsUW55qWnKGPKi9wwf0BRwhiORuGYwKMB+StEMg==
X-Received: by 2002:a05:6000:1846:b0:32d:8a7c:6efc with SMTP id
 c6-20020a056000184600b0032d8a7c6efcmr579699wri.9.1698946728049; 
 Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/33] hw/misc/imx7_snvs: Trace MMIO access
Date: Thu,  2 Nov 2023 17:38:22 +0000
Message-Id: <20231102173835.609985-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231028122415.14869-4-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx7_snvs.c  | 5 +++++
 hw/misc/trace-events | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index ee7698bd9cd..a245f96cd4e 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -16,9 +16,12 @@
 #include "hw/misc/imx7_snvs.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
+#include "trace.h"
 
 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
 {
+    trace_imx7_snvs_read(offset, 0);
+
     return 0;
 }
 
@@ -28,6 +31,8 @@ static void imx7_snvs_write(void *opaque, hwaddr offset,
     const uint32_t value = v;
     const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
 
+    trace_imx7_snvs_write(offset, value);
+
     if (offset == SNVS_LPCR && ((value & mask) == mask)) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 24ba7cc4d0e..426a8472b69 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -115,6 +115,10 @@ msf2_sysreg_write_pll_status(void) "Invalid write to read only PLL status regist
 imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
 imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx64
 
+# imx7_snvs.c
+imx7_snvs_read(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
+imx7_snvs_write(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
+
 # mos6522.c
 mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
 mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "latch=%d counter=0x%"PRIx64 " delta_next=0x%"PRIx64
-- 
2.34.1


