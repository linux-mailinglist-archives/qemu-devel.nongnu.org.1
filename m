Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C9761421
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOG1C-0003d9-Uz; Tue, 25 Jul 2023 07:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOG17-0003bw-JS
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOG15-0002oV-PM
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690283746;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AjRFtCCAXsYEGtcQ5QXMzy8kt7EXgLk3gb4cdjgnBho=;
 b=J+45A107J7b6cd3PwufONfrZkf5/6DfZEcwcS0ewtc8ixRGFOWLZm0gx2zMrY30RMZY4E3
 37dV7egDI0aCdqyh9hF3Y4Xv0OMiUyhf1SwG10cVIk9ecTK3VCJvTbkZwKezCcBQfeiBmm
 N1OtlwoRokENBynU0pBjAYdhfCGSk/E=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-zNY4PhzZMLWcYAyLfjeABQ-1; Tue, 25 Jul 2023 07:15:43 -0400
X-MC-Unique: zNY4PhzZMLWcYAyLfjeABQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 248133814948;
 Tue, 25 Jul 2023 11:15:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31B6A40C2063;
 Tue, 25 Jul 2023 11:15:42 +0000 (UTC)
Date: Tue, 25 Jul 2023 12:15:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH] block/blkio: do not use open flags in qemu_open()
Message-ID: <ZL+u3J8nAuyvgYzs@redhat.com>
References: <20230725111155.85426-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725111155.85426-1-sgarzare@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jul 25, 2023 at 01:11:55PM +0200, Stefano Garzarella wrote:
> qemu_open() in blkio_virtio_blk_common_open() is used to open the
> character device (e.g. /dev/vhost-vdpa-0 or /dev/vfio/vfio) or in
> the future eventually the unix socket.
> 
> In all these cases we cannot open the path in read-only mode,
> when the `read-only` option of blockdev is on, because the exchange
> of IOCTL commands for example will fail.
> 
> In order to open the device read-only, we have to use the `read-only`
> property of the libblkio driver as we already do in blkio_file_open().
> 
> Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
> Reported-by: Qing Wang <qinwang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/blkio.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index 1798648134..fe9bf8ea5f 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -686,15 +686,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
>       * layer through the "/dev/fdset/N" special path.
>       */
>      if (fd_supported) {
> -        int open_flags;
> -
> -        if (flags & BDRV_O_RDWR) {
> -            open_flags = O_RDWR;
> -        } else {
> -            open_flags = O_RDONLY;
> -        }
> -
> -        fd = qemu_open(path, open_flags, errp);

I'd suggest taking the paragraph from the commit message explaining why
it is correct to hardcode O_RDWR and putting it into a comment here.

> +        fd = qemu_open(path, O_RDWR, errp);
>          if (fd < 0) {
>              return -EINVAL;
>          }
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


