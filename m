Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B010824403
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:42:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOtZ-0001Kp-GU; Thu, 04 Jan 2024 09:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLOtX-0001Ke-0g
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:40:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLOtU-0003O9-Oy
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704379222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6M1GXN24dXumGU/wF2bbwyj+P6/zcn2LiicRTi12H1A=;
 b=AbyvZACSiVawmjHDBGTXjliYQxDKFXfyxgKG9Y3dADZxSOY/tzPAxSdWdWB52E+31g3GsQ
 EHb7z+XQ7KfEbw24Z6NqTYraRJn9gFIutke0ONo55ZdEKbvq/y9xrI//SF6he2BmiaQGTN
 bBjhhSPoYqFVeJ9T5MQAVSHjS9pKY98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-a451jZF5NHiUtlOXU1_5zA-1; Thu, 04 Jan 2024 09:39:38 -0500
X-MC-Unique: a451jZF5NHiUtlOXU1_5zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6A23837227;
 Thu,  4 Jan 2024 14:39:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 715BB5190;
 Thu,  4 Jan 2024 14:39:36 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:39:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RESEND v3 02/10] crypto: Support generic LUKS encryption
Message-ID: <ZZbDJSgyfQJ9NF8f@redhat.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
 <c55f6e98595c654d17c16a569422bec5c03ddaa0.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c55f6e98595c654d17c16a569422bec5c03ddaa0.1703482349.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 25, 2023 at 01:45:04PM +0800, Hyman Huang wrote:
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
> Message-Id: <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
> ---
>  block/crypto.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index f82b13d32b..6063879bac 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -64,12 +64,14 @@ static int block_crypto_read_func(QCryptoBlock *block,
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
> +    ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
> +                     offset, buflen, buf, 0);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Could not read encryption header");
>          return ret;
> @@ -269,6 +271,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>      QCryptoBlockOpenOptions *open_opts = NULL;
>      unsigned int cflags = 0;
>      QDict *cryptoopts = NULL;
> +    const char *hdr_bdref = qdict_get_try_str(options, "header");

This is an invalid check to make, because it is assuming the user is
referencing a separate blockdev node name and doesn't work for an
inline definition. eg

  qemu-img info  'json:{"driver":"luks","file":{"filename":"test-payload.img"},"header":{"filename":"test-header.img"}}'


>  
>      GLOBAL_STATE_CODE();
>  
> @@ -277,6 +280,15 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>          return ret;
>      }
>  
> +    if (hdr_bdref) {

Get rid of this 'if' clause and unconditionally call the next line:

> +        crypto->header = bdrv_open_child(NULL, options, "header", bs,
> +                                         &child_of_bds, BDRV_CHILD_METADATA,
> +                                         false, errp);

but pass 'true' instead of 'false' here to allow the child to be absent,
and thus let it return NULL.

> +        if (!crypto->header) {

You'll need to then check  '*errp != NULL' instead

You'll also need "ERRP_GUARD" at the start of the method

> +            return -EINVAL;
> +        }
> +    }
> +
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
>      bs->supported_write_flags = BDRV_REQ_FUA &

This patch should be combined with the previous patch that adds the new
QAPI schema element as splitting them doesn't add value.


Testing this patch with the changes I suggest above, however, still does
not work:

  $ dd if=/dev/zero of=test-header.img bs=1M count=32
  $ dd if=/dev/zero of=test-payload.img bs=1M count=1000
  $ cryptsetup luksFormat  --header test-header.img test-payload.img  --force-password --type luks1
  $ qemu-img info  'json:{"driver":"luks","file":{"filename":"test-payload.img"},"header":{"filename":"test-header.img"}}'
  qemu-img: Could not open 'json:{"driver":"luks","file":{"filename":"test-payload.img"},"header":{"filename":"test-header.img"}}': LUKS payload is overlapping with the header


You need to pass some info into qcrypto_block_open to tell it that the
header is detached. Add a new enum entry to QCryptoBlockOpenFlags
perhaps.  Then skip the LUKS payload overlap check.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


