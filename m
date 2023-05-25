Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD426710E37
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bnh-000785-Iq; Thu, 25 May 2023 10:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2Bmk-0006sb-LX
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q2Bmi-0007q5-6z
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1Hk3hfXOm9OXx5W3sAOXGIvdZoKFi7jJ+hO1Kel38I=;
 b=fJILUioZGjZ64ufpiLosjyJGCe3LK/L/zzB6YEAgbpY1QGJs+rKTQq7RnvIYYJ4Gnf6eNK
 rDQrkkgeYA2sxtlQu0KHKQ6il1Wu7pLotRd4KMkrt69pWZPdqfvYc9z9QPzlzLFdvcMfPs
 ABxml0MeNlvPRlgxlAmL9+DrFERh+C0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-jMWw_QZyMCyDyyPucKRa1g-1; Thu, 25 May 2023 10:17:42 -0400
X-MC-Unique: jMWw_QZyMCyDyyPucKRa1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3377185A792;
 Thu, 25 May 2023 14:17:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D56AD2166B2B;
 Thu, 25 May 2023 14:17:40 +0000 (UTC)
Date: Thu, 25 May 2023 09:17:39 -0500
From: Eric Blake <eblake@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?Sm/Do28=?= Silva <jsilva@suse.de>, 
 Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>, 
 Dario Faggioli <dfaggioli@suse.com>
Subject: Re: [RFC PATCH 2/6] block: Mark bdrv_co_get_allocated_file_size() as
 mixed
Message-ID: <7qjnn474ekublkk6uuwrj3ypioyv6cywnij52qrkn6p4brv5n7@re2bq42uy5xp>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523213903.18418-3-farosas@suse.de>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 23, 2023 at 06:38:59PM -0300, Fabiano Rosas wrote:
> Some callers of this function are about to be converted to use
> coroutines, so allow it to be executed both inside and outside a
> coroutine.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/block/block-io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index a27e471a87..c1f96faca5 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -87,7 +87,7 @@ int64_t co_wrapper_mixed_bdrv_rdlock bdrv_getlength(BlockDriverState *bs);
>  int64_t coroutine_fn GRAPH_RDLOCK
>  bdrv_co_get_allocated_file_size(BlockDriverState *bs);
>  
> -int64_t co_wrapper_bdrv_rdlock
> +int64_t co_wrapper_mixed_bdrv_rdlock
>  bdrv_get_allocated_file_size(BlockDriverState *bs);
>  
>  BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> -- 
> 2.35.3
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


