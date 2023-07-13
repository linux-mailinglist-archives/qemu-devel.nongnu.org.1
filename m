Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A13752383
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJwGE-0003bm-EC; Thu, 13 Jul 2023 09:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJwGA-0003bZ-Ra
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:21:30 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJwG8-0006Jm-O2
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:21:30 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e6113437cso841876a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689254487; x=1691846487;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xnaStf2LdZVJQ+2NTjbH7X+yq4kHKJ2Rpy5blzVGrIw=;
 b=ASQ6hhRRY8GvddKUZCI8JuYwizf/qFoUbpTtCCkhrmWMrJYZi1fuHS0qtiQkIGfEag
 I2xF7R1L1Y3jTLz2M72ocPWnXkjACHwE7L9qTh3oGl1rhz7MwkUdmUgSxB1yNy3MTSbu
 3zl6cXQP9MYQbUFkakyiv14ktqzsQadjDKIXjf+1ywM8nvH77BU+ihVUICpNEz9p9rav
 pXpeG1Dw43U1c6rFAWIVw/1Cd9D23iRWwNxehalVxb+FSZ3BNBePU5XOtkd8f0/Wm21R
 h2DsvvNnLCijU7K/QXViU0JbVBFLhv03/zLyuVgnxR0ArXtvxntpUuF1LgJfTB2bf7Ej
 ZL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689254487; x=1691846487;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xnaStf2LdZVJQ+2NTjbH7X+yq4kHKJ2Rpy5blzVGrIw=;
 b=BCLfCHKlvc1KF0C9SM2LDT9tXUmDinTNmKDoL+AMP2rZvyeRoQ+VXdsZO8fB87oz/b
 upR6u0VFBU43CMhavK/szKUzlxHbap0KNh81xAaXiO0xb0SeAKQ4Q5iVtx99Ym7sgjpP
 5EKCLmfakH3AGww5yfCvW0ze7sB/KezQ114O5GrXkSrpThrC9Abh1RXu28N3PDU+rf8Z
 aGW+GIEyT4h4CtRmrPTvFn3FUsEBiMqsvFzvVqOS9enL1lr6G+mC1S2RUnNtIf4h8IjA
 Y1dW3H+16oewz2qd8R7/vxZveShWGMzQAnvnEsvcgHLPpoecEuxinyvndNpVEZWZI0yx
 TJ7g==
X-Gm-Message-State: ABy/qLb9PcnTII8/OLfcVwti5eGD+WhitwOc08HboGy7WFpe9UiJvikn
 L8qYSMaHyYbtjC/looB8oUUScVF22doHKZDteTthUxg1R1pQE2Sx
X-Google-Smtp-Source: APBJJlG6ciOZAc4SP3I+YmWD3ZOxynuMkr2gRPNLk9NSmLzuJQhBBIGYtObholdoZYNGIPxQtv1L799S558nlLROvyQ=
X-Received: by 2002:a05:6402:610:b0:51e:26a3:1ba3 with SMTP id
 n16-20020a056402061000b0051e26a31ba3mr1812886edv.19.1689254486619; Thu, 13
 Jul 2023 06:21:26 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 14:21:15 +0100
Message-ID: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
Subject: QEMU Summit Minutes 2023
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QEMU Summit Minutes 2023
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
invite-only meeting for the most active maintainers and submaintainers
in the project, and we discuss various project-wide issues, usually
process stuff. We then post the minutes of the meeting to the list as
a jumping off point for wider discussion and for those who weren't
able to attend.

Attendees
=3D=3D=3D=3D=3D=3D=3D=3D=3D

"Peter Maydell" <peter.maydell@linaro.org>
"Alex Benn=C3=A9e" <alex.bennee@linaro.org>
"Kevin Wolf" <kwolf@redhat.com>
"Thomas Huth" <thuth@redhat.com>
"Markus Armbruster" <armbru@redhat.com>
"Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
"Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
"Daniel P. Berrang=C3=A9" <berrange@redhat.com>
"Richard Henderson" <richard.henderson@linaro.org>
"Michael S. Tsirkin" <mst@redhat.com>
"Stefan Hajnoczi" <stefanha@redhat.com>
"Alex Graf" <agraf@csgraf.de>
"Gerd Hoffmann" <kraxel@redhat.com>
"Paolo Bonzini" <pbonzini@redhat.com>
"Michael Roth" <michael.roth@amd.com>

Topic 1: Dealing with tree wide changes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Mark Cave-Ayland raised concerns that tree wide changes often get
stuck because maintainers are conservative about merging code that
touches other subsystems and doesn't have review.  He mentioned a
couple of cases of PC refactoring which had been held up and
languished on the list due to lack of review time. It can be hard to
get everything in the change reviewed, and then hard to get the change
merged, especially if it still has parts that weren't reviewed by
anybody.

Alex Benn=C3=A9e mentioned that maintainers can always give an Acked-by and
then rely on someone else doing the review. But even getting
Acked-by's can take time and we still have a problem with absent
maintainers.

In a brief diversion Markus mused that having more automated checking
for things like QAPI changes would help reduce the maintainer load for
the more mechanical changes.

It was pointed out we should be more accepting of merging changes
without explicit maintainer approval where the changes are surface
level system wide API changes rather than touching the guts of any
particular subsystem. This avoids the sometimes onerous task of
splitting mechanical tree-wide changes along subsystem boundaries.
A delay of one-week + send a ping + one-week was suggested as
sufficient time for maintainers to reply if they care specifically
about the series.

Alex Graf suggested that we should hold different standards of review
requirements depending on the importance of the sub-system. We should
not hold up code because a minor underused subsystem didn't get
signoff. We already informally do this but we don't make it very clear
so it can be hard to tell what is and isn't OK to let through without
review.

Topic 2: Are we happy with the email workflow?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This was a topic to see if there was any consensus among maintainers
about the long-term acceptability of sticking with email for patch
submission and review -- in five years' time, if we're still doing it
the same way, how would we feel about it?

One area where we did get consensus was that now that we're doing CI
on gitlab we can change pull requests from maintainers from via-email
to gitlab merge requests. This would hopefully mean that instead of
the release-manager having to tell gitlab to do a merge and then
reporting back the results of any CI failures, the maintainer
could directly see the CI results and deal with fixing up failures
and resubmitting without involving the release manager. (This
may have the disbenefit that there isn't a single person any
more who looks at all the CI results and gets a sense of whether
particular test cases have pre-existing intermittent failures.)

There was less agreement on the main problem of reviewing code.
On the positive side:
 - everyone acknowledged that the email workflow was a barrier to new
   contributors
 - email is not awkward just for newcomers -- many regular
   developers have to deal with corporate mail systems, firewalls,
   etc, that make the email workflow more awkward than it was
   when Linux (and subsequently QEMU) first adopted it decades ago
 - a web UI means that unreviewed submissions are easier to track,
   rather than being simply ignored on the mailing list
But on the negative side:
 - gitlab is not set up for a "submaintainer tree" kind of workflow,
   so patches would go directly into the main tree and get no
   per-subsystem testing beyond whatever our CI can cover
 - gitlab doesn't handle adding Reviewed-by: and similar tags
 - email provides an automatic archive of the historical code
   review conversation; gitlab doesn't do this as well
 - it would increase the degree to which we might have a lock-in
   problem with gitlab (we could switch away, but it gets more painful)
 - it has the potential to be a bigger barrier to new contributors
   getting started with reviewing, compared to "just send an email"
 - it would probably burn the project's CI minutes more quickly
   as we would do runs per-submission, not just per-pullreq
 - might increase the awkwardness of the "some contributors/bug
   reporters/people interested in a patch are only notifiable
   by gitlab handle, and some only by email, and you can't
   email a handle and you can't tag an email on gitlab" split
 - offline working is trickier/impossible
 - many people were somewhere between "not enthusiastic" and
   "deal-breaker" about the web UI experience for code review
   (some of this can be dealt with via tooling)

So on net, there is no current consensus that we should make a change
in the project's patch submission and code review workflow.

Topic 3: Should we split responsibility for managing CoC reports?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The QEMU project happily does not have to deal with many Code of
Conduct (CoC) reports, but we could do a better job with managing the
ones we do get.  At the moment CoC reports go to the QEMU Leadership
Committee; Paolo proposed that it would be better to decouple CoC
handling to a separate team: although the CoC itself seems good,
asking the Leadership Committee to deal with the reports has not been
working so well.  The model for this is that Linux also initially had
its tech advisory board be the contact for CoC reports before
switching to a dedicated team for them.

There was general consensus that we should try the separate-team
approach. We plan to ask on the mailing list for volunteers who would
be interested in helping out with this.

(As always, the existence of a CoC policy and separate CoC team
doesn't remove the responsibility of established developers for
dealing with poor behaviour on the mailing lists when we see it. But
we can't see everything and the existence of a formal channel for
escalating problems is important.)

Topic 4: Size of the QEMU tarballs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Stefan began by outlining how the issue was noticed after Rackspace
pulled their open source funding leading to a sudden rise in hosting
bills. Fortunately we have been able to deal with the immediate
problem by first using Azure and then migrating to Gnome's CDN
service.  However the tarballs are still big with firmware source code
that we suppose most people never look at taking up a significant
chunk of the size. (In particular, EDK2 sources are half the tarball!)

We do need to be careful about GPL compliance (making sure users
have the source if we provide them the compiled firmware blob
for a GPL'd piece of firmware); but we don't need to necessarily
ship the sources in the exact same tarball as the blob.

Peter said we should check with the downstream consumers of our
tarballs what would be most useful to them; or at least figure
out what we think the common use-cases are. At the moment what
we do is not very useful to anybody:
 * most end users, CI systems, etc building from source tarballs
   don't care about the firmware sources and only want the
   binary blobs to be present
 * most downstream distros doing rebuilds want to rebuild the
   firmware from sources anyway, and will use the 'upstream'
   firmware sources rather than the ones we have in the tarballs

Users of QEMU from git don't get a great firmware experience either,
since the firmware is in submodules, with all the usual git submodule
problems. Plus we could do better in these days of Docker containers
than "somebody builds the firmware blob on their machine and sends a
patch with the binary blob to commit to git". So we should consider
whether we can improve things here while we're working on the firmware
problem.

Mark Cave-Ayland mentioned that he's already automated the "build
OpenBios blobs" aspect; so we could look at that as a model.

There definitely seemed to be consensus that it was worth trying
to improve what we do here -- hopefully somebody will have the
time to attempt something :-)


thanks
-- PMM

