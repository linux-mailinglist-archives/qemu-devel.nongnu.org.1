Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DEAE864F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Jun 2025 16:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUR25-0007P9-O2; Wed, 25 Jun 2025 10:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uUR1j-0007MW-Iw
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:23:03 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uUR1c-0005HO-HH
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:23:02 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS3qr5ylgz6K9Bp;
 Wed, 25 Jun 2025 22:20:08 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id BD259140427;
 Wed, 25 Jun 2025 22:22:41 +0800 (CST)
Received: from localhost (10.45.148.101) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 16:22:40 +0200
Date: Wed, 25 Jun 2025 15:22:34 +0100
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>,
 <armbru@redhat.com>, <mst@redhat.com>, <anisa.su887@gmail.com>
Subject: Re: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Message-ID: <20250625152234.0000159e.alireza.sanaee@huawei.com>
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.148.101]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 23 May 2024 10:44:40 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <nifan.cxl@gmail.com>
> 
> A git tree of this series can be found here (with one extra commit on
> top for printing out accepted/pending extent list for testing): 
> https://github.com/moking/qemu/tree/dcd-v8-qapi
> 
> v7->v8:
> 
> This version carries over the following two patches from Gregory.
> 1. hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
> reference https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
> 2. hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5
> 
> Note, the above two patches are not directly related to DCD emulation.
> 
> All the following patches in this series are built on top of
> mainstream QEMU and the above two patches.
> 
> The most significant changes of v8 is in Patch 11 (Patch 9 in v7).
> Based on feedback from Markus and Jonathan, the QMP interfaces for
> adding and releasing DC extents have been redesigned and now they
> look like below,
> 
> # add a 128MB extent at offset 0 to region 0
> 	{ "execute": "cxl-add-dynamic-capacity",
> 	  "arguments": {
> 		  "path": "/machine/peripheral/cxl-memdev0",
>           "host-id":0,
>           "selection-policy": 'prescriptive',
> 		  "region": 0,
>           "tag": "",
> 		  "extents": [
> 		  {
> 			  "offset": 0,
> 			  "len": 134217728
> 		  }
> 		  ]
> 	  }
> 	}
> 
> Note: tag is optional.
> 
> # Release a 128MB extent at offset 0 from region 0
>  { "execute": "cxl-release-dynamic-capacity",
> 	  "arguments": {
> 		  "path": "/machine/peripheral/cxl-memdev0",
>           "host-id":0,
>           "removal-policy":"prescriptive",
>           "forced-removal": false,
>           "sanitize-on-release": false,
>           "region": 0,
>           "tag": "",
> 		  "extents": [
> 		  {
> 			  "offset": 0,
> 			  "len": 134217728
> 		  }
> 		  ]
> 	  }
> 	}
>     
> Note: removal-policy, sanitize-on-release and tag are optional.
>     
> Other changes include,
> 1. Applied tags to patches. 
> 2. Replaced error_setq with error_append_hint for
> cxl_create_dc_region error case in Patch 6 (Patch 4 in v7); (Zhijian
> Li) 3. Updated the error message to include region size information in
>     cxl_create_dc_region.
> 4. set range1_size_hi to 0 for DCD in build_dvsec. (Jonathan)
> 5. Several minor format fixes.
> 
> Thanks Markus, Jonathan, Gregory, and Zhijian for reviewing v7 and
> svetly Todorov for testing v7.
> 
> This series pass the same tests as v7 check the cover letter of v7 for
> more details. Additionally, we tested the QAPI interface for
> adding/releasing DC extents with optional input parameters.
>   
> 
> v7: https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#mec4c85022ce28c80b241aaf2d5431cadaa45f097
> 
> 
> Fan Ni (12):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
>     size instead of mr as argument
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC
> extent list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support
> add/release dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add DPA range validation for accesses to DC
> regions hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox
> support hw/mem/cxl_type3: Allow to release extent superset in QMP
> interface
> 
> Gregory Price (2):
>   hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
>     reference
>   hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> 
>  hw/cxl/cxl-mailbox-utils.c  | 658
> +++++++++++++++++++++++++++++++++++- hw/mem/cxl_type3.c          |
> 634 ++++++++++++++++++++++++++++++++-- hw/mem/cxl_type3_stubs.c    |
> 25 ++ include/hw/cxl/cxl_device.h |  85 ++++-
>  include/hw/cxl/cxl_events.h |  18 +
>  qapi/cxl.json               | 143 ++++++++
>  6 files changed, 1511 insertions(+), 52 deletions(-)
> 

Hi Nifan,

I am trying to test this patchset with Ira's set on DCD, and I am
trying to work out everything by using sysfs rather than using tools
instead. I am not sure where things are going of the rail.

I am using this patchset
(https://lore.kernel.org/qemu-devel/20240523174651.1089554-2-nifan.cxl@gmail.com/) with Ira's v9 https://lore.kernel.org/all/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

This my CXL config:
return [
    "-m",      "6G,maxmem=20G,slots=10",
    "-object", "memory-backend-ram,id=vmem0,share=on,size=2G",
    "-device", "pxb-cxl,bus_nr=23,bus=pcie.0,id=cxl.1",
    "-device","cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2", 
    "-device","cxl-type3,bus=root_port13,volatile-dc-memdev=vmem0,id=cxl-vmem0,num-dc-regions=2",
    "-M", "cxl=on,cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G" 
]


This is how I create a new CXL DC Region ready to work with.

# creating a region
region=$(cat
/sys/bus/cxl/devices/decoder0.0/create_dynamic_ram_a_region) 
echo $region

echo $region >
/sys/bus/cxl/devices/decoder0.0/create_dynamic_ram_a_region 
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity 
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dynamic_ram_a" > /sys/bus/cxl/devices/decoder2.0/mode
echo $((256 << 20)) > /sys/bus/cxl/devices/decoder2.0/dpa_size

echo $((256 << 20)) > /sys/bus/cxl/devices/$region/size
echo "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit

echo $region > /sys/bus/cxl/drivers/cxl_region/bind

After this I have two things created, region0 and dax_region0:

root@localhost:~# ls /sys/bus/cxl/devices/
dax_region0/    decoder1.0/     decoder1.2/     decoder2.0/
decoder2.2/     endpoint2/      nvdimm-bridge0/ region0/ decoder0.0/
 decoder1.1/     decoder1.3/     decoder2.1/     decoder2.3/     mem0/
         port1/          root0/

This is what I have in dax_region0:
root@localhost:~# ls /sys/bus/cxl/devices/dax_region0/
dax0.0  dax_region  devtype  driver  modalias  subsystem  uevent

Now I want to add an extent, and this is how I am doing it:
	
	{ "execute": "cxl-add-dynamic-capacity",
	  "arguments": {
		  "path": "/machine/peripheral/cxl-memdev0",
          "host-id":0,
          "selection-policy": 'prescriptive',
		  "region": 0,
          "tag": "",
		  "extents": [
		  {
			  "offset": 0,
			  "len": 134217728
		  }
		  ]
	  }
	}

Now I see the extent added in my region device:
root@localhost:~# ls /sys/bus/cxl/devices/dax_region0/
dax0.0  dax_region  devtype  driver  extent0.0  modalias  subsystem
uevent root@localhost:~# ls /sys/bus/cxl/devices/dax_region0/extent0.0/
length  offset  uevent

This is where things will go off the rails, at this point I want to
create a new dax device to use, but this part is unsuccessful. Here I
first add some size to the dax region created before: 

root@localhost:~# echo 67108864 > /sys/bus/dax/devices/dax0.0/size 
[264.539280] dax:alloc_dev_dax_range:1015: dax dax0.0: alloc range[0]:
0x0000000810000000:0x0000000813ffffff 

When I check the size everything looks OK: 
root@localhost:~# cat /sys/bus/dax/devices/dax0.0/size 
67108864

But when I want to bind it then it does not work:
root@localhost:~# echo "dax0.0" > /sys/bus/dax/drivers/device_dax/bind
-bash: echo: write error: No such device

I believe I am missing something here. Would be good if you can help
out here.

Thanks,
Alireza


