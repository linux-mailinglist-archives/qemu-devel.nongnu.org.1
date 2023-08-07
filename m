Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E4771D5A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwoE-0006xu-28; Mon, 07 Aug 2023 05:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwnx-0006pP-SF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:48 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qSwnw-0002tT-D5
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:45:37 -0400
Received: from develop.s.cslab.moe (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 78CC643B72;
 Mon,  7 Aug 2023 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691401533; bh=gYkUBboKGeQHmJF8vaRINbjgPkMVtEXG2nHL2PZAosY=;
 h=From:To:Cc:Subject:Date;
 b=PXuK1MX5gN0/KorEs7i+skaIYNVnX0cmXamuuJumiTmArewQ9jzxBUQbUjQP0IRlA
 GE/oelZXXXq+9E8tiYpeFJUNI4iQw0sVKq3VW0R7WinAbwV9VPfiA/+r0j6/UXaOsq
 33D176MUJfvE/YfytyqGXF1funhRLuLC4ba1zJb8=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v3 0/6] Add loongarch32 mode for loongarch64-softmmu
Date: Mon,  7 Aug 2023 17:44:59 +0800
Message-Id: <20230807094505.2030603-1-c@jia.je>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch series allow qemu-system-loongarch64 to emulate a LoongArch32
machine. A mode enum is added to CPUArchState to select LA32 or LA64 at
runtime. A new CPU model is added for loongarch32. Initial GDB support
is added.

Changes since v2:

- Fix typo in previous commit
- Fix VPPN width in TLBEHI/TLBREHI

Changes since v1:

- No longer create a separate qemu-system-loongarch32 executable, but
  allow user to run loongarch32 emulation using qemu-system-loongarch64
- Add loongarch32 cpu support for virt machine

Full changes:

Jiajie Chen (6):
  target/loongarch: Add loongarch32 mode for loongarch64-softmmu
  target/loongarch: Add loongarch32 cpu la132
  target/loongarch: Add GDB support for loongarch32 mode
  target/loongarch: Support LoongArch32 TLB entry
  target/loongarch: Support LoongArch32 DMW
  target/loongarch: Support LoongArch32 VPPN

 configs/targets/loongarch64-softmmu.mak |  2 +-
 gdb-xml/loongarch-base32.xml            | 45 ++++++++++++++++
 hw/loongarch/virt.c                     |  5 --
 target/loongarch/cpu-csr.h              | 22 ++++----
 target/loongarch/cpu.c                  | 51 +++++++++++++++++-
 target/loongarch/cpu.h                  | 18 +++++++
 target/loongarch/gdbstub.c              | 32 ++++++++---
 target/loongarch/tlb_helper.c           | 71 ++++++++++++++++++++-----
 8 files changed, 209 insertions(+), 37 deletions(-)
 create mode 100644 gdb-xml/loongarch-base32.xml

-- 
2.39.2


