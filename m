Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03075ABC2
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 12:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMQfC-0006cq-2T; Thu, 20 Jul 2023 06:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qMQf9-0006cH-1y
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:13:35 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qMQf6-0003SJ-J1
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:13:34 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qMQeo-0003Z1-NC; Thu, 20 Jul 2023 12:13:14 +0200
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
Subject: =?UTF-8?q?=5BPATCH=20v6=200/6=5D=20Hyper-V=20Dynamic=20Memory=20Protocol=20driver=20=28hv-balloon=20=F0=9F=8E=88=EF=B8=8F=29?=
Date: Thu, 20 Jul 2023 12:12:57 +0200
Message-ID: <cover.1689786474.git.maciej.szmigiero@oracle.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a continuation of the v5 of the patch series located here:
https://lore.kernel.org/qemu-devel/cover.1686577753.git.maciej.szmigiero@oracle.com/


Changes from v5:
* Incorporate David's rework of the driver on top of his virtio-mem-memslots
patches (specifically, commit 6769107d1a4f), making use of a memory region
container created upfront to avoid calling memory_device{,_pre}_plug()
functions from the driver and introducing a driver-specific MemoryDeviceInfo
sub-type.

* Include two additional David's memory-device patches necessary for the
aforementioned conversion in this patch set.

* Use multiple memslots to cover the hot-add memory backend in order to
reduce metadata size for the not-yet-hot-added part of the memory backend.

* Add David's "Co-developed-by:" to patches where he contributed some changes.

* Use OBJECT_DEFINE_TYPE_WITH_INTERFACES() and OBJECT_DECLARE_SIMPLE_TYPE()
macros instead of open-coding the equivalent functionality.

* Drop no longer necessary patch adding g_autoptr() cleanup function for the
Error type.


David Hildenbrand (2):
  memory-device: Support empty memory devices
  memory-device: Drop size alignment check

Maciej S. Szmigiero (4):
  Add Hyper-V Dynamic Memory Protocol definitions
  qapi: Add HvBalloonDeviceInfo sub-type to MemoryDeviceInfo
  qapi: Add HV_BALLOON_STATUS_REPORT event
  Add a Hyper-V Dynamic Memory Protocol driver (hv-balloon)

 Kconfig.host                     |    3 +
 hw/core/machine-hmp-cmds.c       |   15 +
 hw/hyperv/Kconfig                |    5 +
 hw/hyperv/hv-balloon.c           | 2246 ++++++++++++++++++++++++++++++
 hw/hyperv/meson.build            |    1 +
 hw/hyperv/trace-events           |   18 +
 hw/i386/pc.c                     |   22 +
 hw/mem/memory-device.c           |   45 +-
 include/hw/hyperv/dynmem-proto.h |  423 ++++++
 include/hw/hyperv/hv-balloon.h   |   18 +
 include/hw/mem/memory-device.h   |    7 +-
 meson.build                      |   28 +-
 meson_options.txt                |    2 +
 qapi/machine.json                |   64 +-
 scripts/meson-buildoptions.sh    |    3 +
 15 files changed, 2888 insertions(+), 12 deletions(-)
 create mode 100644 hw/hyperv/hv-balloon.c
 create mode 100644 include/hw/hyperv/dynmem-proto.h
 create mode 100644 include/hw/hyperv/hv-balloon.h


