Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F14E89E333
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Apr 2024 21:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruH2g-0006LN-7Y; Tue, 09 Apr 2024 15:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ruH2e-0006L8-Bf
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:22:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ruH2T-0001w5-Ow
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:21:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ecee5c08e6so5576244b3a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712690507; x=1713295307; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2yEypzePlwi9fl1CiVaERC6+269JU99uPhcr+PVvc4I=;
 b=B45QfaCVYiG8y5zhiDhHl/HAaUxVC4MDhMyIzqyJPhVozCsHtoNCUxNXdMC4vb/ALg
 1h3SYWswbgBomZPxSd67XpekOLxwluOYikrbG0OxvuX+z6WlRSmMVGRl2r6o6d2Il+Qr
 LwppFihRBGFlcfFWeUMFqQ3ypHKP7ku6t2RG0uKMhM2G1/0L6ea0drYpk0QLns9cBNNc
 UDYLsqhL/13VQoRH5hoJ2juu+ql/5kMcbldxc8gk+i/INxedot5N+0KffxnREjf7k5zk
 q15KRO7S3VTaXI/JW7Lm/NEtj7cQAR9tBWf+7/IzToXqoxH3RK9LCWBypsQVH3zD0yQz
 muEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712690507; x=1713295307;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2yEypzePlwi9fl1CiVaERC6+269JU99uPhcr+PVvc4I=;
 b=uwZ+EnWCGbOgTkW/KMT/jKYG1GUGy4HxNM6cTpfRcTJKdvy+kTwigpuPUnXdCNnjo3
 F9k8kEfozWY2QRNPsoTugOJtgRhOPQ946GDMZVqenfbyLeNnOvMM5LrRFEN3RifASi9+
 jKKoPiBSs17Dx4du712HAIPV5ZHerionkA5vpTi0XlG+9vZ/fHp+iQj7AXbBYdNHvRFw
 CZ9RXCI8LyGOr/IwFdRTqdRFFOt02m2ZpgkdMO4XXxmwUnKvSFkbGAKfFO0ZpE6n54QX
 7zQiXfPne14insXM15PuIY7ctH11dMz2hfuJ33EqssXEQF5D0pl9xe5D1KM0A1GHwXaS
 jTzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhb0f/90BbN8muK06uzLf3FKQNli6ID/WVzkhr67MThi94AKNZrpCU4TfJu6snR6Zvuc9FfCSRp+LsxHqn4v0rLEY0Yiw=
X-Gm-Message-State: AOJu0YyDM758lhVq3U6f5dig4A6dh55dhy3MTkmIrtCdKYxJd46CyI+V
 cE7UkIvT2aIZjhccACqK00vNTmv2FYKbolUxPD5xovMtWsMvhwVF
X-Google-Smtp-Source: AGHT+IGoOlavNPRMRrxu0yfp9ByTIPrZtUYerP216qbhubXCkPfkJOaKOqZ52x2Txbq8BXW6+t4+fA==
X-Received: by 2002:a05:6a20:1582:b0:1a8:3607:6939 with SMTP id
 h2-20020a056a20158200b001a836076939mr967478pzj.57.1712690506496; 
 Tue, 09 Apr 2024 12:21:46 -0700 (PDT)
Received: from debian ([2601:641:300:14de:cb12:7b73:f080:4218])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a056a00188800b006ed045e3a70sm7942675pfh.25.2024.04.09.12.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:21:46 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 9 Apr 2024 12:21:35 -0700
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "wj28.lee@gmail.com" <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 08/12] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <ZhWVL4iu6E7qh_y3@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-9-nifan.cxl@gmail.com>
 <9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Apr 04, 2024 at 01:32:23PM +0000, J�rgen Hansen wrote:
> On 3/25/24 20:02, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per CXL spec 3.1, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > 
> > For the process of the above two commands, we use two-pass approach.
> > Pass 1: Check whether the input payload is valid or not; if not, skip
> >          Pass 2 and return mailbox process error.
> > Pass 2: Do the real work--add or release extents, respectively.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 433 +++++++++++++++++++++++++++++++++++-
> >   hw/mem/cxl_type3.c          |  11 +
> >   include/hw/cxl/cxl_device.h |   4 +
> >   3 files changed, 444 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 30ef46a036..a9eca516c8 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -19,6 +19,7 @@
> >   #include "qemu/units.h"
> >   #include "qemu/uuid.h"
> >   #include "sysemu/hostmem.h"
> > +#include "qemu/range.h"
> > 
> >   #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >   #define CXL_DC_EVENT_LOG_SIZE 8
> > @@ -85,6 +86,8 @@ enum {
> >       DCD_CONFIG  = 0x48,
> >           #define GET_DC_CONFIG          0x0
> >           #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> >       PHYSICAL_SWITCH = 0x51,
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >           #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1400,6 +1403,422 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> > 
> > +/*
> > + * Check whether any bit between addr[nr, nr+size) is set,
> > + * return true if any bit is set, otherwise return false
> > + */
> > +static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> > +                              unsigned long size)
> > +{
> > +    unsigned long res = find_next_bit(addr, size + nr, nr);
> > +
> > +    return res < nr + size;
> > +}
> > +
> > +CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCRegion *region = &ct3d->dc.regions[0];
> > +
> > +    if (dpa < region->base ||
> > +        dpa >= region->base + ct3d->dc.total_capacity) {
> > +        return NULL;
> > +    }
> > +
> > +    /*
> > +     * CXL r3.1 section 9.13.3: Dynamic Capacity Device (DCD)
> > +     *
> > +     * Regions are used in increasing-DPA order, with Region 0 being used for
> > +     * the lowest DPA of Dynamic Capacity and Region 7 for the highest DPA.
> > +     * So check from the last region to find where the dpa belongs. Extents that
> > +     * cross multiple regions are not allowed.
> > +     */
> > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > +        region = &ct3d->dc.regions[i];
> > +        if (dpa >= region->base) {
> > +            if (dpa + len > region->base + region->len) {
> > +                return NULL;
> > +            }
> > +            return region;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> > +                                             uint64_t dpa,
> > +                                             uint64_t len,
> > +                                             uint8_t *tag,
> > +                                             uint16_t shared_seq)
> > +{
> > +    CXLDCExtent *extent;
> > +
> > +    extent = g_new0(CXLDCExtent, 1);
> > +    extent->start_dpa = dpa;
> > +    extent->len = len;
> > +    if (tag) {
> > +        memcpy(extent->tag, tag, 0x10);
> > +    }
> > +    extent->shared_seq = shared_seq;
> > +
> > +    QTAILQ_INSERT_TAIL(list, extent, node);
> > +}
> > +
> > +void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> > +                                        CXLDCExtent *extent)
> > +{
> > +    QTAILQ_REMOVE(list, extent, node);
> > +    g_free(extent);
> > +}
> > +
> > +/*
> > + * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
> > + * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
> > + */
> > +typedef struct CXLUpdateDCExtentListInPl {
> > +    uint32_t num_entries_updated;
> > +    uint8_t flags;
> > +    uint8_t rsvd[3];
> > +    /* CXL r3.1 Table 8-169: Updated Extent */
> > +    struct {
> > +        uint64_t start_dpa;
> > +        uint64_t len;
> > +        uint8_t rsvd[8];
> > +    } QEMU_PACKED updated_entries[];
> > +} QEMU_PACKED CXLUpdateDCExtentListInPl;
> > +
> > +/*
> > + * For the extents in the extent list to operate, check whether they are valid
> > + * 1. The extent should be in the range of a valid DC region;
> > + * 2. The extent should not cross multiple regions;
> > + * 3. The start DPA and the length of the extent should align with the block
> > + * size of the region;
> > + * 4. The address range of multiple extents in the list should not overlap.
> > + */
> > +static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in)
> > +{
> > +    uint64_t min_block_size = UINT64_MAX;
> > +    CXLDCRegion *region = &ct3d->dc.regions[0];
> > +    CXLDCRegion *lastregion = &ct3d->dc.regions[ct3d->dc.num_regions - 1];
> > +    g_autofree unsigned long *blk_bitmap = NULL;
> > +    uint64_t dpa, len;
> > +    uint32_t i;
> > +
> > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +        region = &ct3d->dc.regions[i];
> > +        min_block_size = MIN(min_block_size, region->block_size);
> > +    }
> > +
> > +    blk_bitmap = bitmap_new((lastregion->base + lastregion->len -
> > +                             ct3d->dc.regions[0].base) / min_block_size);
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        region = cxl_find_dc_region(ct3d, dpa, len);
> > +        if (!region) {
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +
> > +        dpa -= ct3d->dc.regions[0].base;
> > +        if (dpa % region->block_size || len % region->block_size) {
> > +            return CXL_MBOX_INVALID_EXTENT_LIST;
> > +        }
> > +        /* the dpa range already covered by some other extents in the list */
> > +        if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> > +            len / min_block_size)) {
> > +            return CXL_MBOX_INVALID_EXTENT_LIST;
> > +        }
> > +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
> > +   }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in)
> > +{
> > +    uint32_t i;
> > +    CXLDCExtent *ent;
> > +    uint64_t dpa, len;
> > +    Range range1, range2;
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        range_init_nofail(&range1, dpa, len);
> > +
> > +        /*
> > +         * TODO: once the pending extent list is added, check against
> > +         * the list will be added here.
> > +         */
> > +
> > +        /* to-be-added range should not overlap with range already accepted */
> > +        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> > +            range_init_nofail(&range2, ent->start_dpa, ent->len);
> > +            if (range_overlaps_range(&range1, &range2)) {
> > +                return CXL_MBOX_INVALID_PA;
> > +            }
> > +        }
> > +    }
> > +    return CXL_MBOX_SUCCESS;
> > +}
> 
> Instead of iterating over all new extents and all existing extents, 
> couldn't this be rolled into cxl_detect_malformed_extent_list - the 
> bitmap created there summarizes all ranges of the new extents, so you 
> can just check that the existing (and pending) extents don't overlap 
> with anything in the bitmap? Or allow the bitmap to be returned and used 
> for this check, since cxl_detect_malformed_extent_list is also used on 
> release, where things aren't as simple.

Hi J�rgen,

Thanks for reviewing the code.
cxl_detect_malformed_extent_list is only for verify the incoming extent
list in the command payload, while the dry run is used for simulating
the real add/release operations, meaning touching the in-device data
structures. They detect different type of mailbox errors, I think it is
clearer to make them separated. Also, as you can see in the following
patch, we have bitmap for the purpose you mentioned above.

For your suggestion below to reuse the tmp_list to avoid the duplicate
code for iterating extents for real release, I think it would work and
can simplify the code. I am working on it and also need to check whether
it will cause problem when superset release is introduced, but for now
it seems very promising.

Once the code is completed and works as we expected, I will post the
code here so you, Jonathan and others can take a look at it before I
send out the next version of the whole patchset.

Thanks,
Fan

> 
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (Opcode 4802h)
> > + * An extent is added to the extent list and becomes usable only after the
> > + * response is processed successfully
> > + */
> > +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_SUCCESS;
> > +    }
> 
> The mailbox processing in patch 2 converts from le explicitly, whereas 
> the mailbox commands here don't. Looking at the existing mailbox 
> commands, convertion doesn't seem to be rigorously applied, so maybe 
> that is OK?
> 
> > +
> > +    /* Adding extents causes exceeding device's extent tracking ability. */
> > +    if (in->num_entries_updated + ct3d->dc.total_extent_count >
> > +        CXL_NUM_EXTENTS_SUPPORTED) {
> > +        return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +    }
> > +
> > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    ret = cxl_dcd_add_dyn_cap_rsp_dry_run(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > +        ct3d->dc.total_extent_count += 1;
> > +        /*
> > +         * TODO: we will add a pending extent list based on event log record
> > +         * and process the list according here.
> > +         */
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/*
> > + * Copy extent list from src to dst
> > + * Return value: number of extents copied
> > + */
> > +static uint32_t copy_extent_list(CXLDCExtentList *dst,
> > +                                 const CXLDCExtentList *src)
> > +{
> > +    uint32_t cnt = 0;
> > +    CXLDCExtent *ent;
> > +
> > +    if (!dst || !src) {
> > +        return 0;
> > +    }
> > +
> > +    QTAILQ_FOREACH(ent, src, node) {
> > +        cxl_insert_extent_to_extent_list(dst, ent->start_dpa, ent->len,
> > +                                         ent->tag, ent->shared_seq);
> > +        cnt++;
> > +    }
> > +    return cnt;
> > +}
> > +
> > +static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +    uint64_t dpa, len;
> > +    uint32_t i;
> > +    int cnt_delta = 0;
> > +    CXLDCExtentList tmp_list;
> > +    CXLRetCode ret = CXL_MBOX_SUCCESS;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    QTAILQ_INIT(&tmp_list);
> > +    copy_extent_list(&tmp_list, &ct3d->dc.extents);
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        Range range;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        while (len > 0) {
> > +            QTAILQ_FOREACH(ent, &tmp_list, node) {
> > +                range_init_nofail(&range, ent->start_dpa, ent->len);
> > +
> > +                if (range_contains(&range, dpa)) {
> > +                    uint64_t len1, len2, len_done = 0;
> > +                    uint64_t ent_start_dpa = ent->start_dpa;
> > +                    uint64_t ent_len = ent->len;
> > +                    /*
> > +                     * Found the exact extent or the subset of an existing
> > +                     * extent.
> > +                     */
> > +                    if (range_contains(&range, dpa + len - 1)) {
> > +                        len1 = dpa - ent->start_dpa;
> > +                        len2 = ent_start_dpa + ent_len - dpa - len;
> > +                        len_done = ent_len - len1 - len2;
> > +
> > +                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> > +                        cnt_delta--;
> > +
> > +                        if (len1) {
> > +                            cxl_insert_extent_to_extent_list(&tmp_list,
> > +                                                             ent_start_dpa,
> > +                                                             len1, NULL, 0);
> > +                            cnt_delta++;
> > +                        }
> > +                        if (len2) {
> > +                            cxl_insert_extent_to_extent_list(&tmp_list,
> > +                                                             dpa + len,
> > +                                                             len2, NULL, 0);
> > +                            cnt_delta++;
> > +                        }
> > +
> > +                        if (cnt_delta + ct3d->dc.total_extent_count >
> > +                            CXL_NUM_EXTENTS_SUPPORTED) {
> > +                            ret = CXL_MBOX_RESOURCES_EXHAUSTED;
> > +                            goto free_and_exit;
> > +                        }
> > +                    } else {
> > +                        /*
> > +                         * TODO: we reject the attempt to remove an extent
> > +                         * that overlaps with multiple extents in the device
> > +                         * for now, we will allow it once superset release
> > +                         * support is added.
> > +                         */
> > +                        ret = CXL_MBOX_INVALID_PA;
> > +                        goto free_and_exit;
> > +                    }
> > +
> > +                    len -= len_done;
> > +                    /* len == 0 here until superset release is added */
> > +                    break;
> > +                }
> > +            }
> > +            if (len) {
> > +                ret = CXL_MBOX_INVALID_PA;
> > +                goto free_and_exit;
> > +            }
> > +        }
> > +    }
> > +free_and_exit:
> > +    QTAILQ_FOREACH_SAFE(ent, &tmp_list, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
> > + */
> > +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    CXLDCExtent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    ret = cxl_dc_extent_release_dry_run(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    /* From this point, all the extents to release are valid */
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        Range range;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        while (len > 0) {
> > +            QTAILQ_FOREACH(ent, extent_list, node) {
> > +                range_init_nofail(&range, ent->start_dpa, ent->len);
> > +
> > +                /* Found the extent overlapping with */
> > +                if (range_contains(&range, dpa)) {
> > +                    uint64_t len1, len2 = 0, len_done = 0;
> > +                    uint64_t ent_start_dpa = ent->start_dpa;
> > +                    uint64_t ent_len = ent->len;
> > +
> > +                    len1 = dpa - ent_start_dpa;
> > +                    if (range_contains(&range, dpa + len - 1)) {
> > +                        len2 = ent_start_dpa + ent_len - dpa - len;
> > +                    }
> > +                    len_done = ent_len - len1 - len2;
> > +
> > +                    cxl_remove_extent_from_extent_list(extent_list, ent);
> > +                    ct3d->dc.total_extent_count -= 1;
> > +
> > +                    if (len1) {
> > +                        cxl_insert_extent_to_extent_list(extent_list,
> > +                                                         ent_start_dpa,
> > +                                                         len1, NULL, 0);
> > +                        ct3d->dc.total_extent_count += 1;
> > +                    }
> > +                    if (len2) {
> > +                        cxl_insert_extent_to_extent_list(extent_list,
> > +                                                         dpa + len,
> > +                                                         len2, NULL, 0);
> > +                        ct3d->dc.total_extent_count += 1;
> > +                    }
> > +
> > +                    len -= len_done;
> > +                    /*
> > +                     * len will always be 0 until superset release is add.
> > +                     * TODO: superset release will be added.
> > +                     */
> > +                    break;
> > +                }
> > +            }
> > +        }
> > +    }
> 
> The tmp_list generated in cxl_dc_extent_release_dry_run is identical to 
> the updated extent_list after the loops above - so you could swap the 
> existing extent_list with the tmp_list and adjust the number of extents 
> with the cnt_delta calculated, if the dry run is successful - instead of 
> duplicating the logic.
> 
> Thanks,
> J�rgen
> 
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >   #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1413,15 +1832,15 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >       [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
> >           cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
> >       [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
> > -                                      cmd_events_get_interrupt_policy, 0, 0 },
> > +        cmd_events_get_interrupt_policy, 0, 0 },
> >       [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
> > -                                      cmd_events_set_interrupt_policy,
> > -                                      ~0, IMMEDIATE_CONFIG_CHANGE },
> > +        cmd_events_set_interrupt_policy,
> > +        ~0, IMMEDIATE_CONFIG_CHANGE },
> >       [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
> >           cmd_firmware_update_get_info, 0, 0 },
> >       [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> >       [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
> > -                         8, IMMEDIATE_POLICY_CHANGE },
> > +        8, IMMEDIATE_POLICY_CHANGE },
> >       [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
> >                                 0, 0 },
> >       [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > @@ -1450,6 +1869,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> >       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
> >           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
> >           8, 0 },
> > +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> > +        "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> > +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> > +        "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> >   };
> > 
> >   static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 5be3c904ba..951bd79a82 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -678,6 +678,15 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >       return true;
> >   }
> > 
> > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +
> > +    QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> > +    }
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -874,6 +883,7 @@ err_free_special_ops:
> >       g_free(regs->special_ops);
> >   err_address_space_free:
> >       if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >           address_space_destroy(&ct3d->dc.host_dc_as);
> >       }
> >       if (ct3d->hostpmem) {
> > @@ -895,6 +905,7 @@ static void ct3_exit(PCIDevice *pci_dev)
> >       cxl_doe_cdat_release(cxl_cstate);
> >       g_free(regs->special_ops);
> >       if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >           address_space_destroy(&ct3d->dc.host_dc_as);
> >       }
> >       if (ct3d->hostpmem) {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 6aec6ac983..df3511e91b 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -551,4 +551,8 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
> > 
> >   void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> > 
> > +CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> > +
> > +void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> > +                                        CXLDCExtent *extent);
> >   #endif
> > --
> > 2.43.0
> > 

