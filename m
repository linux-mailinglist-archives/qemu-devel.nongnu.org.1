Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B96832032
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgC-0004zD-7G; Thu, 18 Jan 2024 15:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgA-0004rw-5M
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYg8-00070i-Ez
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e586a62f7so241375e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608475; x=1706213275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NepvwILR8saXQ0DwpYtr1EjRADd2IuMlIDWFe0pCcHE=;
 b=lz9U6aLvrSKJBl62+ubSLFWpv3647QJDh2a09i+LPxxy7PwOfwyE215iuG5g3M3aLj
 o8HRUIBaIDvw0UPYWAaCFFqqCOLnipEY16Ls38IcI+hGFgls3DUPBrBJrgOPzJA0658w
 g5I4+W2yX7k1nuNf6cnR7cooPjyGT/KcvtCXNNcZE9oa2sXkHyLnldTjZfnZCNSNSvRO
 IAi9YA3gf4JCuf7xS/C8iXcb5u3DooYVKJfmawTdU7kqTF5s6Loazs6rdBXER6lx322I
 n0w7oO+Wohe+R1dPoYsCa2IlAuWbeiWDRdt5eIGRiJk5MtCDAn5NicIcv9iFP/+oTMel
 s2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608475; x=1706213275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NepvwILR8saXQ0DwpYtr1EjRADd2IuMlIDWFe0pCcHE=;
 b=EMzK/L6f3esoB3P24B4Lc1TcrdfHGyljcIA6D3y0bOilOBDKtnyghXbDGTEnBMGNA5
 YisXDlW0OaTh6TCSS03FV4+ZTSu0Po1GKHRZ7YKBJ6q3QB3RoftlyztAJGbCF0+BqcDO
 slVJzAsTN83X5lcqkna7Zd75TTzlWZvArPyh12sXKhE+WW+P3Bny2vRXQPPZ6rA1vPXc
 /H0B6t7P1HhEvyOj97xNLBjrWYJU6dncT/KvsQLWH983p6gdfwnrWC/k9P1toLGeU2i+
 FnCtQmENVMAp81d7ZrnAeDwScm+h+jdupBM8qr9Ut4bY5663O2UdiEfbCs+K2OFNoyEe
 iyOQ==
X-Gm-Message-State: AOJu0Yw1MUG60X4P5BxobHsULAJdm9NzcBkO2Wk+IoZLpDzX5822WUG3
 Wvkl09LnFXenGiXO5nkZm/9lDVSQa5IFwvrsysitABtt6LAd1kUDEU4PmEyC+OenkpPQ54tfZsT
 tgw2qbpo+
X-Google-Smtp-Source: AGHT+IE+ld0bkfXv4fXDZ190iTMfcnQekq4l51pi5JbBiv/Fbjiv1mhIml27/nvNDwrsDjw20ygyPg==
X-Received: by 2002:a1c:721a:0:b0:40e:85fe:b00d with SMTP id
 n26-20020a1c721a000000b0040e85feb00dmr911900wmc.97.1705608475040; 
 Thu, 18 Jan 2024 12:07:55 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a05600c54c700b0040d604dea3bsm26301559wmb.4.2024.01.18.12.07.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:54 -0800 (PST)
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
Subject: [PATCH 12/20] hw/cpu/a9mpcore: Build it only once
Date: Thu, 18 Jan 2024 21:06:33 +0100
Message-ID: <20240118200643.29037-13-philmd@linaro.org>
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

hw/cpu/a9mpcore.c doesn't require "cpu.h" anymore.
By removing it, the unit become target agnostic:
we can build it once. Update meson.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a9mpcore.c  | 2 +-
 hw/cpu/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index d03f57e579..c30ef72c66 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -15,7 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
-#include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 #define A9_GIC_NUM_PRIORITY_BITS    5
 
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 6d319947ca..38cdcfbe57 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -2,5 +2,5 @@ system_ss.add(files('core.c', 'cluster.c'))
 
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
-specific_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
+system_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
 specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
-- 
2.41.0


