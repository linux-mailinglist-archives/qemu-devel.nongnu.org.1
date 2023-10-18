Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E447CDCFE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Gv-00043o-FC; Wed, 18 Oct 2023 09:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gt-000419-MP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6Gr-0007vg-Em
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=19uWtv5xgZye5chNyFzpoxssPgeWH8KsYsrAHIQ7L2w=;
 b=YnxbqfLxCAkHrm+sK1PGYDZLLhC5gNp0bazeWvQBwADntgeEO02O7DL/gnuOw+c101/sKc
 8/z50R5vWdPGlyAJIVGlxFlWUEUnt4C7R5+jjfEL0m7oA+17JFhvvV/nhwNTKFoiHX6MO0
 +PZA4MFcbg2MqkTBacLh9RlIM5T0HMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-3OJVMSj_OXeJ7cH-0StcRQ-1; Wed, 18 Oct 2023 09:07:19 -0400
X-MC-Unique: 3OJVMSj_OXeJ7cH-0StcRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E61F810201F1;
 Wed, 18 Oct 2023 13:07:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9108220268CC;
 Wed, 18 Oct 2023 13:07:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 00/25] s390x patches
Date: Wed, 18 Oct 2023 15:06:51 +0200
Message-ID: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

 Hi Stefan!

The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-10-18

for you to fetch changes up to 1a1bd94d4274d30fad9e0faf19591a4336f5c22a:

  tests/qtest/migration-test: Disable the analyze-migration.py test on s390x (2023-10-18 14:59:48 +0200)

----------------------------------------------------------------
* s390x CPU topology support
* Clean up global variable shadowing in s390x code
* Simplify the KVM register synchronization code
* Disable the analyze-migration.py test on s390x

----------------------------------------------------------------
Nina Schoetterl-Glausch (1):
      qapi: machine.json: change docs regarding CPU topology

Philippe Mathieu-Daudé (1):
      hw/s390x: Clean up global variable shadowing in quiesce_powerdown_req()

Pierre Morel (20):
      CPU topology: extend with s390 specifics
      s390x/cpu topology: add topology entries on CPU hotplug
      target/s390x/cpu topology: handle STSI(15) and build the SYSIB
      s390x/sclp: reporting the maximum nested topology entries
      s390x/cpu topology: resetting the Topology-Change-Report
      s390x/cpu topology: interception of PTF instruction
      target/s390x/cpu topology: activate CPU topology
      qapi/s390x/cpu topology: set-cpu-topology qmp command
      machine: adding s390 topology to query-cpu-fast
      machine: adding s390 topology to info hotpluggable-cpus
      qapi/s390x/cpu topology: CPU_POLARIZATION_CHANGE QAPI event
      qapi/s390x/cpu topology: add query-s390x-cpu-polarization command
      docs/s390x/cpu topology: document s390x cpu topology
      tests/avocado: s390x cpu topology core
      tests/avocado: s390x cpu topology polarization
      tests/avocado: s390x cpu topology entitlement tests
      tests/avocado: s390x cpu topology test dedicated CPU
      tests/avocado: s390x cpu topology test socket full
      tests/avocado: s390x cpu topology dedicated errors
      tests/avocado: s390x cpu topology bad move

Thomas Huth (3):
      target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a hard requirement
      target/s390x/kvm: Simplify the GPRs, ACRs, CRs and prefix synchronization code
      tests/qtest/migration-test: Disable the analyze-migration.py test on s390x

 MAINTAINERS                         |  11 +
 docs/devel/index-internals.rst      |   1 +
 docs/devel/s390-cpu-topology.rst    | 170 +++++++++++++
 docs/system/s390x/cpu-topology.rst  | 244 +++++++++++++++++++
 docs/system/target-s390x.rst        |   1 +
 qapi/machine-common.json            |  21 ++
 qapi/machine-target.json            | 121 ++++++++++
 qapi/machine.json                   |  85 +++++--
 qapi/qapi-schema.json               |   1 +
 include/hw/boards.h                 |  10 +-
 include/hw/qdev-properties-system.h |   4 +
 include/hw/s390x/cpu-topology.h     |  78 ++++++
 include/hw/s390x/s390-virtio-ccw.h  |   6 +
 include/hw/s390x/sclp.h             |   4 +-
 target/s390x/cpu.h                  |  82 +++++++
 target/s390x/kvm/kvm_s390x.h        |   1 +
 hw/core/machine-hmp-cmds.c          |   6 +
 hw/core/machine-smp.c               |  48 +++-
 hw/core/machine.c                   |   4 +
 hw/core/qdev-properties-system.c    |  13 +
 hw/s390x/cpu-topology.c             | 469 ++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          |  29 ++-
 hw/s390x/sclp.c                     |   5 +
 hw/s390x/sclpquiesce.c              |   8 +-
 system/vl.c                         |   6 +
 target/s390x/cpu-sysemu.c           |  13 +
 target/s390x/cpu.c                  |  16 ++
 target/s390x/cpu_models.c           |   1 +
 target/s390x/kvm/kvm.c              | 166 ++++++-------
 target/s390x/kvm/stsi-topology.c    | 334 +++++++++++++++++++++++++
 tests/qtest/migration-test.c        |   4 +-
 hw/s390x/meson.build                |   1 +
 qapi/meson.build                    |   1 +
 qemu-options.hx                     |   7 +-
 target/s390x/kvm/meson.build        |   3 +-
 tests/avocado/s390_topology.py      | 439 +++++++++++++++++++++++++++++++++
 36 files changed, 2284 insertions(+), 129 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py


