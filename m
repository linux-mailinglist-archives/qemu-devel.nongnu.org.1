Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6305AEE4C9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Jun 2025 18:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHVE-0000tj-Ne; Mon, 30 Jun 2025 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWHV8-0000t2-5J
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:37:02 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWHV3-0007wl-Ps
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:37:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWBYy2phTz6L5RG;
 Tue,  1 Jul 2025 00:33:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5E9951402F0;
 Tue,  1 Jul 2025 00:36:46 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 18:36:45 +0200
Date: Mon, 30 Jun 2025 17:36:44 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU PATCH v4 03/10] cxl-mailbox-utils: 0x5601 - FMAPI Get
 Host Region Config
Message-ID: <20250630173644.00000c87@huawei.com>
In-Reply-To: <20250626222743.1766404-4-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-4-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 26 Jun 2025 22:23:26 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 103 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9a0f8bd2fc..7f0709a27f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -120,6 +120,7 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO    0x0
> +        #define GET_HOST_DC_REGION_CONFIG   0x1
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3286,6 +3287,106 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void build_dsmas_flags(uint8_t *flags, CXLDCRegion *region)
> +{
> +    *flags = 0;
> +
> +    if (region->nonvolatile) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_NONVOLATILE);
> +    }
> +    if (region->sharable) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_SHARABLE);
> +    }
> +    if (region->hw_managed_coherency) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY);
> +    }
> +    if (region->ic_specific_dc_management) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT);
> +    }
> +    if (region->rdonly) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_RDONLY);
> +    }
> +}
> +
> +/* CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h) */
Trivial but this line annoys checkpatch.pl

I'll break it up as.
/*
 * CXL r3.2 section 7.6.7.6.2:
 * Get Host DC Region Configuration (Opcode 5601h)
 */
> +static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t region_cnt;
> +        uint8_t start_rid;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint16_t host_id;
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint8_t flags;
> +            uint8_t rsvd1[3];
> +            uint8_t sanitize;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    uint16_t record_count, out_pl_len, i;
> +
> +    if (in->start_rid >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    extra_out = (void *)out + out_pl_len;
> +    out_pl_len += sizeof(*extra_out);
> +
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    stw_le_p(&out->host_id, 0);
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[in->start_rid + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[in->start_rid + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[in->start_rid + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[in->start_rid + i].block_size);
> +        build_dsmas_flags(&out->records[i].flags,
> +                          &ct3d->dc.regions[in->start_rid + i]);
> +        /* Sanitize is bit 0 of flags. */
> +        out->records[i].sanitize =
> +            ct3d->dc.regions[in->start_rid + i].flags & BIT(0);
> +    }
> +
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
> +             ct3d->dc.total_extent_count);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3402,6 +3503,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>  static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>      [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
>          cmd_fm_get_dcd_info, 0, 0 },
> +    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
> +        cmd_fm_get_host_dc_region_config, 4, 0 },
>  };
>  
>  /*


