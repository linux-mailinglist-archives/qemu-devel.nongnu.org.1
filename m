Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F19542CA
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Aug 2024 09:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serPh-0007Rl-NE; Fri, 16 Aug 2024 03:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1serPf-0007N2-9y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:30:19 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1serPc-0005Cm-Mh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:30:19 -0400
DKIM-Signature: a=rsa-sha256; bh=ESf9+WorO2fP3G+BO4K7PMyiivcJoU67Iz781a+uYwQ=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1723793413; v=1;
 b=KWliRnUUEXHMbffxMibLJ5JQHrAr0MbdQ6pHS3aqopkyPibTqLg0iRlksJKuIqJ949q18Iu7
 +Q8do48igN9V5/BrGklfaXZQgyaCAKEY2N/NqjVjIqfGvkB6Bqo5PH/HZ5fV2a6/h9jFIZozmqv
 Pe9YX99/9SMYmNlUuxpMalD/KO9B3MBQ3UXt8UI9QGKUHDhW/WxryaHYKG/cN5Ll7J28xu7wOt7
 b5yzhXclLG4IWTcvOasLb+EWJmvZJfPL8y4UiRTIelX8WHQ9lKcxXdXQ2NZ3FakSysVLDNkSNUu
 mJIu1LCiNzehR5X/VyGGxD/AkY8SQFBFwuImBJbjkDpkw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 0D09020316;
 Fri, 16 Aug 2024 07:30:13 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Fri, 16 Aug 2024 07:30:12 +0000
Subject: [PATCH qemu v4 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
MIME-Version: 1.0
Message-ID: <172379341272.30818.9359380874395527120-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~liuxu <liuxu@nucleisys.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Last reply: https://lists.gnu.org/archive/html/qemu-
devel/2024-08/msg01631.html

This version no longer separates the implementation of Zilsd and Zclsd
extensions.

lxx (1):
  target/riscv: Add Zilsd and Zclsd extension support

 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg.h                    |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 +-
 target/riscv/insn_trans/trans_zilsd.c.inc | 128 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  16 +++
 target/riscv/translate.c                  |   1 +
 7 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.45.2

