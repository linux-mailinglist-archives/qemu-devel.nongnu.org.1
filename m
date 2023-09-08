Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2349E798293
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:45:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVFM-0004wm-UC; Fri, 08 Sep 2023 02:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVF0-0004w4-Hv
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVEy-0002eI-2r
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694155515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i1/RnQvAb+R7hKnROd9bjLwvoTmmbFDtGQ97pqydmQQ=;
 b=cNwMmzcRCjK+jgGuXbJUBQvMVrFcyMOpkq40y4M/8yRWWgPGXSqIIZpn+LXxQkLyARKAU2
 fjHHy0wooIIjFcwgmngXwbj4xucgIKxkUjyHAEbRB2gMfboKDfCAoWHR5vtxPIrU9XoHBn
 SXNv4joLKJ8jYMTiFg4iyUYzPCrtWlg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-VHPKK7WLN9SGrPJ5gu8CDw-1; Fri, 08 Sep 2023 02:45:13 -0400
X-MC-Unique: VHPKK7WLN9SGrPJ5gu8CDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C34BB2932496
 for <qemu-devel@nongnu.org>; Fri,  8 Sep 2023 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 408B11121314;
 Fri,  8 Sep 2023 06:45:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/17] Net patches
Date: Fri,  8 Sep 2023 14:44:50 +0800
Message-Id: <20230908064507.14596-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

The following changes since commit 03a3a62fbd0aa5227e978eef3c67d3978aec9e5f:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-09-07 10:29:06 -0400)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 049cfda145e96b2605cdf9739f1bcf9ebf3a83e1:

  ebpf: Updated eBPF program and skeleton. (2023-09-08 14:33:46 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Andrew Melnychenko (7):
      tap: Add USO support to tap device.
      virtio-net: Add USO flags to vhost support.
      ebpf: Added eBPF map update through mmap.
      ebpf: Added eBPF initialization by fds.
      virtio-net: Added property to load eBPF RSS with fds.
      qmp: Added new command to retrieve eBPF blob.
      ebpf: Updated eBPF program and skeleton.

Ilya Maximets (1):
      net: add initial support for AF_XDP network backend

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

 MAINTAINERS                                     |    4 +
 ebpf/ebpf.c                                     |   70 ++
 ebpf/ebpf.h                                     |   31 +
 ebpf/ebpf_rss-stub.c                            |    6 +
 ebpf/ebpf_rss.c                                 |  150 ++-
 ebpf/ebpf_rss.h                                 |   10 +
 ebpf/meson.build                                |    2 +-
 ebpf/rss.bpf.skeleton.h                         | 1460 ++++++++++++-----------
 hmp-commands.hx                                 |    3 +
 hw/core/machine.c                               |    4 +
 hw/net/e1000e_core.c                            |   80 +-
 hw/net/igb_core.c                               |  732 ++++++++----
 hw/net/igb_regs.h                               |   20 +-
 hw/net/trace-events                             |    6 +-
 hw/net/vhost_net.c                              |    3 +
 hw/net/virtio-net.c                             |   90 +-
 hw/net/vmxnet3.c                                |    2 +
 include/hw/virtio/virtio-net.h                  |    1 +
 include/net/net.h                               |    7 +-
 meson.build                                     |   19 +-
 meson_options.txt                               |    2 +
 net/af-xdp.c                                    |  526 ++++++++
 net/clients.h                                   |    5 +
 net/meson.build                                 |    3 +
 net/net.c                                       |   19 +-
 net/tap-bsd.c                                   |    7 +-
 net/tap-linux.c                                 |   27 +-
 net/tap-linux.h                                 |    2 +
 net/tap-solaris.c                               |    7 +-
 net/tap-stub.c                                  |    7 +-
 net/tap-win32.c                                 |    2 +-
 net/tap.c                                       |   18 +-
 net/tap_int.h                                   |    4 +-
 net/vhost-vdpa.c                                |    3 +
 qapi/ebpf.json                                  |   66 +
 qapi/meson.build                                |    1 +
 qapi/net.json                                   |   58 +
 qapi/qapi-schema.json                           |    1 +
 qemu-options.hx                                 |   70 +-
 scripts/ci/org.centos/stream/8/x86_64/configure |    1 +
 scripts/meson-buildoptions.sh                   |    3 +
 tests/docker/dockerfiles/debian-amd64.docker    |    1 +
 tests/qtest/libqos/igb.c                        |    5 +
 tools/ebpf/rss.bpf.c                            |    5 +-
 44 files changed, 2518 insertions(+), 1025 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 net/af-xdp.c
 create mode 100644 qapi/ebpf.json


