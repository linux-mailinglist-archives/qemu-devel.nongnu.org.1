Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729AB7A5CC4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWHa-0003f7-GT; Tue, 19 Sep 2023 04:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiWHV-0003db-6n
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiWHN-0006CE-O9
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695112820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PqqSC/TtIFw5JHzv83EkVNvL6JvPP47y7lYCEZz+s8=;
 b=Kb/I5HfNiPZIQp2UI+HUBJoSZce9+yuRJhXytw6Jxm5U8EjTKRKP5LlPWq+4bicqpAMV0/
 LCtrpkKxe0NvQ0rSnuATYvhouOHztVsN0uerWymMhkYVr67oqaZVKgtrGCEq8w6gASyUs7
 wJYMxh5/HHhHLEoEjzzhP0X6ENfW27M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-NRacuGONOP-1QxNxw0b7cA-1; Tue, 19 Sep 2023 04:40:15 -0400
X-MC-Unique: NRacuGONOP-1QxNxw0b7cA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 982ED29AB3FE;
 Tue, 19 Sep 2023 08:40:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F11492B05;
 Tue, 19 Sep 2023 08:40:14 +0000 (UTC)
Date: Tue, 19 Sep 2023 09:40:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Net patches
Message-ID: <ZQlebHldXOFZATSo@redhat.com>
References: <CAJSP0QVf3CFf1zuBnQev-G54SiGZ53MWBj19SyH__19bo=vfWg@mail.gmail.com>
 <1186b0b7-7dc5-d926-e6ff-ba3da2238b9c@ovn.org>
 <ZPsKUDp7nVS/Z+j2@redhat.com>
 <4508010f-12e8-8565-d091-e8c68ae0493e@ovn.org>
 <ZPsQcu0HYBaTScnb@redhat.com>
 <755f9eb1-d97f-a359-3050-f3289374655b@ovn.org>
 <ZPsscpzj9fNtCEOY@redhat.com>
 <c406b8fb-a2f1-8eb2-abc5-af2474edf940@ovn.org>
 <ZQLAkNPdOA4ncDvF@redhat.com>
 <bfcf7272-c4c9-3b30-28ed-065ee374d681@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfcf7272-c4c9-3b30-28ed-065ee374d681@ovn.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 18, 2023 at 09:36:10PM +0200, Ilya Maximets wrote:
> On 9/14/23 10:13, Daniel P. Berrangé wrote:
> > On Wed, Sep 13, 2023 at 08:46:42PM +0200, Ilya Maximets wrote:
> >> On 9/8/23 16:15, Daniel P. Berrangé wrote:
> >>> On Fri, Sep 08, 2023 at 04:06:35PM +0200, Ilya Maximets wrote:
> >>>> On 9/8/23 14:15, Daniel P. Berrangé wrote:
> >>>>> On Fri, Sep 08, 2023 at 02:00:47PM +0200, Ilya Maximets wrote:
> >>>>>> On 9/8/23 13:49, Daniel P. Berrangé wrote:
> >>>>>>> On Fri, Sep 08, 2023 at 01:34:54PM +0200, Ilya Maximets wrote:
> >>>>>>>> On 9/8/23 13:19, Stefan Hajnoczi wrote:
> >>>>>>>>> Hi Ilya and Jason,
> >>>>>>>>> There is a CI failure related to a missing Debian libxdp-dev package:
> >>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/5046139967
> >>>>>>>>>
> >>>>>>>>> I think the issue is that the debian-amd64 container image that QEMU
> >>>>>>>>> uses for testing is based on Debian 11 ("bullseye" aka "oldstable")
> >>>>>>>>> and libxdp is not available on that release:
> >>>>>>>>> https://packages.debian.org/search?keywords=libxdp&searchon=names&suite=oldstable&section=all
> >>>>>>>>
> >>>>>>>> Hmm.  Sorry about that.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> If we need to support Debian 11 CI then either XDP could be disabled
> >>>>>>>>> for that distro or libxdp could be compiled from source.
> >>>>>>>>
> >>>>>>>> I'd suggest we just remove the attempt to install the package for now,
> >>>>>>>> building libxdp from sources may be a little painful to maintain.
> >>>>>>>>
> >>>>>>>> Can be re-added later once distributions with libxdp 1.4+ will be more
> >>>>>>>> widely available, i.e. when fedora dockerfile will be updated to 39,
> >>>>>>>> for example.  That should be soon-ish, right?
> >>>>>>>
> >>>>>>> If you follow the process in docs/devel/testing.rst for adding
> >>>>>>> libxdp in libvirt-ci, then lcitool will "do the right thing"
> >>>>>>> when we move the auto-generated dockerfiles to new distro versions.
> >>>>>>
> >>>>>> Thanks!  I'll prepare changes for libvirt-ci.
> >>>>>>
> >>>>>> In the meantime, none of the currently tested images will have a required
> >>>>>> version of libxdp anyway, so I'm suggesting to just drop this one dockerfile
> >>>>>> modification from the patch.  What do you think?
> >>>>>
> >>>>> Sure, if none of the distros have it, then lcitool won't emit the
> >>>>> dockerfile changes until we update the inherited distro version.
> >>>>> So it is sufficient to just update libvirt-ci.git with the mappings.yml
> >>>>> info for libxdp, and add 'libxdp' to the tests/lcitool/projects/qemu.yml
> >>>>> file in qemu.git. It will then 'just work' when someone updates the
> >>>>> distro versions later.
> >>>>
> >>>> I posted an MR for libvirt-ci adding libxdp:
> >>>>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/429
> >>>>
> >>>> Please, take a look.
> >>>>
> >>>> The docs say that CI will try to build containers with the MR changes,
> >>>> but I don't think anything except sanity checks is actually tested on MR.
> >>>> Sorry if I missed something, never used GitLab pipelines before.
> >>>
> >>> No, that's our fault - we've broken the CI and your change alerted
> >>> me to that fact :-)
> >>>
> >>>> Note that with this update we will be installing older version of libxdp
> >>>> in many containers, even though they will not be used by QEMU, unless
> >>>> they are newer than 1.4.0.
> >>>
> >>> No problem, as it means QEMU CI will demonstrate the the meson.build
> >>> change is ignoring the outdatd libxdp.
> >>>
> >>>> tests/lcitool/projects/qemu.yml in qemu.git cannot be updated without
> >>>> updating a submodule after the MR merge.
> >>>
> >>> Yep.
> >>
> >> Since all the required changes went into libvirt-ci project, I posted an
> >> updated patch set named:
> >>
> >>   '[PATCH v4 0/2] net: add initial support for AF_XDP network backend'
> >>
> >> Please, take a look.
> >>
> >> This should fix the CI issues, though I'm not sure how to run QEMU gitlab
> >> pipelines myself, so I didn't actually test all the images.
> > 
> >   git push gitlab  -o ci.variable=QEMU_CI=2
> > 
> > will create pipeline and immediately run all jobs.
> 
> Thanks!  That worked.  Though I wasn't able to test much anyway as
> this thing burned through all my free compute credits less than
> half way through the pipeline. :D
> 
> So, AFAIU, it's not something an occasional contributor like me can
> use, unless they are spending their own money.

That is not the expected behaviour.

If your repo is a fork of https://gitlab.com/qemu-project/qemu it
should benefit from a *massive* x125 reduction on CI costs.

The critical thing is that it *MUST* have been created with the
'Fork' button on qemu-project/qemu. If that's not the case then
you will burn CI credits at a cost of 1 minute == 1 credit,
instead of 1 minute == 0.008 credits. Check this by going to
the top page of your repo, and looking for a box a little above
the file list, that says

    "Forked from QEMU / QEMU"

If that is not the case, then you'll have to rename your existing
repo to get it out of the way, and then use the 'Fork' button to
create a new copy that is tracked as a fork.

With most accounts getting 400 CI minutes per month, an averge
QEMU CI run should consume about 7 CI minutes.

NB, CI credits reset on the 1st of each month

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


