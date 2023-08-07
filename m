Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D177295E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:37:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2HM-0007bi-9N; Mon, 07 Aug 2023 11:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qT2HJ-0007bC-Aq
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:36:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qT2HE-0006Uf-Su
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:36:17 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKKzN2Qd1z67HqD;
 Mon,  7 Aug 2023 23:31:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 16:36:08 +0100
Date: Mon, 7 Aug 2023 16:36:07 +0100
To: Gregory Price <gourry.memverge@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, 
 <kwangjin.ko@sk.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 4/4] cxl/vendor: SK hynix Niagara Multi-Headed SLD Device
Message-ID: <20230807163607.00004f63@Huawei.com>
In-Reply-To: <20230721163505.1910-5-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
 <20230721163505.1910-5-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 21 Jul 2023 12:35:09 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Create a new device to emulate the SK hynix Niagara MHSLD platform.
> 
> This device has custom CCI commands that allow for applying isolation
> to each memory block between hosts. This enables an early form of
> dynamic capacity, whereby the NUMA node maps the entire region, but
> the host is responsible for asking the device which memory blocks
> are allocated to it, and therefore may be onlined.
> 
> To instantiate, wrap a cxl-type3 mhd in a cxl-skh-niagara like so:
> 
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,sn=66666,is_mhd=true,mhd_head=0,mhd_shmid=15
> -device cxl-skh-niagara,target=cxl-mem0

Hmm. I'm not sure why the wrapping makes sense rather than inheriting form
the cxl-type3 device - with appropriate class provided overrides of functions
etc and relying on the qemu object model to allow you to cast up
and down the inheritance tree.

A few related bits inline on that.

> 
> The linux kernel will require raw CXL commands enabled to allow for
> passing through of Niagara CXL commands via the CCI mailbox.
> 
> The Niagara MH-SLD has a slightly different shared memory region
> than the base MHD, so an additional tool ('init_niagara') is located
> in the vendor subdirectory.  Utilize this in place of cxl_mhd_init.
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

I'm definitely fine with emulating real devices that go beyond what is
defined in the CXL spec, so great to see one being proposed.

Most comments are cleanup related.

> ---
>  hw/cxl/Kconfig                          |   4 +
>  hw/cxl/meson.build                      |   2 +
>  hw/cxl/vendor/meson.build               |   1 +
>  hw/cxl/vendor/skhynix/.gitignore        |   1 +
>  hw/cxl/vendor/skhynix/init_niagara.c    |  99 +++++
>  hw/cxl/vendor/skhynix/meson.build       |   1 +
>  hw/cxl/vendor/skhynix/skhynix_niagara.c | 521 ++++++++++++++++++++++++
>  7 files changed, 629 insertions(+)
>  create mode 100644 hw/cxl/vendor/meson.build
>  create mode 100644 hw/cxl/vendor/skhynix/.gitignore
>  create mode 100644 hw/cxl/vendor/skhynix/init_niagara.c
>  create mode 100644 hw/cxl/vendor/skhynix/meson.build
>  create mode 100644 hw/cxl/vendor/skhynix/skhynix_niagara.c
> 
> diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
> index c9b2e46bac..dd6c54b54d 100644
> --- a/hw/cxl/Kconfig
> +++ b/hw/cxl/Kconfig
> @@ -2,5 +2,9 @@ config CXL
>      bool
>      default y if PCI_EXPRESS
>  
> +config CXL_VENDOR
> +    bool
> +    default y
> +
>  config I2C_MCTP_CXL
>      bool
> diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
> index 1393821fc4..e8c8c1355a 100644
> --- a/hw/cxl/meson.build
> +++ b/hw/cxl/meson.build
> @@ -15,3 +15,5 @@ system_ss.add(when: 'CONFIG_CXL',
>  system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
>  
>  system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
> +
> +subdir('vendor')
> diff --git a/hw/cxl/vendor/meson.build b/hw/cxl/vendor/meson.build
> new file mode 100644
> index 0000000000..12db8991f1
> --- /dev/null
> +++ b/hw/cxl/vendor/meson.build
> @@ -0,0 +1 @@
> +subdir('skhynix')
> diff --git a/hw/cxl/vendor/skhynix/.gitignore b/hw/cxl/vendor/skhynix/.gitignore
> new file mode 100644
> index 0000000000..6d96de38ea
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/.gitignore
> @@ -0,0 +1 @@
> +init_niagara
> diff --git a/hw/cxl/vendor/skhynix/init_niagara.c b/hw/cxl/vendor/skhynix/init_niagara.c
> new file mode 100644
> index 0000000000..28612339e0
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/init_niagara.c

I'm not sure we should burry tooling all the way down here.  Not much under tools though.

> @@ -0,0 +1,99 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2023 MemVerge Inc.
> + * Copyright (c) 2023 SK hynix Inc.
> + *
> + * Reference list:
> + * From www.computeexpresslink.org
> + * Compute Express Link (CXL) Specification revision 3.0 Version 1.0

Not much CXL 3.0 in this file!

> + */
> +
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +struct niagara_state {
> +    uint8_t nr_heads;
> +    uint8_t nr_lds;
> +    uint8_t ldmap[65536];
> +    uint32_t total_sections;
> +    uint32_t free_sections;
> +    uint32_t section_size;
> +    uint32_t sections[];
> +};
> +
> +int main(int argc, char *argv[]) {

New line before {

It's in the qemu tree, so we should stick to qemu style mostly.

> +    int shmid = 0;
> +    uint32_t sections = 0;
> +    uint32_t section_size = 0;
> +    uint32_t heads = 0;
> +    struct niagara_state* niagara_state = 0;

NULL

> +    uint8_t i;
> +
> +    if (argc != 5) {
> +        printf("usage: init_niagara <heads> <sections> <section_size> <shmid>\n"
> +                "\theads         : number of heads on the device\n"
> +                "\tsections      : number of sections\n"
> +                "\tsection_size  : size of a section in 128mb increments\n"
> +                "\tshmid         : /tmp/mytoken.tmp\n\n"
> +                "It is recommended your shared memory region is at least 128kb\n");
> +        return -1;
> +    }
> +
> +    // must have at least 1 head
> +    heads = (uint32_t)atoi(argv[1]);
> +    if (heads == 0 || heads > 32) {
> +        printf("bad heads argument (1-32)\n");
> +        return -1;
> +    }
> +
> +    // Get number of sections
> +    sections = (uint32_t)atoi(argv[2]);
> +    if (sections == 0) {
> +        printf("bad sections argument\n");
> +        return -1;
> +    }
> +
> +    section_size = (uint32_t)atoi(argv[3]);
> +    if (sections == 0) {
> +        printf("bad section size argument\n");
> +        return -1;
> +    }
> +
> +    shmid = (uint32_t)atoi(argv[4]);
> +    if (shmid== 0) {
> +        printf("bad shmid argument\n");
> +        return -1;
> +    }
> +
> +    niagara_state = shmat(shmid, NULL, 0);
> +    if (niagara_state == (void*)-1) {
> +        printf("Unable to attach to shared memory\n");
> +        return -1;
> +    }
> +
> +    // Initialize the niagara_state
> +    size_t niagara_state_size = sizeof(struct niagara_state) + (sizeof(uint32_t) * sections);
> +    memset(niagara_state, 0, niagara_state_size);
> +    niagara_state->nr_heads = heads;
> +    niagara_state->nr_lds = heads;
> +    niagara_state->total_sections = sections;
> +    niagara_state->free_sections = sections;
> +    niagara_state->section_size = section_size;
> +
> +    memset(&niagara_state->ldmap, '\xff', sizeof(niagara_state->ldmap));
> +    for (i = 0; i < heads; i++)
> +        niagara_state->ldmap[i] = i;
> +
> +    printf("niagara initialized\n");
> +    shmdt(niagara_state);
> +    return 0;
> +}
> diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> new file mode 100644
> index 0000000000..4e57db65f1
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> new file mode 100644
> index 0000000000..1224978585
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> @@ -0,0 +1,521 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2023 MemVerge Inc.
> + * Copyright (c) 2023 SK hynix Inc.
> + *
> + * Reference list:
> + * From www.computeexpresslink.org
> + * Compute Express Link (CXL) Specification revision 3.0 Version 1.0
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_device.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_port.h"
> +#include "hw/qdev-properties.h"
> +
> +#define MIN_MEMBLK_SIZE (1024*1024*128)
> +
> +/*
> + * The shared state cannot have 2 variable sized regions
> + * so we have to max out the ldmap.
> +*/
> +typedef struct Niagara_Shared_State Niagara_Shared_State;

Qemu is all camel case for types and combined struct definitions
with typdefs

typedef struct NiagraSharedState {
    uint8_t nr_heads;
    uint8_t nr_lds;
    uint8_t ldmap[65536];
    uint32_t total_sections;
    uint32_t free_sections;
    uint32_t section_size;
    uint32_t sections[];
} NiagraSharedstate;

> +struct Niagara_Shared_State {
> +    uint8_t nr_heads;
> +    uint8_t nr_lds;
> +    uint8_t ldmap[65536];
> +    uint32_t total_sections;
> +    uint32_t free_sections;
> +    uint32_t section_size;
> +    uint32_t sections[];
> +};
> +
> +#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> +#define IMMEDIATE_DATA_CHANGE (1 << 2)
> +#define IMMEDIATE_POLICY_CHANGE (1 << 3)
> +#define IMMEDIATE_LOG_CHANGE (1 << 4)
> +#define SECURITY_STATE_CHANGE (1 << 5)
> +#define BACKGROUND_OPERATION (1 << 6)

Lift these out of the core cxl code into a suitable header rather than
repeating. Fair enough not in first RFC though.

> +
> +enum {
> +    NIAGARA = 0xC0

Good it's in the vendor defined space. I wondered after your
comment earlier on there not being one defined!

> +        #define GET_SECTION_STATUS 0x0
> +        #define SET_SECTION_ALLOC 0x1
> +        #define SET_SECTION_RELEASE 0x2
> +        #define SET_SECTION_SIZE 0x3
> +        #define MOVE_DATA 0x4
> +        #define GET_SECTION_MAP 0x5
> +        #define CLEAR_SECTION 0x99
> +};
> +
> +static CXLRetCode cmd_niagara_get_section_status(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len_in,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    Niagara_Shared_State *niagara_state = (Niagara_Shared_State*)ct3d->mhd_state;
> +    struct {
> +        uint32_t total_section_count;
> +        uint32_t free_section_count;
> +    } QEMU_PACKED *output = (void *)payload_out;
> +
> +    if (!ct3d->is_mhd)
> +        return CXL_MBOX_UNSUPPORTED;
> +
> +    output->total_section_count = niagara_state->total_sections;
> +    output->free_section_count = niagara_state->free_sections;
> +
> +    *len_out = sizeof(*output);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +#define MHD_SECTION_ALLOC_POLICY_ALL_OR_NOTHING 0
> +#define MHD_SECTION_ALLOC_POLICY_BEST_EFFORT 1
> +#define MHD_SECTION_ALLOC_POLICY_MANUAL 2

Even though they are buried down here, good to name these so they
are niagara specific.

> +static CXLRetCode cmd_niagara_set_section_alloc(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    Niagara_Shared_State *niagara_state = (Niagara_Shared_State*)ct3d->mhd_state;
> +    struct {
> +        uint8_t policy;
> +        uint8_t reserved1[3];
> +        uint32_t section_count;
> +        uint8_t reserved2[4];
> +        uint32_t extent_count;
> +        struct {
> +            uint32_t start_section_id;
> +            uint32_t section_count;
> +            uint8_t reserved[8];
> +        } extents[];
> +    } QEMU_PACKED *input = (void *)payload_in;
> +    struct {
> +        uint32_t section_count;
> +        uint32_t extent_count;
> +        struct {
> +            uint32_t start_section_id;
> +            uint32_t section_count;
> +            uint8_t reserved[8];
> +        } extents[];
> +    } QEMU_PACKED *output = (void *)payload_out;
> +
> +    uint8_t policy = input->policy;
> +    uint32_t count = input->section_count;
> +    uint32_t i = 0;
> +
> +    if (count == 0 || count > niagara_state->total_sections) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (input->policy == MHD_SECTION_ALLOC_POLICY_MANUAL) {
> +        /* iterate input extents and count total sections for validation */
> +        uint32_t ttl_sec = 0;
> +        for (i = 0; i < input->extent_count; i++) {
> +            uint32_t start = input->extents[i].start_section_id;
> +            uint32_t end = start + input->extents[i].section_count;
> +            if ((start >= niagara_state->total_sections) || (end > niagara_state->total_sections))
> +                return CXL_MBOX_INVALID_INPUT;
> +            ttl_sec += input->extents[i].section_count;
> +        }
> +        if (ttl_sec != input->section_count)

Brackets needed.

> +            return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    uint32_t *section_ids = malloc(count*sizeof(uint32_t));

docs/devel/style.rst:

"
Declarations
============

Mixed declarations (interleaving statements and declarations within
blocks) are generally not allowed; declarations should be at the beginning
of blocks
"

This is looking like it might benefit from being split into multiple functions
as a lot going on in here!

> +    uint32_t *sections = &niagara_state->sections[0];
> +    uint32_t allocated = 0;
> +
> +    if (input->policy & MHD_SECTION_ALLOC_POLICY_MANUAL) {
> +        uint32_t cur_extent = 0;

No need to init. Also blank line after declarations

> +        for (cur_extent = 0; cur_extent < input->extent_count; cur_extent++) {
> +            uint32_t start_section = input->extents[cur_extent].start_section_id;
> +            uint32_t count = input->extents[cur_extent].section_count;
> +            uint32_t cur_section;
blank line here etc.

> +            for (cur_section = input->extents[cur_extent].start_section_id;
> +                 cur_section < (start_section + count);

Brackets don't add anything.

> +                 cur_section++) {
> +                uint32_t *section = &sections[cur_section];
> +                uint32_t old_value = __sync_fetch_and_or(section, (1 << ct3d->mhd_head));
> +                /* if the old value wasn't 0, this section was already claimed

Wrong comment syntax.

> +                 * if it was owned by use already, just continue and don't count it
> +                 */
> +                if (old_value & (1 << ct3d->mhd_head)) {
> +                    continue;

You continued, no need for an else after it.

> +                } else if (old_value != 0) {
> +                    __sync_fetch_and_and(section, ~(1 << ct3d->mhd_head));
> +                    continue;
> +                }
> +                __sync_fetch_and_sub(&niagara_state->free_sections, 1);
> +                section_ids[allocated++] = i;
> +            }
> +        }
> +    } else {
> +        /* Iterate the the section list and allocate free sections */
> +        for (i = 0; (i < niagara_state->total_sections) && (allocated != count); i++) {
> +            uint32_t old_value = __sync_fetch_and_or(&sections[i], (1 << ct3d->mhd_head));
> +            /* if the old value wasn't 0, this section was already claimed
As above

> +             * if it was owned by use already, just continue and don't count it
> +             */
> +            if (old_value & (1 << ct3d->mhd_head)) {
> +                continue;

Continued so no point in else

> +            } else if (old_value != 0) {
> +                __sync_fetch_and_and(&sections[i], ~(1 << ct3d->mhd_head));
> +                continue;
> +            }
> +            __sync_fetch_and_sub(&niagara_state->free_sections, 1);
> +            section_ids[allocated++] = i;

Quite a bit common with previous leg.  Perhaps a utility function with that
stuff factored out?

> +        }
> +    }
> +
> +    if ((policy & MHD_SECTION_ALLOC_POLICY_ALL_OR_NOTHING) &&
> +        (allocated != count)) {
> +        goto all_or_nothing_fail;
> +    }
> +
> +    /* Build the output */
> +    output->section_count = allocated;
> +    uint32_t extents = 0;
> +    uint32_t previous = 0;
> +    for (i=0; i < allocated; i++) {
> +        if (i == 0) {
> +            /* start the first extent */
> +            output->extents[extents].start_section_id = section_ids[i];
> +            output->extents[extents].section_count = 1;
> +            extents++;
> +        }
> +        else if (section_ids[i] == (previous+1)) {
> +            /* increment the current extent */
> +            output->extents[extents-1].section_count++;
> +        }
> +        else {
> +            /* start a new extent */
> +            output->extents[extents].start_section_id = section_ids[i];
> +            output->extents[extents].section_count = 1;
> +            extents++;
> +        }
> +        previous = section_ids[i];
> +    }
> +    output->extent_count = extents;
> +
> +    *len_out = (8+(16*extents));
> +
> +    free(section_ids);

Looks like a g_autofree pointer would help.

> +    return CXL_MBOX_SUCCESS;
> +all_or_nothing_fail:
> +    /* free any successfully allocated sections */
> +    for (i = 0; i < allocated; i++) {
> +        __sync_fetch_and_and(&sections[i], ~(1 << ct3d->mhd_head));
> +        __sync_fetch_and_add(&niagara_state->free_sections, 1);
> +    }
> +    free(section_ids);
> +    return CXL_MBOX_INTERNAL_ERROR;
> +}
> +
> +#define MHD_SECTION_RELEASE_POLICY_NONE 0
> +#define MHD_SECTION_RELEASE_POLICY_CLEARING 1
> +#define MHD_SECTION_RELEASE_POLICY_RANDOMIZING 2

As above, I'd like these in a niagra specific namespace.

> +static CXLRetCode cmd_niagara_set_section_release(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    Niagara_Shared_State *niagara_state = (Niagara_Shared_State*)ct3d->mhd_state;
> +    struct {
> +        uint32_t extent_count;
> +        uint8_t policy;
> +        uint8_t reserved[3];
> +        struct {
> +            uint32_t start_section_id;
> +            uint32_t section_count;
> +            uint8_t reserved[8];
> +        } extents[];
> +    } QEMU_PACKED *input = (void *)payload_in;
> +    uint32_t i, j;
> +
> +    uint32_t* sections = &niagara_state->sections[0];
> +    for (i = 0; i < input->extent_count; i++) {
> +        uint32_t start = input->extents[i].start_section_id;
> +        for (j = 0; j < input->extents[i].section_count; j++) {
> +            uint32_t old_val = __sync_fetch_and_and(&sections[start+j], ~(1 << ct3d->mhd_head));

Fix up spacing around operators.

> +            if (old_val & (1 << ct3d->mhd_head))
> +                __sync_fetch_and_add(&niagara_state->free_sections, 1);

{}

> +
> +            // TODO: Policy
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode cmd_niagara_set_section_size(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    Niagara_Shared_State *niagara_state = (Niagara_Shared_State*)ct3d->mhd_state;

My gut feeling for now would be to pull the mhd shared state into this driver state
as that will reduce impact on the main type 3 driver whilst we work out what this
all looks like.

> +    struct {
> +        uint8_t section_unit;
> +        uint8_t reserved[7];
> +    } QEMU_PACKED *input = (void *)payload_in;
> +    struct {
> +        uint8_t section_unit;
> +        uint8_t reserved[7];
> +    } QEMU_PACKED *output = (void *)payload_out;
> +
> +    if (niagara_state->section_size ==  (1 << (input->section_unit - 1)))
> +        goto set_section_size_success;

I'd just have the handling here to simplify flow.  Or flip condition and indent the
rest.

{}

> +
> +    /* Check that there are no actively alloc'd sections */
> +    if(niagara_state->free_sections != niagara_state->total_sections)
> +        return CXL_MBOX_INTERNAL_ERROR;

{}

> +
> +    uint32_t prev_section_size = niagara_state->section_size;
> +    uint32_t prev_total_sections = niagara_state->total_sections;
> +
> +    niagara_state->section_size = (1 << (input->section_unit - 1));
> +    niagara_state->total_sections = (prev_section_size * prev_total_sections) / niagara_state->section_size;
> +    niagara_state->free_sections = niagara_state->total_sections;
> +
> +set_section_size_success:
> +    output->section_unit = input->section_unit;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +#define MHD_MOVE_DATA_POLICY_CLEARING 0
> +#define MHD_MOVE_DATA_POLICY_NONE 1
> +static CXLRetCode cmd_niagara_move_data(const struct cxl_cmd *cmd,
> +                                      uint8_t *payload_in,
> +                                      size_t len_in,
> +                                      uint8_t *payload_out,
> +                                      size_t *len_out,
> +                                      CXLCCI *cci)
> +{
> +    struct {
> +        uint32_t extent_count;
> +        uint8_t policy;
> +        uint8_t reserved[3];
> +        struct {
> +            uint32_t source_section_id;
> +            uint32_t source_data_offset;
> +            uint32_t destination_section_id;
> +            uint32_t destination_data_offset;
> +            uint32_t data_length;
> +            uint8_t reserved[4];
> +        } extents;
> +    } QEMU_PACKED *input = (void *)payload_in;
> +
> +    struct {
> +        uint64_t task_id;
> +        uint32_t bitset[];
> +    } QEMU_PACKED *output = (void *)payload_out;
> +
> +    (void)input;
> +    (void)output;

Don't supply this one either if not implemented yet!  Be nice to us
reviewers :)

> +
> +    return CXL_MBOX_UNSUPPORTED;
> +}
> +
> +static CXLRetCode cmd_niagara_clear_section(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLCCI *cci)
> +{
> +    return CXL_MBOX_UNSUPPORTED;

Umm. Don't supply it then! :)

> +}
> +
> +#define MHD_GSM_QUERY_FREE 0
> +#define MHD_GSM_QUERY_ALLOCATED 1
> +static CXLRetCode cmd_niagara_get_section_map(const struct cxl_cmd *cmd,
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    Niagara_Shared_State *niagara_state = (Niagara_Shared_State*)ct3d->mhd_state;
> +    struct {
> +        uint8_t query_type;
> +        uint8_t reserved[7];
> +    } QEMU_PACKED *input = (void *)payload_in;
> +    struct {
> +        uint32_t ttl_section_count;
> +        uint32_t qry_section_count;
> +        uint8_t bitset[];
> +    } QEMU_PACKED *output = (void *)payload_out;
> +
> +    uint8_t query_type = input->query_type;
> +    uint32_t i;
> +
> +    if ((query_type != MHD_GSM_QUERY_FREE) && (query_type != MHD_GSM_QUERY_ALLOCATED))
> +        return CXL_MBOX_INVALID_INPUT;
> +
> +    output->ttl_section_count = niagara_state->total_sections;
> +    output->qry_section_count = 0;
> +    uint32_t bytes = (output->ttl_section_count/8);
> +    if (output->ttl_section_count % 8)
> +        bytes += 1;
> +    for (i = 0; i < bytes; i++)
> +        output->bitset[i] = 0x0;
> +
> +    /* Iterate the the section list and check the bits */
> +    uint32_t* sections = &niagara_state->sections[0];

run scripts/checkpatch.pl on HEAD~3..HEAD or similar and fix every error and warning.

> +    for (i = 0; (i < niagara_state->total_sections); i++) {
> +        uint32_t section = sections[i];
> +        if (((query_type == MHD_GSM_QUERY_FREE) && (!section)) ||
> +            ((query_type == MHD_GSM_QUERY_ALLOCATED) && (section & (1 << ct3d->mhd_head)))) {
> +            uint32_t byte = i / 8;
> +            uint8_t bit = (1 << (i % 8));
> +            output->bitset[byte] |= bit;
> +            output->qry_section_count++;
> +        }
> +    }
> +
> +    *len_out = (8+bytes);

Spaces around +

> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static bool mhdsld_access_valid(CXLType3Dev *ct3d, uint64_t dpa_offset, unsigned int size) {
> +    Niagara_Shared_State *niagara_state = (Niagara_Shared_State*)ct3d->mhd_state;
> +    if (ct3d->mhd_state) {
> +        uint32_t section = (dpa_offset / MIN_MEMBLK_SIZE);
> +        if (!(niagara_state->sections[section] & (1 << ct3d->mhd_head))) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
> +static const struct cxl_cmd cxl_cmd_set_niagara[256][256] = {
> +    [NIAGARA][GET_SECTION_STATUS] = { "GET_SECTION_STATUS",
> +        cmd_niagara_get_section_status, 0, 0 },
> +    [NIAGARA][SET_SECTION_ALLOC] = { "SET_SECTION_ALLOC",
> +        cmd_niagara_set_section_alloc, ~0,
> +        (IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE |
> +         IMMEDIATE_POLICY_CHANGE | IMMEDIATE_LOG_CHANGE)
> +    },
> +    [NIAGARA][SET_SECTION_RELEASE] = { "SET_SECTION_RELEASE",
> +        cmd_niagara_set_section_release, ~0,
> +        (IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE |
> +         IMMEDIATE_POLICY_CHANGE | IMMEDIATE_LOG_CHANGE)
> +    },
> +    [NIAGARA][SET_SECTION_SIZE] = { "SET_SECTION_SIZE",
> +        cmd_niagara_set_section_size, 8,
> +        (IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE |
> +         IMMEDIATE_POLICY_CHANGE | IMMEDIATE_LOG_CHANGE)
> +    },
> +    [NIAGARA][MOVE_DATA] = { "MOVE_DATA",
> +        cmd_niagara_move_data, ~0, IMMEDIATE_DATA_CHANGE },
> +    [NIAGARA][GET_SECTION_MAP] = { "GET_SECTION_MAP",
> +        cmd_niagara_get_section_map, 8 , IMMEDIATE_DATA_CHANGE },
> +    [NIAGARA][CLEAR_SECTION] = { "CLEAR_SECTION",
> +        cmd_niagara_clear_section, 0, IMMEDIATE_DATA_CHANGE },
> +};
> +
> +enum cxl_dev_type {
> +    cxl_type3,
> +};
> +
> +struct CXL_Niagara_State {
> +    PCIDevice parent_obj;

Why not inherit from CXLType3Dev? Should end up simpler and
more standard which will help upstreaming.


> +    PCIDevice *target;
> +    enum cxl_dev_type type;
> +    CXLCCI *cci;
> +};
> +
> +struct CXL_NiagaraClass {
> +    PCIDeviceClass parent_class;
> +};
> +

One blank line only.

> +
> +#define TYPE_CXL_Niagara "cxl-skh-niagara"
> +OBJECT_DECLARE_TYPE(CXL_Niagara_State, CXL_NiagaraClass, CXL_Niagara)
> +
> +static Property cxl_niagara_props[] = {
> +    DEFINE_PROP_LINK("target", CXL_Niagara_State,
> +                     target, TYPE_PCI_DEVICE, PCIDevice *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void cxl_niagara_realize(DeviceState *d, Error **errp)
> +{
> +    CXL_Niagara_State *s = CXL_Niagara(d);
> +
> +    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
> +        CXLType3Dev *ct3d = CXL_TYPE3(s->target);
> +
> +        if (!ct3d->is_mhd) {
> +            error_setg(errp, "Niagara target must be a cxl-type3 mhd");
> +            return;
> +        }
> +
> +        s->type = cxl_type3;
> +        s->cci = &ct3d->cci;
> +
> +        ct3d->mhd_access_valid = mhdsld_access_valid;
> +        return;
> +    }
> +
> +    error_setg(errp, "Unhandled target type for CXL Niagara MHSLD");
> +}
> +
> +static void cxl_niagara_reset(DeviceState *d)
> +{
> +    CXL_Niagara_State *s = CXL_Niagara(d);
> +
> +    if (object_dynamic_cast(OBJECT(s->target), TYPE_CXL_TYPE3)) {
> +        CXLType3Dev *ct3d = CXL_TYPE3(s->target);
> +        cxl_add_cci_commands(&ct3d->cci, cxl_cmd_set_niagara, 512);
> +        return;
> +    }
> +}
> +
> +static void cxl_niagara_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->realize = cxl_niagara_realize;
> +    dc->reset = cxl_niagara_reset;
> +    device_class_set_props(dc, cxl_niagara_props);
> +}
> +
> +static const TypeInfo cxl_niagara_info = {
> +    .name = TYPE_CXL_Niagara,
> +    .parent = TYPE_CXL_TYPE3,
> +    .class_size = sizeof(struct CXL_NiagaraClass),
> +    .class_init = cxl_niagara_class_init,
> +    .instance_size = sizeof(CXL_Niagara_State),

I'd embed the type3 in the state.

> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CXL_DEVICE },
> +        { INTERFACE_PCIE_DEVICE },
> +        {}
> +    },
> +};
> +
> +static void cxl_niagara_register_types(void)
> +{
> +    type_register_static(&cxl_niagara_info);
> +}
> +
> +type_init(cxl_niagara_register_types)


