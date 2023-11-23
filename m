Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF927F650D
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:17:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DJz-0006nq-Sz; Thu, 23 Nov 2023 12:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DJv-0006nc-ST
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DJu-0002Rr-2O
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700759813;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alda3S4tL/chlRAfjN8nQC+JZ/KvG6auchbdArr5nZA=;
 b=S/1EntJ8VDUkNaFazeH3SPj6QiAfkLzyYL3+S/q4PRvvhEfQeYPtJOu9XXZTZR5MlB4Swt
 EM2pee2647NEdkpjeEZP1BAM480K4ulOov0m6nKdNbkVYDnxLi9WRvdt4SfLNEJyHJFEzy
 CA4tSPi4u2P9SHa/wrOka9J68IK3KFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-DgtVNFHDPm6aooRDQdKn4A-1; Thu, 23 Nov 2023 12:16:51 -0500
X-MC-Unique: DgtVNFHDPm6aooRDQdKn4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A042885A58A;
 Thu, 23 Nov 2023 17:16:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF3041121306;
 Thu, 23 Nov 2023 17:16:47 +0000 (UTC)
Date: Thu, 23 Nov 2023 17:16:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZV-I_eWYsBeOe4Sp@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <20231123091654-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123091654-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Thu, Nov 23, 2023 at 09:25:13AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 23, 2023 at 11:40:25AM +0000, Daniel P. Berrangé wrote:
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
> 

> > +  * The non-primary author's contributions were so trivial that
> > +    they can be considered not subject to copyright. In this case
> > +    the secondary authors need not include a ``Signed-off-by``.
> > +
> > +    This case most commonly applies where QEMU reviewers give short
> > +    snippets of code as suggested fixes to a patch. The reviewers
> > +    don't need to have their own ``Signed-off-by`` added unless
> > +    their code suggestion was unusually large.
> 
> It is still a good policy to include attribution, e.g.
> by adding a Suggested-by tag.

Will add this tag.


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
> > +
> > + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> > +   that touches their subsystem, but intends to allow a different
> > +   maintainer to queue it and send a pull request, they would send
> > +   a mail containing a ``Acked-by`` tag.
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
> 
> Suggested-by is also common.
> 
> As long as we are here, let's document Fixes: and Cc: ?

The submitting-a-patch doc covers more general commit message information.
I think this doc just ought to focus on tags that identify humans involved
in the process.

I've never been sure what the point of the 'Cc' tag is, when you actually
want to use the Cc email header ? 


> > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> > index c641d948f1..ec541b3d15 100644
> > --- a/docs/devel/submitting-a-patch.rst
> > +++ b/docs/devel/submitting-a-patch.rst
> > @@ -322,21 +322,9 @@ Patch emails must include a ``Signed-off-by:`` line
> >  
> >  Your patches **must** include a Signed-off-by: line. This is a hard
> >  requirement because it's how you say "I'm legally okay to contribute
> > -this and happy for it to go into QEMU". The process is modelled after
> > -the `Linux kernel
> > -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
> > -policy.
> > -
> > -If you wrote the patch, make sure your "From:" and "Signed-off-by:"
> > -lines use the same spelling. It's okay if you subscribe or contribute to
> > -the list via more than one address, but using multiple addresses in one
> > -commit just confuses things. If someone else wrote the patch, git will
> > -include a "From:" line in the body of the email (different from your
> > -envelope From:) that will give credit to the correct author; but again,
> > -that author's Signed-off-by: line is mandatory, with the same spelling.
> > -
> > -There are various tooling options for automatically adding these tags
> > -include using ``git commit -s`` or ``git format-patch -s``. For more
> > +this and happy for it to go into QEMU". For full guidance, read the
> > +:ref:`code-provenance` documentation.
> > +
> >  information see `SubmittingPatches 1.12
> >  <http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
> 
> this "information" now looks orphaned or am I confused?

Yes, forgot to cull it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


