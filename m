Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4C374E103
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzKp-0003R3-9o; Mon, 10 Jul 2023 18:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzKn-0003Qq-9K
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzKl-0001ex-B3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3142970df44so4841104f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689027974; x=1691619974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W/kN92uMK+CKw86BD+zCo+HNsMkfk0oAEuRPknOkLJM=;
 b=O7+g6inl/3l5UNww37hcDIABvSmhFgtzURIriuqEOXB81zDXf5j6K6vU+uXd1tBqtn
 ICHrx4Z+oAjSGzY//jAP6G4Y7e8NN8IUL32OKonwe5J++HXTnvwjegAJuFMrV0G5MX7T
 HJ/AS/HU/SR0W0IZ431V0TfTA2s/EiwwGLuprpHZn35p6PUoIBW6e5wy50rPkCYOViFS
 TAoHFicPGFcgJ2KYVUPRBR+6imMzNfrgfIm2so63X0y01a6aOW2p4nHOu6XI+/ooHIQP
 cAaNd1cUpuzkR54QHCdPRWVU/nwNcdSP16SoiyZyS5H8zE5STF+GG3ZZjwYfOSlnRua7
 xJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689027974; x=1691619974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/kN92uMK+CKw86BD+zCo+HNsMkfk0oAEuRPknOkLJM=;
 b=FMcLiaFb/2LUeXPNQ87EHkXzZQE4ZompeOcMYi6yZFSDCsNkR8PnPHRBoMsgp1yGRE
 rWctrh3PY72foLwWU2pZhaUSxbOE1+3EtjMACbosuqilQ9+y+FJFvWPUAv7VrPNVfh38
 2ekDdLtm30U1ORGpX5zcThVr0hUl3tHtGYmVXcxabGyqjXioVp5paPdQviPeRdmv4Qun
 hvVopxy4yaGa8QdHXCzFEPinnmszS10Di/DVEL1FCxYLF8WS7lXsPgfZZmfm2NzFIpKX
 YBkEta9AUFvoGqcCEOBiuVYcUg0Y4yuKkL6pzMaLQ7iZGAV1R5MDHvqbae1RTr7A2N9W
 G/Mg==
X-Gm-Message-State: ABy/qLb7sW0wjrK5UrKxhirwa4/Qa1/HZjPgZMyE1uI+SMGnN9euMoWh
 k38c6+HEKJq4cJCpNe6TKFesd55k+orKxGBwOFcFcQ==
X-Google-Smtp-Source: APBJJlFV1rjfAygnYrdsT4344BlBCEgWy1/XENH6QTkJuZWLXWrf5Ey1pfHiZ5goZ2QSfTM0/o6L0g==
X-Received: by 2002:adf:cd09:0:b0:314:e929:bcb9 with SMTP id
 w9-20020adfcd09000000b00314e929bcb9mr10511953wrm.57.1689027974253; 
 Mon, 10 Jul 2023 15:26:14 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 c3-20020a5d4cc3000000b00311299df211sm516934wrt.77.2023.07.10.15.26.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 00/44] MIPS patches for 2023-07-10
Date: Tue, 11 Jul 2023 00:25:27 +0200
Message-Id: <20230710222611.50978-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:

  Merge tag 'pull-vfio-20230710' of https://github.com/legoater/qemu into staging (2023-07-10 09:17:06 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20230710

for you to fetch changes up to 752dfff5ecf35a38145c2dfbb842224177fd1afd:

  hw/ide/piix: Move registration of VMStateDescription to DeviceClass (2023-07-11 00:11:25 +0200)

----------------------------------------------------------------
MIPS patches queue

- Use clock API & divider for cp0_timer to avoid rounding issue (Jiaxun)
- Implement Loongson CSR instructions (Jiaxun)
- Implement Ingenic MXU ASE v1 rev2 (Siarhei)
- Enable GINVx support for I6400 and I6500 cores (Marcin)
- Generalize PCI IDE controller models (Bernhard)

----------------------------------------------------------------

Bernhard Beschow (7):
  hw/ide/pci: Expose legacy interrupts as named GPIOs
  hw/ide/via: Wire up IDE legacy interrupts in host device
  hw/isa/vt82c686: Remove via_isa_set_irq()
  hw/ide: Extract IDEBus assignment into bmdma_init()
  hw/ide: Extract bmdma_status_writeb()
  hw/ide/pci: Replace some magic numbers by constants
  hw/ide/piix: Move registration of VMStateDescription to DeviceClass

Jiaxun Yang (3):
  target/mips: Rework cp0_timer with clock API
  target/mips: Implement Loongson CSR instructions
  hw/mips/loongson3_virt: Relax CPU restrictions for TCG

Marcin Nowakowski (1):
  target/mips: enable GINVx support for I6400 and I6500

Siarhei Volkau (33):
  target/mips: Add emulation of MXU instructions for 32-bit load/store
  target/mips: Add support of two XBurst CPUs
  target/mips/mxu: Add LXW LXB LXH LXBU LXHU instructions
  target/mips/mxu: Add S32MADD/MADDU/MSUB/MSUBU instructions
  target/mips/mxu: Add Q8SLT Q8SLTU instructions
  target/mips/mxu: Fix D16MAX D16MIN Q8MAX Q8MIN instructions
  target/mips/mxu: Add S32SLT D16SLT D16AVG[R] Q8AVG[R] insns
  target/mips/mxu: Add Q8ADD instruction
  target/mips/mxu: Add S32CPS D16CPS Q8ABD Q16SAT insns
  target/mips/mxu: Add D16MULF D16MULE instructions
  target/mips/mxu: Add D16MACF D16MACE instructions
  target/mips/mxu: Add D16MADL instruction
  target/mips/mxu: Add S16MAD instruction
  target/mips/mxu: Add Q16ADD instruction
  target/mips/mxu: Add D32ADD instruction
  target/mips/mxu: Add D32ACC D32ACCM D32ASUM instructions
  target/mips/mxu: Add D32ADDC instruction
  target/mips/mxu: Add Q16ACC Q16ACCM D16ASUM instructions
  target/mips/mxu: Add Q8ADDE Q8ACCE D8SUM D8SUMC instructions
  target/mips/mxu: Add S8STD S8LDI S8SDI instructions
  target/mips/mxu: Add S16LDD S16STD S16LDI S16SDI instructions
  target/mips/mxu: Add S32MUL S32MULU S32EXTR S32EXTRV insns
  target/mips/mxu: Add S32ALN S32LUI insns
  target/mips/mxu: Add D32SARL D32SARW instructions
  target/mips/mxu: Add D32SLL D32SLR D32SAR instructions
  target/mips/mxu: Add Q16SLL Q16SLR Q16SAR instructions
  target/mips/mxu: Add D32/Q16- SLLV/SLRV/SARV instructions
  target/mips/mxu: Add S32/D16/Q8- MOVZ/MOVN instructions
  target/mips/mxu: Add Q8MAC Q8MACSU instructions
  target/mips/mxu: Add Q16SCOP instruction
  target/mips/mxu: Add Q8MADL instruction
  target/mips/mxu: Add S32SFL instruction
  target/mips/mxu: Add Q8SAD instruction

 include/hw/ide/pci.h                 |    1 +
 include/hw/isa/vt82c686.h            |    2 -
 target/mips/cpu.h                    |   45 +-
 target/mips/helper.h                 |    4 +
 target/mips/internal.h               |    2 +
 target/mips/tcg/translate.h          |    1 +
 target/mips/tcg/sysemu_helper.h.inc  |    8 +
 target/mips/tcg/lcsr.decode          |   17 +
 hw/ide/cmd646.c                      |    3 +-
 hw/ide/pci.c                         |   16 +
 hw/ide/piix.c                        |    8 +-
 hw/ide/sii3112.c                     |    7 +-
 hw/ide/via.c                         |    9 +-
 hw/isa/vt82c686.c                    |   11 +-
 hw/mips/loongson3_virt.c             |    4 +-
 target/mips/cpu.c                    |   18 +-
 target/mips/sysemu/cp0_timer.c       |   35 +-
 target/mips/tcg/lcsr_translate.c     |   75 +
 target/mips/tcg/mxu_translate.c      | 3761 +++++++++++++++++++++++++-
 target/mips/tcg/op_helper.c          |   16 +
 target/mips/tcg/sysemu/lcsr_helper.c |   45 +
 target/mips/tcg/translate.c          |   10 +-
 target/mips/cpu-defs.c.inc           |   59 +-
 target/mips/tcg/meson.build          |    2 +
 target/mips/tcg/sysemu/meson.build   |    4 +
 25 files changed, 4001 insertions(+), 162 deletions(-)
 create mode 100644 target/mips/tcg/lcsr.decode
 create mode 100644 target/mips/tcg/lcsr_translate.c
 create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c

-- 
2.38.1


