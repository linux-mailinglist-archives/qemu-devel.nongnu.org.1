Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D62907CA38E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJa8-00006R-Ha; Mon, 16 Oct 2023 05:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qsJa1-000063-IY
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qsJZl-0004UT-KT
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697447267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydqTtSZu5c/xAA3/L7fi61TWuTemiFZYYlVaH0b75HQ=;
 b=T06q859bADArdZ8lj0WaHF/+3ySrl4ORQO4iftn34PUy0x5A3JDQZniqHkwjleDtDe1vdP
 E79b/xUyhlgDe0OzJm9mnsCLq611DrHioQbS2ZU9xoGUvnJaKtAUrLEeo28opW2yiwiZc2
 Mpr+TNz5evaKgx+57f07n1G+IpSO/ac=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-la6nWfeROgieVrR-w6zWVg-1; Mon, 16 Oct 2023 05:07:45 -0400
X-MC-Unique: la6nWfeROgieVrR-w6zWVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21490185A7B6
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:07:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F0A8492BFA;
 Mon, 16 Oct 2023 09:07:44 +0000 (UTC)
Date: Mon, 16 Oct 2023 10:07:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/vm: netbsd: install dtc
Message-ID: <ZSz9XrOLZPQ2Rm+v@redhat.com>
References: <20231013153027.800327-1-pbonzini@redhat.com>
 <cee1cc9f-ed36-4300-a712-d3fbef4bb395@redhat.com>
 <ZSz9AFwxPBsoRMih@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSz9AFwxPBsoRMih@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Oct 16, 2023 at 10:06:11AM +0100, Daniel P. Berrangé wrote:
> On Mon, Oct 16, 2023 at 11:00:14AM +0200, Thomas Huth wrote:
> > On 13/10/2023 17.30, Paolo Bonzini wrote:
> > > Install dtc as it is now a mandatory external dependency in order to build QEMU.
> > > 
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >   tests/vm/netbsd | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> > > index 939dc1b22a1..3ef1ec2d9cc 100755
> > > --- a/tests/vm/netbsd
> > > +++ b/tests/vm/netbsd
> > > @@ -40,6 +40,9 @@ class NetBSDVM(basevm.BaseVM):
> > >           "gsed",
> > >           "gettext-tools",
> > > +        # libs: basic
> > > +        "dtc",
> > > +
> > >           # libs: crypto
> > >           "gnutls",
> > 
> > Does this work for you? When I run "make vm-build-netbsd", I'm still getting
> > a failure:

snip

> > Library fdt found: NO
> > Initialized empty Git repository in
> > /home/qemu/qemu-test.Li0spd/src/subprojects/dtc/.git/
> > fatal: unable to access 'https://gitlab.com/qemu-project/dtc.git/': SSL
> > certificate problem: unable to get local issuer certificate
> > 
> > ../src/meson.build:3076:4: ERROR: Git command failed: ['/usr/pkg/bin/git',
> > 'fetch', '--depth', '1', 'origin',
> > 'b6910bec11614980a21e46fbccc35934b671bd81']
> > 
> > A full log can be found at
> > /home/qemu/qemu-test.Li0spd/build/meson-logs/meson-log.txt
> > 
> > ERROR: meson setup failed
> > 
> > ... so though the NetBSD people finally upgraded their dtc to a usable
> > level, our meson.build seems to be unable to detect it?
> 
> They claim to have version 1.7.0
> 
>   https://ftp.netbsd.org/pub/pkgsrc/current/pkgsrc/sysutils/dtc/index.html
> 
> and we claim to want 1.5.0, so should be OK.
> 
> Suggests that our detection, or test compilation is failing. The
> meson-log.txt might have more info, if you can access that ?
> 
> 
> Also separately it appears we're missing the public CA cert bundle,
> so we should not see a cert error from gitlab.

The latter is presumably solvable with this:

  https://ftp.netbsd.org/pub/pkgsrc/current/pkgsrc/security/ca-certificates/index.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


