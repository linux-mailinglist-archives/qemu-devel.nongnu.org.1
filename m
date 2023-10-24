Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D1B7D4A1F
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCnx-0001Vs-Lu; Tue, 24 Oct 2023 04:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCnv-0001VK-OH
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:23 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvCnn-00012J-Sr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:30:23 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c4fe37f166so60393071fa.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698136213; x=1698741013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DofkXsCTvbZe2X7DyAN5f8buT8fMjFe1M1dZcn34LJc=;
 b=Fc9NeE5z7qkq2QVnCeJIsjsEXVsXdchnLDiiuRbnAoKYWP9yft2ZVoVAnu2nzoQ/+k
 7SPI84kU8NJC6nfFaiuQF0kD0VF4UasEEyqZrq3axwSqzqD9z963sRL+h/uro8aQspMP
 yMSdhvjt7T21genyf2E/5/h3EnndODzaOjRqFrG1N1cW6ewLx1F6JzkypODyok/wMnjT
 pJd8SPKaeYZVh2EAUm95tWVz37nO6PXmpeeryG6FZa1J661EiSyYPfpr+UjvoHhqDPgy
 lzLtRn4umnbNoXgRf8eMjeYOwTxr9BLbmbbS+k8/OOM2vBcQf4RxrNCm2DPY8+9yUxj1
 EIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136213; x=1698741013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DofkXsCTvbZe2X7DyAN5f8buT8fMjFe1M1dZcn34LJc=;
 b=MDFMe3lYt4blOrgb5TALKcSVY0eO0xMIIPomFNfnWFznXmkVDdAKNTw9o9J+2Dk9ue
 1fq5DeScMLVdkJi8Rs9ThCoY0dD9exY989HVcW6saDF7HqbnLlWKVLIP6dBa9VvJVL4U
 zbkb+Qj7DuwbG0QUTORKo1qxD8c9CUZB1xP3trF3v66eSAbo2C1Oo8aPIxmXaiLNNike
 iKfPFOrXdFsPtbRVTT0EtbucNjf3GAV9cvf0c6O5dkck4zSULfU+9CSyraTWK0rR/VHJ
 P49xthJpT0nKnOFpdCEleLYPWNxlvc0rkTr5mRRbt9JE/pLEA0lN/xbCKDPNN3EHnLvr
 ss1w==
X-Gm-Message-State: AOJu0YwwFqbat8/y27nQ7ekUy+J0eji2LU5zf+keKER/BP/Icy5YLu96
 y5t7DTWn8ySZRpt/aNpez64Gpd920d9voyCgCjg=
X-Google-Smtp-Source: AGHT+IEgNY1lNhKaqiH+XySTlojRe1Utg4H3Xo25xIKq+RgKfHPG7n44lrGJNEoOexcW8reoaHsp6w==
X-Received: by 2002:a2e:a7cc:0:b0:2c5:fb9:49b6 with SMTP id
 x12-20020a2ea7cc000000b002c50fb949b6mr11124885ljp.10.1698136213130; 
 Tue, 24 Oct 2023 01:30:13 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040531f5c51asm11506348wms.5.2023.10.24.01.30.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 01:30:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw/m68k: Strengthen QOM/SysBus API uses
Date: Tue, 24 Oct 2023 10:30:03 +0200
Message-ID: <20231024083010.12453-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

All series reviewed.

v2:
- Addressed Thomas comments in patches 1-2
- Added R-b tags

Avoid QOM objects poking at each other internals:
- Pass "link" properties
- Access MMIO via SysBus API
- Simplify using sysbus_create_simple()

Philippe Mathieu-Daudé (6):
  hw/m68k/irqc: Pass CPU using QOM link property
  hw/m68k/mcf5206: Pass CPU using QOM link property
  hw/m68k/mcf_intc: Expose MMIO region via SysBus API
  hw/m68k/mcf_intc: Pass CPU using QOM link property
  hw/m68k/next-cube: Do not open-code sysbus_create_simple()
  hw/m68k/virt: Do not open-code sysbus_create_simple()

 include/hw/intc/m68k_irqc.h |  1 +
 hw/intc/m68k_irqc.c         | 10 +++++++++-
 hw/m68k/an5206.c            |  6 ++++--
 hw/m68k/mcf5206.c           |  9 ++++++++-
 hw/m68k/mcf_intc.c          | 21 ++++++++++++++-------
 hw/m68k/next-cube.c         |  9 ++-------
 hw/m68k/virt.c              |  9 ++++-----
 7 files changed, 42 insertions(+), 23 deletions(-)

-- 
2.41.0


