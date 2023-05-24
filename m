Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655C70F166
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1k9s-0001gr-0z; Wed, 24 May 2023 04:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=pqJs=BN=redhat.com=clg@ozlabs.org>)
 id 1q1k9p-0001ep-FU
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:47:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=pqJs=BN=redhat.com=clg@ozlabs.org>)
 id 1q1k9n-0002Lx-Mk
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:47:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QR4ZF1gV1z4x3m;
 Wed, 24 May 2023 18:47:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QR4ZC1nSxz4x3g;
 Wed, 24 May 2023 18:47:30 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] vfio queue
Date: Wed, 24 May 2023 10:47:22 +0200
Message-Id: <20230524084724.2511267-1-clg@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=pqJs=BN=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following changes since commit aa33508196f4e2da04625bee36e1f7be5b9267e7:

  Merge tag 'mem-2023-05-23' of https://github.com/davidhildenbrand/qemu into staging (2023-05-23 10:57:25 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20230524

for you to fetch changes up to dbdea0dbfe2cef9ef6c752e9077e4fc98724194c:

  util/vfio-helpers: Use g_file_read_link() (2023-05-24 09:21:22 +0200)

----------------------------------------------------------------
vfio queue:

* Fix for a memory corruption due to an extra free
* Fix for a compile breakage

----------------------------------------------------------------
Akihiko Odaki (1):
      util/vfio-helpers: Use g_file_read_link()

Zhenzhong Duan (1):
      vfio/pci: Fix a use-after-free issue

 hw/vfio/pci.c       | 2 +-
 util/vfio-helpers.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

