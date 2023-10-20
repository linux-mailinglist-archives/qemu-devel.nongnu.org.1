Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6637D1036
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAD-0000Do-0l; Fri, 20 Oct 2023 09:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAA-0000DI-CT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:03:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpA8-0005F5-NZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:03:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso1084520a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807014; x=1698411814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SDBJ3mrLth7e5T3Pd/8WVxgBRrRT5m1C71LOIXG9CdU=;
 b=tYEth7sA0ihQKgYkpASSUOJqsKR8mZhSSrWLTbGaHJWVTpFfLSYxv7UkToH/EVmm0F
 ZNx2M1Tf6/QvMsmTQzPS5hlHCJkjk904US5Wuno3WKJXT+E+msbTCWDTK1MRvifpgPY6
 OPgMfM16bEYM9tOUgLXcu+sfNAH/kvPmFIFeTnbT1pyNSH+OoHg9CKn49OwBqUnspZBe
 N11RlVmVu4843Gta6SFvh+oLtUPU4mNDnb5M1YLZsd4yKo1mYK3EFMwzNhJ/B3IDCwjj
 Ib9kCy7sDP0w91zUFB1o00icVBTt6zGAB98PMvCE/w4MGJue7yxCBLoSm1Oh0+JXJ6A8
 Gz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807014; x=1698411814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SDBJ3mrLth7e5T3Pd/8WVxgBRrRT5m1C71LOIXG9CdU=;
 b=D9ULHnmQsYkCHc6N7tLJA2ADQ0YF4quvLS5nQnlUSUvG/3tg5bVF7zY3giQvI7TxGW
 4dEjoM9Cn0LbD9FaoluIaU0YDJcCmhHu+fNCXP+nzStjFXBzR5t/D3niJQ+S4Ufb0V9X
 K5bk7fGb9zEcKHseIJibnYNcIAlYmsnxPdw477sWgRB1nsLRpb6ybPWR8etEs8FBuKJ+
 RxC3ZRR8U8J46VO06QGlbShUo4FQxhwXH9Y2yv19nudEj/XF426Y/itHKTYzNjLFQnz/
 rTdPmkB0i1ZsGvCEMuUXwj8+i3okmkWyu/J8fjuG3CBwmwpWmn5LwXTWEmdFDmAEqW8H
 gIrg==
X-Gm-Message-State: AOJu0YyHZ4PbFkCglRRV8JWC6ZYj7XIbIEKN+syuxx1pmibKkpHlLSmG
 nQymEOZURAzGDnJ+jXMGa6bv59JxJcX7PSlFA/Y=
X-Google-Smtp-Source: AGHT+IG4GC7sLoyvj4v1rbVa8oPN+en8HFEtEHRZhRchV9y+p1dMzx2deXWqcCVHHy+6KF4exJ4+8g==
X-Received: by 2002:a05:6402:26d4:b0:53d:e1d9:a11 with SMTP id
 x20-20020a05640226d400b0053de1d90a11mr1666469edd.35.1697807014109; 
 Fri, 20 Oct 2023 06:03:34 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 bx14-20020a0564020b4e00b0052ff9bae873sm1415053edb.5.2023.10.20.06.03.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:03:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/9] hw/arm/pxa2xx: SysBus/QDev fixes
Date: Fri, 20 Oct 2023 15:03:21 +0200
Message-ID: <20231020130331.50048-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Missing review: 6-9

Hi,

Extracted from a bigger series which enforce QDev state machine
(qdev instance must be realized before external API is used on
it).

While here, pxa2xx i2c/intc devices received some qdev fondness.

Since v3:
- Added Thomas R-b tags

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


