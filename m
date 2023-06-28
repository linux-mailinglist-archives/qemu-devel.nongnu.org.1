Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C5741B9C
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 00:01:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEdCW-0001AK-WD; Wed, 28 Jun 2023 17:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEdCV-0001AB-II
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEdCT-0003Z4-KK
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKdH/aemj8eW4ibqcxIIHZW9ybIeg1yPuuxLQ/CR4zs=;
 b=TzpRHQytmF3m7bGMGBLUmXVMhzM1zGHWtxJz2PhzwdmIWVoWII2FzgXJrjI/b+ubTgdjOC
 qghsXvAhjuuc1bmmWC9z/caZOxDD9zqCL9qNLZpY5WwEFTu51+NtyUepE7a9yXwA+NKgm1
 D5Ib7qkfKBsCVEyyPq7dEyvSUre00KQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-BucNSNsDMKqK-ybCEZ8DLA-1; Wed, 28 Jun 2023 17:59:43 -0400
X-MC-Unique: BucNSNsDMKqK-ybCEZ8DLA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62dd79f63e0so73266d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989582; x=1690581582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKdH/aemj8eW4ibqcxIIHZW9ybIeg1yPuuxLQ/CR4zs=;
 b=lz5LgcVbLUSaTVizsS7rD6KJjd/oKuTTj347H34i+YMDYhqL1hUJ3+oJ79gjJdKyOI
 Ey9Fma7Ie6jDcUvGHEaorf2p578kFSVTq85572RnIpzJYCeuMQaxe2OSAJFYIU57kSX8
 ffaenF3wyWaXnfj72KaJ7Nb5eHTuOsRY7Icjg/gFQhzvbOEw/SztY7+ZiVE2R0iRVLvO
 nEYKBUDfzvFED53Fa0krXovOG3o/DqlSBRDHtF6Qpg/JdMt+aLBveMXSA4nxyv3ScG2m
 FMr/qc4PLCL7U715tJ81jq7QgivkSl/O+9zkW3gDA7xFdgitaK51O3RbtsWxglN0Eo9H
 KsPA==
X-Gm-Message-State: ABy/qLYRUaZiC5Iqj6BjGZdpL6U/gGLPtqP5Heg0ADj8asrAMZ5DjvLp
 r4PnNpSYaVNtT8n0NrAh5XHMxXNa9Qcd6crTQZOHG6sadzE9wrnks3RQFf1y1MLrtCDnP0oz0aL
 LFfl7sewIEWlYHDE=
X-Received: by 2002:a05:6214:4119:b0:636:e4f:6b88 with SMTP id
 kc25-20020a056214411900b006360e4f6b88mr2031719qvb.1.1687989582561; 
 Wed, 28 Jun 2023 14:59:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsluJn7lloPBbQowFY+h/4nyoGWN1uf5OP0bog+ifL8Phv9+8XZP+ZRzwgD8fb35XkTzG90Q==
X-Received: by 2002:a05:6214:4119:b0:636:e4f:6b88 with SMTP id
 kc25-20020a056214411900b006360e4f6b88mr2031706qvb.1.1687989582197; 
 Wed, 28 Jun 2023 14:59:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u7-20020ad44987000000b00630228acc45sm6141921qvx.145.2023.06.28.14.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:59:41 -0700 (PDT)
Date: Wed, 28 Jun 2023 17:59:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3] multifd: Add colo support
Message-ID: <ZJytTfvhyByE0qI0@x1n>
References: <20230622131846.1f5fabb1@mobian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230622131846.1f5fabb1@mobian>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

copy hailiang.

On Thu, Jun 22, 2023 at 01:18:46PM +0200, Lukas Straub wrote:
> Like in the normal ram_load() path, put the received pages into the
> colo cache and mark the pages in the bitmap so that they will be
> flushed to the guest later.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/meson.build    |  1 +
>  migration/multifd-colo.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  migration/multifd-colo.h | 24 ++++++++++++++++++
>  migration/multifd.c      |  5 ++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 migration/multifd-colo.c
>  create mode 100644 migration/multifd-colo.h
> 
> diff --git a/migration/meson.build b/migration/meson.build
> index 1ae28523a1..063e0e0a8c 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -21,6 +21,7 @@ system_ss.add(files(
>    'migration.c',
>    'multifd.c',
>    'multifd-zlib.c',
> +  'multifd-colo.c',
>    'ram-compress.c',
>    'options.c',
>    'postcopy-ram.c',
> diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
> new file mode 100644
> index 0000000000..4872dc6d01
> --- /dev/null
> +++ b/migration/multifd-colo.c
> @@ -0,0 +1,53 @@
> +/*
> + * multifd colo implementation
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/target_page.h"
> +#include "exec/ramblock.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "ram.h"
> +#include "multifd.h"
> +#include "options.h"
> +#include "io/channel-socket.h"
> +#include "migration/colo.h"
> +#include "multifd-colo.h"
> +
> +void multifd_colo_prepare_recv_pages(MultiFDRecvParams *p)
> +{
> +    if (!migrate_colo())
> +        return;
> +
> +    assert(p->block->colo_cache);
> +
> +    /*
> +     * While we're still in precopy state (not yet in colo state), we copy
> +     * received pages to both guest and cache. No need to set dirty bits,
> +     * since guest and cache memory are in sync.
> +     */
> +    if (migration_incoming_in_colo_state()) {
> +        colo_record_bitmap(p->block, p->normal, p->normal_num);
> +    }
> +    p->host = p->block->colo_cache;
> +}
> +
> +void multifd_colo_process_recv_pages(MultiFDRecvParams *p)
> +{
> +    if (!migrate_colo())
> +        return;
> +
> +    if (!migration_incoming_in_colo_state()) {
> +        for (int i = 0; i < p->normal_num; i++) {
> +            void *guest = p->block->host + p->normal[i];
> +            void *cache = p->host + p->normal[i];
> +            memcpy(guest, cache, p->page_size);
> +        }
> +    }
> +    p->host = p->block->host;
> +}
> diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
> new file mode 100644
> index 0000000000..58920a0583
> --- /dev/null
> +++ b/migration/multifd-colo.h
> @@ -0,0 +1,24 @@
> +/*
> + * multifd colo header
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
> +#define QEMU_MIGRATION_MULTIFD_COLO_H
> +
> +#ifdef CONFIG_REPLICATION
> +
> +void multifd_colo_prepare_recv_pages(MultiFDRecvParams *p);
> +void multifd_colo_process_recv_pages(MultiFDRecvParams *p);
> +
> +#else
> +
> +static inline void multifd_colo_prepare_recv_pages(MultiFDRecvParams *p) {}
> +static inline void multifd_colo_process_recv_pages(MultiFDRecvParams *p) {}
> +
> +#endif
> +#endif
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3387d8277f..6b031c1fd2 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -25,6 +25,7 @@
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "multifd.h"
> +#include "multifd-colo.h"
>  #include "threadinfo.h"
>  #include "options.h"
>  #include "qemu/yank.h"
> @@ -1134,10 +1135,14 @@ static void *multifd_recv_thread(void *opaque)
>          qemu_mutex_unlock(&p->mutex);
>  
>          if (p->normal_num) {
> +            multifd_colo_prepare_recv_pages(p);
> +
>              ret = multifd_recv_state->ops->recv_pages(p, &local_err);
>              if (ret != 0) {
>                  break;
>              }
> +
> +            multifd_colo_process_recv_pages(p);
>          }
>  
>          if (flags & MULTIFD_FLAG_SYNC) {
> -- 
> 2.39.2



-- 
Peter Xu


