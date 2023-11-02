Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 735427DF06C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:44:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVAi-00036b-39; Thu, 02 Nov 2023 06:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyVAg-00035w-94
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qyVAe-0003Ze-CU
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698921807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cD74fjOyUcW9h2vQKi01IRfuj9mPjcg3Re+fA6quSDc=;
 b=RNfBY0k1II3ymGnJnAqabSLD/NxWLxEVwuFz1GtN9rguZJYTUM+LxzurOnDQsXqJ+xRhFW
 JLUC4Nn28xU/zhRUabld78E+iTUTHgOob2EFUQrxSQQbbdXoyXSik8k8AqeOgMLElMbP1D
 24Wi7MZy6vjsQMf967Q7GkiiNGxdfCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-AO_d-_YiMxiL6wlkkMCWng-1; Thu,
 02 Nov 2023 06:43:24 -0400
X-MC-Unique: AO_d-_YiMxiL6wlkkMCWng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 209C0280C294;
 Thu,  2 Nov 2023 10:43:24 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDEAC40C6EBC;
 Thu,  2 Nov 2023 10:43:22 +0000 (UTC)
Date: Thu, 2 Nov 2023 11:43:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: -drive if=none: can't we make this the default?
Message-ID: <ZUN9SZ6VkvLHWNXs@redhat.com>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
 <ZUFK/BHG2WMhAiWG@redhat.com>
 <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 01.11.2023 um 12:21 hat Peter Maydell geschrieben:
> On Tue, 31 Oct 2023 at 18:45, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 16.10.2023 um 13:58 hat Michael Tokarev geschrieben:
> > > Almost everyone mentions -blockdev as a replacement for -drive.
> >
> > More specifically for -drive if=none. I honestly don't know many common
> > use cases for that one.
> 
> One use case for it is "create a drive with a qcow2 backend to use
> for -snapshot snapshots, but don't plug it into anything". See
> https://translatedcode.wordpress.com/2015/07/06/tricks-for-debugging-qemu-savevm-snapshots/
> I dunno whether that counts as "common", though :-)

Ok, I was already wondering what good -snapshot was for an image that
isn't even used, but what the article describes is actually not using
-snapshot, but internal snapshots with savevm/loadvm, i.e. using the
image to store the VM state.

This actually makes a lot of sense for if=none, as one of the few cases
where "none" accurately tells what device it will be used with.

> > For management tools, -blockdev is indeed what should be used, and that
> > things are more explicit there is actually a feature, not a bug, for
> > management tools.
> >
> > As a human user, in the common case where I don't care about the
> > details, I don't want to type up an explicit -device. if=virtio gives me
> > more directly what I want.
> 
> I can never remember if if=virtio is going to give me virtio-pci or
> virtio-mmio, so my scripts all explicitly create a drive with "-drive if=none"
> and a virtio-blk-pci device with "-device". I don't much mind being a
> bit long-winded in a script file.

This makes me think that if=virtio-pci/virtio-mmio would make sense.
Maybe even more generally if=<qdev-device-name> as long as it is a block
device and therefore has a 'drive' property?

if=virtio already gets translated into a -device option internally
anyway, so doing this for more device names shouldn't be that bad.

> > So you only need it when you want to specify one of the more exotic
> > -device options, which shouldn't happen that often. Well, it doesn't for
> > me anyway, other people may have other use cases. Is that your case? If
> > so, which options do you usually want to give to -device?
> >
> > > But I have to remind several issues with it:
> > >
> > > 1. While documentation has improved a lot, -blockdev is still mostly unknown
> > >    to the masses.
> >
> > And for manual human use, that's okay anyway - you probably don't want
> > to use it. But if you're writing scripts or even advanced management
> > software, then you should use it.
> >
> > (Of course, in complex cases you may have to use it manually anyway
> > because -drive has some limitations, but that should be the absolute
> > exception.)
> >
> > > 2. -blockdev is just too verbose, one have to specify a lot of parameters just to
> > >    do a simple thing which is solved with an extra parameter with -drive.
> > >    Including various backing stores/chains for qcow2 files - this is terrible for
> > >    using things manually from command line
> >
> > You don't have to specify the backing chain explicitly if you're happy
> > with the default options with which the backing files are opened.
> >
> > -blockdev options are typically a bit longer than -drive ones, but not
> > extremely. The separate -device that if=none gives you is already a
> > similar amount of extra typing.
> >
> > -drive if=virtio,file=test.qcow2
> > -drive if=none,file=test.qcow2,id=disk -device virtio-blk,drive=disk
> > -blockdev qcow2,file.driver=file,file.filename=test.qcow2,node-name=disk -device virtio-blk,drive=disk
> 
> How did -blockdev end up with a different syntax for specifying the
> ID of the drive (i.e. "node-name=foo" rather than "id=foo")
> than everything else uses?

I don't remember the details, but I believe this is historical baggage
from -drive, which already used "id" for the BlockBackend (i.e. the
whole block tree attached to a device), and then "node-name" was added
for the BlockDriverState (the individual nodes in the tree).

When later -blockdev came around and only defined nodes rather than
whole trees, "node-name" was already there and doing the right thing.

> > > 3. -blockdev does not work with -snapshot
> > >
> > > 4. Something else I forgot while typing all the above :)
> > >
> > > In my view, -blockdev is not a substitute for -drive, not at all, and it is
> > > very user-unfriendly.  This is why -drive seems to be a good trade-off between
> > > things like -hda (which is just too simplistic) and -blockdev which which is
> > > way too verbose and lacks some automatic sugar like -snapshot.
> >
> > I would agree with that, but if=none already feels a bit unfriendly.
> >
> > Honestly, I would like to throw away the existing -drive and replace it
> > with one that has a simpler implementation (as a wrapper around
> > -blockdev) and I would be happy if it gained some additional options for
> > passing through things to -device so that you don't have to bother with
> > if=none even in the more complex cases any more.
> >
> > It would be pure syntactic sugar with a similar compatibility promise as
> > in HMP (we won't break it just for fun, but we'll also not stop making
> > sensible changes just because they make things look a bit different).
> 
> You really need to make -blockdev work with -snapshot first, though.
> Pretty much none of my use cases will ever switch over to it until
> that happens.

-snapshot doesn't really make sense for -blockdev, because -blockdev
defines a single node and -snapshot implies creating a temporary overlay
which brings in two additional nodes. But the new -drive should of
course still support that. It would just translate into multiple
-blockdevs.

> Also, you can't arbitrarily change the command-line compat
> requirements because of how you've chosen to (re-)implement an
> option. That doesn't mean the current syntax is set in stone, but
> I'm pretty sure the command line isn't at the HMP "we can change
> it without deprecation" level of compat promises.

That's why we haven't done it yet, but I do think we need to change the
compat requirements for -drive before we can move on and improve its
state. Of course, there is a need for a stable interface for management
tools, but for defining block device backends, that's -blockdev and not
-drive.

The problem with -drive is that it has grown organically for so long
that nobody really understands what it's doing in detail. I can do a 90%
(or more) compatible reimplementation of it, but the problem is that I
can't tell what the remaining 10% consist of, so I can't explicitly
deprecate that functionality before doing the rewrite.

The other option would be introducing another high level option like
-disk and deprecating -drive wholesale, but I don't think that would
actually improve things for anyone. It would make the transition process
more standard, but also much more painful because it breaks the 90%,
too.

Kevin


