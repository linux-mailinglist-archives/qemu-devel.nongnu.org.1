Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCE832034
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:08:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYfd-0003Xp-El; Thu, 18 Jan 2024 15:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfc-0003XO-2a
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfa-0006wb-Jv
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:23 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so7306985e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608441; x=1706213241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPG2WfDmNMhkMT4jWeTVRmIkZRsis0mgcrg/P3hE0Ws=;
 b=hEnaDDvdHGTpGHEZYsRf0J5Z98zWI3sf6Y2tzlcAouroY1MvEIvY/ORerlonQGRtDF
 rO7+yg7EH9svWDwnBcnhsZJdwX9C2SEpZE9ANmGPI9LlAciR6euSyZNyeYjcxNe5Fs1P
 AXYslfhviW55/rmN45pxs2RUhKqfpLdJVOBaJdcFL/zTj0W0IMbVNs8JcnlJFh8ued0d
 UIBhofu6cJI6DzABb6Ie9TBhrsjpKlBdBYWXrfUyyCdUp1F6ePUWdzL4PAzBdRKMlTKL
 s1uqqQ5dHssNvzOayum7trqRz1Q915rt2jcd1+/MGU6gB2lfqI49Ld0kjRhn312dJaZQ
 b3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608441; x=1706213241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPG2WfDmNMhkMT4jWeTVRmIkZRsis0mgcrg/P3hE0Ws=;
 b=OQ4FYro02U3ntkAq0U1W1rgxukVT13J4vsjPP3IJ2aLqUqy/1dv0KD5KgnW88geh/X
 7c5csDApU6klfytwVaJMZDMJnaKBEnrl+iMyIAJU0Y1X36Azg14VcPFWbqdN89AyvfGN
 tdcxV4I77QxDiwrP0//v+wL1dUDP6vRvRdYby9TDZLMQwA7oB7Tefgb3FqUeIuqC089l
 cgDpKfKopwf2m8YC8pJ2D/Eu+Ag/EnWQGdTN5dIZZpO3lgoUITKlLTHRo/Y/Sx7DOr3C
 +nyEmbleNbbIj0S6r9aJfKDu6Vn8wsArlq5UqxJyCm/uP6DwqsHKes5klZWvhjBUK7RG
 /YAA==
X-Gm-Message-State: AOJu0YzOqlf9mtzMWMoJP50bIS8yE5RI1hrVxQ8sACxsz7N3EJSqFEGC
 Jh4Z8Ej2HuzedJSY9zZSoseEtfXQkUfw4Snaa/il3bPP7tYfsCFjuqJiayHvY4q2Rls3W7/YHXv
 JGcmxLuEJ
X-Google-Smtp-Source: AGHT+IFEMMya0qNkyh3kGalH8tBAMi4ftYlBVKyLBVVyK/sNll0fXqEHx9nz0kVM2qwAhHGsyVuw5w==
X-Received: by 2002:a7b:ce16:0:b0:40e:861a:c106 with SMTP id
 m22-20020a7bce16000000b0040e861ac106mr819142wmc.107.1705608441172; 
 Thu, 18 Jan 2024 12:07:21 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm8045600wmb.38.2024.01.18.12.07.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:20 -0800 (PST)
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
Subject: [PATCH 06/20] target/arm/cpregs: Include missing
 'hw/registerfields.h' header
Date: Thu, 18 Jan 2024 21:06:27 +0100
Message-ID: <20240118200643.29037-7-philmd@linaro.org>
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

target/arm/cpregs.h uses the FIELD() macro defined in
"hw/registerfields.h". Include it in order to avoid when
refactoring unrelated headers:

  target/arm/cpregs.h:347:30: error: expected identifier
  FIELD(HFGRTR_EL2, AFSR0_EL1, 0, 1)
                               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpregs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index b6fdd0f3eb..ca2d6006ce 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -21,6 +21,8 @@
 #ifndef TARGET_ARM_CPREGS_H
 #define TARGET_ARM_CPREGS_H
 
+#include "hw/registerfields.h"
+
 /*
  * ARMCPRegInfo type field bits:
  */
-- 
2.41.0


