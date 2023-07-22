Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0475D88A
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 03:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN18t-0007cb-PT; Fri, 21 Jul 2023 21:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qN18q-0007cC-2s
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 21:10:40 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qN18o-0003uJ-41
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 21:10:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 93BE961DA7;
 Sat, 22 Jul 2023 01:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51494C433C7;
 Sat, 22 Jul 2023 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689988234;
 bh=HHkoAkj5rPgIhje4TXKZ6hXryJxQpVPFwVsaV9IzcjE=;
 h=Date:From:To:cc:Subject:From;
 b=oQH6i3TdmM94vkYJPcHKjHJwsiQpr7/PMHxbJk9FHkjnM82sLQGCYHxaErT1UG6wg
 A4D9rEV8E+OmUXV62617QRLOfEjMhMOOhCsg66x07iG+Sw/eMdJOXbq+MUSzpcOz/P
 yzUdT5jHYeVLlOkhFeFI3eb6BDfU6Q1oMTH4cjBP0fBzpvmmDG3658X0fmUASf0TQS
 gTg5Nn4SbJ3kjFu21uTY5dsvtoR6xJu2uaIQA5ORnNZzRfFTso+rSEeRfWeS/wam8x
 b2HGrL1L2TIHzjnlUSf2Cig8AAhro+U6w3rENxthoEftRHUis3XoDRJDkntNKylUso
 fJiNjj77JfXbQ==
Date: Fri, 21 Jul 2023 18:10:31 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: peter.maydell@linaro.org, richard.henderson@linaro.org
cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com
Subject: [PULL 0/2] xen-virtio-1-tag
Message-ID: <alpine.DEB.2.22.394.2307211804380.3118466@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit d1181d29370a4318a9f11ea92065bea6bb159f83:

  Merge tag 'pull-nbd-2023-07-19' of https://repo.or.cz/qemu/ericb into staging (2023-07-20 09:54:07 +0100)

are available in the Git repository at:

  https://gitlab.com/sstabellini/qemu.git xen-virtio-1-tag

for you to fetch changes up to 6bb48c66946dfbd653f06ad5f3fc957972333b56:

  xen_arm: Initialize RAM and add hi/low memory regions (2023-07-21 18:00:29 -0700)

----------------------------------------------------------------
Oleksandr Tyshchenko (2):
      xen_arm: Create virtio-mmio devices during initialization
      xen_arm: Initialize RAM and add hi/low memory regions

 hw/arm/xen_arm.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

