Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E17F64F4
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:12:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DFY-0003ii-1B; Thu, 23 Nov 2023 12:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DFW-0003gg-1N
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DFU-0000Jm-1I
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700759538;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWGwogfj6VXXQKd66+J1TVtdaa4kBzyW4buFEyN3LeA=;
 b=MLiG00iOlVE1Ya23FvTkrXq1E/U6SFsr5zCDF82hch//xaUdn89or2Junr32TaTbdyyjR1
 i+HLeT9wkS2BXS3HVvBTj+4oy6yUgrZQRB3/aGM+cbZIutf7DnWicq3gmNX61WfOuWrNYT
 S6mscRQ8/nNNVKc94QkHLuoc53/DzCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-oX-N-_1EMKmafHH0U3CHog-1; Thu, 23 Nov 2023 12:12:14 -0500
X-MC-Unique: oX-N-_1EMKmafHH0U3CHog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA5D88D4E2;
 Thu, 23 Nov 2023 17:12:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C4B940C6EB9;
 Thu, 23 Nov 2023 17:12:11 +0000 (UTC)
Date: Thu, 23 Nov 2023 17:12:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZV-H507VjDKouaX_@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <CAFEAcA_1EkO3PnaYruMLWAaPHNLrrMXwuMohTi5gKLwa0P=Ljw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_1EkO3PnaYruMLWAaPHNLrrMXwuMohTi5gKLwa0P=Ljw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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

On Thu, Nov 23, 2023 at 01:01:00PM +0000, Peter Maydell wrote:
> On Thu, 23 Nov 2023 at 11:40, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Currently we have a short paragraph saying that patches must include
> > a Signed-off-by line, and merely link to the kernel documentation.
> > The linked kernel docs have alot of content beyond the part about
> 
> "a lot"
> 
> > sign-off an thus is misleading/distracting to QEMU contributors.
> 
> "and thus are"
> 
> >
> > This introduces a dedicated 'code-provenance' page in QEMU talking
> > about why we require sign-off, explaining the other tags we commonly
> > use, and what to do in some edge cases.
> 
> Good idea; I've felt for a while now that it was a little awkward
> to have to point people at that big kernel doc page.
> 
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/devel/code-provenance.rst    | 197 ++++++++++++++++++++++++++++++
> >  docs/devel/index-process.rst      |   1 +
> >  docs/devel/submitting-a-patch.rst |  18 +--
> >  3 files changed, 201 insertions(+), 15 deletions(-)
> >  create mode 100644 docs/devel/code-provenance.rst
> >
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > new file mode 100644
> > index 0000000000..b4591a2dec
> > --- /dev/null
> > +++ b/docs/devel/code-provenance.rst
> > @@ -0,0 +1,197 @@
> > +.. _code-provenance:
> > +
> > +Code provenance
> > +===============
> > +
> > +Certifying patch submissions
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The QEMU community **mandates** all contributors to certify provenance
> > +of patch submissions they make to the project. To put it another way,
> > +contributors must indicate that they are legally permitted to contribute
> > +to the project.
> > +
> > +Certification is achieved with a low overhead by adding a single line
> > +to the bottom of every git commit::
> > +
> > +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
> > +
> > +This existence of this line asserts that the author of the patch is
> > +contributing in accordance with the `Developer's Certificate of
> > +Origin <https://developercertifcate.org>`__:
> > +
> > +.. _dco:
> > +
> > +::
> > +  Developer's Certificate of Origin 1.1
> > +
> > +  By making a contribution to this project, I certify that:
> > +
> > +  (a) The contribution was created in whole or in part by me and I
> > +      have the right to submit it under the open source license
> > +      indicated in the file; or
> > +
> > +  (b) The contribution is based upon previous work that, to the best
> > +      of my knowledge, is covered under an appropriate open source
> > +      license and I have the right under that license to submit that
> > +      work with modifications, whether created in whole or in part
> > +      by me, under the same open source license (unless I am
> > +      permitted to submit under a different license), as indicated
> > +      in the file; or
> > +
> > +  (c) The contribution was provided directly to me by some other
> > +      person who certified (a), (b) or (c) and I have not modified
> > +      it.
> > +
> > +  (d) I understand and agree that this project and the contribution
> > +      are public and that a record of the contribution (including all
> > +      personal information I submit with it, including my sign-off) is
> > +      maintained indefinitely and may be redistributed consistent with
> > +      this project or the open source license(s) involved.
> > +
> > +It is generally expected that the name and email addresses used in one
> > +of the ``Signed-off-by`` lines, matches that of the git commit ``Author``
> > +field. If the person sending the mail is also one of the patch authors,
> > +it is further expected that the mail ``From:`` line name & address match
> > +one of the ``Signed-off-by`` lines.
> 
> Is it? Patches sent via the sr.ht service won't do that, and I'm
> pretty sure we've had a few contributors in the past who send
> patches from different addresses to avoid problems with their
> corporate mail server mangling patches. I think this would be
> better softened to something like a recommendation ("Generally
> you should use the same email addresses ... ").

Yes, I forgot about sr.ht being wierd in this respect, so I'll
take your suggestion.


> > +
> > + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> > +   on the mailing list, if they consider the patch acceptable, they
> > +   should send an email reply containing a ``Reviewed-by`` tag.
> > +
> > +   NB: a subsystem maintainer sending a pull request would replace
> > +   their own ``Reviewed-by`` with another ``Signed-off-by``
> 
> I agree with Philippe here -- you add signed-off-by, you don't
> replace reviewed-by.

Yep, will change that.

> 
> > +
> > + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> > +   that touches their subsystem, but intends to allow a different
> > +   maintainer to queue it and send a pull request, they would send
> > +   a mail containing a ``Acked-by`` tag.
> 
> I would personally also say "Acked-by does not imply a full code
> review of the patch; if the subsystem maintainer has done a full
> review, they should use the Reviewed-by tag instead."
> 
> But I know that there are some differences of opinion on exactly
> what Acked-by: means...

I'll incorporate something along those lines with a little fuzzyness
to give flexibility.

> > +
> > + * **``Tested-by``**: when a QEMU community member has functionally
> > +   tested the behaviour of the patch in some manner, they should
> > +   send an email reply conmtaning a ``Tested-by`` tag.
> > +
> > + * **``Reported-by``**: when a QEMU community member reports a problem
> > +   via the mailing list, or some other informal channel that is not
> > +   the issue tracker, it is good practice to credit them by including
> > +   a ``Reported-by`` tag on any patch fixing the issue. When the
> > +   problem is reported via the GitLab issue tracker, however, it is
> > +   sufficient to just include a link to the issue.
> 
> Maybe we should add a bit of encouraging text here along the lines of:
> 
> Reviewing and testing is something anybody can do -- if you've
> reviewed the code or tested it, feel free to send an email with
> your tag to say you've done that, or to ask questions if there's
> part of the patch you don't understand.
> 
> ? Or perhaps that would be better elsewhere; IDK.

I'll put a little bit in here but want to keep it relatively
concise, since we have other docs about more general contribution
practices.



> > +If the abandoned patch already had a ``Signed-off-by`` from the original
> > +author this **must** be preserved. The new contributor **must** then add
> > +their own ``Signed-off-by`` after the original one if they made any
> > +further changes to it. It is common to include a comment just prior to
> > +the new ``Signed-off-by`` indicating what extra changes were made. For
> > +example::
> > +
> > +  Signed-off-by: Some Person <some.person@example.com>
> > +  [Rebased and added support for 'foo']
> > +  Signed-off-by: New Person <new.person@example.com>
> 
> You might want to use two different email domains in this example;
> an abandoned project picked up by somebody from the same company
> (assuming the usual copyright-belongs-to-company) is a bit different
> from an abandoned project picked up by an entirely unrelated person.

Yes good idea.

> I think in this case it's also worth stating the general principles:
> 
> ===begin===
> The general principles with picking up abandoned work are:
>  * we should continue to credit the first author for their work
>  * we should track the provenance of the code
>  * we should also acknowledge the efforts of the person picking
>    up the work
>  * the commit messages should indicate who is responsible for
>    what parts of the final patch
> 
> In complicated cases or if in doubt, you can always ask on the
> mailing list for advice.
> 
> If the new work you'd need to do to resubmit the patches is
> significant, it's worth dropping the original author a
> friendly email to let them know, in case you might be
> duplicating something the original author is still working on.
> ===endit===
> 
> perhaps ?

I'll incorporate somethnig along these lines.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


