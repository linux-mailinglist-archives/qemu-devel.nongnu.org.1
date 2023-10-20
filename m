Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D67D123B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr5A-0005aP-31; Fri, 20 Oct 2023 11:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr58-0005a3-Dy
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:34 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtr56-0001Kw-RF
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:34 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b95622c620so145350466b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697814390; x=1698419190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P69VzEorpXddKrG2FGgSVDMQ6Av1xOCOUL1LBQdSnIQ=;
 b=uXEzxWEG8Ajcn4LK41LkHSzxhES94aNUSkACq2hVl7MHGY/HvjXtfqykJgP6DQcTxL
 wsB/zbHpZ1EqAv1B6AHDhAoXvxRhAp4McmF79FyNuf/It4buMQpfPrc0pxTZY0/SqOju
 IgxpMr4OhIbla/3NQRq8/3COc+VevigLPkWyX4oeKiLv9brEj0v2zd0RFAwqGdWrNfxI
 U9X+xcCooHDvutGVkhFjWu72F0v6PjgezhT8Urqxyo4enNUYEdXFYUTuAP52gJZg+WU4
 irRSHSDRLFOvyoYCGV/bTqpMc0Knj6+RiCD1CYVcpYYHoD5MDrwPCbiF+6v3SNjCh6mw
 e7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814390; x=1698419190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P69VzEorpXddKrG2FGgSVDMQ6Av1xOCOUL1LBQdSnIQ=;
 b=QYT2xRCE5X8Lo/OOXUucJuld0AtIAbuGeNUnFLrwsrmRV+u4eqbha7s6Es+PyqJaFX
 y0/F9kvS0Ss7jK0PFQjrnjw6LPKLgS+AhLs/41UG0ZxqLEunjTOJPS5qcamx2J6vlB9r
 e0BSeQlT8a1I4cE2gn8q+GoBCS402rZyQFAulSh90o1YcTtYL+X7YGPnJ7FYktnoZNYU
 4DV8Oahiiys6Z3IkacqHzUxm9KH2YDDV7gmy4fjIajQULGESPYKiH8GA7g6Y2Lmiz4Da
 MH1PrwmmwXTLYEs2en+dwFNU95fK/DZmUDv/38H3A7n7QdeYBLnU49vn8+/DZ830qjkr
 7fNw==
X-Gm-Message-State: AOJu0YwbwucRbWaAsVR8lXdCJnO29XZ5UESx+PsOrxo2Sf1CC9Rq0K4s
 /gBMkJdJyGwXVkOHT+LTqiFWeTARjqXwCDUUt68=
X-Google-Smtp-Source: AGHT+IGZeVOPbhQN3+bHNe5Lk0VF5sl+QK9iAnws+0el05EdLlA/sWmVW9O/TgAFlx91prjrMvtAwA==
X-Received: by 2002:a17:907:d38a:b0:9ad:ef08:1f32 with SMTP id
 vh10-20020a170907d38a00b009adef081f32mr1437459ejc.37.1697814390326; 
 Fri, 20 Oct 2023 08:06:30 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 o1-20020a170906774100b009c6e58437dasm1680331ejn.37.2023.10.20.08.06.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 08:06:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] hw/m68k: Strengthen QOM/SysBus API uses
Date: Fri, 20 Oct 2023 17:06:20 +0200
Message-ID: <20231020150627.56893-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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
 hw/m68k/an5206.c            |  2 ++
 hw/m68k/mcf5206.c           |  9 ++++++++-
 hw/m68k/mcf_intc.c          | 21 ++++++++++++++-------
 hw/m68k/next-cube.c         |  9 ++-------
 hw/m68k/virt.c              |  9 ++++-----
 7 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.41.0


