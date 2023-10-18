Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A77CDFF9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7cc-0008SQ-Po; Wed, 18 Oct 2023 10:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1qt7cX-0008Mx-37; Wed, 18 Oct 2023 10:34:01 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1qt7cV-0008VO-1X; Wed, 18 Oct 2023 10:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4av8QNV4tVroMlLYxeUZim18cwUW3pZBcX7BnarRVk=; b=cobQLwKbjKOkz48O6+5FKoT/Ah
 fG+Iq7qSscCbxGnhyx8hAWM+s59dncbmiUUNJ31KFb7+77n5z2tPq+JdhLSeCF2Gn1PRh7ugOeXqK
 TxtO7EIAxhdh5kI/2VWtzu6Lsq8LGCiBPkRoLuO4pa5EY6vDfXEDA0nA6C8daZgFS/Ku4ep7CDU62
 R3oeqx8cr+HP+r3qBKRY0Rl8A7cLaIxyeVJD+A9cOzDcwfol8EorlDkBQALl4BfmzZKZI/MGI7rGe
 vbkdLAJBDqlvlot/W96Ag460Ero2ERekqIQsDLJ1T5Iydh+xpS6KKyWoyxIPxnMvr4HxwEqJHDhWo
 WceXq33g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1qt7cP-005Hdo-1v;
 Wed, 18 Oct 2023 14:33:53 +0000
Date: Wed, 18 Oct 2023 14:33:53 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 eduardo@habkost.net, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, raphael.norwitz@nutanix.com,
 yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru,
 daniil.tatianin@yandex.ru
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
Message-ID: <ZS_s0RE0ES9mvFar@gallifrey>
References: <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
 <877cnkzasr.fsf@pond.sub.org>
 <a55e8b57-3411-4587-affd-3bc0635af4fe@yandex-team.ru>
 <878r80tdyd.fsf@pond.sub.org>
 <20231018064912-mutt-send-email-mst@kernel.org>
 <ZS+6g+vtYz9Uh6G3@redhat.com> <87o7gwp29r.fsf@pond.sub.org>
 <ZS/KhowbXegXtYxA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS/KhowbXegXtYxA@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 14:32:53 up 32 days, 17:31, 1 user, load average: 0.03, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Wed, Oct 18, 2023 at 02:02:08PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Wed, Oct 18, 2023 at 06:51:41AM -0400, Michael S. Tsirkin wrote:
> > >> On Wed, Oct 18, 2023 at 12:36:10PM +0200, Markus Armbruster wrote:
> > >> > > x- seems safer for management tool that doesn't know about "unstable" properties..
> > >> > 
> > >> > Easy, traditional, and unreliable :)
> > >> 
> > >> > > But on the other hand, changing from x- to no-prefix is already
> > >> > > done when the feature is stable, and thouse who use it already
> > >> > > use the latest version of interface, so, removing the prefix is
> > >> > > just extra work.
> > >> > 
> > >> > Exactly.
> > >> > 
> > >> 
> > >> I think "x-" is still better for command line use of properties - we
> > >> don't have an API to mark things unstable there, do we?
> > >
> > > Personally I like to see "x-" prefix present *everywhere* there is
> > > an unstable feature, and consider the need to rename when declaring
> > > it stable to be good thing as it sets an easily identifiable line
> > > in the sand and is self-evident to outside observers.
> > >
> > > The self-documenting nature of the "x-" prefer is what makes it most
> > > compelling to me. A patch submission, or command line invokation or
> > > an example QMP command, or a bug report, that exhibit an 'x-' prefix
> > > are an immediate red flag to anyone who sees them.
> > 
> > Except when it isn't, like in "x-origin".
> > 
> > > If someone sees a QMP comamnd / a typical giant QEMU command line,
> > > they are never going to go look at the QAPI schema to check whether
> > > any feature used had an 'unstable' marker. The 'unstable' marker
> > > might as well not exist in most cases.
> > >
> > > IOW, having the 'unstable' flag in the QAPI schema is great for machine
> > > introspection, but it isn't a substitute for having an 'x-' prefix used
> > > for the benefit of humans IMHO.
> > 
> > I'm not sure there's disagreement.  Quoting myself:
> > 
> >     The "x-" can remind humans "this is unstable" better than a feature
> >     flag can (for machines, it's the other way round).
> > 
> > CLI and HMP are for humans.  We continue to use "x-" there.
> > 
> > QMP is for machines.  The feature flag is the sole source of truth.
> > Additional use of "x-" is fine, but not required.
> 
> I guess we have different defintions of "for humans" in this context.
> I consider QMP  data still relevant for humans, because humans are
> reviewing patches to libvirt that add usage of QMP features, or
> triaging bug reports that include examples of usage, and in both
> cases it is pretty relevant to make unstable features stand out to
> the human via the x- prefix IMHO.

Using x- for events makes sense to me; the semantics of events can be
quite subtle; often you don't find out how broken they are until you
wire them through libvirt and up the stack; so it's not impossible
you might need to change it - but then without the x- the semantics
(rather than existence) of the event is carved in stone.

Dave

> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

