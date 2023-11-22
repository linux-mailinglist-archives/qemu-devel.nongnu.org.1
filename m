Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857A7F3D75
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:39:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwI-0002cO-1T; Wed, 22 Nov 2023 00:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwG-0002c7-1t
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:16 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwE-00079G-Cu
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:15 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc921a4632so55307475ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631492; x=1701236292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u9YB65+SsIbD9aeg7W2+4VTLFs87501Lkc+eoCafu28=;
 b=bkgwIzU0ZWE6gCK6G6dxv/qtBuXZL4nqyVujzZEip5RhcKKxbbfWroNhMmz+YGaoFZ
 zO5Syg4YcMJMXVRp3c6uLAMNXbCvnWzIuN1QJXs6Wa0ugSrh836OimZc/AuLPq+YdU4L
 KpG/i0lxxmE9zZHWURIHhgfFq9ncYdy+7u3nPpqU6t4MGktL0vOL3ZS+pnisU06oCdat
 H6E5jzhfE2hw1qwyU+yELK0MWiLZGTBsOv79eIOh5OoVa0grXlqnbHz/imE/MoOfM0U+
 KqXrBa9yAZI2JaPzKlzh7iB1C7fcIO/c79o1EJ06HsXMylNLdKa6vWWhp21uTyy155LY
 cetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631492; x=1701236292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9YB65+SsIbD9aeg7W2+4VTLFs87501Lkc+eoCafu28=;
 b=XMZKqZKaElbL5YmIkm/g9uPiIgcTpNCS2+qveaKPoHFPWF/UTEo/PihIX+nBeY/gJm
 HBI6EBOHQbSqI8VXDu8z/dRYDCIsRyizJGur69/mVI3Gipnj3+wMJAABzmAC99dLDRY+
 M5X3sy2GxHmxURj14TvlEjjNF9q7C2KdfR9l9KXAgTOvjNpQ8avo+cxG2s2QQNahshls
 Lq+eR6MgL5/+VaJCbI1kuhnvNeD63Z47TXtQ7cDJFAj2+66JvSypaFTx1E+cilHp0BN8
 4G0wlR/9LykZ20GWLXxJ48aw3UH6mtqURsRoBRxPX0ho7TM4hi6Q9fH1cPQ2aTFP1+Ye
 d2DA==
X-Gm-Message-State: AOJu0YzuyfJjjUtb+OeGmQmON0Bwgc6PORAQPswhJQ7NPCBWDUdawkiN
 vSncejBv4QJcR+i7NRADdJPdRDVBRQW4vA==
X-Google-Smtp-Source: AGHT+IGqw4zdTKs6DD0pb1acAJi4sT7A6u+L86W9wSk9qc09pTceEwB1ntyrNxyTbDnL8RaZobYT+g==
X-Received: by 2002:a17:902:b489:b0:1cf:64c0:6384 with SMTP id
 y9-20020a170902b48900b001cf64c06384mr1232280plr.69.1700631491978; 
 Tue, 21 Nov 2023 21:38:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:10 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/6] riscv-to-apply queue
Date: Wed, 22 Nov 2023 15:37:54 +1000
Message-ID: <20231122053800.1531799-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 8fa379170c2a12476021f5f50d6cf3f672e79e7b:

  Update version for v8.2.0-rc1 release (2023-11-21 13:56:12 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20231122

for you to fetch changes up to 6bca4d7d1ff2b8857486c3ff31f5c6fc3e3984b4:

  target/riscv/cpu_helper.c: Fix mxr bit behavior (2023-11-22 14:03:37 +1000)

----------------------------------------------------------------
Fourth RISC-V PR for 8.2

This is a few bug fixes for the 8.2 release

* Add Zicboz block size to hwprobe
* Creat the virt machine FDT before machine init is complete
* Don't verify ISA compatibility for zicntr and zihpm
* Fix SiFive E CLINT clock frequency
* Fix invalid exception on MMU translation stage
* Fix mxr bit behavior

----------------------------------------------------------------
Clément Chigot (1):
      target/riscv: don't verify ISA compatibility for zicntr and zihpm

Daniel Henrique Barboza (1):
      hw/riscv/virt.c: do create_fdt() earlier, add finalize_fdt()

Ivan Klokov (2):
      target/riscv/cpu_helper.c: Invalid exception on MMU translation stage
      target/riscv/cpu_helper.c: Fix mxr bit behavior

Palmer Dabbelt (1):
      linux-user/riscv: Add Zicboz block size to hwprobe

Román Cárdenas (1):
      riscv: Fix SiFive E CLINT clock frequency

 hw/riscv/sifive_e.c        |  2 +-
 hw/riscv/virt.c            | 71 +++++++++++++++++++++++++++-------------------
 linux-user/syscall.c       |  6 ++++
 target/riscv/cpu_helper.c  | 54 +++++++++++++++++------------------
 target/riscv/tcg/tcg-cpu.c |  9 ++++++
 5 files changed, 85 insertions(+), 57 deletions(-)

