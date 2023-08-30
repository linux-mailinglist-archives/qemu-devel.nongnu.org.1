Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452678D6A5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMVF-0003m6-G0; Wed, 30 Aug 2023 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbMVB-0003ex-Kq
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbMV6-00088M-QZ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693406935;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4Zq3i2WOIUSi8EXE5K6NvSD1T4v/O+3Jk8tOU138jEo=;
 b=UgusAGzF38Vw7R5PWhzlLZVN4o3mp3bAdsRWVv3NJeZh7U2xuAL5smuUEPh+qDEVAL2HGa
 C8iwDOAltJF7fKn39WtSab65m/S2rvCGYeZN0QZUV+YmunZGrWN1LFg5t2j+HZXaEV3Vi+
 PEB/8SDBnFdIsuIzXqogJ5s1zeK0tkU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-BsazKCwePfmjv-SZJ2q-XQ-1; Wed, 30 Aug 2023 10:48:48 -0400
X-MC-Unique: BsazKCwePfmjv-SZJ2q-XQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C304185A78B;
 Wed, 30 Aug 2023 14:48:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3FEC4021B9;
 Wed, 30 Aug 2023 14:48:46 +0000 (UTC)
Date: Wed, 30 Aug 2023 15:48:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 0/1] Quick fix patches
Message-ID: <ZO9WzHvhuGEnViue@redhat.com>
References: <20230830022205.57878-1-imp@bsdimp.com>
 <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
 <bcc8770e-95e6-e259-3c0b-e18a2c41474b@redhat.com>
 <CANCZdfqijpBfCJpv0QywMF3bd4Kow-3wyqs2ohT7w3tcYWOVZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfqijpBfCJpv0QywMF3bd4Kow-3wyqs2ohT7w3tcYWOVZQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Aug 30, 2023 at 08:31:15AM -0600, Warner Losh wrote:
> On Wed, Aug 30, 2023, 7:26 AM Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 30/08/2023 15.16, Stefan Hajnoczi wrote:
> > > Hi,
> > > The patch introduces the following build failure:
> > >
> > > cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p
> > > -Isubprojects/libvhost-user -I../subprojects/libvhost-user
> > > -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu99 -O2 -g
> > > -Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing
> > > -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> > > -fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ
> > > subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF
> > > subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o
> > > subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c
> > > ../subprojects/libvhost-user/libvhost-user.c
> > > In file included from ../subprojects/libvhost-user/include/atomic.h:18,
> > > from ../subprojects/libvhost-user/libvhost-user.c:53:
> > > ../subprojects/libvhost-user/include/compiler.h:38:40: error: missing
> > > binary operator before token "("
> > > 38 | #if defined(__clang__) &&
> > __has_warning("-Waddress-of-packed-member")
> > > | ^
> > >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/4981576093
> >
> > IIRC older versions of GCC do not have __has_warning() yet, so if you want
> > to use this in compiler.h, you have to do it below the line in compiler.h
> > that adds this:
> >
> > #ifndef __has_warning
> > #define __has_warning(x) 0 /* compatibility with non-clang compilers */
> > #endif
> >
> 
> This already works for linux-user. If there are gcc versions that break,
> our current CI jobs don't show it. Why add complexity for unsupported gcc
> versions? And how do I know I got it right?

IIUC, /no/ GCC version has __has_warning. The no-op stub we have works
because we merely need the preprocessor to be able to parse the
expression

  #if defined(__clang__) && __has_warning("....")

it'll never actually evaluate the __has_warning clause under GCC
because the defined(__clang__) will be false.

> I'm really starting to think the feedback 'move it to compilers.h' should
> have just been ignored... it's turning into a lot of my time to correct
> that I don't have when I'm also out of CI minutes to test with.

FWIW, if you have a Linux VM with docker/podman present it also possible
to run the CI environments locally with 'make docker-help' has more info

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


