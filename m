Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA03762187
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMts-0006B6-AN; Tue, 25 Jul 2023 14:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMtp-0006AR-JU
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMtn-0000Ld-Ta
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690310203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzycErlJrf/u1fYB3xTO9GVxHed6fEJoe+Em7YJNPyo=;
 b=RDsYMQaqVtjhTnb3yrtkdBhA1qB7exezkA9EGIMkqO93pWK5gR5r/EUY4W4BQktNNs7O45
 is4waWlH+E9Rk4knssQaIVEeeGvJrzMb9rkD0XS+1Sxv6Knf00gZUHbXyJKR2k1s1+ETrl
 r2ztjo1Oj6zh42srIb2+pxtezuXXtTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-x2FbUYyeOtiTz8UNJm8R1g-1; Tue, 25 Jul 2023 14:36:40 -0400
X-MC-Unique: x2FbUYyeOtiTz8UNJm8R1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82B79857FF8;
 Tue, 25 Jul 2023 18:36:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98CFA2166B25;
 Tue, 25 Jul 2023 18:36:37 +0000 (UTC)
Date: Tue, 25 Jul 2023 19:36:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 6/6] python/machine: remove unused sock_dir argument
Message-ID: <ZMAWM7BVs5gLwiUl@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-7-jsnow@redhat.com>
 <ZMAT60PpKSIAemZ7@redhat.com>
 <CAFn=p-YTohvmxET2kk1NWU1X=psVcD1M0oS7BDEZUH521DEQ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-YTohvmxET2kk1NWU1X=psVcD1M0oS7BDEZUH521DEQ_w@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 25, 2023 at 02:33:36PM -0400, John Snow wrote:
> On Tue, Jul 25, 2023 at 2:26 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Jul 25, 2023 at 02:03:37PM -0400, John Snow wrote:
> > > By using a socketpair for all of the sockets managed by the VM class and
> > > its extensions, we don't need the sock_dir argument anymore, so remove
> > > it.
> > >
> > > We only added this argument so that we could specify a second, shorter
> > > temporary directory for cases where the temp/log dirs were "too long" as
> > > a socket name on macOS. We don't need it for this class now. In one
> > > case, avocado testing takes over responsibility for creating an
> > > appropriate sockdir.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  python/qemu/machine/machine.py             | 18 ------------------
> > >  python/qemu/machine/qtest.py               |  5 +----
> > >  tests/avocado/acpi-bits.py                 |  5 +----
> > >  tests/avocado/avocado_qemu/__init__.py     |  2 +-
> > >  tests/avocado/machine_aspeed.py            |  5 ++++-
> > >  tests/qemu-iotests/iotests.py              |  2 +-
> > >  tests/qemu-iotests/tests/copy-before-write |  3 +--
> > >  7 files changed, 9 insertions(+), 31 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> 
> Thanks!
> 
> I don't know if we want this for *this* cycle or not, it's "only
> testing code" and it should hopefully be harmless. If it makes the
> tests more reliable, it might be worth it. I don't have strong
> feelings one way or the other, we've lived without it for so long
> as-is.
> 
> I'll see what Peter says.

Although it does affect end users, the biggest impact is our own
CI. Once the release is out it would help CI on stable trees,
but the big win is CI on master.

I'd verge towards skipping this during freeze and applying to
master after release. Then propose cherry-pick to stable once
it has had some soak time in our real CI.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


