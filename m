Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B420C798861
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:15:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecH4-0005RZ-PE; Fri, 08 Sep 2023 10:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qecGe-0005Pe-9k
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qecGY-0008Jy-5N
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOVh0VpdDOEADfSJ+6fxxexJcNTNzosQ8yiqG6vSLGQ=;
 b=T9OnmmkRWal7KZKS4qJ8f9xA07DjjKY9/FReer79rzxpX8g0A6uI16fXUsrK7v7dyLy5AT
 1KyezOW000XTX5yjxPau6rFt3p84rINCAZToBcPkx3W83BudRn0MVGqU+n/KT2i2tWVsGx
 DFg1cqxgzMxB3chGUlQg+/ChHrJkO6c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-7VOhEZYvPgSYkRt_3OWrUQ-1; Fri, 08 Sep 2023 10:15:18 -0400
X-MC-Unique: 7VOhEZYvPgSYkRt_3OWrUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DB3038157C8;
 Fri,  8 Sep 2023 14:15:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBAFD2026D2B;
 Fri,  8 Sep 2023 14:15:16 +0000 (UTC)
Date: Fri, 8 Sep 2023 15:15:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Net patches
Message-ID: <ZPsscpzj9fNtCEOY@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
 <CAJSP0QVf3CFf1zuBnQev-G54SiGZ53MWBj19SyH__19bo=vfWg@mail.gmail.com>
 <1186b0b7-7dc5-d926-e6ff-ba3da2238b9c@ovn.org>
 <ZPsKUDp7nVS/Z+j2@redhat.com>
 <4508010f-12e8-8565-d091-e8c68ae0493e@ovn.org>
 <ZPsQcu0HYBaTScnb@redhat.com>
 <755f9eb1-d97f-a359-3050-f3289374655b@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <755f9eb1-d97f-a359-3050-f3289374655b@ovn.org>
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

On Fri, Sep 08, 2023 at 04:06:35PM +0200, Ilya Maximets wrote:
> On 9/8/23 14:15, Daniel P. Berrangé wrote:
> > On Fri, Sep 08, 2023 at 02:00:47PM +0200, Ilya Maximets wrote:
> >> On 9/8/23 13:49, Daniel P. Berrangé wrote:
> >>> On Fri, Sep 08, 2023 at 01:34:54PM +0200, Ilya Maximets wrote:
> >>>> On 9/8/23 13:19, Stefan Hajnoczi wrote:
> >>>>> Hi Ilya and Jason,
> >>>>> There is a CI failure related to a missing Debian libxdp-dev package:
> >>>>> https://gitlab.com/qemu-project/qemu/-/jobs/5046139967
> >>>>>
> >>>>> I think the issue is that the debian-amd64 container image that QEMU
> >>>>> uses for testing is based on Debian 11 ("bullseye" aka "oldstable")
> >>>>> and libxdp is not available on that release:
> >>>>> https://packages.debian.org/search?keywords=libxdp&searchon=names&suite=oldstable&section=all
> >>>>
> >>>> Hmm.  Sorry about that.
> >>>>
> >>>>>
> >>>>> If we need to support Debian 11 CI then either XDP could be disabled
> >>>>> for that distro or libxdp could be compiled from source.
> >>>>
> >>>> I'd suggest we just remove the attempt to install the package for now,
> >>>> building libxdp from sources may be a little painful to maintain.
> >>>>
> >>>> Can be re-added later once distributions with libxdp 1.4+ will be more
> >>>> widely available, i.e. when fedora dockerfile will be updated to 39,
> >>>> for example.  That should be soon-ish, right?
> >>>
> >>> If you follow the process in docs/devel/testing.rst for adding
> >>> libxdp in libvirt-ci, then lcitool will "do the right thing"
> >>> when we move the auto-generated dockerfiles to new distro versions.
> >>
> >> Thanks!  I'll prepare changes for libvirt-ci.
> >>
> >> In the meantime, none of the currently tested images will have a required
> >> version of libxdp anyway, so I'm suggesting to just drop this one dockerfile
> >> modification from the patch.  What do you think?
> > 
> > Sure, if none of the distros have it, then lcitool won't emit the
> > dockerfile changes until we update the inherited distro version.
> > So it is sufficient to just update libvirt-ci.git with the mappings.yml
> > info for libxdp, and add 'libxdp' to the tests/lcitool/projects/qemu.yml
> > file in qemu.git. It will then 'just work' when someone updates the
> > distro versions later.
> 
> I posted an MR for libvirt-ci adding libxdp:
>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/429
> 
> Please, take a look.
> 
> The docs say that CI will try to build containers with the MR changes,
> but I don't think anything except sanity checks is actually tested on MR.
> Sorry if I missed something, never used GitLab pipelines before.

No, that's our fault - we've broken the CI and your change alerted
me to that fact :-)

> Note that with this update we will be installing older version of libxdp
> in many containers, even though they will not be used by QEMU, unless
> they are newer than 1.4.0.

No problem, as it means QEMU CI will demonstrate the the meson.build
change is ignoring the outdatd libxdp.

> tests/lcitool/projects/qemu.yml in qemu.git cannot be updated without
> updating a submodule after the MR merge.

Yep.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


