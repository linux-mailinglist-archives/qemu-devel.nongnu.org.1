Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB07A1B59
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5W4-0002nP-OT; Fri, 15 Sep 2023 05:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qh5W2-0002mo-DL
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qh5W0-00041w-9d
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694771609;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vkErMAlS+1rCXq0S0/0Hf+yZ1sKTvwhnPIVGRsumAMQ=;
 b=Rp7s7DClgm6GsuDM97DCkYjuL33f4wWk2ed1fbaCBPRtWeXgP4Pk+9F5ikyyN6NBWfUe+/
 piUGqSY3ju0zb+V1CHDsaiA+K17knNMsdVnt701rhMDn1os3T3TSdYgwdGkG12Dr/A6Gbq
 fcRldjA+az19DOP8qx/v8ZDhvh3ZRsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-8bkGsAcEPHmIYTV1PqTTlA-1; Fri, 15 Sep 2023 05:53:27 -0400
X-MC-Unique: 8bkGsAcEPHmIYTV1PqTTlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 771FA101A550
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:53:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A19A52026D76;
 Fri, 15 Sep 2023 09:53:26 +0000 (UTC)
Date: Fri, 15 Sep 2023 10:53:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tyler Fanelli <tfanelli@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 stefanha@redhat.com
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
Message-ID: <ZQQplEOUE2GhBL07@redhat.com>
References: <20230914175835.382972-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914175835.382972-1-tfanelli@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Sep 14, 2023 at 01:58:27PM -0400, Tyler Fanelli wrote:
> These patches are submitted as an RFC mainly because I'm a relative
> newcomer to QEMU with no knowledge of the community's views on
> including Rust code, nor it's preference of using library APIs for
> ioctls that were previously implemented in QEMU directly.

We've talked about Rust alot, but thus far most focus has been on
areas peripheral to QEMU. Projects that might have been part of
QEMU in the past, and now being done as separate efforts, and
have bene taking advantage of Rust. eg virtiofsd Rust replacing
QEMU's in -tree C impl. eg passt providing an alternative to
slirp. eg the dbus display in QEMU allowing a remote display
frontend to be provided, written in rust. eg libblkio providing
a block backend in Rust.

The libblkio work is likely closest to what you've proposed
here, in that it is a Rust create exposed as a C shared library
for apps to consume. In theory apps don't need to care that it
is written in Rust, as it is opaque.

The one key difference though is that it was not replacing
existing functionality, it was adding a new feature. So users
who didn't have libblkio or whom want to avoid Rust dependancies
didn't loose anything they were already using.

If we use the libsev.so we create a hard dependancy on the Rust
sev crate, otherwise users loose the SEV feature in QEMU. Right
now the sev crate C library is not present in *any* distro that
I can see.

If we treat 'sev' as just another opaque 3rd party library to be
provided by the distro, this creates a problem. Our support
policy is that we usually won't drop features in existing distros,
but that is what would happen if we applied this patchset today.
We did bend that rule slightly with virtiofsd, but that was already
a separate binary and we followed our deprecation path before
deleting it, giving distros time to adapt.


If we rollback the curtain, however, and decide to expose Rust
directly to QEMU we could address this problem. We could bundle
the dependant Rust crates directly with QEMU tarballs, and
generate the FFI C library as part of QEMU build and static
link the library. Distros would not have todo anything, though
they could have the choice of dyn linking if they really wanted
to.

If we directly exposed the notion of Rust to QEMU, then we are
also not limited by whether a Rust crate provides a C FFI itself.
QEMU could provide C FFI glue for any Rust crate it sees as
useful to its code.

This all forces us, however, to have the difficult discussion
about whether we're willing to make Rust a mandatory dependancy
of QEMU and permit (or even welcome) its use /anywhere/ in the
QEMU tree that looks relevant.

We've already queried whether Rust will actually benefit the
core QEMU codebase, or whether we'll end up punching too many
holes in its safety net to make it worthwhile. My opinion is
that we probably shouldn't obsess over that as I think it is
hard to predict the future, it has a habit of surprising us.
Your patch series here doesn't demonstrate an obvious safety
benefit, since we have existing working code and that code is
not especially complex. Once we open the doors to Rust code
in QEMU though, we will probably surprise ourselves with the
range of benefits we'll see 2, 3, 5 years down the road.

IOW, we shouldn't judge future benefits based on this patch
series. It is great that this series is actually quite simple,
because it lets us focus on how we might integrate Rust more
directly into QEMU, without worrying much about the actual
code being replaced.

> This series looks to explore the possibility of using the library and
> show a bit of what it would look like. I'm looking for comments
> regarding if this feature is desired.

My summary, is that I'd personally be in favour of opening the door
to Rust code as a mandatory pre-requisite for QEMU, at the very least
for system emulators. Not because this particular series is compelling,
but because I think Rust could be more beneficial to QEMU over the long
term than we expect. In terms of consuming it though, if we're going
to replace existing QEMU functionality, then I think we need to bundle
the Rust code and natively integrate it into the build system, as we
have recently started doing with our python deps, to detach ourselves
from the limits of what distros ship.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


