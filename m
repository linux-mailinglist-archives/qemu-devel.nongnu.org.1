Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D29706D0D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:39:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJEs-0006yi-67; Wed, 17 May 2023 11:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzJEq-0006y7-9a
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzJEo-0002nY-5b
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5p5bkiUFhhtOk8jPF7iqhbybGiDSK5XLEK2no/0Du8=;
 b=UeRESKrPhP1fvRgu6yPxMCffKrkSV7kEa5PiKp2HJ0XyuB96wVNS29ArwqnDJ5/hIx8j/Y
 vZA4m+tcp+z7tZWLqr8VkSyP3ot+lB1r18s1xhJZq3OzSVOhNX/QAjA8U8o3PKjbVjhtM6
 q2OrpogS57fclrI7s1BmQ+wYbk7ZDqs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-Yw-PNvPbPgCJT_Smz0FuOQ-1; Wed, 17 May 2023 11:38:48 -0400
X-MC-Unique: Yw-PNvPbPgCJT_Smz0FuOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD70C2808E70;
 Wed, 17 May 2023 15:38:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3F6F40C6EC4;
 Wed, 17 May 2023 15:38:46 +0000 (UTC)
Date: Wed, 17 May 2023 16:38:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 5/5] gitlab: support disabling job auto-run in upstream
Message-ID: <ZGT1BGbWPipLnk0o@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-6-berrange@redhat.com>
 <b0086f66-fe64-e38e-ce77-f3441401d013@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0086f66-fe64-e38e-ce77-f3441401d013@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Wed, May 17, 2023 at 06:13:44PM +0300, Michael Tokarev wrote:
> 17.05.2023 16:54, Daniel P. Berrangé wrote:
> > In forks QEMU_CI=1 can be used to create a pipeline but not auto-run any
> > jobs. In upstream jobs always auto-run, which is equiv of QEMU_CI=2.
> > 
> > This supports setting QEMU_CI=1 in upstream, to disable job auto-run.
> > This can be used to preserve CI minutes if repushing a branch to staging
> > with a specific fix that only needs testing in limited scenarios.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/base.yml | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> > index 999149852e..188a770799 100644
> > --- a/.gitlab-ci.d/base.yml
> > +++ b/.gitlab-ci.d/base.yml
> > @@ -109,6 +109,16 @@ variables:
> >       - if: '$QEMU_CI != "2" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
> >         when: manual
> > +    # Upstream pipeline jobs start automatically unless told not to
> > +    # by setting QEMU_CI=1
> > +    - if: '$QEMU_CI == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH =~ /staging-[[:digit:]]+\.[[:digit:]]/'
> 
> Should this be enabled for main staging branch too?
> I dunno how it is useful though.

Yes, actually it should have been. There's no downside to enabling it for
'staging' too, since it is opt-in.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


