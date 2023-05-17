Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1054706D06
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJE6-0006oQ-LK; Wed, 17 May 2023 11:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzJE4-0006oD-K6
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzJE2-0002bh-Sn
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkIQ0+gng+iHOGQbmDx3aJ/+JssAwmw/ZIhAo4eXLUM=;
 b=SfL35JEEJSx9zmsFpc053Dpxb/FziErslj9Yt7khFCsZ93dvj4A4Pzed9VqItqEGtiIRnN
 aW1DZq2ao61Nqz9K2hex5VOFo7VC/6ebMi+Vdisj5VZ38WEPNGKDiQOqmAmJnvabCDrOW1
 2l3h++y1wHo6M6IzzatY/2mv5iZsNRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-YMNtnOUpMe2u-XZhCy8okw-1; Wed, 17 May 2023 11:37:58 -0400
X-MC-Unique: YMNtnOUpMe2u-XZhCy8okw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C224386C60E;
 Wed, 17 May 2023 15:37:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46976C15BA0;
 Wed, 17 May 2023 15:37:56 +0000 (UTC)
Date: Wed, 17 May 2023 16:37:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 3/5] gitlab: stable staging branches publish containers
 in a separate tag
Message-ID: <ZGT00cm2rocMyv3E@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-4-berrange@redhat.com>
 <8e6c152f-4349-f63e-9976-0f9cd412f8df@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6c152f-4349-f63e-9976-0f9cd412f8df@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 17, 2023 at 06:26:56PM +0300, Michael Tokarev wrote:
> 17.05.2023 16:54, Daniel P. Berrangé wrote:
> > If the stable staging branches publish containers under the 'latest' tag
> > they will clash with containers published on the primary staging branch,
> > as well  as with each other. This introduces logic that overrides the
> > container tag when jobs run against the stable staging branches.
> > 
> > The CI_COMMIT_REF_SLUG variable we use expands to the git branch name,
> > but with most special characters removed, such that it is valid as a
> > docker tag name. eg 'staging-8.0' will get a slug of 'staging-8-0'
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/base.yml | 24 ++++++++++++++++++++++--
> >   1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> > index a1d734267a..f379c182a7 100644
> > --- a/.gitlab-ci.d/base.yml
> > +++ b/.gitlab-ci.d/base.yml
> > @@ -1,7 +1,7 @@
> >   variables:
> > -  # On stable branches this needs changing. Should also be
> > -  # overridden per pipeline if running pipelines concurrently
> > +  # On stable branches this is changed by later rules. Should also
> > +  # be overridden per pipeline if running pipelines concurrently
> >     # for different branches in contributor forks.
> >     QEMU_CI_CONTAINER_TAG: latest
> > @@ -16,6 +16,9 @@ variables:
> >   # Thus we group them into a number of stages, ordered from
> >   # most restrictive to least restrictive
> >   #
> > +# For pipelines running for stable "staging-X.Y" branches
> > +# we must override QEMU_CI_CONTAINER_TAG
> > +#
> >   .base_job_template:
> >     variables:
> >       # Each script line from will be in a collapsible section in the job output
> > @@ -61,11 +64,23 @@ variables:
> >       #############################################################
> >       # Optional jobs should not be run unless manually triggered
> > +    - if: '$QEMU_JOB_OPTIONAL && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
> > +      when: manual
> > +      allow_failure: true
> > +      variables:
> > +        QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
> 
> Here, it somehow feels better to use $CI_COMMIT_BRANCH instead of $CI_COMMIT_REF_SLUG.
> I know little about gitlab CI. It is REF_SLUG like a hashed value of COMMIT_BRANCH?

The git branch / tag name can contain characters that are not permitted
for docker tag names. The CI_COMMIT_REF_SLUG is CI_COMMIT_BRANCH but with
everything except 0-9 and a-z replaced with -, making it safe for use as
a docker tag [1]. 


With regards,
Daniel

[1] https://docs.gitlab.com/ee/ci/variables/predefined_variables.html
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


