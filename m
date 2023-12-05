Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78E8052DA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 12:29:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rATak-0003K2-PG; Tue, 05 Dec 2023 06:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rATai-0003Ju-CP
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 06:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rATaf-0001OV-E1
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 06:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701775668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2r/n5CpfyKDLfziwPO4YQCwDHtClpe4nHlkcAO9AzM=;
 b=cHNCOo6hx7ltwW6Ev9FNAKPKmOYAY99rXN/CwGl02tzIZrxSR4xaRQHwBZyytfY/Jmt9fu
 eIpyd4hApCIQEBCgBENRvZC96ozaLWFIWX8TYmeNtlGnzpPHJjkNDI1gSbAPk3phBo67A9
 ui/1cgTHbKbYYBsO0fUb/I+hLCrPzfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-bn80hu2XMce0cNSHDSQIHQ-1; Tue, 05 Dec 2023 06:27:43 -0500
X-MC-Unique: bn80hu2XMce0cNSHDSQIHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A044101A52A;
 Tue,  5 Dec 2023 11:27:43 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0D3C15968;
 Tue,  5 Dec 2023 11:27:42 +0000 (UTC)
Date: Tue, 5 Dec 2023 12:27:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC 0/8] Support generic Luks encryption
Message-ID: <ZW8JLedv5H6Dp9iK@redhat.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
 <ZW39KzXUbWrJUdQH@redhat.com>
 <CAK9dgmapfxO93ZMSiw+aT6E1XLLrs+sXXprwCxgB8egeznsLBQ@mail.gmail.com>
 <ZW4Dm2TI9d4XBDtT@redhat.com>
 <CAK9dgmZ75OBDCNi-oMm-FKfzmfSo116dqYKi9PJucZa9DbSu8A@mail.gmail.com>
 <ZW4P20Ib7vJZW77V@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW4P20Ib7vJZW77V@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 04.12.2023 um 18:43 hat Daniel P. Berrangé geschrieben:
> On Tue, Dec 05, 2023 at 01:32:51AM +0800, Yong Huang wrote:
> > On Tue, Dec 5, 2023 at 12:51 AM Daniel P. Berrangé <berrange@redhat.com>
> > wrote:
> > 
> > > On Tue, Dec 05, 2023 at 12:41:16AM +0800, Yong Huang wrote:
> > > > On Tue, Dec 5, 2023 at 12:24 AM Daniel P. Berrangé <berrange@redhat.com>
> > > > wrote:
> > > >
> > > > > On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:
> > > > > > This functionality was motivated by the following to-do list seen
> > > > > > in crypto documents:
> > > > > > https://wiki.qemu.org/Features/Block/Crypto
> > > > > >
> > > > > > The last chapter says we should "separate header volume":
> > > > > >
> > > > > > The LUKS format has ability to store the header in a separate volume
> > > > > > from the payload. We should extend the LUKS driver in QEMU to support
> > > > > > this use case.
> > > > > >
> > > > > > As a proof-of-concept, I've created this patchset, which I've named
> > > > > > the Gluks: generic luks. As their name suggests, they offer
> > > encryption
> > > > > > for any format that QEMU theoretically supports.
> > > > >
> > > > > I don't see the point in creating a new driver.
> > > > >
> > > > > I would expect detached header support to be implemented via an
> > > > > optional new 'header' field in the existing driver. ie
> > > > >
> > > > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > > index ca390c5700..48d1f2a974 100644
> > > > > --- a/qapi/block-core.json
> > > > > +++ b/qapi/block-core.json
> > > > > @@ -3352,11 +3352,15 @@
> > > > >  #     decryption key (since 2.6). Mandatory except when doing a
> > > > >  #     metadata-only probe of the image.
> > > > >  #
> > > > > +# @header: optional reference to the location of a blockdev
> > > > > +#     storing a detached LUKS heaer
> > > > > +#
> > > > >  # Since: 2.9
> > > > >  ##
> > > > >  { 'struct': 'BlockdevOptionsLUKS',
> > > > >    'base': 'BlockdevOptionsGenericFormat',
> > > > > -  'data': { '*key-secret': 'str' } }
> > > > > +  'data': { '*key-secret': 'str',
> > > > > +            "*header-file': 'BlockdevRef'} }
> > > > >
> > > > >  ##
> > > > >  # @BlockdevOptionsGenericCOWFormat:
> > > > > @@ -4941,9 +4945,18 @@
> > > > >  #
> > > > >  # Driver specific image creation options for LUKS.
> > > > >  #
> > > > > -# @file: Node to create the image format on
> > > > > +# @file: Node to create the image format on. Mandatory
> > > > > +#     unless a detached header file is specified using
> > > > > +#     @header.
> > > > >  #
> > > > > -# @size: Size of the virtual disk in bytes
> > > > > +# @size: Size of the virtual disk in bytes.  Mandatory
> > > > > +#     unless a detached header file is specified using
> > > > > +#     @header.
> > > > > +#
> > > > > +# @header: optional reference to the location of a blockdev
> > > > > +#     storing a detached LUKS heaer. The @file option is
> > > > > +#     is optional when this is given, unless it is desired
> > > > > +#     to perform pre-allocation
> > > > >  #
> > > > >  # @preallocation: Preallocation mode for the new image (since: 4.2)
> > > > >  #     (default: off; allowed values: off, metadata, falloc, full)
> > > > > @@ -4952,8 +4965,9 @@
> > > > >  ##
> > > > >  { 'struct': 'BlockdevCreateOptionsLUKS',
> > > > >    'base': 'QCryptoBlockCreateOptionsLUKS',
> > > > > -  'data': { 'file':             'BlockdevRef',
> > > > > -            'size':             'size',
> > > > > +  'data': { '*file':            'BlockdevRef',
> > > > > +            '*size':            'size',
> > > > > +            '*header':          'BlockdevRef'
> > > > >              '*preallocation':   'PreallocMode' } }
> > > > >
> > > > >  ##
> > > > >
> > > > > It ends up giving basicallly the same workflow as you outline,
> > > > > without needing the new block driver
> > > > >
> > > >
> > > > How about the design and usage, could it be simpler? Any advice? :)
> > > >
> > > >
> > > > As you can see below, the Gluks format block layer driver's design is
> > > > quite simple.
> > > >
> > > >          virtio-blk/vhost-user-blk...(front-end device)
> > > >               ^
> > > >               |
> > > >              Gluks   (format-like disk node)
> > > >           /         \
> > > >        file       header (blockdev reference)
> > > >         /             \
> > > >      file            file (protocol node)
> > > >        |               |
> > > >    disk data       Luks data
> > >
> > > What I suggested above ends up with the exact same block driver
> > > graph, unless I'm missing something.
> > >
> > 
> > I could overlook something or fail to adequately convey the goal of the
> > patchset. :(
> > 
> > Indeed, utilizing the same block driver might be effective if our only goal
> > is to divide the header volume, giving us an additional way to use Luks.
> > 
> > While supporting encryption for any disk format that QEMU is capable of
> > supporting is another feature of this patchset. This implies that we might
> > link the Luks header to other blockdev references, which might alter how
> > the Luks are used and make them incompatible with it. It's not
> > user-friendly in my opinion, and I'm not aware of a more elegant solution.
> 
> That existing LUKS driver can already be used in combination with
> any QEMU block driver, and in the case of disk formats, can be used
> either above or below the format, depending on whether you want to
> encrypt just the image payload, or the payload and metadata ie.
> 
> We can do
> 
>   luks -> qcow2 -> file    (qcow2 header and qcow2 payload protected)
> 
> or
> 
>   qcow2 -> luks -> file    (only qcow2 payload protected)

The other way around actually. If you want to have qcow2 metadata
encrypted, you need to put luks between qcow2 and file so that it sees
the metadata I/O done by the qcow2 driver. If you have luks above qcow2,
then qcow2 will see only encrypted data, but will access the metadata as
usual without going through encryption.

Kevin

> And in the qcow2 case, we also have support for LUKS integrated natively
> into the qcow2 format, which is similar to the 2nd case, with the
> benefit that we're explicit that the image requires encryption.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


