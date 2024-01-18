Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C2832048
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:10:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfl-0003ZS-1U; Thu, 18 Jan 2024 15:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfi-0003Yw-Sr
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:30 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfg-0006xG-BJ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:29 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337be1326e3so3012665f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608446; x=1706213246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrKc6a2ST12i1A3LtQl32z7hhWzowcoULUtetVq5wyM=;
 b=kG7OiRvl7VBmUmFaKShTNnLiNGSmJfmns6JOxTewQv6o0M+IBWba0/TdNGFKh/Wmp6
 hRKHEQS1o9PgM5UdLIRRjJyuDAVjXfkTFJyQxD2sZGn3A0CfNpowq+YNP1zSss48SzPr
 mv8pa/ATXWs/5yMUWa23PCljbCedVgt2p6Bu3yYJtAXhL6NAPbaj98r9UNP1zbnX76J1
 kF8wHybtM07Xwm1TTO4ZbBTPlohlyzonUciTdvsd1mSm+s0kShOCkqu3n36qMhmRlL8+
 7l1yvBJMw26b8KyXl4Cf5Fk1uRxeKf/JyyhuX7lib7QRUslzBwb5lz+Ebhs1cSqHIJxj
 CZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608446; x=1706213246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrKc6a2ST12i1A3LtQl32z7hhWzowcoULUtetVq5wyM=;
 b=M88HXBM/skdoS293kmV4hfvfFZh+bM2fZY1rEALu0ZFLK5XZwRP09mD8GLeYsvUSQk
 phm+5ZZ9wlZAwFWz3Hqgqb1LYDKYjvAFB/lnPSqiks6fhkKvEFdqdouB+F5SaARqTy6T
 vNu14yjA+uxUh6Lf3ESAyRg0VIeNxCXfkAfQI/bJKE/fox6Lkpv9KrDHCnbHexUzqfE4
 21DzzGvOyqZzF1hAtiXmIT/fQNTjU5k+Ypj/IWr8SvVIDKmb0gRY6sghklYsTkOJDXLT
 bZyb7jSQtsCxy1ZNrmXHHkCVvNf6lLtOsmgzuEkjNj5TeKUv3meNN7Fg5l9whfEurno8
 R6Lw==
X-Gm-Message-State: AOJu0YxiADVEnoqz+r/xkBikzAbCX1TjZHD16EwBFnwUMMkYpLlwy2gx
 CISWVe52ViemFsKU25fM63G9xqi52bevp9QNUMRRpwTaa52+dPWw7fRBSLKH3KvWau+xY0EL76x
 xKb4W7+oW
X-Google-Smtp-Source: AGHT+IF5TpLyt3xzqsStcktHwFkLs0/CdB5ZWsL/qBuExtVHXvpvfbbjbqtgg9GZ9hmsrHlpwv7qWA==
X-Received: by 2002:a1c:7511:0:b0:40e:8f4c:9fd6 with SMTP id
 o17-20020a1c7511000000b0040e8f4c9fd6mr1045616wmc.137.1705608446722; 
 Thu, 18 Jan 2024 12:07:26 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b0040e5951f199sm26612681wmq.34.2024.01.18.12.07.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:26 -0800 (PST)
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
Subject: [PATCH 07/20] target/arm/cpregs: Include missing 'kvm-consts.h' header
Date: Thu, 18 Jan 2024 21:06:28 +0100
Message-ID: <20240118200643.29037-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

target/arm/cpregs.h uses the CP_REG_ARCH_* definitions
from "target/arm/kvm-consts.h". Include it in order to
avoid when refactoring unrelated headers:

  target/arm/cpregs.h:191:18: error: use of undeclared identifier 'CP_REG_ARCH_MASK'
      if ((kvmid & CP_REG_ARCH_MASK) == CP_REG_ARM64) {
                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpregs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index ca2d6006ce..cc7c54378f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -22,6 +22,7 @@
 #define TARGET_ARM_CPREGS_H
 
 #include "hw/registerfields.h"
+#include "target/arm/kvm-consts.h"
 
 /*
  * ARMCPRegInfo type field bits:
-- 
2.41.0


