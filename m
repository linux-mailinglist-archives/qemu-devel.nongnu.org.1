Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 894D3B20C3C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 16:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulTfp-0005XU-0c; Mon, 11 Aug 2025 10:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ulTfl-0005XI-Ur
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:38:49 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ulTfc-0000H1-US
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 10:38:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0xyM6SHkz6L5cs;
 Mon, 11 Aug 2025 22:35:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 775781402EF;
 Mon, 11 Aug 2025 22:38:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 11 Aug
 2025 16:38:30 +0200
Date: Mon, 11 Aug 2025 15:38:28 +0100
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>, 
 <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v6 8/8] hw/cxl: Add emulation for memory sparing control
 feature
Message-ID: <20250811153828.00003283@huawei.com>
In-Reply-To: <20250811085530.2263-9-shiju.jose@huawei.com>
References: <20250811085530.2263-1-shiju.jose@huawei.com>
 <20250811085530.2263-9-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 11 Aug 2025 09:55:30 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The
> subclasses for this operation vary in terms of the scope of the sparing
> being performed. The Cacheline sparing subclass refers to a sparing
> action that can replace a full cacheline. Row sparing is provided as an
> alternative to PPR sparing functions and its scope is that of a single
> DDR row. Bank sparing allows an entire bank to be replaced. Rank sparing
> is defined as an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing Maintenance operations.
> 
> The host may issue a query command by setting Query Resources flag in the
> Input Payload (CXL Spec 3.2 Table 8-120) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the Memory
> Sparing Event Record (CXL Spec 3.2 Table 8-60) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory
> device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using DRAM event record, where the 'maintenance needed' flag
> may set. The event record contains some of the DPA, Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
> should be repaired. The userspace tool requests for maintenance operation
> if the 'maintenance needed' flag set in the CXL DRAM error record.
> 
> CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
> discovery and configuration.
> 
> CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
> maintenance operation feature.
> 
> Add emulation for CXL memory device memory sparing control feature
> and memory sparing maintenance operation command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

A few comments inline.  I'll fix up whilst applying to the CXL staging tree.

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 317 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |  44 +++++
>  include/hw/cxl/cxl_device.h |  33 ++++
>  include/hw/cxl/cxl_events.h |   5 +
>  4 files changed, 395 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 254154ceda..a3ab3b48f2 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

> +static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
>                              uint8_t maint_op_class, uint8_t maint_op_sub_class,
> -                            CXLMaintenance *ent)
> +                            CXLMaintenance *ent,
> +                            CXLMemSparingMaintInPayload *sparing_pi)
>  {
>      CXLEventSparing event_rec = {};
>  
> @@ -1615,6 +1852,31 @@ static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
>              strncpy((char *)event_rec.component_id, (char *)ent->component_id,
>                      sizeof(event_rec.component_id));
>          }
> +    } else if (sparing_pi) {
> +        event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
> +        event_rec.result = 0;
> +        event_rec.validity_flags = CXL_MSER_VALID_CHANNEL |
> +                                   CXL_MSER_VALID_RANK |
> +                                   CXL_MSER_VALID_NIB_MASK |
> +                                   CXL_MSER_VALID_BANK_GROUP |
> +                                   CXL_MSER_VALID_BANK |
> +                                   CXL_MSER_VALID_ROW |
> +                                   CXL_MSER_VALID_COLUMN;
> +        event_rec.res_avail = 1;
> +        event_rec.channel = sparing_pi->channel;
> +        event_rec.rank = sparing_pi->rank;
> +        if (sparing_pi->flags & CXL_MEM_SPARING_FLAGS_NIB_MASK_VALID) {
> +            __builtin_memcpy(event_rec.nibble_mask, sparing_pi->nibble_mask,

Why not memcpy()?
Also, wrong size - should be sizeof(sparing_pi->nibble_mask);


> +                             sizeof(uint32_t));
> +        }
> +        event_rec.bank_group = sparing_pi->bank_group;
> +        event_rec.bank = sparing_pi->bank;
> +        event_rec.column = sparing_pi->column;
> +        __builtin_memcpy(event_rec.row, sparing_pi->row, sizeof(uint32_t));

As above.

> +        if (sparing_pi->flags & CXL_MEM_SPARING_FLAGS_SUB_CHANNEL_VALID) {
> +            event_rec.sub_channel = sparing_pi->sub_channel;
> +            event_rec.validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
> +        }
>      } else {
>          return;
>      }


> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 959049aa46..59f8fa7c24 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h

> +#define CXL_MEMDEV_SPARING_GET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_SPARING_SET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_SPARING_SAFE_IN_USE_FLAG    BIT(0)
> +#define CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG    BIT(1)
> +#define CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG    BIT(2)
Odd alignment. If going for aligned values, make sure they all
align fully.  This seems to be 4 spaces, which doesn't relaly
help anything.


