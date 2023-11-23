Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B477B7F5FA8
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 14:02:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r69L4-00034C-0L; Thu, 23 Nov 2023 08:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r69Kb-0002xY-2z
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:01:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r69KX-0002s1-F9
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:01:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-547e7de7b6fso1690470a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700744472; x=1701349272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PE8/nu2AJ4t3+zQB0x8SCKFIeqDcw3DqliPXfbIfj4w=;
 b=XIevTsB9h6aDp05QBUVq6Be3UNgE4VKdGkw9CLaidxKggxPqAnkgCI8xN4D/CoRre/
 I9LX+HE92hlPHtbrwU54UthElNB9jh6sKyTAiR8E7uVCkAvFqxfCo62AaJk16tEXRPu1
 Srcvp1RYfLi/IZQBDDZr90uz66ZesqWThC0DJZy2nl10FUWxQY/Fb7YNTkA6fTMzuIu5
 mG/wmRdxddRZP0vXrK01JROdxkyXgMgIkKzzk/VZfBKlMvqcAeIZed3Zr2/h7yxWsfpj
 1ueJjt4L3NbtHixeqHtsgs1nYFFI5/e7N5zoF5zDTAzKICpcRIK2bO1w1MdjY+ZJVg36
 +DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700744472; x=1701349272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PE8/nu2AJ4t3+zQB0x8SCKFIeqDcw3DqliPXfbIfj4w=;
 b=pChPC84KBe4IDE1Ox1qwsbYwU7AM0NUN68wHEEICa6SbtM5zgP/btz+3k1+9GQxcSO
 UkhR+18v8cKdIanYhMNhBeFV2qBjK7Raa/siOCp45J+EBs6gK4cwYNbcMJYJF0eAqkWz
 +ePC/WLbKJKVKUSpkLvkphiG52mC0w53BSFIFn1kw/WM7HjMdXXOKd57kNDIWxO1NDtx
 TZxUb2G8S2lhnkXjtS+6xzODeguBSh6JpOsz1qrpkrn+RF/L1UK+oj/yVfvdilTT6rgZ
 0j6/apcbCALNDdNSzYhY2LJBbyKRrHXwRGdSEwUKCAxeCpgsYofDMhEn5iQ+Aoc2HyRl
 ur5A==
X-Gm-Message-State: AOJu0Yw4EzofjuHA1P16djfUCdr1Ez+gAi63N7AIeUfsSs8HtTmTt0d0
 cQCgt1tAtEKtrFOyvc/8ihTR8vu9a3YzadiYZ4pfhA==
X-Google-Smtp-Source: AGHT+IFY9nVz0LDzXcAnOV3Xm/E8+LtVyIJZrYo01RFtx2spqmJDcHNo1/7Hqe4MVftyq8aeM2EaDR1NVeJfo7m7gdQ=
X-Received: by 2002:a50:ed13:0:b0:547:ebe:2561 with SMTP id
 j19-20020a50ed13000000b005470ebe2561mr1906574eds.14.1700744471915; Thu, 23
 Nov 2023 05:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
In-Reply-To: <20231123114026.3589272-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2023 13:01:00 +0000
Message-ID: <CAFEAcA_1EkO3PnaYruMLWAaPHNLrrMXwuMohTi5gKLwa0P=Ljw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01,
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

On Thu, 23 Nov 2023 at 11:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Currently we have a short paragraph saying that patches must include
> a Signed-off-by line, and merely link to the kernel documentation.
> The linked kernel docs have alot of content beyond the part about

"a lot"

> sign-off an thus is misleading/distracting to QEMU contributors.

"and thus are"

>
> This introduces a dedicated 'code-provenance' page in QEMU talking
> about why we require sign-off, explaining the other tags we commonly
> use, and what to do in some edge cases.

Good idea; I've felt for a while now that it was a little awkward
to have to point people at that big kernel doc page.


> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/devel/code-provenance.rst    | 197 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  18 +--
>  3 files changed, 201 insertions(+), 15 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> new file mode 100644
> index 0000000000..b4591a2dec
> --- /dev/null
> +++ b/docs/devel/code-provenance.rst
> @@ -0,0 +1,197 @@
> +.. _code-provenance:
> +
> +Code provenance
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +of the ``Signed-off-by`` lines, matches that of the git commit ``Author`=
`
> +field. If the person sending the mail is also one of the patch authors,
> +it is further expected that the mail ``From:`` line name & address match
> +one of the ``Signed-off-by`` lines.

Is it? Patches sent via the sr.ht service won't do that, and I'm
pretty sure we've had a few contributors in the past who send
patches from different addresses to avoid problems with their
corporate mail server mangling patches. I think this would be
better softened to something like a recommendation ("Generally
you should use the same email addresses ... ").

> +Multiple authorship
> +~~~~~~~~~~~~~~~~~~~
> +
> +It is not uncommon for a patch to have contributions from multiple
> +authors. In such a scenario, a git commit will usually be expected
> +to have a ``Signed-off-by`` line for each contributor involved in
> +creatin of the patch. Some edge cases:

"creation" (not "creating")

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

missing '.' (or perhaps ':').

> +
> + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> +   on the mailing list, if they consider the patch acceptable, they
> +   should send an email reply containing a ``Reviewed-by`` tag.
> +
> +   NB: a subsystem maintainer sending a pull request would replace
> +   their own ``Reviewed-by`` with another ``Signed-off-by``

I agree with Philippe here -- you add signed-off-by, you don't
replace reviewed-by.

> +
> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> +   that touches their subsystem, but intends to allow a different
> +   maintainer to queue it and send a pull request, they would send
> +   a mail containing a ``Acked-by`` tag.

I would personally also say "Acked-by does not imply a full code
review of the patch; if the subsystem maintainer has done a full
review, they should use the Reviewed-by tag instead."

But I know that there are some differences of opinion on exactly
what Acked-by: means...

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

Maybe we should add a bit of encouraging text here along the lines of:

Reviewing and testing is something anybody can do -- if you've
reviewed the code or tested it, feel free to send an email with
your tag to say you've done that, or to ask questions if there's
part of the patch you don't understand.

? Or perhaps that would be better elsewhere; IDK.

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
> +The subsystem maintainer submitting a pull request is **NOT** expected t=
o
> +have a ``Reviewed-by`` tag on the patch, since this is implied by their
> +own ``Signed-off-by``.

As above, Signed-off-by doesn't imply Reviewed-by. If the
submaintainer has reviewed the patch, they add the R-by,
but if they haven't done that, then they only add the S-o-by.

> +
> +Tools for adding ``Signed-of-by``
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

You might want to use two different email domains in this example;
an abandoned project picked up by somebody from the same company
(assuming the usual copyright-belongs-to-company) is a bit different
from an abandoned project picked up by an entirely unrelated person.

I think in this case it's also worth stating the general principles:

=3D=3D=3Dbegin=3D=3D=3D
The general principles with picking up abandoned work are:
 * we should continue to credit the first author for their work
 * we should track the provenance of the code
 * we should also acknowledge the efforts of the person picking
   up the work
 * the commit messages should indicate who is responsible for
   what parts of the final patch

In complicated cases or if in doubt, you can always ask on the
mailing list for advice.

If the new work you'd need to do to resubmit the patches is
significant, it's worth dropping the original author a
friendly email to let them know, in case you might be
duplicating something the original author is still working on.
=3D=3D=3Dendit=3D=3D=3D

perhaps ?

thanks
-- PMM

