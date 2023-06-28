Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937F7410BE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:08:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETxv-0006aG-Pm; Wed, 28 Jun 2023 08:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qETxm-0006J0-AC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qETxi-0001fJ-Bw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687954060;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8shiAe7z7Ozjo8JAG1U+bJEEvj74qwURFJmJJGgy1KE=;
 b=eC8qZWH+/evKDaYzYK1gvdeVJptiGQ4ZPrzIhuUR14bn6W2s8ytbGZehz7IMDaIt7Cpp4O
 PK0ezWxab/3j5nmFfFa5qV13AAOK45/U8QtHKXPD/4aKw8TnOYAekUnY9x96iTJijU4CZQ
 CY8hQ0MLf5nbEzhoYsDSFj2JN7QP3Fo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-oLpygk6RNcGjFJCTaC0NGA-1; Wed, 28 Jun 2023 08:07:38 -0400
X-MC-Unique: oLpygk6RNcGjFJCTaC0NGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA2901C28CE8;
 Wed, 28 Jun 2023 12:07:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3798C09A07;
 Wed, 28 Jun 2023 12:07:36 +0000 (UTC)
Date: Wed, 28 Jun 2023 13:07:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu@sfconservancy.org, qemu-devel <qemu-devel@nongnu.org>,
 Camilla Conte <cconte@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>
Subject: Re: Azure infrastructure update
Message-ID: <ZJwihuChdYDqLyhg@redhat.com>
References: <CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com>
 <ZJwZQqckRZd2RQd4@redhat.com>
 <CABgObfbdkXZysnU90vWqZvP2+q3tZoBbEXFtpiU5-zJZYCBy4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfbdkXZysnU90vWqZvP2+q3tZoBbEXFtpiU5-zJZYCBy4g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Jun 28, 2023 at 01:41:03PM +0200, Paolo Bonzini wrote:
> > If we do this, then when opening a merge request, an initial pipeline
> > would be triggered.
> >
> > If-and-only-if the maintainer has "Developer" on gitlab.com/qemu-project,
> > then that merge request initial pipeline will burn upstream CI credits.
> >
> > If they are not a "Developer", it will burn their own fork credits. If
> > they don't have any credits left, then someone with "Developer" role
> > will have to spawn a pipeline on their behalf, which will run in
> > upstream context and burn upstream credits. The latter is tedious,
> > so I think expectation is that anyone who submits pull requests would
> > be expected to have 'Developer' role on qemu-project. We want that
> > anyway really so we can tag maintainers in issues on gitlab too.
> 
> Agreed. Is there no option to have the "Developer" use his own credits?

I've never found any way to control / force this behaviour.

> > IOW, assume that any maintainer opening a merge req will be burning
> > upstream CI credits on their merge request pipelines. [...]
> > Merge requests are not serialized though. [...]
> > To address this would require using GitLab's  "merge trains" feature.
> >
> > When merge trains are enabled, when someone hits the button to apply
> > a merge request to master, an *additional* CI pipeline is started
> > based on the exact content that will be applied to master. Crucially,
> > as the name hints, the merge train pipelines  are serialized. IOW,
> > if you request to apply 4 merge requests in quick succession a queue
> > of pipelines will be created and run one after the other. If any
> > pipeline fails, that MR is kicked out of the queue, and the
> > following pipelines carry on.
> >
> > IOW, the merge trains feature replicates what we achieve with the
> > serialized 'staging' branch.
> >
> > What you can see here though, is that every merge request will have
> > at least 2 pipelines - one when the MR is opened, and one when it
> > is applied to master - both consuming upstream CI credits.
> >
> > IOW, we potentially double our CI usage in this model if we don't
> > make any changes to how CI pipelines are triggered. [...]
> > If we can afford the CI credits, I'd keep things simple and
> > just accept the increased CI burn, but with your figures above
> > I fear we'd be too close to the limit to be relaxed about it.
> 
> Hmm, now that I think about it I'm not sure the merge request CI would
> use private runners. Would it use the CI variables that are set in
> settings/ci_cd? If not, the pipeline would not tag the jobs for
> private runners, and therefore the merge request would use shared
> runners (thus burning project minutes, but that's a different
> problem).

The repo/project global CI env variable settings should be
honoured for all pipelines in that repo, regardless of what
action triggers the pipeline. So I'd expect merge request
triggered pipelines to "just work" with the runner tagging.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


