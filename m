Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0AA70839D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdlM-0006Kx-Mq; Thu, 18 May 2023 09:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyj-0000Bp-5P
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyg-0002VW-Oj
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-307a8386946so1279321f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684409965; x=1687001965; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ehHG0nci8MLeY8VEC4MS9K8MqfFsu3/xlF8naLYm8xY=;
 b=gdRR+FwpZIt7gUDHdknFngCQyoR51pTppnp4gaQe+M5b4cUAzYFOLfZP5+Yz+u+fnF
 3EbK5xqPFtssvQK57VoCaPkObIGUg88Bafo6ZV2egu8DFXZlR4Z3ZC7MmWK5YaLGjmmq
 +yUbtFidHO90a5/G16BrzpcLBTOiZFGtbERrPCvj/S4c0szSK/ifGrGNfCGn2061gtOV
 8psIBX3QKCk6TU9xZ3/Tp4GxptZftfXZa8q751Obn5hivxhECefczRqn2AChpFsdwePj
 1nNpf87LZHzXmzXAp6el8hV39wDFPhSr7TQx9kpuUPVxbKdPfTsa7Mtnk5XcsIfp14ny
 u5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409965; x=1687001965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehHG0nci8MLeY8VEC4MS9K8MqfFsu3/xlF8naLYm8xY=;
 b=BfiMnEZZmdjaVOIhgIIzPSVVPeypXdEm5c5ZUgAoJEd+VO8Ve/EXTiV+XkozlALoir
 ZB+uD4QJUmnEXK3f7o0dsFx1cVFo7hDkgrSKh3zQzyBfz8EeGQNUzIzKMx72X42Bi992
 vIZCgIBdqGoDL3MyY7GGb8sX0NzVjUCv9l/l2YEsYWxadwr6iQvzK2Ffxfcmm9LJ9ifT
 X1sR4P6Q+yTjGZp65eY7c4oJmzR/8e4mPFt7xrVahtUcq2Jm/cXraIZYP/xo4FEsg3Oc
 GUOdcphivs6UfetzKqd9ky6sTY0jFIPBLndRFEDimwOvxjoSrenMXK3YjKG/zjbodZVw
 AunA==
X-Gm-Message-State: AC+VfDwkAQk8EyqaD7rQyxiw7APll7Jf1062V7JlDAmut1W4Bz8GQKMY
 ZOzdtrv3/za+hylyosMkkw/lqA==
X-Google-Smtp-Source: ACHHUZ618PWvyApuQFuGsyHXL2DZoSeeXIUvwKPpQWpQjbA0Z/nYvKg5Lw/FR/yIZmAVMWuKGb23RA==
X-Received: by 2002:adf:eb09:0:b0:2ff:f37:9d0f with SMTP id
 s9-20020adfeb09000000b002ff0f379d0fmr1484486wrn.57.1684409964791; 
 Thu, 18 May 2023 04:39:24 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1c7406000000b003f4272c2d10sm5083982wmc.1.2023.05.18.04.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:39:24 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH 0/6] Add RISC-V Virtual IRQs and IRQ filtering support
Date: Thu, 18 May 2023 12:38:32 +0100
Message-Id: <20230518113838.130084-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 May 2023 09:33:46 -0400
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

This series adds M and HS-mode virtual interrupt and IRQ filtering support.
This allows inserting virtual interrupts from M/HS-mode into S/VS-mode
using mvien/hvien and mvip/hvip csrs. IRQ filtering is a use case of
this change, i-e M-mode can stop delegating an interrupt to S-mode and 
instead enable it in MIE and receive those interrupts in M-mode and then
selectively inject the interrupt using mvien and mvip.
            
Also, the spec doesn't mandate the interrupt to be actually supported
in hardware. Which allows M/HS-mode to assert virtual interrupts to
S/VS-mode that have no connection to any real interrupt events.
             
This is defined as part of the AIA specification [0], "5.3 Interrupt
filtering and virtual interrupts for supervisor level" and "6.3.2 Virtual
interrupts for VS level".

Most of the testing is done by hacking around OpenSBI and linux host.
The changes for those can be found at [2] and [3].

It's my first touch on RISC-V qemu IRQ subsystem. Any feedback would
be much appreciated.

The change can also be found on github [1].

TODO: This change doesn't support delegating virtual interrupts injected 
by M-mode to VS-mode by the Hypervisor. This is true for bits 13:63 only.

Thanks
Rajnesh

[0]: https://github.com/riscv/riscv-aia/releases/download/1.0-RC4/riscv-interrupts-1.0-RC4.pdf
[1]: https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/riscv_irq_filter
[2]: https://github.com/rajnesh-kanwal/opensbi/tree/dev/rkanwal/irq_filter
[3]: https://github.com/rajnesh-kanwal/linux/commits/dev/rkanwal/aia_irq_filter

Rajnesh Kanwal (6):
  target/riscv: Without H-mode mask all HS mode inturrupts in mie.
  target/riscv: Check for async flag in case of RISCV_EXCP_SEMIHOST.
  target/riscv: Set VS* bits to one in mideleg when H-Ext is enabled
  target/riscv: Split interrupt logic from riscv_cpu_update_mip.
  target/riscv: Add M-mode virtual interrupt and IRQ filtering support.
  target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.

 target/riscv/cpu.c        |   9 +-
 target/riscv/cpu.h        |  23 ++
 target/riscv/cpu_bits.h   |   6 +
 target/riscv/cpu_helper.c |  87 +++++--
 target/riscv/csr.c        | 477 ++++++++++++++++++++++++++++++++++----
 target/riscv/machine.c    |   6 +
 6 files changed, 541 insertions(+), 67 deletions(-)

-- 
2.25.1


