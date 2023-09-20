Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9A7A81B1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwbH-0000Mg-2m; Wed, 20 Sep 2023 08:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiwbD-0000MH-Jh
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:46:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiwb2-0003U7-Mu
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:46:34 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RrJ7H3kPsz6D9CM;
 Wed, 20 Sep 2023 20:41:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 20 Sep
 2023 13:46:20 +0100
Date: Wed, 20 Sep 2023 13:46:18 +0100
To: Gregory Price <gourry.memverge@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, 
 <kwangjin.ko@sk.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v4 1/1] cxl/vendor: SK hynix Niagara Multi-Headed SLD
 Device
Message-ID: <20230920134618.000065a9@Huawei.com>
In-Reply-To: <20230918173656.504628-2-gregory.price@memverge.com>
References: <20230918173656.504628-1-gregory.price@memverge.com>
 <20230918173656.504628-2-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 18 Sep 2023 13:36:56 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Create a new device to emulate the SK hynix Niagara MHSLD platform.
> 
> This device has custom CCI commands that allow for applying isolation
> to each memory block between hosts. This enables an early form of
> dynamic capacity, whereby the NUMA node maps the entire region, but
> the host is responsible for asking the device which memory blocks
> are allocated to it, and therefore may be onlined.
> 
> To instantiate:
> 
> -device cxl-skh-niagara,cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,sn=66666,mhd-head=0,mhd-shmid=15
> 
> The linux kernel will require raw CXL commands enabled to allow for
> passing through of Niagara CXL commands via the CCI mailbox.
> 
> The Niagara MH-SLD has a shared memory region that must be initialized
> using the 'init_niagara' tool located in the vendor subdirectory
> 
> usage: init_niagara <heads> <sections> <section_size> <shmid>
>         heads         : number of heads on the device
>         sections      : number of sections
>         section_size  : size of a section in 128mb increments
>         shmid         : shmid produced by ipcmk
> 
> Example:
> $shmid1=ipcmk -M 131072
> ./init_niagara 4 32 1 $shmid1
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Junhee Ryu <junhee.ryu@sk.com>
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>

Hi Gregory,

Seems this doesn't drop in directly on top of the rest of v3.
The mhd_access_valid check has moved from being a class thing to
an instance thing.

So for now I've reverted that bit in my local tree and will probably
push out later.  Whilst here, some trivial formatting stuff inline
that I was carrying.

Thanks,

Jonathan

> diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> new file mode 100644
> index 0000000000..88e53cc6cc
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c

...

> +static void niagara_alloc_build_output(NiagaraAllocOutput *output,
> +                                       size_t *len_out,
> +                                       uint32_t *section_ids,
> +                                       uint32_t section_count)
> +{
> +    uint32_t extents;
> +    uint32_t previous;
> +    uint32_t i;
> +
> +    /* Build the output */
> +    output->section_count = section_count;
> +    extents = 0;
> +    previous = 0;
> +    for (i = 0; i < section_count; i++) {
> +        if (i == 0) {
> +            /* start the first extent */
> +            output->extents[extents].start_section_id = section_ids[i];
> +            output->extents[extents].section_count = 1;
> +            extents++;
> +        } else if (section_ids[i] == (previous + 1)) {
> +            /* increment the current extent */
> +            output->extents[extents - 1].section_count++;
> +        } else {
> +            /* start a new extent */
> +            output->extents[extents].start_section_id = section_ids[i];
> +            output->extents[extents].section_count = 1;
> +            extents++;
> +        }
> +        previous = section_ids[i];
> +    }
> +    output->extent_count = extents;
> +    *len_out = (8 + (16 * extents));

Too many brackets.

> +    return;
> +}

...

> +static CXLRetCode cmd_niagara_get_section_map(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    CXLNiagaraState *s = CXL_NIAGARA(cci->d);
> +    NiagaraSharedState *nss = s->mhd_state;
> +    NiagaraGetSectionMapInput *input = (void *)payload_in;
> +    NiagaraGetSectionMapOutput *output = (void *)payload_out;
> +    uint32_t *sections = &nss->sections[0];
> +    uint8_t query_type = input->query_type;
> +    uint32_t i;
> +    uint32_t bytes;
> +
> +    if ((query_type != NIAGARA_GSM_QUERY_FREE) &&
> +        (query_type != NIAGARA_GSM_QUERY_ALLOCATED)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    output->ttl_section_count = nss->total_sections;
> +    output->qry_section_count = 0;
> +    bytes = (output->ttl_section_count / 8);
> +    if (output->ttl_section_count % 8) {
> +        bytes += 1;
> +    }
> +
> +    for (i = 0; i < bytes; i++) {
> +        output->bitset[i] = 0x0;
> +    }
> +
> +    /* Iterate the the section list and check the bits */
> +    for (i = 0; (i < nss->total_sections); i++) {
> +        uint32_t section = sections[i];
> +
> +        if (((query_type == NIAGARA_GSM_QUERY_FREE) && (!section)) ||
> +            ((query_type == NIAGARA_GSM_QUERY_ALLOCATED) &&
> +             (section & (1 << s->mhd_head)))) {
> +            uint32_t byte = i / 8;
> +            uint8_t bit = (1 << (i % 8));
Too many brackets

> +
> +            output->bitset[byte] |= bit;
> +            output->qry_section_count++;
> +        }
> +    }
> +
> +    *len_out = (8 + bytes);
And here

> +    return CXL_MBOX_SUCCESS;
> +}
> diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.h b/hw/cxl/vendor/skhynix/skhynix_niagara.h
> new file mode 100644
> index 0000000000..19753ddddb
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.h
> @@ -0,0 +1,162 @@
> +#ifndef CXL_SKH_NIAGARA_H
> +#define CXL_SKH_NIAGARA_H
> +#include <stdint.h>
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_mailbox.h"
> +#include "hw/cxl/cxl_device.h"
> +
> +#define NIAGARA_MIN_MEMBLK (1024 * 1024 * 128)
qemu/units.h and you can use
(128 * MiB)

...

> +/*
> + * Niagara Get Section Map Command
> + * query type:
> + *     Free - Map of free sections
> + *     Allocted - What sections are allocated for this head
allocated

> + * Returns a map of the requested type of sections
> + */
> +#define NIAGARA_GSM_QUERY_FREE 0
> +#define NIAGARA_GSM_QUERY_ALLOCATED 1
> +
> +typedef struct NiagaraGetSectionMapInput {
> +    uint8_t query_type;
> +    uint8_t reserved[7];
> +} QEMU_PACKED NiagaraGetSectionMapInput;
> +
> +typedef struct NiagaraGetSectionMapOutput {
> +    uint32_t ttl_section_count;
> +    uint32_t qry_section_count;
> +    uint8_t bitset[];
> +} QEMU_PACKED NiagaraGetSectionMapOutput;
> +
> +#endif


