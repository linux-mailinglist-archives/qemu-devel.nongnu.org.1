Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D9741A7B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEcUb-0007eg-LX; Wed, 28 Jun 2023 17:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qEcUZ-0007e1-OS
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qEcUY-0001q4-6F
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687986860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+rr/xaKo6blJY11VvQTFwogMWlsygR+gBEOzAYsIcY=;
 b=FOsvCs6uQcv27PgTmqZ12WGfibGdut1zwcCsPzHDNDrU1z/FFt9y8g9yxJlncdPaDyol6R
 +hB1FrA/+IS3h8tPuVnII4FN/DvRHU1c6Pz+J18NC6W0OKAFnw5SRiXlEHfZyOO60hraOW
 uqTBHiNHQvtWgB71UWSyOilOAz2HKuI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-gpgWO5oaOlu1481_oqEvrQ-1; Wed, 28 Jun 2023 17:14:18 -0400
X-MC-Unique: gpgWO5oaOlu1481_oqEvrQ-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-76998d984b0so15383639f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687986858; x=1690578858;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+rr/xaKo6blJY11VvQTFwogMWlsygR+gBEOzAYsIcY=;
 b=bWmwc2211UhxRYORLxXG17uGUb9Zu/8nA5MDG6niLc95X/hUdD8zOsHc03RQLwcU1x
 I6Agl5pTqMrEFyqFZtUatn/6p0xTePBeGJ8jJX0FvAHX6+IULiRRQhSBrYIK8Ncy+Cvs
 eq6Lk12U8qHQSNgsZVWOutDJU2srnGs1N+r+YCE7AWNj449esK9U1o6yUk/E1pxsQpxu
 wlrmWwEniwON5x8LHEIV3LgAM4AUdhzE20hzSmwUdNVvH6SmxKEsaCzhuX1leIKAXSLz
 EjgXdVn1m6Xa7Z7hk+AfHI+4+STnBZN4LzOdY0FrcdGSC1v3XW+SeMMqpcE5PVjCVjl/
 QXOA==
X-Gm-Message-State: AC+VfDywZbX1MscSPB7e6Husupypqhkr3pkRYygbOB12CJJ1vX/sX4gb
 n/nscPMjVwTBlML+lTI0h/g9owDOxFEzoUTBsO9UgQTlDfAoFyUPV8tQ92/sTxVlSxmmlmOWY/I
 pyNROCIJg3VcOpT0=
X-Received: by 2002:a6b:e503:0:b0:783:62f7:3e2c with SMTP id
 y3-20020a6be503000000b0078362f73e2cmr10737601ioc.9.1687986858113; 
 Wed, 28 Jun 2023 14:14:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7x+45mR/qzupdxQwhXwU8dzdn5rNS1y4XhowSEBrFQJfRL7ba65LiNEwRcij8E/RlysS+gNQ==
X-Received: by 2002:a6b:e503:0:b0:783:62f7:3e2c with SMTP id
 y3-20020a6be503000000b0078362f73e2cmr10737577ioc.9.1687986857868; 
 Wed, 28 Jun 2023 14:14:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 g6-20020a5d8c86000000b00780d8ef274asm3703763ion.3.2023.06.28.14.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:14:17 -0700 (PDT)
Date: Wed, 28 Jun 2023 15:14:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 0/2] vfio/migration: Make VFIO migration
 non-experimental
Message-ID: <20230628151415.77ee583e.alex.williamson@redhat.com>
In-Reply-To: <20230628073112.7958-1-avihaih@nvidia.com>
References: <20230628073112.7958-1-avihaih@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 28 Jun 2023 10:31:10 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Hello,
> 
> The major parts of VFIO migration are supported today in QEMU. This
> includes basic VFIO migration, device dirty page tracking and precopy
> support. Thus, at this point in time, it seems appropriate to make VFIO
> migration non-experimental.
> 
> This short series (which is based on the precopy series [1]) does that
> and also adds a few improvements:
> - Patch #1 resets bytes_transferred counter properly.
> - Patch #2 cleans up the VFIO migration realize flow and makes VFIO
>   migration non-experimental.
> 
> Note that Zhenzhong's series [2] fixes additional bugs and further
> cleans the VFIO migration realize flow.
> 
> Changes from v1 [3]:
> * Dropped patch #1 as it's an optimization. (Cedric)
> * Added Fixes tag to patch #2. (Cedric)
> * Made VFIO device realization fail if migration is not supported and
>   enable_migration is ON. (Cedric)
> * Kept the error message of errno == ENOTTY case as it was in
>   vfio_migration_query_flags(). (Cedric)
> * Added a warn when enable_migration is ON and device dirty tracking is
>   not supported. (Alex)
> * Renamed trace_vfio_migration_probe() to
> * trace_vfio_migration_realize().
> 
> 
> Thanks.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20230621111201.29729-1-avihaih@nvidia.com/
> 
> [2]
> https://lore.kernel.org/qemu-devel/20230621080204.420723-1-zhenzhong.duan@intel.com/
> 
> [3]
> https://lore.kernel.org/qemu-devel/20230626082353.18535-1-avihaih@nvidia.com/
> 
> Avihai Horon (2):
>   vfio/migration: Reset bytes_transferred properly
>   vfio/migration: Make VFIO migration non-experimental
> 
>  include/hw/vfio/vfio-common.h |  7 +--
>  migration/migration.h         |  1 +
>  hw/vfio/common.c              | 16 ++++++-
>  hw/vfio/migration.c           | 85 ++++++++++++++++++++++++-----------
>  hw/vfio/pci.c                 |  4 +-
>  migration/migration.c         |  1 +
>  migration/savevm.c            |  1 +
>  migration/target.c            | 17 ++++++-
>  hw/vfio/trace-events          |  2 +-
>  9 files changed, 97 insertions(+), 37 deletions(-)
> 

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


