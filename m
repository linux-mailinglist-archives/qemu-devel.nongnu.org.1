Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD87CDCF6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6ME-0007Jo-DE; Wed, 18 Oct 2023 09:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lc-00070m-Ji
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6La-0000e3-Qc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:28 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so11311305a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634743; x=1698239543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y+7dBdnLdYLbkfBLo/0ny+SjIXHGD30XHvK4qlWP4Rw=;
 b=J2v/bhq12juImRpaWC9hbKbkNYKaAQ2UAcwOGpt9ZXWUfbeTT4MWynWQFpveDq4bJl
 j+yzhxwxEfrMtw4oEi4widSe71vtTa96TjrVUGOJKoG3pXYONdA+veQEThQ7aUTqgRA1
 1Wz0WiYvAYNFgzEv3m0usw1zMD6GM7aK6AuYZ5ERK6+C2wvHvCaZarH9qpfrdVSlsku2
 KXvw05uZUS9lJIvOBPvFxlfDCdi3eWJ5SzJ5zqtIcrvWrjWbMuqEQ9xnCw5uemoN9wLg
 3+1BeT101zbEr79Fj4USItqpgS4q+YXh8ExRzonjhfCb83AivkEyDjKCx+JrJubP5w4/
 pxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634743; x=1698239543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y+7dBdnLdYLbkfBLo/0ny+SjIXHGD30XHvK4qlWP4Rw=;
 b=SQQJbNK1VzbkKlyRXsz703ICdhI9Lb1LduC3nTpq20UciVpVZuMFV38p4Ys51FN+PA
 FKW3sQnIceONZYb/cCXhUvM4Mb6IAOXo3u068d8CiGuXUChVK03qbcKVAmOj9mKMivvL
 r3VlP3XsLtHuD5VMBMPHm5LVWzapKjJCGJJh+nIP8I1UzY1uvmpMomIkXLyT1zFB8vkU
 Ha3vq9SBnVQUfRuZjYUgWuAhumjVi7htjsvIroFwmz2M1rHzeYamBGpHgmSba8eWIOAz
 E73IpBHIuOWbx/Vp4+Mq1kpK4sg2HvT/flhH/3dJ6DEEnCwaBNVrdn44WL0JtG0UCiMW
 L11Q==
X-Gm-Message-State: AOJu0Yxqehoot1sIBwxBttm/cw59+Dj3RR0WfgbazBt+xzKXThr9TcDe
 YQy3ZGMxL62la6uQeTc3m3ftLRCh+eFMcVEpV/E=
X-Google-Smtp-Source: AGHT+IGgNHntVx/cdNWbjI7zvDJBDx0owQAxKT4sam5lHR/DltJli6hB7PD6azmhh7VLt0kBQhojdg==
X-Received: by 2002:a17:907:c08:b0:9bd:e017:370e with SMTP id
 ga8-20020a1709070c0800b009bde017370emr4594450ejc.54.1697634743370; 
 Wed, 18 Oct 2023 06:12:23 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 os20-20020a170906af7400b009ad89697c86sm1698352ejb.144.2023.10.18.06.12.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:12:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] hw/arm/pxa2xx: SysBus/QDev fixes
Date: Wed, 18 Oct 2023 15:12:12 +0200
Message-ID: <20231018131220.84380-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Extracted from a bigger series which enforce QDev state machine
(qdev instance must be realized before external API is used on
it).

While here, pxa2xx i2c/intc devices received some qdev fondness.

Philippe Mathieu-Daudé (8):
  hw/sd/pxa2xx: Realize sysbus device before accessing it
  hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
  hw/pcmcia/pxa2xx: Realize sysbus device before accessing it
  hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
  hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
  hw/intc/pxa2xx: Convert to Resettable interface
  hw/intc/pxa2xx: Pass CPU reference using QOM link property
  hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of pxa2xx_pic_init()

 include/hw/arm/pxa.h |  2 --
 hw/arm/pxa2xx.c      | 12 ++++++++----
 hw/arm/pxa2xx_pic.c  | 38 +++++++++++++++++++++++++++++---------
 hw/pcmcia/pxa2xx.c   | 15 ---------------
 hw/sd/pxa2xx_mmci.c  |  7 +------
 5 files changed, 38 insertions(+), 36 deletions(-)

-- 
2.41.0


