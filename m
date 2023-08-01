Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938076AECE
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlsE-0003An-UI; Tue, 01 Aug 2023 05:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls5-00036d-2q
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:56 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls3-0005Ao-2a
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1690882850;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Wl4X0D1/3bPUD0unWr6NjqyJYukClfBN3sM+ylWIAfg=;
 b=f86/l7lnClyOcTmWSt9k/slbzdmHcwIER1k0+lSCWlhbnbKiav/3BM3U
 RiAQc4BZeLC2ffMbGJnjhZS2/Lya4gb3zeUsPoe1MZw4CrSGd/bb2EUsn
 HbO6VZvnRETTzhVgNnMcIHFF4IAqCHlxomNmJ9ENw8nO9TZyWmhn8/mJ6 o=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 118528044
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:BT0EzaPn9mwuu8nvrR33l8FynXyQoLVcMsEvi/4bfWQNrUpw12ZWn
 2obUGqBO6zbNjShfYp3PoS38BwCusfWydVkQQto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSs/vrRC9H5qyo42tH5QVmPpingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0v5FIUZ1r
 t4aEzwiKR2ZuNmS0o2AcuY506zPLOGzVG8eknRpzDWfBvc6W5HTBa7N4Le03h9p2JoIR6yHI
 ZNEN3w2Nk+ojx5nYz/7DLo3mvuogX/uNSVVsluPqYI84nTJzRw327/oWDbQUoXTFZgPzh7E+
 goq+UzbJA4ba+HBwwO780uKt8jdjSznCKsdQejQGvlC3wTImz175ActfUK2pOT8hkOgVtZ3L
 UsS9Swz668o+ySWosLVBkPi5iTe51hFBoQWSrdhgO2Q9kbKyx6rJk8/FRxDU9AJ88IsegcOx
 GCyp9y8UFSDr4appWKhGqa89G3jYXhKcjVbPUfoXiNevYC9/dhbYgbnC486TfXr1oCd9STYm
 WjikcQou1kEYSfnPY2f9EuPvT+jr4OhouUdtlSOBTLNAu+UieeYi22UBbvzt6wowH6xFAXpg
 ZT9s5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3w83T8Nxq2vxpyT8FWy13N2ZDB44WvvohBezO
 BOD0e+vzME70ISWgV9fPNvqVpVCIVnIHtX5TPHEBueikbAoHDJrCBpGPBbKt0i0yRhErE3KE
 cvDGSpaJSpAWPsPIfvfb7t17ILHMQhklT+KH82qkE7+uVdcDVbMIYo43JK1RrhRxMu5TM/9q
 b6z6+PiJ81jbdDD
IronPort-HdrOrdr: A9a23:SX1lza1X3q3q6L8kU6FafwqjBNEkLtp133Aq2lEZdPU1SKylfq
 WV98jzuiWYtN98YhsdcLO7WZVoP0myyXcd2+B4AV7IZmXbUQWTQr1f0Q==
X-Talos-CUID: 9a23:AmRoQWAzSQQjSuX6EzFV1GkvQeInSXHyi3rKHHScG1lScLLAHA==
X-Talos-MUID: 9a23:AOhYzAkhN+MVLswddda3dnpAEthpvJnwAnkzkKwgiu6WJSNsax6S2WE=
X-IronPort-AV: E=Sophos;i="6.01,246,1684814400"; d="scan'208";a="118528044"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 0/5] Misc fixes, for thread-pool, xen, and xen-emulate
Date: Tue, 1 Aug 2023 10:40:33 +0100
Message-ID: <20230801094038.11026-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=prvs=570bccec8=anthony.perard@citrix.com;
 helo=esa1.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following changes since commit 802341823f1720511dd5cf53ae40285f7978c61b:

  Merge tag 'pull-tcg-20230731' of https://gitlab.com/rth7680/qemu into staging (2023-07-31 14:02:51 -0700)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20230801

for you to fetch changes up to 856ca10f9ce1fcffeab18546b36a64f79017c905:

  xen-platform: do full PCI reset during unplug of IDE devices (2023-08-01 10:22:33 +0100)

----------------------------------------------------------------
Misc fixes, for thread-pool, xen, and xen-emulate

* fix an access to `request_cond` QemuCond in thread-pool
* fix issue with PCI devices when unplugging IDE devices in Xen guest
* several fixes for issues pointed out by Coverity

----------------------------------------------------------------
Anthony PERARD (2):
      xen-block: Avoid leaks on new error path
      thread-pool: signal "request_cond" while locked

David Woodhouse (1):
      hw/xen: Clarify (lack of) error handling in transaction_commit()

Olaf Hering (1):
      xen-platform: do full PCI reset during unplug of IDE devices

Peter Maydell (1):
      xen: Don't pass MemoryListener around by value

 hw/arm/xen_arm.c                |  4 ++--
 hw/block/xen-block.c            | 11 ++++++-----
 hw/i386/kvm/xenstore_impl.c     | 12 +++++++++++-
 hw/i386/xen/xen-hvm.c           |  4 ++--
 hw/i386/xen/xen_platform.c      |  7 ++++---
 hw/xen/xen-hvm-common.c         |  8 ++++----
 include/hw/xen/xen-hvm-common.h |  2 +-
 util/thread-pool.c              |  2 +-
 8 files changed, 31 insertions(+), 19 deletions(-)

