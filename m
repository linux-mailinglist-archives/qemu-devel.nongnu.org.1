Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B18767A44D3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9fY-0005vy-OX; Mon, 18 Sep 2023 04:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fW-0005vm-LG
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9fR-00047h-V8
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=INij+cEoHNtNiTbPzTrnmac14obiARL3YipToJ3Gzho=;
 b=SnPd+f4iyxqRUZgEr8H7EMnw8yKZdyDlOEoaF5bcxZ3pqSTN0yItAKhLlQnOYWiTcGN0sx
 xPetwt0zXS9yODxICwfo252Qla/CmxUmKyEoUcMMKJX6wZUoSknweSYn294BWI9vVYa7rX
 NyU8S4Ng0Q6/CR3qyQF/QPLbLoFQ3g8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-KXxV33cTMHqOwoaqLRJBMg-1; Mon, 18 Sep 2023 04:31:35 -0400
X-MC-Unique: KXxV33cTMHqOwoaqLRJBMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D6711C05129
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 971C22156701
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:31:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL V2 00/17] Net patches
Date: Mon, 18 Sep 2023 16:31:15 +0800
Message-Id: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 6d7a53e9f16d2b18d94f9fce1e4eea34570286ef:

  net/tap: Avoid variable-length array (2023-09-18 14:36:13 +0800)

----------------------------------------------------------------

Changes since V1:

- fix compiling failure for netmap
- fix CI failure due to libxdp
- include one more sereis that avoid using variable length


----------------------------------------------------------------
Andrew Melnychenko (2):
      tap: Add USO support to tap device.
      virtio-net: Add USO flags to vhost support.

Ilya Maximets (2):
      tests: bump libvirt-ci for libasan and libxdp
      net: add initial support for AF_XDP network backend

Peter Maydell (4):
      hw/net/fsl_etsec/rings.c: Avoid variable length array
      hw/net/rocker: Avoid variable length array
      net/dump: Avoid variable length array
      net/tap: Avoid variable-length array

Tomasz Dzieciol (7):
      igb: remove TCP ACK detection
      igb: rename E1000E_RingInfo_st
      igb: RX descriptors guest writting refactoring
      igb: RX payload guest writting refactoring
      igb: add IPv6 extended headers traffic detection
      igb: packet-split descriptors support
      e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers

Yuri Benditovich (2):
      tap: Add check for USO features
      virtio-net: Add support for USO features

 MAINTAINERS                                        |   4 +
 hmp-commands.hx                                    |   3 +
 hw/core/machine.c                                  |   4 +
 hw/net/e1000e_core.c                               |  80 +--
 hw/net/fsl_etsec/rings.c                           |  12 +-
 hw/net/igb_core.c                                  | 732 +++++++++++++++------
 hw/net/igb_regs.h                                  |  20 +-
 hw/net/rocker/rocker_of_dpa.c                      |   2 +-
 hw/net/trace-events                                |   6 +-
 hw/net/vhost_net.c                                 |   3 +
 hw/net/virtio-net.c                                |  35 +-
 hw/net/vmxnet3.c                                   |   2 +
 include/net/net.h                                  |   7 +-
 meson.build                                        |   9 +
 meson_options.txt                                  |   2 +
 net/af-xdp.c                                       | 526 +++++++++++++++
 net/clients.h                                      |   5 +
 net/dump.c                                         |   2 +-
 net/meson.build                                    |   3 +
 net/net.c                                          |  19 +-
 net/netmap.c                                       |   2 +-
 net/tap-bsd.c                                      |   7 +-
 net/tap-linux.c                                    |  27 +-
 net/tap-linux.h                                    |   2 +
 net/tap-solaris.c                                  |   7 +-
 net/tap-stub.c                                     |   7 +-
 net/tap-win32.c                                    |   2 +-
 net/tap.c                                          |  21 +-
 net/tap_int.h                                      |   4 +-
 net/vhost-vdpa.c                                   |   3 +
 qapi/net.json                                      |  58 ++
 qemu-options.hx                                    |  70 +-
 scripts/ci/org.centos/stream/8/x86_64/configure    |   1 +
 scripts/meson-buildoptions.sh                      |   3 +
 tests/docker/dockerfiles/alpine.docker             |   1 +
 tests/docker/dockerfiles/centos8.docker            |   1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-amd64.docker       |   2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   2 +-
 tests/docker/dockerfiles/fedora.docker             |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker      |   2 +-
 tests/docker/dockerfiles/ubuntu2004.docker         |   2 +-
 tests/docker/dockerfiles/ubuntu2204.docker         |   2 +-
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/projects/qemu.yml                    |   1 +
 tests/qtest/libqos/igb.c                           |   5 +
 50 files changed, 1436 insertions(+), 285 deletions(-)
 create mode 100644 net/af-xdp.c


