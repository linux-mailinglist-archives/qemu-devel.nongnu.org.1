Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E599475972A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:38:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7O4-0005Hq-Rc; Wed, 19 Jul 2023 09:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM7Nz-00057A-Ca
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM7Nx-0002wZ-Ov
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773912;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sD5G06EAL4gKNXZYK8oIvkSwgOc0+/ni2MZnSyeV6Gc=;
 b=c4BzcSbkZy8+d4xhMfrcUDM5Bzx9TK8LuFl+NSQ4N7sYdZR13bXFCzmkEmM/bqMgdb6/l+
 x+7nVC8u2Q4m0MiqQxn93GWUPl5gOlgXicV3nYYZfMnboThc3K+yFfdr70jGewtqiU7ZXn
 ObD9dCIRPOrItmqFD7DjijtPmI/0PuY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-xsS7IYGgPQiVi1C4TRgLow-1; Wed, 19 Jul 2023 09:38:30 -0400
X-MC-Unique: xsS7IYGgPQiVi1C4TRgLow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F1CF830DAB;
 Wed, 19 Jul 2023 13:38:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FFE41454143;
 Wed, 19 Jul 2023 13:38:29 +0000 (UTC)
Date: Wed, 19 Jul 2023 14:38:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 07/12] qtest: bump prom-env-test timeout to 3 minutes
Message-ID: <ZLfnUnARTdkEtg25@redhat.com>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-8-berrange@redhat.com>
 <7fd24e86-46ae-28d1-912a-eb7a42ea6493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fd24e86-46ae-28d1-912a-eb7a42ea6493@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Jul 19, 2023 at 03:22:30PM +0200, Thomas Huth wrote:
> On 17/07/2023 20.28, Daniel P. Berrangé wrote:
> > The prom-env-test takes about 1 + 1/2 minutes in a --enable-debug
> > build. Bumping to 3 minutes will give more headroom.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/qtest/meson.build | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index c6da428dc5..095c98820e 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -5,6 +5,7 @@ slow_qtests = {
> >     'qom-test' : 900,
> >     'test-hmp' : 240,
> >     'pxe-test': 180,
> > +  'prom-env-test': 180,
> >   }
> >   qtests_generic = [
> 
> I tested your patches, and initially, everything looked good now. But this
> prom-env-test them reminded me that we run some additional tests in the
> "SPEED=slow" mode ... I guess we have to take these into consideration, too?
> 
> I now did a "configure --enable-debug" build and then ran:
> 
>  make -j$(nproc) check-qtest-ppc64 SPEED=slow
> 
> and indeed, this prom-env-test is now timing out there. Also the
> device-introspect-test was timing out in SPEED=slow mode. Should we bump the
> timeout for those, or could this maybe be handled via the TIMEOUT_MULTIPLIER
> in the final patch?

My goal was "no regressions" wrt current status for people working on
common development hardware. If people are using old, or modern low
performance hardware than a timeout multiplier would be expected.

IOW, for SPEED=slow, I think we need to "do the right thing" with
the default timeouts.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


