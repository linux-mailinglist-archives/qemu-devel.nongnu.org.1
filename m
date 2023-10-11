Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6B7C599F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 18:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcTJ-0001tq-Ct; Wed, 11 Oct 2023 12:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqcTG-0001nC-5Z
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 12:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqcTD-0001F4-MD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 12:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697043242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WvoSV7GAzcTKi5rpFm9f4HREFpQ5FiKaxp9GUP0EMs=;
 b=ZPw+SuR4bJDN9Q3VKu7nsSXDBVPRt5j6Q//Qqz3swQ0mWBTEpIdV1Wk1pB87Cy3MEx+uRq
 mzmcMYw+UAx0CEQwRZhqWTHjS/sJzvncazRWBJVtMOwfVVESAUVE3x/qqD7U1OTEPAtVO3
 zUBrvIcVHl3Qej+CDVZoOVYnvgSQYZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-1dZfVtXqN8afHj6M8i-7-w-1; Wed, 11 Oct 2023 12:53:48 -0400
X-MC-Unique: 1dZfVtXqN8afHj6M8i-7-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 420743C23652;
 Wed, 11 Oct 2023 16:53:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E32C1C060AE;
 Wed, 11 Oct 2023 16:53:45 +0000 (UTC)
Date: Wed, 11 Oct 2023 17:53:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v9 23/23] plugins: Support C++
Message-ID: <ZSbTF5CXJreWywP/@redhat.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-24-akihiko.odaki@daynix.com>
 <ZSZiAHtXGOZnZNas@redhat.com>
 <2c970c00-519c-4175-b0ca-9081c4aa0daf@daynix.com>
 <ffdd55c2-4ae9-4b1f-ac12-a9ad714c3f26@redhat.com>
 <69ba49f0-843f-4a74-ad00-5ce1138ee074@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69ba49f0-843f-4a74-ad00-5ce1138ee074@daynix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 12, 2023 at 01:42:04AM +0900, Akihiko Odaki wrote:
> On 2023/10/12 1:21, Thomas Huth wrote:
> > On 11/10/2023 17.48, Akihiko Odaki wrote:
> > > On 2023/10/11 17:51, Daniel P. Berrangé wrote:
> > > > On Wed, Oct 11, 2023 at 04:03:09PM +0900, Akihiko Odaki wrote:
> > > > > Make qemu-plugin.h consumable for C++ platform.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > ---
> > > > >   docs/devel/tcg-plugins.rst |  4 ++++
> > > > >   meson.build                |  2 +-
> > > > >   include/qemu/qemu-plugin.h |  4 ++++
> > > > >   tests/plugin/cc.cc         | 16 ++++++++++++++++
> > > > >   tests/plugin/meson.build   |  5 +++++
> > > > >   tests/tcg/Makefile.target  |  3 +--
> > > > >   6 files changed, 31 insertions(+), 3 deletions(-)
> > > > >   create mode 100644 tests/plugin/cc.cc
> > > > > 
> > > > > diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> > > > > index c9f8b27590..984d8012e9 100644
> > > > > --- a/docs/devel/tcg-plugins.rst
> > > > > +++ b/docs/devel/tcg-plugins.rst
> > > > > @@ -283,6 +283,10 @@ run::
> > > > >     160          1      0
> > > > >     135          1      0
> > > > > +- contrib/plugins/cc.cc
> > > > > +
> > > > > +A pure test plugin to ensure that the plugin API is
> > > > > compatible with C++.
> > > > > +
> > > > 
> > > > IMHO we don't need to be adding a test just to prove the
> > > > existance of the G_BEGIN_DECLS/G_END_DECLS macros in the
> > > > plugin header.
> > > 
> > > Strictly speaking, if you include this header file from C++, the
> > > code will be interpreted as C++ instead of C but with C linkage.
> > > That worries me that the header file may get something not allowed
> > > in C++ in the future.
> > 
> > I think it should be enough if you add the G_BEGIN_DECLS/G_END_DECLS
> > macros here. QEMU is a C project, and it was quite difficult to get rid
[> > of the C++ code again, so please don't soften the check in meson.build
> > and don't introduce new .cc files.
> > If you have some code somewhere that uses C++ for plugins, I think it
> > would be better to add a regression test there instead.
> 
> It doesn't sound right to test the upstream header file in a downstream
> project. It will take time until the fix becomes readily usable for the
> downstream even if the downstream finds a bug.

Essentially QEMU is explicitly saying that C++ support is not a core
deliverable of the project. QEMU will accept patches to fix problems
but won't put any effort into C++ beyond that.

In such a scenario it is appropriate for a downstream to do testing
itself. The delay between finding a problem and sending a fix does
not need to be big - it could easily be less than a day if there is
a nightly CI job that tests against latest QEMU git master.

Distributing the testing burden is more scalable as QEMU also does
not have the resources to test every scenario it wants to. This kind
of situation already exists with the Xen project, which does CI against
QEMU on an ongoing basis to identify and report bugs that affect Xen
in scenarios which QEMU does not test. Libvirt also runs CI against
QEMU to detect regressions in QEMU which impact libvirt's usage of
QEMU, that QEMU's own CI won't catch.

All that not withstanding, while you are right that someone might
accidentally introduce something in the header that is not compatible
with C++, the actual chances of this are low. This plugin header file
is small, self contained, and is not undergoing a high volume of
change.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


