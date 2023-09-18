Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9BE7A46C6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBKB-0006HP-Up; Mon, 18 Sep 2023 06:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBK6-0006Gn-Jw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:17:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBK2-0006n0-G4
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:17:45 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-404539209ffso44268615e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695032260; x=1695637060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OeLfLl3LjSe+flyYRXHJoPyc020uZocilUJMKnQncFo=;
 b=DNhXxsTgrxi5pjnJ17NCrhNfsmlSSTmwZc7O/RJ0DZVKBIt0MrSi/cjhztg5PDR/mf
 NLCggOY0g8Do6FXADQ5uxxCgLtrGYJxwF91o9VEOF/w9Ql8EqJXaD7TcxRJspKhJIIj4
 799jyniOJmMNpY1ZlYLSVKsGoJYqGiidp/IhvyKeqdyZ7KlFtJkikFfCYoCX18G5Jx9Q
 SsGNA1jBg73jRZ3IlZ1TmTDMugwOhMGVO4dAr9HjT/HthjboEGvliKSmcBXKe0VgSVpY
 ZxHykH4ZcFuc2s+vgkxaISDAZ6H+2UBZtIWCSMTrd7zX+tS2q9hDeBC73fAvprRoY4jC
 K/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695032260; x=1695637060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OeLfLl3LjSe+flyYRXHJoPyc020uZocilUJMKnQncFo=;
 b=TDfVG3cDvPmmAd0FZvi8Igd38WpQLjExoFOV4Cm+QPs2r8ys9kR78tHwwHscibG726
 MgE+GGcacakIVE+THeyTxssTb1goTzSKTLnrhNpUHYt39ajMoWNP0Smen3msSVioHQ6f
 WTpB3TBxwyR8Po2CBDWk0OuCybBzxNT9H3pRWr5z5pQ0jTZGiUlp5k0JPY6tdH4JkzB2
 pL8/2eSI+oyWxzf34QDNLAZiuFB7hRZDmhIyNJyo7mfxFqpntJXXOLwaOWS3tDEKGDEk
 oTbhPYXEbYjVTEUwNuZvG3jLhHvG/uydEE8RstvqZa4mk0RlT8i0KlH7aKzfjbp6t83Y
 drFA==
X-Gm-Message-State: AOJu0YwuKuPW8sfLXOeN+14nNaEj/2j9xW2SlCt9AApjlWZlZRDf/XrE
 RtOVppU0TmwyGulPP/xX+Z8LE5k8bgePK+hU1ZotSg==
X-Google-Smtp-Source: AGHT+IGSfBDs6j3tcZ4qajKD3qps7Ks4L8/CdtFxIGHeMqsgIaLpNZuM6XwokMcGIrinRdTBIBL70Q==
X-Received: by 2002:a7b:c84e:0:b0:401:7d3b:ccaf with SMTP id
 c14-20020a7bc84e000000b004017d3bccafmr6649664wml.4.1695032260467; 
 Mon, 18 Sep 2023 03:17:40 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c20d300b003feeb082a9fsm11960178wmm.3.2023.09.18.03.17.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] qdev: Ensure devices are fully realized when calling
 DeviceReset handler
Date: Mon, 18 Sep 2023 12:17:34 +0200
Message-ID: <20230918101736.23905-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the process of clarifying QOM/QDev design, we want to enforce
the QDev state machine, in particular RESET can only happens *after*
REALIZE.

Besides CPUs (which are still particular), the only case I noticed
is in a non-QDev type (OMAP MMC) accessing a QDev one (SD/MMC card).

The first patch first handle the OMAP MMC case doing minor surgery
(passing a 'realized' state to omap_mmc_reset(), the function doing
reset out of normal QDev RESET tree propagation).

The second patch add an assertion in QDev core code, in order to
avoid further devices being added out of (QDev) order.

Please review,

Phil.

Philippe Mathieu-Daudé (2):
  hw/sd/omap_mmc: Do not reset SDCard until being fully realized
  qdev: Ensure devices are fully realized when calling DeviceReset
    handler

 include/hw/arm/omap.h |  2 +-
 hw/arm/omap1.c        |  2 +-
 hw/arm/omap2.c        |  2 +-
 hw/core/qdev.c        |  3 +++
 hw/sd/omap_mmc.c      | 21 ++++++++++++---------
 5 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.41.0


