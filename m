Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29A816C17
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:20:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBfO-0004Bm-AT; Mon, 18 Dec 2023 06:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBfL-0004BY-VB
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBfA-0000US-8q
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702898395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kdxl5+xTgjLclwvRVUeXv9iq5GtNxWfeQOHn0FZd+zw=;
 b=ESG4diIQJl++KAD5I0cAE8U33jv4KuM+X8pwcuZzaHQ3lLXhAT3JbZTlk8d/ZCcUvKEdUi
 F3+PwgcJY/Jh6IGralkFCxTTmJ6Nu6GkBXKkfgjagdoYRu1lOZCL6qFEnYT1SQACy/H/RY
 i4juN6s+NArwtKzSe96KdMsD8at1KU4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-L_yWCNq2McCVi2DkdPGO8w-1; Mon,
 18 Dec 2023 06:19:53 -0500
X-MC-Unique: L_yWCNq2McCVi2DkdPGO8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84F7529AA384;
 Mon, 18 Dec 2023 11:19:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E52C15968;
 Mon, 18 Dec 2023 11:19:52 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:19:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [v2 4/4] block: Support detached LUKS header creation for
 blockdev-create
Message-ID: <ZYAq1kre1cEH5YOD@redhat.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
 <5ca4a43ea0795d9fb6ea3649eead10017df69b1c.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ca4a43ea0795d9fb6ea3649eead10017df69b1c.1701879996.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Dec 07, 2023 at 12:37:45AM +0800, Hyman Huang wrote:
> Provide the "detached-mode" option for detached LUKS header
> formatting.
> 
> To format the LUKS header on the pre-creating disk, example
> as follows:
> 
> 1. add a protocol blockdev node of LUKS header
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> > "filename":"/path/to/cipher.gluks" }}'
> 
> 2. add the secret for encrypting the cipher stored in LUKS
>    header above
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > "arguments":{"qom-type": "secret", "id":
> > "libvirt-1-storage-secret0", "data": "abc123"}}'
> 
> 3. format the disk node
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > "arguments":{"job-id":"job0", "options":{"driver":"luks",
> > "size":0, "file":"libvirt-1-storage", "detached-mode":true,
> > "cipher-alg":"aes-256",
> > "key-secret":"libvirt-3-storage-encryption-secret0"}}}'
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  block/crypto.c       | 8 +++++++-
>  qapi/block-core.json | 5 ++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 7d70349463..e77c49bd0c 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -667,10 +667,12 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>      BlockDriverState *bs = NULL;
>      QCryptoBlockCreateOptions create_opts;
>      PreallocMode preallocation = PREALLOC_MODE_OFF;
> +    int64_t size;
>      int ret;
>  
>      assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
>      luks_opts = &create_options->u.luks;
> +    size = luks_opts->size;
>  
>      bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
>      if (bs == NULL) {
> @@ -686,7 +688,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>          preallocation = luks_opts->preallocation;
>      }
>  
> -    ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
> +    if (luks_opts->detached_mode) {
> +        size = 0;
> +    }
> +
> +    ret = block_crypto_co_create_generic(bs, size, &create_opts,
>                                           preallocation, errp);
>      if (ret < 0) {
>          goto fail;
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 10be08d08f..1e7a7e1b05 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4952,13 +4952,16 @@
>  # @preallocation: Preallocation mode for the new image (since: 4.2)
>  #     (default: off; allowed values: off, metadata, falloc, full)
>  #
> +# @detached-mode: create a detached LUKS header. (since 9.0)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsLUKS',
>    'base': 'QCryptoBlockCreateOptionsLUKS',
>    'data': { 'file':             'BlockdevRef',
>              'size':             'size',
> -            '*preallocation':   'PreallocMode' } }
> +            '*preallocation':   'PreallocMode',
> +            '*detached-mode':   'bool'}}

Using a bool flag here is insufficiently flexible. We need to be able to
honour preallocation of the payload device, while using a separate
header.

You need to make the existing 'file' optional, while also adding an
extra optional 'header' field. ie

  { 'struct': 'BlockdevCreateOptionsLUKS',
    'base': 'QCryptoBlockCreateOptionsLUKS',
    'data': { '*file':            'BlockdevRef',
              '*header':          'BlockdevRef',
              'size':             'size',
              '*preallocation':   'PreallocMode' } }


If 'preallocation' is requested, then we must enforce that 'file' is
non-NULL in the code.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


