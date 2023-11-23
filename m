Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB67F5E94
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:59:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r68Lk-00010B-AA; Thu, 23 Nov 2023 06:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r68Li-0000zO-Al
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:58:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r68Lf-00036P-S3
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:58:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b2a8575d9so4896455e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700740702; x=1701345502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U9GOy43Uhb0XDebkTgSkhFTosrXiV9bbPAmwVd1fzeQ=;
 b=GCSdoH5RUs1BnJm6KSEkF3Gx9LthxrjH+RZstfDM/ceswS9gTtV5clMPsQQeiQcHZo
 g1Xkps/Y4dOU8fo+X+WDOs28VVIOWW9D0l3eg8VYWXZ+892Y41JIlFMWzOIaiMW/sJx8
 GosfqQSCMl8+x2KlkvUp/mSxUJP/gtH050rUMerYwKSrstg4O9xgW70PaOcF5IRElzho
 KfVi2w5MW6X2CwLaJMXP4NQW9xXoQRPAhiz6VMj/E6PRqhOBfeTUgiyBxAqA0EsNbAoS
 +I56Z52ngcIifl6NhyxO5uC7bxxAv5V0l/cIVQH28VaY19qE7wr1TfNJJqqtB6q07zlg
 u7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700740702; x=1701345502;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9GOy43Uhb0XDebkTgSkhFTosrXiV9bbPAmwVd1fzeQ=;
 b=IOcIzjUHcr+C25+RHuvYn/VlRYpMWzAROm1R2leq6eK62Iyi++RXRgRWn8F5kGp14q
 JL/+yS7QYDqV2GFfOVKVwvMrIQitY3Jk8/rI6spCmPX4pygtHPumy/O2M3hjjeXVfyr9
 b4UTQZMRFJUtFujLp5JdMpzvhoi6qN+W2cGfw51JOtg8oqoyS2/gFjR+PeUs7eKRr7ep
 3NTcfqTR3YevVSAbM/kOGtmIkHmA17GczQEotsoOAgwa8eUUTFxYj3KC/a8mtfyMYtUE
 vk4KINyAgUH26WzggAiyYQREsQlSTkMRT2OyMoDaoDCjmgvJXLVKc3bIgn1Fqm7S8EDx
 tvIQ==
X-Gm-Message-State: AOJu0YwKEzGvZIah1qJHY0EkwAmZ62e7VwWobsZ6H6m1fQy/t+GHz3FB
 +/THN6Y8vd6C0uLVtq3iQsOjPw==
X-Google-Smtp-Source: AGHT+IHRq68EdcV071HGu2yjjLDbAbTtVisNEQMN3yUVHYQ+wkqUSsAKHkHVeHAKmvYADfo7eiUTYQ==
X-Received: by 2002:a5d:47c7:0:b0:331:6977:1e20 with SMTP id
 o7-20020a5d47c7000000b0033169771e20mr4641663wrc.59.1700740701798; 
 Thu, 23 Nov 2023 03:58:21 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a5d4143000000b0032da49e18fasm1478418wrq.23.2023.11.23.03.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:58:21 -0800 (PST)
Message-ID: <d3998e03-8f91-4bc3-896f-4a8f3174e442@linaro.org>
Date: Thu, 23 Nov 2023 12:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123114026.3589272-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 23/11/23 12:40, Daniel P. Berrangé wrote:
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
>   docs/devel/code-provenance.rst    | 197 ++++++++++++++++++++++++++++++
>   docs/devel/index-process.rst      |   1 +
>   docs/devel/submitting-a-patch.rst |  18 +--
>   3 files changed, 201 insertions(+), 15 deletions(-)
>   create mode 100644 docs/devel/code-provenance.rst
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

Typo: https://developercertificate.org/

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

"creating"

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

"contribute"

> +    who is the copyright holder. It is none the less still preferrable

"preferable"

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

Hmm not sure about replacing, they have different meaning. You can merge
patch you haven't reviewed. But as a maintainer you must S-o-b what you
end merging (what is mentioned below in "subsystem maintainer").

> +
> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> +   that touches their subsystem, but intends to allow a different
> +   maintainer to queue it and send a pull request, they would send
> +   a mail containing a ``Acked-by`` tag.
> +
> + * **``Tested-by``**: when a QEMU community member has functionally
> +   tested the behaviour of the patch in some manner, they should
> +   send an email reply conmtaning a ``Tested-by`` tag.

"containing"

> +
> + * **``Reported-by``**: when a QEMU community member reports a problem
> +   via the mailing list, or some other informal channel that is not
> +   the issue tracker, it is good practice to credit them by including
> +   a ``Reported-by`` tag on any patch fixing the issue. When the
> +   problem is reported via the GitLab issue tracker, however, it is
> +   sufficient to just include a link to the issue.

Hmm isn't related to the "Resolves:" tag?

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
> +
> +Tools for adding ``Signed-of-by``

"Signed-off-by"

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
>      maintainers
>      style
>      submitting-a-patch
> +   code-provenance
>      trivial-patches
>      stable-process
>      submitting-a-pull-request
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index c641d948f1..ec541b3d15 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -322,21 +322,9 @@ Patch emails must include a ``Signed-off-by:`` line
>   
>   Your patches **must** include a Signed-off-by: line. This is a hard
>   requirement because it's how you say "I'm legally okay to contribute
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
>   information see `SubmittingPatches 1.12
>   <http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
>   


