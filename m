Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A08637F65DE
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:00:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Dyn-0000ZP-L6; Thu, 23 Nov 2023 12:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6Dyf-0000Ys-0v
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6Dya-0003vW-HJ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700762335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+QJaVYI9YO1//DwWMdTtuWgpFsUYrJCTzfJCMttkZQ=;
 b=i31AonvEGAEUdseTWVdNZC9QTjpvk3A495/zTlG6KNee99ihIbiPOSScHQmW82CkBAqbjk
 dBVN8jKgoV/v6DpZFNGNIz5VPXMh51a6hKWUeofyf5p8NajYqZD2oG+BMN0tLC9zcEnNeW
 /h4ClOv/+grOLyhBBGpDt0e/U4shvBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-2pgRW7NpOUi3eyobTW7JRg-1; Thu, 23 Nov 2023 12:58:51 -0500
X-MC-Unique: 2pgRW7NpOUi3eyobTW7JRg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FFFF101A529;
 Thu, 23 Nov 2023 17:58:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12642492BE0;
 Thu, 23 Nov 2023 17:58:47 +0000 (UTC)
Date: Thu, 23 Nov 2023 17:58:45 +0000
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
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <ZV-S1f2cK8MLNizz@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123092523-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Thu, Nov 23, 2023 at 09:35:43AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrangé wrote:
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
> > +
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
> > +
> > +The QEMU maintainers thus require that contributors refrain from using
> > +"AI" code generators on patches intended to be submitted to the project,
> > +and will decline any contribution if use of "AI" is known or suspected.
> > +
> > +Examples of tools impacted by this policy includes both GitHub CoPilot,
> > +and ChatGPT, amongst many others which are less well known.
> 
> 
> So you called out these two by name, fine, but given "AI" is in scare
> quotes I don't really know what is or is not allowed and I don't know
> how will contributors know.  Is the "AI" that one must not use
> necessarily an LLM?  And how do you define LLM even? Wikipedia says
> "general-purpose language understanding and generation".

I used "AI" in quotes, because I think it can mean different things to
different people. In practical terms it has become a bit of a catch
all term for a wide variety of tools. Thus I think the quote serve to
express this as a loose generalization, rather than a precise definition.

The same for "LLM", I don't want to try to define it, as it has also
become somewhat of a general term. 

> All this seems vague to me.

Delibrately so, as there are a wide variety of tools working in
varying ways, but all with similar caveats around the licensing
of the output "derivative" work.

> However, can't we define a simpler more specific policy?
> For example, isn't it true that *any* automatically generated code
> can only be included if the scripts producing said code
> are also included or otherwise available under GPLv2?

The license of a code generation tool itself is usually considered
to be not a factor in the license of its output.

In most cases the license of the input data will determine the
license of the output data, since the latter is a derivative
work of the former. The person runing the tool will typically
know exact what the input data is, and so have confidence over
the license of the output.

If there are questions about whether the output is a derivative
of the tool's code itself, then the tool author can provide an
disclaimer for this.  Such a disclaimer though, would not erase
the derivative link between input data and output data. One
example is GCC where the output .o/exe is a derivative of the
input .c.  The output, however, may also link the gcc runtime
library, and so GCC has a license exception saying that this
runtime linkage doesn't affect the license of the output
program. This is OK, since the GCC authors who added this
exception owned copyright over the runtime library they're
adding an exception for.

If we apply this to LLMs, the output of the LLM is a derivative
of the training data. The output is not a derivative of the LLM
code. The LLM copyright holders could make this latter point
explicit since they own copyright of the LLM code, but they do
not own copyright of the training data, and neither does the
person using the LLM, hence the legal uncertainty.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


