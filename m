Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB365B48F55
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 15:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbpk-0007FC-97; Mon, 08 Sep 2025 09:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uvbpZ-0007B4-2b
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:22:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uvbpK-0001Fv-2m
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:22:45 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250908132220epoutp017e7a9aa2c520b00ac1fa268f206c9308~jUV1UBJfs1222112221epoutp01k
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 13:22:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250908132220epoutp017e7a9aa2c520b00ac1fa268f206c9308~jUV1UBJfs1222112221epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1757337740;
 bh=knrzU4zTXN/S8XJVF6YHpcWSR50Tq3TSEQe5tajVzvg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vg63lgP9m5WtBYvjTpQZjdoWot1Rud8rC1IufjiJ6KqqdCULvHXaSjoOGvQ0ZOK2m
 qkXEm7XpzID+l/mQ4eqx49neXjGqduTPqfPJWv+89rMJwJTRtrpnTIjnLRqNDL1vWl
 AEYdN0pfz9spkqG+LZq1t7t6u5QfG1aOqZnzp4HU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20250908132220epcas5p1ffbdbb4c9ef7992a034859d65dc0e254~jUV03-xw00535705357epcas5p1I;
 Mon,  8 Sep 2025 13:22:20 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.95]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4cL70W3RM7z3hhT8; Mon,  8 Sep
 2025 13:22:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250908132218epcas5p3d3ed20009f5c6b0dd6d09a3797ad734f~jUVzfyrT90755907559epcas5p3v;
 Mon,  8 Sep 2025 13:22:18 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250908132217epsmtip138506816a6dccb23b458d72e1d5a945d~jUVxyjzD82205422054epsmtip1D;
 Mon,  8 Sep 2025 13:22:16 +0000 (GMT)
Date: Mon, 8 Sep 2025 18:52:11 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH v3 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20250908132211.tusasxcwx45d474x@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250905171252.00004c72@huawei.com>
X-CMS-MailID: 20250908132218epcas5p3d3ed20009f5c6b0dd6d09a3797ad734f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1
References: <CGME20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1@epcas5p2.samsung.com>
 <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <20250905171252.00004c72@huawei.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/09/25 05:12PM, Jonathan Cameron wrote:
>On Thu,  4 Sep 2025 18:49:02 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> This patch series refactor existing support for Identify Switch Device
>> and Get Physical Port State by utilizing physical ports (USP & DSP)
>> information stored during enumeration.
>>
>> Additionally, it introduces new support for Physical Port Control
>> of FM-API based physical switch command set as per CXL spec r3.2
>> Table 8-230:Physical Switch. It primarily constitutes two logic:
>> -Assert-Deassert PERST: Assert PERST involves physical port to be in
>>  hold reset phase for minimum 100ms. No other physical port control
>>  request are entertained until Deassert PERST command for the given
>>  port is issued.
>> -Reset PPB: cold reset of physical port (completing enter->hold->exit phases).
>>
>> Tested using libcxl-mi interface[1]:
>> All active ports and all opcodes per active port is tested. Also, tested
>> against possible edge cases manually since the interface currently dosen't
>> support run time input.
>>
>> Example topology (1 USP + 3 DSP's->switch with 2 CXLType3 devices connected
>> to 2 DSP's):
>> FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
>>     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
>>     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
>>     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
>>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>>     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>>     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>>     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
>>     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>>     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>>     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
>>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
>>     -device virtio-rng-pci,bus=swport1"
>>
>> Multiple Qemu Topologies tested:
>> -without any devices connected to downstream ports.
>> -with virtio-rng-pci devices connected to downstream ports.
>> -with CXLType3 devices connected to downstream ports.
>> -with different unique values of ports (both upstream and downstream).
>>
>> Changes from v2->v3:
>> -cxl_set_port_type(): optimized storing of strucutre members.
>> -namespace defines instead of enum.
>> -Calculating size for active_port_bitmask than hardcoding to 0x20.
>> -Defined struct phy_port directly inside struct CXLUpstreamPort as pports.
>> -Renamed struct pperst to struct CXLPhyPortPerst.
>> -Optimized perst member initializations for ports inside
>>  cxl_initialize_usp_mctpcci() using active_port_bitmask.
>>
>> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
>>
>> The patches are generated against the Johnathan's tree
>> https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.
>>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>
>Hi Arpit,
>
>I'll have a go (probably next week) at rebasing this rather earlier in my tree as I'd
>like to get this upstream without it having a dependency on the MCTP support.
>
>That means bring it up with the switch-cci / pcie mailbox CCI and squashing
>the MCTP bit into the patch that brings that support up later in my tree.
>
>I do plan to fix up the remaining 'feature' gap on the FMAPI/MCTP/USB
>emulation which is that it's ignoring the MTU to the host and so not
>breaking messages up as it should.  Linux doesn't care but maybe some other
>OS will. Not entirely sure when I'll get to that though and I'd like to
>move your work forward before that.
>
>Jonathan
>
>
Hi Jonathan,
Thanks for the review comments!

As per my understanding from CXL spec r3.2 Table 8-215: Physical Port Control
request is allowed only for switch FM interface and is prohibited for
switch-cci/pcie mailbox CCI. However, if possible, should I be using
cxl_initialize_mailbox_swcci() to initialize my perst members?

Thanks,
Arpit.
>>
>> Arpit Kumar (2):
>>   hw/cxl: Refactored Identify Switch Device & Get Physical Port State
>>   hw/cxl: Add Physical Port Control (Opcode 5102h)
>>
>>  hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
>>  include/hw/cxl/cxl_device.h               |  76 +++++
>>  include/hw/cxl/cxl_mailbox.h              |   1 +
>>  include/hw/pci-bridge/cxl_upstream_port.h |   9 +
>>  4 files changed, 347 insertions(+), 107 deletions(-)
>>
>

------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_
Content-Type: text/plain; charset="utf-8"


------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_f7f1f_--

