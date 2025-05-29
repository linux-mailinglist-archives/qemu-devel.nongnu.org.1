Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BBEAC817D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 19:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgjh-0004QD-JM; Thu, 29 May 2025 13:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKgjT-0004PI-96
 for qemu-devel@nongnu.org; Thu, 29 May 2025 13:07:56 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKgjO-0001Jd-Vv
 for qemu-devel@nongnu.org; Thu, 29 May 2025 13:07:55 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7Xp40Zp2z6K9LY;
 Fri, 30 May 2025 01:06:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 218D8140595;
 Fri, 30 May 2025 01:07:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 May
 2025 19:07:35 +0200
Date: Thu, 29 May 2025 18:07:34 +0100
To: <nifan.cxl@gmail.com>, <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <anisa.su887@gmail.com>, <gourry@gourry.net>, <fan.ni@samsung.com>
Subject: Re: [Qemu PATCH v2] hw/cxl: fix DC extent capacity tracking
Message-ID: <20250529180734.00001197@huawei.com>
In-Reply-To: <20250529163925.2916725-1-nifan.cxl@gmail.com>
References: <20250529163925.2916725-1-nifan.cxl@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 29 May 2025 16:34:25 +0000
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
> extents in different states including added, pending, etc.
> 
> Before the change, for the in-device extent number tracking purpose, we only
> have "total_extent_count" defined, which only tracks the number of
> extents accepted. However, we need to track number of extents in other
> states also, for now it is extents pending-to-add.
> 
> To fix that, we introduce a new counter for dynamic capacity
> "nr_extents_accepted" which explicitly tracks number of the extents
> accepted by the hosts, and fix "total_extent_count" to include
> both accepted and pending extents counting.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.  Michael, would you mind picking this up directly if
you are happy with it?   It is an esoteric corner case but
we should emulate resource exhaustion for tracking extents correctly.

I don't have many fixes queued up at the moment to make it worth
me bundling them up into a little series.  There is just this one
and the one for Register Locator capability size I posted
earlier today (Fan can you take a look at that one?)

> ---
> v2:
> 1) No functional changes;
> 2) Rebased the code to ToT of master branch;
> 3) Picked up tag;
> 
> v1:
> https://lore.kernel.org/linux-cxl/20250520195741.789841-1-nifan.cxl@gmail.com/
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h |  3 ++-
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 299f232f26..0b615ea37a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      uint16_t out_pl_len, size;
>      CXLDCExtent *ent;
>  
> -    if (start_extent_id > ct3d->dc.total_extent_count) {
> +    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> @@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
>  
>      stl_le_p(&out->count, record_count);
> -    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
>      stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
>  
>      if (record_count > 0) {
> @@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
>      QTAILQ_INSERT_TAIL(list, group, node);
>  }
>  
> -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
>  {
>      CXLDCExtent *ent, *ent_next;
>      CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> +    uint32_t extents_deleted = 0;
>  
>      QTAILQ_REMOVE(list, group, node);
>      QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
>          cxl_remove_extent_from_extent_list(&group->list, ent);
> +        extents_deleted++;
>      }
>      g_free(group);
> +
> +    return extents_deleted;
>  }
>  
>  /*
> @@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> -    uint32_t i;
> +    uint32_t i, num;
>      uint64_t dpa, len;
>      CXLRetCode ret;
>  
> @@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      }
>  
>      if (in->num_entries_updated == 0) {
> -        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +        ct3d->dc.total_extent_count -= num;
>          return CXL_MBOX_SUCCESS;
>      }
>  
> @@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>  
>          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
>          ct3d->dc.total_extent_count += 1;
> +        ct3d->dc.nr_extents_accepted += 1;
>          ct3_set_region_block_backed(ct3d, dpa, len);
>      }
>      /* Remove the first extent group in the pending list */
> -    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +    ct3d->dc.total_extent_count -= num;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -3160,7 +3167,7 @@ free_and_exit:
>          }
>          *updated_list_size = 0;
>      } else {
> -        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
> +        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
>      }
>  
>      return ret;
> @@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>          ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
>          cxl_remove_extent_from_extent_list(&updated_list, ent);
>      }
> -    ct3d->dc.total_extent_count = updated_list_size;
> +    ct3d->dc.total_extent_count += (updated_list_size -
> +                                    ct3d->dc.nr_extents_accepted);
> +
> +    ct3d->dc.nr_extents_accepted = updated_list_size;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 94e7274912..f283178d88 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      }
>      if (group) {
>          cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> +        dcd->dc.total_extent_count += num_extents;
>      }
>  
>      /*
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed6cd50c67..a151e19da8 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -618,6 +618,7 @@ struct CXLType3Dev {
>          CXLDCExtentList extents;
>          CXLDCExtentGroupList extents_pending;
>          uint32_t total_extent_count;
> +        uint32_t nr_extents_accepted;
>          uint32_t ext_list_gen_seq;
>  
>          uint8_t num_regions; /* 0-8 regions */
> @@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
>                                                      uint16_t shared_seq);
>  void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
>                                         CXLDCExtentGroup *group);
> -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
>  void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                   uint64_t len);
>  void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,


