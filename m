Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A71CB7F5FFA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 14:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r69Zd-0002iF-1f; Thu, 23 Nov 2023 08:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r69ZZ-0002hr-13
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:16:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r69ZW-0002fb-6c
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700745404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkabsX/5pHbH/ITIj5JZl5EsGMpXNJi2yi99uy6Cv60=;
 b=YG0dCPGA35+VfT4ZN+sjZKjO9sNwu6fOgl7pzfkgDeIIMm7UCQwMYqnJi215Ka6hLfVPDP
 vIk8AYbBe9qSUQ6fXpI/B7eDEr1RjeA7fVDcq293fdePIihb0lc143fm2X0i0as8efLxut
 d93IZ3sbzTU4pTJGqJI7wSXmbCIbn80=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-2lVJX7khPbqXGLvYJPShYg-1; Thu,
 23 Nov 2023 08:16:39 -0500
X-MC-Unique: 2lVJX7khPbqXGLvYJPShYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 367EA3C025B9;
 Thu, 23 Nov 2023 13:16:39 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42821C1596F;
 Thu, 23 Nov 2023 13:16:37 +0000 (UTC)
Date: Thu, 23 Nov 2023 14:16:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZV9QtIkJJvZyQbRn@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123114026.3589272-2-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 23.11.2023 um 12:40 hat Daniel P. Berrangé geschrieben:
> Currently we have a short paragraph saying that patches must include
> a Signed-off-by line, and merely link to the kernel documentation.
> The linked kernel docs have alot of content beyond the part about
> sign-off an thus is misleading/distracting to QEMU contributors.
> 
> This introduces a dedicated 'code-provenance' page in QEMU talking
> about why we require sign-off, explaining the other tags we commonly
> use, and what to do in some edge cases.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/code-provenance.rst    | 197 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  18 +--
>  3 files changed, 201 insertions(+), 15 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> new file mode 100644
> index 0000000000..b4591a2dec
> --- /dev/null
> +++ b/docs/devel/code-provenance.rst
> @@ -0,0 +1,197 @@
> +.. _code-provenance:
> +
> +Code provenance
> +===============
> +
> +Certifying patch submissions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The QEMU community **mandates** all contributors to certify provenance
> +of patch submissions they make to the project. To put it another way,
> +contributors must indicate that they are legally permitted to contribute
> +to the project.
> +
> +Certification is achieved with a low overhead by adding a single line
> +to the bottom of every git commit::
> +
> +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
> +
> +This existence of this line asserts that the author of the patch is
> +contributing in accordance with the `Developer's Certificate of
> +Origin <https://developercertifcate.org>`__:
> +
> +.. _dco:
> +
> +::
> +  Developer's Certificate of Origin 1.1
> +
> +  By making a contribution to this project, I certify that:
> +
> +  (a) The contribution was created in whole or in part by me and I
> +      have the right to submit it under the open source license
> +      indicated in the file; or
> +
> +  (b) The contribution is based upon previous work that, to the best
> +      of my knowledge, is covered under an appropriate open source
> +      license and I have the right under that license to submit that
> +      work with modifications, whether created in whole or in part
> +      by me, under the same open source license (unless I am
> +      permitted to submit under a different license), as indicated
> +      in the file; or
> +
> +  (c) The contribution was provided directly to me by some other
> +      person who certified (a), (b) or (c) and I have not modified
> +      it.
> +
> +  (d) I understand and agree that this project and the contribution
> +      are public and that a record of the contribution (including all
> +      personal information I submit with it, including my sign-off) is
> +      maintained indefinitely and may be redistributed consistent with
> +      this project or the open source license(s) involved.
> +
> +It is generally expected that the name and email addresses used in one
> +of the ``Signed-off-by`` lines, matches that of the git commit ``Author``
> +field. If the person sending the mail is also one of the patch authors,
> +it is further expected that the mail ``From:`` line name & address match
> +one of the ``Signed-off-by`` lines. 

Isn't the S-o-b expected even if the person sending the mail isn't one
of the patch authors, i.e. certifying (c) rather than (a) or (b) from
the DCO? This is essentially the same case as what a subsystem
maintainer does.

> +Multiple authorship
> +~~~~~~~~~~~~~~~~~~~
> +
> +It is not uncommon for a patch to have contributions from multiple
> +authors. In such a scenario, a git commit will usually be expected
> +to have a ``Signed-off-by`` line for each contributor involved in
> +creatin of the patch. Some edge cases:
> +
> +  * The non-primary author's contributions were so trivial that
> +    they can be considered not subject to copyright. In this case
> +    the secondary authors need not include a ``Signed-off-by``.
> +
> +    This case most commonly applies where QEMU reviewers give short
> +    snippets of code as suggested fixes to a patch. The reviewers
> +    don't need to have their own ``Signed-off-by`` added unless
> +    their code suggestion was unusually large.
> +
> +  * Both contributors work for the same employer and the employer
> +    requires copyright assignment.
> +
> +    It can be said that in this case a ``Signed-off-by`` is indicating
> +    that the person has permission to contributeo from their employer
> +    who is the copyright holder. It is none the less still preferrable
> +    to include a ``Signed-off-by`` for each contributor, as in some
> +    countries employees are not able to assign copyright to their
> +    employer, and it also covers any time invested outside working
> +    hours.
> +
> +Other commit tags
> +~~~~~~~~~~~~~~~~~
> +
> +While the ``Signed-off-by`` tag is mandatory, there are a number of
> +other tags that are commonly used during QEMU development
> +
> + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> +   on the mailing list, if they consider the patch acceptable, they
> +   should send an email reply containing a ``Reviewed-by`` tag.
> +
> +   NB: a subsystem maintainer sending a pull request would replace
> +   their own ``Reviewed-by`` with another ``Signed-off-by``

As Philippe already mentioned, this isn't necessarily the case. It's a
common enough practice to add a S-o-b (which technically only certifies
the DCO) without removing the R-b (which tells that the content was
actually reviewed in detail - maintainers don't always do that if there
are already R-bs from trusted community members).

> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> +   that touches their subsystem, but intends to allow a different
> +   maintainer to queue it and send a pull request, they would send
> +   a mail containing a ``Acked-by`` tag.
> +   

Trailing whitespace?

> + * **``Tested-by``**: when a QEMU community member has functionally
> +   tested the behaviour of the patch in some manner, they should
> +   send an email reply conmtaning a ``Tested-by`` tag.
> +
> + * **``Reported-by``**: when a QEMU community member reports a problem
> +   via the mailing list, or some other informal channel that is not
> +   the issue tracker, it is good practice to credit them by including
> +   a ``Reported-by`` tag on any patch fixing the issue. When the
> +   problem is reported via the GitLab issue tracker, however, it is
> +   sufficient to just include a link to the issue.
> +
> +Subsystem maintainer requirements
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When a subsystem maintainer accepts a patch from a contributor, in
> +addition to the normal code review points, they are expected to validate
> +the presence of suitable ``Signed-off-by`` tags.
> +
> +At the time they queue the patch in their subsystem tree, the maintainer
> +**MUST** also then add their own ``Signed-off-by`` to indicate that they
> +have done the aforementioned validation.
> +
> +The subsystem maintainer submitting a pull request is **NOT** expected to
> +have a ``Reviewed-by`` tag on the patch, since this is implied by their
> +own ``Signed-off-by``.

Considering the above, I would remove this last paragraph.

Kevin


