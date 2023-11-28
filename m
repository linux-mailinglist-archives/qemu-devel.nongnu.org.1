Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B47FBBBF
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yHc-0001nJ-Hs; Tue, 28 Nov 2023 08:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHa-0001my-Q4
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:37:46 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHZ-0007uq-4d
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:37:46 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5482df11e73so7158733a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178663; x=1701783463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbNGDZzMkTmahEM+ics3uzeN3yQgsB5NCuwfdUgHe68=;
 b=TyCdmjCDOwn1RnFYiYf4dCStGYrjIrhsXybhAPk4hN2XB/qo3NaSJwJs6mvOLyW9Lk
 94JxnP/mki9hpB/IpRBOi68eQrgJk/DJP4qcjRlyCbJAbrsBPsnrEPKyI+1beorIcjir
 yDJLfFG7NNwFZuluFiqvgjeXJNA1Ove9hdS/6E7GGadfp8ZDGfQVUWD3kBWc1f/n8frF
 FElLBlNf3VgEPqlBzjFBbaxUxn/xyg6zv2kHViqB+lI2ClZPy7yo/oG4QJ7MIh1CQlY4
 tkKfy1BVgCFYblpUlBMBd2kwkOmSlofs9QmAaMEGXKWhHmAbOgaI7U8fD2Ij0GB9qtBb
 lHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178663; x=1701783463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZbNGDZzMkTmahEM+ics3uzeN3yQgsB5NCuwfdUgHe68=;
 b=RrJVfUArzIB8lNxLbwI1/ETnjCelwspLX/uEYL95rTfyO1fekzZkmPZPYQw6P9XyyG
 gY4tVT+H05X71NTEHkS5mkXM1u9I5aKLqnCeoYLiDkeKhY+L+enw+pEL4inq8cv2r6pL
 Rc2Y7eEmzLNDo4UFhVXrBz+6i14j7Tbr/OQujyErKNSi267fIN79QUCqHgZOKQNMHz7x
 1huogJjKFT3sEX2Z5QMCVeH+F30FOG4V4OmZQTL/Y/BzA6F0WDQIXHH5za9KVHvNPnUX
 5TteDvywOv1looYLCtouqSUmuq3oK/OKRTP9ir8AZMaU/26xMGc123c/vjCX4iF9FKwG
 N1Yg==
X-Gm-Message-State: AOJu0Yw7AzR1FYJMA3p+sGwlUiSJAuXwd2XqjV7ih370/IJpmduVHb5x
 1OkjlWxMBKXuWdNHRBQbbaZ9yv9E2GhhuSZkITc=
X-Google-Smtp-Source: AGHT+IFoYf0Zb6DWFI+pBgJON7i0az9xOX0K0jASWqZ5I5zJeVpi69XCQw7zIsbWZEIQvrgCvkRPVw==
X-Received: by 2002:a17:906:fa90:b0:9b2:be5e:7545 with SMTP id
 lt16-20020a170906fa9000b009b2be5e7545mr11295002ejb.36.1701178663251; 
 Tue, 28 Nov 2023 05:37:43 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 n27-20020a170906089b00b009fe0902961bsm6773252eje.23.2023.11.28.05.37.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:37:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/7] Misc fixes for 2023-11-28
Date: Tue, 28 Nov 2023 14:37:33 +0100
Message-ID: <20231128133740.64525-1-philmd@linaro.org>
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

The following changes since commit e867b01cd6658a64c16052117dbb18093a2f9772:

  Merge tag 'qga-pull-2023-11-25' of https://github.com/kostyanf14/qemu into staging (2023-11-27 08:59:00 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-next-20231128

for you to fetch changes up to 0180a744636e6951996240b96a250d20ad0fad0d:

  docs/s390: Fix wrong command example in s390-cpu-topology.rst (2023-11-28 14:27:18 +0100)

----------------------------------------------------------------
Misc fixes for 8.2

* buildsys: Invoke bash via 'env' (Samuel)

* doc: Fix example in s390-cpu-topology.rst (Zhao)

* HW: Fix AVR ATMega reset stack (Gihun) and VT82C686 IRQ routing (Zoltan)

----------------------------------------------------------------

BALATON Zoltan (4):
  hw/isa/vt82c686: Bring back via_isa_set_irq()
  hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts
  hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq()
  hw/audio/via-ac97: Route interrupts using via_isa_set_irq()

Gihun Nam (1):
  hw/avr/atmega: Fix wrong initial value of stack pointer

Samuel Tardieu (1):
  target/hexagon/idef-parser/prepare: use env to invoke bash

Zhao Liu (1):
  docs/s390: Fix wrong command example in s390-cpu-topology.rst

 docs/devel/s390-cpu-topology.rst   |  6 +--
 include/hw/isa/vt82c686.h          |  2 +
 target/avr/cpu.h                   |  3 ++
 hw/audio/via-ac97.c                |  8 +--
 hw/avr/atmega.c                    |  4 ++
 hw/isa/vt82c686.c                  | 79 ++++++++++++++++++++----------
 hw/usb/vt82c686-uhci-pci.c         |  9 ++++
 target/avr/cpu.c                   | 10 +++-
 target/hexagon/idef-parser/prepare |  2 +-
 9 files changed, 87 insertions(+), 36 deletions(-)

-- 
2.41.0


