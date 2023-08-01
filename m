Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9A76BD54
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 21:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuiP-00009p-0g; Tue, 01 Aug 2023 15:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQuiK-000085-Jr
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 15:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQuiI-0005NI-VD
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 15:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690916841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CI0goRjHxYpy4yVcYH3g1igqqOn1vLD6mqWCxDswg0=;
 b=A8KzBI1ibJD29BIYDxmnMHoZM5Kp9e57Tv6KFEMaROMaps8PoR//GL/Rc3kNsl8IpvgI5v
 lJbPv4Z/WJKHQVj2/3Ja08hG4Y/HpeQmUSHjJK2DivJ2IDVt23wpbRqDwrVcpWQ89ntxhW
 SFpotXGT/iA11BeLHrBf73/uJ2vcYEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-QMlfSPbeMoe2O8RCxMe05g-1; Tue, 01 Aug 2023 15:07:18 -0400
X-MC-Unique: QMlfSPbeMoe2O8RCxMe05g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B21A8631DF;
 Tue,  1 Aug 2023 19:07:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8656B4021521;
 Tue,  1 Aug 2023 19:07:16 +0000 (UTC)
Date: Tue, 1 Aug 2023 20:07:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7/8] gitlab: disable optimization and debug symbols in
 msys build
Message-ID: <ZMlX4nE8YwOWWXEt@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-8-berrange@redhat.com>
 <952019de-c467-e924-5660-eb4b75847a06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <952019de-c467-e924-5660-eb4b75847a06@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 01, 2023 at 08:44:02PM +0200, Thomas Huth wrote:
> On 01/08/2023 15.04, Daniel P. Berrangé wrote:
> > Building at -O2, adds 33% to the build time, over -O2. IOW a build that
> > takes 45 minutes at -O0, takes 60 minutes at -O2. Turning off debug
> > symbols drops it further, down to 38 minutes.
> > 
> > IOW, a "-O2 -g" build is 58% slower than a "-O0" build on msys in the
> > gitlab CI windows shared runners.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/windows.yml | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> > index 34109a80f2..552e3b751d 100644
> > --- a/.gitlab-ci.d/windows.yml
> > +++ b/.gitlab-ci.d/windows.yml
> > @@ -113,7 +113,7 @@ msys2-64bit:
> >       # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
> >       # changed to compile QEMU with the --without-default-devices switch
> >       # for the msys2 64-bit job, due to the build could not complete within
> > -    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices
> > +    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
> >       # qTests don't run successfully with "--without-default-devices",
> >       # so let's exclude the qtests from CI for now.
> >       TEST_ARGS: --no-suite qtest
> > @@ -123,5 +123,5 @@ msys2-32bit:
> >     variables:
> >       MINGW_TARGET: mingw-w64-i686
> >       MSYSTEM: MINGW32
> > -    CONFIGURE_ARGS:  --target-list=ppc64-softmmu
> > +    CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
> >       TEST_ARGS: --no-suite qtest
> 
> This is IMHO a very good idea! But I think for now it's enough if you only
> change the 64-bit, isn't it?

My thought was if we do it for 32-bit too, we can enable some more targets
to get a more comprehensive build.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


