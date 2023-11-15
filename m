Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 474FB7EC564
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 15:35:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Gxj-0005OB-0x; Wed, 15 Nov 2023 09:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.hsu@sifive.com>)
 id 1r3Gxh-0005Nu-1c
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 09:33:49 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.hsu@sifive.com>)
 id 1r3Gxf-0000nu-3a
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 09:33:48 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso723212b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1700058825; x=1700663625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ecRHMGZirFSvepW+2l+0SMlprMm5YizFJNQAXE+cbQ=;
 b=N24Uwzn84dHeT68TGfoGaiqo6388a3O6kYexdLH9N88ujA/3rxZ2S62wIbT+okMHf3
 eBXrjPdKNQPHYjmKEURXo7efOcQkT45WsRMq3Dz9xsb89KdPkjMcJT+Lsx4EWKVeofAV
 Epkw1+Te4Qt0+/1QMN4OHWGUbtQls+RgmfOsAxaqAuX/sdP18UyvHWTyd4qZvFFww4dA
 L5LY32sUFeSMAX4Sg/S1yuY/uh/pjqOSRTxzaQADaISKRkLL4A87sJLBf+PwycndREwR
 jI8ptNiFuAbR+3Zxj6sXAFnygXeccLSjhP57KNOkViDfoH2w8RkvSp8QMOzbCjGDA9GZ
 sLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700058825; x=1700663625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ecRHMGZirFSvepW+2l+0SMlprMm5YizFJNQAXE+cbQ=;
 b=a0Q0dKb2lFs9KD/JVEwWSMwW7vsx82PSuLEPfBEU6BtGWS12uacL21a+Tbc+aa5T3s
 OPqzwqnaDaYTQq2W8OFPD7FuwyujdJaV20s9MaXeEkr5ZETOg67LsCKrf58xnMji2ZoD
 sw32b04E5K8LF0Thrgi8L5qESc5FMXQo8ewUSivvwD3qVqnhySP2B2ug8FmTD4pA7xoy
 BNxhqV548fnrZmmLT0FmZ5fWFH47wGYg5oeuAzDYywU+bldZwoVDhpGDqSIWTQKpd4h5
 p0hFC/aVEECTRJWE3LUqqfQtGikch54zdW+N0w3UM8/ECH6tu+BCQ9TeZ0phHiNsCy6c
 QZTg==
X-Gm-Message-State: AOJu0YwUz+DQNdNjSbCQ7fwDctrQNOpOxUNMKk0IjtslhPi86JaAU1pc
 XmK7akOkTZMVIWe93rhxrJ9LjA==
X-Google-Smtp-Source: AGHT+IGDI9e1i9NcSH7F0df+8g7dzZzYuT7DZu9d/GxQk5D8KgSY7D9laVOhUWJ/f9CrHl01ZwigNw==
X-Received: by 2002:aa7:8fa7:0:b0:690:f877:aa1e with SMTP id
 t39-20020aa78fa7000000b00690f877aa1emr6149825pfs.12.1700058824680; 
 Wed, 15 Nov 2023 06:33:44 -0800 (PST)
Received: from maxhsu-SiFive.. (61-230-7-62.dynamic-ip.hinet.net.
 [61.230.7.62]) by smtp.gmail.com with ESMTPSA id
 r2-20020aa78b82000000b006c871f3ad1csm1443496pfd.71.2023.11.15.06.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 06:33:44 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Frank Chang <frank.chang@sifive.com>, qemu-arm@nongnu.org,
 Greentime Hu <greentime.hu@sifive.com>, qemu-devel@nongnu.org,
 Max Hsu <max.hsu@sifive.com>
Subject: [PATCH 0/2] hw/pci-host: Fix Designware no address match behavior
Date: Wed, 15 Nov 2023 22:33:39 +0800
Message-Id: <20231115143341.13068-1-max.hsu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.hsu@sifive.com; helo=mail-pf1-x42f.google.com
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

IMX6DQRM Rev4, in chapter 48.3.9.1, specifies that iATU is instantiated
inside the PCIe core, translating TLPs in and out of the PCIe core.

Currently, the model faces issues with TLPs using memory addresses not
registered on the iATU.
The Designware spec (48.3.9.2 for outbound, 48.3.9.3 for inbound)
mentions that TLPs should continue without address translation.

For inbound access, model uses iATU inbound region 0 for dummy access.
However, the Linux Kernel Driver is unaware, leading to the disabling
of this region, blocking TLPs.

For outbound access, the model didn't implement this, blocking any
access outside the iATU outbound list.

This patch series addresses these issues separately for inbound and
outbound. After applying the patches, the model has been tested with
the e1000e Ethernet card, ensuring proper functioning of network
transmissions and MSI interrupts.

Signed-off-by: Max Hsu <max.hsu@sifive.com>

Max Hsu (2):
  hw/pci-host: Designware: Fix inbound iATU no address match behavior
  hw/pci-host: Designware: Add outbound iATU no address match behavior

 hw/pci-host/designware.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

-- 
2.34.1


