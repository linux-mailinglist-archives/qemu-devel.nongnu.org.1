Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F25337B37B4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 18:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmGAq-00035r-OT; Fri, 29 Sep 2023 12:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qmGAg-00030L-Qe
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 12:16:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qmGAZ-0006Kl-2S
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 12:16:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405497850dbso123368115e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696004205; x=1696609005; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xh1o3yh9k8s8Du3ioGU6aZkjuIl2+uYmVsN67dgAZrQ=;
 b=sz3a+wWQC0wJdUYiI3JrdQ8uQAIsTJTdvWZiXO2w+0VLZZUTgGfD+KfsO5i67Bto49
 SwSzcoaWyIMQG5B6t/WWSPf/BN92YsBtQApD1UDXnMXNMzgFEiTVAUF7YwKuDoFK9hOL
 CT5DGyZc6JGGWxdAVlOn4IRKjO8y36RpmyvDOlVnV+Gtd/UbZzTjg75dRn2nNeXZ+sGB
 2XYXsaO2bPt5OOjiphk+97/wRHvAPz5RMmr+cqvcJW+KqMAyNKzc8kzKo3HbZuKrtMHc
 TMNPoM+YFakSyYQYK84mGY7UzGSh3ZNX8+B5QUx9OUeG+Jw1ERU7kKGV2jNmkIbrvkIV
 rfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696004205; x=1696609005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xh1o3yh9k8s8Du3ioGU6aZkjuIl2+uYmVsN67dgAZrQ=;
 b=LbFYDpU3UkZVek+FBMyaUEmJr1ZnNeYkiU5fFQbG9iSi/TLnbgHHCr2jXtpO9g5wAo
 u2gzT432IVrYAZMqKunkhsPyZBagHFtZ2d4Un7/3Pz6zW+ed9ZXVKdmYVnvrzRfpgy+q
 oznV6EGJKTRl6Kno5ssQMMTfWw0RBMcTiBirjqZ7eHE3RESzGN36euptG8mcT24Skj2m
 ttEWRrqU7a/9oYMcCfro5zDR+PbWtZ4AxZSrUp+F9CJmF+VXxvJFMEbd6b5FC0JIiAKa
 zL8LZTZfAlv4EOgf/aECX01kEpKqifoxyLhOhZHgsWCoLlJPqaeRkBKJoephQFB/zJHj
 TKUg==
X-Gm-Message-State: AOJu0YyDQHCNmRZiS+2DUWfJ2zmymMnmtJz0s75Lkwj/rLQBAQQU4fvk
 ZzOcwl/zPFdU750M8UywfnGb4A==
X-Google-Smtp-Source: AGHT+IH3QNijH21aeOKnHSPiHVjhkNCyl72o4hXiq6JuRtX/skZH3zRNHmNpPe5mMUeeS5PRpjTwqA==
X-Received: by 2002:a5d:460a:0:b0:317:57f0:fae with SMTP id
 t10-20020a5d460a000000b0031757f00faemr4026677wrq.63.1696004205163; 
 Fri, 29 Sep 2023 09:16:45 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a5d64ae000000b0031aca6cc69csm11631083wrp.2.2023.09.29.09.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 09:16:44 -0700 (PDT)
Date: Fri, 29 Sep 2023 17:16:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 09/12] util/reserved-region: Add new ReservedRegion
 helpers
Message-ID: <20230929161649.GC2957297@myrica>
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913080423.523953-10-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 13, 2023 at 10:01:44AM +0200, Eric Auger wrote:
> Introduce resv_region_list_insert() helper which inserts
> a new ReservedRegion into a sorted list of reserved region.
> In case of overlap, the new region has higher priority and
> hides the existing overlapped segments. If the overlap is
> partial, new regions are created for parts which are not
> overlapped. The new region has higher priority independently
> on the type of the regions.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/qemu/reserved-region.h | 32 ++++++++++++
>  util/reserved-region.c         | 94 ++++++++++++++++++++++++++++++++++
>  util/meson.build               |  1 +
>  3 files changed, 127 insertions(+)
>  create mode 100644 include/qemu/reserved-region.h
>  create mode 100644 util/reserved-region.c
> 
> diff --git a/include/qemu/reserved-region.h b/include/qemu/reserved-region.h
> new file mode 100644
> index 0000000000..8e6f0a97e2
> --- /dev/null
> +++ b/include/qemu/reserved-region.h
> @@ -0,0 +1,32 @@
> +/*
> + * QEMU ReservedRegion helpers
> + *
> + * Copyright (c) 2023 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef QEMU_RESERVED_REGION_H
> +#define QEMU_RESERVED_REGION_H
> +
> +#include "exec/memory.h"
> +
> +/*
> + * Insert a new region into a sorted list of reserved regions. In case
> + * there is overlap with existing regions, the new added region has
> + * higher priority and replaces the overlapped segment.
> + */
> +GList *resv_region_list_insert(GList *list, ReservedRegion *reg);
> +
> +#endif
> diff --git a/util/reserved-region.c b/util/reserved-region.c
> new file mode 100644
> index 0000000000..bb26a6bed3
> --- /dev/null
> +++ b/util/reserved-region.c
> @@ -0,0 +1,94 @@
> +/*
> + * QEMU ReservedRegion helpers
> + *
> + * Copyright (c) 2023 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/range.h"
> +#include "qemu/reserved-region.h"
> +
> +GList *resv_region_list_insert(GList *list, ReservedRegion *reg)
> +{
> +    ReservedRegion *resv_iter, *new_reg;
> +    Range *r = &reg->range;
> +    Range *range_iter;
> +    GList *l;
> +
> +    for (l = list; l ; ) {
> +        resv_iter = (ReservedRegion *)l->data;
> +        range_iter = &resv_iter->range;
> +
> +        /* Skip all list elements strictly less than range to add */
> +        if (range_compare(range_iter, r) < 0) {
> +            l = l->next;
> +        } else if (range_compare(range_iter, r) > 0) {
> +            return g_list_insert_before(list, l, reg);
> +        } else { /* there is an operlap */

I guess this could just be 'else if', and the whole block below
unindented. But I don't know if the function would look less or more scary :)

> +            if (range_contains_range(r, range_iter)) {
> +                /* new range contains current item, simply remove this latter */
> +                GList *prev = l->prev;
> +                g_free(l->data);
> +                list = g_list_delete_link(list, l);
> +                if (prev) {

These four lines could just be 'l = prev->next'.

> +                    l = prev;
> +                    if (l) {
> +                        l = l->next;
> +                    }
> +                } else {
> +                    l = list;
> +                }
> +            } else if (range_contains_range(range_iter, r)) {
> +                /* new region is included in the current region */
> +                if (range_lob(range_iter) == range_lob(r)) {
> +                    /* adjacent on the left side, derives into 2 regions */
> +                    range_set_bounds(range_iter, range_upb(r) + 1,
> +                                     range_upb(range_iter));
> +                    return g_list_insert_before(list, l, reg);
> +                } else if (range_upb(range_iter) == range_upb(r)) {
> +                    /* adjacent on the right side, derives into 2 regions */
> +                    range_set_bounds(range_iter, range_lob(range_iter),
> +                                     range_lob(r) - 1);
> +                    l = l->next;
> +                } else {
> +                    uint64_t lob = range_lob(range_iter);
> +                    /*
> +                     * the new range is in the middle of an existing one,
> +                     * split this latter into 3 regs instead
> +                     */
> +                    range_set_bounds(range_iter, range_upb(r) + 1,
> +                                     range_upb(range_iter));
> +                    new_reg = g_new0(ReservedRegion, 1);
> +                    new_reg->type = resv_iter->type;
> +                    range_set_bounds(&new_reg->range,
> +                                     lob, range_lob(r) - 1);
> +                    list = g_list_insert_before(list, l, new_reg);
> +                    return g_list_insert_before(list, l, reg);
> +                }
> +            } else if (range_lob(r) < range_lob(range_iter)) {
> +                range_set_bounds(range_iter, range_upb(r) + 1,
> +                                 range_upb(range_iter));
> +                return g_list_insert_before(list, l, reg);
> +            } else { /* intersection on the upper range */
> +                range_set_bounds(range_iter, range_lob(range_iter),
> +                                 range_lob(r) - 1);
> +                l = l->next;
> +            }
> +        } /* overlap */
> +    }
> +    return g_list_append(list, reg);

Looks correct overall

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> +}
> +
> diff --git a/util/meson.build b/util/meson.build
> index c4827fd70a..eb677b40c2 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -51,6 +51,7 @@ util_ss.add(files('qdist.c'))
>  util_ss.add(files('qht.c'))
>  util_ss.add(files('qsp.c'))
>  util_ss.add(files('range.c'))
> +util_ss.add(files('reserved-region.c'))
>  util_ss.add(files('stats64.c'))
>  util_ss.add(files('systemd.c'))
>  util_ss.add(files('transactions.c'))
> -- 
> 2.41.0
> 

