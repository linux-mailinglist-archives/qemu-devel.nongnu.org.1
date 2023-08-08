Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE77739F7
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLKy-0001Fo-72; Tue, 08 Aug 2023 07:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLKu-0001FQ-Lt
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:57:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLKr-0001L6-SU
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:57:16 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKs5p0z5Qz6J72Y;
 Tue,  8 Aug 2023 19:53:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 12:57:11 +0100
To: <qemu-devel@nongnu.org>
CC: Gavin Shan <gshan@redhat.com>, <linuxarm@huawei.com>, James Morse
 <james.morse@arm.com>, "peter . maydell @ linaro . org"
 <peter.maydell@linaro.org>, <zhao1.liu@linux.intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>, Yicong Yang
 <yangyicong@huawei.com>
Subject: [RFC PATCH 0/5] hw/arm: MPAM Emulation + PPTT cache description.
Date: Tue, 8 Aug 2023 12:57:08 +0100
Message-ID: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Aim of this bit of emulation is to use it for testing James Morse's
kernel tree - in particularly letting us poke the corner cases.
Right now I'm not that focused on upstreaming this (too many other things
in my backlog), but any feedback on the approach etc welcome and perhaps
the PPTT part is useful independent of MPAM support.

Current kernel branch (one outstanding bug reported but that's hard to hit
and requires setting the narrowing target number of IDs to 1 which is bonkers):
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.5-rc1

Supported:
* PPTT cache description - this is necessary for the cross references MPAM
  table entries use to establish which Cache any given control set influences.
  I included option for generating shared tables which were a common choice
  prior to MPAM needing those cross references.
* CPU emulation for MPAM. Given we aren't doing anything with the content
  this is just a case of adding the MPAM_IDR register and read/write registers
  to control current PARTID / PMG group.
* MPAM MSC emulation for caches and memory controllers.
  Multiple RIS support allows up to 16 such elements to be controlled via
  a single interface (used only for memory currently.
  Most controls wired up, though introspection interface and sanity checks
  only cover some of them so far. No monitoring yet.
* ACPI tables and device instantiation in ARM Virt. ACPI only because the
  kernel patches clearly state the DT binding is a WIP.
* A hack to add lots of caches to the MAX cpu via the relevant CPU registers
  - these are read back to generate the PPTT Table and MPAM devices.

TODO:
- Dealing with case of no NUMA nodes. Currently we don't start if NUMA
  nodes aren't specified and mpam=on.  Defaulting to a single NUMA
  node if MPAM is enabled may make more sense.
- Error injection / reporting on invalid parameters.
- Monitor support.
- Wire up the interrupts properly.
- Tighten checks on unexpected values to further help with catching
  bugs in kernel code (a few already found and fixed by James).
- ACPI table test (yeah I'm lazy).
- Remove remaining 'fixed' constraints on number of partitions etc
  so they can be different across controllers / different levels
  of the hierarchy.
- Expand the qmp introspection interface to cover the missing parts.

Example command line (who doesn't love SMT arm machines?):
aarch64-softmmu/qemu-system-aarch64 -D test.log -d unimp \
 -M virt,nvdimm=on,gic-version=3,mpam=on,mpam_min_msc=on \
 -m 4g -cpu max,core-count=2 \
 -smp 16,sockets=1,clusters=4,threads=2,cache-cluster-start-level=2,cache-node-start-level=3 \
 -kernel Image \
 -drive if=none,file=full.qcow2,format=qcow2,id=hd \
 -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd \
 -qmp-pretty tcp:localhost:4445,server=on,wait=off \
...
 -nographic -no-reboot -append 'earlycon root=/dev/vda2' \
 -bios QEMU_EFI.fd \
 -object memory-backend-ram,size=1G,id=mem0 \
 -object memory-backend-ram,size=1G,id=mem1 \
 -object memory-backend-ram,size=1G,id=mem2 \
 -object memory-backend-ram,size=1G,id=mem3 \
 -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
 -numa node,nodeid=1,cpus=4-7,memdev=mem1 \
 -numa node,nodeid=2,cpus=8-11,memdev=mem2 \
 -numa node,nodeid=3,cpus=12-15,memdev=mem3
 
QMP comamnds:

{ "execute": "qmp_capabilities" }
{ "execute": "query-mpam-cache",
  "arguments": {
    "level": 3
  }
}

Will return something like (reformatted as the pretty version is 'long')
An 'ideal' version of this interface will take some more thought as it
needs to balance readability and clarity with complex implementation of
the code to 'interpret' the register values.

{
    "return": [
        {
            "cpu": 0,
            "level": 3,
            "regs": [
                {
                    "mbwumon-idr": 0,
                    "idr": 758514712831,
                    "cfg-cpbm": [
                        { "words": [ 4294967295 ] },
                        { "words": [ 0 ] },
                        { "words": [ 0 ] },
                        { "words": [ 0 ] },	
                        { "words": [ 0 ] },
			....
			{ "words": [ 0 ] }
                    ],
                    "partid-nrw-idr": 31,
                    "mbw-idr": 0,
                    "csumon-idr": 0,
                    "esr": 0,
                    "ecr": 1,
                    "cfg-part-sel": 0,
                    "iidr": 44042038,
                    "cpor-idr": 32,
                    "msmon-idr": 0,
                    "ccap-idr": 2952791044,
                    "aidr": 17,
                    "pri-idr": 35
                }
            ],
            "type": 3
        }
    ]
}

Jonathan Cameron (5):
  hw/acpi: Add PPTT cache descriptions
  HACK: target/arm/tcg: Add some more caches to cpu=max
  target/arm: Add support for MPAM CPU registers
  hw/arm: Add MPAM emulation.
  hw/arm/virt: Add MPAM MSCs for memory controllers and caches.

 qapi/machine.json           |   8 +-
 qapi/mpam.json              |  78 ++++
 qapi/qapi-schema.json       |   1 +
 include/hw/acpi/aml-build.h |  19 +-
 include/hw/arm/mpam.h       |  13 +
 include/hw/arm/virt.h       |   2 +
 include/hw/boards.h         |   4 +
 target/arm/cpu.h            |  15 +
 hw/acpi/aml-build.c         | 189 +++++++-
 hw/arm/mpam-qapi-stubs.c    |   9 +
 hw/arm/mpam-qapi.c          |  58 +++
 hw/arm/mpam.c               | 886 ++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 327 ++++++++++++-
 hw/arm/virt.c               | 134 ++++++
 hw/core/machine-smp.c       |   8 +
 hw/loongarch/acpi-build.c   |   2 +-
 target/arm/cpu.c            |  10 +-
 target/arm/helper.c         |  30 ++
 target/arm/tcg/cpu64.c      |  12 +
 hw/arm/Kconfig              |   4 +
 hw/arm/meson.build          |   4 +
 qapi/meson.build            |   1 +
 22 files changed, 1803 insertions(+), 11 deletions(-)
 create mode 100644 qapi/mpam.json
 create mode 100644 include/hw/arm/mpam.h
 create mode 100644 hw/arm/mpam-qapi-stubs.c
 create mode 100644 hw/arm/mpam-qapi.c
 create mode 100644 hw/arm/mpam.c

-- 
2.39.2


