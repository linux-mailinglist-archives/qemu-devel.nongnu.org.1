Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CACB715C58
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3x1S-0005Ul-Mi; Tue, 30 May 2023 06:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3x1R-0005Ua-4E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3x1P-0004PA-1M
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685444169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VpK9XOxXdDhTB0/JwfBpyeNtddUAcBeDFX/zpL97aOk=;
 b=T/2y2zDxxJ8PGsGd7gYWiI2QFWorqyOqVESeB/tqogaxkGVwMcvjwS6hr2QmJ01tdnDInQ
 AJHPRZXDv8UCBKyeK5kISbau+fBp0im7GRd7QG0HG7Ku5C9s4/QCFLbK3ud2FwkMnOHBuS
 ZNZtjcLPWOt+PLT8Ukyc7x1TlERYGPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-rtMibyN7NFutG7CoSlapmA-1; Tue, 30 May 2023 06:56:06 -0400
X-MC-Unique: rtMibyN7NFutG7CoSlapmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA87085A5A8;
 Tue, 30 May 2023 10:56:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B8B92022EC3;
 Tue, 30 May 2023 10:56:04 +0000 (UTC)
Date: Tue, 30 May 2023 11:56:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 0/5] gitlab: improvements to handling of stable
 staging branches
Message-ID: <ZHXWQnT8B8upVRny@redhat.com>
References: <20230526101934.935969-1-berrange@redhat.com>
 <e10a91a7-a3e3-79d0-f413-4e5a6f8f325b@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e10a91a7-a3e3-79d0-f413-4e5a6f8f325b@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 30, 2023 at 10:36:36AM +0300, Michael Tokarev wrote:
> 26.05.2023 13:19, Daniel P. Berrangé wrote:
> > We just (re)discovered that our gitlab rules don't work nicely with
> > pipelines running from stable staging branches. Every pipeline gets
> > published with the 'latest' tag, whether its the main staging branch
> > or one of the stable staging branches. If pipelines for multiple
> > staging branches run concurrently they'll get very confused and end
> > up using the wrong container content. eg a 8.0 stable job will get
> > run with a container from the development branch, or vica-verca.
> > 
> > With this series we dynamically change the tag so that the 'staging'
> > branch still uses 'latest', but the stable 'staging-X.Y' branaches
> > use a 'staging-X-Y' container tag.
> > 
> > We also let the container tag be set explicitly via the new variable
> > 
> >    QEMU_CI_CONTAINER_TAG
> > 
> > to facilitate CI testing, the new variable
> > 
> >    QEMU_CI_UPSTREAM
> > 
> > can be set to the fork namespace, to allow contributors to run a
> > pipeline as if their fork were upstream.
> 
> Daniel, can you describe in a bit more detail (or refer to some text
> to read) about how this whole thing works, aka the "big picture"?

What docs we have are at docs/devel/ci*rst but they're by no means
complete.

> It smells like we're doing huge wasteful job here, but it might be
> just because I don't understand how it works.
> 
> Can't we prepare all containers separately and independently of regular
> qemu commits, and just use the prepared container images every time
> we run tests?

Contributor branches, contributor patch series submissions, and pull
requests periodically contain updates to the dockerfiles. When we
build such code branches, we need to ensure that containers we using
building inside match the contents of those dockerfiles otherwise the
build will fail or perhaps worse, silently not test the changes in the
correct way.

Also we're creating contaniers in a staging branch and there's no
guarantee that the staging branch will actually get merged to master,
it might get rejected if CI fails, so we're left with containers that
might reflect a discard pull request.

A final point is that the distro base images change periodically and
we want to pick up this content.

We don't want people triggering the pipelines to have to think about
any of this to figure out whether a container rebuild is needed or
not, as that is inherantly error prone. We need CI to "do the right
thing" at all times.

Thus we will always build the containers in stage 1 of the pipeline.
The stage 2 will then do the QEMU builds inside the just refreshed
continers.

This is indeed wasteful if the patch series being tested did NOT
have any container changes.

To mitigate this wastage, however, we tell docker to use the previously
published containers as a cache. So docker build will compare each
command in the dockerfile, against the cache and if they match, it will
just copy across the contanier layer. This is a major performance win,
but even this act of checking the cache does have some wastage.

Essentially with CI reliability is king and generally overules other
considerations. A reliable, but computationally wasteful CI, is more
usable than an unreliable, but computationally efficient CI.

Obviously the ideal is computationally efficient *and* reliable, and
that's what we constantly want to strive towards.

> Also, why can't several tests (from several different pipelines, maybe
> run for different branches) use the same images (if we don't re-prepare
> them on each and every test run)?

The cache should mostly address this, within the scope of our release
stream.

> I understand different branches might have different requirements for
> containers, like using older version of some OS, etc, - this is done
> by naming the container images appropriately, like debian-latest (for
> master) vs debian-bullseye (for stable-7.2) etc.

The package dependancies have changed frequently enough that each
release of QEMU needs distinct containers. So with this patch series,
we set container tag names based on the staging branch, so we'll get

   debian11:latest       (for master / staging)
   debian11:staging-8-0  (for 8.0.x release staging)
   debian11:staging-8-2  (for 7.2.x release staging)



Finally, I have at last figured out a way we can improve this that will
probably let us remove the redundant container rebuilds for patch series
that /don't/ include dockerfile changes. IOW, we may finally be able to
achieve a computationally efficient and reliable CI, that doesn't require
maintainers to figure out when to rebuild containers. It is on my to do
list to try it out....



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


