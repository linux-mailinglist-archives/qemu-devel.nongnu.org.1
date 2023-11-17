Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FF7EEC8E
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3t6X-0005Ke-GL; Fri, 17 Nov 2023 02:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6M-0005Ie-Li
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3t6H-0004FV-P7
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:17:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso13963715e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 23:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700205428; x=1700810228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+m6lmxVWQ7+CnkISSCc8mmJ1L+TYWYHaFStbjKV5xFQ=;
 b=mRLV8t0I4cFE6GopMH7+ctnfLaBVhDeIgusJLc8LQn4zVuxM+tiatfJhn/0XlpZ032
 9AIsWwAShPgXSJ7d4ulvwBXUmG4X9rRf/PrAx2lsWvrwhP7GLfZiClnzo4UxAccDj28W
 9R3xoQtUqeDdB8r+iU7X8qTM8lyX/z6ZMmQdqelLw/3pnp9It+MilydMDAuUPo9WQAWN
 iFRA8NYQx3KTKdxHVfotclvChls/gCPLwXU4GJzUp9pa/sNsK3jYoxjMae1ymAjC49hK
 rlGwukC4g9gk0lMtR1IP6aKV8c69937wKDRS2/EsxmdCQFwkX3XO9Mul9rWWTEpcSJk/
 RoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700205428; x=1700810228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+m6lmxVWQ7+CnkISSCc8mmJ1L+TYWYHaFStbjKV5xFQ=;
 b=O5ueC8oAFpiRzgZU1kYUI3bbbXJ+CbzvFI1kyYthuO5NuHmIgK2c8SgpDaWRUVI2R0
 AgT2zUE8+dQEq4n4xTFaiIfqQ1dxzhsRy0Uq2uigicplNM/Xb4pBqWLZmRZmnU4G34qv
 BGYk85az1ocB+dp6qf6J8YolJr9HxxrJIyySWhDEohF7bgOdsCJSo0uiWmcywSZXSpQ7
 fKdz3rAbeaQcRrHcwNs4x0jU17bJWh7SzJNplbXNK1BaywIinW+kbfvYqtnG2TS5U0kX
 YEsGMDqimca2TJxI2ftwGnxwMtJ07ZapT9GDhyQ4JSEZuMy3Bg+fgfVwz+Cf7KjpdrDD
 USPw==
X-Gm-Message-State: AOJu0Yww8YLP9MYSgOzreZhKw2p5yrkDn26BfKy4DSX29rRHfbmi3b4Q
 XF2qxyiCqaptBCNbBMrNrz7NLQR5ioz5RJxCHxQ=
X-Google-Smtp-Source: AGHT+IFKluiOaMv/BHfqtOsnieV9TxeY52XN2s7mdMPaqPgitxk70KgaSFUxMQXFqv9lzV0/cRJf+w==
X-Received: by 2002:a05:600c:4584:b0:40a:57b4:3d68 with SMTP id
 r4-20020a05600c458400b0040a57b43d68mr10888896wmo.18.1700205428084; 
 Thu, 16 Nov 2023 23:17:08 -0800 (PST)
Received: from m1x-phil.lan (bd137-h02-176-184-46-187.dsl.sta.abo.bbox.fr.
 [176.184.46.187]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c429500b0040a4cc876e0sm1654225wmc.40.2023.11.16.23.17.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Nov 2023 23:17:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Gavin Shan <gshan@redhat.com>
Subject: [PATCH-for-8.2? v2 0/4] hw/arm/stm32xxx: Report error when incorrect
 CPU is used
Date: Fri, 17 Nov 2023 08:17:00 +0100
Message-ID: <20231117071704.35040-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Series fully reviewed.

Hi,

While reviewing this [*] series from Arnaud and Inès,
I realized STM32 based boards don't check the requested
CPU type is correct, and ignore it. Possibly confusing
users.
Since these simple boards code is used as template,
I took the opportunity to sanitize it a bit, using the
MachineClass::valid_cpu_types which seems simpler (to me)
for newcomers.

Patches are candidate for 8.2 but this is a long
standing issue, not a regression from 8.1.

Regards,

Phil.

[*] https://lore.kernel.org/qemu-devel/170003673257.14701.8139061802716120109-0@git.sr.ht/

Gavin Shan (1):
  hw/core/machine: Constify MachineClass::valid_cpu_types[]

Philippe Mathieu-Daudé (3):
  hw/arm/stm32f405: Report error when incorrect CPU is used
  hw/arm/stm32f205: Report error when incorrect CPU is used
  hw/arm/stm32f100: Report error when incorrect CPU is used

 include/hw/arm/stm32f100_soc.h |  4 ----
 include/hw/arm/stm32f205_soc.h |  4 ----
 include/hw/arm/stm32f405_soc.h |  4 ----
 include/hw/boards.h            |  2 +-
 hw/arm/netduino2.c             |  7 ++++++-
 hw/arm/netduinoplus2.c         |  7 ++++++-
 hw/arm/olimex-stm32-h405.c     |  8 ++++++--
 hw/arm/stm32f100_soc.c         |  9 ++-------
 hw/arm/stm32f205_soc.c         |  9 ++-------
 hw/arm/stm32f405_soc.c         |  8 +-------
 hw/arm/stm32vldiscovery.c      |  7 ++++++-
 hw/hppa/machine.c              | 22 ++++++++++------------
 hw/m68k/q800.c                 | 11 +++++------
 13 files changed, 45 insertions(+), 57 deletions(-)

-- 
2.41.0


