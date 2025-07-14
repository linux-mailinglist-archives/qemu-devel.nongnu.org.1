Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B727B047A1
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 20:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOME-0005Sn-7K; Mon, 14 Jul 2025 14:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubNEv-0000YB-TH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:45:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubNEs-0007fz-7M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:45:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqPf5Rzrz6L5NZ;
 Tue, 15 Jul 2025 01:41:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 50E0B1402ED;
 Tue, 15 Jul 2025 01:45:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:45:09 +0200
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
 <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 00/11] hw/cxl: DCD Fabric Management Command Set (for
 10.1)
Date: Mon, 14 Jul 2025 18:44:56 +0100
Message-ID: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

v2:
- Missing colon and tags (Fan)
- Simpler handling block size parameters. The spec constrains these to
  be power of 2 so the v1 code of BITUL((int)log2(x) is equivalent of
  just using x directly. (Michael)
- Check for power of 2 (Fan + Anisa)

 
Hi Michael,

I consider these ready for upstream.  They are only lightly tweaked from
Anisa's last posting to drop some long lines and change a few patch
titles + drag them to be directly based on upstream rather than on top
of some stuff on my gitlab tree (trivial fuzz + context stuff only in
the rebase).  There is one long line checkpatch warns about but I couldn't
come up with a remotely elegant alternative so it seemed resonable to ignore
that.

The fix from Fan has been on list for a while and is a necessary
precursor of the FMAPI part. You may already have that queued.

Anisa's cover letter for v4 follows which gives a lot more detail on what we have
here.

This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
according to the CXL r3.2 Spec.

The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
commands to the device (QEMU-emulated) through MCTP messages over USB.

Test Configuration:
 - Kernel:
To perform end-to-end tests, both MCTP and DCD support are needed for the kernel.
The kernel version used is Ira's latest DCD branch which is based on 6.15-rc2,
which includes the upstreamed support for MCTP over USB:
https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13

- QEMU:
To enable MCTP over USB in QEMU, Jonathan's RFC patches are applied on ToT master branch
(https://lore.kernel.org/linux-cxl/20250609163334.922346-1-Jonathan.Cameron@huawei.com/T/#m21b9e0dfc689cb1890bb4d961710c23379e04902)

For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
The libcxlmi test program is used to send the command to the device and results
are collected and verified.

For command 0x5602 (Set DC Region Config): device creates an event record with type
DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
if the configuration changes as a result of the command. Currently, the kernel
version used to test this only supports Add/Release type events. Thus, this
request essentially gets ignored but did not cause problems besides the host
not knowing about the configuration change when tested.

For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
tests involve libcxlmi test program (acting as the FM), kernel DCD
code (host) and QEMU device. The test workflow follows that in CXL r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps:
1. Start a VM with CXL topology:

 '-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
     -device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=2,sn=99 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=us0 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k'

2. Load the CXL related drivers in the VM & configure MCTP endpoints:

3. Create a DC region for the DCD device attached:

cxl create-region -m mem0 -d decoder0.0 -s 1G -t dynamic_ram_a

4. Add/release DC extents by sending 0x5604 and 0x5605 respectively through
the following libcxlmi test program:

https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

6. Create a DAX Device from the extents added:

daxctl create-device -r region0
daxctl reconfigure-device dax0.1 -m system-ram

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

Anisa Su (10):
  hw/cxl: mailbox-utils: 0x5600 - FMAPI Get DCD Info
  hw/mem: cxl_type3: Add dsmas_flags to CXLDCRegion struct
  hw/cxl: mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  hw/cxl: Move definition for dynamic_capacity_uuid and enum for DC
    event types to header
  hw/mem: cxl_type3: Add DC Region bitmap lock
  hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  hw/cxl: mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  hw/cxl: Create helper function to create DC Event Records from extents
  hw/cxl: mailbox-utils: 0x5604 - FMAPI Initiate DC Add
  hw/cxl: mailbox-utils: 0x5605 - FMAPI Initiate DC Release

Fan Ni (1):
  hw/cxl: fix DC extent capacity tracking

 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |  31 +-
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 hw/cxl/cxl-events.c          |  38 +++
 hw/cxl/cxl-mailbox-utils.c   | 552 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c           |  83 ++----
 7 files changed, 657 insertions(+), 69 deletions(-)

-- 
2.48.1


