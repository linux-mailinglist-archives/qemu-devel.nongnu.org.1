Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3B7D5820
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKCs-0000gk-1f; Tue, 24 Oct 2023 12:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCm-0000g2-V2
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCl-0000to-3d
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso34268865e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164666; x=1698769466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IZ/JIaCD4bgqQwPEUaUAuoz6MNhWNnrfpvJBP8QkU5o=;
 b=IlGVaHJjY9f0gMSiomodMGs1FNDQTVIOAjO47AhUHJ8s86JMcz0M01+XKwCyb3H8ec
 VFyLxM4q8TjNUmmoD5q1UwYT76nMXxNDKQIQ9K56s08mK6Abt0FAdVkG1K1f4NLJxH21
 RlXTVyCNRvG/YnTd3cWnpIoeUvnEaBi08Nr5bEulSxYcSntQL0TigmDmjD3ByngiPymJ
 ZzsUIexvfYPbEqLxhx699sYrvUiGThTdzSfK/DqtA26YRkEVWhq5wvIwgjI+iOuYCpcl
 V9j1ntXS+iMGSGSf4N9SPkJlDwfRv1xKaiyj6aZOFZ+N8LFsNX7cuan39wbTeNvelKmI
 2ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164666; x=1698769466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IZ/JIaCD4bgqQwPEUaUAuoz6MNhWNnrfpvJBP8QkU5o=;
 b=UREL2OjsYuEBWPKdqmYY9EhfG5CAsIYoBpyyzYg7jYNv9fXe5e+64mcRF8vnfXd2jP
 pgeahxQSz8vGzGMBUVHKxsFeBPcsmrLDMy+8HYuardxZU8+qZUZWROxGYwBKY1bvPmNf
 rLywt5xdJXw6vMYoFjG4nAsWann6+lLy0TQyrCPK7mHVA6khsoVZrhR4Gn2Eiwubg7J5
 Ap8voXN0OtZcySpWAPKuFVSZCBrD0awHnyYS0wTTCCXRcPRFF4AMShCnLIozZZ6jjpXZ
 bjg/fjPAO6C66qU16ABTm5QTF+nqzz90l4dxU6sTV2TpX+19KgQ9frVIf8EeSjWpXuXP
 6OQg==
X-Gm-Message-State: AOJu0YxKLJrER/U4x8FiQGpy+ETwB2PzV2un/yRTPtUVnBuN2Z+vQysP
 +f/KeJmlxKasn4xPdK0qr6SDTA6//5FPoE/AvTU=
X-Google-Smtp-Source: AGHT+IGKBkfenD7j+WsuXwLVj6wu2W69Nnh4aWWT+e/XabT7ICQMG0seP4MKgRWX/0w5o029xX7duA==
X-Received: by 2002:a05:600c:4593:b0:401:b504:b6a0 with SMTP id
 r19-20020a05600c459300b00401b504b6a0mr10130263wmo.3.1698164666210; 
 Tue, 24 Oct 2023 09:24:26 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c45ca00b00407752f5ab6sm12592013wmo.6.2023.10.24.09.24.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:24:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/11] hw/arm/aspeed: Split AspeedSoCState per 2400/2600/10x0
Date: Tue, 24 Oct 2023 18:24:11 +0200
Message-ID: <20231024162423.40206-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This series is extracted for a bigger work.

Cortex-A MP clusters (TYPE_A15MPCORE_PRIV) should create
the ARM cores in its own state. Unfortunately we don't do
it that way, and this model calls qemu_get_cpu().

In order to remove the qemu_get_cpu() call there, we first
need to rework some SoC users.

This series rework the Aspeed SoC state, so it is clear
what fields are really used by a SoC type (2400 / 2600 /
10x0). It will then be easier to have the MP cluster create
the core instances.

Regards,

Phil.

Philippe Mathieu-Daudé (11):
  hw/arm/aspeed: Extract code common to all boards to a common file
  hw/arm/aspeed: Rename aspeed_soc_init() as AST2400/2500 specific
  hw/arm/aspeed: Rename aspeed_soc_realize() as AST2400/2500 specific
  hw/arm/aspeed: Dynamically allocate AspeedMachineState::soc field
  hw/arm/aspeed: Introduce TYPE_ASPEED10X0_SOC
  hw/arm/aspeed: Introduce TYPE_ASPEED2600_SOC
  hw/arm/aspeed: Introduce TYPE_ASPEED2400_SOC
  hw/arm/aspeed: Check 'memory' link is set in common aspeed_soc_realize
  hw/arm/aspeed: Move AspeedSoCState::armv7m to Aspeed10x0SoCState
  hw/arm/aspeed: Move AspeedSoCState::a7mpcore to Aspeed2600SoCState
  hw/arm/aspeed: Move AspeedSoCState::cpu/vic to Aspeed2400SoCState

 include/hw/arm/aspeed_soc.h               |  35 +++-
 hw/arm/aspeed.c                           | 101 +++++------
 hw/arm/aspeed_ast10x0.c                   |  53 +++---
 hw/arm/{aspeed_soc.c => aspeed_ast2400.c} | 201 +++++-----------------
 hw/arm/aspeed_ast2600.c                   |  75 ++++----
 hw/arm/aspeed_soc_common.c                | 154 +++++++++++++++++
 hw/arm/fby35.c                            |  27 +--
 hw/arm/meson.build                        |   3 +-
 8 files changed, 364 insertions(+), 285 deletions(-)
 rename hw/arm/{aspeed_soc.c => aspeed_ast2400.c} (76%)
 create mode 100644 hw/arm/aspeed_soc_common.c

-- 
2.41.0


