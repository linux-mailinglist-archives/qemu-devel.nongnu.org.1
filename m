Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A67A1DD5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7V8-0008G7-6Z; Fri, 15 Sep 2023 08:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qh7Uy-0008Eq-8C
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qh7Ut-0006GN-84
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694779229;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t89cCaSgAmZtTUrikE8w9841NqS6ojPrpDsBQYgPXgQ=;
 b=eY2nlV+Y2jJoJF+31//QPBCJlArA0Eeob+d8H0UDVK5p8ue9p0QLTkmJOkmWQY4ec66sY/
 qQ8k0zVWCHeqjGUKRO3BJOYAqcJwRHTBm1wwdj5CEoZeHdYAEb9bW2JqYrjPtpvX/WsbrI
 USXWhGKsnsOe7hisKP9PjjktP9uWbqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-igbImswUO7uYakpbC2VfRw-1; Fri, 15 Sep 2023 08:00:26 -0400
X-MC-Unique: igbImswUO7uYakpbC2VfRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76A5D803470;
 Fri, 15 Sep 2023 12:00:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ED04176DE;
 Fri, 15 Sep 2023 12:00:22 +0000 (UTC)
Date: Fri, 15 Sep 2023 13:00:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/9] tests: update Debian images to Bookworm
Message-ID: <ZQRHVIkgme0EOm/I@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-2-alex.bennee@linaro.org>
 <30ac04ad-eb02-90ad-57ff-089538413602@linaro.org>
 <ZQQi6n+3mp+bQIgu@redhat.com>
 <242dc7bd-f0c4-d58c-fc6a-f3ddc0168bf2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <242dc7bd-f0c4-d58c-fc6a-f3ddc0168bf2@linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 15, 2023 at 12:53:30PM +0200, Philippe Mathieu-Daudé wrote:
> On 15/9/23 11:24, Daniel P. Berrangé wrote:
> > On Fri, Sep 15, 2023 at 11:14:29AM +0200, Philippe Mathieu-Daudé wrote:
> > > On 14/9/23 17:54, Alex Bennée wrote:
> > > > Bookworm has been out a while now. Time to update our containers to
> > > > the current stable. This requires the latest lcitool repo so update
> > > > the sub-module too.
> > > > 
> > > > For some reason the MIPs containers won't build so skip those for now.
> > > 
> > > Debian removed mipsel:
> > > https://lists.debian.org/debian-devel-announce/2023/09/msg00000.html
> > > https://lists.debian.org/debian-release/2019/08/msg00582.html ...
> > 
> > Wwith our general aim to support latest release, plus the previous
> > release (capped to a maximum of 2 years), we can still consider
> > mipsel supportable in QEMU CI by sticking with oldstable (Bullseye)
> > for the mipsel containers.
> > 
> > Once Debian 13 comes out, however, we'll be discarding Bullseye
> > from CI and so we'll be unable to do CI for mipsel. At the very
> > least this means we'll consider mipsel to be downgraded in terms
> > of supportability when that happens. We might then consider
> > explicitly dropping it as a buld target entirely, as the writing
> > is on the wall for 32-bit OS platforms in general...
> 
> I'm fine with dropping system emulation on 32-bit hosts, but a bit
> reluctant to drop user emulation there. Anyhow I agree with our
> distrib releases support rules, so the mipsel buildsys part is
> effectively condemned.

I wouldn't say condemned, because we are free to continue including
mipsel code in QEMU if we desire - we just will be unable to
guarantee that it works correctly - we'd be relying on developers
and users to report bugs and test it on whatever distro thye happen
to still have working.  Cutting it back to just user emulation is
a reasonable thing - testing user mode guest is not locked into
our support matrix, so we can easily test user mode binaries via
ancient distros if desired.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


