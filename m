Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A33D7D0792
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 07:22:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qthwk-0003Fe-9R; Fri, 20 Oct 2023 01:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qthwi-0003FA-CR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qthwf-0003oR-IB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 01:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697779271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yEXvB+OfZzedzKunFwTWtBiRDB/huIuOkEln/87wirg=;
 b=bpk+vTqCVDFemBqOO6uMB1RLLrmkq1Q1Ld4FiYquV0bmf9uqspzBr1TosmPzTq85UNixqG
 LqWATjhrg03uTPEPWlVMQ/sLCtWJ6w1QJwBLKNyjLeyYT7RjamZZXzzb++UG1r1QKRcxXF
 DrI/3c7txbyeIs4Ox4sxY6K3x6AClV8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-nLjkk2rWM9OOXtsP02jarQ-1; Fri, 20 Oct 2023 01:20:57 -0400
X-MC-Unique: nLjkk2rWM9OOXtsP02jarQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDE863806068;
 Fri, 20 Oct 2023 05:20:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15FBF8B9;
 Fri, 20 Oct 2023 05:20:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL v2 00/24] s390x patches
Date: Fri, 20 Oct 2023 07:20:53 +0200
Message-ID: <20231020052055.519460-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The following changes since commit 0d239e513e0117e66fa739fb71a43b9383a108ff:

  Merge tag 'pull-lu-20231018' of https://gitlab.com/rth7680/qemu into staging (2023-10-19 10:20:57 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-10-20

for you to fetch changes up to 18424d9591c73178bdfd6a4518091064db22e1d9:

  tests/qtest/migration-test: Disable the analyze-migration.py test on s390x (2023-10-20 07:16:53 +0200)

----------------------------------------------------------------
* s390x CPU topology support
* Simplify the KVM register synchronization code
* Disable the analyze-migration.py test on s390x

----------------------------------------------------------------
v2:
- Fixed the CI failures
- Dropped the -Wshadow cleanup patch since it's in another PR already

Nina Schoetterl-Glausch (1):
      qapi: machine.json: change docs regarding CPU topology

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
 include/hw/s390x/cpu-topology.h     |  83 +++++++
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
 35 files changed, 2285 insertions(+), 125 deletions(-)
 create mode 100644 docs/devel/s390-cpu-topology.rst
 create mode 100644 docs/system/s390x/cpu-topology.rst
 create mode 100644 qapi/machine-common.json
 create mode 100644 include/hw/s390x/cpu-topology.h
 create mode 100644 hw/s390x/cpu-topology.c
 create mode 100644 target/s390x/kvm/stsi-topology.c
 create mode 100644 tests/avocado/s390_topology.py


