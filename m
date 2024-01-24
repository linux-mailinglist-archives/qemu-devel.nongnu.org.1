Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2383AC7A
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jan 2024 15:52:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSebC-0001ZS-OY; Wed, 24 Jan 2024 09:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSeb9-0001Yy-4V
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:51:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSeb6-0008O5-3H
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:51:26 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKmzR6KXCz6J9dr;
 Wed, 24 Jan 2024 22:48:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E4FC140684;
 Wed, 24 Jan 2024 22:51:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 14:51:19 +0000
Date: Wed, 24 Jan 2024 14:51:18 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240124145118.00002f7d@Huawei.com>
In-Reply-To: <20231107180907.553451-3-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-3-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue,  7 Nov 2023 10:07:06 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec 3.0, add dynamic capacity region representative based on
> Table 8-126 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: decode_len of a dc region is aligned to 256*MiB, need to be divided by
> 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> mailbox command.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan,

I'm looking at how to move these much earlier in my tree on basis that
they should be our main focus for merging in this QEMU cycle.

Whilst I do that rebase, I'm taking a closer look at the code.
I'm targetting rebasing on upstream qemu + the two patch sets I just
sent out:
[PATCH 00/12 qemu] CXL emulation fixes and minor cleanup. 
[PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1

It would be good to document why these commands should be optional (which I think
comes down to the annoying fact that Get Dynamic Capacity Configuration isn't
allowed to return 0 regions, but instead should not be available as a command
if DCD isn't supported.

Note this requires us to carry Gregory's patches to make the CCI command list
constructed at runtime rather than baked in ahead of this set.

So another question is should we jump directly to the r3.1 version of DCD?
I think we probably should as it includes some additions that are necessary
for a bunch of the potential use cases.


> ---
>  hw/cxl/cxl-mailbox-utils.c  | 80 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  6 +++
>  include/hw/cxl/cxl_device.h | 17 ++++++++
>  3 files changed, 103 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 8eceedfa87..f80dd6474f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,6 +80,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1210,6 +1212,74 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration

As per the patch set I just sent out, I want to standardize on references
to r3.1 because it's all that is easy to get.  However if we decide to r3.0
DCD first the upgrade it later, then clearly these need to stick to r3.0 for
now.

> + * (Opcode: 4800h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_dyn_cap_config_in_pl {
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_out_pl {
> +        uint8_t num_regions;
> +        uint8_t rsvd1[7];

This changed in r3.1 (errata? - I haven't checked)
Should be 'regions returned' in first byte.

> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint32_t dsmadhandle;

> +            uint8_t flags;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];

There are two fields after this as well.
Total number of supported extents and number of available extents.

That annoyingly means we can't use the structure to tell us where
to find all the fields...


> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> +    uint16_t record_count = 0, i;

Better to split that on to 2 lines. Never hide setting a value
in the middle of a set of declarations.

> +    uint16_t out_pl_len;
> +    uint8_t start_region_id = in->start_region_id;
> +
> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);

For r3.1 + 8 for the two trailing fields.

> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);

As part of the cci rework we started zeroing the whole mailbox payload space
after copying out the input payload.
https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204

So shouldn't need this (unless we have a bug)

Jonathan

