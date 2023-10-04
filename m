Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3657B8749
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6Cp-00057v-A2; Wed, 04 Oct 2023 14:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qo6Co-00057g-1V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qo6Cm-0003El-A4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696442559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVj1aQpOljHPtbE4XSUFt6PjvqxaigPt63LnGyIgmI4=;
 b=fbej7EtHRT22FhnGhPApgIbmKEoBel6BIXZr9/ZeQNvXROpYkWjLejjNixpnNM1KKFrAfM
 tfkHVBPc/xLkLOeQh9hbtR6jAVvRcG4ox92TmvBXcwco1GhnLs473pi86n1DCv9pp0pWUD
 rBBY1vTt2i+TFcewl/uPjY0EHgGzqM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-sTVnnVyaP5exRr4_zpZJcg-1; Wed, 04 Oct 2023 14:02:36 -0400
X-MC-Unique: sTVnnVyaP5exRr4_zpZJcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AF5A805BAC;
 Wed,  4 Oct 2023 18:02:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76F72140E950;
 Wed,  4 Oct 2023 18:02:35 +0000 (UTC)
Date: Wed, 4 Oct 2023 19:02:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Wshadow: Better name for 'optarg'?
Message-ID: <ZR2ouS/Wy4YsSjwd@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
 <11abc551-188e-85c0-fe55-b2b58d35105d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11abc551-188e-85c0-fe55-b2b58d35105d@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Wed, Oct 04, 2023 at 07:56:35PM +0200, Thomas Huth wrote:
> On 04/10/2023 19.43, Philippe Mathieu-Daudé wrote:
> > On 4/10/23 19:35, Thomas Huth wrote:
> > > On 04/10/2023 19.23, Richard Henderson wrote:
> > > > On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
> > > > > Hi,
> > > > > 
> > > > > I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
> > > > 
> > > > I thought things like this is why we were trying -Wshadow=local.
> > > > 
> > > > I think it's unlikely that we'll be able to prevent all such cases.
> > > 
> > > Given the broad range of operating systems and libraries that we
> > > support in QEMU, I agree with Richard - it will likely be impossible
> > > to enable that option without =local by default without risking that
> > > compilation breaks on some exotic systems or new versions of various
> > > libraries.
> > 
> > -Wshadow=local doesn't seem to work here which is why I switched
> > to -Wshadow. I probably misunderstood something from Markus cover
> > letter. My setup is:
> > 
> > C compiler for the host machine: clang (clang 14.0.3 "Apple clang
> > version 14.0.3 (clang-1403.0.22.14.1)")
> > 
> > I suppose we'll figure that out when eventually enabling -Wshadow=local
> > on CI. Meanwhile I already cleaned the 'optarg' warnings that were
> > bugging me, see:
> > https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/
> > I'll try to get -Wshadow=local, but the other series still seems a
> > good cleanup, as I used more meaningful variable names.
> 
> If I got that right, -Wshadow=local only works with gcc and not with clang
> yet, so we'll need a check in configure or meson.build and will be able to
> only use it when it's available.
> 
> If we could use "-Wshadow" to check global variables, too, that would be
> great, but given my experience with some other project, it's very unlikely
> that you can get it running reliably everywhere, since there is often a bad
> library header somewhere that declares some global variable(s) that spoil
> your plans (IIRC I've once seen a bad library that even declared a global
> variable called "x" ... and you certainly don't want to rename all
> occurances of "x" in the QEMU source code just because of a bad library ...
> however, that's been many years ago, though, maybe the situation got better
> nowadays, so if you like, feel free to continue your quest - just be aware
> that it might not be solvable at the end).

FWIW, libvirt has successfully used -Wshadow for 10 years with no
real ongoing burden. There is of course a bit of an initial pain,
but if you have good CI coverage (as we do), we'll be able to validate
all the important platforms.

Windows is normally the worst platform for -Wshadow since some win32
headers defnie some incredibly generic names !

For the unimportant/niche platforms, people can send fixes as needed,
and shouldn't be using -Werror for production builds anyway.

IOW, if we can see a path to going all the way to -Wshadow that isn't
going to need 100's more patches, we might as well do it, or at least
accept patches to walk towards full -Wshadow.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


