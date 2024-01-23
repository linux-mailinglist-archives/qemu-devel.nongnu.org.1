Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0905838793
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:39:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSARF-0003Vk-6w; Tue, 23 Jan 2024 01:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSAQs-0003U9-F5
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:38:50 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSAQq-000826-S7
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:38:50 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a87dfc3b5so2816145a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 22:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705991926; x=1706596726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1S3Kb8X6+oHdxd8A/86ZJwcoceMTfTdBEBzF8MGKUDU=;
 b=QiTaolEqHsGwPcXcBnbgMsh6gmibdTxjGAlLhjC0VpElbatdNgU82DeaHT/79x8WPM
 Zl5jST5m/LreZlkGN2iETCdqrBNOs/OQO/vOx+YmVhRc2HaizSRlfLQeteFO40+r2ZYa
 FlUpq0aIoFmt8PXszPjr7zKn8h/pxKMGXRzK8QBGgK3buLIX0WwPBh83iP+wEcRayn3w
 FHWIB5BN5FJrvXpiNgsAPUvHtuf97U66Ldcs0y/LDW0KLBluqZ9qGGBRR6wYZuoAZv7c
 x2HVSSiYjmN7axlsT5JrtMicbPRi8yA132d/SoPIDtwtTr1RJ0i2Ku2mYacT3md3XLIg
 HnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705991926; x=1706596726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1S3Kb8X6+oHdxd8A/86ZJwcoceMTfTdBEBzF8MGKUDU=;
 b=Y+xMCGoH2kFk4xbN7O4Q4Bay46kNGG88/C2U2ypVaGn4Wxyb7lXhpETJB3c0uHJDpF
 1SOifhJFPYHbZquH/r73kbRiOEhpSXoTx6L6gY6g8Lp6uZm4HoKqHeTggndkQKGCDK2+
 olNgEC8ZETTTxnw1yEiwc2JmM7zK2l679mPAbDnOzjHZp8qI0ACC9wtpryvdxH9mzgTp
 VltyLBbB5dL6gJCvtZVX9ZhUOr0DVHMr7+NYKvHmINbBransg2WnBdtkquqH4JnAQdEO
 Bw1bZeRbdWqN2X53jPL4kCnpLL/FODVhZRiiNeZIruoVsbwkj91NoHQkCam9oW4H8LAJ
 yBTQ==
X-Gm-Message-State: AOJu0YxWQnP2nTrx72BekLoRA28gJFsi/zhlZcqhMwae8tmQBWVJvEC/
 OdqTHgCDYhTmJSG93xa0YX+WhoRljjCBzw/G+NaR/U4F9j1ENLqQeKJ8rGI8l1aO2GfM8Zg4q41
 Cdfc=
X-Google-Smtp-Source: AGHT+IH10tALiVUBiygJF18SkkcSc95REieNOE5uwPdQGxn7GWT9Kn+c4EBSjbXP7jPdXz0IMdJCBg==
X-Received: by 2002:a17:907:8749:b0:a2f:ba67:cdd3 with SMTP id
 qo9-20020a170907874900b00a2fba67cdd3mr2766929ejc.78.1705991925893; 
 Mon, 22 Jan 2024 22:38:45 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 vg17-20020a170907d31100b00a30d2406871sm108238ejc.128.2024.01.22.22.38.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jan 2024 22:38:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Gavin Shan <gshan@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] hw/arm/cortex-a: Check for CPU types in
 machine_run_board_init()
Date: Tue, 23 Jan 2024 07:38:34 +0100
Message-ID: <20240123063842.35255-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Following Gavin recent CPU type enforcement cleanups,
restrict more single-CPU ARM machines (here Cortex-A SoC).

Based-on: <20240118200643.29037-1-philmd@linaro.org> (arm-next)

Philippe Mathieu-Daudé (8):
  hw/arm/exynos: Check for CPU types in machine_run_board_init()
  hw/arm/highbank: Check for CPU types in machine_run_board_init()
  hw/arm/vexpress: Check for CPU types in machine_run_board_init()
  hw/arm/aspeed/2400: Check for CPU types in machine_run_board_init()
  hw/arm/aspeed/2500: Check for CPU types in machine_run_board_init()
  hw/arm/aspeed/2600: Check for CPU types in machine_run_board_init()
  hw/arm/aspeed/1030: Check for CPU types in machine_run_board_init()
  hw/arm/zynq: Check for CPU types in machine_run_board_init()

 hw/arm/aspeed.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/exynos4_boards.c |  8 ++++++++
 hw/arm/highbank.c       | 10 ++++++++++
 hw/arm/vexpress.c       | 10 ++++++++++
 hw/arm/xilinx_zynq.c    |  5 +++++
 5 files changed, 73 insertions(+)

-- 
2.41.0


