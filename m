Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF27F659C
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:38:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DeF-00083l-6V; Thu, 23 Nov 2023 12:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1r6DeD-00083W-LN
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:37:53 -0500
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1r6DeB-0003nM-PQ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:37:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7C7BC1FD66;
 Thu, 23 Nov 2023 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700761068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3MlrC1aKOHBpN3JI2tRZeQTGyCtZKW+bW+BxILBrOY=;
 b=KPIh+X/IcOnugti9Og4NBCDqG9F3ofyTd5lbtbrmHgMcawNTlBvB+/KZEgqE9C+l1vje57
 OyoyWa1jF3RQaXuGXdhXgBjErYbx0ZvgkmaVYRhUkcV6Dt+iJWQ2OQdzQN+uwaIGinrAdj
 b+1nKk/3UE6rO1D+lppMqb3bUoXgpDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700761068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3MlrC1aKOHBpN3JI2tRZeQTGyCtZKW+bW+BxILBrOY=;
 b=+7gdpnE3rhXjKtCop3tOd/Ron/4iC/oiFtMuSgGeN033nl7mZuzY9SJH32mtUAHbQPm+3w
 TcDRAljRXbFDZhBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5A3C22C16B;
 Thu, 23 Nov 2023 17:37:48 +0000 (UTC)
Date: Thu, 23 Nov 2023 18:37:47 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123173747.GV9696@kitsune.suse.cz>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0kgeiex.fsf@draig.linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spamd-Bar: +++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [13.99 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 RCPT_COUNT_TWELVE(0.00)[15]; VIOLATED_DIRECT_SPF(3.50)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 13.99
X-Rspamd-Queue-Id: 7C7BC1FD66
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=msuchanek@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It may be suited to produce such code (disputable) but the code is not
suited for inclusion into the project, for legal reasons.

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

And license of that corpus of training data is not defined.

If you could erase the copyright on anything by feeding it into a
statistical model and pulling it back out there would be some big
content license holders objecting so it's very unlikely to happen.

Consequently, for all practical purposes the "AI"/LLM output is
derivative work of the input with all legal consequences.

This is, of course, only a problem for *generative* use of AI/LLM where
the putput can contain contain copies of substantial parts of input.

Thanks

Michal

