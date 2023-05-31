Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC2718AC2
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:06:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S1D-0002Q2-CR; Wed, 31 May 2023 16:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4S1B-0002Pk-1R
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4S15-0005aT-QK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685563313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlhu2dgges6xKoL/h/FYZKSQHpO5aoNB3Ro6Rs5Bakk=;
 b=fSAsIc2DswxIlUNBuK1AoG/c8Lh68tCdY74wotGv8gos2cf7txb/1zxGJuk3vEamg3iNx+
 k26OMyKXuXnudOCqUktawi8cELSEYbqju0POJe7fVg/lvSZllmJCKbIaT3UG1X7BuyOw+F
 sf0TYfjVKEZW0Jm/V812q3Gq6JKwdic=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-FqQ7gj1dMZua94aBINzoTA-1; Wed, 31 May 2023 16:01:49 -0400
X-MC-Unique: FqQ7gj1dMZua94aBINzoTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55BEB3806624;
 Wed, 31 May 2023 20:01:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C65C040CFD46;
 Wed, 31 May 2023 20:01:48 +0000 (UTC)
Date: Wed, 31 May 2023 15:01:47 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, hreitz@redhat.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 07/11] block: Fix AioContext locking in bdrv_open_inherit()
Message-ID: <wrsymadjtzmmqmqjqykqod2l7corz3l4zfunk74l22bx6acddq@2peb4ufu5uif>
References: <20230531110231.262251-1-kwolf@redhat.com>
 <20230531110231.262251-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531110231.262251-8-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

On Wed, May 31, 2023 at 01:02:27PM +0200, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Commit message is sparse, and doesn't mention....

> ---
>  block.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index a0793b6435..954b9923d9 100644
> --- a/block.c
> +++ b/block.c
> @@ -3794,6 +3794,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
>      int64_t total_size;
>      QemuOpts *opts = NULL;
>      BlockDriverState *bs_snapshot = NULL;
> +    AioContext *ctx = bdrv_get_aio_context(bs);
>      int ret;
>  
>      GLOBAL_STATE_CODE();
> @@ -3802,7 +3803,10 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
>         instead of opening 'filename' directly */
>  
>      /* Get the required size from the image */
> +    aio_context_acquire(ctx);
>      total_size = bdrv_getlength(bs);
> +    aio_context_release(ctx);
> +
>      if (total_size < 0) {
>          error_setg_errno(errp, -total_size, "Could not get image size");
>          goto out;
> @@ -3836,7 +3840,10 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
>          goto out;
>      }
>  
> +    aio_context_acquire(ctx);
>      ret = bdrv_append(bs_snapshot, bs, errp);
> +    aio_context_release(ctx);
> +
>      if (ret < 0) {
>          bs_snapshot = NULL;
>          goto out;

...the changes to bdrv_append_temp_snapshot above.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


