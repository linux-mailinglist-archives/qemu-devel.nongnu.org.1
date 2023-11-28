Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E007FC8F9
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 23:00:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r866a-0008JZ-Ky; Tue, 28 Nov 2023 16:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1r866X-0008Iz-FC
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 16:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1r866V-0006Do-J8
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 16:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701208729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G63JiulxV18c61Pse1oLaYsMlNDu9y3Ia+uC2IYzy5w=;
 b=GEt8tMNBZz0cV5FIl5rxZzU4lxMnBod4QGpUq6Bl2zT/yyvG47xL0e9WIVs4NsVL2D/WZp
 FQA8H3XdexJzD95CsHOnGBaZOU+pt6/SsNEXn03mTKXWMfrwondPuK6xKfC0EURBlTSIk0
 G1pwQl8aS4gwDgQAdwKsoxOQSS5YIpg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-P5cdyjCKOQeOIHAUceD3hQ-1; Tue,
 28 Nov 2023 16:58:46 -0500
X-MC-Unique: P5cdyjCKOQeOIHAUceD3hQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B0FE1C06E03;
 Tue, 28 Nov 2023 21:58:46 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 593A91C060AE;
 Tue, 28 Nov 2023 21:58:43 +0000 (UTC)
Date: Tue, 28 Nov 2023 22:58:41 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] block: commit: Allow users to request only format
 driver names in backing file format
Message-ID: <ZWZikXhpevsA2ik2@angien.pipo.sk>
References: <cover.1700837066.git.pkrempa@redhat.com>
 <8593619407b16a578896e1e9fcc77a18fe8d80fa.1700837066.git.pkrempa@redhat.com>
 <632957d1-219d-4bbb-a0fc-b510c8b936ca@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632957d1-219d-4bbb-a0fc-b510c8b936ca@yandex-team.ru>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 28, 2023 at 20:10:10 +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 24.11.23 17:52, Peter Krempa wrote:
> > Introduce a new flag 'backing_file_format_no_protocol' for the
> > block-commit QMP command which instructs the internals to use 'raw'
> > instead of the protocol driver in case when a image is used without a
> > dummy 'raw' wrapper.
> > 
> > The flag is designed such that it can be always asserted by management
> > tools even when there isn't any update to backing files.
> > 
> > The flag will be used by libvirt so that the backing images still
> > reference the proper format even when libvirt will stop using the dummy
> > raw driver (raw driver with no other config). Libvirt needs this so that
> > the images stay compatible with older libvirt versions which didn't
> > expect that a protocol driver name can appear in the backing file format
> > field.
> > 
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > ---

[...]

> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index ca390c5700..367e896905 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1810,6 +1810,14 @@
> >   #     Care should be taken when specifying the string, to specify a
> >   #     valid filename or protocol.  (Since 2.1)
> >   #
> > +# @backing-file-format-no-protocol: If true always use a 'format' driver name
> > +#     for the 'backing file format' field if updating the image header of the
> > +#     overlay of 'top'. Otherwise the real name of the driver of the backing
> > +#     image may be used which may be a protocol driver.
> > +#
> > +#     Can be used also when no image header will be updated.
> > +#     (default: false; since: 8.2)
> > +#
> 
> Hi Peter.

Hi,

Firstly to be honest, I consider the fact that qemu can put a protocol
driver into the header field named "backing file format" to be a bug.
After discussion with Kevin I understand the rationale of doing so, but
nevertheless, a backing protocol name is not a format and should have
had it's own header field.

> Hmm. Could this just be @backing-file-format ?

I don't really care too deeply about the name.

Calling it just @backing-file-format though would imply (as you write
below) that as argument the string to write into the metadata. More on
that below.

> As I understand, finally, that's just a string which we are going to put into qcow2 metadata.

Yes.

> And from qcow2 point of view, it's rather strange to set backing_file_format="raw" for backing image which is actually "qcow2".

Indeed, that would be wrong, but this is _NOT_ what this patch
actually does.

This patch ensures that only a *format* driver name is ever written to
the backing image. It overrides the fact that a *protocol* driver name
would be written into the field if the tail of the backing chain is a
raw image, which was instantiated in qemu without the dummy 'raw' driver
on top.

Since a raw driver with no configuration simply passes request to the
*protocol* driver below it it's not needed in most configs. In fact as
stefanha figured out a long time ago it's just simpy overhead.

We need a format name in the backing file format field as libvirt
assumed for a very long time that such a field would contain only format
drivers, and since I want to remove the overhead of the 'raw' driver I
need to ensure that images won't break for older libvirt.

>"raw" say nothing to the reader and may be even misleading. Same for qemu, this seems just a strange thing.
> 
> Also, what I dislike, that new feature sounds like hardcoded "raw" is the only format driver. If go this way, more honest name would be @backing-file-raw.

Once again, that is not what's happening here. The field enables that
only a *format* driver is used. This is only a problem when the final
image is raw, but without the dummy 'raw' driver on top of it. Thus
that's the reason the workaround only ever writes 'raw' into it.
Otherwise the proper format name is in the 'driver' field already and is
not overwritten.

> And, if we allow user to give any backing-file name to be written into qcow2 metadata after the operation, why not just allow to set any backing-file-name as well?

This IMO makes no sense to allow, but based on the reimagined design of
the 'backing file /format/' field it might appear that it does.

'block-commit' and 'block-stream, can't change the format of any of the
images, they simply move data, thus for any non-raw image in a chain it
must still use actual format name. Only place it makes sense is in the
same cases when the code in this patch triggers.

And then it still doesn't make sense to write anything besides:
1) The actual *format* of the image (thus 'raw')
2) The protocol driver of the last image (e.g. NBD)

But since 'block-stream'/'block-commit' don't move the image to any
other storage, allowing the user to write any other protocol also
doesn't make any sense to write any other protocol.

Thus the two cases above are the only sane, this patch allows that 1) is
written into the image.

> So, I think simple @backing-file-format argument, allowing to set any string as backing format is a better concept.

While libvirt certainly has the data to do so, as noted in the paragraph
above it doesn't IMO make sense to allow write any arbitrary driver name
there.

And with design like this it allows libvirt to unconditionally use the
flag without thinking too much about what is the correct value.

> Moreover: in BlockdevCreateOptionsQcow2 we have backing-file and backing-fmt options. So I think, we should follow this and name the new option for block-job @backing-fmt.

This is different, you are creating an image and declaring it's backing
image format. With 'block-stream' and 'block-commit' the format of the
backing image won't change, just data will be shuffled around. 


