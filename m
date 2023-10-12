Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D88C7C6DEC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquer-0002kI-Hp; Thu, 12 Oct 2023 08:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qquen-0002j7-32
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:14 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqueh-0001jM-4p
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so141647966b.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113140; x=1697717940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vd06sYB52yhekTeF3eyRbvf+2Ug3vpYQ4rXLu4x9Xkw=;
 b=a/OkS7nCbB0mIRw5tH9xnptcBtYKf1Z1jvByfiFdsj7wZWBlWp/ZppW78BTA2TeYIg
 AH3+VU5Cn7pOZ6w530FAVNtuYkxO/K/VoAm+SmY6g2gdlOeiky/jBrGODqheVY+pDHCJ
 bC8gvJedbUmZZyHRKutaHXKykJ8uRYEOHPAa4mB4NRWZEeAmJXoDS+Gdu1zfolwd4oSM
 W1+f7ZH46kCAVJt6De50shkGAqhNX+vuTJl6VnAe/61fUEUae6CisldHNS+ZOq9Buhxn
 kiMVyt0HL+aEZbIyRax/PJwZuAFQk8yLchFe/URvNYwrVO9wB5gxLqzXRql4QwlP5cjT
 ZurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113140; x=1697717940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vd06sYB52yhekTeF3eyRbvf+2Ug3vpYQ4rXLu4x9Xkw=;
 b=EmmaXqMsDunvDuDtHXrDl2aQFMgnq6KUrQQH7cpjMFOG0fVUALJpxgF7jFBZC/26EO
 wl33FYZbkJ92lTchzzEHtK6iDRygyRDHQ1Qfr+16AfzBD69ZEuewKy283EVE0DL3p1sf
 aIYfk6s3ud9JyMjMWrALRcynJCS9PQ9YOGVI7EtE/hcFHnB5crhqRH/iTocPsZsYoOQc
 r8xBkvUy7mi3UXhDnw3+cyMIydfjECdHKnKA9FvefoC+8y4NyuNqoysCKP8gswcb/TYl
 eWBRnhUClTHfr0PO+NOEEO+RW5ULPxF/EmWDrHh+DAwliiUQZcVga1wsCYL5YpEc+g4x
 XX/Q==
X-Gm-Message-State: AOJu0YzNp4tkNECk7NE7HVmlpJjCIYfruzPNq3nVIwwJN5y8i/yMerr+
 JYcYkbN6G/Fa/xCzPZHZKRrNkMRszkc6PpF4xdqX3A==
X-Google-Smtp-Source: AGHT+IEn6kqnnhLsAlQry+trAp5/G4K6hueC66LSEEYpPb8wvQlM5/hFStbjh/qWf/BhmKdcg4RX3A==
X-Received: by 2002:a17:907:6c14:b0:9b6:f0e2:3c00 with SMTP id
 rl20-20020a1709076c1400b009b6f0e23c00mr19423868ejc.71.1697113140094; 
 Thu, 12 Oct 2023 05:19:00 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a170906b08600b009a19701e7b5sm11036107ejy.96.2023.10.12.05.18.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:18:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] hw/pci-host/designware: QOM shuffling (Host bridge <->
 Root function)
Date: Thu, 12 Oct 2023 14:18:48 +0200
Message-ID: <20231012121857.31873-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

While trying this PCI host bridge in a hegerogeneous setup
I noticed few discrepancies due to the fact that host bridge
pieces were managed by the root function.

This series move these pieces (ViewPort and MSI regs) to the
host bridge side where they belong. Unfortunately this is
a migration breakage.

I recommend reviewing using 'git-diff --color-moved=dimmed-zebra'.

Regards,

Phil.

Philippe Mathieu-Daudé (8):
  hw/pci-host/designware: Declare CPU QOM types using DEFINE_TYPES()
    macro
  hw/pci-host/designware: Initialize root function in host bridge
    realize
  hw/pci-host/designware: Add 'host_mem' variable for clarity
  hw/pci-host/designware: Hoist host controller in root function #0
  hw/pci-host/designware: Keep host reference in DesignwarePCIEViewport
  hw/pci-host/designware: Move viewports from root func to host bridge
  hw/pci-host/designware: Move MSI registers from root func to host
    bridge
  hw/pci-host/designware: Create ViewPorts during host bridge
    realization

 include/hw/pci-host/designware.h |  20 +-
 hw/pci-host/designware.c         | 376 +++++++++++++++----------------
 2 files changed, 187 insertions(+), 209 deletions(-)

-- 
2.41.0


