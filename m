Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4657161A1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:23:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zGI-0002MC-7u; Tue, 30 May 2023 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFc-0001zQ-BH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:02 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFR-0006p5-OA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:56 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f4f89f71b8so2922162e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1685452727; x=1688044727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AdB1R3GwSXKwMts3lsX24zW2X1lAeBTH8CNKugZAd50=;
 b=aMPw3xk9e/1Og9dHePHuMVNU9JOVdA+tKj65Z1WG6i1PhpnQRm0tngLcXdNCD9Kh56
 izY3VZRez8Xn4VqbRc047qlTPwkdFkurHkUVJSZ5fE+0HhexQCl7IbCoOyS9MXgZDlxF
 nyK6jIfpVW+ckKRAh0r8uVcbln6ItFR5QL2E0zE0+I/9lAcRuECDPWwYffonh8euiGEz
 uDeut6KcF7rtaoflNBN9aXT7TAImnInGXAnQape46z+UUaqYAL9wSZJA2ViBNdAjamnL
 1orUAXVyXrzr1qXrPyZs9QjbHYgGQUTMfZ/uRLqRaINj0OcrWNwV01YBU/L3AMpCYLk0
 7l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452727; x=1688044727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AdB1R3GwSXKwMts3lsX24zW2X1lAeBTH8CNKugZAd50=;
 b=OLB5sTWYQq5cO2haRwKOhv7Z903Igp8EKQlX5TShDRagj0T+lZMAM+Zw/Lq0g7N/Xt
 RQYLJWhZYy44uflyMYBkpbCwYKAEwrhdrbxI0v5VAyfs0Tfz9QreQcnIqmTR4S/C8Ven
 Dw3stBGaRI+8NUYmYWCGNeOhzlRZUepIm6TkuVwDP4HyLeOYAp2l8YZG2m9ExeVhCDUC
 TiqmQ5Z3qL8qemmWoHUHeDAW4GxXzTgZg+eOdBCSIrThgPOH1O0SBGe3F5tYrafmNNPh
 +xjc0QCNXRZOPWbeA6kwXT7P+ITrrXDEP7nB3hay7GiXflhkuSvbhCgAHnFJ8A5vmbGI
 XFHg==
X-Gm-Message-State: AC+VfDyijDAcu4ft+GFmGazlrx/OTheenf6fZvH+K8fYgaMF/ufK/07J
 goLTHxeF3PVDGimZ6u6C4Ig1MQ==
X-Google-Smtp-Source: ACHHUZ5kd0Jia3ed5Cy+bYfEihtlIPhXWW32nNpsbPfWHyyvSl4ro/Pv8X1ltnMSvF0E6AmWGLbUIA==
X-Received: by 2002:a2e:9c18:0:b0:2a7:a719:5943 with SMTP id
 s24-20020a2e9c18000000b002a7a7195943mr699169lji.40.1685452726832; 
 Tue, 30 May 2023 06:18:46 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170907170800b0096f803afbe3sm7376156ejc.66.2023.05.30.06.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:18:45 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 0/9] disas/riscv: Add vendor extension support
Date: Tue, 30 May 2023 15:18:34 +0200
Message-Id: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-lf1-x12d.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

This series adds vendor extension support to the QEMU disassembler
for RISC-V. The following vendor extensions are covered:
* XThead{Ba,Bb,Bs,Cmo,CondMov,FMemIdx,Fmv,Mac,MemIdx,MemPair,Sync}
* XVentanaCondOps

So far, there have been two attempts to add vendor extension support
to the QEMU disassembler. The first one [1] was posted in August 2022
by LIU Zhiwei and attempts to separate vendor extension specifics
from standard extension code in combination with a patch that introduced
support for XVentanaCondOps. The second one [2] was posted in March 2023
by me and added XThead* support without separating the vendor extensions
from the standard code.

This patchset represents the third attempt to add vendor extension
support to the QEMU disassembler. It adds all features of the previous
attempts and integrates them into a patchset that uses the same
mechanism for testing the extension availability like translate.c
(using the booleans RISCVCPUConfig::ext_*).
To achieve that, a couple of patches were needed to restructure
the existing code.

Note, that this patchset allows an instruction encoder function for each
vendor extension, but operand decoding and instruction printing remains
common code. This is irrelevant for XVentanaCondOps, but the patch for
the XThead* extensions includes changes in riscv.c and riscv.h.
This could be changed to force more separation with the cost of
duplication.

The first patch of this series is cherry-picked from LIU Zhiwei's series.
It was reviewed by Alistair Francis and Richard Henderson, but never
made it on master. I've added "Reviewed-by" tags to the commit.

I've added "Co-developed-by" tags to those commits that are derived
from the series of LIU Zhiwei.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2022-08/msg03662.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04566.html

Christoph Müllner (8):
  target/riscv: Factor out RISCVCPUConfig from cpu.h
  disas/riscv: Move types/constants to new header file
  disas/riscv: Make rv_op_illegal a shared enum value
  disas/riscv: Encapsulate opcode_data into decode
  target/riscv/cpu: Share RISCVCPUConfig with disassembler
  disas/riscv: Provide infrastructure for vendor extensions
  disas/riscv: Add support for XVentanaCondOps
  disas/riscv: Add support for XThead* instructions

LIU Zhiwei (1):
  target/riscv: Use xl instead of mxl for disassemble

 disas/meson.build         |   6 +-
 disas/riscv-xthead.c      | 707 ++++++++++++++++++++++++++++++++++++++
 disas/riscv-xthead.h      |  28 ++
 disas/riscv-xventana.c    |  41 +++
 disas/riscv-xventana.h    |  18 +
 disas/riscv.c             | 384 ++++++---------------
 disas/riscv.h             | 297 ++++++++++++++++
 target/riscv/cpu-config.h | 159 +++++++++
 target/riscv/cpu.c        |   6 +-
 target/riscv/cpu.h        | 114 +-----
 target/riscv/translate.c  |  27 +-
 11 files changed, 1374 insertions(+), 413 deletions(-)
 create mode 100644 disas/riscv-xthead.c
 create mode 100644 disas/riscv-xthead.h
 create mode 100644 disas/riscv-xventana.c
 create mode 100644 disas/riscv-xventana.h
 create mode 100644 disas/riscv.h
 create mode 100644 target/riscv/cpu-config.h

-- 
2.40.1


