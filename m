Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047A74ED48
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 13:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJBt1-0001G9-7E; Tue, 11 Jul 2023 07:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJBsx-0001Ft-LZ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 07:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJBsu-00043u-Ub
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 07:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689076222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOqAy4E7KqVXoNX4Wo2qO/DObfyKiEOOQrC1sr3KvWI=;
 b=g1Dx7GbbDAImh3ljz/V+U+XYBh79cGP/mSqcFJs1VFMbqSUCBXMBoOFStGP0V/yQACtTX1
 t5cEuQwi2uK01WNpVcPgym34hIo7l8aUe6SxuYgVNP/T0BByTDEeaBUrh4pDcUPkAg/tIW
 bVZyrC2tddv2u6hoOMGpRutMnLUT/mY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-XSGM8qlOPFC65O8QQVx11w-1; Tue, 11 Jul 2023 07:50:20 -0400
X-MC-Unique: XSGM8qlOPFC65O8QQVx11w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A8B48037BA;
 Tue, 11 Jul 2023 11:50:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4693492CA6;
 Tue, 11 Jul 2023 11:50:18 +0000 (UTC)
Date: Tue, 11 Jul 2023 12:50:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] tests/migration: Restrict initrd-stress.img to Linux
Message-ID: <ZK1B+MnRUvEGb6Pl@redhat.com>
References: <20230710175607.32818-1-philmd@linaro.org>
 <ZKxJxkw/zUkgrlr8@redhat.com>
 <6564b580-48d7-2ea7-207b-00d583b802e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6564b580-48d7-2ea7-207b-00d583b802e9@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Mon, Jul 10, 2023 at 09:17:43PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/7/23 20:11, Daniel P. Berrangé wrote:
> > On Mon, Jul 10, 2023 at 07:56:07PM +0200, Philippe Mathieu-Daudé wrote:
> > > Trying to build initrd-stress.img on Darwin we get:
> > > 
> > >    $ ninja tests/migration/initrd-stress.img
> > >    Compiling C object tests/migration/stress.p/stress.c.o
> > >    FAILED: tests/migration/stress.p/stress.c.o
> > >    ../tests/migration/stress.c:24:10: fatal error: 'linux/random.h' file not found
> > >    #include <linux/random.h>
> > >             ^~~~~~~~~~~~~~~~
> > 
> > I think that's historical accident, as AFAICT, nothing in stress.c
> > needs that include to be present.
> 
> Removing I get:

True, the resulting file is still written to assume Linux userspace.

We can remove the linux/random.h header as it is redundant. Your
patch is still needed, just with a more general commit message
saying that many requird features are Linux only.

> 
> ../../tests/migration/stress.c:35:12: error: 'syscall' is deprecated: first
> deprecated in macOS 10.12 - syscall(2) is unsupported; please switch to a
> supported interface. For SYS_kdebug_trace use kdebug_signpost().
> [-Werror,-Wdeprecated-declarations]
>     return syscall(SYS_gettid);
>            ^
> /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/unistd.h:746:6:
> note: 'syscall' has been explicitly marked deprecated here
> int      syscall(int, ...);
>          ^
> ../../tests/migration/stress.c:43:16: error: use of undeclared identifier
> 'RB_POWER_OFF'
>         reboot(RB_POWER_OFF);
>                ^
> ../../tests/migration/stress.c:241:39: error: too many arguments to function
> call, expected 4, have 5
>     if (mount("none", dir, fstype, 0, NULL) < 0) {
>         ~~~~~                         ^~~~
> /Library/Developer/CommandLineTools/usr/lib/clang/14.0.3/include/stddef.h:89:16:
> note: expanded from macro 'NULL'
> #  define NULL ((void*)0)
>                ^~~~~~~~~~
> /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/mount.h:448:9:
> note: 'mount' declared here
> int     mount(const char *, const char *, int, void *);
>         ^
> 3 errors generated.
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


