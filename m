Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7C7F6583
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DaC-0003W4-T1; Thu, 23 Nov 2023 12:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Da7-0003Vs-CE
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Da5-00009X-Fg
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700760816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXyAntG+44WSZWZRy82IWZhEleM+sqrAyJ3BG+Dpxnc=;
 b=e4mWCkyAY/RsuIrJrSxJeeYXpQNdNbPuS5eqZnEwY5DVisTy4ps18/UhWgDRGIyzLiSFp/
 E2/xFzlstfQLcCeiqOXSgs/NI4eZYSAW04iehD1IR3zTKAO5NKhigwSidmGi3v0rQ2EyiB
 sxo6Ju3MH3TdiELkIx75/H3EWmMIRDc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-TPly6Zm-N8OsPOczLTalKA-1; Thu, 23 Nov 2023 12:33:34 -0500
X-MC-Unique: TPly6Zm-N8OsPOczLTalKA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40b349b9711so6551915e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 09:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700760813; x=1701365613;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yXyAntG+44WSZWZRy82IWZhEleM+sqrAyJ3BG+Dpxnc=;
 b=pQcrv+saadkD2BDK7bytysPZ4PhFMeeQNBHL4vnO00Tvwlhaq+qyYbGKr4P+/O/AM9
 3BkAOKdBXGK9xwE54vT6hADxbu0Oqc486V9HjLMoIuR25UEzBhkC50HhU5M9D1ZAtk6P
 2Tj7b90Dip+WyOa2N8d2N2M0nOB8kR8+welSkgTaJuIKbZsjKJHvh2loLDzWC/hyHJB3
 +NP1Lr4BBz6PWdS846Z+KMJDOzK2yNFhzElio+6Xn12UTGR+28rk52xxtfAEZFiZeAqg
 eJ8Dzg86fTVulNIKQV01aYbSOUp68KNBgxTS5IdoL7kNrddXcslxlqnJsDkQkAq0Vafk
 K0uA==
X-Gm-Message-State: AOJu0YzK4TbIqwYroovF/Pnat8sPH/YJDm0Cowa7lFVz/dSqZYNEEMn+
 Ear1nVnYD3D+b75YB+ubnvgMG4BGMSaNV42l0O3mKPtljg6MZg1aCKLpY833whvPqXBFyxA209v
 /kEeOCSaLJodSpGo=
X-Received: by 2002:adf:ef8e:0:b0:32d:81f7:d6f2 with SMTP id
 d14-20020adfef8e000000b0032d81f7d6f2mr115828wro.30.1700760813286; 
 Thu, 23 Nov 2023 09:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIHhSJZQczm0Iz8fKI+Q0Fspjw/E/qgkwrzvJSecYJTL2yvwyGU62RUyu57RtHHwJ1ZvGnSg==
X-Received: by 2002:adf:ef8e:0:b0:32d:81f7:d6f2 with SMTP id
 d14-20020adfef8e000000b0032d81f7d6f2mr115802wro.30.1700760812838; 
 Thu, 23 Nov 2023 09:33:32 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:dd6e:61bc:cc48:699f:b2ce])
 by smtp.gmail.com with ESMTPSA id
 f8-20020adff988000000b00332e75eae4asm437714wrr.85.2023.11.23.09.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 09:33:19 -0800 (PST)
Date: Thu, 23 Nov 2023 12:33:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <20231123123106-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <20231123091654-mutt-send-email-mst@kernel.org>
 <ZV-I_eWYsBeOe4Sp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV-I_eWYsBeOe4Sp@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 23, 2023 at 05:16:45PM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 23, 2023 at 09:25:13AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 23, 2023 at 11:40:25AM +0000, Daniel P. Berrangé wrote:
> > > Currently we have a short paragraph saying that patches must include
> > > a Signed-off-by line, and merely link to the kernel documentation.
> > > The linked kernel docs have alot of content beyond the part about
> > > sign-off an thus is misleading/distracting to QEMU contributors.
> > > 
> > > This introduces a dedicated 'code-provenance' page in QEMU talking
> > > about why we require sign-off, explaining the other tags we commonly
> > > use, and what to do in some edge cases.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> 
> > > +  * The non-primary author's contributions were so trivial that
> > > +    they can be considered not subject to copyright. In this case
> > > +    the secondary authors need not include a ``Signed-off-by``.
> > > +
> > > +    This case most commonly applies where QEMU reviewers give short
> > > +    snippets of code as suggested fixes to a patch. The reviewers
> > > +    don't need to have their own ``Signed-off-by`` added unless
> > > +    their code suggestion was unusually large.
> > 
> > It is still a good policy to include attribution, e.g.
> > by adding a Suggested-by tag.
> 
> Will add this tag.
> 
> 
> > > +Other commit tags
> > > +~~~~~~~~~~~~~~~~~
> > > +
> > > +While the ``Signed-off-by`` tag is mandatory, there are a number of
> > > +other tags that are commonly used during QEMU development
> > > +
> > > + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> > > +   on the mailing list, if they consider the patch acceptable, they
> > > +   should send an email reply containing a ``Reviewed-by`` tag.
> > > +
> > > +   NB: a subsystem maintainer sending a pull request would replace
> > > +   their own ``Reviewed-by`` with another ``Signed-off-by``
> > > +
> > > + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> > > +   that touches their subsystem, but intends to allow a different
> > > +   maintainer to queue it and send a pull request, they would send
> > > +   a mail containing a ``Acked-by`` tag.
> > > +   
> > > + * **``Tested-by``**: when a QEMU community member has functionally
> > > +   tested the behaviour of the patch in some manner, they should
> > > +   send an email reply conmtaning a ``Tested-by`` tag.
> > > +
> > > + * **``Reported-by``**: when a QEMU community member reports a problem
> > > +   via the mailing list, or some other informal channel that is not
> > > +   the issue tracker, it is good practice to credit them by including
> > > +   a ``Reported-by`` tag on any patch fixing the issue. When the
> > > +   problem is reported via the GitLab issue tracker, however, it is
> > > +   sufficient to just include a link to the issue.
> > 
> > 
> > Suggested-by is also common.
> > 
> > As long as we are here, let's document Fixes: and Cc: ?
> 
> The submitting-a-patch doc covers more general commit message information.
> I think this doc just ought to focus on tags that identify humans involved
> in the process.
> 
> I've never been sure what the point of the 'Cc' tag is, when you actually
> want to use the Cc email header ? 
> 

It records the fact that these people have been copied but did not
respond.

> > > diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> > > index c641d948f1..ec541b3d15 100644
> > > --- a/docs/devel/submitting-a-patch.rst
> > > +++ b/docs/devel/submitting-a-patch.rst
> > > @@ -322,21 +322,9 @@ Patch emails must include a ``Signed-off-by:`` line
> > >  
> > >  Your patches **must** include a Signed-off-by: line. This is a hard
> > >  requirement because it's how you say "I'm legally okay to contribute
> > > -this and happy for it to go into QEMU". The process is modelled after
> > > -the `Linux kernel
> > > -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
> > > -policy.
> > > -
> > > -If you wrote the patch, make sure your "From:" and "Signed-off-by:"
> > > -lines use the same spelling. It's okay if you subscribe or contribute to
> > > -the list via more than one address, but using multiple addresses in one
> > > -commit just confuses things. If someone else wrote the patch, git will
> > > -include a "From:" line in the body of the email (different from your
> > > -envelope From:) that will give credit to the correct author; but again,
> > > -that author's Signed-off-by: line is mandatory, with the same spelling.
> > > -
> > > -There are various tooling options for automatically adding these tags
> > > -include using ``git commit -s`` or ``git format-patch -s``. For more
> > > +this and happy for it to go into QEMU". For full guidance, read the
> > > +:ref:`code-provenance` documentation.
> > > +
> > >  information see `SubmittingPatches 1.12
> > >  <http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
> > 
> > this "information" now looks orphaned or am I confused?
> 
> Yes, forgot to cull it.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


