Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94CA7C6A56
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsVM-000787-R2; Thu, 12 Oct 2023 06:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVI-00077B-7d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVF-0006xY-Ev
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4066241289bso8382345e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697104871; x=1697709671;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/uDNKhg8CJ8x2YA34QcwAjMiq7D5MjiTEYuva1JakdA=;
 b=k8fjYTAGYxBpLxO2l1kW3o2u7OjW8AQKyhFPcWlGOdlLRW18px+Pb+8AXO3S6/LxFl
 EvNCeQSUzVjMivULoM3UlHRWOHT7LoovQIL3BHcpbLUQZlC8wwqZcjxdO4qkOkwTRecF
 QJoVv8G2sBcYHQvsjOXjAu+1imvXcbkiesGI1LuAVIgzDez7CfEYBTHrnOypt3vk2B6V
 e2EM/Bwl8FPkBMq9yk2wsyTb4FcSrC7MmCO1L71R5FHlV+wGxzvXxUCmM36kljLdiesF
 UWKMqHxgXjS8o8WeMj5yi6UfoBvCU+ayWi0/o3vQfwrZ6A7pWATK/rIPDJlaY5DZPneX
 P6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697104871; x=1697709671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uDNKhg8CJ8x2YA34QcwAjMiq7D5MjiTEYuva1JakdA=;
 b=gznO9EF8UT9MfLpeq4GGhfWVnDMiT6bbUwJyszmV8heP6F5Ht1nJZ3aNBI3vharRtG
 K9PWyOv4krqpCv/JSXfe+zUU1xiVo8eKpvQIpIMMnR4ZJRgSjSsZcq8CwOFTbiTdZR0Z
 QIQkH4np5Ke3Qy4RpUomWJxkEBsdZQZ0LPeHo8uFLRMN1Hwklz0onfNaQSYAfa6NkuFo
 V6AYAtG1dtmZ2ZemomEir8MFXjBXa2LG8LdHDNjdcnRwx/4G+IepUJyJQg/ym1YiOTLi
 zUtSzI/9WIwAo5ResdOvu3uL9vhTiD7WZ5+os0jQc0j64uCCOeW/iNQ8ei0RWSILQoe0
 Fz7w==
X-Gm-Message-State: AOJu0YyJL+HGpdaBTm6LJUWCZHU9Rg5OKTQ8AjRHJEpuJNs+lnHCBB5p
 vEICS9z68ONMNr389FYqYc5+lA==
X-Google-Smtp-Source: AGHT+IHQsHWZzgYE1OpYa/TQqY1copjPHn2YZxPRBrlCybNY0pgv2Z13SGfHx7X+KycA73539JQ+Hg==
X-Received: by 2002:adf:b186:0:b0:32d:819d:ec75 with SMTP id
 q6-20020adfb186000000b0032d819dec75mr4408748wra.60.1697104871451; 
 Thu, 12 Oct 2023 03:01:11 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000024c00b0032d88e370basm3803122wrz.34.2023.10.12.03.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 03:01:10 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v4 0/6] target/riscv: Add RISC-V Virtual IRQs and IRQ
 filtering support
Date: Thu, 12 Oct 2023 11:00:57 +0100
Message-Id: <20231012100103.28612-1-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x343.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[0]: https://github.com/riscv/riscv-aia/releases/download/1.0-RC4/riscv-interrupts-1.0-RC4.pdf
[1]: https://github.com/rajnesh-kanwal/opensbi/tree/dev/rkanwal/irq_filter
[2]: https://github.com/rajnesh-kanwal/linux/commits/dev/rkanwal/aia_irq_filter
[3]: https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/riscv_irq_filter

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
 target/riscv/machine.c     |   6 +
 target/riscv/tcg/tcg-cpu.c |   7 +-
 7 files changed, 547 insertions(+), 75 deletions(-)

-- 
2.34.1


