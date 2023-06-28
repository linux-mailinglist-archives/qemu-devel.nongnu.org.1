Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175A74100D
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETLM-00017x-FR; Wed, 28 Jun 2023 07:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qETLI-00017R-F9
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qETLF-0004zx-8b
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687951687;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Jv041x81bonlglij7ZmWbSfM/UcrWCn6NmKRN84w51Q=;
 b=cw4GIkGfutMRfX3Tq3JnvH6kEF90his0xFiFQ4zXiHnoRa+vvmmbEz1Pco2eG74Fw5KLOy
 5mHbHv0y7o+A7d5fyqwVuXFsQhTBJXPes1lTocaieY5lKwjwf/uczet8SLiBDW4u7qsnQy
 ET8KuMnMikE2YWxewyZIk7C6LdSc2ds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-xPuZfvXXNiCmFdrQhUvYBQ-1; Wed, 28 Jun 2023 07:28:06 -0400
X-MC-Unique: xPuZfvXXNiCmFdrQhUvYBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4CF3185A794;
 Wed, 28 Jun 2023 11:28:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90E3E200C0F2;
 Wed, 28 Jun 2023 11:28:04 +0000 (UTC)
Date: Wed, 28 Jun 2023 12:28:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu@sfconservancy.org, qemu-devel <qemu-devel@nongnu.org>,
 Camilla Conte <cconte@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>
Subject: Re: Azure infrastructure update
Message-ID: <ZJwZQqckRZd2RQd4@redhat.com>
References: <CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 28, 2023 at 12:44:33PM +0200, Paolo Bonzini wrote:
> Starting June 1, all pipelines running in qemu-project/qemu have been
> using the private runners. Besides benefiting from the higher number
> of vCPUs per job, this, it leaves the GitLab shared runner allowance
> to Windows jobs as well as updates to qemu-web.

Also the python-qemu-qmp.git  CI is on shared runners currently.

> Our consumption of Azure credits was as follows:
> * $2005 as of Jun 1, of which $371 used for the now-deleted D2s VM
> * $2673 as of Jun 28, of which $457 used for the now-deleted D2s VM
> 
> Based on the credits consumed from Jun 1 to Jun 28, which should be
> representative of normal resource use, I am estimating the Azure costs
> as follows:

Only caveat is that June did not co-incide with a soft freeze. My
impression is that our CI pipeline usage has a spike in the weeks
around the freeze.

> $6700 for this year, of which:
> - $1650 for the E2s VM
> - $450 for the now-deleted D2s VM
> - $1600 for the Kubernetes compute nodes
> - $2500 for AKS (Azure Kubernetes Service) including system nodes,
> load balancing, monitoring and a few more itemized services(*)
> - $500 for bandwidth and IP address allocation
> 
> $7800 starting next year, of which:
> - $1900 for the E2s VM

Same size VM as last year, but more ? Is this is simply you
anticipating possible price increases from Azure ?

> - $2250 for the Kubernetes compute nodes

IIUC, the $1600 from year this will cover about 7.5 months worth
of usage (Jun -> Dec), which would imply more around $2500 for a
full 12 months, possibly more if we add in peaks for soft freeze.
IOW could conceivably be closer to $3k mark without much difficulty,
especially if also start doing more pipelines for stable branches
on a regular basis, now we have CI working properly for stable.

> - $3100 for AKS-related services

Same question about anticipated prices ?

> - $550 for bandwidth and IP address allocation
> 
> This fits within the allowance of the Azure open source credits
> program, while leaving some leeway in case of increased costs or
> increased usage of the private runners. As a contingency plan in case
> costs surge, we can always disable usage of the private runners and
> revert to wider usage of shared runners.

We also still have Eldondev's physical machine setup as a runner,
assuming that's going to be available indefinitely if we need
the resource.

> That said, the cost for the compute nodes is not small. In particular,
> at the last QEMU Summit we discussed the possibility of adopting a
> merge request workflow for maintainer pull requests. These merge
> requests would replace the pipelines that are run by committers as
> part of merging trees, and therefore should not introduce excessive
> costs.

Depending on how we setup the CI workflow, it might increase our
usage, potentially double it quite easily.


Right now, whomever is doing CI for merging pull requests is fully
serializing CI pipelines, so what's tested 100% matches what is
merged to master.

With a merge request workflow it can be slightly different based
on a couple of variables.

When pushing a merge request to their fork, prior to opening the
merge request, CI credits are burnt in their fork for every push,
based on whatever is the HEAD of their branch. This might be behind
current upstream 'master' by some amount.


Typically when using merge requests though, you would change the
gitlab CI workflow rules to trigger CI pipelines from merge request
actions, instead of branch push actions.

If we do this, then when opening a merge request, an initial pipeline
would be triggered.

If-and-only-if the maintainer has "Developer" on gitlab.com/qemu-project,
then that merge request initial pipeline will burn upstream CI credits.

If they are not a "Developer", it will burn their own fork credits. If
they don't have any credits left, then someone with "Developer" role
will have to spawn a pipeline on their behalf, which will run in
upstream context and burn upstream credits. The latter is tedious,
so I think expectation is that anyone who submits pull requests would
be expected to have 'Developer' role on qemu-project. We want that
anyway really so we can tag maintainers in issues on gitlab too.


IOW, assume that any maintainer opening a merge req will be burning
upstream CI credits on their merge request pipelines.


This initial pipeline will run against a merge commit that grafts
the head of the pull request, and 'master' at the time the pipeline
was triggered.

In a default config, if we apply the merge request at that point it
would go into master with no further pipeline run.

Merge requests are not serialized though.

So if a second merge request had been applied to master, after the
time the first merge request pipeline started, the pipeline for the
first merge request is potentially invalid. Compared to our use of
the (serialized) pipelines on the 'staging' branch, this setup would
be a regression in coverage.

To address this would require using GitLab's  "merge trains" feature.

When merge trains are enabled, when someone hits the button to apply
a merge request to master, an *additional* CI pipeline is started
based on the exact content that will be applied to master. Crucially,
as the name hints, the merge train pipelines  are serialized. IOW,
if you request to apply 4 merge requests in quick succession a queue
of pipelines will be created and run one after the other. If any
pipeline fails, that MR is kicked out of the queue, and the
following pipelines carry on.

IOW, the merge trains feature replicates what we achieve with the
serialized 'staging' branch.

What you can see here though, is that every merge request will have
at least 2 pipelines - one when the MR is opened, and one when it
is applied to master - both consuming upstream CI credits.

IOW, we potentially double our CI usage in this model if we don't
make any changes to how CI pipelines are triggered.


Essentially the idea with merge requests is that the initial
pipeline upon opening the merge requests does full validation
and catches all the silly stuff. Failures are ok because this
is all parallelized with other MRs, so failures don't delay
anything/anyone else. The merge train is then the safety net
to prove the original pipeline results are still valid for
current HEAD at time of applying it. You want the merge train
pipelines to essentially never fail as that's disruptive to
anything following on.

If we can afford the CI credits, I'd keep things simple and
just accept the increased CI burn, but with your figures above
I fear we'd be too close to the limit to be relaxed about it.

The extra eldondev runner could come into play here possibly.

If we can't afford the double pipelines, then we would have
to write our GitLab CI yml rules to exclude the initial
pipeline, or just do a very minimalist "smoke test", and
focus bulk of CI usage on teh merge train pipeline.

This is all solvable in one way or another. We just need to
figure out the right tradeoffs we want.

>          However, as things stand, in case of a more generalized
> adoption of GitLab MRs(**) the QEMU project will *not* be able to
> shoulder the cost of running our (pretty expensive) CI on private
> runners for all merge requests.

With more generalized adoption of MR workflow for all contributions
bear in mind that many of the contributors will NOT have the
'Developer' role on gitlab.com/qemu-project. Thus their merge
requests pipelines would run in fork context and consume their own
CI credits, unless a "Developer" had to manually trigger a pipeline
on their behalf.

So yes, I agree that full adoption of MRs would definitley increase
our CI usage, but not be quite such a horrendous amount as you might
first think. We would definitely need more resources whichever way
you look at it though.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


