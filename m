Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D27FC10C
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:09:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r82WR-00053a-8e; Tue, 28 Nov 2023 13:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r82WO-00053B-VF
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r82WL-0000hf-F2
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701194956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oErOqwyM8Wd2XWnFIJ96sii80DRMnm5kXfb+q3a28W0=;
 b=diHik3WC6OMhn1w3ltqLxKGF8KCBB3X9NBoZU+Hftmzzj5bHXHlY9dYQG0gvQHa5uiKB4N
 U9RrnuPxE9qndMLuTHRVRb6+XCwoByfQt5YemXFB/w6P9LCZAmvD9k2Glreeit/fdLSrqM
 WGwIuPph57LB5lXmP6HmxN7RNlyW2M0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-8Q_bmVUfOQ2Axi5cvM-IIw-1; Tue, 28 Nov 2023 13:09:13 -0500
X-MC-Unique: 8Q_bmVUfOQ2Axi5cvM-IIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55992811E7B;
 Tue, 28 Nov 2023 18:09:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F1DC2166B28;
 Tue, 28 Nov 2023 18:09:11 +0000 (UTC)
Date: Tue, 28 Nov 2023 18:09:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU Summit Minutes 2023
Message-ID: <ZWYsxfJ7u9G9BfOP@redhat.com>
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
 <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
 <CAFEAcA9M5mXQJRQWGTWoh52H+KmCYd2sWrKzM8RrA=Dh=VeTQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9M5mXQJRQWGTWoh52H+KmCYd2sWrKzM8RrA=Dh=VeTQg@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

On Tue, Nov 28, 2023 at 06:05:25PM +0000, Peter Maydell wrote:
> On Tue, 28 Nov 2023 at 17:54, Cédric Le Goater <clg@redhat.com> wrote:
> >
> > On 11/21/23 18:11, Alex Bennée wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >> Topic 2: Are we happy with the email workflow?
> > >> ==============================================
> > >>
> > >> This was a topic to see if there was any consensus among maintainers
> > >> about the long-term acceptability of sticking with email for patch
> > >> submission and review -- in five years' time, if we're still doing it
> > >> the same way, how would we feel about it?
> > >>
> > >> One area where we did get consensus was that now that we're doing CI
> > >> on gitlab we can change pull requests from maintainers from via-email
> > >> to gitlab merge requests. This would hopefully mean that instead of
> > >> the release-manager having to tell gitlab to do a merge and then
> > >> reporting back the results of any CI failures, the maintainer
> > >> could directly see the CI results and deal with fixing up failures
> > >> and resubmitting without involving the release manager. (This
> > >> may have the disbenefit that there isn't a single person any
> > >> more who looks at all the CI results and gets a sense of whether
> > >> particular test cases have pre-existing intermittent failures.)
> > >
> > > If we are keen to start processing merge requests for the 9.0 release we
> > > really should consider how it is going to work before we open up the
> > > taps post 8.2-final going out.
> > >
> > > Does anyone want to have a go at writing an updated process for
> > > docs/devel/submitting-a-pull-request.rst (or I guess merge-request) so
> > > we can discuss it and be ready early in the cycle? Ideally someone who
> > > already has experience with the workflow with other gitlab hosted
> > > projects.
> >
> >
> > Reading the Topic 2 paragraph above, I understand that a maintainer
> > of a subsystem would be able to merge its '-next' branch in the main
> > repository when CI is all green. Correct ?
> 
> I think my intention when writing that was to say that the submaintainer
> kicks things off and deals with resubmitting and rerunning if there
> are failures, but actually doing "merge this successfully tested
> pullreq" is still the release-manager's job.
> 
> > It seems to me that we should also have a group of people approving
> > the MR.
> 
> I do think something like this is probably where we want to get to
> eventually, where there's a group of people with the rights to
> approve a merge, and maybe the rules about how many approvals
> or whose approval is needed can differ between "normal development"
> and "in freeze" periods. But the idea of the above text I think
> was that the first step is to change from how the release manager
> receives "please merge this" requests from the current "here's an
> email, you need to test it" to "here's a thing in the gitlab UI
> that has already passed the tests and is ready to go".

If we setup ACL rules to require the release manager only to
start with, it is easy enough to expand the ACL rules later
once we're comfortable with more people doing the work.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


