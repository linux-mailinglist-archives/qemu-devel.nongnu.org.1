Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC883ADD9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jan 2024 16:56:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSfcI-0006QO-42; Wed, 24 Jan 2024 10:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSfcG-0006Pz-H6
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:56:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSfcE-0003Fv-IL
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:56:40 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKpRD1JDGz6K5df;
 Wed, 24 Jan 2024 23:54:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B9FF9140A70;
 Wed, 24 Jan 2024 23:56:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 15:56:34 +0000
Date: Wed, 24 Jan 2024 15:56:33 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <20240124155633.00002d5f@Huawei.com>
In-Reply-To: <20231107180907.553451-7-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-7-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Tue,  7 Nov 2023 10:07:10 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and add get DC extent list mailbox command per
> CXL.spec.3.0:.8.2.9.8.9.2.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
A few minor comments inline.

J
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 73 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h | 23 ++++++++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1f512b3e6b..56f4aa237a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -82,6 +82,7 @@ enum {
>          #define CLEAR_POISON           0x2
>      DCD_CONFIG  = 0x48,
>          #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1286,6 +1287,75 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.0 section 8.2.9.8.9.2:
> + * Get Dynamic Capacity Extent List (Opcode 4810h)

4801h

> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len_in,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_dyn_cap_ext_list_in_pl {
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_ext_list_out_pl {
> +        uint32_t count;
> +        uint32_t total_extents;
> +        uint32_t generation_num;
> +        uint8_t rsvd[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
> +    uint16_t record_count = 0, i = 0, record_done = 0;
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCDExtent *ent;
> +    uint16_t out_pl_len;
> +    uint32_t start_extent_id = in->start_extent_id;
> +
> +    if (start_extent_id > ct3d->dc.total_extent_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(in->extent_cnt,
> +                       ct3d->dc.total_extent_count - start_extent_id);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    /* May need more processing here in the future */

Not sure what this comment is referring to... I'd be tempted to just
remove it.

> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);

As before. It should be already zeroed.

> +    stl_le_p(&out->count, record_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +    if (record_count > 0) {
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (i++ < start_extent_id) {
> +                continue;
> +            }
> +            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
> +            stq_le_p(&out->records[record_done].len, ent->len);
> +            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
> +            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
> +            record_done++;
> +            if (record_done == record_count) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +



> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 3dc6928bc5..5738c6f434 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -420,6 +420,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  
>  #define DCD_MAX_REGION_NUM 8
>  
> +typedef struct CXLDCDExtentRaw {
> +    uint64_t start_dpa;
> +    uint64_t len;
> +    uint8_t tag[0x10];
> +    uint16_t shared_seq;
> +    uint8_t rsvd[0x6];
> +} QEMU_PACKED CXLDCExtentRaw;
Naming mismatch.

> +
> +typedef struct CXLDCDExtent {
> +    uint64_t start_dpa;
> +    uint64_t len;
> +    uint8_t tag[0x10];
> +    uint16_t shared_seq;
> +    uint8_t rsvd[0x6];
> +
> +    QTAILQ_ENTRY(CXLDCDExtent) node;
> +} CXLDCDExtent;

DCD or DC?  I don't really care but inconsistent currently.

> +typedef QTAILQ_HEAD(, CXLDCDExtent) CXLDCDExtentList;
> +
>  typedef struct CXLDCDRegion {
>      uint64_t base;
>      uint64_t decode_len; /* aligned to 256*MiB */
> @@ -470,6 +489,10 @@ struct CXLType3Dev {
>          HostMemoryBackend *host_dc;
>          AddressSpace host_dc_as;
>          uint64_t total_capacity; /* 256M aligned */
> +        CXLDCDExtentList extents;
> +
> +        uint32_t total_extent_count;
> +        uint32_t ext_list_gen_seq;
>  
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCDRegion regions[DCD_MAX_REGION_NUM];


