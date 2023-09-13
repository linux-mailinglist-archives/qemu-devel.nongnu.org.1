Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045A79F12C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 20:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgUiS-00074e-2s; Wed, 13 Sep 2023 14:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qgUiK-00071k-21
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 14:35:49 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qgUiC-0007xl-BM
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 14:35:46 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id B06401C0006;
 Wed, 13 Sep 2023 18:35:33 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v4 0/2] net: add initial support for AF_XDP network backend
Date: Wed, 13 Sep 2023 20:34:35 +0200
Message-ID: <20230913183620.1278418-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.197; envelope-from=i.maximets@ovn.org;
 helo=relay5-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

See the feature description in patch #2.

Version 4:

  - Fixed image builds with libvirt-ci by adding a new commit that
    bumps a submodule version and then using that new version for
    libxdp support in the main qemu build.
    Based on discussion in the PULL request:
      https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg01730.html

Version 3:

  - Bump requirements to libxdp 1.4.0+.  Having that, removed all
    the conditional compilation parts, since all the needed APIs
    are available in this version of libxdp.

  - Also removed the ability to pass xsks map fd, since ability
    to just pass socket fds is now always available and it doesn't
    require any capabilities untile manipulations with BPF maps.

  - Updated documentation to not call out specific vendors, memory
    numbers or specific required capabilities.

  - Changed logic of returning peeked at but unused descriptors.

  - Minor cleanups.


Version 2:

  - Added support for running with no capabilities by passing
    pre-created AF_XDP socket file descriptors via 'sock-fds' option.
    Conditionally complied because requires unreleased libxdp 1.4.0.
    The last restriction is having 32 MB of RLIMIT_MEMLOCK per queue.

  - Refined and extended documentation.


Ilya Maximets (2):
  tests: bump libvirt-ci for libasan and libxdp
  net: add initial support for AF_XDP network backend

 MAINTAINERS                                   |   4 +
 hmp-commands.hx                               |   3 +
 meson.build                                   |   9 +
 meson_options.txt                             |   2 +
 net/af-xdp.c                                  | 526 ++++++++++++++++++
 net/clients.h                                 |   5 +
 net/meson.build                               |   3 +
 net/net.c                                     |   6 +
 qapi/net.json                                 |  58 ++
 qemu-options.hx                               |  70 ++-
 .../ci/org.centos/stream/8/x86_64/configure   |   1 +
 scripts/meson-buildoptions.sh                 |   3 +
 tests/docker/dockerfiles/alpine.docker        |   1 +
 tests/docker/dockerfiles/centos8.docker       |   1 +
 .../dockerfiles/debian-amd64-cross.docker     |   2 +-
 tests/docker/dockerfiles/debian-amd64.docker  |   2 +-
 .../dockerfiles/debian-arm64-cross.docker     |   2 +-
 .../dockerfiles/debian-armel-cross.docker     |   2 +-
 .../dockerfiles/debian-armhf-cross.docker     |   2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   2 +-
 .../dockerfiles/debian-s390x-cross.docker     |   2 +-
 tests/docker/dockerfiles/fedora.docker        |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker |   2 +-
 tests/docker/dockerfiles/ubuntu2004.docker    |   2 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |   2 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 27 files changed, 704 insertions(+), 12 deletions(-)
 create mode 100644 net/af-xdp.c

-- 
2.41.0


