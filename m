Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C397F65BF
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:47:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Dmd-0004mc-GX; Thu, 23 Nov 2023 12:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DmZ-0004Vo-Cy
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DmW-0007Lr-P1
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700761586;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FH+61h5dYdrZ/OTrriafKIW0Sd6ukBY/OkKysArgCfg=;
 b=AmnAsut3k3xKTl5GMkvnkwH4FznC6cLjv942aGXk89/Yr+sAj+F3lcJP1KfxonAzegT4lD
 ZlZcZyKODYaGkf1tDMgdHcrph7vEipboqoai6z/L1puQZa2KueDHiDAOtsJ4A/C7obJkWD
 f2eMDeF/Vl5hbvOaIrvkno8xg/R3ONg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GBxrM2MBN3ObK33Tx64hng-1; Thu, 23 Nov 2023 12:46:23 -0500
X-MC-Unique: GBxrM2MBN3ObK33Tx64hng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21B8A185A784;
 Thu, 23 Nov 2023 17:46:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA4E2026D66;
 Thu, 23 Nov 2023 17:46:19 +0000 (UTC)
Date: Thu, 23 Nov 2023 17:46:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <ZV-P6M8seKmMKGCB@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0kgeiex.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On Thu, Nov 23, 2023 at 12:57:42PM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > There has been an explosion of interest in so called "AI" (LLM)
> > code generators in the past year or so. Thus far though, this is
> > has not been matched by a broadly accepted legal interpretation
> > of the licensing implications for code generator outputs. While
> > the vendors may claim there is no problem and a free choice of
> > license is possible, they have an inherent conflict of interest
> > in promoting this interpretation. More broadly there is, as yet,
> > no broad consensus on the licensing implications of code generators
> > trained on inputs under a wide variety of licenses.
> >
> > The DCO requires contributors to assert they have the right to
> > contribute under the designated project license. Given the lack
> > of consensus on the licensing of "AI" (LLM) code generator output,
> > it is not considered credible to assert compliance with the DCO
> > clause (b) or (c) where a patch includes such generated code.
> >
> > This patch thus defines a policy that the QEMU project will not
> > accept contributions where use of "AI" (LLM) code generators is
> > either known, or suspected.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index b4591a2dec..a6e42c6b1b 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -195,3 +195,43 @@ example::
> >    Signed-off-by: Some Person <some.person@example.com>
> >    [Rebased and added support for 'foo']
> >    Signed-off-by: New Person <new.person@example.com>
> > +
> > +Use of "AI" (LLM) code generators
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +TL;DR:
> > +
> > +  **Current QEMU project policy is to DECLINE any contributions
> > +  which are believed to include or derive from "AI" (LLM)
> > +  generated code.**
> > +
> > +The existence of "AI" (`Large Language Model <https://en.wikipedia.org/wiki/Large_language_model>`__
> > +/ LLM) code generators raises a number of difficult legal questions, a
> > +number of which impact on Open Source projects. As noted earlier, the
> > +QEMU community requires that contributors certify their patch submissions
> > +are made in accordance with the rules of the :ref:`dco` (DCO). When a
> > +patch contains "AI" generated code this raises difficulties with code
> > +provenence and thus DCO compliance.
> 
> I agree this is going to be a field that keeps lawyers well re-numerated
> for the foreseeable future. However I suspect this elides over the main
> use case for LLM generators which is non-novel transformation. One good
> example is generating text fixtures where you write a piece of original
> code and then ask the code completion engine to fill out some unit tests
> to exercise the code. It's boring mechanical work but one an LLM is very
> suited to (even if you might tweak the final result).

Yes, I can see how that is helpful, but I think in many cases the
resulting code will be complex enough to be considered copyrightable,
and so even with the original input code, I feel the licensing of the
output is still ill-defined.

> 
> > +To satisfy the DCO, the patch contributor has to fully understand
> > +the origins and license of code they are contributing to QEMU. The
> > +license terms that should apply to the output of an "AI" code generator
> > +are ill-defined, given that both training data and operation of the
> > +"AI" are typically opaque to the user. Even where the training data
> > +is said to all be open source, it will likely be under a wide variety
> > +of license terms.
> > +
> > +While the vendor's of "AI" code generators may promote the idea that
> > +code output can be taken under a free choice of license, this is not
> > +yet considered to be a generally accepted, nor tested, legal opinion.
> > +
> > +With this in mind, the QEMU maintainers does not consider it is
> > +currently possible to comply with DCO terms (b) or (c) for most "AI"
> > +generated code.
> 
> There is a load of code out that isn't eligible for copyright projection
> because it doesn't demonstrate much originality or creativity. In the
> experimentation I've done so far I've not seen much sign of genuine
> creativity. LLM's benefit from having access to a wide corpus of
> training data and tend to do a better job of inferencing solutions from
> semi-related posts than say for example human manually comparing posts
> having pasted an error message in google.

The boundary between what is considered copyrightable and not, it
itself quite ill-defined, and thus it is hard to express a clear
rule that can be applied.

I think more experience long term contributors end up getting somewhat
of a "gut feeling" about what's ok and what's not, but I'm not sure if
that is true for contibutors in general.

IOW, while there are likely cases where it is possible to safely use
a AI generator, I'm not sure how to best express that in an way that
makes sense.

Perhaps a loosely worded addendum  about possible exception for
"trivial" output

> > +The QEMU maintainers thus require that contributors refrain from using
> > +"AI" code generators on patches intended to be submitted to the project,
> > +and will decline any contribution if use of "AI" is known or suspected.
> > +
> > +Examples of tools impacted by this policy includes both GitHub CoPilot,
> > +and ChatGPT, amongst many others which are less well known.
> 
> What about if you took an LLM and then fine tuned it by using project
> data so it could better help new users in making contributions to the
> project? You would be biasing the model to your own data for the
> purposes of helping developers write better QEMU code?

It is hard to provide an answer to that question, since I think it is
something that would need to be considered case by case. It hinges
around how much does the new QEMU specific training data influence
the model, vs other pre-existing training (if any)

Perhaps we can finish this policy with a general point to solicit
feedback on possible exceptions ?

  "If a contributor believes they can demonstrate that the output of
   a particular tool has deterministic licensing, such that they can
   satisfy the DCO, they should provide such info to the mailing list"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


