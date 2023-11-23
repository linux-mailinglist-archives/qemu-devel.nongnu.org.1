Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D19847F64FF
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:14:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DHA-0005KJ-Aw; Thu, 23 Nov 2023 12:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DH8-0005Il-Gr
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DH0-0000yh-IY
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700759632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Rp3RLlBx36Ux1ClJIihBXNTXYXJvFupliIPd/luRRM=;
 b=ApFrqZfW3lovS9A7XnklesKpGpThJfKj4Kr0GZorGhulNYroROB+PTKLgJwvJERWjOWwpP
 utUQFEtqu7y4w4dLC/bNpwONBCDsMWdqSvd+cLSZOMxdT5zn7Xlb7cwSOyCNM6I/wtnm46
 k0T+lKpuX1yzkDUooVVJmaaPHElzypE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-E5XGCgnQNAi3QzxqOrtGtw-1; Thu, 23 Nov 2023 12:13:49 -0500
X-MC-Unique: E5XGCgnQNAi3QzxqOrtGtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D0CD88D4E3;
 Thu, 23 Nov 2023 17:13:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B574436E4;
 Thu, 23 Nov 2023 17:12:59 +0000 (UTC)
Date: Thu, 23 Nov 2023 17:12:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZV-IGbGb7EIzgIxo@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <ZV9QtIkJJvZyQbRn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV9QtIkJJvZyQbRn@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Nov 23, 2023 at 02:16:36PM +0100, Kevin Wolf wrote:
> Am 23.11.2023 um 12:40 hat Daniel P. Berrangé geschrieben:
> > Currently we have a short paragraph saying that patches must include
> > a Signed-off-by line, and merely link to the kernel documentation.
> > The linked kernel docs have alot of content beyond the part about
> > sign-off an thus is misleading/distracting to QEMU contributors.
> > 
> > This introduces a dedicated 'code-provenance' page in QEMU talking
> > about why we require sign-off, explaining the other tags we commonly
> > use, and what to do in some edge cases.
> > 
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
> Isn't the S-o-b expected even if the person sending the mail isn't one
> of the patch authors, i.e. certifying (c) rather than (a) or (b) from
> the DCO? This is essentially the same case as what a subsystem
> maintainer does.

Yes, you are right.


> > +Other commit tags
> > +~~~~~~~~~~~~~~~~~
> > +
> > +While the ``Signed-off-by`` tag is mandatory, there are a number of
> > +other tags that are commonly used during QEMU development
> > +
> > + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> > +   on the mailing list, if they consider the patch acceptable, they
> > +   should send an email reply containing a ``Reviewed-by`` tag.
> > +
> > +   NB: a subsystem maintainer sending a pull request would replace
> > +   their own ``Reviewed-by`` with another ``Signed-off-by``
> 
> As Philippe already mentioned, this isn't necessarily the case. It's a
> common enough practice to add a S-o-b (which technically only certifies
> the DCO) without removing the R-b (which tells that the content was
> actually reviewed in detail - maintainers don't always do that if there
> are already R-bs from trusted community members).

Yes, will change.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


