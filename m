Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6897CFA6D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSmm-0004fL-5M; Thu, 19 Oct 2023 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmR-0004MA-1n
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmO-0007Bg-S2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:09:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d9552d765so6171780f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697720968; x=1698325768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y6l2KIf5+R7TUFSxlxouVzOchcCkcjWpO60Z6OF//2w=;
 b=CWBT3U59eAnGzhsmh+wpvr+Yb0olkpT7B5vR0dTI9d6bKWaVJxzDZhaGmjXCSWFgE7
 v66wN0GmZvSLdLa1ukRyE+FLx+kqzY6KYyhnpPtKeZA8xMOkz+Xf0cCKhWt3OFAVoy5F
 cdSVDPcmzpB3DPnh4o5b/3N2P25Xqi+Dcsi+iuC5HbNcLAZiswZ/58ZzqDzPO16FnuKD
 17JNxxZXs1QMGX5NbN1q1hoYjXiJm1Zgd21pWNJ1N1P5mD1wLqBGPrlcvXlSFIU0TcFe
 0srSdLiVWP3kyWoTp5F8iTvHCbLwPg91GuHf+zKN/4MXyjaO85NtBMCQfu+0GkbaiKKG
 5vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697720968; x=1698325768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6l2KIf5+R7TUFSxlxouVzOchcCkcjWpO60Z6OF//2w=;
 b=JYHDc5X9h8fhoY/j8hVysvNR9BuTvnJ0gZigRCkkJTjgdtjEMIsuHqSoXgZvVluTYW
 OxMswtuFBZfTukw4yoivykaoB68pTJ3PEMwu6SWxlcZ80bx1wgE/AZVjA9z1GL5EKskm
 SqPNpHpRZMIyzNtGHdDcMHYOfEejzMjdIpQN/Gli5a6tlZX5nXxWJSa7XVwzOqqoQ3Q+
 zaWcPrFGPeUHSzgK3NOutodZuOO80/kTn3rdlY5glfxyS0MeHAeI09helY2U260/fJKX
 NtwAcyqhcPqlujIEzOB50BcktABU2fv3M2JyMYHahJarWu5uW6wF/iLYVwYZjBWaa6o7
 YpiQ==
X-Gm-Message-State: AOJu0YzsXcqf+GrfjKeDAC0fwPyQ1xXD1oZbmZf190wKoOE594yXErmu
 5WeKExCP5DkSZHgnw2XjRiLxKCl7NU0L812/6oOEvA==
X-Google-Smtp-Source: AGHT+IHJSW00kAUMQ0kRsmnPOlDLNWSw/YdKlkzZN7pZcZsWVJFo4BYxaST+qwyFB4D3zgTzQlER0g==
X-Received: by 2002:a5d:6583:0:b0:32d:7efc:7e1f with SMTP id
 q3-20020a5d6583000000b0032d7efc7e1fmr1372866wru.71.1697720967866; 
 Thu, 19 Oct 2023 06:09:27 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a5d4a4e000000b0032196c508e3sm4397656wrs.53.2023.10.19.06.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:09:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] hw/arm/pxa2xx: SysBus/QDev fixes
Date: Thu, 19 Oct 2023 15:09:15 +0200
Message-ID: <20231019130925.18744-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Since v2:
- Fixed i2c_init_bus() call in pxa2xx_i2c_init() (new patch)

Philippe Mathieu-Daudé (9):
  hw/sd/pxa2xx: Realize sysbus device before accessing it
  hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
  hw/pcmcia/pxa2xx: Realize sysbus device before accessing it
  hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
  hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
  hw/intc/pxa2xx: Convert to Resettable interface
  hw/intc/pxa2xx: Pass CPU reference using QOM link property
  hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of pxa2xx_pic_init()
  hw/arm/pxa2xx: Realize PXA2XX_I2C device before accessing it

 include/hw/arm/pxa.h |  2 --
 hw/arm/pxa2xx.c      | 17 +++++++++++------
 hw/arm/pxa2xx_pic.c  | 38 +++++++++++++++++++++++++++++---------
 hw/pcmcia/pxa2xx.c   | 15 ---------------
 hw/sd/pxa2xx_mmci.c  |  7 +------
 5 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.41.0


