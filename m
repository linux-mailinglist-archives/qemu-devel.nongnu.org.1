Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EBF7F2983
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:58:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NVw-0000oN-DR; Tue, 21 Nov 2023 04:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r5NVu-0000nZ-E5
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r5NVp-0001Bh-S9
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700560663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HySAHGx2603DvvOosltvAVKvouXd9222nXbNP3O1lkQ=;
 b=a+XnUbREC2JKFsyu7267MuO4OdfLQACxOs7EqAbczLDmYtkeNqzJp8zclh66X5xY7IM+jm
 7PHUE/1M1WffyOJ+F+LmrXqaCJBLG5qNTLXoIl6HSfuyVIX1jPIQVplkCniqrjh1aG9Vcz
 DheL8CcqKM2J9ClABB0iBvQEQz1gizE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-Q02y2Y88NwaQZlOlRJH6Fg-1; Tue,
 21 Nov 2023 04:57:40 -0500
X-MC-Unique: Q02y2Y88NwaQZlOlRJH6Fg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F18F1C05ECE
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96B11492BE0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:57:39 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Net patches
Date: Tue, 21 Nov 2023 17:57:34 +0800
Message-ID: <20231121095737.31438-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 84f85eb95f14add02efd5e69f2ff7783d79b24f7:

  net: do not delete nics in net_cleanup() (2023-11-21 15:42:34 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Akihiko Odaki (2):
      net: Provide MemReentrancyGuard * to qemu_new_nic()
      net: Update MemReentrancyGuard for NIC

David Woodhouse (1):
      net: do not delete nics in net_cleanup()

 hw/net/allwinner-sun8i-emac.c |  3 ++-
 hw/net/allwinner_emac.c       |  3 ++-
 hw/net/cadence_gem.c          |  3 ++-
 hw/net/dp8393x.c              |  3 ++-
 hw/net/e1000.c                |  3 ++-
 hw/net/e1000e.c               |  2 +-
 hw/net/eepro100.c             |  4 +++-
 hw/net/etraxfs_eth.c          |  3 ++-
 hw/net/fsl_etsec/etsec.c      |  3 ++-
 hw/net/ftgmac100.c            |  3 ++-
 hw/net/i82596.c               |  2 +-
 hw/net/igb.c                  |  2 +-
 hw/net/imx_fec.c              |  2 +-
 hw/net/lan9118.c              |  3 ++-
 hw/net/mcf_fec.c              |  3 ++-
 hw/net/mipsnet.c              |  3 ++-
 hw/net/msf2-emac.c            |  3 ++-
 hw/net/mv88w8618_eth.c        |  3 ++-
 hw/net/ne2000-isa.c           |  3 ++-
 hw/net/ne2000-pci.c           |  3 ++-
 hw/net/npcm7xx_emc.c          |  3 ++-
 hw/net/opencores_eth.c        |  3 ++-
 hw/net/pcnet.c                |  3 ++-
 hw/net/rocker/rocker_fp.c     |  4 ++--
 hw/net/rtl8139.c              |  3 ++-
 hw/net/smc91c111.c            |  3 ++-
 hw/net/spapr_llan.c           |  3 ++-
 hw/net/stellaris_enet.c       |  3 ++-
 hw/net/sungem.c               |  2 +-
 hw/net/sunhme.c               |  3 ++-
 hw/net/tulip.c                |  3 ++-
 hw/net/virtio-net.c           |  6 ++++--
 hw/net/vmxnet3.c              |  2 +-
 hw/net/xen_nic.c              |  3 ++-
 hw/net/xgmac.c                |  3 ++-
 hw/net/xilinx_axienet.c       |  3 ++-
 hw/net/xilinx_ethlite.c       |  3 ++-
 hw/usb/dev-network.c          |  3 ++-
 include/net/net.h             |  2 ++
 net/net.c                     | 43 +++++++++++++++++++++++++++++++++++++------
 40 files changed, 112 insertions(+), 46 deletions(-)



