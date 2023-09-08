Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4803C798B76
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qefBG-0007Iz-43; Fri, 08 Sep 2023 13:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qefAx-0007DW-HG
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:21:48 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@gmx.us>) id 1qefAu-0006DG-BV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1694193609; x=1694798409; i=fan.ni@gmx.us;
 bh=eTuAMCtxIep1hkQhE9WfgRxSJEMBNLNyy1WUCrC1IlY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UucjMoheG9kEHhtv7iyNw4nzNkbJ9koDQ+Y6Z/LmfyjRv4eFMZ9C27u7Hmw0xfLI2qhYusp
 0a4ZmhlNP/9sNyhj46UzD3N7uAk3IDpzO7qrC/NqGlF5g6+p3rShJN0gNMDHvKW2ug/tO27VZ
 +ZEbPq6EHaoPROMpXDuJr1w1gvMJJtUQU4zk69mOp/AMBHsExTCPoSGQLD0QOP67scAO0DSjO
 Ti8XuRv+WoWEzm8+78tY9btwHB4rn3tjW+59gCalf0agHb0Iijs2WJvp+tDC4u5qF25zp24S4
 mGAFwsCX+IfmGC8UgRbQBHZpxSPw7k92ATGoC7LB67w0nnAVjYYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1q38PB2db7-00brwB; Fri, 08
 Sep 2023 19:20:09 +0200
Date: Fri, 8 Sep 2023 10:19:55 -0700
From: Fan Ni <fan.ni@gmx.us>
To: J?rgen Hansen <Jorgen.Hansen@wdc.com>
Cc: Fan Ni <fan.ni@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox
 commands to support add/release dynamic capacity response
Message-ID: <ZPtXuyJkFKgBpL9A@debian>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7@uscas1p2.samsung.com>
 <20230725183939.2741025-8-fan.ni@samsung.com>
 <e1640028-6b9d-3cdf-52fb-241f985c4bbb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1640028-6b9d-3cdf-52fb-241f985c4bbb@wdc.com>
X-Provags-ID: V03:K1:QOKSHZN38gt922xEcnREdH3Tslemuxy+b9ml1WlkVVpglkGkJqN
 OPacRVz8/gO+I0m1ozpn2VbTQkV5EwMh9+xrMFLdKxolorY+Wdvbvtb3fhZL0F6VmTuGF5Q
 zQHN28ur4vpp3a+E3QlGsLqerE3tpHpNORjDuT5DD2ALViwm2B3JvNBhIiJm2EGmgkXtQFL
 6vCI7t30MrkWwdviUNwFg==
UI-OutboundReport: notjunk:1;M01:P0:cQMkAvkz3fM=;x3zDOCgKmb3VZDXqVcZ8tuoSEkM
 M9HM4eT7Zdu2y+mljRzb64V/39LvZuXlU1AOoLPCtb9XOpjCdB/5yKc2FY6cmNlkOwcHg8cV2
 6WqSEIxzMJYPEfEP8madX72WuovzpvMh8CMlYc10mgpz7IjDu0qGE6Y9X4eRunNkOEVPU/tT+
 VCavPghGkHTnDqBFGGX29xboaa8MCqDPwFyPv96VCShpFHIzgv23+ue8pC3Lwr7mz67uP3vIJ
 fDqAF4r2Gae3ZrlUNa5/O6x2pt3jlT0YOvdrU+gSlNPyF+aQ+LvT2iDQFgVXQDVhy6fOM4NDV
 LGmkHvjzuR4mmrhu1Ss0Bp7NQFFUQBpNBGJ/6gQ4sCMRGPb+/qmez717p3AyW58ZUBDJGp8U/
 UTKf1v5OGsiyjN6dN51ntqLzpkqn0f4mRq5NXo3jlyR5WZ0keKkW7GYZKIXMH//2xCSxBd7su
 SjoeIGJh/w3kBTKpFzF8Le0HCf02/Kp42GtS3aJT6sVFzwrSi5uBgnHm2fbB0/McvXWaxJkgi
 +LtVtu90UAIctKpPXXRzP8eXvveThWYvN4iVevD9vYZjINXXRIObsBjSSuUVZ1OI+0fuX7psD
 8itWhby3I4bXk9NCuX34ExcA76TL2stpbeZy5GqExfBXLe0Fpo3Zl/t1/mmQymm1751YXw/zQ
 qTkx7q3j0qffvqrwcc8vatpByI1Q7Z1Vw79FSpIdrY7xYahtEySof1RmYZgynyVUNnLRbhuJn
 XzL4oBvWl03ziSBYusMlePPX+WJQ28frci64WEr3Vf56ShNMJP1ZbfwGc4qZ/7sANTu6d54MI
 YDHvh7MJqRd0qyp6mI8DiCJ3Y4ThlzsAjOgZyAX1DFoA8hFgnnxMdCwz2dkyH3AjMxGPtn/XX
 Lqz2U18isn0iK+ep9C4ZTCcDVHm7wUkq+FTfzLzqJWehngVwoIvZtOxsPTRGXXUdKiuxof5AZ
 F6kkwsIbSD98I2d2eFrYujMQK0g=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=fan.ni@gmx.us;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Fri, Sep 08, 2023 at 01:00:16PM +0000, J?rgen Hansen wrote:
> On 7/25/23 20:39, Fan Ni wrote:
> > From: Fan Ni <nifan@outlook.com>
> >
> > Per CXL spec 3.0, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 253 ++++++++++++++++++++++++++++++++++=
++
> >   include/hw/cxl/cxl_device.h |   3 +-
> >   2 files changed, 255 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 3d25a9697e..1e4944da95 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -84,6 +84,8 @@ enum {
> >       DCD_CONFIG  =3D 0x48, /*r3.0: 8.2.9.8.9*/
> >           #define GET_DC_CONFIG          0x0
> >           #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> >       PHYSICAL_SWITCH =3D 0x51
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >   };
> > @@ -1086,6 +1088,251 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list=
(struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> >
> > +/*
> > + * Check whether the bits at addr between [nr, nr+size) are all set,
> > + * return 1 if all 1s, else return 0
> > + */
> > +static inline int test_bits(const unsigned long *addr, int nr, int si=
ze)
> > +{
> > +    unsigned long res =3D find_next_zero_bit(addr, size + nr, nr);
> > +
> > +    return (res >=3D nr + size) ? 1 : 0;
> > +}
> > +
> > +/*
> > + * Find dynamic capacity region id based on dpa range [dpa, dpa+len)
> > + */
> > +static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa,
> > +        uint64_t len)
> > +{
> > +    int8_t i =3D dev->dc.num_regions - 1;
> > +
> > +    while (i > 0 && dpa < dev->dc.regions[i].base) {
> > +        i--;
> > +    }
> > +
> > +    if (dpa < dev->dc.regions[i].base
> > +            || dpa + len > dev->dc.regions[i].base + dev->dc.regions[=
i].len) {
> > +        return dev->dc.num_regions;
> > +    }
> > +
> > +    return i;
> > +}
> > +
> > +static void insert_extent_to_extent_list(CXLDCDExtentList *list, uint=
64_t dpa,
> > +        uint64_t len, uint8_t *tag, uint16_t shared_seq)
> > +{
> > +    CXLDCD_Extent *extent;
> > +    extent =3D g_new0(CXLDCD_Extent, 1);
> > +    extent->start_dpa =3D dpa;
> > +    extent->len =3D len;
> > +    if (tag) {
> > +        memcpy(extent->tag, tag, 0x10);
> > +    } else {
> > +        memset(extent->tag, 0, 0x10);
> > +    }
> > +    extent->shared_seq =3D shared_seq;
> > +
> > +    QTAILQ_INSERT_TAIL(list, extent, node);
> > +}
> > +
> > +typedef struct updated_dc_extent_list_in_pl {
> > +    uint32_t num_entries_updated;
> > +    uint8_t rsvd[4];
> > +    struct { /* r3.0: Table 8-130 */
> > +        uint64_t start_dpa;
> > +        uint64_t len;
> > +        uint8_t rsvd[8];
> > +    } QEMU_PACKED updated_entries[];
> > +} QEMU_PACKED updated_dc_extent_list_in_pl;
> > +
> > +/*
> > + * The function only check the input extent list against itself.
> > + */
> > +static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev,
> > +        const updated_dc_extent_list_in_pl *in)
> > +{
> > +    unsigned long *blk_bitmap;
> > +    uint64_t min_block_size =3D dev->dc.regions[0].block_size;
> > +    struct CXLDCD_Region *region =3D &dev->dc.regions[0];
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    uint8_t rid;
> > +    CXLRetCode ret;
> > +
> > +    for (i =3D 1; i < dev->dc.num_regions; i++) {
> > +        region =3D &dev->dc.regions[i];
> > +        if (min_block_size > region->block_size) {
> > +            min_block_size =3D region->block_size;
> > +        }
> > +    }
> > +
> > +    blk_bitmap =3D bitmap_new((region->len + region->base
> > +                - dev->dc.regions[0].base) / min_block_size);
> > +
> > +    for (i =3D 0; i < in->num_entries_updated; i++) {
> > +        dpa =3D in->updated_entries[i].start_dpa;
> > +        len =3D in->updated_entries[i].len;
> > +
> > +        rid =3D find_region_id(dev, dpa, len);
> > +        if (rid =3D=3D dev->dc.num_regions) {
> > +            ret =3D CXL_MBOX_INVALID_PA;
> > +            goto out;
> > +        }
> > +
> > +        region =3D &dev->dc.regions[rid];
> > +        if (dpa % region->block_size || len % region->block_size) {
> > +            ret =3D CXL_MBOX_INVALID_EXTENT_LIST;
> > +            goto out;
> > +        }
>
> Hi,
>
> The bitmap uses the dc region 0 base address as the baseline, so when
> checking the dpa against the bitmap it needs to be adjusted for that
> before the bitmap checks, e.g.,
>
> +        dpa -=3D dev->dc.regions[0].base;
>
> Thanks,
> Jorgen

Make sense. Will fix. Thanks.

Fan
>
> > +        /* the dpa range already covered by some other extents in the=
 list */
> > +        if (test_bits(blk_bitmap, dpa / min_block_size, len / min_blo=
ck_size)) {
> > +            ret =3D CXL_MBOX_INVALID_EXTENT_LIST;
> > +            goto out;
> > +        }
> > +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_=
size);
> > +   }
> > +
> > +    ret =3D CXL_MBOX_SUCCESS;
> > +
> > +out:
> > +    g_free(blk_bitmap);
> > +    return ret;
> > +}
> > +
> > +/*
> > + * cxl spec 3.0: 8.2.9.8.9.3
> > + * Add Dynamic Capacity Response (opcode 4802h)
> > + * Assume an extent is added only after the response is processed suc=
cessfully
> > + * TODO: for better extent list validation, a better solution would b=
e
> > + * maintaining a pending extent list and use it to verify the extent =
list in
> > + * the response.
> > + */
> > +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
> > +        CXLDeviceState *cxl_dstate, uint16_t *len_unused)
> > +{
> > +    updated_dc_extent_list_in_pl *in =3D (void *)cmd->payload;
> > +    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev=
,
> > +            cxl_dstate);
> > +    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
> > +    CXLDCD_Extent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated =3D=3D 0) {
> > +        ret =3D CXL_MBOX_SUCCESS;
> > +        goto out;
> > +    }
> > +
> > +    ret =3D detect_malformed_extent_list(ct3d, in);
> > +    if (ret !=3D CXL_MBOX_SUCCESS) {
> > +        goto out;
> > +    }
> > +
> > +    for (i =3D 0; i < in->num_entries_updated; i++) {
> > +        dpa =3D in->updated_entries[i].start_dpa;
> > +        len =3D in->updated_entries[i].len;
> > +
> > +        /*
> > +         * Check if the DPA range of the to-be-added extent overlaps =
with
> > +         * existing extent list maintained by the device.
> > +         */
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len) {
> > +                ret =3D CXL_MBOX_INVALID_PA;
> > +                goto out;
> > +            } else if (ent->start_dpa <=3D dpa
> > +                    && dpa + len <=3D ent->start_dpa + ent->len) {
> > +                ret =3D CXL_MBOX_INVALID_PA;
> > +                goto out;
> > +            } else if ((dpa < ent->start_dpa + ent->len
> > +                        && dpa + len > ent->start_dpa + ent->len)
> > +                    || (dpa < ent->start_dpa && dpa + len > ent->star=
t_dpa)) {
> > +                ret =3D CXL_MBOX_INVALID_PA;
> > +                goto out;
> > +            }
> > +        }
> > +
> > +        /*
> > +         * TODO: add a pending extent list based on event log record =
and verify
> > +         * the input response
> > +         */
> > +
> > +        insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > +    }
> > +    ret =3D CXL_MBOX_SUCCESS;
> > +
> > +out:
> > +    return ret;
> > +}
> > +
> > +/*
> > + * Spec 3.0: 8.2.9.8.9.4
> > + * Release Dynamic Capacity (opcode 4803h)
> > + **/
> > +static CXLRetCode cmd_dcd_release_dyn_cap(struct cxl_cmd *cmd,
> > +        CXLDeviceState *cxl_dstate,
> > +        uint16_t *len_unused)
> > +{
> > +    updated_dc_extent_list_in_pl *in =3D (void *)cmd->payload;
> > +    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev=
,
> > +            cxl_dstate);
> > +    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
> > +    CXLDCD_Extent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated =3D=3D 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    ret =3D detect_malformed_extent_list(ct3d, in);
> > +    if (ret !=3D CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    for (i =3D 0; i < in->num_entries_updated; i++) {
> > +        dpa =3D in->updated_entries[i].start_dpa;
> > +        len =3D in->updated_entries[i].len;
> > +
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len) {
> > +                break;
> > +            } else if (ent->start_dpa < dpa
> > +                    && dpa + len <=3D ent->start_dpa + ent->len) {
> > +                /* remove partial extent */
> > +                uint64_t len1 =3D dpa - ent->start_dpa;
> > +                uint64_t len2 =3D ent->start_dpa + ent->len - dpa - l=
en;
> > +
> > +                if (len1) {
> > +                    insert_extent_to_extent_list(extent_list, ent->st=
art_dpa,
> > +                            len1, NULL, 0);
> > +                }
> > +                if (len2) {
> > +                    insert_extent_to_extent_list(extent_list, dpa + l=
en, len2,
> > +                            NULL, 0);
> > +                }
> > +                break;
> > +            } else if ((dpa < ent->start_dpa + ent->len
> > +                        && dpa + len > ent->start_dpa + ent->len)
> > +                    || (dpa < ent->start_dpa && dpa + len > ent->star=
t_dpa))
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +        }
> > +
> > +        if (ent) {
> > +            QTAILQ_REMOVE(extent_list, ent, node);
> > +            g_free(ent);
> > +        } else {
> > +            /* Try to remove a non-existing extent */
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >   #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1129,6 +1376,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D=
 {
> >       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
> >           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_=
ext_list,
> >           8, 0 },
> > +    [DCD_CONFIG][ADD_DYN_CAP_RSP] =3D {
> > +        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> > +    [DCD_CONFIG][RELEASE_DYN_CAP] =3D {
> > +        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> >   };
> >
> >   static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 3a338b3b37..01a5eaca48 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -130,7 +130,8 @@ typedef enum {
> >       CXL_MBOX_INCORRECT_PASSPHRASE =3D 0x14,
> >       CXL_MBOX_UNSUPPORTED_MAILBOX =3D 0x15,
> >       CXL_MBOX_INVALID_PAYLOAD_LENGTH =3D 0x16,
> > -    CXL_MBOX_MAX =3D 0x17
> > +    CXL_MBOX_INVALID_EXTENT_LIST =3D 0x1E, /* cxl r3.0: Table 8-34*/
> > +    CXL_MBOX_MAX =3D 0x1F
> >   } CXLRetCode;
> >
> >   struct cxl_cmd;
> > --
> > 2.25.1

