Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6DB7FDD9E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:50:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Nka-0000P3-VH; Wed, 29 Nov 2023 11:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r8NkV-0000Nm-Gm
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r8NkT-0006cH-EG
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701276556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZazBXKj6fU4zxmIlPqwn0uKUgP2JurgeP2wwgLRbB+M=;
 b=iQ48axgeooXuJUe5Hpw77j/1EC0PLpi02f+wBsdopDYnJPrWGS7LPhKxF8f79RlxI9G+tT
 REXRYOREXGPC8Gz5qK+kUE4YJEaAxY7HB2zaBYzwxgZOPEBwEPp8kXr9d4iN022/B2oUoc
 0jfIzqXYbAlYXLvInYu0e/K8RMrdglM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-YIFfXosdM56GaHRaLJ_ROg-1; Wed, 29 Nov 2023 11:49:12 -0500
X-MC-Unique: YIFfXosdM56GaHRaLJ_ROg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FE55185A789;
 Wed, 29 Nov 2023 16:49:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1358240C6EBA;
 Wed, 29 Nov 2023 16:49:10 +0000 (UTC)
Date: Wed, 29 Nov 2023 16:49:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU Summit Minutes 2023
Message-ID: <ZWdrhGhmY--yUluR@redhat.com>
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <ZWYsMsgxjDZ_T2zA@redhat.com>
 <CANCZdfq6dPArtLjwAbV9MxQnR6pOn6MR+gB7eTogUyw8WuyjCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfq6dPArtLjwAbV9MxQnR6pOn6MR+gB7eTogUyw8WuyjCw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 29, 2023 at 08:50:06AM -0700, Warner Losh wrote:
> On Wed, Nov 29, 2023 at 8:44 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Tue, Nov 28, 2023 at 06:54:42PM +0100, Cédric Le Goater wrote:
> > > On 11/21/23 18:11, Alex Bennée wrote:
> > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > >
> > > > > QEMU Summit Minutes 2023
> > > > > ========================
> > > > >
> > > > > As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
> > > > > invite-only meeting for the most active maintainers and
> > submaintainers
> > > > > in the project, and we discuss various project-wide issues, usually
> > > > > process stuff. We then post the minutes of the meeting to the list as
> > > > > a jumping off point for wider discussion and for those who weren't
> > > > > able to attend.
> > > > >
> > > > <snip>
> > > > >
> > > > > Topic 2: Are we happy with the email workflow?
> > > > > ==============================================
> > > > >
> > > > > This was a topic to see if there was any consensus among maintainers
> > > > > about the long-term acceptability of sticking with email for patch
> > > > > submission and review -- in five years' time, if we're still doing it
> > > > > the same way, how would we feel about it?
> > > > >
> > > > > One area where we did get consensus was that now that we're doing CI
> > > > > on gitlab we can change pull requests from maintainers from via-email
> > > > > to gitlab merge requests. This would hopefully mean that instead of
> > > > > the release-manager having to tell gitlab to do a merge and then
> > > > > reporting back the results of any CI failures, the maintainer
> > > > > could directly see the CI results and deal with fixing up failures
> > > > > and resubmitting without involving the release manager. (This
> > > > > may have the disbenefit that there isn't a single person any
> > > > > more who looks at all the CI results and gets a sense of whether
> > > > > particular test cases have pre-existing intermittent failures.)
> > > >
> > > > If we are keen to start processing merge requests for the 9.0 release
> > we
> > > > really should consider how it is going to work before we open up the
> > > > taps post 8.2-final going out.
> > > >
> > > > Does anyone want to have a go at writing an updated process for
> > > > docs/devel/submitting-a-pull-request.rst (or I guess merge-request) so
> > > > we can discuss it and be ready early in the cycle? Ideally someone who
> > > > already has experience with the workflow with other gitlab hosted
> > > > projects.
> >
> > If no one else beats me to it, I can try and write up something,
> > since I'm pretty familiar with gitlab PR from libvirt & other
> > projects.
> >
> > > Reading the Topic 2 paragraph above, I understand that a maintainer
> > > of a subsystem would be able to merge its '-next' branch in the main
> > > repository when CI is all green. Correct ?
> >
> > A maintainer would have their own fork of qemu-project/qemu, under
> > their namespace, or if there are maintainers collaborating, they
> > might have a separate group nmamespace for their subsystem.
> > eg qemu-block-subsys/qemu, or we could use sub-groups perhaps
> > so  qemu-project/block-subsys/qemu  for official subsystem
> > trees.
> >
> > Anyway, when a maintainer wants to merge a tree, I would expect to
> > have a MR opened against 'master' in qemu-project/qemu.  The CI
> > ought to then run and if it is all green, then someone would approve
> > it to merge to master.
> >
> > > It seems to me that we should also have a group of people approving
> > > the MR.
> >
> > Yes, while we could have one designated gate keeper approving all
> > MRs, that would defeat some of the benefit of MRs. So likely would
> > be good to have a pool, and also setup the config so that the owner
> > of an MR is not allow to approve their own MR, to guarantee there
> > is always a 2nd pair of eyes as sanity check.
> >
> > We might also need to consider enabling 'merge trains', so that
> > we get a serialized CI run again after hte MR is approved, in
> > case 'master' moved onwards since the initial CI pipeline when
> > the MR was opened.
> >
> 
> I'd honestly optimize for 'frequent merges of smaller things' rather than
> 'infrequent merges of larger things'. The latter has caused most of the
> issues for me. It's harder to contribute because the overhead of doing so
> is so large you want to batch everything. Let's not optimize for that
> workaround for the high-friction submission process we have now. If there's
> always smaller bits of work going in all the time, you'll find few commit
> races... though the CI pipeline is rather large, so having a ci-staging
> branch to land the MRs to that have completed CI, but not CI on the tip,
> might not be bad... but the resolution of conflicts can be tricky, though
> infrequent, so if a ci-staging branch bounces, all MRs would need to be
> manually requeued after humans look at why and think through who needs to
> talk to whom, or if it's just a 'other things landed before you could get
> yours in and it's not the ci-staging being full of other people's commits
> that is at fault.

I agree. Right now we tend to have fairly large pull requests, because
people are concious of each pull request consuming non-trivial resources
from the release maintainer. If this new MR based approach reduces the
load on the release maintainer, then sending frequent small pull requests
is almost certainly going to be better.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


