Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82A7F6168
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6AeE-0004NY-7c; Thu, 23 Nov 2023 09:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Ae2-0004Lo-9k
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Adz-0006cn-U5
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700749522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbYPu+sA8bUpC8kAYSGRPa/KCpiU3AhafdBdZmrbdPY=;
 b=EIclxETiqLq+F9xrbOva30yDwKALzMC2ZrYviDZAgX7QynCu8WZgGB+2Tnkqw8I8N1ObGh
 wGEcfj4k7sxVxhFSNdPg+mveNh0zQCerMe0AmWO+yZ+5q2eay3edilBjmksM72t+FMg1i9
 By/00c1OnVpBtIUBbBbteuoyPdR5B1o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-UooOkJQ6MZGDiCGnno3_XA-1; Thu, 23 Nov 2023 09:25:20 -0500
X-MC-Unique: UooOkJQ6MZGDiCGnno3_XA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c88814a48eso9209061fa.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700749519; x=1701354319;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HbYPu+sA8bUpC8kAYSGRPa/KCpiU3AhafdBdZmrbdPY=;
 b=BKGSO7Fywvxjy79Gre9ocVapAUWnE2lGXtB96Yk4fmrHzKJ4A3vc5YuNO6GRpnEEeF
 gyIWf8Ag4+gMsJUwYOoohHlDBIx+SPd91I+HjyyEt5XHw+efl5k2CkHwSesjjsZ/DDGE
 zMWsySBlLrgfqllNFtV2FWF9jtje/nRXJz85CC4HvMJn9RD1f7KC06rNDhoOIA0lvj3M
 vwUwv7dDuYEvzuIj0sKeuCAcAQi+7hYjKsRtwlPv2BqEwGpBIGfBVFP3aETrIcOrC/Aw
 Ot+YPiSOlwAupEoyXAg+oyrIGnVZtvrQpjrVWVnkyIb8d4fz+pHdfK5YBYnEdU5daj2g
 JKrQ==
X-Gm-Message-State: AOJu0Yzj/Swqm6yYXc6Dsoz5CeawU5D344/mxBmcUBELi5HZ9doh9n5E
 G1O1eRfL8L2dOlqgSG7/j/Jg7Tp/0WfCXSTMiUY9KV7gwyvruf7VoNtQoioL236cLYoVl1QqZQE
 I0/OmXNCqCyxbSxE=
X-Received: by 2002:a05:651c:8d:b0:2c8:8c65:84e5 with SMTP id
 13-20020a05651c008d00b002c88c6584e5mr4382122ljq.10.1700749519354; 
 Thu, 23 Nov 2023 06:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQAQnnLaWwgL6SpoG3ty6z9mFidAyNRy7SWVJ6zVi1UljDHXNOXydrJtvlbVMEoxwxkQ0r/A==
X-Received: by 2002:a05:651c:8d:b0:2c8:8c65:84e5 with SMTP id
 13-20020a05651c008d00b002c88c6584e5mr4382094ljq.10.1700749518785; 
 Thu, 23 Nov 2023 06:25:18 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:dd6e:61bc:cc48:699f:b2ce])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a05600c458400b0040648217f4fsm2817936wmo.39.2023.11.23.06.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 06:25:18 -0800 (PST)
Date: Thu, 23 Nov 2023 09:25:13 -0500
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
Message-ID: <20231123091654-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123114026.3589272-2-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Nov 23, 2023 at 11:40:25AM +0000, Daniel P. Berrangé wrote:
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

Great initiative! I think we needed this for a while now.



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

The existence?

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
> +
> +Multiple authorship
> +~~~~~~~~~~~~~~~~~~~
> +
> +It is not uncommon for a patch to have contributions from multiple
> +authors. In such a scenario, a git commit will usually be expected
> +to have a ``Signed-off-by`` line for each contributor involved in
> +creatin of the patch. Some edge cases:

creation

> +
> +  * The non-primary author's contributions were so trivial that
> +    they can be considered not subject to copyright. In this case
> +    the secondary authors need not include a ``Signed-off-by``.
> +
> +    This case most commonly applies where QEMU reviewers give short
> +    snippets of code as suggested fixes to a patch. The reviewers
> +    don't need to have their own ``Signed-off-by`` added unless
> +    their code suggestion was unusually large.

It is still a good policy to include attribution, e.g.
by adding a Suggested-by tag.


> +
> +  * Both contributors work for the same employer and the employer
> +    requires copyright assignment.
> +
> +    It can be said that in this case a ``Signed-off-by`` is indicating
> +    that the person has permission to contributeo from their employer

contribute

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
> +
> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> +   that touches their subsystem, but intends to allow a different
> +   maintainer to queue it and send a pull request, they would send
> +   a mail containing a ``Acked-by`` tag.
> +   
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


Suggested-by is also common.

As long as we are here, let's document Fixes: and Cc: ?


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


Below you say **must** - I think that is better, no need to shout.

> +
> +The subsystem maintainer submitting a pull request is **NOT** expected to
> +have a ``Reviewed-by`` tag on the patch, since this is implied by their
> +own ``Signed-off-by``.
> +  
> +Tools for adding ``Signed-of-by``


Signed-off-by

> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +There are a variety of ways tools can support adding ``Signed-off-by``
> +tags for patches, avoiding the need for contributors to manually
> +type in this repetitive text each time.
> +
> +git commands
> +^^^^^^^^^^^^
> +
> +When creating, or amending, a commit the ``-s`` flag to ``git commit``
> +will append a suitable line matching the configuring git author
> +details.
> +
> +If preparing patches using the ``git format-patch`` tool, the ``-s``
> +flag can be used to append a suitable line in the emails it creates,
> +without modifying the local commits. Alternatively to modify the
> +local commits on a branch en-mass::
> +
> +  git rebase master -x 'git commit --amend --no-edit -s'
> +
> +emacs
> +^^^^^
> +
> +In the file ``$HOME/.emacs.d/abbrev_defs`` add::
> +
> +  (define-abbrev-table 'global-abbrev-table
> +    '(
> +      ("8rev" "Reviewed-by: YOUR NAME <your@email.addr>" nil 1)
> +      ("8ack" "Acked-by: YOUR NAME <your@email.addr>" nil 1)
> +      ("8test" "Tested-by: YOUR NAME <your@email.addr>" nil 1)
> +      ("8sob" "Signed-off-by: YOUR NAME <your@email.addr>" nil 1)
> +     ))
> +
> +with this change, if you type (for example) ``8rev`` followed
> +by ``<space>`` or ``<enter>`` it will expand to the whole phrase. 
> +
> +vim
> +^^^
> +
> +In the file ``$HOME/.vimrc`` add::
> +
> +  iabbrev 8rev Reviewed-by: YOUR NAME <your@email.addr>
> +  iabbrev 8ack Acked-by: YOUR NAME <your@email.addr>
> +  iabbrev 8test Tested-by: YOUR NAME <your@email.addr>
> +  iabbrev 8sob Signed-off-by: YOUR NAME <your@email.addr>
> +
> +with this change, if you type (for example) ``8rev`` followed
> +by ``<space>`` or ``<enter>`` it will expand to the whole phrase. 
> +
> +Re-starting abandoned work
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For a variety of reasons there are some patches that get submitted to
> +QEMU but never merged. An unrelated contributor may decide (months or
> +years later) to continue working from the abandoned patch and re-submit
> +it with extra changes.
> +
> +If the abandoned patch already had a ``Signed-off-by`` from the original
> +author this **must** be preserved. The new contributor **must** then add
> +their own ``Signed-off-by`` after the original one if they made any
> +further changes to it. It is common to include a comment just prior to
> +the new ``Signed-off-by`` indicating what extra changes were made. For
> +example::
> +
> +  Signed-off-by: Some Person <some.person@example.com>
> +  [Rebased and added support for 'foo']
> +  Signed-off-by: New Person <new.person@example.com>
> diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
> index 362f97ee30..b54e58105e 100644
> --- a/docs/devel/index-process.rst
> +++ b/docs/devel/index-process.rst
> @@ -13,6 +13,7 @@ Notes about how to interact with the community and how and where to submit patch
>     maintainers
>     style
>     submitting-a-patch
> +   code-provenance
>     trivial-patches
>     stable-process
>     submitting-a-pull-request
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index c641d948f1..ec541b3d15 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -322,21 +322,9 @@ Patch emails must include a ``Signed-off-by:`` line
>  
>  Your patches **must** include a Signed-off-by: line. This is a hard
>  requirement because it's how you say "I'm legally okay to contribute
> -this and happy for it to go into QEMU". The process is modelled after
> -the `Linux kernel
> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
> -policy.
> -
> -If you wrote the patch, make sure your "From:" and "Signed-off-by:"
> -lines use the same spelling. It's okay if you subscribe or contribute to
> -the list via more than one address, but using multiple addresses in one
> -commit just confuses things. If someone else wrote the patch, git will
> -include a "From:" line in the body of the email (different from your
> -envelope From:) that will give credit to the correct author; but again,
> -that author's Signed-off-by: line is mandatory, with the same spelling.
> -
> -There are various tooling options for automatically adding these tags
> -include using ``git commit -s`` or ``git format-patch -s``. For more
> +this and happy for it to go into QEMU". For full guidance, read the
> +:ref:`code-provenance` documentation.
> +
>  information see `SubmittingPatches 1.12
>  <http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.

this "information" now looks orphaned or am I confused?


> -- 
> 2.41.0


