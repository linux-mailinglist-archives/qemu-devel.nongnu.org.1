Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97EA80F2BD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:32:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5es-0001nW-Cm; Tue, 12 Dec 2023 11:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eG-0000wu-NK
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:21 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eF-0007EM-0k
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:20 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so674700066b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398617; x=1703003417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yI/BdK3JpWxvgTmRXK4JG4UZmdLauV/5I5Y5kpQEdc=;
 b=PW5EzrEJwxAfoumbelhZqSplq2Dr5lIn69M1rsLamM2lYbIW9Rjkj43gbfQ39aIPGF
 Nvntr2tkwWjlm0Vhlk7DB38AA0GiYa2l7KfT6s0YW/+w+GD7uzlQQogUWD2YjL8Fww8f
 P4tC6pQGLkCV8MvF9wS1NQgRvEhHogHUPZ+jCschDwu1mtfJarjyDNjdQVOMcfxUDsZH
 gvg1aat0+xuWtEdD4h5LL7D4O29h2PH0Ly6mWLq0uNsTEpiRFRw35MJ5H8RBO/ITkQwo
 PIvj22vyKYELZMGopy/INT5MbqmsOp67HXXhBPiTpEI2SlwFJSwzGq2BvbRxSzHKAh6Q
 oWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398617; x=1703003417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yI/BdK3JpWxvgTmRXK4JG4UZmdLauV/5I5Y5kpQEdc=;
 b=b0Pi+8rH0qlkrLHYTBTGwahzB2xD15Fw0Yg7jkjPGDuW6shem2RJiGjus1jUz49B8B
 LJzIFb2QCSPfT+Z1SRMUCRzxq64+yJuohOFqladoA4Gk7Vs8bxafRXnvbNOz1ZWsb+6f
 dULsWRvBf7R6wXMF5YhBa97YwlRAxsjMinZ4MlDzJff7HbV8cP7hu7BCqNErKuZ0oWGE
 iokEFWeWB9W1+/UXD4doef8sFnewoeSsU47ywXBiIeUwG00VS3ti1XYZYtIOeKPwJFs9
 6j7wIQEGYnXq+LNTFqNbkNMyvVIoIi8uYJKF/wzE+gFE4ocyvkcnDSTM8XN2NOXDta6e
 +huw==
X-Gm-Message-State: AOJu0YxWdnCTFJybBrLperyEpOaLyovSZOK+wa+j1lb9MHgsw8KInRdx
 SkxqdP+/GU7ndZLQcQ0TbKSkvN+eLyS2MuMgbSI=
X-Google-Smtp-Source: AGHT+IGocN7maPYKtAczqs3qDPil+solm+ZjQNUyQDb7ys0Tbt4YnQ6fpdspbxcOG6FTxMKseOq12Q==
X-Received: by 2002:a17:906:14d:b0:a1c:837c:e4a0 with SMTP id
 13-20020a170906014d00b00a1c837ce4a0mr3925715ejh.29.1702398617418; 
 Tue, 12 Dec 2023 08:30:17 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ts7-20020a170907c5c700b00a1dd58874b8sm6477080ejc.119.2023.12.12.08.30.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/33] hw/cpu: Remove dead Kconfig
Date: Tue, 12 Dec 2023 17:29:05 +0100
Message-ID: <20231212162935.42910-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

ARM MPCore Kconfig are defined in hw/arm/Kconfig.
hw/cpu/Kconfig is never used, remove it.

Fixes: 82f5181777 ("kconfig: introduce kconfig files")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/Kconfig | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 hw/cpu/Kconfig

diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
deleted file mode 100644
index 1767d028ac..0000000000
--- a/hw/cpu/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-config ARM11MPCORE
-    bool
-
-config A9MPCORE
-    bool
-
-config A15MPCORE
-    bool
-- 
2.41.0


