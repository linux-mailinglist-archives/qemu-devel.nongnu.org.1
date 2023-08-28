Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E540978B596
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 18:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafQB-00006A-Ix; Mon, 28 Aug 2023 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qafQ9-00005j-E8
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:48:57 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qafQ6-0000A1-MN
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:48:57 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qafPk-0000fM-BJ; Mon, 28 Aug 2023 18:48:32 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Subject: =?UTF-8?q?=5BPATCH=20v7=200/7=5D=20Hyper-V=20Dynamic=20Memory=20Protocol=20driver=20=28hv-balloon=20=F0=9F=8E=88=EF=B8=8F=29?=
Date: Mon, 28 Aug 2023 18:48:17 +0200
Message-ID: <cover.1693240836.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This is a continuation of the v6 of the patch series located here:
https://lore.kernel.org/qemu-devel/cover.1689786474.git.maciej.szmigiero@oracle.com/


Changes from v6:
* Split the hv-balloon driver implementation into multiple files holding
particular data structures and their methods in order to make the driver
easier to understand.

* Split out the PC machine necessary plumbing for the driver and its final
activation into a separate patch.

* Make sure that patches that bring QAPI-related changes also implement these
in the driver in the same patch.

* Add a "query-hv-balloon-status-report" QMP command to query the data from
the last received HV_BALLOON_STATUS_REPORT event.

* Rate limit the HV_BALLOON_STATUS_REPORT QMP event.

* Replace "TBD" in QAPI changes with the actual targeted QEMU version.

* Spelling and formatting fixes in QAPI changes.

* Rebase onto the latest David's patch series.


Based-on: <20230825132149.366064-1-david@redhat.com>
Based-on-Repo-Commit: https://github.com/davidhildenbrand/qemu/tree/virtio-mem-memslots b65df116f8a8


David Hildenbrand (2):
  memory-device: Support empty memory devices
  memory-device: Drop size alignment check

Maciej S. Szmigiero (5):
  Add Hyper-V Dynamic Memory Protocol definitions
  Add a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
  qapi: Add query-memory-devices support to hv-balloon
  qapi: Add HV_BALLOON_STATUS_REPORT event and its QMP query command
  hw/i386/pc: Support hv-balloon

 Kconfig.host                              |    3 +
 hw/core/machine-hmp-cmds.c                |   15 +
 hw/hyperv/Kconfig                         |   10 +
 hw/hyperv/hv-balloon-internal.h           |   33 +
 hw/hyperv/hv-balloon-our_range_memslots.c |  201 +++
 hw/hyperv/hv-balloon-our_range_memslots.h |  110 ++
 hw/hyperv/hv-balloon-page_range_tree.c    |  228 +++
 hw/hyperv/hv-balloon-page_range_tree.h    |  118 ++
 hw/hyperv/hv-balloon.c                    | 1767 +++++++++++++++++++++
 hw/hyperv/meson.build                     |    1 +
 hw/hyperv/trace-events                    |   18 +
 hw/i386/Kconfig                           |    1 +
 hw/i386/pc.c                              |   22 +
 hw/mem/memory-device.c                    |   49 +-
 include/hw/hyperv/dynmem-proto.h          |  423 +++++
 include/hw/hyperv/hv-balloon.h            |   18 +
 include/hw/mem/memory-device.h            |    7 +-
 meson.build                               |   28 +-
 meson_options.txt                         |    2 +
 monitor/monitor.c                         |    1 +
 qapi/machine.json                         |  103 +-
 scripts/meson-buildoptions.sh             |    3 +
 22 files changed, 3148 insertions(+), 13 deletions(-)
 create mode 100644 hw/hyperv/hv-balloon-internal.h
 create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.c
 create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.h
 create mode 100644 hw/hyperv/hv-balloon-page_range_tree.c
 create mode 100644 hw/hyperv/hv-balloon-page_range_tree.h
 create mode 100644 hw/hyperv/hv-balloon.c
 create mode 100644 include/hw/hyperv/dynmem-proto.h
 create mode 100644 include/hw/hyperv/hv-balloon.h


