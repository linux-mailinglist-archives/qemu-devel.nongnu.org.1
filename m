Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FB07094BC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 12:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzxH5-0004mO-I6; Fri, 19 May 2023 06:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzxH1-0004lx-TQ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 06:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1pzxH0-0006cg-1j
 for qemu-devel@nongnu.org; Fri, 19 May 2023 06:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684491824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VqquCAzGDSf8U8KLH6BTgpLMIB5+q9nkHAekuLlsL5w=;
 b=ThTHCOag7iUyweysGndPtng4AIr/MPzkCTFlK9y9yc4e5mpDL/piSx2V8oPWZ8yz2Y1SB1
 dgLHJsuWAycYSfr8ZOhZetdbGMb6pUtXskpjKzJt4+YKe3Omk5VpanXx21SkEuuYofqhGR
 +A0vcNgU7idyyXogiZFdl2LXh+mpBSw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-EmCou-QhOj-nPSFSms_uRw-1; Fri, 19 May 2023 06:23:41 -0400
X-MC-Unique: EmCou-QhOj-nPSFSms_uRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2F5C3C01B90;
 Fri, 19 May 2023 10:23:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 680D8C0004B;
 Fri, 19 May 2023 10:23:38 +0000 (UTC)
Date: Fri, 19 May 2023 11:23:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org,
 Eldon Stegall <eldon-qemu@eldondev.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/2] Raise crash-test-debian timeout to 90 minutes
Message-ID: <ZGdOJ0Kafhk53LTT@redhat.com>
References: <20230407145252.32955-1-cconte@redhat.com>
 <20230407145252.32955-2-cconte@redhat.com>
 <9bc1b9c3-a54c-8a59-5b68-af8d63037142@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bc1b9c3-a54c-8a59-5b68-af8d63037142@redhat.com>
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

On Tue, Apr 11, 2023 at 10:22:51AM +0200, Thomas Huth wrote:
> On 07/04/2023 16.52, Camilla Conte wrote:
> > When running on the Kubernetes runner, this CI job is timing out.
> > Raise the limit to give the job enough time to run.
> > 
> > Signed-off-by: Camilla Conte <cconte@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest.yml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index ba6f551752..893f8c69b4 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -98,6 +98,7 @@ crash-test-debian:
> >     needs:
> >       - job: build-system-debian
> >         artifacts: true
> > +  timeout: 90m
> >     variables:
> >       IMAGE: debian-amd64
> >     script:
> 
> Eldon recently discovered that the crash-test-debian jobs takes longer on
> his runner since it has KVM enabled and the job tests the devices twice -
> once with TCG and once with KVM. I assume this is the case for the
> Kubernetes runner, too? ... we should likely add a switch to the
> device-crash-test script to provide a way to enforce running with one
> accelerator only, so we can keep the run time in a sane limit.
> 
> Anyway, for the time being, this patch is of course a fair work-around, thus:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

You added --tcg-only to the test a little while after your review here,
so hopefully this patch can be dropped.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


