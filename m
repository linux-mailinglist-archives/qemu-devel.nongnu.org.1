Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64191832037
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgR-0005W0-Dz; Thu, 18 Jan 2024 15:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgL-0005RP-G5
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgJ-00073q-N1
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e884ac5c8so251255e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608486; x=1706213286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzWbQBIfEs6OJQ0hzr//F/cyUEfiuvwBN1uqJ0c1PMQ=;
 b=kcGqJv1qb4JoInmpl5pkwOfF0hMfqUv7tyBh1GGXuCPQ3GTrdhCpgGXdmhBP3tB0zi
 j6G+aGUJ61T4l/+ck0RYTsUaY4Yz1Xetnc3OgiIqzHxAK5qSY7ElDb6hxyHWAFeOu7gV
 2QQOy0L2Uw9YLlx/T9OkhgzgKWTQi9rT2aqOoHDmjFYG91J4ssESL4CteThKliQwKRo6
 CHN0e/Qh2MGXJ+vjHI8+em67XnUerT+sOIT6y45MQ+ehlWUTOZ4rNzVCVvGbFBe2Y6MB
 o41Ukte5u7GDe8eu2zyrjI2FQY2FDoXrhG9Kb3BJ2jqDYyXNA3I4+rw6gjgJbY0ayvjP
 Isbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608486; x=1706213286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzWbQBIfEs6OJQ0hzr//F/cyUEfiuvwBN1uqJ0c1PMQ=;
 b=AuUU2PVcNNSlIYeCPZxHC/ebmRxHKFVcVZgJvLbMxkomDb1u6QanEnzWND2FmhvI6K
 AVPmD87mGu5X9t2O4QFa0i2rpsk6Um7p5W0Ya5PJDX2dPHhJCRM7fscE/aVQgVH4Bmk6
 1rxvP5geaYgEO6GGkGW67vJCORpuzURDA+Z7k52CbfHMCVJpDMaMqZD3BG/R6Lr1ldDT
 xVvSbwA8Zt2E04To5TCrHq6MlwWOPprmFOR4xkCdzotTdpqWEX5U4xn0vZ9YW2X9mD6L
 36+zJLT2g+s388seLubw25RL+bLApOPsm/sOC83LwlyGHBI5DuPvfDsxns5VLfVZM3j5
 UcPQ==
X-Gm-Message-State: AOJu0YxNra36cTSi0NWe0DvB6Iq146qHdHJKLxGGngo8QdR6kulmrP/+
 YsDilWg1k2k7yB0D+dpI6Dam2172hyLMKry9Cz5xCfrXxtMqW78FQQIyKZQtp2B2UdBVsvBgf0x
 wNub3EBT0
X-Google-Smtp-Source: AGHT+IFci8bumHGc8yO/eXI47NN1r9/9twGUNYvsiqm8vje6N+VVmUV/t0FaeNfUmyQwqGi/uZixhA==
X-Received: by 2002:a05:600c:2047:b0:40e:53a0:c140 with SMTP id
 p7-20020a05600c204700b0040e53a0c140mr471729wmg.229.1705608486072; 
 Thu, 18 Jan 2024 12:08:06 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c0a0a00b0040e4bcfd826sm27279780wmp.47.2024.01.18.12.08.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:05 -0800 (PST)
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
Subject: [PATCH 14/20] hw/misc/xlnx-versal-crl: Build it only once
Date: Thu, 18 Jan 2024 21:06:35 +0100
Message-ID: <20240118200643.29037-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

hw/misc/xlnx-versal-crl.c doesn't require "cpu.h"
anymore.  By removing it, the unit become target
agnostic: we can build it once. Update meson.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/xlnx-versal-crl.c | 1 -
 hw/misc/meson.build       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 1a596f1cf5..1f1762ef16 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -18,7 +18,6 @@
 #include "hw/register.h"
 #include "hw/resettable.h"
 
-#include "target/arm/cpu.h"
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/misc/xlnx-versal-crl.h"
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 36c20d5637..66820acac3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -96,8 +96,8 @@ system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-crf.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-apu-ctrl.c'))
-specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-crl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
+  'xlnx-versal-crl.c',
   'xlnx-versal-xramc.c',
   'xlnx-versal-pmc-iou-slcr.c',
   'xlnx-versal-cfu.c',
-- 
2.41.0


