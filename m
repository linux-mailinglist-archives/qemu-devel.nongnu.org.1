Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E690F82B13B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:00:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwWL-0000YX-0J; Thu, 11 Jan 2024 09:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNwWI-0000Y7-FZ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNwWC-0003U7-3H
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704985129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPvY8hHnlKKCrzTLw/MTSFkuwnTALP0XhujwZy0yRm8=;
 b=GfJony6S58WMeeM3WEcEsP5BqEk0kjrukXXhQCPHw9sjCRlTL9Bnfy+jwNSjAwKXWp+qDM
 45aLAopZI5j3O5kNa2Eb7hSGndP3cpV9b+eoUNHjSo5f0AnSOSy5pvZuQjxvmzq9QzqljP
 s+xfDOWaZvNTLkrC3Q3iWdQwK36DWg8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Qiwid2qUPDW5VzDdo5gaWQ-1; Thu, 11 Jan 2024 09:58:45 -0500
X-MC-Unique: Qiwid2qUPDW5VzDdo5gaWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BF3E108C0A4;
 Thu, 11 Jan 2024 14:58:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2584A3C25;
 Thu, 11 Jan 2024 14:58:44 +0000 (UTC)
Date: Thu, 11 Jan 2024 14:58:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v3 01/10] crypto: Introduce option and structure
 for detached LUKS header
Message-ID: <ZaACIZlPRnJidSE_@redhat.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
 <a34c12048198cea06d5d1a69a3fa8b76ab13cbba.1703482349.git.yong.huang@smartx.com>
 <87h6jkuee9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6jkuee9.fsf@pond.sub.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 11, 2024 at 03:35:10PM +0100, Markus Armbruster wrote:
> Hyman Huang <yong.huang@smartx.com> writes:
> 
> > Add the "header" option for the LUKS format. This field would be
> > used to identify the blockdev's position where a detachable LUKS
> > header is stored.
> >
> > In addition, introduce header field in struct BlockCrypto
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-Id: <5b99f60c7317092a563d7ca3fb4b414197015eb2.1701879996.git.yong.huang@smartx.com>
> > ---
> >  block/crypto.c       | 1 +
> >  qapi/block-core.json | 6 +++++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 921933a5e5..f82b13d32b 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;
> >  struct BlockCrypto {
> >      QCryptoBlock *block;
> >      bool updating_keys;
> > +    BdrvChild *header;  /* Reference to the detached LUKS header */
> >  };
> >  
> >  
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index ca390c5700..10be08d08f 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3352,11 +3352,15 @@
> >  #     decryption key (since 2.6). Mandatory except when doing a
> >  #     metadata-only probe of the image.
> >  #
> > +# @header: optional reference to the location of a blockdev
> > +#     storing a detached LUKS header. (since 9.0)
> 
> This will come out like
> 
>     "header": "BlockdevRef" (optional)
>        optional reference to the location of a blockdev storing a detached
>        LUKS header. (since 9.0)
> 
> in the manual.  Scratch "optional".
> 
> Moreover, a BlockdevRef is a "Reference to a block device" (quote from
> its doc comment), not a "reference to the location of a blockdev".
> Better simplify to something like "block device holding a detached LUKS
> header".
> 
> But that's just phrasing.  The contents could perhaps use improvement,
> too.  Let's start with this question: what's a detachable LUKS header,
> and why would anybody want to use it?

Normally a LUKS volume has a layout:

  disk:  | header | key material | disk payload data |

With a detached LUKS header, you need 2 disks so getting

  disk1:  | header | key material |
  disk2:  | disk payload data |

There are a variety of reasons to do this

 * Secrecy - the disk2 cannot be identified as containing LUKS volume
             since there's no header

 * Control - if access to the disk1 is restricted, then even if someone
             has access to disk2 they can't unlock it. Might be useful
	     if you have disks on NFS but want to restrict which host
	     can launch a VM instance from it, by dynamically providing
	     access to the header to a designated host

 * Flexibility - your application data volume may be a given size and
                 it is inconvenient to resize it to add encryption.
		 You can store the LUKS header separately and use
		 the existing storage volume for payload

 * Recovery - corruption of a bit in the header may make the entire
              payload inaccessible. It might be convenient to take
	      backups of the header. If your primary disk header
	      becomes corrupt, you can unlock the data still by
	      pointing to the backup detached header.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


