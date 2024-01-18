Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649B832041
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:09:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfT-0003VC-P8; Thu, 18 Jan 2024 15:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfR-0003UV-6Q
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:13 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfP-0006vY-KV
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-337bad75860so284f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608430; x=1706213230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSJ61VYdXLhvSCoYWTAbZrzxB1wnfwdSWkLcd4JmNGA=;
 b=ODQWk/C5fSXcXkaoJvaHvOtINgfmIMlPFMcslQpgm3FfISu5GSgK7X0GdPc43iGgDv
 Ax2G5T0etfDm3Kj4flVB5aXDJexQ3nf8KK9Fw05qOgwv4RU4tpvanvHk1GJE1u8/Ntpe
 GS06qpEKauCOpKAo6ZUADJ+bx8Zco2c1BAAoZpTaRlKine09sGj/SpwDQzyb54Vje3PR
 MdOfGhwJ9neUJeSncrK9ckRKf6yyTKXD95qQp1YZEr+J8XO4VaFX2GXazqz5iB+NQPb5
 kslHsU48+N53NmSJNEOnXABw8nMxgy13rG2YRuHOFCrn278pDXsn3oQ67RGWYRXkQYjK
 dS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608430; x=1706213230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSJ61VYdXLhvSCoYWTAbZrzxB1wnfwdSWkLcd4JmNGA=;
 b=Udiwwm+1BwiuQ9ak+F0nL5v+MVWiSSyRU+XLiIysgpKg4GJyhiyo7kbW/dM46/edjR
 wxLFkOx7z9boQSVe8Zf4uqs8eZ9dL1IC1nbG9dVOYKmXIOGQt1Nkt8xDFMYxTk5HnE8X
 qnyqFghGM3X+U7Vjle1OBSSwhFRleeg1DXjF9HaJFnDNfdVotR8jRHK6MZ/6PmiwwF3W
 ccIYxuwyh3RVNkgBaYz9xSOCkmQS9LIBEtnk4S7no+uXR9mcJGStyuzQ9pF+SfYSxWfK
 s4NkChWTwBBpsBxZP06kDY6qJUwbx9y/Zjv+3Mh+HUlfdMw8ghb6oXb4FGyACUTgYUki
 Cudw==
X-Gm-Message-State: AOJu0YzKVGM6NfG81Z/Ax7I2nWbE3Mi4DQN6eTzyMk5T+MwtwECjojZW
 HzLe+qkfrMQxOhnJIa8D7l6m+PTtkYXtcJjypNzHhkaNxjTvHBvOHk4PLcZp3cclXdhFY5KqJUt
 chfxExDNK
X-Google-Smtp-Source: AGHT+IETSTGRNXlFpF1x/zcbUs5V3o4QwqncYxMR7NZ7TvBtPQk41EnWndQyks5m9I+o909cn/g4Pg==
X-Received: by 2002:a5d:6c6e:0:b0:336:c3c7:75e8 with SMTP id
 r14-20020a5d6c6e000000b00336c3c775e8mr1223627wrz.45.1705608429954; 
 Thu, 18 Jan 2024 12:07:09 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 q10-20020adf9dca000000b0033342338a24sm4766596wre.6.2024.01.18.12.07.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:09 -0800 (PST)
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
Subject: [PATCH 04/20] hw/arm/xlnx-versal: Include missing 'cpu.h' header
Date: Thu, 18 Jan 2024 21:06:25 +0100
Message-ID: <20240118200643.29037-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

include/hw/arm/xlnx-versal.h uses the ARMCPU structure which
is defined in the "target/arm/cpu.h" header. Include it in
order to avoid when refactoring unrelated headers:

  In file included from hw/arm/xlnx-versal-virt.c:20:
  include/hw/arm/xlnx-versal.h:62:23: error: array has incomplete element type 'ARMCPU' (aka 'struct ArchCPU')
              ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b24fa64557..025beb5532 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -34,6 +34,7 @@
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
+#include "target/arm/cpu.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
-- 
2.41.0


