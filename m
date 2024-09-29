Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70D9896B5
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Sep 2024 20:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suyKi-0003Xd-8O; Sun, 29 Sep 2024 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suyKV-0003WL-Jq
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:07:37 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suyKS-0008U7-Ql
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:07:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EE5E75C1188;
 Sun, 29 Sep 2024 18:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88D7C4CEC5;
 Sun, 29 Sep 2024 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727633243;
 bh=WNDDcwiuv4gSzeEIfI1rj90jQNxFFr3Yoykr3N3sSso=;
 h=From:To:Cc:Subject:Date:From;
 b=C2eoglBU5IO8s2JENaFxUSpXW2yK8Cq8Rt1qzHur5raW87nBFXRCGMr302JjtSima
 9nqNzTr/UfrHaonSIrGTEApFHDO55EMucEG2cEKgrehCS2wdOCB4wuSZHn2Fbos8rS
 YfbRlRhxtMwbhVmAJhNW1xqBpwNz5N5bfv3u8N7OjJu329nfBemYYP9C1RYulBuVkX
 2+PAu093lo3Vgirrxp7lbQwptHiHVrBdFk+T2uFkVZ4gGuUfE/9BXBIzV879meYroQ
 hIsxEQTAXzW267KTpwzSr7BBK8UEUS4SQrBx7yd4KkQIwqGkEjZFedlxUZscqz1CL8
 96MrdXnJg08EQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/2] Fix PVH entrypoint parsing
Date: Sun, 29 Sep 2024 20:06:56 +0200
Message-Id: <20240929180659.3598-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix the handling of the ELF note that describes the PVH entrypoint

v2: fix broken ELF note handling on big endian hosts

Ard Biesheuvel (2):
  hw/elf_ops: Implement missing endian swabbing for ELF notes
  hw/x86: Always treat the PVH entrypoint as a 32-bit LE field

 hw/i386/x86-common.c     |  7 ++-----
 include/hw/elf_ops.h.inc | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.39.5


