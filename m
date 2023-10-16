Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EA97CA691
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsLbn-0002bf-UC; Mon, 16 Oct 2023 07:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qsLbj-0002bP-Lz
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:17:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qsLbb-0005ab-Dm
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:17:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40776b200e5so22872825e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697455061; x=1698059861;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o0X746pWBb61XQE/PyM4YL/Nc2C8wn9L+9XF0qSDLec=;
 b=sj1HQSzIuXyHrS07AoFH7gi23QYY6xUEiVZ71bBbs67dIjuMYCSWevLN2fqUwYBdMA
 hMNoRR2uTCjafvBsXM0O/wEHieDlquigA6rWhYFAKgwQhatafLBYMK3xtV//nqUIsNNG
 M21ZpyXi/RxYAgx4DcZUDCF40RWNGnwZcHuuBK2i+qZTyTTQugQwPpDOw2hbGs61GkK1
 uo/iEFFRKEZBv26uacbwfKy1qJvFkXVx2rKp3Djz0gxMRj+dkjuT5uHau6te097vOmZD
 zHPpD0Y6zUlp/GSUSkx30l6401lwC98h485m40A7RuAl+xw0lXYW/ZcIGL6ZhMLXdJUc
 hh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697455061; x=1698059861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0X746pWBb61XQE/PyM4YL/Nc2C8wn9L+9XF0qSDLec=;
 b=BCuoCPCN2J6AI/meGEgPKBFDHsKHK2tgEHCIDn2Fe7hfHrFz1FD0L9AzQAm5jx5McC
 d1Z1f3PITYGVP3Q51myCGkhFNsilhAaArTt2I2Qoe9YaI6DaRaKIirEmPx8LA6TZ/vp3
 tlGm7o/Dxf2/Nju34t68lWOITDLgQpYyCg+yZmeP1uCQHr/JA7v0Rq8Y+wWVuJgGR8JV
 kZ/OA0T+FWxVI9H1XtaGAejyza3E3Cj20iulnkPeQIpiiJwLQ4zfemMOK8h4AGHEJLCY
 6oxtR65CLj8dvDgSM5NPtU/bW35BAbG7553YUrPvSG9SRQ3RyEdGLYCmuMxIh+sdV7EX
 x5wg==
X-Gm-Message-State: AOJu0YwC2A5nyqLBI1ab3DgNec8HifwqCYoTJnOUh42JoDMcPAflxtEM
 lgG4cKCcEHySqqVgHIHHHaiDLg==
X-Google-Smtp-Source: AGHT+IHIdYSbUItU6QiNyeHZSj4SrFHJYkIKdMZs/uSSRSHC467zUCsFn4kzRxzMxPaQnfmAOur9WQ==
X-Received: by 2002:a1c:6a17:0:b0:401:db82:3edf with SMTP id
 f23-20020a1c6a17000000b00401db823edfmr28934481wmc.39.1697455060601; 
 Mon, 16 Oct 2023 04:17:40 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a056000010f00b0032daf848f68sm3114299wrx.59.2023.10.16.04.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 04:17:40 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v5 0/6] target/riscv: Add RISC-V Virtual IRQs and IRQ
 filtering support
Date: Mon, 16 Oct 2023 12:17:30 +0100
Message-Id: <20231016111736.28721-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
The changes for those can be found at [1] and [2].

It's my first touch on RISC-V qemu IRQ subsystem. Any feedback would
be much appreciated.

The change can also be found on github [3].

TODO: This change doesn't support delegating virtual interrupts injected
by M-mode to VS-mode by the Hypervisor. This is true for bits 13:63 only.

Thanks
Rajnesh

[0]: https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf
[1]: https://github.com/rajnesh-kanwal/opensbi/tree/dev/rkanwal/irq_filter
[2]: https://github.com/rajnesh-kanwal/linux/commits/dev/rkanwal/aia_irq_filter
[3]: https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/riscv_irq_filter

v5:
 * Rebased the patches onto alister/riscv-to-apply.next again. Updated
   version_id and minimum_version_id in vmstate_riscv_cpu and
   vmstate_hyper. Also updated AIA spec links.

v4:
 * Rebased the patches onto alister/riscv-to-apply.next. There were
   some rebasing conflicts due to code restructuring.

v3:
 * Rebased the patches and added reviewed-by tags.

v2:
 * Move RISCV_EXCP_SEMIHOST to switch case and remove special handling.
 * Fix linux-user build.

Rajnesh Kanwal (6):
  target/riscv: Without H-mode mask all HS mode inturrupts in mie.
  target/riscv: Check for async flag in case of RISCV_EXCP_SEMIHOST.
  target/riscv: Set VS* bits to one in mideleg when H-Ext is enabled
  target/riscv: Split interrupt logic from riscv_cpu_update_mip.
  target/riscv: Add M-mode virtual interrupt and IRQ filtering support.
  target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.

 target/riscv/cpu.c         |   4 +-
 target/riscv/cpu.h         |  23 ++
 target/riscv/cpu_bits.h    |   6 +
 target/riscv/cpu_helper.c  |  99 ++++++--
 target/riscv/csr.c         | 477 +++++++++++++++++++++++++++++++++----
 target/riscv/machine.c     |  14 +-
 target/riscv/tcg/tcg-cpu.c |   7 +-
 7 files changed, 551 insertions(+), 79 deletions(-)

-- 
2.34.1


