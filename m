Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919F832036
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfD-0003P8-3D; Thu, 18 Jan 2024 15:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfB-0003On-8K
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:06:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYf8-0006sF-MH
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:06:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e8801221cso224215e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608413; x=1706213213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiNAFYNzh60Xuezutbt6PuwpTTLS/OKWcI7qaHfDd9s=;
 b=HP9tV4Jq36w/bkNaJaAQAhsEL9TlOcgrGAG4kaObnnS1au3JwTcdyTp+yxRVllMIB6
 F+/VRqZPPhIMX0+DXw89ATjT9nkK8nnlDtMc/lsMDevqebDl3SFqNbLH8PLEkn/jhZMs
 wtvpw7BB25G+n2O1bVvqKytAxJ8Mpk2Xucez7NDXxe4OWrDR2WMIlpOIMwPrBMKXfrdH
 +hQD+mn4925unUYysgyGxs+pM6XEWwYSYxw2+zcGOmby/6WfN0/qYeDEZ1hnxUCu40IW
 vLHwgd16yoYU7f+DEmIAHbA1ACwOLLC/U+iFCeF4buPAg41dLyoBRy6P0Ef5tgHbK8Wa
 VEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608413; x=1706213213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiNAFYNzh60Xuezutbt6PuwpTTLS/OKWcI7qaHfDd9s=;
 b=EaNq+N+HTldU79V2Cs5F22mOY2kyy2/AgO0+9EU5EkcLMtUKcGUAKkLjiwKLQeXqJE
 e89Y4OTnk3z0lc8IXm9+GHqX7P2Wet8fASuXy8qCJOeWcEVb+Cl5Ra+63jcqLcjjj0Oc
 Hp/VFNbTjIzOB6G/3S2qUplDOGODDwsxRgvfa0VpFRPcCBSbRJHZxgPDhgMQPa+7XtQI
 CYYKyRfyEhowNlSdsu9gKUJJu6TvQnSLXjDJJljB8WH9IVedg21HP5QHE6zMcwd6Wwa/
 YTevq4DAqqqBjQcNS1lYDPz3dAiDyf1GUZHyNICV27pqsdEqqK2UOcAXZ4oR4P+JUyQl
 Gvpg==
X-Gm-Message-State: AOJu0YyXugy2nK5sioURGPs4oljuMJFxQcH1aFRjtZABdo0SYt+eHwDI
 hdxEcQRCiCL8ovgzS7rvwOUqH8JXFiZVb8rqp9eSiwpANMbYsq+vPQ334WZLkAYyS0s28wBTgn+
 0GJQG3ZF5
X-Google-Smtp-Source: AGHT+IFCtGpPVhfA9Jwun0OeUACkeGdu+paDIrRm7jQFMh2yisqV6dFj3NRTrnHaxOVPKfMo4Nk5zg==
X-Received: by 2002:a05:600c:3317:b0:40e:85fe:af82 with SMTP id
 q23-20020a05600c331700b0040e85feaf82mr1044508wmp.24.1705608412751; 
 Thu, 18 Jan 2024 12:06:52 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0040d8d11bf63sm26933714wmb.41.2024.01.18.12.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:06:52 -0800 (PST)
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
Subject: [PATCH 01/20] hw/arm/exynos4210: Include missing 'exec/tswap.h' header
Date: Thu, 18 Jan 2024 21:06:22 +0100
Message-ID: <20240118200643.29037-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

hw/arm/exynos4210.c calls tswap32() which is declared
in "exec/tswap.h". Include it in order to avoid when
refactoring unrelated headers:

  hw/arm/exynos4210.c:499:22: error: call to undeclared function 'tswap32';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
          smpboot[n] = tswap32(smpboot[n]);
                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index de39fb0ece..af511a153d 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/tswap.h"
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
-- 
2.41.0


