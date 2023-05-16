Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4C7052F9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyx4q-0002GO-6Z; Tue, 16 May 2023 11:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3887702e5f8995638c98f9d9326b4913fb107be7@lizzy.crudebyte.com>)
 id 1pyx4n-0002Fe-Er
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:59:01 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3887702e5f8995638c98f9d9326b4913fb107be7@lizzy.crudebyte.com>)
 id 1pyx4l-0004iq-4A
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=4GhyD38eBpT5lQA3gIVJJ+fpt8/vu+u2QHaVqOwiR30=; b=UrlE+
 pnfgOpY2ml4XXkPToOrrGxR+5OvzSg3RHrgFDU0nCjvsK074C+N3U1xo0pN5jGj5v6FrubvWOAqG8
 zMr/EE49Spa79wczs5bw9xaaRrtgPWgd8K1SN3x9S0abh8nsdx3py1G4pgxYgFr/46cY8AxidvEfY
 kYMPQ/hikG1UVU2NLSJeIp4pEMKrPHJxRikxsxjN9Ot++ADP+rihRX3IuEQuiNaIUD856YFwMHLWd
 r7Aa64H80ihqK4M70M/o64KKf0KOnkiLposR5ZmTGrf0uFG6IC0hU3c0Fj0Byrt2MuC/sIgzxHYh7
 lxf+ov4ti+AnwYOhtdBf0PK6vvwyA==;
Message-Id: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 May 2023 17:21:04 +0200
Subject: [PULL 0/4] 9p queue 2023-05-16
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>,
 Peter Foley <pefoley@google.com>, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=3887702e5f8995638c98f9d9326b4913fb107be7@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-05-15 13:54:33 -0700)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20230516

for you to fetch changes up to 3887702e5f8995638c98f9d9326b4913fb107be7:

  configure: make clear that VirtFS is 9p (2023-05-16 16:21:54 +0200)

----------------------------------------------------------------
9pfs: fixes

* Fixes for Xen, configure and a theoretical leak.

----------------------------------------------------------------
Christian Schoenebeck (2):
      tests/9p: fix potential leak in v9fs_rreaddir()
      configure: make clear that VirtFS is 9p

Jason Andryuk (1):
      9pfs/xen: Fix segfault on shutdown

Peter Foley (1):
      Don't require libcap-ng for virtfs support

 hw/9pfs/trace-events                  |  6 ++++++
 hw/9pfs/xen-9p-backend.c              | 35 ++++++++++++++++++++++-------------
 meson.build                           | 14 ++++++++++----
 meson_options.txt                     |  2 ++
 scripts/meson-buildoptions.sh         |  4 ++++
 tests/qtest/libqos/virtio-9p-client.c |  5 +++++
 6 files changed, 49 insertions(+), 17 deletions(-)

