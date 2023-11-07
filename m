Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BBB7E4A60
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 22:15:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0TOF-0000By-AL; Tue, 07 Nov 2023 16:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r0TOE-0000Bl-5n
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:13:38 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r0TOB-0002GA-PN
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:13:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 87CEEB818E1;
 Tue,  7 Nov 2023 21:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E458C433C7;
 Tue,  7 Nov 2023 21:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699391599;
 bh=DOmZ9xzN3bJ7D0eYPu5YFBAPOn+RTr1Scc+PHjEmaTw=;
 h=Date:From:To:cc:Subject:From;
 b=DHQGjM9iQRndSKCbK0qQpjZ7ODIZAtANa0i5VAjJRHU3aXgSjGyJOFlm4pKGhtyFW
 29OLNhXIe0dECHIWD5FJzPzAMoeJygnL5UkgtvBjWen5Jl5r220O9L0qF2Kj/c6Ojx
 braszy2c4eIlLfbzKADVVySswcAaICZclFFTNRQxz9p/DmaIQDt7vH3UvAMonsPj9M
 /mwEB8bsq8ExqHkatnYE54M2RFjW6LpSTu7F3fkDqpnRJZRp0QiKzh3+7oW7uIYdqK
 pC+bGmLQSfDeNmDBaOh7XGA6ieBEdli7Xx8Th8Dfx4jQmcfCDojidJa4Nc/nzsbj/q
 9Gysqs++pHsqg==
Date: Tue, 7 Nov 2023 13:13:17 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: qemu-devel@nongnu.org, stefanha@redhat.com
cc: sstabellini@kernel.org, peter.maydell@linaro.org
Subject: [PULL 0/1] xen-virtio-fix-1-tag
Message-ID: <alpine.DEB.2.22.394.2311071310190.3478774@ubuntu-linux-20-04-desktop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=sstabellini@kernel.org; helo=ams.source.kernel.org
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

Minor bug fix for Virtio/Xen support


The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:

  Merge tag 'xen-virtio-fix-1-tag' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)

are available in the Git repository at:

  https://gitlab.com/sstabellini/qemu.git 

for you to fetch changes up to 01bb72afbb95003fb5562e341a592f583e27e280:

  Xen: Fix xen_set_irq() and xendevicemodel_set_irq_level() (2023-11-07 13:03:19 -0800)

----------------------------------------------------------------
Vikram Garhwal (1):
      Xen: Fix xen_set_irq() and xendevicemodel_set_irq_level()

 hw/arm/xen_arm.c            | 4 +++-
 include/hw/xen/xen_native.h | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

