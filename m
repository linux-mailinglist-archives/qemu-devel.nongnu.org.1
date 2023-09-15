Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B77A2620
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDjG-00033B-Or; Fri, 15 Sep 2023 14:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qhDjF-00031M-9Y
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qhDjD-0002fu-Lf
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694803181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuQcGTeGJ1kwJlpFERXOY6XBEOOLlbSmt8iOg9EUNpE=;
 b=YwSpZOIy4eiqCX84m90hMW7v/85dF+jH/OcZQMf9tFgRv8Ouq2qrdWPNNSPPcTOBh6TxzI
 O5ly4PWqwch5XOLsYpqrBvCBC4b7ntORvmW6EfAWmvrqxi2vMlOeOeGz+F3dH6Qj3nPxus
 9floHa+9/RRtmuCrpNDgAb2Lbx1CGRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-XrLI1o7_NTGyHQGkRr01dQ-1; Fri, 15 Sep 2023 14:39:39 -0400
X-MC-Unique: XrLI1o7_NTGyHQGkRr01dQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3FAB811E7B;
 Fri, 15 Sep 2023 18:39:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FA8C40C6EA8;
 Fri, 15 Sep 2023 18:39:37 +0000 (UTC)
Date: Fri, 15 Sep 2023 13:39:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH v2 3/8] qemu-img: rebase: use backing files' BlockBackend
 for buffer alignment
Message-ID: <k4e2luy4l5vlsfim36ocspcjcy7rltnqlmgigffpxb4azo522h@7v3xxctdx5lk>
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 15, 2023 at 07:20:11PM +0300, Andrey Drobyshev wrote:
> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
> the data read from the old and new backing files are aligned using
> BlockDriverState (or BlockBackend later on) referring to the target image.
> However, this isn't quite right, because buf_new is only being used for
> reading from the new backing, while buf_old is being used for both reading
> from the old backing and writing to the target.  Let's take that into account
> and use more appropriate values as alignments.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qemu-img.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 50660ba920..d12e4a4753 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3750,8 +3750,13 @@ static int img_rebase(int argc, char **argv)
>          int64_t n;
>          float local_progress = 0;
>  
> -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
> +        if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
> +            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
> +            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> +        } else {
> +            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
> +        }

Since bdrv_opt_mem_align(NULL) is safe, could we just simplify this to:

buf_old = qemu_memalign(MAX(bdrv_opt_mem_align(blk_old_backing),
                            bdrv_opt_mem_align(blk)), IO_BUF_SIZE);

instead of going through an if statement?  Or is the problem that
bdrv_opt_mem_align(NULL) can return the host page size (perhaps 64k),
which may be larger than technically needed in some scenarios?

> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>  
>          size = blk_getlength(blk);
>          if (size < 0) {
> -- 
> 2.39.3

At any rate, aligning the buffers by how they will be used makes sense
(if the destination blk has looser requirements than the source
blk_old_backing, then accesses into blk_old are suspect).

Reviewed-by: Eric Blake <eblake@redhat.com.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


