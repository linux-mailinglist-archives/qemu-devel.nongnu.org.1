Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9243671A3BC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:06:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4koX-0001VU-75; Thu, 01 Jun 2023 12:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4koQ-0001OS-86
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4koO-0002gI-TT
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685635562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LiWV9e6Pc9vPe13kbK9KOefjFA4x7JhLE2ziqCt6vcY=;
 b=R2k4GcKi6BXid5s5Pwojzads1c8BPeqqzl/PRtQNsmX5nTIANWxm7bJkLxoHLPQCJEayML
 SildZlCk1f43bYcF4jv0xZMD3TSd+3BK1FsMfnVsVuSpzvMy4kVGUQGI9Vg/+YgsIQqcbj
 1PMk5GEmfZqDiwEq4HX7JlB2YLhaOgs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-IMFLtBVvNzuBxobfP91ZDw-1; Thu, 01 Jun 2023 12:05:51 -0400
X-MC-Unique: IMFLtBVvNzuBxobfP91ZDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A04E3813F33;
 Thu,  1 Jun 2023 16:05:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D6A112132C;
 Thu,  1 Jun 2023 16:05:50 +0000 (UTC)
Date: Thu, 1 Jun 2023 18:05:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: stefanha@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 02/11] qdev-properties-system: Lock AioContext for
 blk_insert_bs()
Message-ID: <ZHjB3eQCZmhMb1iT@redhat.com>
References: <20230531110231.262251-1-kwolf@redhat.com>
 <20230531110231.262251-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531110231.262251-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 31.05.2023 um 13:02 hat Kevin Wolf geschrieben:
> blk_insert_bs() requires that callers hold the AioContext lock for the
> node that should be inserted. Take it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index d42493f630..7f6b14276a 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -147,7 +147,10 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
>              blk = blk_new(ctx, 0, BLK_PERM_ALL);
>              blk_created = true;
>  
> +            aio_context_acquire(ctx);
>              ret = blk_insert_bs(blk, bs, errp);
> +            aio_context_release(ctx);

This one actually isn't completely right. ctx is only the AioContext of
bs if the device supports iothreads, but the main context otherwise.
It's the right thing for blk_new(), but for blk_insert_bs() we always
need to hold the lock for the AioContext of bs.

Kevin


