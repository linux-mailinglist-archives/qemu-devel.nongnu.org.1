Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 396FD816C03
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:17:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBbS-0007G7-0E; Mon, 18 Dec 2023 06:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBbP-0007E9-TA
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rFBbN-0008KZ-JW
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702898159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VlUJMFwfOIGXf+QKG8uNUqRNMZ5o+20zPqE/F+VwNRk=;
 b=JpPPWPm7HxR8W7/AT3mLrdx1cS656ZuNhvFsXqKwjDHhNmJpT7WV+LOMSyjoV920AOktAZ
 HZ6FkCZ7r8DoRVfqhV1AMW7WxbO2CKw3Wi6cug6rjLpCPxdLIvtXzko8OmHBsmPua0Jwkj
 3QbU5s/7VwjnnKfSYkMRSbtMzaWpp+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-KVeFDXmmNdqNx99tHMGUnQ-1; Mon, 18 Dec 2023 06:15:58 -0500
X-MC-Unique: KVeFDXmmNdqNx99tHMGUnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD149863B86;
 Mon, 18 Dec 2023 11:15:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 826EC51D5;
 Mon, 18 Dec 2023 11:15:56 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:15:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [v2 3/4] crypto: Support generic LUKS encryption
Message-ID: <ZYAp6kxCXgV749j2@redhat.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
 <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

On Thu, Dec 07, 2023 at 12:37:44AM +0800, Hyman Huang wrote:
> By enhancing the LUKS driver, it is possible to enable
> the detachable LUKS header and, as a result, achieve
> general encryption for any disk format that QEMU has
> supported.
> 
> Take the qcow2 as an example, the usage of the generic
> LUKS encryption as follows:
> 
> 1. add a protocol blockdev node of data disk
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> > "filename":"/path/to/test_disk.qcow2"}}'
> 
> 2. add a protocol blockdev node of LUKS header as above.
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> > "filename": "/path/to/cipher.gluks" }}'
> 
> 3. add the secret for decrypting the cipher stored in LUKS
>    header above
> $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > "arguments":{"qom-type":"secret", "id":
> > "libvirt-2-storage-secret0", "data":"abc123"}}'
> 
> 4. add the qcow2-drived blockdev format node
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-1-format", "driver":"qcow2",
> > "file":"libvirt-1-storage"}}'
> 
> 5. add the luks-drived blockdev to link the qcow2 disk with
>    LUKS header by specifying the field "header"
> $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> > "file":"libvirt-1-format", "header":"libvirt-2-storage",
> > "key-secret":"libvirt-2-format-secret0"}}'
> 
> 6. add the virtio-blk device finally
> $ virsh qemu-monitor-command vm '{"execute":"device_add",
> > "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> > "drive": "libvirt-2-format", "id":"virtio-disk2"}}'
> 
> The generic LUKS encryption method of starting a virtual
> machine (VM) is somewhat similar to hot-plug in that both
> maintaining the same json command while the starting VM
> changes the "blockdev-add/device_add" parameters to
> "blockdev/device".
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  block/crypto.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index f82b13d32b..7d70349463 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -40,6 +40,7 @@ struct BlockCrypto {
>      QCryptoBlock *block;
>      bool updating_keys;
>      BdrvChild *header;  /* Reference to the detached LUKS header */
> +    bool detached_mode; /* If true, LUKS plays a detached header role */
>  };
>  
>  
> @@ -64,12 +65,16 @@ static int block_crypto_read_func(QCryptoBlock *block,
>                                    Error **errp)
>  {
>      BlockDriverState *bs = opaque;
> +    BlockCrypto *crypto = bs->opaque;
>      ssize_t ret;
>  
>      GLOBAL_STATE_CODE();
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> -    ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
> +    if (crypto->detached_mode)
> +        ret = bdrv_pread(crypto->header, offset, buflen, buf, 0);
> +    else
> +        ret = bdrv_pread(bs->file, offset, buflen, buf, 0);

This can be simplified to:

    ret = bdrv_pread(bs->header ? bs->header : file, offset, buflen, buf, 0);

>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Could not read encryption header");
>          return ret;
> @@ -269,6 +274,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>      QCryptoBlockOpenOptions *open_opts = NULL;
>      unsigned int cflags = 0;
>      QDict *cryptoopts = NULL;
> +    const char *header_bdref =
> +        qdict_get_try_str(options, "header");
>  
>      GLOBAL_STATE_CODE();
>  
> @@ -277,6 +284,16 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>          return ret;
>      }
>  
> +    if (header_bdref) {
> +        crypto->detached_mode = true;

Drop this flag since it has no benefit.

> +        crypto->header = bdrv_open_child(NULL, options, "header", bs,
> +                                         &child_of_bds, BDRV_CHILD_METADATA,
> +                                         false, errp);
> +        if (!crypto->header) {
> +            return -EINVAL;
> +        }
> +    }
> +
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
>      bs->supported_write_flags = BDRV_REQ_FUA &
> @@ -312,6 +329,14 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>          goto cleanup;
>      }
>  
> +    if (crypto->detached_mode) {

  if (crypto->header != NULL)

> +        /*
> +         * Set payload offset to zero as the file bdref has no LUKS
> +         * header under detached mode.
> +         */
> +        qcrypto_block_set_payload_offset(crypto->block, 0);

The LUKS header stores the payload offset.  If someone creates the LUKS
volume with a detached header, they may still choose to put the payload
at a non-zero offset.

So AFAICT, we should always honour the payload offset from the header,
even when detached.   When formatting the header, we should default to
a zero offset though

> +    }
> +
>      bs->encrypted = true;
>  
>      ret = 0;
> @@ -903,6 +928,17 @@ block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
>  
>      BlockCrypto *crypto = bs->opaque;
>  
> +    if (role == (role & BDRV_CHILD_METADATA)) {
> +        /* Assign read permission only */
> +        perm |= BLK_PERM_CONSISTENT_READ;
> +        /* Share all permissions */
> +        shared |= BLK_PERM_ALL;
> +
> +        *nperm = perm;
> +        *nshared = shared;
> +        return;
> +    }

What is code doing ?  You've set  BDRV_CHILD_METADATA role on the
crypto->header  object, but how does this block_crypto_child_perms
method get run against crypto->header ? 

> +
>      bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
>  
>      /*
> -- 
> 2.39.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


