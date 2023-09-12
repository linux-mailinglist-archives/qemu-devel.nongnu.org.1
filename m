Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123C79D528
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5Vu-0000MD-9S; Tue, 12 Sep 2023 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg5Vp-0000Ka-Kr
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg5Va-0003td-Hb
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694533256;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqPnJUgGrxj2TyI+IaVEv49oYsZXO0cc2qae0kY92pE=;
 b=Z6PHLEh1XFrkkJlMoRdgk2NP6HFYaWR+/m44Dg6ojr+/narAOSkOfZ5U2uX7AFxI+ZPX5q
 hbg96nnwUIwjgCXLl6hAMtgklTh088A7s9696bPNWmFEquTyF+uPirVtKqT7e+mkIYvdwY
 hoY03Ebc8l2lVu2IfA+TkZSVD1IdqmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-dcOppG4QNneA45LY6whHjw-1; Tue, 12 Sep 2023 11:40:54 -0400
X-MC-Unique: dcOppG4QNneA45LY6whHjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32C19101FAA1;
 Tue, 12 Sep 2023 15:40:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EFEF2904;
 Tue, 12 Sep 2023 15:40:52 +0000 (UTC)
Date: Tue, 12 Sep 2023 16:40:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 06/12] qtest: bump pxe-test timeout to 3 minutes
Message-ID: <ZQCGgimPV5rDOS+e@redhat.com>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-7-berrange@redhat.com>
 <94fd6765-112d-70cc-b8c6-d4556bdce376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94fd6765-112d-70cc-b8c6-d4556bdce376@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 19, 2023 at 03:26:11PM +0200, Thomas Huth wrote:
> On 17/07/2023 20.28, Daniel P. Berrangé wrote:
> > The pxe-test takes about 1 + 1/2 minutes in a --enable-debug
> > build. Bumping to 3 minutes will give more headroom.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/qtest/meson.build | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 1070c6dc64..c6da428dc5 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -4,6 +4,7 @@ slow_qtests = {
> >     'npcm7xx_pwm-test': 300,
> >     'qom-test' : 900,
> >     'test-hmp' : 240,
> > +  'pxe-test': 180,
> >   }
> 
> By the way, pxe-test uses the boot_sector_test() function, and that already
> uses a timeout of 600 seconds ... so we maybe should use the same (or even
> slightly higher) timeout value here?

Your original change setting that 600 limit says:

    If QEMU has been compiled with the flags --enable-tcg-interpreter and
    --enable-debug, the guest is running incredibly slow. The pxe boot test
    can take up to 400 seconds when testing the pseries ppc64 machine.

so yeah, we need to set the timeout for pxe-test to 600 seconds
too. I guess likewise for other tests using boot_sector_test()
function too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


