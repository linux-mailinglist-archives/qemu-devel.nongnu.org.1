Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BED741039
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETY4-0005xA-Ev; Wed, 28 Jun 2023 07:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qETY1-0005vE-MX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qETXy-0000MN-Mb
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687952477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vny7d0a74HpyFxRwszMIOvJPQ/gWrBBL8n9tJto79+o=;
 b=WMtJYZPe1+bLPhZYlWBpgUhpGDG5n/W/pQcpNBxJL+Xcd6Sdfnz5dUknxl2aLDZkaJp38V
 3e7SCoa1fgKVRXjnPLjR+F64pU1fy3AOAyE+QPrBI0IAnU65+jSvRGdVmhvF3VmfG/v/H0
 hvHvYisNk/isE91bPWFnb8+me5yLI1Q=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Up6w6G3bNKqgeLwnOXOgOg-1; Wed, 28 Jun 2023 07:41:16 -0400
X-MC-Unique: Up6w6G3bNKqgeLwnOXOgOg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7943dfc059aso484566241.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687952475; x=1690544475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vny7d0a74HpyFxRwszMIOvJPQ/gWrBBL8n9tJto79+o=;
 b=KhtfSVibTid2PfdYI5wGPwL8ttLCurCkNCVFTAUKFsnOKwQ/No8gzakrrzyvvCLTBw
 WeoNzIyPyQtcOKOtX0fNXwVZ/x6LzqwChnB6+3x4LzmnUtIT7d7vu/EBQHInmW20jYY2
 X66e+97uePlF23xJUv3RlIAD14Kn/iwFaxXtcr2JLMEjslALR5f3bIW5lrBvxAKwN+2D
 z77oId/tx3TPGA0/cDZOxeaTNbyLs9fx2s9Xy8O/lwG0l8kHUAisFF1e+DzCR4H/vemD
 5+iC4AYQ5J6tloRrlgf5sDct+MIMt1N3irtuZ5iv/kkmWrSiCvJdDd10GvUTdx0lR+cC
 s5Ag==
X-Gm-Message-State: AC+VfDyVhPNSkB4CkynZuA+SqUpc2fY5LRyUkKG2npH9M0JzRVaqCpXf
 mSZW2jgxfAj1EORC0RjCdCuY61phJiwfoe3E3G3ZQ+QBe/6JCHt8ZTLyHzxinxzs/c0RqqsCzSn
 NLu4ZKPQ0fD3FJPiyLAw1Dxdwzb+MRzk=
X-Received: by 2002:a67:fe88:0:b0:440:b2ba:1548 with SMTP id
 b8-20020a67fe88000000b00440b2ba1548mr16143199vsr.5.1687952475397; 
 Wed, 28 Jun 2023 04:41:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EsHypiKPBrb4pgRs5otFfHf59gyg5C+flEN5JDCGyxtWzEMI3uSw3zfJn8v0yn/bLtOXgg1IyWxj4WYTVDiQ=
X-Received: by 2002:a67:fe88:0:b0:440:b2ba:1548 with SMTP id
 b8-20020a67fe88000000b00440b2ba1548mr16143181vsr.5.1687952475007; Wed, 28 Jun
 2023 04:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com>
 <ZJwZQqckRZd2RQd4@redhat.com>
In-Reply-To: <ZJwZQqckRZd2RQd4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Jun 2023 13:41:03 +0200
Message-ID: <CABgObfbdkXZysnU90vWqZvP2+q3tZoBbEXFtpiU5-zJZYCBy4g@mail.gmail.com>
Subject: Re: Azure infrastructure update
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu@sfconservancy.org, qemu-devel <qemu-devel@nongnu.org>, 
 Camilla Conte <cconte@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 28, 2023 at 1:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > $6700 for this year, of which:
> > - $1650 for the E2s VM
> > - $450 for the now-deleted D2s VM
> > - $1600 for the Kubernetes compute nodes
> > - $2500 for AKS (Azure Kubernetes Service) including system nodes,
> > load balancing, monitoring and a few more itemized services(*)
> > - $500 for bandwidth and IP address allocation
> >
> > $7800 starting next year, of which:
> > - $1900 for the E2s VM
>
> Same size VM as last year, but more ? Is this is simply you
> anticipating possible price increases from Azure ?

No it's just ~11 vs. 12 months, because we didn't set it up from the first =
day.

> > - $2250 for the Kubernetes compute nodes
>
> IIUC, the $1600 from year this will cover about 7.5 months worth
> of usage (Jun -> Dec), which would imply more around $2500 for a
> full 12 months, possibly more if we add in peaks for soft freeze.
> IOW could conceivably be closer to $3k mark without much difficulty,
> especially if also start doing more pipelines for stable branches
> on a regular basis, now we have CI working properly for stable.

It also covers several weeks in May. In any case I've saved the broken
down data and will redo the estimate after 4 months (Jun 1->Sep 30,
covering both a soft freeze and a hard freeze).

> > - $3100 for AKS-related services
>
> Same question about anticipated prices ?

Same answer about 9-10 months vs. 12. :)

> > That said, the cost for the compute nodes is not small. In particular,
> > at the last QEMU Summit we discussed the possibility of adopting a
> > merge request workflow for maintainer pull requests. These merge
> > requests would replace the pipelines that are run by committers as
> > part of merging trees, and therefore should not introduce excessive
> > costs.
>
> Depending on how we setup the CI workflow, it might increase our
> usage, potentially double it quite easily.
>
> Right now, whomever is doing CI for merging pull requests is fully
> serializing CI pipelines, so what's tested 100% matches what is
> merged to master.
>
> With a merge request workflow it can be slightly different based
> on a couple of variables.
>
> When pushing a merge request to their fork, prior to opening the
> merge request, CI credits are burnt in their fork for every push,
> based on whatever is the HEAD of their branch. This might be behind
> current upstream 'master' by some amount.
>
> Typically when using merge requests though, you would change the
> gitlab CI workflow rules to trigger CI pipelines from merge request
> actions, instead of branch push actions.

Yes, that was my idea as well.

> If we do this, then when opening a merge request, an initial pipeline
> would be triggered.
>
> If-and-only-if the maintainer has "Developer" on gitlab.com/qemu-project,
> then that merge request initial pipeline will burn upstream CI credits.
>
> If they are not a "Developer", it will burn their own fork credits. If
> they don't have any credits left, then someone with "Developer" role
> will have to spawn a pipeline on their behalf, which will run in
> upstream context and burn upstream credits. The latter is tedious,
> so I think expectation is that anyone who submits pull requests would
> be expected to have 'Developer' role on qemu-project. We want that
> anyway really so we can tag maintainers in issues on gitlab too.

Agreed. Is there no option to have the "Developer" use his own credits?

> IOW, assume that any maintainer opening a merge req will be burning
> upstream CI credits on their merge request pipelines. [...]
> Merge requests are not serialized though. [...]
> To address this would require using GitLab's  "merge trains" feature.
>
> When merge trains are enabled, when someone hits the button to apply
> a merge request to master, an *additional* CI pipeline is started
> based on the exact content that will be applied to master. Crucially,
> as the name hints, the merge train pipelines  are serialized. IOW,
> if you request to apply 4 merge requests in quick succession a queue
> of pipelines will be created and run one after the other. If any
> pipeline fails, that MR is kicked out of the queue, and the
> following pipelines carry on.
>
> IOW, the merge trains feature replicates what we achieve with the
> serialized 'staging' branch.
>
> What you can see here though, is that every merge request will have
> at least 2 pipelines - one when the MR is opened, and one when it
> is applied to master - both consuming upstream CI credits.
>
> IOW, we potentially double our CI usage in this model if we don't
> make any changes to how CI pipelines are triggered. [...]
> If we can afford the CI credits, I'd keep things simple and
> just accept the increased CI burn, but with your figures above
> I fear we'd be too close to the limit to be relaxed about it.

Hmm, now that I think about it I'm not sure the merge request CI would
use private runners. Would it use the CI variables that are set in
settings/ci_cd? If not, the pipeline would not tag the jobs for
private runners, and therefore the merge request would use shared
runners (thus burning project minutes, but that's a different
problem).

> If we can't afford the double pipelines, then we would have
> to write our GitLab CI yml rules to exclude the initial
> pipeline, or just do a very minimalist "smoke test", and
> focus bulk of CI usage on teh merge train pipeline.
>
> This is all solvable in one way or another. We just need to
> figure out the right tradeoffs we want.
>
> >          However, as things stand, in case of a more generalized
> > adoption of GitLab MRs(**) the QEMU project will *not* be able to
> > shoulder the cost of running our (pretty expensive) CI on private
> > runners for all merge requests.
>
> With more generalized adoption of MR workflow for all contributions
> bear in mind that many of the contributors will NOT have the
> 'Developer' role on gitlab.com/qemu-project. Thus their merge
> requests pipelines would run in fork context and consume their own
> CI credits, unless a "Developer" had to manually trigger a pipeline
> on their behalf.

I would expect most MRs to come from Developers but yes, that's not a given=
.

Paolo


