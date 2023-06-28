Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8609C7409C5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPnL-0004da-Mc; Wed, 28 Jun 2023 03:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEPnJ-0004dB-LT
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEPnI-0003I5-0j
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687938050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ros0zz0a+0QAkmBvsRh7QiPiseMFlO9T4/oDZGvzdgg=;
 b=FrddCQVUrwlhE7PALSl9FmNI12G+1gtlYOOVVMeO3B7cQmCbhzwuloAqe1P6rAfUuK7VQL
 XTdlwUbaRoOy3wYY61H9YZYcDxidUNbjyXueSqObTZ1ldQvxT1vR6CVLjUSCsfVd65Bsef
 khUN1kRZHhjV+Dn+Ela8CBEeasFkjg4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-JaxH-fMQPCm0tvzmPb4IRA-1; Wed, 28 Jun 2023 03:40:47 -0400
X-MC-Unique: JaxH-fMQPCm0tvzmPb4IRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AAB8382C96A;
 Wed, 28 Jun 2023 07:40:47 +0000 (UTC)
Received: from redhat.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEAAA9E9C;
 Wed, 28 Jun 2023 07:40:46 +0000 (UTC)
Date: Wed, 28 Jun 2023 09:40:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v2 3/3] block: remove separate bdrv_file_open callback
Message-ID: <ZJvj/UP9CZXQ+U2Y@redhat.com>
References: <20230601115139.196369-1-pbonzini@redhat.com>
 <20230601115139.196369-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115139.196369-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 01.06.2023 um 13:51 hat Paolo Bonzini geschrieben:
> bdrv_file_open and bdrv_open are completely equivalent, they are
> never checked except to see which one to invoke.  So merge them
> into a single one.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> diff --git a/block/blkio.c b/block/blkio.c
> index 72117fa0059b..202cf20ca4bb 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -992,7 +992,7 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
>          .format_name             = name, \
>          .protocol_name           = name, \
>          .instance_size           = sizeof(BDRVBlkioState), \
> -        .bdrv_file_open          = blkio_file_open, \
> +        .bdrv_open               = blkio_open, \
>          .bdrv_close              = blkio_close, \
>          .bdrv_co_getlength       = blkio_co_getlength, \
>          .bdrv_co_truncate        = blkio_truncate, \

You changed the function name here, but didn't actually rename the
function. I don't think this can build.

> diff --git a/block/null.c b/block/null.c
> index 4808704ffd3a..6fa64d20d865 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -283,7 +283,7 @@ static BlockDriver bdrv_null_co = {
>      .protocol_name          = "null-co",
>      .instance_size          = sizeof(BDRVNullState),
>  
> -    .bdrv_file_open         = null_file_open,
> +    .bdrv_open              = null_file_open,
>      .bdrv_parse_filename    = null_co_parse_filename,
>      .bdrv_co_getlength      = null_co_getlength,
>      .bdrv_co_get_allocated_file_size = null_co_get_allocated_file_size,

If we do want to rename, then we should do it in all block drivers. As
far as I can tell, this would be null, nvme and ssh. Not nfs, because
all related function start with nfs_file_* there.

Kevin


