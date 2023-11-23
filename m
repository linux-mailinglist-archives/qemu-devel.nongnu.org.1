Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5B7F64EC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:09:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DCH-0001c4-Ap; Thu, 23 Nov 2023 12:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DCE-0001bY-Vo
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r6DCD-00078T-6R
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700759336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/KtaZ4fuFDKV4Q10R49TwcHVmQOte7RqWb1xfAkw1o=;
 b=KPTnaG8IEJ6gHh0pK1e1wN25PCYmrMcsPeQgNfkIlaz58T7z+crprQf3t64n/Cpk0LGtdW
 Lj3dM9bvSwiATtEbQ+kZ3YeLmmprm/QFi4C7a9J5oKoQnAXftnPMF4JP8Pqzmuue6li4US
 Hv4bacQj6ARBxcmlTkhIi81gPXWGOsY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-U-qu3zbyMi2qiSOOxzt1xQ-1; Thu,
 23 Nov 2023 12:08:50 -0500
X-MC-Unique: U-qu3zbyMi2qiSOOxzt1xQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59BD81C05AB5;
 Thu, 23 Nov 2023 17:08:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65FD4C1596F;
 Thu, 23 Nov 2023 17:08:48 +0000 (UTC)
Date: Thu, 23 Nov 2023 17:08:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZV-HHpLnjOj1LPDi@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <d3998e03-8f91-4bc3-896f-4a8f3174e442@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3998e03-8f91-4bc3-896f-4a8f3174e442@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 23, 2023 at 12:58:18PM +0100, Philippe Mathieu-Daudé wrote:
> On 23/11/23 12:40, Daniel P. Berrangé wrote:
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
> >   docs/devel/code-provenance.rst    | 197 ++++++++++++++++++++++++++++++
> >   docs/devel/index-process.rst      |   1 +
> >   docs/devel/submitting-a-patch.rst |  18 +--
> >   3 files changed, 201 insertions(+), 15 deletions(-)
> >   create mode 100644 docs/devel/code-provenance.rst

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
> Hmm not sure about replacing, they have different meaning. You can merge
> patch you haven't reviewed. But as a maintainer you must S-o-b what you
> end merging (what is mentioned below in "subsystem maintainer").

I've always taken it as implied that patches I queue are reviewed by me,
but replies here suggest I'm in a minority on that.  That shows why it is
worth documenting this for QEMU explicitly :-)

> > + * **``Reported-by``**: when a QEMU community member reports a problem
> > +   via the mailing list, or some other informal channel that is not
> > +   the issue tracker, it is good practice to credit them by including
> > +   a ``Reported-by`` tag on any patch fixing the issue. When the
> > +   problem is reported via the GitLab issue tracker, however, it is
> > +   sufficient to just include a link to the issue.
> 
> Hmm isn't related to the "Resolves:" tag?

Gitlab supports a huge varity - resolves/fixes/closes/etc

I don't think this wants to turn into a full guide on what info to include
in a commit message, as we already have that in the submitting-a-patch doc,
explaining the bug link syntax. So I'll still to just the tags that
explicitly credit humans.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


