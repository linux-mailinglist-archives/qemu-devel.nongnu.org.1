Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA25832051
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfZ-0003W5-5b; Thu, 18 Jan 2024 15:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfW-0003Vc-GW
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfU-0006wE-W6
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e8f710d44so257995e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608435; x=1706213235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqI4tMz2yzskRPvxs8gc/s3cCgtxYk3v0bTB1NWtJzM=;
 b=Zv/KyXAuEovv23X4w7KfY17iIwtapPIVUKkJRTwSgJq1pcJBx/2nEXpt9hc7AUzSez
 OY4D7eeMcP7+Ltmcf46iYolFYZw7CNdafe+QVTMNFT/5EKIwn/gMUXrh1NzobavYkkES
 SxTxadgEPWzCD4RC9ehyDAmsxxGdXNbKzNfcg/NHNSegzMLShhH+TDB22222rxgINPPh
 xUI7lceVMN3HQAVAN6ZMbmq0pVQym+lLRQyi0xgVaJr/JcV9DIxvfyXeVwxS/UfLkDw8
 cPMCW0qf6ZNatj7YQvdWR3wb12loIehDi/n/M9WtOJTUboh/DVq6HkhzHvTdXrX5o2FX
 nUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608435; x=1706213235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqI4tMz2yzskRPvxs8gc/s3cCgtxYk3v0bTB1NWtJzM=;
 b=cED/c+jczl4H8uPXF6RDd8PJUSNmu8eRd8F4IeXLLOTCjBxGmkXffF6wUSGoygwHsW
 XjQ/yS8M+2rNLpwE0eD9B2YtkGyncBvHp1G9fxRDj9VM1570GMVDlY8hFqOt+B0Bm8Rl
 ge/SGvGj7ki06A2nJ3nr+RR4kv79jUcmp8uDuT9o985RLUzSeknlp/+NghltHaUrqGde
 xTrXDzyZNFhIU4zKFiodPrUTDsUzKy5CJ6GGoBVMaJJNxEnCCNqZXrGJEnwwc1OPqcr2
 ApGilVfuSqWPDl2iqMkQzkF7tSSfeGl26wCOTg2HwGclSXbJPYsvys6hXxExwPZ0nnwO
 Brdw==
X-Gm-Message-State: AOJu0YxFJ0OX+8sZpySzFVMtYkRb2NelzgscIfnr6xeMik6qtMiTUVql
 ZUyWKvwD3thNncgOgpEJfo4fa34BC6p4za462uGm2RqkxshdP4DWAjUPWN6kQqe10SxG/lfHCbP
 7v6PvRCxS
X-Google-Smtp-Source: AGHT+IEJjVKFjOhUte3h+FN6s3BlfHWp+z5dcQ4uANgPU3TjG5YMaIqdzX+BYpMSKDVsuoEyDNtojQ==
X-Received: by 2002:a05:600c:22c6:b0:40d:88cb:ac7b with SMTP id
 6-20020a05600c22c600b0040d88cbac7bmr786225wmg.183.1705608435599; 
 Thu, 18 Jan 2024 12:07:15 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 o31-20020a05600c511f00b0040e703ad630sm18018088wms.22.2024.01.18.12.07.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:15 -0800 (PST)
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
Subject: [PATCH 05/20] target/arm/cpu-features: Include missing
 'hw/registerfields.h' header
Date: Thu, 18 Jan 2024 21:06:26 +0100
Message-ID: <20240118200643.29037-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

target/arm/cpu-features.h uses the FIELD_EX32() macro
defined in "hw/registerfields.h". Include it in order
to avoid when refactoring unrelated headers:

  target/arm/cpu-features.h:44:12: error: call to undeclared function 'FIELD_EX32';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-features.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7a590c824c..028795ff23 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -20,6 +20,8 @@
 #ifndef TARGET_ARM_FEATURES_H
 #define TARGET_ARM_FEATURES_H
 
+#include "hw/registerfields.h"
+
 /*
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
-- 
2.41.0


