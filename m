Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33F7691D4
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPGg-0000xn-GC; Mon, 31 Jul 2023 05:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQPGX-0000u2-Dd
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQPGV-00067P-Dy
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690795952;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=L+k4I/GnQAezZOS+VfkytSDAJGIk+4h82H/3CjfPjts=;
 b=gWgmKXuGJY+BgIiBTz3mrBbb/6QpX7tXP9pnGBn+IaOenGNoE0sKyNnpqGwkZFAPWFqSzy
 u2JxTNkDgQoBYHTSvsni0cOGS2DRZ2dHgY9dIUnOjWkNn1dV2NP2f8jnZWCZyzH/+nDONk
 hxVlolnfG1CO14ClebCwPxkFjYMJ/kI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-WcmlGyAQMpqEgNMDL0mvMQ-1; Mon, 31 Jul 2023 05:32:27 -0400
X-MC-Unique: WcmlGyAQMpqEgNMDL0mvMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65DD038149AF;
 Mon, 31 Jul 2023 09:32:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F116A200A7CA;
 Mon, 31 Jul 2023 09:32:25 +0000 (UTC)
Date: Mon, 31 Jul 2023 10:32:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Message-ID: <ZMd/pdT5DmPxtjYW@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 31, 2023 at 11:10:58AM +0200, Thomas Huth wrote:
> On 28/07/2023 17.13, Peter Maydell wrote:
> > On Fri, 28 Jul 2023 at 15:28, Thomas Huth <thuth@redhat.com> wrote:
> > > 
> > > Clang on Windows does not seem to know the "gcc_struct" attribute
> > > and emits a warning when we try to use it. Add an additional check
> > > here with __has_attribute() to avoid this problem.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   include/qemu/compiler.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> > > index a309f90c76..5065b4447c 100644
> > > --- a/include/qemu/compiler.h
> > > +++ b/include/qemu/compiler.h
> > > @@ -22,7 +22,7 @@
> > >   #define QEMU_EXTERN_C extern
> > >   #endif
> > > 
> > > -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> > > +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)) && !defined(__clang__)
> > >   # define QEMU_PACKED __attribute__((gcc_struct, packed))
> > >   #else
> > >   # define QEMU_PACKED __attribute__((packed))
> > 
> > I'm not sure about this. The idea of QEMU_PACKED is that
> > it's supposed to give you the same struct layout
> > regardless of compiler. With this change it no longer
> > does that, and there's no compile-time guard against
> > using something in a packed struct that has a different
> > layout on Windows clang vs everything else.
> > 
> > If it was OK to use plain attribute(packed) we wouldn't
> > need the ifdef at all because we could use it on GCC too.
> 
> I still haven't quite grasped whether this attribute just affects structures
> with bitfields in it, or whether it could also affect other structures
> without bitfields.
> 
> Looking at https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html and
> https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html#index-mms-bitfields , it
> sounds like it only affects structs with bitfields, unless you specify an
> "aligned(x)" attribute, too?
> 
> Anyway, using bitfields in structs for exchanging data with the guest is
> just way too error-prone, as you can see in the discussion about that
> VTD_IR_TableEntry in my other patch. We should maybe advise against
> bitfields in our coding style and point people to registerfields.h instead
> for new code? ... so that we use QEMU_PACKED mainly for legacy code. Would
> it then be OK for you, Peter, to go on with this approach?
> 
> Or do you see another possibility how we could fix that timeout problem in
> the 64-bit MSYS2 job? Still switching to clang, but compiling with
> --extra-cflags="-Wno-unknown-attributes" maybe?

I was surprised to see that we're not using ccache in gitlab CI. It wouldn't
help the from-clean compile time, but thereafter it ought to help. I'm doing
some tests with that to see the impact.

Another option might be to try precompiled headers, which meson supports
quite nicely / transparently. Might especially help on Windows where the
entire world is declared in windows.h


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


