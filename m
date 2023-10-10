Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A7C7BFE6D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqD95-0006F0-Pv; Tue, 10 Oct 2023 09:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqD90-0006CY-TN
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqD8w-0001DT-A8
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696945885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WPlDaTC9Nx/qxNyARQOUIBoi1JEmNCvuT9tftjEj660=;
 b=OLo+SFg30vdzcFu80ZtqfkbUwmCNSxmUIXTWKc/SRN1+OITi6Z4pGY5NixByWoIR7Im0JJ
 U+QOwuurcm+HzQDPCgrzf0hgdGFQ1YletvEilbH9RayO7S3be70fHycbMvjJsQS7Yj2dbd
 01s0lFnnDhboToywRBnU1pUlOl2iAMw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-o8tr0N1NPa62zg3MiJPsXA-1; Tue, 10 Oct 2023 09:51:23 -0400
X-MC-Unique: o8tr0N1NPa62zg3MiJPsXA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d9a5a3f2d4fso961746276.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696945883; x=1697550683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPlDaTC9Nx/qxNyARQOUIBoi1JEmNCvuT9tftjEj660=;
 b=TvvNtkXazfkOAN2dXOQQtqmgxzuejzWc9aRfzp2+FtnDlEV8z7hfXy6EDyRUDnYH4h
 7tq3Qd8wbke+za6PEkwOvjF136kGK/mSHglvULpGM6mrMK93Gaxr7kLT6WimAFE+RwdX
 X6d2DBVmZfwi49YWXgcJN/ZgF+yL4pl090knd5NbqC/wc5E1D9SBeJ1Xf2wXPTVyz/d5
 +5xG+RjS4sEyH//pUbd+vYVP27G5iox35L9bD2BEfo+2QliI8hOfLb1g8k9Y1OJ67Y75
 2JP7DRzLlXailLAJD9cEPFiDAN/7LHvtgbrRSJkd1VChkER05XHr+AzbhkpG9hqi20wj
 rElw==
X-Gm-Message-State: AOJu0YxLCZlpE0L6jqsrRDSo37W8qC31cTKk69hR+8NsGQBs0qcsWnLc
 4ycaMMSqx1isVvdR7XHCCr6lc0d6Jq6Xl3bhKzNk6nnEH6bP4VKC8fkeQmhvg64FeAJ4++5ZGWh
 rnasYU5iX6gCsYOs=
X-Received: by 2002:a25:cf8b:0:b0:d81:5af9:5208 with SMTP id
 f133-20020a25cf8b000000b00d815af95208mr19044367ybg.31.1696945882949; 
 Tue, 10 Oct 2023 06:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNyzMFbZzVQUxyDVfREGu8Uy+JRT9GN76mqTNphrObN8vBVvFRl+VyNItwNLcUiVh+jsJE3Q==
X-Received: by 2002:a25:cf8b:0:b0:d81:5af9:5208 with SMTP id
 f133-20020a25cf8b000000b00d815af95208mr19044335ybg.31.1696945882570; 
 Tue, 10 Oct 2023 06:51:22 -0700 (PDT)
Received: from [192.168.43.95] ([37.170.189.5])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a0c8c42000000b0065b22afe53csm4839552qvb.94.2023.10.10.06.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 06:51:21 -0700 (PDT)
Message-ID: <f14be475-7a7b-6709-a7dd-e91504a6afa2@redhat.com>
Date: Tue, 10 Oct 2023 15:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/12] util/reserved-region: Add new ReservedRegion
 helpers
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-10-eric.auger@redhat.com>
 <20230929161649.GC2957297@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230929161649.GC2957297@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jean,
On 9/29/23 18:16, Jean-Philippe Brucker wrote:
> On Wed, Sep 13, 2023 at 10:01:44AM +0200, Eric Auger wrote:
>> Introduce resv_region_list_insert() helper which inserts
>> a new ReservedRegion into a sorted list of reserved region.
>> In case of overlap, the new region has higher priority and
>> hides the existing overlapped segments. If the overlap is
>> partial, new regions are created for parts which are not
>> overlapped. The new region has higher priority independently
>> on the type of the regions.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  include/qemu/reserved-region.h | 32 ++++++++++++
>>  util/reserved-region.c         | 94 ++++++++++++++++++++++++++++++++++
>>  util/meson.build               |  1 +
>>  3 files changed, 127 insertions(+)
>>  create mode 100644 include/qemu/reserved-region.h
>>  create mode 100644 util/reserved-region.c
>>
>> diff --git a/include/qemu/reserved-region.h b/include/qemu/reserved-region.h
>> new file mode 100644
>> index 0000000000..8e6f0a97e2
>> --- /dev/null
>> +++ b/include/qemu/reserved-region.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * QEMU ReservedRegion helpers
>> + *
>> + * Copyright (c) 2023 Red Hat, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef QEMU_RESERVED_REGION_H
>> +#define QEMU_RESERVED_REGION_H
>> +
>> +#include "exec/memory.h"
>> +
>> +/*
>> + * Insert a new region into a sorted list of reserved regions. In case
>> + * there is overlap with existing regions, the new added region has
>> + * higher priority and replaces the overlapped segment.
>> + */
>> +GList *resv_region_list_insert(GList *list, ReservedRegion *reg);
>> +
>> +#endif
>> diff --git a/util/reserved-region.c b/util/reserved-region.c
>> new file mode 100644
>> index 0000000000..bb26a6bed3
>> --- /dev/null
>> +++ b/util/reserved-region.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * QEMU ReservedRegion helpers
>> + *
>> + * Copyright (c) 2023 Red Hat, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/range.h"
>> +#include "qemu/reserved-region.h"
>> +
>> +GList *resv_region_list_insert(GList *list, ReservedRegion *reg)
>> +{
>> +    ReservedRegion *resv_iter, *new_reg;
>> +    Range *r = &reg->range;
>> +    Range *range_iter;
>> +    GList *l;
>> +
>> +    for (l = list; l ; ) {
>> +        resv_iter = (ReservedRegion *)l->data;
>> +        range_iter = &resv_iter->range;
>> +
>> +        /* Skip all list elements strictly less than range to add */
>> +        if (range_compare(range_iter, r) < 0) {
>> +            l = l->next;
>> +        } else if (range_compare(range_iter, r) > 0) {
>> +            return g_list_insert_before(list, l, reg);
>> +        } else { /* there is an operlap */
> I guess this could just be 'else if', and the whole block below
> unindented. But I don't know if the function would look less or more scary :)
yeah if you don't mind I would be inclided to leave it as is. It
isolates the case where we have an overlap and you already reviewed it ;-).
>
>> +            if (range_contains_range(r, range_iter)) {
>> +                /* new range contains current item, simply remove this latter */
>> +                GList *prev = l->prev;
>> +                g_free(l->data);
>> +                list = g_list_delete_link(list, l);
>> +                if (prev) {
> These four lines could just be 'l = prev->next'.
indeed!
>
>> +                    l = prev;
>> +                    if (l) {
>> +                        l = l->next;
>> +                    }
>> +                } else {
>> +                    l = list;
>> +                }
>> +            } else if (range_contains_range(range_iter, r)) {
>> +                /* new region is included in the current region */
>> +                if (range_lob(range_iter) == range_lob(r)) {
>> +                    /* adjacent on the left side, derives into 2 regions */
>> +                    range_set_bounds(range_iter, range_upb(r) + 1,
>> +                                     range_upb(range_iter));
>> +                    return g_list_insert_before(list, l, reg);
>> +                } else if (range_upb(range_iter) == range_upb(r)) {
>> +                    /* adjacent on the right side, derives into 2 regions */
>> +                    range_set_bounds(range_iter, range_lob(range_iter),
>> +                                     range_lob(r) - 1);
>> +                    l = l->next;
>> +                } else {
>> +                    uint64_t lob = range_lob(range_iter);
>> +                    /*
>> +                     * the new range is in the middle of an existing one,
>> +                     * split this latter into 3 regs instead
>> +                     */
>> +                    range_set_bounds(range_iter, range_upb(r) + 1,
>> +                                     range_upb(range_iter));
>> +                    new_reg = g_new0(ReservedRegion, 1);
>> +                    new_reg->type = resv_iter->type;
>> +                    range_set_bounds(&new_reg->range,
>> +                                     lob, range_lob(r) - 1);
>> +                    list = g_list_insert_before(list, l, new_reg);
>> +                    return g_list_insert_before(list, l, reg);
>> +                }
>> +            } else if (range_lob(r) < range_lob(range_iter)) {
>> +                range_set_bounds(range_iter, range_upb(r) + 1,
>> +                                 range_upb(range_iter));
>> +                return g_list_insert_before(list, l, reg);
>> +            } else { /* intersection on the upper range */
>> +                range_set_bounds(range_iter, range_lob(range_iter),
>> +                                 range_lob(r) - 1);
>> +                l = l->next;
>> +            }
>> +        } /* overlap */
>> +    }
>> +    return g_list_append(list, reg);
> Looks correct overall
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

That must have been a pain, really appreciated!

Eric
>
>> +}
>> +
>> diff --git a/util/meson.build b/util/meson.build
>> index c4827fd70a..eb677b40c2 100644
>> --- a/util/meson.build
>> +++ b/util/meson.build
>> @@ -51,6 +51,7 @@ util_ss.add(files('qdist.c'))
>>  util_ss.add(files('qht.c'))
>>  util_ss.add(files('qsp.c'))
>>  util_ss.add(files('range.c'))
>> +util_ss.add(files('reserved-region.c'))
>>  util_ss.add(files('stats64.c'))
>>  util_ss.add(files('systemd.c'))
>>  util_ss.add(files('transactions.c'))
>> -- 
>> 2.41.0
>>


