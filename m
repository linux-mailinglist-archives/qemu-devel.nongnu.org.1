Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F931A9AB28
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 12:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7uEf-0002i4-M3; Thu, 24 Apr 2025 06:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uEd-0002gh-NA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:55:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uEb-0001RM-W9
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:55:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjt9y0QNvz6L5bt;
 Thu, 24 Apr 2025 18:53:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A27514025A;
 Thu, 24 Apr 2025 18:55:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:55:10 +0200
Date: Thu, 24 Apr 2025 11:55:09 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 5/9] cxl_events.h: move definition for
 dynamic_capacity_uuid and enum for DC event types
Message-ID: <20250424115509.00007cc5@huawei.com>
In-Reply-To: <20250317164204.2299371-6-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-6-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 17 Mar 2025 16:31:32 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> move definition for dynamic_capacity_uuid and enum for DC event types to

Move

> cxl_events.h from cxl_type3.c for shared use in next patch
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 15 ---------------
>  include/hw/cxl/cxl_events.h | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 452a0c101a..ac74e62875 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1977,21 +1977,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> -/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> -static const QemuUUID dynamic_capacity_uuid = {
> -    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> -                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> -};
> -
> -typedef enum CXLDCEventType {
> -    DC_EVENT_ADD_CAPACITY = 0x0,
> -    DC_EVENT_RELEASE_CAPACITY = 0x1,
> -    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> -    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> -    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> -    DC_EVENT_CAPACITY_RELEASED = 0x5,
> -} CXLDCEventType;
> -
>  /*
>   * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
>   * the list.
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..758b075a64 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
>      uint32_t tags_avail;
>  } QEMU_PACKED CXLEventDynamicCapacity;
>  
> +/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +typedef enum CXLDCEventType {
> +    DC_EVENT_ADD_CAPACITY = 0x0,
> +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> +} CXLDCEventType;
> +
>  #endif /* CXL_EVENTS_H */


