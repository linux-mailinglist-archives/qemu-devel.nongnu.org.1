Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E51824418
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:47:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLP04-0004ic-Kt; Thu, 04 Jan 2024 09:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLP02-0004iI-Ve
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLP00-0004oH-QM
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704379627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H/nK8u9YG2fE2q0OdmWdlj6fjAaGxLrjfrSkBCEiR6M=;
 b=Bn61B6t0zpguXYCuyxm2DlE672heL8eRf8oyVF//Ym8fwqBMCR1VZfpF9+7nah6LgZJ3cz
 ehYrDjNF+AcT+LasW6Q52KQn/Lnzteaa0p0eWm9mAPmY8HwNEt4+Xmqlvp15JvGVcmdKFB
 G38PZHBeLY7eXB1fEKIZwQYYvdkfj4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-7Q7jQH8FNQWB3JdYFeqLYw-1; Thu, 04 Jan 2024 09:47:05 -0500
X-MC-Unique: 7Q7jQH8FNQWB3JdYFeqLYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 816D5833946;
 Thu,  4 Jan 2024 14:47:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5677492BC6;
 Thu,  4 Jan 2024 14:47:03 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:47:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RESEND v3 06/10] block: Support detached LUKS header
 creation using blockdev-create
Message-ID: <ZZbE5fn0a-8f4chC@redhat.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
 <20ab47b728492cedb7ea671239f0397a141c3f5a.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20ab47b728492cedb7ea671239f0397a141c3f5a.1703482349.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Dec 25, 2023 at 01:45:08PM +0800, Hyman Huang wrote:
> The LUKS disk with detached header consists of a separate LUKS
> header and payload. This LUKS disk type should be formatted
> as follows:
> 
> 1. add the secret to lock/unlock the cipher stored in the
>    detached LUKS header
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > "arguments":{"qom-type": "secret", "id": "sec0", "data": "foo"}}'
> 
> 2. create a header img with 0 size
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job0", "options":{"driver":"file",
> > "filename":"/path/to/detached_luks_header.img", "size":0 }}}'
> 
> 3. add protocol blockdev node for header
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments": {"driver":"file", "filename":
> > "/path/to/detached_luks_header.img", "node-name":
> > "detached-luks-header-storage"}}'
> 
> 4. create a payload img with 0 size
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job1", "options":{"driver":"file",
> > "filename":"/path/to/detached_luks_payload_raw.img", "size":0}}}'
> 
> 5. add protocol blockdev node for payload
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments": {"driver":"file", "filename":
> > "/path/to/detached_luks_payload_raw.img", "node-name":
> > "luks-payload-raw-storage"}}'
> 
> 6. do the formatting with 128M size
> $ virsh qemu-monitor-command c81_node1 '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job2", "options":{"driver":"luks", "header":
> > "detached-luks-header-storage", "file":"luks-payload-raw-storage",
> > "size":134217728, "preallocation":"full", "key-secret":"sec0" }}}'
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  block/crypto.c      | 109 ++++++++++++++++++++++++++++++++++++++++----
>  crypto/block-luks.c |   6 ++-
>  crypto/block.c      |   1 +
>  3 files changed, 106 insertions(+), 10 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 78fbe79c95..76cc8bda49 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -160,6 +160,48 @@ error:
>      return ret;
>  }
>  
> +static int coroutine_fn GRAPH_UNLOCKED
> +block_crypto_co_format_luks_payload(BlockdevCreateOptionsLUKS *luks_opts,
> +                                    Error **errp)
> +{
> +    BlockDriverState *bs = NULL;
> +    BlockBackend *blk = NULL;
> +    Error *local_error = NULL;
> +    int ret;
> +
> +    if (luks_opts->size > INT64_MAX) {
> +        return -EFBIG;
> +    }
> +
> +    bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
> +    if (bs == NULL) {
> +        return -EIO;
> +    }
> +
> +    blk = blk_co_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
> +                             BLK_PERM_ALL, errp);
> +    if (!blk) {
> +        ret = -EPERM;
> +        goto fail;
> +    }
> +
> +    ret = blk_truncate(blk, luks_opts->size, true,
> +                       luks_opts->preallocation, 0, &local_error);
> +    if (ret < 0) {
> +        if (ret == -EFBIG) {
> +            /* Replace the error message with a better one */
> +            error_free(local_error);
> +            error_setg(errp, "The requested file size is too large");
> +        }
> +        goto fail;
> +    }
> +
> +    ret = 0;
> +
> +fail:
> +    bdrv_co_unref(bs);
> +    return ret;
> +}
>  
>  static QemuOptsList block_crypto_runtime_opts_luks = {
>      .name = "crypto",
> @@ -651,6 +693,7 @@ static int coroutine_fn GRAPH_UNLOCKED
>  block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>  {
>      BlockdevCreateOptionsLUKS *luks_opts;
> +    BlockDriverState *hdr_bs = NULL;
>      BlockDriverState *bs = NULL;
>      QCryptoBlockCreateOptions create_opts;
>      PreallocMode preallocation = PREALLOC_MODE_OFF;
> @@ -659,8 +702,22 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>      assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
>      luks_opts = &create_options->u.luks;
>  
> -    if (luks_opts->file == NULL) {
> -        error_setg(errp, "Formatting LUKS disk requires parameter 'file'");
> +    if (luks_opts->header == NULL && luks_opts->file == NULL) {
> +        error_setg(errp, "Either the parameter 'header' or 'file' should "

s/should/must/

> +                   "be specified");
> +        return -EINVAL;
> +    }
> +
> +    if (luks_opts->detached_header && luks_opts->header == NULL) {
> +        error_setg(errp, "Formatting a detached LUKS disk requries "

typo   s/requries/requires/

> +                   "'header' to be specified");
> +        return -EINVAL;
> +    }
> +
> +    if ((luks_opts->preallocation != PREALLOC_MODE_OFF) &&
> +        (luks_opts->file == NULL)) {
> +        error_setg(errp, "Parameter 'preallocation' requries 'file' to be "

typo   s/requries/requires/

> +                   "specified for formatting LUKS disk");
>          return -EINVAL;
>      }
>  
> @@ -673,7 +730,40 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>          preallocation = luks_opts->preallocation;
>      }
>  
> -    if (luks_opts->file) {
> +    if (luks_opts->header) {
> +        hdr_bs = bdrv_co_open_blockdev_ref(luks_opts->header, errp);
> +        if (hdr_bs == NULL) {
> +            return -EIO;
> +        }
> +
> +        /*
> +         * If blockdev reference of header is specified,
> +         * detached_header default to true
> +         */
> +        create_opts.u.luks.detached_header = true;
> +
> +        /* Format the LUKS header node */
> +        ret = block_crypto_co_create_generic(hdr_bs, 0, &create_opts,
> +                                             PREALLOC_MODE_OFF, errp);
> +        if (ret < 0) {
> +            goto hdr_bs_failed;
> +        }
> +
> +        /* Format the LUKS payload node */
> +        if (luks_opts->file) {
> +            ret = block_crypto_co_format_luks_payload(luks_opts, errp);
> +            if (ret < 0) {
> +                goto hdr_bs_failed;
> +            }
> +        }
> +
> +        ret = 0;
> +
> +hdr_bs_failed:

I'd suggest we just make the existing 'fail:' label
cope with unref'ing  hdr_bs if it is non-NULL,
rather than having multiple goto label choices.

> +        bdrv_co_unref(hdr_bs);
> +        return ret;
> +    } else if (luks_opts->file) {
> +        /* None detached LUKS header path */
>          bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
>          if (bs == NULL) {
>              return -EIO;
> @@ -682,14 +772,15 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>          ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
>                                               preallocation, errp);
>          if (ret < 0) {
> -            goto fail;
> +            goto bs_failed;
>          }

> -    }
>  
> -    ret = 0;
> -fail:
> -    bdrv_co_unref(bs);
> -    return ret;
> +        ret = 0;
> +
> +bs_failed:
> +        bdrv_co_unref(bs);
> +        return ret;
> +    }
>  }
>  
>  static int coroutine_fn GRAPH_UNLOCKED
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index 48443ffcae..474c7aee2e 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1561,8 +1561,12 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>      block->payload_offset =
>          qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
>  
> +    block->detached_header_size =
> +        (header_sectors + QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS *
> +         split_key_sectors) * block->sector_size;

Storing this in 'detached_header_size' struct field looks redundant,
as the onlY place that reads it is the next line. Remove the struct
field and use a local variable.

> +
>      /* Reserve header space to match payload offset */
> -    initfunc(block, block->payload_offset, opaque, &local_err);
> +    initfunc(block, block->detached_header_size, opaque, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto error;
> diff --git a/crypto/block.c b/crypto/block.c
> index 7bb4b74a37..ea493f056e 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -102,6 +102,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
>      }
>  
>      block->driver = qcrypto_block_drivers[options->format];
> +    block->detached_header = options->u.luks.detached_header;

You cannot access a 'luks' field here, as this can be used for
non-LUKS formats. In an earlier patch I suggested using a enum
flag to indicate detached header when opening a device. that
will work for creating it too.

>  
>      if (block->driver->create(block, options, optprefix, initfunc,
>                                writefunc, opaque, errp) < 0) {
> -- 
> 2.39.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


