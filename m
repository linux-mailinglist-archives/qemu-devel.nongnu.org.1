Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF0E832044
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:09:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfH-0003Ro-Bv; Thu, 18 Jan 2024 15:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfF-0003Re-Vs
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfE-0006t0-F8
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e86a9fbd9so195045e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608418; x=1706213218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htALVQYUd7tctCm3cf8P5ZcYUk/HKeiXOxSFOuNuC8A=;
 b=Jk7ewOybzq6uvZz/lm4sOoitpaxYG5jOdlA8I22c77qVPiiOjYSBYZa9wx6ROs0tOY
 evm9WdRZcjIOKlqBNef6vdx7oTliLJxkLEes2s7m3Lpi6Xsoy+PNlYugUec7KAAGc/in
 6atEHS9lze233Wr1TwNNbrY1N4Zdo/wLOvzwgKheZDCQ6MCt39NzBg2gh9z/hTia6ZQb
 8t8R0y8ZADohIX/n4dZ1XGo24P5Q41TK+PTtzSAolwfYueNxCh8wM79S/o5cfNwxXNf3
 yQ2ylz0QsWuPFsnxCo1KPdfxoEDldmRU05hcg2tUH8rNhq2BLlg+H4N9LENYLJAmO9yN
 em8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608418; x=1706213218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htALVQYUd7tctCm3cf8P5ZcYUk/HKeiXOxSFOuNuC8A=;
 b=pZgSuMC98JUkwuuOYS73+dhkGpX4h9gsnZAMJoygkllIOS2d7Mcfzlq3i/OtXtoumP
 rJTk80Tw0UQp0P76ZRa/13YM34+qeA1pF8A+TR9z9gpIengOOcrkY94QSqPot1bPl+b8
 FflL/HjMleP2GbBHnhuEJEz1ps5n8HY1In66y7zQK0flX1UYRVhmx5cbQtCgw2STtvbG
 14KoWrr0OAGyUzHjNzKpbDSte5dvjWTl4st4X4hJGYsz08FA1dci8Y0wflcWxrQajExw
 16+0om5v+nk/3HYzKSHlOx3WCY0MmrVU+D51inkdAY2A2s0TwrbKSXbWLwI2D67Phun+
 DTmw==
X-Gm-Message-State: AOJu0Yz50XTcb7YO8PgpsBTD74BCGS5wNa5al4yZDT27Ukf1+D79bu6f
 Sda1ULUs8efLW2UQxIeQZ/kDgtdtFKDQhMnul/d5o5dfRxYXcWWI28yFiCeOOKbQn91pPTVo3YY
 tDYhUHtWs
X-Google-Smtp-Source: AGHT+IG8bYbFqhoBk8yTqNa3Tvhld4ys4sIRX15x3ny/K7+1KUY5t+dQIHR21Z/0Xv/O+nHkSVXnDQ==
X-Received: by 2002:a7b:cbcc:0:b0:40c:416c:d99b with SMTP id
 n12-20020a7bcbcc000000b0040c416cd99bmr862981wmi.47.1705608418664; 
 Thu, 18 Jan 2024 12:06:58 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c1c9400b0040e54f15d3dsm30578929wms.31.2024.01.18.12.06.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:06:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 02/20] hw/arm/xilinx_zynq: Include missing 'exec/tswap.h'
 header
Date: Thu, 18 Jan 2024 21:06:23 +0100
Message-ID: <20240118200643.29037-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

hw/arm/xilinx_zynq.c calls tswap32() which is declared
in "exec/tswap.h". Include it in order to avoid when
refactoring unrelated headers:

  hw/arm/xilinx_zynq.c:103:31: error: call to undeclared function 'tswap32';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
          board_setup_blob[n] = tswap32(board_setup_blob[n]);
                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xilinx_zynq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index dbb9793aa1..d4c817ecdc 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-clock.h"
 #include "sysemu/reset.h"
 #include "qom/object.h"
+#include "exec/tswap.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
-- 
2.41.0


