Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447E78E44F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 03:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbWSx-0006PM-GL; Wed, 30 Aug 2023 21:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qbWSv-0006P7-26
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 21:27:21 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qbWSs-0006VX-Od
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 21:27:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2626D60BD3;
 Thu, 31 Aug 2023 01:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70D2C433C8;
 Thu, 31 Aug 2023 01:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693445236;
 bh=ftMoHOchEvAiNzjoOSxy2Nu0eFmBDiW7FWut0tu7Lvs=;
 h=Date:From:To:cc:Subject:From;
 b=Dl9pbTMF8vNj/g3doZS173E2uLISV/hIUcGmVLcrI3lH2DzFNWLJpP3XYZi4D3QEp
 3LrNZr3qZhD39gEu/+AMjqfGVvd872moZb5BkBwkHqlft+CnuoW6xdXnV+FIFStijg
 +BdAcN6uxIPX0Liq9ySzzg69NgI2NIYZsdsP5GwdYLqMAVLVlQ9Letrs+WPcXZuwvP
 hVeCFhVfQ6wOn4HL1hQRY5ljwFeKz33Pxbo7RmT4YGWaGerbJz+YrZwW8qkE5gW4GK
 vSQqlQkcCkqfFyEIVyecOxBaRrjMEcwD5Ia2E5Ale305Zx6s5AvUO09L+voa2lA8sD
 u9Av0ims5lyeQ==
Date: Wed, 30 Aug 2023 18:27:13 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: peter.maydell@linaro.org
cc: sstabellini@kernel.org, richard.henderson@linaro.org, 
 qemu-devel@nongnu.org, vikram.garhwal@amd.com
Subject: [PULL v2 0/2] xen-virtio-2-tag
Message-ID: <alpine.DEB.2.22.394.2308301824340.6458@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

The following changes since commit 156618d9ea67f2f2e31d9dedd97f2dcccbe6808c:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-08-30 09:20:27 -0400)

are available in the Git repository at:

  https://gitlab.com/sstabellini/qemu.git xen-virtio-2-tag

for you to fetch changes up to 560142190bc347fdd4511a795bdcff768799519d:

  xen_arm: Initialize RAM and add hi/low memory regions (2023-08-30 18:23:08 -0700)

----------------------------------------------------------------
Oleksandr Tyshchenko (2):
      xen_arm: Create virtio-mmio devices during initialization
      xen_arm: Initialize RAM and add hi/low memory regions

 hw/arm/xen_arm.c            | 80 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen_native.h | 24 ++++++++++++++
 2 files changed, 104 insertions(+)

